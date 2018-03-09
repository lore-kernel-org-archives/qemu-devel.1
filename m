Received: from eggs.gnu.org ([2001:4830:134:3::10]:33297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkp-0000wt-1L
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkn-0006fK-07
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:22 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:18:47 +0100
Message-Id: <20180309161933.8168-11-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/56] qcow2: Check L1 table parameters in
 qcow2_expand_zero_clusters()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

This function iterates over all snapshots of a qcow2 file in order to
expand all zero clusters, but it does not validate the snapshots' L1
tables first.

We now have a function to take care of this, so let's use it.

We can also take the opportunity to replace the sector-based
bdrv_read() with bdrv_pread().

Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-cluster.c      | 24 +++++++++++++++++-------
 tests/qemu-iotests/080     |  2 ++
 tests/qemu-iotests/080.out |  4 ++++
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 98908c4264..1aee726c6a 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include <zlib.h>
 
+#include "qapi/error.h"
 #include "qemu-common.h"
 #include "block/block_int.h"
 #include "block/qcow2.h"
@@ -2092,11 +2093,21 @@ int qcow2_expand_zero_clusters(BlockDriverState *bs,
     }
 
     for (i = 0; i < s->nb_snapshots; i++) {
-        int l1_sectors = DIV_ROUND_UP(s->snapshots[i].l1_size *
-                                      sizeof(uint64_t), BDRV_SECTOR_SIZE);
+        int l1_size2;
+        uint64_t *new_l1_table;
+        Error *local_err = NULL;
+
+        ret = qcow2_validate_table(bs, s->snapshots[i].l1_table_offset,
+                                   s->snapshots[i].l1_size, sizeof(uint64_t),
+                                   QCOW_MAX_L1_SIZE, "Snapshot L1 table",
+                                   &local_err);
+        if (ret < 0) {
+            error_report_err(local_err);
+            goto fail;
+        }
 
-        uint64_t *new_l1_table =
-            g_try_realloc(l1_table, l1_sectors * BDRV_SECTOR_SIZE);
+        l1_size2 = s->snapshots[i].l1_size * sizeof(uint64_t);
+        new_l1_table = g_try_realloc(l1_table, l1_size2);
 
         if (!new_l1_table) {
             ret = -ENOMEM;
@@ -2105,9 +2116,8 @@ int qcow2_expand_zero_clusters(BlockDriverState *bs,
 
         l1_table = new_l1_table;
 
-        ret = bdrv_read(bs->file,
-                        s->snapshots[i].l1_table_offset / BDRV_SECTOR_SIZE,
-                        (void *)l1_table, l1_sectors);
+        ret = bdrv_pread(bs->file, s->snapshots[i].l1_table_offset,
+                         l1_table, l1_size2);
         if (ret < 0) {
             goto fail;
         }
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 6a10e7defa..5622604f83 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -177,6 +177,7 @@ _make_test_img 64M
 { $QEMU_IMG snapshot -c test $TEST_IMG; } 2>&1 | _filter_testdir
 poke_file "$TEST_IMG" "$offset_snap1_l1_offset" "\x00\x00\x00\x00\x00\x40\x02\x00"
 { $QEMU_IMG convert -s test $TEST_IMG $TEST_IMG.snap; } 2>&1 | _filter_testdir
+{ $QEMU_IMG amend -o compat=0.10 $TEST_IMG; } 2>&1 | _filter_testdir
 
 echo
 echo "== Invalid snapshot L1 table size =="
@@ -185,6 +186,7 @@ _make_test_img 64M
 { $QEMU_IMG snapshot -c test $TEST_IMG; } 2>&1 | _filter_testdir
 poke_file "$TEST_IMG" "$offset_snap1_l1_size" "\x10\x00\x00\x00"
 { $QEMU_IMG convert -s test $TEST_IMG $TEST_IMG.snap; } 2>&1 | _filter_testdir
+{ $QEMU_IMG amend -o compat=0.10 $TEST_IMG; } 2>&1 | _filter_testdir
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index f0d9038d55..315edbc26f 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -64,10 +64,14 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Failed to load snapshot: Snapshot L1 table offset invalid
+qemu-img: Snapshot L1 table offset invalid
+qemu-img: Error while amending options: Invalid argument
 
 == Invalid snapshot L1 table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qemu-img: Failed to load snapshot: Snapshot L1 table too large
+qemu-img: Snapshot L1 table too large
+qemu-img: Error while amending options: File too large
 *** done
-- 
2.13.6
