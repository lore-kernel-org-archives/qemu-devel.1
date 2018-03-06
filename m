Received: from eggs.gnu.org ([2001:4830:134:3::10]:60897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1etFEs-0007MD-Gj
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1etFEn-00080Y-VV
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:14:54 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue,  6 Mar 2018 18:14:10 +0200
Message-Id: <483061de4af377793c1de733d1160dc6655496f8.1520352600.git.berto@igalia.com>
In-Reply-To: <cover.1520352600.git.berto@igalia.com>
References: <cover.1520352600.git.berto@igalia.com>
In-Reply-To: <cover.1520352600.git.berto@igalia.com>
References: <cover.1520352600.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 5/7] qcow2: Check snapshot L1 table in
 qcow2_snapshot_goto()
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

This function copies a snapshot's L1 table into the active one without
validating it first.

We now have a function to take care of this, so let's use it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Cc: Eric Blake <eblake@redhat.com>
---
 block/qcow2-snapshot.c     | 9 +++++++++
 tests/qemu-iotests/080     | 2 ++
 tests/qemu-iotests/080.out | 4 ++++
 3 files changed, 15 insertions(+)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index bf94f4f434..0faf728dc4 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -465,6 +465,7 @@ int qcow2_snapshot_goto(BlockDriverState *bs, const char *snapshot_id)
 {
     BDRVQcow2State *s = bs->opaque;
     QCowSnapshot *sn;
+    Error *local_err = NULL;
     int i, snapshot_index;
     int cur_l1_bytes, sn_l1_bytes;
     int ret;
@@ -477,6 +478,14 @@ int qcow2_snapshot_goto(BlockDriverState *bs, const char *snapshot_id)
     }
     sn = &s->snapshots[snapshot_index];
 
+    ret = qcow2_validate_table(bs, sn->l1_table_offset, sn->l1_size,
+                               sizeof(uint64_t), QCOW_MAX_L1_SIZE,
+                               "Snapshot L1 table", &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        goto fail;
+    }
+
     if (sn->disk_size != bs->total_sectors * BDRV_SECTOR_SIZE) {
         error_report("qcow2: Loading snapshots with different disk "
             "size is not implemented");
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 018f815697..538857310f 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -180,6 +180,7 @@ poke_file "$TEST_IMG" "$offset_snap1_l1_offset" "\x00\x00\x00\x00\x00\x40\x02\x0
 { $QEMU_IMG amend -o compat=0.10 $TEST_IMG; } 2>&1 | _filter_testdir
 { $QEMU_IO -c "open -o overlap-check.inactive-l2=on $TEST_IMG" \
            -c 'write 0 4k'; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IMG snapshot -a test $TEST_IMG; } 2>&1 | _filter_testdir
 
 echo
 echo "== Invalid snapshot L1 table size =="
@@ -191,6 +192,7 @@ poke_file "$TEST_IMG" "$offset_snap1_l1_size" "\x10\x00\x00\x00"
 { $QEMU_IMG amend -o compat=0.10 $TEST_IMG; } 2>&1 | _filter_testdir
 { $QEMU_IO -c "open -o overlap-check.inactive-l2=on $TEST_IMG" \
            -c 'write 0 4k'; } 2>&1 | _filter_qemu_io | _filter_testdir
+{ $QEMU_IMG snapshot -a test $TEST_IMG; } 2>&1 | _filter_testdir
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index d622ac06c0..1525e1b087 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -68,6 +68,8 @@ qemu-img: Snapshot L1 table offset invalid
 qemu-img: Error while amending options: Invalid argument
 Failed to flush the refcount block cache: Invalid argument
 write failed: Invalid argument
+qemu-img: Snapshot L1 table offset invalid
+qemu-img: Could not apply snapshot 'test': Failed to load snapshot: Invalid argument
 
 == Invalid snapshot L1 table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
@@ -78,4 +80,6 @@ qemu-img: Snapshot L1 table too large
 qemu-img: Error while amending options: File too large
 Failed to flush the refcount block cache: File too large
 write failed: File too large
+qemu-img: Snapshot L1 table too large
+qemu-img: Could not apply snapshot 'test': Failed to load snapshot: File too large
 *** done
-- 
2.11.0
