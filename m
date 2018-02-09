Received: from eggs.gnu.org ([2001:4830:134:3::10]:47724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ek70z-0007Df-9B
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ek70w-0005RE-5i
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:38:49 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri,  9 Feb 2018 13:37:44 +0200
Message-Id: <20180209113744.11842-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] qcow2: Check the L1 table parameters from all
 internal snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

The code that reads the qcow2 snapshot table takes the offset and size
of all snapshots' L1 table without doing any kind of checks.

Although qcow2_snapshot_load_tmp() does verify that the table size is
valid, the table offset is not checked at all. On top of that there
are several other code paths that deal with internal snapshots that
don't use that function or do any other check.

This patch verifies that all L1 tables are correctly aligned and the
size does not exceed the maximum allowed valued.

The check from qcow2_snapshot_load_tmp() is removed since it's now
useless (opening an image will fail before that).

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-snapshot.c     | 14 ++++++++++----
 tests/qemu-iotests/080     | 10 +++++++++-
 tests/qemu-iotests/080.out | 10 ++++++++--
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 44243e0e95..b9d46d95fa 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -121,6 +121,16 @@ int qcow2_read_snapshots(BlockDriverState *bs)
         offset += name_size;
         sn->name[name_size] = '\0';
 
+        if (offset_into_cluster(s, sn->l1_table_offset)) {
+            ret = -EINVAL;
+            goto fail;
+        }
+
+        if (sn->l1_size > QCOW_MAX_L1_SIZE / sizeof(uint64_t)) {
+            ret = -EFBIG;
+            goto fail;
+        }
+
         if (offset - s->snapshots_offset > QCOW_MAX_SNAPSHOTS_SIZE) {
             ret = -EFBIG;
             goto fail;
@@ -704,10 +714,6 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
     sn = &s->snapshots[snapshot_index];
 
     /* Allocate and read in the snapshot's L1 table */
-    if (sn->l1_size > QCOW_MAX_L1_SIZE / sizeof(uint64_t)) {
-        error_setg(errp, "Snapshot L1 table too large");
-        return -EFBIG;
-    }
     new_l1_bytes = sn->l1_size * sizeof(uint64_t);
     new_l1_table = qemu_try_blockalign(bs->file->bs,
                                        align_offset(new_l1_bytes, 512));
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 1c2bd85742..dec6749908 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -171,7 +171,15 @@ poke_file "$TEST_IMG" "$offset_l2_table_0" "\x80\x00\x00\xff\xff\xff\x00\x00"
 { $QEMU_IMG snapshot -c test $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
-echo "== Invalid snapshot L1 table =="
+echo "== Invalid snapshot L1 table offset =="
+_make_test_img 64M
+{ $QEMU_IO -c "write 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IMG snapshot -c test $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
+poke_file "$TEST_IMG" "$offset_snap1_l1_offset" "\x00\x00\x00\x00\x00\x40\x02\x00"
+{ $QEMU_IMG convert -s test $TEST_IMG $TEST_IMG.snap; } 2>&1 | _filter_testdir
+
+echo
+echo "== Invalid snapshot L1 table size =="
 _make_test_img 64M
 { $QEMU_IO -c "write 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
 { $QEMU_IMG snapshot -c test $TEST_IMG; } 2>&1 | _filter_testdir
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index 6a7fda1356..86ed9567b7 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -59,9 +59,15 @@ wrote 512/512 bytes at offset 0
 qemu-img: Could not create snapshot 'test': -27 (File too large)
 qemu-img: Could not create snapshot 'test': -11 (Resource temporarily unavailable)
 
-== Invalid snapshot L1 table ==
+== Invalid snapshot L1 table offset ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Failed to load snapshot: Snapshot L1 table too large
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Could not read snapshots: Invalid argument
+
+== Invalid snapshot L1 table size ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Could not read snapshots: File too large
 *** done
-- 
2.11.0
