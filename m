Received: from eggs.gnu.org ([2001:4830:134:3::10]:41353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1erR46-0008BW-HQ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:28:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1erR41-0004Jx-Fj
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:28:18 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  1 Mar 2018 18:27:12 +0200
Message-Id: <e0230b79625ea4f0a73e6c1cc43710a2e1a1aa21.1519921268.git.berto@igalia.com>
In-Reply-To: <cover.1519921268.git.berto@igalia.com>
References: <cover.1519921268.git.berto@igalia.com>
In-Reply-To: <cover.1519921268.git.berto@igalia.com>
References: <cover.1519921268.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 6/7] qcow2: Check snapshot L1 table in
 qcow2_snapshot_delete()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This function deletes a snapshot from disk, removing its entry from
the snapshot table, freeing its L1 table and decreasing the refcounts
of all clusters.

The L1 table offset and size are however not validated. If we use
invalid values in this function we'll probably corrupt the image even
more, so we should return an error instead.

We now have a function to take care of this, so let's use it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-snapshot.c     | 7 +++++++
 tests/qemu-iotests/080     | 2 ++
 tests/qemu-iotests/080.out | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index f1be5506a2..727a3d79de 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -608,6 +608,13 @@ int qcow2_snapshot_delete(BlockDriverState *bs,
     }
     sn = s->snapshots[snapshot_index];
 
+    ret = qcow2_validate_table(bs, sn.l1_table_offset, sn.l1_size,
+                               sizeof(uint64_t), QCOW_MAX_L1_SIZE,
+                               "Snapshot L1 table", errp);
+    if (ret < 0) {
+        return ret;
+    }
+
     /* Remove it from the snapshot list */
     memmove(s->snapshots + snapshot_index,
             s->snapshots + snapshot_index + 1,
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index 538857310f..f8e7d6f4df 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -181,6 +181,7 @@ poke_file "$TEST_IMG" "$offset_snap1_l1_offset" "\x00\x00\x00\x00\x00\x40\x02\x0
 { $QEMU_IO -c "open -o overlap-check.inactive-l2=on $TEST_IMG" \
            -c 'write 0 4k'; } 2>&1 | _filter_qemu_io | _filter_testdir
 { $QEMU_IMG snapshot -a test $TEST_IMG; } 2>&1 | _filter_testdir
+{ $QEMU_IMG snapshot -d test $TEST_IMG; } 2>&1 | _filter_testdir
 
 echo
 echo "== Invalid snapshot L1 table size =="
@@ -193,6 +194,7 @@ poke_file "$TEST_IMG" "$offset_snap1_l1_size" "\x10\x00\x00\x00"
 { $QEMU_IO -c "open -o overlap-check.inactive-l2=on $TEST_IMG" \
            -c 'write 0 4k'; } 2>&1 | _filter_qemu_io | _filter_testdir
 { $QEMU_IMG snapshot -a test $TEST_IMG; } 2>&1 | _filter_testdir
+{ $QEMU_IMG snapshot -d test $TEST_IMG; } 2>&1 | _filter_testdir
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index 35c768aff3..f16fd59053 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -68,6 +68,7 @@ qemu-img: Error while amending options: Invalid argument
 Failed to flush the refcount block cache: Invalid argument
 write failed: Invalid argument
 qemu-img: Could not apply snapshot 'test': Failed to load snapshot: Invalid argument
+qemu-img: Could not delete snapshot 'test': Snapshot L1 table offset invalid
 
 == Invalid snapshot L1 table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
@@ -78,4 +79,5 @@ qemu-img: Error while amending options: File too large
 Failed to flush the refcount block cache: File too large
 write failed: File too large
 qemu-img: Could not apply snapshot 'test': Failed to load snapshot: File too large
+qemu-img: Could not delete snapshot 'test': Snapshot L1 table too large
 *** done
-- 
2.11.0
