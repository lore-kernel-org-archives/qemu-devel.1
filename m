Received: from eggs.gnu.org ([2001:4830:134:3::10]:34908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqdly-0004Jx-EW
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fqdlx-0004YF-L9
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:22:34 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 17 Aug 2018 15:22:18 +0300
Message-Id: <20180817122219.16206-7-vsementsov@virtuozzo.com>
In-Reply-To: <20180817122219.16206-1-vsementsov@virtuozzo.com>
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 6/7] block/qcow2-refcount: fix out-of-file
 L1 entries to be zero
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

Zero out corrupted L1 table entry, which reference L2 table out of
underlying file.
Zero L1 table entry means that "the L2 table and all clusters described
by this L2 table are unallocated."

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-refcount.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index d9c8cd666b..3c004e5bfe 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1647,6 +1647,29 @@ static int fix_l2_entry_to_zero(BlockDriverState *bs, BdrvCheckResult *res,
     return ret;
 }
 
+/* Zero out L1 entry
+ *
+ * Returns: -errno if overlap check failed
+ *          0 if write failed
+ *          1 on success
+ */
+static int fix_l1_entry_to_zero(BlockDriverState *bs, BdrvCheckResult *res,
+                                BdrvCheckMode fix, int64_t l1_offset,
+                                int l1_index, bool active,
+                                const char *fmt, ...)
+{
+    int ret;
+    int ign = active ? QCOW2_OL_ACTIVE_L2 : QCOW2_OL_INACTIVE_L2;
+    va_list args;
+
+    va_start(args, fmt);
+    ret = fix_table_entry(bs, res, fix, "L1", l1_offset, l1_index, 0, ign,
+                          fmt, args);
+    va_end(args);
+
+    return ret;
+}
+
 /*
  * Increases the refcount in the given refcount table for the all clusters
  * referenced in the L2 table. While doing so, performs some checks on L2
@@ -1808,6 +1831,7 @@ static int check_refcounts_l1(BlockDriverState *bs,
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t *l1_table = NULL, l2_offset, l1_size2;
+    int64_t file_len;
     int i, ret;
 
     l1_size2 = l1_size * sizeof(uint64_t);
@@ -1837,12 +1861,32 @@ static int check_refcounts_l1(BlockDriverState *bs,
             be64_to_cpus(&l1_table[i]);
     }
 
+    file_len = bdrv_getlength(bs->file->bs);
+    if (file_len < 0) {
+        ret = file_len;
+        goto fail;
+    }
+
     /* Do the actual checks */
     for(i = 0; i < l1_size; i++) {
         l2_offset = l1_table[i];
         if (l2_offset) {
             /* Mark L2 table as used */
             l2_offset &= L1E_OFFSET_MASK;
+            if (l2_offset >= file_len) {
+                ret = fix_l1_entry_to_zero(
+                        bs, res, fix, l1_table_offset, i, active,
+                        "l2 table offset out of file: offset 0x%" PRIx64,
+                        l2_offset);
+                if (ret < 0) {
+                    /* Something is seriously wrong, so abort checking
+                     * this L1 table */
+                    goto fail;
+                }
+
+                continue;
+            }
+
             ret = qcow2_inc_refcounts_imrt(bs, res,
                                            refcount_table, refcount_table_size,
                                            l2_offset, s->cluster_size);
-- 
2.11.1
