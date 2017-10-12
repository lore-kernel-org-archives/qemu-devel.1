Received: from eggs.gnu.org ([2001:4830:134:3::10]:42985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dGF-00016Z-Mi
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dGE-0001B3-8Q
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:10:51 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 12 Oct 2017 16:05:41 +0300
Message-Id: <c14d0cf215ff8a9450b026c5f64f15a2600626f9.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 27/31] qcow2: Rename l2_table in
 qcow2_alloc_compressed_cluster_offset()
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

This function doesn't need any changes to support L2 slices, but since
it's now dealing with slices intead of full tables, the l2_table
variable is renamed for clarity.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index eb5094e593..e7b07d3366 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -747,26 +747,26 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
 {
     BDRVQcow2State *s = bs->opaque;
     int l2_index, ret;
-    uint64_t *l2_table;
+    uint64_t *l2_slice;
     int64_t cluster_offset;
     int nb_csectors;
 
-    ret = get_cluster_table(bs, offset, &l2_table, &l2_index);
+    ret = get_cluster_table(bs, offset, &l2_slice, &l2_index);
     if (ret < 0) {
         return 0;
     }
 
     /* Compression can't overwrite anything. Fail if the cluster was already
      * allocated. */
-    cluster_offset = be64_to_cpu(l2_table[l2_index]);
+    cluster_offset = be64_to_cpu(l2_slice[l2_index]);
     if (cluster_offset & L2E_OFFSET_MASK) {
-        qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
+        qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
         return 0;
     }
 
     cluster_offset = qcow2_alloc_bytes(bs, compressed_size);
     if (cluster_offset < 0) {
-        qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
+        qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
         return 0;
     }
 
@@ -781,9 +781,9 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
     /* compressed clusters never have the copied flag */
 
     BLKDBG_EVENT(bs->file, BLKDBG_L2_UPDATE_COMPRESSED);
-    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
-    l2_table[l2_index] = cpu_to_be64(cluster_offset);
-    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
+    l2_slice[l2_index] = cpu_to_be64(cluster_offset);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
     return cluster_offset;
 }
-- 
2.11.0
