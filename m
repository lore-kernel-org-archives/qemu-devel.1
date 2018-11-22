Received: from eggs.gnu.org ([2001:4830:134:3::10]:37523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFf-0001z3-6L
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFd-0001D2-D8
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:51 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 22 Nov 2018 17:54:17 +0100
Message-Id: <20181122165417.23894-14-kwolf@redhat.com>
In-Reply-To: <20181122165417.23894-1-kwolf@redhat.com>
References: <20181122165417.23894-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/13] iotests: Enhance 223 to cover multiple
 bitmap granularities
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

Testing granularity at the same size as the cluster isn't quite
as fun as what happens when it is larger or smaller.  This
enhancement also shows that qemu's nbd server can serve the
same disk over multiple exports simultaneously.

Signed-off-by: Eric Blake <eblake@redhat.com>
Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/223     | 43 +++++++++++++++++++++++++++++++-------
 tests/qemu-iotests/223.out | 32 +++++++++++++++++++++-------
 2 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 72419e0338..397b865d34 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -57,10 +57,11 @@ run_qemu()
 }
=20
 echo
-echo "=3D=3D=3D Create partially sparse image, then add dirty bitmap =3D=
=3D=3D"
+echo "=3D=3D=3D Create partially sparse image, then add dirty bitmaps =3D=
=3D=3D"
 echo
=20
-_make_test_img 4M
+# Two bitmaps, to contrast granularity issues
+_make_test_img -o cluster_size=3D4k 4M
 $QEMU_IO -c 'w -P 0x11 1M 2M' "$TEST_IMG" | _filter_qemu_io
 run_qemu <<EOF
 { "execute": "qmp_capabilities" }
@@ -78,7 +79,16 @@ run_qemu <<EOF
   "arguments": {
     "node": "n",
     "name": "b",
-    "persistent": true
+    "persistent": true,
+    "granularity": 65536
+  }
+}
+{ "execute": "block-dirty-bitmap-add",
+  "arguments": {
+    "node": "n",
+    "name": "b2",
+    "persistent": true,
+    "granularity": 512
   }
 }
 { "execute": "quit" }
@@ -88,10 +98,11 @@ echo
 echo "=3D=3D=3D Write part of the file under active bitmap =3D=3D=3D"
 echo
=20
-$QEMU_IO -c 'w -P 0x22 2M 2M' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c 'w -P 0x22 512 512' -c 'w -P 0x33 2M 2M' "$TEST_IMG" \
+    | _filter_qemu_io
=20
 echo
-echo "=3D=3D=3D End dirty bitmap, and start serving image over NBD =3D=3D=
=3D"
+echo "=3D=3D=3D End dirty bitmaps, and start serving image over NBD =3D=3D=
=3D"
 echo
=20
 _launch_qemu 2> >(_filter_nbd)
@@ -103,6 +114,8 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"blockdev-add=
",
     "file":{"driver":"file", "filename":"'"$TEST_IMG"'"}}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"x-block-dirty-bitmap-disable",
   "arguments":{"node":"n", "name":"b"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-block-dirty-bitmap-disable",
+  "arguments":{"node":"n", "name":"b2"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
   "arguments":{"addr":{"type":"unix",
     "data":{"path":"'"$TEST_DIR/nbd"'"}}}}' "return"
@@ -110,26 +123,40 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server=
-add",
   "arguments":{"device":"n"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
   "arguments":{"name":"n", "bitmap":"b"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+  "arguments":{"device":"n", "name":"n2"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
+  "arguments":{"name":"n2", "bitmap":"b2"}}' "return"
=20
 echo
-echo "=3D=3D=3D Contrast normal status with dirty-bitmap status =3D=3D=3D=
"
+echo "=3D=3D=3D Contrast normal status to large granularity dirty-bitmap=
 =3D=3D=3D"
 echo
=20
 QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
 IMG=3D"driver=3Dnbd,export=3Dn,server.type=3Dunix,server.path=3D$TEST_DI=
R/nbd"
-$QEMU_IO -r -c 'r -P 0 0 1m' -c 'r -P 0x11 1m 1m' \
-  -c 'r -P 0x22 2m 2m' --image-opts "$IMG" | _filter_qemu_io
+$QEMU_IO -r -c 'r -P 0x22 512 512' -c 'r -P 0 512k 512k' -c 'r -P 0x11 1=
m 1m' \
+  -c 'r -P 0x33 2m 2m' --image-opts "$IMG" | _filter_qemu_io
 $QEMU_IMG map --output=3Djson --image-opts \
   "$IMG" | _filter_qemu_img_map
 $QEMU_IMG map --output=3Djson --image-opts \
   "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b" | _filter_qemu_img_map
=20
+echo
+echo "=3D=3D=3D Contrast to small granularity dirty-bitmap =3D=3D=3D"
+echo
+
+IMG=3D"driver=3Dnbd,export=3Dn2,server.type=3Dunix,server.path=3D$TEST_D=
IR/nbd"
+$QEMU_IMG map --output=3Djson --image-opts \
+  "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b2" | _filter_qemu_img_map
+
 echo
 echo "=3D=3D=3D End NBD server =3D=3D=3D"
 echo
=20
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
   "arguments":{"name":"n"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
+  "arguments":{"name":"n2"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"quit"}' "return"
=20
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 33021c8e6a..de417477de 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -1,6 +1,6 @@
 QA output created by 223
=20
-=3D=3D=3D Create partially sparse image, then add dirty bitmap =3D=3D=3D
+=3D=3D=3D Create partially sparse image, then add dirty bitmaps =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D4194304
 wrote 2097152/2097152 bytes at offset 1048576
@@ -11,15 +11,18 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
+{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "SHUTDOWN", "data": {"guest": false}}
=20
=20
 =3D=3D=3D Write part of the file under active bitmap =3D=3D=3D
=20
+wrote 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2097152/2097152 bytes at offset 2097152
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
-=3D=3D=3D End dirty bitmap, and start serving image over NBD =3D=3D=3D
+=3D=3D=3D End dirty bitmaps, and start serving image over NBD =3D=3D=3D
=20
 {"return": {}}
 {"return": {}}
@@ -27,18 +30,32 @@ wrote 2097152/2097152 bytes at offset 2097152
 {"return": {}}
 {"return": {}}
 {"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
=20
-=3D=3D=3D Contrast normal status with dirty-bitmap status =3D=3D=3D
+=3D=3D=3D Contrast normal status to large granularity dirty-bitmap =3D=3D=
=3D
=20
-read 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 524288/524288 bytes at offset 524288
+512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 2097152/2097152 bytes at offset 2097152
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": fals=
e},
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true},
+{ "start": 4096, "length": 1044480, "depth": 0, "zero": true, "data": fa=
lse},
 { "start": 1048576, "length": 3145728, "depth": 0, "zero": false, "data"=
: true}]
-[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": tru=
e},
+[{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": false=
},
+{ "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data": =
true},
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data"=
: false}]
+
+=3D=3D=3D Contrast to small granularity dirty-bitmap =3D=3D=3D
+
+[{ "start": 0, "length": 512, "depth": 0, "zero": false, "data": true},
+{ "start": 512, "length": 512, "depth": 0, "zero": false, "data": false}=
,
+{ "start": 1024, "length": 2096128, "depth": 0, "zero": false, "data": t=
rue},
 { "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data"=
: false}]
=20
 =3D=3D=3D End NBD server =3D=3D=3D
@@ -46,4 +63,5 @@ read 2097152/2097152 bytes at offset 2097152
 {"return": {}}
 {"return": {}}
 {"return": {}}
+{"return": {}}
 *** done
--=20
2.19.1
