Received: from eggs.gnu.org ([209.51.188.92]:41738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDc-0000KV-Bj
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDb-0005BT-6e
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:40 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  2 Apr 2019 22:05:23 -0500
Message-Id: <20190403030526.12258-5-eblake@redhat.com>
In-Reply-To: <20190403030526.12258-1-eblake@redhat.com>
References: <20190403030526.12258-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/7] iotests: Update 241 to expose backing
 layer fragmentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Previous commits have mentioned that our NBD server still sends
unaligned fragments when an active layer with large advertised minimum
block size is backed by another layer with a smaller block
size. Expand the test to actually cover this scenario, by using qcow2
encryption (which forces 512-byte alignment) with an unaligned raw
backing file.

The test passes, but only because the client side works around the
server's non-compliance; if you repeat the test manually with tracing
turned on, you will see the server sending a status for 1000 bytes
data then 1048 bytes hole, which is not aligned. But reverting commit
737d3f5244 shows that it is indeed the client working around the bug
in the server.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/241     | 20 +++++++++++++++++++-
 tests/qemu-iotests/241.out |  9 +++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/241 b/tests/qemu-iotests/241
index 4b196857387..c1fa6980dc8 100755
--- a/tests/qemu-iotests/241
+++ b/tests/qemu-iotests/241
@@ -28,6 +28,7 @@ nbd_unix_socket=3D$TEST_DIR/test_qemu_nbd_socket
 _cleanup()
 {
     _cleanup_test_img
+    rm -f "$TEST_IMAGE_FILE.qcow2"
     nbd_server_stop
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -37,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 . ./common.nbd

-_supported_fmt raw
+_supported_fmt raw # although the test also requires use of qcow2
 _supported_proto nbd
 _supported_os Linux
 _require_command QEMU_NBD
@@ -88,6 +89,23 @@ $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qe=
mu_img_map
 $QEMU_IO -c map "$TEST_IMG"
 nbd_server_stop

+echo
+echo "=3D=3D=3D Encrypted qcow2 file backed by unaligned raw image  =3D=3D=
=3D"
+echo
+
+# Enabling encryption in qcow2 forces 512-alignment
+SECRET=3Dsecret,id=3Dsec0,data=3D12345
+$QEMU_IMG create -f qcow2 -b "$TEST_IMG_FILE" -F raw --object "$SECRET" =
\
+  -o encrypt.format=3Dluks,encrypt.key-secret=3Dsec0,encrypt.iter-time=3D=
10 \
+  "$TEST_IMG_FILE.qcow2" 2k | _filter_img_create
+nbd_server_start_unix_socket --object "$SECRET" --image-opts \
+  driver=3Dqcow2,file.filename=3D"$TEST_IMG_FILE.qcow2",encrypt.key-secr=
et=3Dsec0
+
+$QEMU_NBD_PROG --list -k $nbd_unix_socket | grep '\(size\|min\)'
+$QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
+$QEMU_IO -c map "$TEST_IMG"
+nbd_server_stop
+
 # Not tested yet: we also want to ensure that qemu as NBD client does
 # not access beyond the end of a server's advertised unaligned size:
 #  nbdkit -U - memory size=3D513 --run 'qemu-io -f raw -c "r 512 512" $n=
bd'
diff --git a/tests/qemu-iotests/241.out b/tests/qemu-iotests/241.out
index f481074a02e..ef7de1205d2 100644
--- a/tests/qemu-iotests/241.out
+++ b/tests/qemu-iotests/241.out
@@ -25,4 +25,13 @@ WARNING: Image format was not specified for '/home/ebl=
ake/qemu/tests/qemu-iotest
 [{ "start": 0, "length": 1000, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
 { "start": 1000, "length": 24, "depth": 0, "zero": true, "data": true, "=
offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
+
+=3D=3D=3D Encrypted qcow2 file backed by unaligned raw image  =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT.qcow2', fmt=3Dqcow2 size=3D2048 backing_fi=
le=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT encrypt.format=3Dluks encrypt=
.key-secret=3Dsec0 encrypt.iter-time=3D10
+  size:  2048
+  min block: 512
+[{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET},
+{ "start": 1024, "length": 1024, "depth": 0, "zero": true, "data": false=
, "offset": OFFSET}]
+2 KiB (0x800) bytes     allocated at offset 0 bytes (0x0)
 *** done
--=20
2.20.1
