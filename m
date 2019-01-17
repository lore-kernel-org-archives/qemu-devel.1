Received: from eggs.gnu.org ([209.51.188.92]:33356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDTT-0004D6-9C
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDTS-0008Ah-9T
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:37:11 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 17 Jan 2019 13:36:38 -0600
Message-Id: <20190117193658.16413-2-eblake@redhat.com>
In-Reply-To: <20190117193658.16413-1-eblake@redhat.com>
References: <20190117193658.16413-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 01/21] iotests: Make 233 output more reliable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, rjones@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

We have a race between the nbd server and the client both trying
to report errors at once which can make the test sometimes fail
if the output lines swap order under load.  Break the race by
collecting server messages into a file and then replaying that
at the end of the test.

Signed-off-by: Eric Blake <eblake@redhat.com>
CC: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

---
An alternative solution might be to silence the message from the
server by default, and output it only when -v was passed
---
 tests/qemu-iotests/233     | 11 ++++++++---
 tests/qemu-iotests/233.out |  4 +++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index 1814efe3333..ab15c777370 100755
--- a/tests/qemu-iotests/233
+++ b/tests/qemu-iotests/233
@@ -2,7 +2,7 @@
 #
 # Test NBD TLS certificate / authorization integration
 #
-# Copyright (C) 2018 Red Hat, Inc.
+# Copyright (C) 2018-2019 Red Hat, Inc.
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -30,6 +30,7 @@ _cleanup()
 {
     nbd_server_stop
     _cleanup_test_img
+    rm -f "$TEST_DIR/server.log"
     tls_x509_cleanup
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -66,7 +67,7 @@ $QEMU_IO -c 'w -P 0x11 1m 1m' "$TEST_IMG" | _filter_qem=
u_io

 echo
 echo "=3D=3D check TLS client to plain server fails =3D=3D"
-nbd_server_start_tcp_socket -f $IMGFMT "$TEST_IMG"
+nbd_server_start_tcp_socket -f $IMGFMT "$TEST_IMG" 2> "$TEST_DIR/server.=
log"

 $QEMU_IMG info --image-opts \
     --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,i=
d=3Dtls0 \
@@ -81,7 +82,7 @@ echo "=3D=3D check plain client to TLS server fails =3D=
=3D"
 nbd_server_start_tcp_socket \
     --object tls-creds-x509,dir=3D${tls_dir}/server1,endpoint=3Dserver,i=
d=3Dtls0,verify-peer=3Dyes \
     --tls-creds tls0 \
-    -f $IMGFMT "$TEST_IMG"
+    -f $IMGFMT "$TEST_IMG" 2>> "$TEST_DIR/server.log"

 $QEMU_IMG info nbd://localhost:$nbd_tcp_port 2>&1 | sed "s/$nbd_tcp_port=
/PORT/g"

@@ -109,6 +110,10 @@ $QEMU_IO -c 'r -P 0x11 1m 1m' -c 'w -P 0x22 1m 1m' -=
-image-opts \

 $QEMU_IO -f $IMGFMT -r -U -c 'r -P 0x22 1m 1m' "$TEST_IMG" | _filter_qem=
u_io

+echo
+echo "=3D=3D final server log =3D=3D"
+cat "$TEST_DIR/server.log"
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 5f416721b03..2199d8a8b32 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -27,7 +27,6 @@ virtual size: 64M (67108864 bytes)
 disk size: unavailable

 =3D=3D check TLS with different CA fails =3D=3D
-qemu-nbd: option negotiation failed: Verify failed: No certificate was f=
ound.
 qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-=
creds=3Dtls0': The certificate hasn't got a known issuer

 =3D=3D perform I/O over TLS =3D=3D
@@ -37,4 +36,7 @@ wrote 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D final server log =3D=3D
+qemu-nbd: option negotiation failed: Verify failed: No certificate was f=
ound.
 *** done
--=20
2.20.1
