Received: from eggs.gnu.org ([2001:4830:134:3::10]:43419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5g-00088g-SR
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5a-0001CN-SK
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:52 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  5 Feb 2018 16:33:23 +0200
Message-Id: <b243299c7136f7014c5af51665431ddbf5e99afd.1517840877.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 23/39] qcow2: Update handle_alloc() to
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

handle_alloc() loads an L2 table and limits the number of checked
clusters to the amount that fits inside that table. Since we'll be
loading L2 slices instead of full tables we need to update that limit.

Apart from that, this function doesn't need any additional changes, so
this patch simply updates the variable name from l2_table to l2_slice.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 854035a312..e09df478c1 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1275,7 +1275,7 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
 {
     BDRVQcow2State *s = bs->opaque;
     int l2_index;
-    uint64_t *l2_table;
+    uint64_t *l2_slice;
     uint64_t entry;
     uint64_t nb_clusters;
     int ret;
@@ -1288,29 +1288,29 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
     assert(*bytes > 0);
 
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
 
-    entry = be64_to_cpu(l2_table[l2_index]);
+    entry = be64_to_cpu(l2_slice[l2_index]);
 
     /* For the moment, overwrite compressed clusters one by one */
     if (entry & QCOW_OFLAG_COMPRESSED) {
         nb_clusters = 1;
     } else {
-        nb_clusters = count_cow_clusters(s, nb_clusters, l2_table, l2_index);
+        nb_clusters = count_cow_clusters(s, nb_clusters, l2_slice, l2_index);
     }
 
     /* This function is only called when there were no non-COW clusters, so if
@@ -1339,7 +1339,7 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
          * nb_clusters already to a range of COW clusters */
         preallocated_nb_clusters =
             count_contiguous_clusters(nb_clusters, s->cluster_size,
-                                      &l2_table[l2_index], QCOW_OFLAG_COPIED);
+                                      &l2_slice[l2_index], QCOW_OFLAG_COPIED);
         assert(preallocated_nb_clusters > 0);
 
         nb_clusters = preallocated_nb_clusters;
@@ -1350,7 +1350,7 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
         keep_old_clusters = true;
     }
 
-    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
     if (!alloc_cluster_offset) {
         /* Allocate, if necessary at a given offset in the image file */
-- 
2.11.0
