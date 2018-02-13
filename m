Received: from eggs.gnu.org ([2001:4830:134:3::10]:53194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele2E-0003Zv-5u
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele2C-0005lj-FN
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:26 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:05:22 +0100
Message-Id: <20180213170529.10858-49-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 48/55] qcow2: Rename l2_table in
 qcow2_alloc_compressed_cluster_offset()
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

This function doesn't need any changes to support L2 slices, but since
it's now dealing with slices instead of full tables, the l2_table
variable is renamed for clarity.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 0c5d4b9bf163aa3b49ec19cc512a50d83563f2ad.1517840877.git.berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8fbaba008b..24055e19a1 100644
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
2.13.6
