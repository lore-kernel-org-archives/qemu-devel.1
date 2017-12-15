Received: from eggs.gnu.org ([2001:4830:134:3::10]:55380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVE-0000WP-E5
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003Gi-54
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:12 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:50 +0100
Message-Id: <8f5a1687d5999f3eecb989dd25b57144cc850b28.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 22/32] qcow2: Update discard_single_l2() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

discard_single_l2() limits the number of clusters to be discarded to
the amount that fits inside an L2 table. Since we'll be loading L2
slices instead of full tables we need to update that limit.

Apart from that, this function doesn't need any additional changes, so
this patch simply updates the variable name from l2_table to l2_slice.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 0d126581bd..3be8478c75 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1640,7 +1640,7 @@ int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset)
 
 /*
  * This discards as many clusters of nb_clusters as possible at once (i.e.
- * all clusters in the same L2 table) and returns the number of discarded
+ * all clusters in the same L2 slice) and returns the number of discarded
  * clusters.
  */
 static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
@@ -1648,24 +1648,24 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
                              bool full_discard)
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
@@ -1703,18 +1703,18 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
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
-- 
2.11.0
