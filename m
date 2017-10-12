Received: from eggs.gnu.org ([2001:4830:134:3::10]:44052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dHk-0002P7-Kg
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dHh-0004Wy-62
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:12:24 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 12 Oct 2017 16:05:32 +0300
Message-Id: <65c2b2b32a686d3084a1579583334a85b706edcb.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 18/31] qcow2: Update qcow2_get_cluster_offset()
 to support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, Alberto Garcia <berto@igalia.com>

qcow2_get_cluster_offset() checks how many contiguous bytes are
available at a given offset. The returned number of bytes is limited
by the amount that can be addressed without having to load more than
one L2 table.

Since we'll be loading L2 slices instead of full tables this patch
changes the limit accordingly using the size of the L2 slice for the
calculations instead of the full table size.

The l2_table variable is also renamed to l2_slice to reflect this, and
offset_to_l2_index() is replaced with offset_to_l2_slice_index().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 580fb50869..860e56ec7c 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -522,8 +522,8 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
 {
     BDRVQcow2State *s = bs->opaque;
     unsigned int l2_index;
-    uint64_t l1_index, l2_offset, *l2_table;
-    int l1_bits, c;
+    uint64_t l1_index, l2_offset, *l2_slice;
+    int c;
     unsigned int offset_in_cluster;
     uint64_t bytes_available, bytes_needed, nb_clusters;
     QCow2ClusterType type;
@@ -532,12 +532,11 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
     offset_in_cluster = offset_into_cluster(s, offset);
     bytes_needed = (uint64_t) *bytes + offset_in_cluster;
 
-    l1_bits = s->l2_bits + s->cluster_bits;
-
     /* compute how many bytes there are between the start of the cluster
-     * containing offset and the end of the l1 entry */
-    bytes_available = (1ULL << l1_bits) - (offset & ((1ULL << l1_bits) - 1))
-                    + offset_in_cluster;
+     * containing offset and the end of the l2 slice that contains
+     * the entry pointing to it */
+    bytes_available = (s->l2_slice_size - offset_to_l2_slice_index(s, offset))
+        << s->cluster_bits;
 
     if (bytes_needed > bytes_available) {
         bytes_needed = bytes_available;
@@ -566,17 +565,17 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
         return -EIO;
     }
 
-    /* load the l2 table in memory */
+    /* load the l2 slice in memory */
 
-    ret = l2_load(bs, offset, l2_offset, &l2_table);
+    ret = l2_load(bs, offset, l2_offset, &l2_slice);
     if (ret < 0) {
         return ret;
     }
 
     /* find the cluster offset for the given disk offset */
 
-    l2_index = offset_to_l2_index(s, offset);
-    *cluster_offset = be64_to_cpu(l2_table[l2_index]);
+    l2_index = offset_to_l2_slice_index(s, offset);
+    *cluster_offset = be64_to_cpu(l2_slice[l2_index]);
 
     nb_clusters = size_to_clusters(s, bytes_needed);
     /* bytes_needed <= *bytes + offset_in_cluster, both of which are unsigned
@@ -603,14 +602,14 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
     case QCOW2_CLUSTER_UNALLOCATED:
         /* how many empty clusters ? */
         c = count_contiguous_clusters_unallocated(nb_clusters,
-                                                  &l2_table[l2_index], type);
+                                                  &l2_slice[l2_index], type);
         *cluster_offset = 0;
         break;
     case QCOW2_CLUSTER_ZERO_ALLOC:
     case QCOW2_CLUSTER_NORMAL:
         /* how many allocated clusters ? */
         c = count_contiguous_clusters(nb_clusters, s->cluster_size,
-                                      &l2_table[l2_index], QCOW_OFLAG_ZERO);
+                                      &l2_slice[l2_index], QCOW_OFLAG_ZERO);
         *cluster_offset &= L2E_OFFSET_MASK;
         if (offset_into_cluster(s, *cluster_offset)) {
             qcow2_signal_corruption(bs, true, -1, -1,
@@ -626,7 +625,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
         abort();
     }
 
-    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
     bytes_available = (int64_t)c * s->cluster_size;
 
@@ -644,7 +643,7 @@ out:
     return type;
 
 fail:
-    qcow2_cache_put(s->l2_table_cache, (void **)&l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **)&l2_slice);
     return ret;
 }
 
-- 
2.11.0
