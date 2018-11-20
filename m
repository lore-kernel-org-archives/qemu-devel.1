Received: from eggs.gnu.org ([2001:4830:134:3::10]:51703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gPAGc-0006n2-Hi
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:56:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gPAGY-0001SP-Pt
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:56:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gPAGY-0001Qk-Fx
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:56:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79AAD30821E4
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 17:56:49 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 20 Nov 2018 17:56:46 +0000
Message-Id: <20181120175646.25763-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests: fix nbd test to work correctly with raw
 images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The first qemu-io command must honour the $IMGFMT that is set rather
than hardcoding qcow2. The qemu-nbd commands should also set $IMGFMT
to avoid the insecure format probe warning.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/qemu-iotests/233 | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index a4da60d0ad..1814efe333 100755
--- a/tests/qemu-iotests/233
+++ b/tests/qemu-iotests/233
@@ -66,7 +66,7 @@ $QEMU_IO -c 'w -P 0x11 1m 1m' "$TEST_IMG" | _filter_qem=
u_io
=20
 echo
 echo "=3D=3D check TLS client to plain server fails =3D=3D"
-nbd_server_start_tcp_socket "$TEST_IMG"
+nbd_server_start_tcp_socket -f $IMGFMT "$TEST_IMG"
=20
 $QEMU_IMG info --image-opts \
     --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,i=
d=3Dtls0 \
@@ -78,7 +78,10 @@ nbd_server_stop
 echo
 echo "=3D=3D check plain client to TLS server fails =3D=3D"
=20
-nbd_server_start_tcp_socket --object tls-creds-x509,dir=3D${tls_dir}/ser=
ver1,endpoint=3Dserver,id=3Dtls0,verify-peer=3Dyes --tls-creds tls0 "$TES=
T_IMG"
+nbd_server_start_tcp_socket \
+    --object tls-creds-x509,dir=3D${tls_dir}/server1,endpoint=3Dserver,i=
d=3Dtls0,verify-peer=3Dyes \
+    --tls-creds tls0 \
+    -f $IMGFMT "$TEST_IMG"
=20
 $QEMU_IMG info nbd://localhost:$nbd_tcp_port 2>&1 | sed "s/$nbd_tcp_port=
/PORT/g"
=20
@@ -104,7 +107,7 @@ $QEMU_IO -c 'r -P 0x11 1m 1m' -c 'w -P 0x22 1m 1m' --=
image-opts \
     driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0 \
     2>&1 | _filter_qemu_io
=20
-$QEMU_IO -f qcow2 -r -U -c 'r -P 0x22 1m 1m' "$TEST_IMG" | _filter_qemu_=
io
+$QEMU_IO -f $IMGFMT -r -U -c 'r -P 0x22 1m 1m' "$TEST_IMG" | _filter_qem=
u_io
=20
 # success, all done
 echo "*** done"
--=20
2.19.1
