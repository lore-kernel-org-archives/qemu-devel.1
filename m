Received: from eggs.gnu.org ([2001:4830:134:3::10]:53450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1emMRT-0002P6-9q
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1emMRN-0007Xc-2d
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:31:27 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 15 Feb 2018 18:30:55 +0200
Message-Id: <e88300880e84e1ae7c4803c4e1cb8201de11bacc.1518711805.git.berto@igalia.com>
In-Reply-To: <cover.1518711805.git.berto@igalia.com>
References: <cover.1518711805.git.berto@igalia.com>
In-Reply-To: <cover.1518711805.git.berto@igalia.com>
References: <cover.1518711805.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH 2/2] qcow2: Check the L1 table parameters
 from all internal snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

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
 block/qcow2-snapshot.c     | 18 +++++++++++++-----
 block/qcow2.c              |  2 +-
 block/qcow2.h              |  2 +-
 tests/qemu-iotests/080     | 16 +++++++++++++++-
 tests/qemu-iotests/080.out | 42 ++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 7a36073e3e..4424b7f1dc 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -44,7 +44,7 @@ void qcow2_free_snapshots(BlockDriverState *bs)
     s->nb_snapshots = 0;
 }
 
-int qcow2_read_snapshots(BlockDriverState *bs)
+int qcow2_read_snapshots(BlockDriverState *bs, int flags)
 {
     BDRVQcow2State *s = bs->opaque;
     QCowSnapshotHeader h;
@@ -121,6 +121,18 @@ int qcow2_read_snapshots(BlockDriverState *bs)
         offset += name_size;
         sn->name[name_size] = '\0';
 
+        if (!(flags & BDRV_O_CHECK)) {
+            if (offset_into_cluster(s, sn->l1_table_offset)) {
+                ret = -EINVAL;
+                goto fail;
+            }
+
+            if (sn->l1_size > QCOW_MAX_L1_SIZE / sizeof(uint64_t)) {
+                ret = -EFBIG;
+                goto fail;
+            }
+        }
+
         if (offset - s->snapshots_offset > QCOW_MAX_SNAPSHOTS_SIZE) {
             ret = -EFBIG;
             goto fail;
@@ -704,10 +716,6 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
     sn = &s->snapshots[snapshot_index];
 
     /* Allocate and read in the snapshot's L1 table */
-    if (sn->l1_size > QCOW_MAX_L1_SIZE / sizeof(uint64_t)) {
-        error_setg(errp, "Snapshot L1 table too large");
-        return -EFBIG;
-    }
     new_l1_bytes = sn->l1_size * sizeof(uint64_t);
     new_l1_table = qemu_try_blockalign(bs->file->bs,
                                        ROUND_UP(new_l1_bytes, 512));
diff --git a/block/qcow2.c b/block/qcow2.c
index 20e16ea602..f56947aebf 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1474,7 +1474,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
     s->snapshots_offset = header.snapshots_offset;
     s->nb_snapshots = header.nb_snapshots;
 
-    ret = qcow2_read_snapshots(bs);
+    ret = qcow2_read_snapshots(bs, flags);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not read snapshots");
         goto fail;
diff --git a/block/qcow2.h b/block/qcow2.h
index 19f14bfc1e..fcd336aec4 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -641,7 +641,7 @@ int qcow2_snapshot_table_check(BlockDriverState *bs, BdrvCheckResult *result,
                                BdrvCheckMode fix);
 
 void qcow2_free_snapshots(BlockDriverState *bs);
-int qcow2_read_snapshots(BlockDriverState *bs);
+int qcow2_read_snapshots(BlockDriverState *bs, int flags);
 
 /* qcow2-cache.c functions */
 Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 1c2bd85742..728a5f937a 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -171,13 +171,27 @@ poke_file "$TEST_IMG" "$offset_l2_table_0" "\x80\x00\x00\xff\xff\xff\x00\x00"
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
+# Fix the image
+_check_test_img -r all
+
+echo
+echo "== Invalid snapshot L1 table size =="
 _make_test_img 64M
 { $QEMU_IO -c "write 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
 { $QEMU_IMG snapshot -c test $TEST_IMG; } 2>&1 | _filter_testdir
 poke_file "$TEST_IMG" "$offset_snap1_l1_size" "\x10\x00\x00\x00"
 { $QEMU_IMG convert -s test $TEST_IMG $TEST_IMG.snap; } 2>&1 | _filter_testdir
 
+# Fix the image
+_check_test_img -r all
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index 6a7fda1356..eb26496566 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -59,9 +59,47 @@ wrote 512/512 bytes at offset 0
 qemu-img: Could not create snapshot 'test': -27 (File too large)
 qemu-img: Could not create snapshot 'test': -11 (Resource temporarily unavailable)
 
-== Invalid snapshot L1 table ==
+== Invalid snapshot L1 table offset ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-qemu-img: Failed to load snapshot: Snapshot L1 table too large
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Could not read snapshots: Invalid argument
+Deleting snapshot 1 (test) l1_offset=0x400200: L1 table is not cluster aligned; snapshot table entry corrupted
+Leaked cluster 4 refcount=2 reference=1
+Leaked cluster 5 refcount=2 reference=1
+Leaked cluster 6 refcount=1 reference=0
+Repairing cluster 4 refcount=2 reference=1
+Repairing cluster 5 refcount=2 reference=1
+Repairing cluster 6 refcount=1 reference=0
+Repairing OFLAG_COPIED L2 cluster: l1_index=0 l1_entry=40000 refcount=1
+Repairing OFLAG_COPIED data cluster: l2_entry=50000 refcount=1
+The following inconsistencies were found and repaired:
+
+    3 leaked clusters
+    3 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+
+== Invalid snapshot L1 table size ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: Could not open 'TEST_DIR/t.qcow2': Could not read snapshots: File too large
+Deleting snapshot 1 (test) l1_size=0x10000000: L1 table is too large; snapshot table entry corrupted
+Leaked cluster 4 refcount=2 reference=1
+Leaked cluster 5 refcount=2 reference=1
+Leaked cluster 6 refcount=1 reference=0
+Repairing cluster 4 refcount=2 reference=1
+Repairing cluster 5 refcount=2 reference=1
+Repairing cluster 6 refcount=1 reference=0
+Repairing OFLAG_COPIED L2 cluster: l1_index=0 l1_entry=40000 refcount=1
+Repairing OFLAG_COPIED data cluster: l2_entry=50000 refcount=1
+The following inconsistencies were found and repaired:
+
+    3 leaked clusters
+    3 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
 *** done
-- 
2.11.0
