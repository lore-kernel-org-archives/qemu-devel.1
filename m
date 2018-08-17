Received: from eggs.gnu.org ([2001:4830:134:3::10]:34837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqdlw-0004J9-JX
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqdlv-0004W1-LH
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:22:32 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 17 Aug 2018 15:22:17 +0300
Message-Id: <20180817122219.16206-6-vsementsov@virtuozzo.com>
In-Reply-To: <20180817122219.16206-1-vsementsov@virtuozzo.com>
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 5/7] block/qcow2-refcount:
 check_refcounts_l2: split fix_l2_entry_to_zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Split entry repairing to separate function, to be reused later.

Note: entry in in-memory l2 table (local variable in
check_refcounts_l2) is not updated after this patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 147 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 109 insertions(+), 38 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 3b057b635d..d9c8cd666b 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1554,6 +1554,99 @@ enum {
     CHECK_FRAG_INFO = 0x2,      /* update BlockFragInfo counters */
 };
 
+/* Update entry in L1 or L2 table
+ *
+ * Returns: -errno if overlap check failed
+ *          0 if write failed
+ *          1 on success
+ */
+static int write_table_entry(BlockDriverState *bs, const char *table_name,
+                             uint64_t table_offset, int entry_index,
+                             uint64_t new_val, int ign)
+{
+    int ret;
+    uint64_t entry_offset =
+            table_offset + (uint64_t)entry_index * sizeof(new_val);
+
+    cpu_to_be64s(&new_val);
+    ret = qcow2_pre_write_overlap_check(bs, ign, entry_offset, sizeof(new_val));
+    if (ret < 0) {
+        fprintf(stderr,
+                "ERROR: Can't write %s table entry: overlap check failed: %s\n",
+                table_name, strerror(-ret));
+        return ret;
+    }
+
+    ret = bdrv_pwrite_sync(bs->file, entry_offset, &new_val, sizeof(new_val));
+    if (ret < 0) {
+        fprintf(stderr, "ERROR: Failed to overwrite %s table entry: %s\n",
+                table_name, strerror(-ret));
+        return 0;
+    }
+
+    return 1;
+}
+
+/* Try to fix (if allowed) entry in L1 or L2 table. Update @res correspondingly.
+ *
+ * Returns: -errno if overlap check failed
+ *          0 if entry was not updated for other reason
+ *            (fixing disabled or write failed)
+ *          1 on success
+ */
+static int fix_table_entry(BlockDriverState *bs, BdrvCheckResult *res,
+                           BdrvCheckMode fix, const char *table_name,
+                           uint64_t table_offset, int entry_index,
+                           uint64_t new_val, int ign,
+                           const char *fmt, va_list args)
+{
+    int ret;
+
+    fprintf(stderr, fix & BDRV_FIX_ERRORS ? "Repairing: " : "ERROR: ");
+    vfprintf(stderr, fmt, args);
+    fprintf(stderr, "\n");
+
+    if (!(fix & BDRV_FIX_ERRORS)) {
+        res->corruptions++;
+        return 0;
+    }
+
+    ret = write_table_entry(bs, table_name, table_offset, entry_index, new_val,
+                            ign);
+
+    if (ret == 1) {
+        res->corruptions_fixed++;
+    } else {
+        res->check_errors++;
+    }
+
+    return ret;
+}
+
+/* Make L2 entry to be QCOW2_CLUSTER_ZERO_PLAIN
+ *
+ * Returns: -errno if overlap check failed
+ *          0 if write failed
+ *          1 on success
+ */
+static int fix_l2_entry_to_zero(BlockDriverState *bs, BdrvCheckResult *res,
+                                BdrvCheckMode fix, int64_t l2_offset,
+                                int l2_index, bool active,
+                                const char *fmt, ...)
+{
+    int ret;
+    int ign = active ? QCOW2_OL_ACTIVE_L2 : QCOW2_OL_INACTIVE_L2;
+    uint64_t l2_entry = QCOW_OFLAG_ZERO;
+    va_list args;
+
+    va_start(args, fmt);
+    ret = fix_table_entry(bs, res, fix, "L2", l2_offset, l2_index, l2_entry,
+                          ign, fmt, args);
+    va_end(args);
+
+    return ret;
+}
+
 /*
  * Increases the refcount in the given refcount table for the all clusters
  * referenced in the L2 table. While doing so, performs some checks on L2
@@ -1646,46 +1739,24 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                 if (qcow2_get_cluster_type(l2_entry) ==
                     QCOW2_CLUSTER_ZERO_ALLOC)
                 {
-                    fprintf(stderr, "%s offset=%" PRIx64 ": Preallocated zero "
-                            "cluster is not properly aligned; L2 entry "
-                            "corrupted.\n",
-                            fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR",
+                    ret = fix_l2_entry_to_zero(
+                            bs, res, fix, l2_offset, i, active,
+                            "offset=%" PRIx64 ": Preallocated zero cluster is "
+                            "not properly aligned; L2 entry corrupted.",
                             offset);
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
-                            /* Skip marking the cluster as used
-                             * (it is unused now) */
-                            continue;
-                        }
-                    } else {
-                        res->corruptions++;
+                    if (ret < 0) {
+                        /* Something is seriously wrong, so abort checking
+                         * this L2 table */
+                        goto fail;
+                    }
+                    if (ret == 1) {
+                        /* Skip marking the cluster as used
+                         * (it is unused now) */
+                        continue;
                     }
+                    /* Entry was not updated, but do not abort, mark cluster
+                     * as used and continue checking the rest of this L2
+                     * table's entries */
                 } else {
                     fprintf(stderr, "ERROR offset=%" PRIx64 ": Data cluster is "
                         "not properly aligned; L2 entry corrupted.\n", offset);
-- 
2.11.1
