Received: from eggs.gnu.org ([2001:4830:134:3::10]:53078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele2A-0003VA-Pn
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele29-0005i5-3i
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:22 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:05:14 +0100
Message-Id: <20180213170529.10858-41-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 40/55] qcow2: Update discard_single_l2() to
 support L2 slices
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

discard_single_l2() limits the number of clusters to be discarded
to the amount that fits inside an L2 table. Since we'll be loading
L2 slices instead of full tables we need to update that limit. The
function is renamed to discard_in_l2_slice() for clarity.

Apart from that, this function doesn't need any additional changes, so
this patch simply updates the variable name from l2_table to l2_slice.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: 1cb44a5b68be5334cb01b97a3db3a3c5a43396e5.1517840877.git.berto@igalia.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index dbd57cd35f..62336960a5 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1631,32 +1631,32 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
 
 /*
  * This discards as many clusters of nb_clusters as possible at once (i.e.
- * all clusters in the same L2 table) and returns the number of discarded
+ * all clusters in the same L2 slice) and returns the number of discarded
  * clusters.
  */
-static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
-                             uint64_t nb_clusters, enum qcow2_discard_type type,
-                             bool full_discard)
+static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
+                               uint64_t nb_clusters,
+                               enum qcow2_discard_type type, bool full_discard)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t *l2_table;
+    uint64_t *l2_slice;
     int l2_index;
     int ret;
     int i;
 
-    ret = get_cluster_table(bs, offset, &l2_table, &l2_index);
+    ret = get_cluster_table(bs, offset, &l2_slice, &l2_index);
     if (ret < 0) {
         return ret;
     }
 
-    /* Limit nb_clusters to one L2 table */
-    nb_clusters = MIN(nb_clusters, s->l2_size - l2_index);
+    /* Limit nb_clusters to one L2 slice */
+    nb_clusters = MIN(nb_clusters, s->l2_slice_size - l2_index);
     assert(nb_clusters <= INT_MAX);
 
     for (i = 0; i < nb_clusters; i++) {
         uint64_t old_l2_entry;
 
-        old_l2_entry = be64_to_cpu(l2_table[l2_index + i]);
+        old_l2_entry = be64_to_cpu(l2_slice[l2_index + i]);
 
         /*
          * If full_discard is false, make sure that a discarded area reads back
@@ -1694,18 +1694,18 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
         }
 
         /* First remove L2 entries */
-        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
+        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
         if (!full_discard && s->qcow_version >= 3) {
-            l2_table[l2_index + i] = cpu_to_be64(QCOW_OFLAG_ZERO);
+            l2_slice[l2_index + i] = cpu_to_be64(QCOW_OFLAG_ZERO);
         } else {
-            l2_table[l2_index + i] = cpu_to_be64(0);
+            l2_slice[l2_index + i] = cpu_to_be64(0);
         }
 
         /* Then decrease the refcount */
         qcow2_free_any_clusters(bs, old_l2_entry, 1, type);
     }
 
-    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
     return nb_clusters;
 }
@@ -1729,10 +1729,10 @@ int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
 
     s->cache_discards = true;
 
-    /* Each L2 table is handled by its own loop iteration */
+    /* Each L2 slice is handled by its own loop iteration */
     while (nb_clusters > 0) {
-        cleared = discard_single_l2(bs, offset, nb_clusters, type,
-                                    full_discard);
+        cleared = discard_in_l2_slice(bs, offset, nb_clusters, type,
+                                      full_discard);
         if (cleared < 0) {
             ret = cleared;
             goto fail;
-- 
2.13.6
