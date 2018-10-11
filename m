Received: from eggs.gnu.org ([2001:4830:134:3::10]:59615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAchX-0006am-Vn
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gAchU-0006hF-Lv
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 11:16:35 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 11 Oct 2018 18:16:21 +0300
Message-Id: <20181011151623.25702-7-vsementsov@virtuozzo.com>
In-Reply-To: <20181011151623.25702-1-vsementsov@virtuozzo.com>
References: <20181011151623.25702-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 6/8] block/qcow2-refcount: refactor fixing
 L2 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Split entry repairing to separate function, to be reused later in
check_refcounts_l2, prepare the whole pipeline for adding more
corruption types which may be repaired.

Note: entry in in-memory l2 table (local variable in
check_refcounts_l2) is not updated after this patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 234 ++++++++++++++++++++++++++---------------
 1 file changed, 148 insertions(+), 86 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 3b34681f16..65e0fd2de3 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1558,6 +1558,63 @@ enum {
     CHECK_FRAG_INFO = 0x2,      /* update BlockFragInfo counters */
 };
 
+typedef enum {
+    REP_ACTIVE_L1,
+    REP_INACTIVE_L1,
+    REP_ACTIVE_L2,
+    REP_INACTIVE_L2
+} RepTableType;
+
+/* repair_table_entry
+ *
+ * Rewrite entry in L1 or L2 table and set @res appropriately.
+ *
+ * Returns: -errno if overlap check failed
+ *          0 if write failed
+ *          1 on success
+ */
+static int repair_table_entry(BlockDriverState *bs, BdrvCheckResult *res,
+                              RepTableType type, uint64_t table_offset,
+                              int entry_index, uint64_t new_val)
+{
+    int ret;
+    uint64_t entry_offset =
+            table_offset + (uint64_t)entry_index * sizeof(new_val);
+
+    static const struct {
+        const char *name;
+        int ign;
+    } types[] = {
+        [REP_ACTIVE_L1] = { "L1", QCOW2_OL_ACTIVE_L1 },
+        [REP_INACTIVE_L1] = { "L1", QCOW2_OL_INACTIVE_L1 },
+        [REP_ACTIVE_L2] = { "L2", QCOW2_OL_ACTIVE_L1 },
+        [REP_INACTIVE_L2] = { "L2", QCOW2_OL_INACTIVE_L1 },
+    };
+
+    cpu_to_be64s(&new_val);
+    ret = qcow2_pre_write_overlap_check(bs, types[type].ign, entry_offset,
+                                        sizeof(new_val));
+    if (ret < 0) {
+        res->check_errors++;
+        fprintf(stderr,
+                "ERROR: Cannot write %s table entry: "
+                "overlap check failed: %s\n",
+                types[type].name, strerror(-ret));
+        return ret;
+    }
+
+    ret = bdrv_pwrite_sync(bs->file, entry_offset, &new_val, sizeof(new_val));
+    if (ret < 0) {
+        res->check_errors++;
+        fprintf(stderr, "ERROR: Failed to overwrite %s table entry: %s\n",
+                types[type].name, strerror(-ret));
+        return 0;
+    }
+
+    res->corruptions_fixed++;
+    return 1;
+}
+
 /*
  * Increases the refcount in the given refcount table for the all clusters
  * referenced in the L2 table. While doing so, performs some checks on L2
@@ -1572,9 +1629,11 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                               int flags, BdrvCheckMode fix, bool active)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t *l2_table, l2_entry;
+    uint64_t *l2_table;
     uint64_t next_contiguous_offset = 0;
     int i, l2_size, ret;
+    bool fix_er = fix & BDRV_FIX_ERRORS;
+    RepTableType type = active ? REP_ACTIVE_L2 : REP_INACTIVE_L2;
 
     /* Read L2 table from disk */
     l2_size = s->l2_size * sizeof(uint64_t);
