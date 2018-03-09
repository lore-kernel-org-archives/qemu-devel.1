Received: from eggs.gnu.org ([2001:4830:134:3::10]:33172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkl-0000rO-Kf
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkk-0006aj-0N
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:19 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:18:46 +0100
Message-Id: <20180309161933.8168-10-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/56] qcow2: Check L1 table offset in
 qcow2_snapshot_load_tmp()
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

This function checks that the size of a snapshot's L1 table is not too
large, but it doesn't validate the offset.

We now have a function to take care of this, so let's use it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-snapshot.c     |  8 +++++---
 tests/qemu-iotests/080     | 10 +++++++++-
 tests/qemu-iotests/080.out |  8 +++++++-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index cee25f582b..bf94f4f434 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -704,9 +704,11 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
     sn = &s->snapshots[snapshot_index];
 
     /* Allocate and read in the snapshot's L1 table */
-    if (sn->l1_size > QCOW_MAX_L1_SIZE / sizeof(uint64_t)) {
-        error_setg(errp, "Snapshot L1 table too large");
-        return -EFBIG;
+    ret = qcow2_validate_table(bs, sn->l1_table_offset, sn->l1_size,
+                               sizeof(uint64_t), QCOW_MAX_L1_SIZE,
+                               "Snapshot L1 table", errp);
+    if (ret < 0) {
+        return ret;
     }
     new_l1_bytes = sn->l1_size * sizeof(uint64_t);
     new_l1_table = qemu_try_blockalign(bs->file->bs,
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 1c2bd85742..6a10e7defa 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -171,7 +171,15 @@ poke_file "$TEST_IMG" "$offset_l2_table_0" "\x80\x00\x00\xff\xff\xff\x00\x00"
 { $QEMU_IMG snapshot -c test $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
 
 echo
-echo "== Invalid snapshot L1 table =="
+echo "== Invalid snapshot L1 table offset =="
+_make_test_img 64M
+{ $QEMU_IO -c "write 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IMG snapshot -c test $TEST_IMG; } 2>&1 | _filter_testdir
+poke_file "$TEST_IMG" "$offset_snap1_l1_offset" "\x00\x00\x00\x00\x00\x40\x02\x00"
+{ $QEMU_IMG convert -s test $TEST_IMG $TEST_IMG.snap; } 2>&1 | _filter_testdir
+
+echo
+echo "== Invalid snapshot L1 table size =="
 _make_test_img 64M
 { $QEMU_IO -c "write 0 512" $TEST_IMG; } 2>&1 | _filter_qemu_io | _filter_testdir
 { $QEMU_IMG snapshot -c test $TEST_IMG; } 2>&1 | _filter_testdir
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index 4c7790c9ee..f0d9038d55 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -59,7 +59,13 @@ wrote 512/512 bytes at offset 0
 qemu-img: Could not create snapshot 'test': -27 (File too large)
 qemu-img: Could not create snapshot 'test': -11 (Resource temporarily unavailable)
 
-== Invalid snapshot L1 table ==
+== Invalid snapshot L1 table offset ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: Failed to load snapshot: Snapshot L1 table offset invalid
+
+== Invalid snapshot L1 table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.13.6
