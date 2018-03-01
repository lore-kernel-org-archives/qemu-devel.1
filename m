Received: from eggs.gnu.org ([2001:4830:134:3::10]:41350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1erR46-0008BT-H3
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1erR41-0004K5-GU
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:28:18 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu,  1 Mar 2018 18:27:13 +0200
Message-Id: <ab74e13d0484aad82a8d36e962835aa2f68e1172.1519921268.git.berto@igalia.com>
In-Reply-To: <cover.1519921268.git.berto@igalia.com>
References: <cover.1519921268.git.berto@igalia.com>
In-Reply-To: <cover.1519921268.git.berto@igalia.com>
References: <cover.1519921268.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 7/7] qcow2: Make qemu-img check detect
 corrupted L1 tables in snapshots
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

'qemu-img check' cannot detect if a snapshot's L1 table is corrupted.
This patch checks the table's offset and size and reports corruption
if the values are not valid.

This patch doesn't add code to fix that corruption yet, only to detect
and report it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-refcount.c     | 14 ++++++++++++++
 tests/qemu-iotests/080     |  2 ++
 tests/qemu-iotests/080.out | 20 ++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index dcb96e2b16..b1828d6fce 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2019,6 +2019,20 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
     /* snapshots */
     for (i = 0; i < s->nb_snapshots; i++) {
         sn = s->snapshots + i;
+        if (offset_into_cluster(s, sn->l1_table_offset)) {
+            fprintf(stderr, "ERROR snapshot %s (%s) l1_offset=%#" PRIx64 ": "
+                    "L1 table is not cluster aligned; snapshot table entry "
+                    "corrupted\n", sn->id_str, sn->name, sn->l1_table_offset);
+            res->corruptions++;
+            continue;
+        }
+        if (sn->l1_size > QCOW_MAX_L1_SIZE / sizeof(uint64_t)) {
+            fprintf(stderr, "ERROR snapshot %s (%s) l1_size=%#" PRIx32 ": "
+                    "L1 table is too large; snapshot table entry corrupted\n",
+                    sn->id_str, sn->name, sn->l1_size);
+            res->corruptions++;
+            continue;
+        }
         ret = check_refcounts_l1(bs, res, refcount_table, nb_clusters,
                                  sn->l1_table_offset, sn->l1_size, 0, fix);
         if (ret < 0) {
diff --git a/tests/qemu-iotests/080 b/tests/qemu-iotests/080
index f8e7d6f4df..4dbe68e950 100755
--- a/tests/qemu-iotests/080
+++ b/tests/qemu-iotests/080
@@ -182,6 +182,7 @@ poke_file "$TEST_IMG" "$offset_snap1_l1_offset" "\x00\x00\x00\x00\x00\x40\x02\x0
            -c 'write 0 4k'; } 2>&1 | _filter_qemu_io | _filter_testdir
 { $QEMU_IMG snapshot -a test $TEST_IMG; } 2>&1 | _filter_testdir
 { $QEMU_IMG snapshot -d test $TEST_IMG; } 2>&1 | _filter_testdir
+_check_test_img
 
 echo
 echo "== Invalid snapshot L1 table size =="
@@ -195,6 +196,7 @@ poke_file "$TEST_IMG" "$offset_snap1_l1_size" "\x10\x00\x00\x00"
            -c 'write 0 4k'; } 2>&1 | _filter_qemu_io | _filter_testdir
 { $QEMU_IMG snapshot -a test $TEST_IMG; } 2>&1 | _filter_testdir
 { $QEMU_IMG snapshot -d test $TEST_IMG; } 2>&1 | _filter_testdir
+_check_test_img
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index f16fd59053..2dad7f46a0 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -69,6 +69,16 @@ Failed to flush the refcount block cache: Invalid argument
 write failed: Invalid argument
 qemu-img: Could not apply snapshot 'test': Failed to load snapshot: Invalid argument
 qemu-img: Could not delete snapshot 'test': Snapshot L1 table offset invalid
+ERROR snapshot 1 (test) l1_offset=0x400200: L1 table is not cluster aligned; snapshot table entry corrupted
+Leaked cluster 4 refcount=2 reference=1
+Leaked cluster 5 refcount=2 reference=1
+Leaked cluster 6 refcount=1 reference=0
+
+1 errors were found on the image.
+Data may be corrupted, or further writes to the image may corrupt it.
+
+3 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 
 == Invalid snapshot L1 table size ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
@@ -80,4 +90,14 @@ Failed to flush the refcount block cache: File too large
 write failed: File too large
 qemu-img: Could not apply snapshot 'test': Failed to load snapshot: File too large
 qemu-img: Could not delete snapshot 'test': Snapshot L1 table too large
+ERROR snapshot 1 (test) l1_size=0x10000000: L1 table is too large; snapshot table entry corrupted
+Leaked cluster 4 refcount=2 reference=1
+Leaked cluster 5 refcount=2 reference=1
+Leaked cluster 6 refcount=1 reference=0
+
+1 errors were found on the image.
+Data may be corrupted, or further writes to the image may corrupt it.
+
+3 leaked clusters were found on the image.
+This means waste of disk space, but no harm to data.
 *** done
-- 
2.11.0
