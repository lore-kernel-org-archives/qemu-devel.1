Received: from eggs.gnu.org ([2001:4830:134:3::10]:52943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele27-0003Pt-HD
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele24-0005dr-G3
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:19 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:05:12 +0100
Message-Id: <20180213170529.10858-39-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 38/55] qcow2: Update handle_copied() to support
 L2 slices
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

handle_copied() loads an L2 table and limits the number of checked
clusters to the amount that fits inside that table. Since we'll be
loading L2 slices instead of full tables we need to update that limit.

Apart from that, this function doesn't need any additional changes, so
this patch simply updates the variable name from l2_table to l2_slice.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 541ac001a7d6b86bab2392554bee53c2b312148c.1517840877.git.berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index a01abb3b18..7699544358 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1119,7 +1119,7 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
     BDRVQcow2State *s = bs->opaque;
     int l2_index;
     uint64_t cluster_offset;
-    uint64_t *l2_table;
+    uint64_t *l2_slice;
     uint64_t nb_clusters;
     unsigned int keep_clusters;
     int ret;
@@ -1131,23 +1131,23 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
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
@@ -1175,7 +1175,7 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
         /* We keep all QCOW_OFLAG_COPIED clusters */
         keep_clusters =
             count_contiguous_clusters(nb_clusters, s->cluster_size,
-                                      &l2_table[l2_index],
+                                      &l2_slice[l2_index],
                                       QCOW_OFLAG_COPIED | QCOW_OFLAG_ZERO);
         assert(keep_clusters <= nb_clusters);
 
@@ -1190,7 +1190,7 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
 
     /* Cleanup */
 out:
-    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
     /* Only return a host offset if we actually made progress. Otherwise we
      * would make requirements for handle_alloc() that it can't fulfill */
-- 
2.13.6
