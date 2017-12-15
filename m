Received: from eggs.gnu.org ([2001:4830:134:3::10]:55389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVE-0000WT-Gc
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVB-0003G0-ON
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:12 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:48 +0100
Message-Id: <0cfc3621612922be4fb61894118ef982a61a23d7.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 20/32] qcow2: Update handle_copied() to
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

handle_copied() loads an L2 table and limits the number of checked
clusters to the amount that fits inside that table. Since we'll be
loading L2 slices instead of full tables we need to update that limit.

Apart from that, this function doesn't need any additional changes, so
this patch simply updates the variable name from l2_table to l2_slice.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f8c22ca2be..09b6dc984f 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1128,7 +1128,7 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
     BDRVQcow2State *s = bs->opaque;
     int l2_index;
     uint64_t cluster_offset;
-    uint64_t *l2_table;
+    uint64_t *l2_slice;
     uint64_t nb_clusters;
     unsigned int keep_clusters;
     int ret;
@@ -1140,23 +1140,23 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
                                 == offset_into_cluster(s, *host_offset));
 
     /*
-     * Calculate the number of clusters to look for. We stop at L2 table
+     * Calculate the number of clusters to look for. We stop at L2 slice
      * boundaries to keep things simple.
      */
     nb_clusters =
         size_to_clusters(s, offset_into_cluster(s, guest_offset) + *bytes);
 
-    l2_index = offset_to_l2_index(s, guest_offset);
-    nb_clusters = MIN(nb_clusters, s->l2_size - l2_index);
+    l2_index = offset_to_l2_slice_index(s, guest_offset);
+    nb_clusters = MIN(nb_clusters, s->l2_slice_size - l2_index);
     assert(nb_clusters <= INT_MAX);
 
     /* Find L2 entry for the first involved cluster */
-    ret = get_cluster_table(bs, guest_offset, &l2_table, &l2_index);
+    ret = get_cluster_table(bs, guest_offset, &l2_slice, &l2_index);
     if (ret < 0) {
         return ret;
     }
 
-    cluster_offset = be64_to_cpu(l2_table[l2_index]);
+    cluster_offset = be64_to_cpu(l2_slice[l2_index]);
 
     /* Check how many clusters are already allocated and don't need COW */
     if (qcow2_get_cluster_type(cluster_offset) == QCOW2_CLUSTER_NORMAL
@@ -1184,7 +1184,7 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
         /* We keep all QCOW_OFLAG_COPIED clusters */
         keep_clusters =
             count_contiguous_clusters(nb_clusters, s->cluster_size,
-                                      &l2_table[l2_index],
+                                      &l2_slice[l2_index],
                                       QCOW_OFLAG_COPIED | QCOW_OFLAG_ZERO);
         assert(keep_clusters <= nb_clusters);
 
@@ -1199,7 +1199,7 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
 
     /* Cleanup */
 out:
-    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
     /* Only return a host offset if we actually made progress. Otherwise we
      * would make requirements for handle_alloc() that it can't fulfill */
-- 
2.11.0
