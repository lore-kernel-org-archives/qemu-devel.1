Received: from eggs.gnu.org ([209.51.188.92]:43645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkQzc-0005t0-Fh
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkQza-0000I8-CM
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:03:16 -0500
Date: Fri, 18 Jan 2019 10:02:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190118100257.GC20660@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190117193658.16413-1-eblake@redhat.com>
	<20190117193658.16413-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190117193658.16413-2-eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/21] iotests: Make 233 output more
 reliable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, nsoffer@redhat.com, rjones@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, Jan 17, 2019 at 01:36:38PM -0600, Eric Blake wrote:
> We have a race between the nbd server and the client both trying
> to report errors at once which can make the test sometimes fail
> if the output lines swap order under load.  Break the race by
> collecting server messages into a file and then replaying that
> at the end of the test.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> CC: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> ---
> An alternative solution might be to silence the message from the
> server by default, and output it only when -v was passed

I wouldn't consider this an either/or situation. It is probably
good practice to qemu-nbd to be completely silent wrt client
problems so a malicious client can't spam the qemu-nbd log (if
any). None the less it is also useful to have the iotests validate
that this log message is printed.

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


> ---
>  tests/qemu-iotests/233     | 11 ++++++++---
>  tests/qemu-iotests/233.out |  4 +++-
>  2 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
> index 1814efe3333..ab15c777370 100755
> --- a/tests/qemu-iotests/233
> +++ b/tests/qemu-iotests/233
> @@ -2,7 +2,7 @@
>  #
>  # Test NBD TLS certificate / authorization integration
>  #
> -# Copyright (C) 2018 Red Hat, Inc.
> +# Copyright (C) 2018-2019 Red Hat, Inc.
>  #
>  # This program is free software; you can redistribute it and/or modify
>  # it under the terms of the GNU General Public License as published by
> @@ -30,6 +30,7 @@ _cleanup()
>  {
>      nbd_server_stop
>      _cleanup_test_img
> +    rm -f "$TEST_DIR/server.log"
>      tls_x509_cleanup
>  }
>  trap "_cleanup; exit \$status" 0 1 2 3 15
> @@ -66,7 +67,7 @@ $QEMU_IO -c 'w -P 0x11 1m 1m' "$TEST_IMG" | _filter_q=
emu_io
>=20
>  echo
>  echo "=3D=3D check TLS client to plain server fails =3D=3D"
> -nbd_server_start_tcp_socket -f $IMGFMT "$TEST_IMG"
> +nbd_server_start_tcp_socket -f $IMGFMT "$TEST_IMG" 2> "$TEST_DIR/serve=
r.log"
>=20
>  $QEMU_IMG info --image-opts \
>      --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient=
,id=3Dtls0 \
> @@ -81,7 +82,7 @@ echo "=3D=3D check plain client to TLS server fails =3D=
=3D"
>  nbd_server_start_tcp_socket \
>      --object tls-creds-x509,dir=3D${tls_dir}/server1,endpoint=3Dserver=
,id=3Dtls0,verify-peer=3Dyes \
>      --tls-creds tls0 \
> -    -f $IMGFMT "$TEST_IMG"
> +    -f $IMGFMT "$TEST_IMG" 2>> "$TEST_DIR/server.log"
>=20
>  $QEMU_IMG info nbd://localhost:$nbd_tcp_port 2>&1 | sed "s/$nbd_tcp_po=
rt/PORT/g"
>=20
> @@ -109,6 +110,10 @@ $QEMU_IO -c 'r -P 0x11 1m 1m' -c 'w -P 0x22 1m 1m'=
 --image-opts \
>=20
>  $QEMU_IO -f $IMGFMT -r -U -c 'r -P 0x22 1m 1m' "$TEST_IMG" | _filter_q=
emu_io
>=20
> +echo
> +echo "=3D=3D final server log =3D=3D"
> +cat "$TEST_DIR/server.log"
> +
>  # success, all done
>  echo "*** done"
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
> index 5f416721b03..2199d8a8b32 100644
> --- a/tests/qemu-iotests/233.out
> +++ b/tests/qemu-iotests/233.out
> @@ -27,7 +27,6 @@ virtual size: 64M (67108864 bytes)
>  disk size: unavailable
>=20
>  =3D=3D check TLS with different CA fails =3D=3D
> -qemu-nbd: option negotiation failed: Verify failed: No certificate was=
 found.
>  qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tl=
s-creds=3Dtls0': The certificate hasn't got a known issuer
>=20
>  =3D=3D perform I/O over TLS =3D=3D
> @@ -37,4 +36,7 @@ wrote 1048576/1048576 bytes at offset 1048576
>  1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  read 1048576/1048576 bytes at offset 1048576
>  1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +=3D=3D final server log =3D=3D
> +qemu-nbd: option negotiation failed: Verify failed: No certificate was=
 found.
>  *** done
> --=20
> 2.20.1
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
