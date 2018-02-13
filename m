Received: from eggs.gnu.org ([2001:4830:134:3::10]:52828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele22-0003KV-DQ
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele21-0005bc-Eo
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:14 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:05:11 +0100
Message-Id: <20180213170529.10858-38-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 37/55] qcow2: Update
 qcow2_alloc_cluster_link_l2() to support L2 slices
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

There's a loop in this function that iterates over the L2 entries in a
table, so now we need to assert that it remains within the limits of
an L2 slice.

Apart from that, this function doesn't need any additional changes, so
this patch simply updates the variable name from l2_table to l2_slice.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: f9846a1c2efc51938e877e2a25852d9ab14797ff.1517840877.git.berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index e0eea73297..a01abb3b18 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -922,7 +922,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
 {
     BDRVQcow2State *s = bs->opaque;
     int i, j = 0, l2_index, ret;
-    uint64_t *old_cluster, *l2_table;
+    uint64_t *old_cluster, *l2_slice;
     uint64_t cluster_offset = m->alloc_offset;
 
     trace_qcow2_cluster_link_l2(qemu_coroutine_self(), m->nb_clusters);
@@ -949,13 +949,13 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
                                    s->refcount_block_cache);
     }
 
-    ret = get_cluster_table(bs, m->offset, &l2_table, &l2_index);
+    ret = get_cluster_table(bs, m->offset, &l2_slice, &l2_index);
     if (ret < 0) {
         goto err;
     }
-    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
+    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
 
-    assert(l2_index + m->nb_clusters <= s->l2_size);
+    assert(l2_index + m->nb_clusters <= s->l2_slice_size);
     for (i = 0; i < m->nb_clusters; i++) {
         /* if two concurrent writes happen to the same unallocated cluster
          * each write allocates separate cluster and writes data concurrently.
@@ -963,16 +963,16 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
          * cluster the second one has to do RMW (which is done above by
          * perform_cow()), update l2 table with its cluster pointer and free
          * old cluster. This is what this loop does */
-        if (l2_table[l2_index + i] != 0) {
-            old_cluster[j++] = l2_table[l2_index + i];
+        if (l2_slice[l2_index + i] != 0) {
+            old_cluster[j++] = l2_slice[l2_index + i];
         }
 
-        l2_table[l2_index + i] = cpu_to_be64((cluster_offset +
+        l2_slice[l2_index + i] = cpu_to_be64((cluster_offset +
                     (i << s->cluster_bits)) | QCOW_OFLAG_COPIED);
      }
 
 
-    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
     /*
      * If this was a COW, we need to decrease the refcount of the old cluster.
-- 
2.13.6
