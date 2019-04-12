Received: from eggs.gnu.org ([209.51.188.92]:44061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEyg3-0004f4-6k
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEyg1-0002IR-NH
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:05:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 12 Apr 2019 18:04:58 +0200
Message-Id: <20190412160458.23920-3-kwolf@redhat.com>
In-Reply-To: <20190412160458.23920-1-kwolf@redhat.com>
References: <20190412160458.23920-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] iotest: Fix 241 to run in generic directory
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

From: Eric Blake <eblake@redhat.com>

Filter the qemu-nbd server output to get rid of a direct reference
to my build directory.

Fixes: e9dce9cb
Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/241     | 4 +++-
 tests/qemu-iotests/241.out | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/241 b/tests/qemu-iotests/241
index 4b19685738..017a736aab 100755
--- a/tests/qemu-iotests/241
+++ b/tests/qemu-iotests/241
@@ -28,6 +28,7 @@ nbd_unix_socket=3D$TEST_DIR/test_qemu_nbd_socket
 _cleanup()
 {
     _cleanup_test_img
+    rm -f "$TEST_DIR/server.log"
     nbd_server_stop
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -69,12 +70,13 @@ echo
=20
 # Intentionally omit '-f' to force image probing, which in turn forces
 # sector alignment, here at the server.
-nbd_server_start_unix_socket "$TEST_IMG_FILE"
+nbd_server_start_unix_socket "$TEST_IMG_FILE" 2> "$TEST_DIR/server.log"
=20
 $QEMU_NBD_PROG --list -k $nbd_unix_socket | grep '\(size\|min\)'
 $QEMU_IMG map -f raw --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
 $QEMU_IO -f raw -c map "$TEST_IMG"
 nbd_server_stop
+cat "$TEST_DIR/server.log" | _filter_testdir
=20
 echo
 echo "=3D=3D=3D Exporting unaligned raw image, forced client sector alig=
nment =3D=3D=3D"
diff --git a/tests/qemu-iotests/241.out b/tests/qemu-iotests/241.out
index f481074a02..75f9f465e5 100644
--- a/tests/qemu-iotests/241.out
+++ b/tests/qemu-iotests/241.out
@@ -10,13 +10,13 @@ QA output created by 241
=20
 =3D=3D=3D Exporting unaligned raw image, forced server sector alignment =
=3D=3D=3D
=20
-WARNING: Image format was not specified for '/home/eblake/qemu/tests/qem=
u-iotests/scratch/t.raw' and probing guessed raw.
-         Automatically detecting the format is dangerous for raw images,=
 write operations on block 0 will be restricted.
-         Specify the 'raw' format explicitly to remove the restrictions.
   size:  1024
   min block: 512
 [{ "start": 0, "length": 1024, "depth": 0, "zero": false, "data": true, =
"offset": OFFSET}]
 1 KiB (0x400) bytes     allocated at offset 0 bytes (0x0)
+WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing=
 guessed raw.
+         Automatically detecting the format is dangerous for raw images,=
 write operations on block 0 will be restricted.
+         Specify the 'raw' format explicitly to remove the restrictions.
=20
 =3D=3D=3D Exporting unaligned raw image, forced client sector alignment =
=3D=3D=3D
=20
--=20
2.20.1
