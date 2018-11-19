Received: from eggs.gnu.org ([2001:4830:134:3::10]:51537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnlA-0000Qm-4y
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnl9-0002mV-2z
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:54:56 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 19 Nov 2018 11:54:26 -0600
Message-Id: <20181119175427.2298497-12-eblake@redhat.com>
In-Reply-To: <20181119175427.2298497-1-eblake@redhat.com>
References: <20181119175427.2298497-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/12] iotests: Also test I/O over NBD TLS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Enhance test 233 to also perform I/O beyond the initial handshake.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20181118022403.2211483-1-eblake@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/qemu-iotests/233     | 12 +++++++++++-
 tests/qemu-iotests/233.out | 10 ++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index 46013cefdcd..a4da60d0ade 100755
--- a/tests/qemu-iotests/233
+++ b/tests/qemu-iotests/233
@@ -62,7 +62,7 @@ tls_x509_create_client "ca2" "client2"
 echo
 echo "=3D=3D preparing image =3D=3D"
 _make_test_img 64M
-
+$QEMU_IO -c 'w -P 0x11 1m 1m' "$TEST_IMG" | _filter_qemu_io

 echo
 echo "=3D=3D check TLS client to plain server fails =3D=3D"
@@ -96,6 +96,16 @@ $QEMU_IMG info --image-opts \
     driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0 \
     2>&1 | sed "s/$nbd_tcp_port/PORT/g"

+echo
+echo "=3D=3D perform I/O over TLS =3D=3D"
+QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
+$QEMU_IO -c 'r -P 0x11 1m 1m' -c 'w -P 0x22 1m 1m' --image-opts \
+    --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,i=
d=3Dtls0 \
+    driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0 \
+    2>&1 | _filter_qemu_io
+
+$QEMU_IO -f qcow2 -r -U -c 'r -P 0x22 1m 1m' "$TEST_IMG" | _filter_qemu_=
io
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 616e9238c89..94acd9b9479 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -9,6 +9,8 @@ Generating a signed certificate...

 =3D=3D preparing image =3D=3D
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

 =3D=3D check TLS client to plain server fails =3D=3D
 qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-=
creds=3Dtls0': Denied by server for option 5 (starttls)
@@ -27,4 +29,12 @@ disk size: unavailable
 =3D=3D check TLS with different CA fails =3D=3D
 option negotiation failed: Verify failed: No certificate was found.
 qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-=
creds=3Dtls0': The certificate hasn't got a known issuer
+
+=3D=3D perform I/O over TLS =3D=3D
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
--=20
2.17.2
