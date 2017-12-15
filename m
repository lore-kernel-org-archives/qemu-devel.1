Received: from eggs.gnu.org ([2001:4830:134:3::10]:55414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVF-0000WY-EE
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003Gy-4z
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:13 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:51 +0100
Message-Id: <6884a0a3917beeb854eede711b0d88acb0960ff5.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 23/32] qcow2: Update zero_single_l2() to
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

zero_single_l2() limits the number of clusters to be zeroed to the
amount that fits inside an L2 table. Since we'll be loading L2 slices
instead of full tables we need to update that limit.

Apart from that, this function doesn't need any additional changes, so
this patch simply updates the variable name from l2_table to l2_slice.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 3be8478c75..8f7a04ba7d 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1761,33 +1761,33 @@ fail:
 
 /*
  * This zeroes as many clusters of nb_clusters as possible at once (i.e.
- * all clusters in the same L2 table) and returns the number of zeroed
+ * all clusters in the same L2 slice) and returns the number of zeroed
  * clusters.
  */
 static int zero_single_l2(BlockDriverState *bs, uint64_t offset,
                           uint64_t nb_clusters, int flags)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t *l2_table;
+    uint64_t *l2_slice;
     int l2_index;
     int ret;
     int i;
     bool unmap = !!(flags & BDRV_REQ_MAY_UNMAP);
 
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
         uint64_t old_offset;
         QCow2ClusterType cluster_type;
 
-        old_offset = be64_to_cpu(l2_table[l2_index + i]);
+        old_offset = be64_to_cpu(l2_slice[l2_index + i]);
 
         /*
          * Minimize L2 changes if the cluster already reads back as
@@ -1799,16 +1799,16 @@ static int zero_single_l2(BlockDriverState *bs, uint64_t offset,
             continue;
         }
 
-        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
+        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
         if (cluster_type == QCOW2_CLUSTER_COMPRESSED || unmap) {
-            l2_table[l2_index + i] = cpu_to_be64(QCOW_OFLAG_ZERO);
+            l2_slice[l2_index + i] = cpu_to_be64(QCOW_OFLAG_ZERO);
             qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_REQUEST);
         } else {
-            l2_table[l2_index + i] |= cpu_to_be64(QCOW_OFLAG_ZERO);
+            l2_slice[l2_index + i] |= cpu_to_be64(QCOW_OFLAG_ZERO);
         }
     }
 
-    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
     return nb_clusters;
 }
-- 
2.11.0
