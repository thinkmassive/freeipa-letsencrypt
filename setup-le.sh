#!/usr/bin/bash
set -o nounset -o errexit

WORKDIR=$(dirname "$(realpath $0)")

dnf install letsencrypt -y

ipa-cacert-manage install "$WORKDIR/ca/isrgrootx1.pem" -n ISRGRootX1 -t C,,
ipa-certupdate -v

ipa-cacert-manage install "$WORKDIR/ca/lets-encrypt-r3.pem" -n letsencryptr3 -t C,,
ipa-certupdate -v

"$WORKDIR/renew-le.sh" --first-time
