Received: from eggs.gnu.org ([2001:4830:134:3::10]:37217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFV-0001nq-KV
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFU-0000wc-6s
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:41 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 22 Nov 2018 17:54:12 +0100
Message-Id: <20181122165417.23894-9-kwolf@redhat.com>
In-Reply-To: <20181122165417.23894-1-kwolf@redhat.com>
References: <20181122165417.23894-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/13] iotests: fix nbd test 233 to work
 correctly with raw images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The first qemu-io command must honour the $IMGFMT that is set rather
than hardcoding qcow2. The qemu-nbd commands should also set $IMGFMT
to avoid the insecure format probe warning.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
