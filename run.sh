#!/bin/sh

conda run -n zap2epg python3 /home/tom/Scripts/zap2epg/zap2epg.py
XML=/home/tom/Scripts/zap2epg/xmltv.xml
XMLZ=/home/tom/Scripts/zap2epg/xmltv.xml.gz
#$(mktemp -u)
SOCKET="/home/tom/media-server/configs/tvheadend/epggrab/xmltv.sock"

if [ ! -f "$XML" ]; then
    echo "Error: $XML file does not exist. Exiting."
    exit 1
fi

gzip $XML

if gzip -t $XMLZ; then
        zcat "$XMLZ" | socat -u - UNIX-CONNECT:"$SOCKET"
fi

rm $XMLZ