@@ -1589,13 +1648,17 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
 
     /* Do the actual checks */
     for(i = 0; i < s->l2_size; i++) {
-        l2_entry = be64_to_cpu(l2_table[i]);
-
-        switch (qcow2_get_cluster_type(l2_entry)) {
+        uint64_t l2_entry = be64_to_cpu(l2_table[i]);
+        uint64_t l2_entry_fix = l2_entry;
+        QCow2ClusterType entry_type = qcow2_get_cluster_type(l2_entry);
+        int64_t offset, size;
+        bool fatal = false; /* l2_entry is fatally corrupted, don't count it if
+                                fail to fix */
+
+        /* check for errors: either increase res->corruptions or set
+         * @l2_entry_fix to something other */
+        switch (entry_type) {
         case QCOW2_CLUSTER_COMPRESSED:
-        {
-            int64_t csize, coffset;
-
             /* Compressed clusters don't have QCOW_OFLAG_COPIED */
             if (l2_entry & QCOW_OFLAG_COPIED) {
                 fprintf(stderr, "ERROR: coffset=0x%" PRIx64 ": "
@@ -1605,113 +1668,112 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                 res->corruptions++;
             }
 
-            /* Mark cluster as used */
-            csize = (((l2_entry >> s->csize_shift) & s->csize_mask) + 1) * 512;
-            coffset = l2_entry & s->cluster_offset_mask & ~511;
-            ret = qcow2_inc_refcounts_imrt(bs, res,
-                                           refcount_table, refcount_table_size,
-                                           coffset, csize);
-            if (ret < 0) {
-                goto fail;
-            }
-
-            if (flags & CHECK_FRAG_INFO) {
-                res->bfi.allocated_clusters++;
-                res->bfi.compressed_clusters++;
-
-                /* Compressed clusters are fragmented by nature.  Since they
-                 * take up sub-sector space but we only have sector granularity
-                 * I/O we need to re-read the same sectors even for adjacent
-                 * compressed clusters.
-                 */
-                res->bfi.fragmented_clusters++;
-            }
+            offset = l2_entry & s->cluster_offset_mask & ~511;
+            size = (((l2_entry >> s->csize_shift) & s->csize_mask) + 1) * 512;
             break;
-        }
 
         case QCOW2_CLUSTER_ZERO_ALLOC:
         case QCOW2_CLUSTER_NORMAL:
-        {
-            uint64_t offset = l2_entry & L2E_OFFSET_MASK;
+            offset = l2_entry & L2E_OFFSET_MASK;
+            size = s->cluster_size;
 
             /* Correct offsets are cluster aligned */
             if (offset_into_cluster(s, offset)) {
+                fatal = true; /* misaligned cluster leads to
+                               * qcow2_signal_corruption(fatal = true)
+                               */
                 if (qcow2_get_cluster_type(l2_entry) ==
                     QCOW2_CLUSTER_ZERO_ALLOC)
                 {
                     fprintf(stderr, "%s offset=%" PRIx64 ": Preallocated zero "
                             "cluster is not properly aligned; L2 entry "
                             "corrupted.\n",
-                            fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR",
-                            offset);
-                    if (fix & BDRV_FIX_ERRORS) {
-                        uint64_t l2e_offset =
-                            l2_offset + (uint64_t)i * sizeof(uint64_t);
-                        int ign = active ? QCOW2_OL_ACTIVE_L2 :
-                                           QCOW2_OL_INACTIVE_L2;
-
-                        l2_entry = QCOW_OFLAG_ZERO;
-                        l2_table[i] = cpu_to_be64(l2_entry);
-                        ret = qcow2_pre_write_overlap_check(bs, ign,
-                                l2e_offset, sizeof(uint64_t));
-                        if (ret < 0) {
-                            fprintf(stderr, "ERROR: Overlap check failed\n");
-                            res->check_errors++;
-                            /* Something is seriously wrong, so abort checking
-                             * this L2 table */
-                            goto fail;
-                        }
-
-                        ret = bdrv_pwrite_sync(bs->file, l2e_offset,
-                                               &l2_table[i], sizeof(uint64_t));
-                        if (ret < 0) {
-                            fprintf(stderr, "ERROR: Failed to overwrite L2 "
-                                    "table entry: %s\n", strerror(-ret));
-                            res->check_errors++;
-                            /* Do not abort, continue checking the rest of this
-                             * L2 table's entries */
-                        } else {
-                            res->corruptions_fixed++;
-                        }
-                    } else {
-                        res->corruptions++;
-                    }
+                            fix_er ? "Repairing" : "ERROR", offset);
+                    l2_entry_fix = QCOW_OFLAG_ZERO;
                 } else {
                     fprintf(stderr, "ERROR offset=%" PRIx64 ": Data cluster is "
                         "not properly aligned; L2 entry corrupted.\n", offset);
                     res->corruptions++;
                 }
+            }
 
-                /* Skip marking the cluster as used
-                 * (l2 entry is marked as zero or still fatally corrupted) */
-                continue;
+            break;
+
+        case QCOW2_CLUSTER_ZERO_PLAIN:
+        case QCOW2_CLUSTER_UNALLOCATED:
+            /* No allocation to be counted */
+            continue;
+
+        default:
+            abort();
+        }
+
+        /* handle found errors */
+        if (l2_entry_fix != l2_entry) {
+            if (fix_er) {
+                ret = repair_table_entry(bs, res, type,
+                                         l2_offset, i, l2_entry_fix);
+                if (ret < 0) {
+                    /* Something is seriously wrong, so abort checking
+                     * this L2 table */
+                    goto fail;
+                } else if (ret == 1) {
+                    /* successfully fixed */
+                    l2_entry = l2_entry_fix;
+                    entry_type = qcow2_get_cluster_type(l2_entry);
+                    fatal = false;
+                }
+            } else {
+                res->corruptions++;
             }
+        }
+        if (fatal || entry_type == QCOW2_CLUSTER_ZERO_PLAIN ||
+            entry_type == QCOW2_CLUSTER_ZERO_PLAIN)
+        {
+            /* entry is either:
+             *   fatally corrupted, and we did not fix it,
+             *   we can't count it like normal entry
+             * or:
+             *   successfully fixed to be zero/unallocated,
+             *   we should not count it.
+             */
+            continue;
+        }
+
+        ret = qcow2_inc_refcounts_imrt(bs, res,
+                                       refcount_table, refcount_table_size,
+                                       offset, size);
+        if (ret < 0) {
+            goto fail;
+        }
+
+        /* update counters */
+        if (flags & CHECK_FRAG_INFO) {
+            res->bfi.allocated_clusters++;
+            switch (entry_type) {
+            case QCOW2_CLUSTER_COMPRESSED:
+                res->bfi.compressed_clusters++;
 
-            if (flags & CHECK_FRAG_INFO) {
-                res->bfi.allocated_clusters++;
+                /* Compressed clusters are fragmented by nature.  Since they
+                 * take up sub-sector space but we only have sector granularity
+                 * I/O we need to re-read the same sectors even for adjacent
+                 * compressed clusters.
+                 */
+                res->bfi.fragmented_clusters++;
+                break;
+
+            case QCOW2_CLUSTER_ZERO_ALLOC:
+            case QCOW2_CLUSTER_NORMAL:
                 if (next_contiguous_offset &&
                     offset != next_contiguous_offset) {
                     res->bfi.fragmented_clusters++;
                 }
                 next_contiguous_offset = offset + s->cluster_size;
-            }
+                break;
 
-            /* Mark cluster as used */
-            ret = qcow2_inc_refcounts_imrt(bs, res,
-                                           refcount_table, refcount_table_size,
-                                           offset, s->cluster_size);
-            if (ret < 0) {
-                goto fail;
+            default:
+                abort();
             }
-            break;
-        }
-
-        case QCOW2_CLUSTER_ZERO_PLAIN:
-        case QCOW2_CLUSTER_UNALLOCATED:
-            break;
-
-        default:
-            abort();
         }
     }
 
-- 
2.18.0
