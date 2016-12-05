Received: from eggs.gnu.org ([2001:4830:134:3::10]:53074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDvWg-0006o5-6F
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:50:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cDvWc-0008J7-42
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:49:58 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon,  5 Dec 2016 09:49:34 -0600
Message-Id: <20161205154934.24999-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.8 v2] qcow2: Don't strand clusters near
 2G intervals during commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

The qcow2_make_empty() function is reached during 'qemu-img commit',
in order to clear out ALL clusters of an image.  However, if the
image cannot use the fast code path (true if the image is format
0.10, or if the image contains a snapshot), the cluster size is
larger than 512, and the image is larger than 2G in size, then our
choice of sector_step causes problems.  Since it is not cluster
aligned, but qcow2_discard_clusters() silently ignores an unaligned
head or tail, we are leaving clusters allocated.

Enhance the testsuite to expose the flaw, and patch the problem by
ensuring our step size is aligned.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: perform rounding correctly
---
 block/qcow2.c              |   3 +-
 tests/qemu-iotests/097     |  41 +++++---
 tests/qemu-iotests/097.out | 249 +++++++++++++++++++++++++++++++++------------
 3 files changed, 210 insertions(+), 83 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ed9e0f3..96fb8a8 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2808,7 +2808,8 @@ static int qcow2_make_empty(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t start_sector;
-    int sector_step = INT_MAX / BDRV_SECTOR_SIZE;
+    int sector_step = (QEMU_ALIGN_DOWN(INT_MAX, s->cluster_size) /
+                       BDRV_SECTOR_SIZE);
     int l1_clusters, ret = 0;

     l1_clusters = DIV_ROUND_UP(s->l1_size, s->cluster_size / sizeof(uint64_t));
diff --git a/tests/qemu-iotests/097 b/tests/qemu-iotests/097
index 01d8dd0..4c33e80 100755
--- a/tests/qemu-iotests/097
+++ b/tests/qemu-iotests/097
@@ -46,7 +46,7 @@ _supported_proto file
 _supported_os Linux


-# Four passes:
+# Four main passes:
 #  0: Two-layer backing chain, commit to upper backing file (implicitly)
 #     (in this case, the top image will be emptied)
 #  1: Two-layer backing chain, commit to upper backing file (explicitly)
@@ -56,22 +56,30 @@ _supported_os Linux
 #  3: Two-layer backing chain, commit to lower backing file
 #     (in this case, the top image will implicitly stay unchanged)
 #
+# Each pass is run twice, since qcow2 has different code paths for cleaning
+# an image depending on whether it has a snapshot.
+#
 # 020 already tests committing, so this only tests whether image chains are
 # working properly and that all images above the base are emptied; therefore,
-# no complicated patterns are necessary
+# no complicated patterns are necessary.  Check near the 2G mark, as qcow2
+# has been buggy at that boundary in the past.
 for i in 0 1 2 3; do
+for j in 0 1; do

 echo
-echo "=== Test pass $i ==="
+echo "=== Test pass $i.$j ==="
 echo

-TEST_IMG="$TEST_IMG.base" _make_test_img 64M
-TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" 64M
-_make_test_img -b "$TEST_IMG.itmd" 64M
+TEST_IMG="$TEST_IMG.base" _make_test_img 2100M
+TEST_IMG="$TEST_IMG.itmd" _make_test_img -b "$TEST_IMG.base" 2100M
+_make_test_img -b "$TEST_IMG.itmd" 2100M
+if [ $j -eq 0 ]; then
+    $QEMU_IMG snapshot -c snap "$TEST_IMG"
+fi

-$QEMU_IO -c 'write -P 1 0 192k' "$TEST_IMG.base" | _filter_qemu_io
-$QEMU_IO -c 'write -P 2 64k 128k' "$TEST_IMG.itmd" | _filter_qemu_io
-$QEMU_IO -c 'write -P 3 128k 64k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c 'write -P 1 0x7ffd0000 192k' "$TEST_IMG.base" | _filter_qemu_io
+$QEMU_IO -c 'write -P 2 0x7ffe0000 128k' "$TEST_IMG.itmd" | _filter_qemu_io
+$QEMU_IO -c 'write -P 3 0x7fff0000 64k' "$TEST_IMG" | _filter_qemu_io

 if [ $i -lt 3 ]; then
     if [ $i == 0 ]; then
@@ -88,12 +96,12 @@ if [ $i -lt 3 ]; then
     fi

     # Bottom should be unchanged
-    $QEMU_IO -c 'read -P 1 0 192k' "$TEST_IMG.base" | _filter_qemu_io
+    $QEMU_IO -c 'read -P 1 0x7ffd0000 192k' "$TEST_IMG.base" | _filter_qemu_io

     # Intermediate should contain changes from top
-    $QEMU_IO -c 'read -P 1 0 64k' "$TEST_IMG.itmd" | _filter_qemu_io
-    $QEMU_IO -c 'read -P 2 64k 64k' "$TEST_IMG.itmd" | _filter_qemu_io
-    $QEMU_IO -c 'read -P 3 128k 64k' "$TEST_IMG.itmd" | _filter_qemu_io
+    $QEMU_IO -c 'read -P 1 0x7ffd0000 64k' "$TEST_IMG.itmd" | _filter_qemu_io
+    $QEMU_IO -c 'read -P 2 0x7ffe0000 64k' "$TEST_IMG.itmd" | _filter_qemu_io
+    $QEMU_IO -c 'read -P 3 0x7fff0000 64k' "$TEST_IMG.itmd" | _filter_qemu_io

     # And in pass 0, the top image should be empty, whereas in both other passes
     # it should be unchanged (which is both checked by qemu-img map)
@@ -101,9 +109,9 @@ else
     $QEMU_IMG commit -b "$TEST_IMG.base" "$TEST_IMG"

     # Bottom should contain all changes
-    $QEMU_IO -c 'read -P 1 0 64k' "$TEST_IMG.base" | _filter_qemu_io
-    $QEMU_IO -c 'read -P 2 64k 64k' "$TEST_IMG.base" | _filter_qemu_io
-    $QEMU_IO -c 'read -P 3 128k 64k' "$TEST_IMG.base" | _filter_qemu_io
+    $QEMU_IO -c 'read -P 1 0x7ffd0000 64k' "$TEST_IMG.base" | _filter_qemu_io
+    $QEMU_IO -c 'read -P 2 0x7ffe0000 64k' "$TEST_IMG.base" | _filter_qemu_io
+    $QEMU_IO -c 'read -P 3 0x7fff0000 64k' "$TEST_IMG.base" | _filter_qemu_io

     # Both top and intermediate should be unchanged
 fi
@@ -113,6 +121,7 @@ $QEMU_IMG map "$TEST_IMG.itmd" | _filter_qemu_img_map
 $QEMU_IMG map "$TEST_IMG" | _filter_qemu_img_map

 done
+done


 # success, all done
diff --git a/tests/qemu-iotests/097.out b/tests/qemu-iotests/097.out
index 48abd2e..8106cc9 100644
--- a/tests/qemu-iotests/097.out
+++ b/tests/qemu-iotests/097.out
@@ -1,119 +1,236 @@
 QA output created by 097

-=== Test pass 0 ===
+=== Test pass 0.0 ===

-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.itmd
-wrote 196608/196608 bytes at offset 0
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 131072/131072 bytes at offset 65536
+wrote 131072/131072 bytes at offset 2147352576
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 131072
+wrote 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image committed.
-read 196608/196608 bytes at offset 0
+read 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 0
+read 65536/65536 bytes at offset 2147287040
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 65536
+read 65536/65536 bytes at offset 2147352576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 131072
+read 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
-0               0x30000         TEST_DIR/t.IMGFMT.base
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
 Offset          Length          File
-0               0x10000         TEST_DIR/t.IMGFMT.base
-0x10000         0x20000         TEST_DIR/t.IMGFMT.itmd
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
 Offset          Length          File
-0               0x10000         TEST_DIR/t.IMGFMT.base
-0x10000         0x20000         TEST_DIR/t.IMGFMT.itmd
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd

-=== Test pass 1 ===
+=== Test pass 0.1 ===

-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.itmd
-wrote 196608/196608 bytes at offset 0
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 131072/131072 bytes at offset 65536
+wrote 131072/131072 bytes at offset 2147352576
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 131072
+wrote 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image committed.
-read 196608/196608 bytes at offset 0
+read 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 0
+read 65536/65536 bytes at offset 2147287040
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 65536
+read 65536/65536 bytes at offset 2147352576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 131072
+read 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
-0               0x30000         TEST_DIR/t.IMGFMT.base
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
 Offset          Length          File
-0               0x10000         TEST_DIR/t.IMGFMT.base
-0x10000         0x20000         TEST_DIR/t.IMGFMT.itmd
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
 Offset          Length          File
-0               0x10000         TEST_DIR/t.IMGFMT.base
-0x10000         0x10000         TEST_DIR/t.IMGFMT.itmd
-0x20000         0x10000         TEST_DIR/t.IMGFMT
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd

-=== Test pass 2 ===
+=== Test pass 1.0 ===

-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.itmd
-wrote 196608/196608 bytes at offset 0
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 131072/131072 bytes at offset 65536
+wrote 131072/131072 bytes at offset 2147352576
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 131072
+wrote 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image committed.
-read 196608/196608 bytes at offset 0
+read 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 0
+read 65536/65536 bytes at offset 2147287040
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 65536
+read 65536/65536 bytes at offset 2147352576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 131072
+read 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
-0               0x30000         TEST_DIR/t.IMGFMT.base
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
 Offset          Length          File
-0               0x10000         TEST_DIR/t.IMGFMT.base
-0x10000         0x20000         TEST_DIR/t.IMGFMT.itmd
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
 Offset          Length          File
-0               0x10000         TEST_DIR/t.IMGFMT.base
-0x10000         0x10000         TEST_DIR/t.IMGFMT.itmd
-0x20000         0x10000         TEST_DIR/t.IMGFMT
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
+0x7fff0000      0x10000         TEST_DIR/t.IMGFMT

-=== Test pass 3 ===
+=== Test pass 1.1 ===

-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
-Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.itmd
-wrote 196608/196608 bytes at offset 0
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+wrote 196608/196608 bytes at offset 2147287040
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 131072/131072 bytes at offset 65536
+wrote 131072/131072 bytes at offset 2147352576
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 131072
+wrote 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Image committed.
-read 65536/65536 bytes at offset 0
+read 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147287040
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147352576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
+0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+
+=== Test pass 2.0 ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+wrote 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 2147352576
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image committed.
+read 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147287040
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147352576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
+0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+
+=== Test pass 2.1 ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+wrote 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 2147352576
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image committed.
+read 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147287040
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147352576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
+0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+
+=== Test pass 3.0 ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+wrote 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 2147352576
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image committed.
+read 65536/65536 bytes at offset 2147287040
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147352576
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
+Offset          Length          File
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
+0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
+
+=== Test pass 3.1 ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=2202009600
+Formatting 'TEST_DIR/t.IMGFMT.itmd', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=2202009600 backing_file=TEST_DIR/t.IMGFMT.itmd
+wrote 196608/196608 bytes at offset 2147287040
+192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 2147352576
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 2147418112
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Image committed.
+read 65536/65536 bytes at offset 2147287040
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 65536
+read 65536/65536 bytes at offset 2147352576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 65536/65536 bytes at offset 131072
+read 65536/65536 bytes at offset 2147418112
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Offset          Length          File
-0               0x30000         TEST_DIR/t.IMGFMT.base
+0x7ffd0000      0x30000         TEST_DIR/t.IMGFMT.base
 Offset          Length          File
-0               0x10000         TEST_DIR/t.IMGFMT.base
-0x10000         0x20000         TEST_DIR/t.IMGFMT.itmd
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
 Offset          Length          File
-0               0x10000         TEST_DIR/t.IMGFMT.base
-0x10000         0x10000         TEST_DIR/t.IMGFMT.itmd
-0x20000         0x10000         TEST_DIR/t.IMGFMT
+0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
+0x7ffe0000      0x10000         TEST_DIR/t.IMGFMT.itmd
+0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
 *** done
-- 
2.9.3
