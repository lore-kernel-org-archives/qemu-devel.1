Received: from eggs.gnu.org ([2001:4830:134:3::10]:34579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv4Yw-0001Pg-8x
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv4Yu-0000XS-OU
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 12:10:38 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 18:09:33 +0200
Message-Id: <20170403160936.28293-14-mreitz@redhat.com>
In-Reply-To: <20170403160936.28293-1-mreitz@redhat.com>
References: <20170403160936.28293-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 13/16] block/qcow2:
 qcow2_calc_size_usage() for truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This patch extends qcow2_calc_size_usage() so it can calculate the
additional space needed for preallocating image growth.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 137 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 98 insertions(+), 39 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index aafbc8dbed..12dafcc570 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2108,7 +2108,15 @@ done:
     return ret;
 }
 
-static uint64_t qcow2_calc_size_usage(uint64_t new_size,
+/**
+ * Returns the number of bytes that must be allocated in the underlying file
+ * to accomodate an image growth from @current_size to @new_size.
+ *
+ * @current_size must be 0 when creating a new image. In that case, @bs is
+ * ignored; otherwise it must be valid.
+ */
+static uint64_t qcow2_calc_size_usage(BlockDriverState *bs,
+                                      uint64_t current_size, uint64_t new_size,
                                       int cluster_bits, int refcount_order)
 {
     size_t cluster_size = 1u << cluster_bits;
@@ -2129,47 +2137,97 @@ static uint64_t qcow2_calc_size_usage(uint64_t new_size,
     refblock_bits = cluster_bits - (refcount_order - 3);
     refblock_size = 1 << refblock_bits;
 
-    /* header: 1 cluster */
-    meta_size += cluster_size;
-
-    /* total size of L2 tables */
-    nl2e = aligned_total_size / cluster_size;
-    nl2e = align_offset(nl2e, cluster_size / sizeof(uint64_t));
-    meta_size += nl2e * sizeof(uint64_t);
+    if (!current_size) {
+        /* header: 1 cluster */
+        meta_size += cluster_size;
+
+        /* total size of L2 tables */
+        nl2e = aligned_total_size / cluster_size;
+        nl2e = align_offset(nl2e, cluster_size / sizeof(uint64_t));
+        meta_size += nl2e * sizeof(uint64_t);
+
+        /* total size of L1 tables */
+        nl1e = nl2e * sizeof(uint64_t) / cluster_size;
+        nl1e = align_offset(nl1e, cluster_size / sizeof(uint64_t));
+        meta_size += nl1e * sizeof(uint64_t);
+
+        /* total size of refcount blocks
+         *
+         * note: every host cluster is reference-counted, including metadata
+         * (even refcount blocks are recursively included).
+         * Let:
+         *   a = total_size (this is the guest disk size)
+         *   m = meta size not including refcount blocks and refcount tables
+         *   c = cluster size
+         *   y1 = number of refcount blocks entries
+         *   y2 = meta size including everything
+         *   rces = refcount entry size in bytes
+         * then,
+         *   y1 = (y2 + a)/c
+         *   y2 = y1 * rces + y1 * rces * sizeof(u64) / c + m
+         * we can get y1:
+         *   y1 = (a + m) / (c - rces - rces * sizeof(u64) / c)
+         */
+        nrefblocke = (aligned_total_size + meta_size + cluster_size)
+                   / (cluster_size - rces - rces * sizeof(uint64_t)
+                                                 / cluster_size);
+        meta_size += DIV_ROUND_UP(nrefblocke, refblock_size) * cluster_size;
 
-    /* total size of L1 tables */
-    nl1e = nl2e * sizeof(uint64_t) / cluster_size;
-    nl1e = align_offset(nl1e, cluster_size / sizeof(uint64_t));
-    meta_size += nl1e * sizeof(uint64_t);
+        /* total size of refcount tables */
+        nreftablee = nrefblocke / refblock_size;
+        nreftablee = align_offset(nreftablee, cluster_size / sizeof(uint64_t));
+        meta_size += nreftablee * sizeof(uint64_t);
 
-    /* total size of refcount blocks
-     *
-     * note: every host cluster is reference-counted, including metadata
-     * (even refcount blocks are recursively included).
-     * Let:
-     *   a = total_size (this is the guest disk size)
-     *   m = meta size not including refcount blocks and refcount tables
-     *   c = cluster size
-     *   y1 = number of refcount blocks entries
-     *   y2 = meta size including everything
-     *   rces = refcount entry size in bytes
-     * then,
-     *   y1 = (y2 + a)/c
-     *   y2 = y1 * rces + y1 * rces * sizeof(u64) / c + m
-     * we can get y1:
-     *   y1 = (a + m) / (c - rces - rces * sizeof(u64) / c)
-     */
-    nrefblocke = (aligned_total_size + meta_size + cluster_size)
-               / (cluster_size - rces - rces * sizeof(uint64_t)
-                                             / cluster_size);
-    meta_size += DIV_ROUND_UP(nrefblocke, refblock_size) * cluster_size;
+        return aligned_total_size + meta_size;
+    } else {
+        BDRVQcow2State *s = bs->opaque;
+        uint64_t aligned_cur_size = align_offset(current_size, cluster_size);
+        uint64_t creftable_length;
+        uint64_t i;
+
+        /* new total size of L2 tables */
+        nl2e = aligned_total_size / cluster_size;
+        nl2e = align_offset(nl2e, cluster_size / sizeof(uint64_t));
+        meta_size += nl2e * sizeof(uint64_t);
+
+        /* Subtract L2 tables which are already present */
+        for (i = 0; i < s->l1_size; i++) {
+            if (s->l1_table[i] & L1E_OFFSET_MASK) {
+                meta_size -= cluster_size;
+            }
+        }
 
-    /* total size of refcount tables */
-    nreftablee = nrefblocke / refblock_size;
-    nreftablee = align_offset(nreftablee, cluster_size / sizeof(uint64_t));
-    meta_size += nreftablee * sizeof(uint64_t);
+        /* Do not add L1 table size because the only caller of this path
+         * (qcow2_truncate) has increased its size already. */
 
-    return aligned_total_size + meta_size;
+        /* Calculate size of the additional refblocks (this assumes that all of
+         * the existing image is covered by refblocks, which is extremely
+         * likely); this may result in overallocation because parts of the newly
+         * added space may be covered by existing refblocks, but that is fine.
+         *
+         * This only considers the newly added space. Since we cannot update the
+         * reftable in-place, we will have to able to store both the old and the
+         * new one at the same time, though. Therefore, we need to add the size
+         * of the old reftable here.
+         */
+        creftable_length = ROUND_UP(s->refcount_table_size * sizeof(uint64_t),
+                                    cluster_size);
+        nrefblocke = ((aligned_total_size - aligned_cur_size) + meta_size +
+                      creftable_length + cluster_size)
+                   / (cluster_size - rces -
+                      rces * sizeof(uint64_t) / cluster_size);
+        meta_size += DIV_ROUND_UP(nrefblocke, refblock_size) * cluster_size;
+
+        /* total size of the new refcount table (again, may be too much because
+         * it assumes that the new area is not covered by any refcount blocks
+         * yet) */
+        nreftablee = s->max_refcount_table_index + 1 +
+                     nrefblocke / refblock_size;
+        nreftablee = align_offset(nreftablee, cluster_size / sizeof(uint64_t));
+        meta_size += nreftablee * sizeof(uint64_t);
+
+        return (aligned_total_size - aligned_cur_size) + meta_size;
+    }
 }
 
 static int qcow2_create2(const char *filename, int64_t total_size,
@@ -2210,7 +2268,8 @@ static int qcow2_create2(const char *filename, int64_t total_size,
     int ret;
 
     if (prealloc == PREALLOC_MODE_FULL || prealloc == PREALLOC_MODE_FALLOC) {
-        uint64_t file_size = qcow2_calc_size_usage(total_size, cluster_bits,
+        uint64_t file_size = qcow2_calc_size_usage(NULL, 0, total_size,
+                                                   cluster_bits,
                                                    refcount_order);
 
         qemu_opt_set_number(opts, BLOCK_OPT_SIZE, file_size, &error_abort);
-- 
2.12.1
