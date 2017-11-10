Received: from eggs.gnu.org ([2001:4830:134:3::10]:56912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDG4A-0006oP-5j
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:38:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDG46-0007jT-Vp
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:38:18 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Nov 2017 21:37:59 +0100
Message-Id: <20171110203759.14018-2-mreitz@redhat.com>
In-Reply-To: <20171110203759.14018-1-mreitz@redhat.com>
References: <20171110203759.14018-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 1/1] qcow2: Repair unaligned
 preallocated zero clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, John Snow <jsnow@redhat.com>

We can easily repair unaligned preallocated zero clusters by discarding
them, so why not do it?

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-refcount.c     | 70 ++++++++++++++++++++++++++++++++++++++--------
 tests/qemu-iotests/060     |  3 +-
 tests/qemu-iotests/060.out |  9 ++++++
 3 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 3de1ab51ba..92701ab7af 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1508,7 +1508,7 @@ enum {
 static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                               void **refcount_table,
                               int64_t *refcount_table_size, int64_t l2_offset,
-                              int flags)
+                              int flags, BdrvCheckMode fix)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t *l2_table, l2_entry;
@@ -1579,6 +1579,57 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                 next_contiguous_offset = offset + s->cluster_size;
             }
 
+            /* Correct offsets are cluster aligned */
+            if (offset_into_cluster(s, offset)) {
+                if (qcow2_get_cluster_type(l2_entry) ==
+                    QCOW2_CLUSTER_ZERO_ALLOC)
+                {
+                    fprintf(stderr, "%s offset=%" PRIx64 ": Preallocated zero "
+                            "cluster is not properly aligned; L2 entry "
+                            "corrupted.\n",
+                            fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR",
+                            offset);
+                    if (fix & BDRV_FIX_ERRORS) {
+                        uint64_t l2e_offset =
+                            l2_offset + (uint64_t)i * sizeof(uint64_t);
+
+                        l2_entry = QCOW_OFLAG_ZERO;
+                        l2_table[i] = cpu_to_be64(l2_entry);
+                        ret = qcow2_pre_write_overlap_check(bs,
+                                QCOW2_OL_ACTIVE_L2 | QCOW2_OL_INACTIVE_L2,
+                                l2e_offset, sizeof(uint64_t));
+                        if (ret < 0) {
+                            fprintf(stderr, "ERROR: Overlap check failed\n");
+                            res->check_errors++;
+                            /* Something is seriously wrong, so abort checking
+                             * this L2 table */
+                            goto fail;
+                        }
+
+                        ret = bdrv_pwrite_sync(bs->file, l2e_offset,
+                                               &l2_table[i], sizeof(uint64_t));
+                        if (ret < 0) {
+                            fprintf(stderr, "ERROR: Failed to overwrite L2 "
+                                    "table entry: %s\n", strerror(-ret));
+                            res->check_errors++;
+                            /* Do not abort, continue checking the rest of this
+                             * L2 table's entries */
+                        } else {
+                            res->corruptions_fixed++;
+                            /* Skip marking the cluster as used
+                             * (it is unused now) */
+                            continue;
+                        }
+                    } else {
+                        res->corruptions++;
+                    }
+                } else {
+                    fprintf(stderr, "ERROR offset=%" PRIx64 ": Data cluster is "
+                        "not properly aligned; L2 entry corrupted.\n", offset);
+                    res->corruptions++;
+                }
+            }
+
             /* Mark cluster as used */
             ret = qcow2_inc_refcounts_imrt(bs, res,
                                            refcount_table, refcount_table_size,
@@ -1586,13 +1637,6 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
             if (ret < 0) {
                 goto fail;
             }
-
-            /* Correct offsets are cluster aligned */
-            if (offset_into_cluster(s, offset)) {
-                fprintf(stderr, "ERROR offset=%" PRIx64 ": Cluster is not "
-                    "properly aligned; L2 entry corrupted.\n", offset);
-                res->corruptions++;
-            }
             break;
         }
 
@@ -1626,7 +1670,7 @@ static int check_refcounts_l1(BlockDriverState *bs,
                               void **refcount_table,
                               int64_t *refcount_table_size,
                               int64_t l1_table_offset, int l1_size,
-                              int flags)
+                              int flags, BdrvCheckMode fix)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t *l1_table = NULL, l2_offset, l1_size2;
@@ -1681,7 +1725,8 @@ static int check_refcounts_l1(BlockDriverState *bs,
 
             /* Process and check L2 entries */
             ret = check_refcounts_l2(bs, res, refcount_table,
-                                     refcount_table_size, l2_offset, flags);
+                                     refcount_table_size, l2_offset, flags,
+                                     fix);
             if (ret < 0) {
                 goto fail;
             }
@@ -1957,7 +2002,8 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
 
     /* current L1 table */
     ret = check_refcounts_l1(bs, res, refcount_table, nb_clusters,
-                             s->l1_table_offset, s->l1_size, CHECK_FRAG_INFO);
+                             s->l1_table_offset, s->l1_size, CHECK_FRAG_INFO,
+                             fix);
     if (ret < 0) {
         return ret;
     }
@@ -1966,7 +2012,7 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
     for (i = 0; i < s->nb_snapshots; i++) {
         sn = s->snapshots + i;
         ret = check_refcounts_l1(bs, res, refcount_table, nb_clusters,
-                                 sn->l1_table_offset, sn->l1_size, 0);
+                                 sn->l1_table_offset, sn->l1_size, 0, fix);
         if (ret < 0) {
             return ret;
         }
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 1eca09417b..8e4d27a77a 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -335,7 +335,8 @@ poke_file "$TEST_IMG" "$l2_offset" "\x80\x00\x00\x00\x00\x00\x2a\x01"
 # Let's write to it!
 $QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
 
-# Can't repair this yet (TODO: We can just deallocate the cluster)
+echo '--- Repairing ---'
+_check_test_img -r all
 
 echo
 echo '=== Discarding with an unaligned refblock ==='
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 56f5eb15d8..16d5142eed 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -317,6 +317,15 @@ discard 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 qcow2: Marking image as corrupt: Preallocated zero cluster offset 0x2a00 unaligned (guest offset: 0); further corruption events will be suppressed
 write failed: Input/output error
+--- Repairing ---
+Repairing offset=2a00: Preallocated zero cluster is not properly aligned; L2 entry corrupted.
+The following inconsistencies were found and repaired:
+
+    0 leaked clusters
+    1 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
 
 === Discarding with an unaligned refblock ===
 
-- 
2.13.6
