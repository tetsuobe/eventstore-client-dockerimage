FROM tetsuobe/php7

ADD . /var/www

ADD docker/php.ini /usr/local/etc/php/php.ini

# EventStore installation
ENV ES_VERSION 3.5.0

ADD http://download.geteventstore.com/binaries/EventStore-OSS-Ubuntu-14.04-v$ES_VERSION.tar.gz /tmp/
RUN tar xfz /tmp/EventStore-OSS-Ubuntu-14.04-v$ES_VERSION.tar.gz -C /opt

EXPOSE 2113
EXPOSE 1113

VOLUME /data/db
VOLUME /data/logs

ENV EVENTSTORE_MAX_MEM_TABLE_SIZE 100000
ENV EVENTSTORE_WORKER_THREADS 12
ENV EVENTSTORE_MEM_DB True

WORKDIR /opt/EventStore-OSS-Ubuntu-14.04-v$ES_VERSION

CMD ./run-node.sh --ext-http-prefixes=http://*:2113/ --ext-ip=0.0.0.0 \
    --mem-db --log /data/logs --run-projections=all
