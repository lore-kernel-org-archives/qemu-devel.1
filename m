Received: from eggs.gnu.org ([2001:4830:134:3::10]:44633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnMn-0008OS-5E
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gOnMl-0006gW-VM
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 12:29:45 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 19 Nov 2018 11:29:24 -0600
Message-Id: <20181119172924.2296342-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1] iotests: Enhance 223 to cover multiple
 bitmap granularities
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

Testing granularity at the same size as the cluster isn't quite
as fun as what happens when it is larger or smaller.  This
enhancement also shows that qemu's nbd server can server the
same disk over multiple exports simultaneously.

Signed-off-by: Eric Blake <eblake@redhat.com>
---

Just a testsuite enhancement, so suitable for -rc2 if it gets a
quick review. Otherwise, I will probably include it as part of
a larger series I'm working on to make qemu-nbd handle misaligned
images more sanely (that's a pre-existing problem in the 3.0 release,
so it's not fixing a regression and may be invovled enough to slip
into 4.0, depending on what the rest of my series looks like).

 tests/qemu-iotests/223     | 43 +++++++++++++++++++++++++++++++-------
 tests/qemu-iotests/223.out | 32 +++++++++++++++++++++-------
 2 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index 72419e03388..397b865d347 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -57,10 +57,11 @@ run_qemu()
 }

 echo
-echo "=== Create partially sparse image, then add dirty bitmap ==="
+echo "=== Create partially sparse image, then add dirty bitmaps ==="
 echo

-_make_test_img 4M
+# Two bitmaps, to contrast granularity issues
+_make_test_img -o cluster_size=4k 4M
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
 echo "=== Write part of the file under active bitmap ==="
 echo

-$QEMU_IO -c 'w -P 0x22 2M 2M' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c 'w -P 0x22 512 512' -c 'w -P 0x33 2M 2M' "$TEST_IMG" \
+    | _filter_qemu_io

 echo
-echo "=== End dirty bitmap, and start serving image over NBD ==="
+echo "=== End dirty bitmaps, and start serving image over NBD ==="
 echo

 _launch_qemu 2> >(_filter_nbd)
@@ -103,6 +114,8 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"blockdev-add",
     "file":{"driver":"file", "filename":"'"$TEST_IMG"'"}}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"x-block-dirty-bitmap-disable",
   "arguments":{"node":"n", "name":"b"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-block-dirty-bitmap-disable",
+  "arguments":{"node":"n", "name":"b2"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
   "arguments":{"addr":{"type":"unix",
     "data":{"path":"'"$TEST_DIR/nbd"'"}}}}' "return"
@@ -110,26 +123,40 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
   "arguments":{"name":"n", "bitmap":"b"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+  "arguments":{"device":"n", "name":"n2"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
+  "arguments":{"name":"n2", "bitmap":"b2"}}' "return"

 echo
-echo "=== Contrast normal status with dirty-bitmap status ==="
+echo "=== Contrast normal status to large granularity dirty-bitmap ==="
 echo

 QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
 IMG="driver=nbd,export=n,server.type=unix,server.path=$TEST_DIR/nbd"
-$QEMU_IO -r -c 'r -P 0 0 1m' -c 'r -P 0x11 1m 1m' \
-  -c 'r -P 0x22 2m 2m' --image-opts "$IMG" | _filter_qemu_io
+$QEMU_IO -r -c 'r -P 0x22 512 512' -c 'r -P 0 512k 512k' -c 'r -P 0x11 1m 1m' \
+  -c 'r -P 0x33 2m 2m' --image-opts "$IMG" | _filter_qemu_io
 $QEMU_IMG map --output=json --image-opts \
   "$IMG" | _filter_qemu_img_map
 $QEMU_IMG map --output=json --image-opts \
   "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b" | _filter_qemu_img_map

+echo
+echo "=== Contrast to small granularity dirty-bitmap ==="
+echo
+
+IMG="driver=nbd,export=n2,server.type=unix,server.path=$TEST_DIR/nbd"
+$QEMU_IMG map --output=json --image-opts \
+  "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b2" | _filter_qemu_img_map
+
 echo
 echo "=== End NBD server ==="
 echo

 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
   "arguments":{"name":"n"}}' "return"
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
+  "arguments":{"name":"n2"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-stop"}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"quit"}' "return"

diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 33021c8e6a1..de417477de0 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -1,6 +1,6 @@
 QA output created by 223

-=== Create partially sparse image, then add dirty bitmap ===
+=== Create partially sparse image, then add dirty bitmaps ===

 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
 wrote 2097152/2097152 bytes at offset 1048576
@@ -11,16 +11,22 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
+{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}


 === Write part of the file under active bitmap ===

+wrote 512/512 bytes at offset 512
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 2097152/2097152 bytes at offset 2097152
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

-=== End dirty bitmap, and start serving image over NBD ===
+=== End dirty bitmaps, and start serving image over NBD ===

+{"return": {}}
+{"return": {}}
+{"return": {}}
 {"return": {}}
 {"return": {}}
 {"return": {}}
@@ -28,21 +34,33 @@ wrote 2097152/2097152 bytes at offset 2097152
 {"return": {}}
 {"return": {}}

-=== Contrast normal status with dirty-bitmap status ===
+=== Contrast normal status to large granularity dirty-bitmap ===

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
-[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": false},
+[{ "start": 0, "length": 4096, "depth": 0, "zero": false, "data": true},
+{ "start": 4096, "length": 1044480, "depth": 0, "zero": true, "data": false},
 { "start": 1048576, "length": 3145728, "depth": 0, "zero": false, "data": true}]
-[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": true},
+[{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": false},
+{ "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data": true},
+{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": false}]
+
+=== Contrast to small granularity dirty-bitmap ===
+
+[{ "start": 0, "length": 512, "depth": 0, "zero": false, "data": true},
+{ "start": 512, "length": 512, "depth": 0, "zero": false, "data": false},
+{ "start": 1024, "length": 2096128, "depth": 0, "zero": false, "data": true},
 { "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": false}]

 === End NBD server ===

+{"return": {}}
 {"return": {}}
 {"return": {}}
 {"return": {}}
-- 
2.17.2
