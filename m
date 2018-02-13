Received: from eggs.gnu.org ([2001:4830:134:3::10]:52535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1r-00035f-65
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1p-0005S9-Q0
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:03 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:04:56 +0100
Message-Id: <20180213170529.10858-23-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 22/55] qcow2: Remove BDS parameter from
 qcow2_cache_entry_mark_dirty()
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

This function was only using the BlockDriverState parameter to pass it
to qcow2_cache_get_table_idx(). This is no longer necessary so this
parameter can be removed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 5c40516a91782b083c1428b7b6a41bb9e2679bfb.1517840876.git.berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h          |  3 +--
 block/qcow2-cache.c    |  3 +--
 block/qcow2-cluster.c  | 12 ++++++------
 block/qcow2-refcount.c | 14 ++++++--------
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 016e87c81a..73e0e0133d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -639,8 +639,7 @@ int qcow2_read_snapshots(BlockDriverState *bs);
 Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables);
 int qcow2_cache_destroy(BlockDriverState* bs, Qcow2Cache *c);
 
-void qcow2_cache_entry_mark_dirty(BlockDriverState *bs, Qcow2Cache *c,
-     void *table);
+void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table);
 int qcow2_cache_flush(BlockDriverState *bs, Qcow2Cache *c);
 int qcow2_cache_write(BlockDriverState *bs, Qcow2Cache *c);
 int qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 5ff2cbf5c5..07603e6b15 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -421,8 +421,7 @@ void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table)
     assert(c->entries[i].ref >= 0);
 }
 
-void qcow2_cache_entry_mark_dirty(BlockDriverState *bs, Qcow2Cache *c,
-     void *table)
+void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table)
 {
     int i = qcow2_cache_get_table_idx(c, table);
     assert(c->entries[i].offset != 0);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index e5ab102c29..08af5c5995 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -324,7 +324,7 @@ static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
     BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_WRITE);
 
     trace_qcow2_l2_allocate_write_l2(bs, l1_index);
-    qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
     ret = qcow2_cache_flush(bs, s->l2_table_cache);
     if (ret < 0) {
         goto fail;
@@ -765,7 +765,7 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
     /* compressed clusters never have the copied flag */
 
     BLKDBG_EVENT(bs->file, BLKDBG_L2_UPDATE_COMPRESSED);
-    qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
     l2_table[l2_index] = cpu_to_be64(cluster_offset);
     qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
 
@@ -937,7 +937,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
     if (ret < 0) {
         goto err;
     }
-    qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
 
     assert(l2_index + m->nb_clusters <= s->l2_size);
     for (i = 0; i < m->nb_clusters; i++) {
@@ -1678,7 +1678,7 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
         }
 
         /* First remove L2 entries */
-        qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
         if (!full_discard && s->qcow_version >= 3) {
             l2_table[l2_index + i] = cpu_to_be64(QCOW_OFLAG_ZERO);
         } else {
@@ -1774,7 +1774,7 @@ static int zero_single_l2(BlockDriverState *bs, uint64_t offset,
             continue;
         }
 
-        qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
         if (cluster_type == QCOW2_CLUSTER_COMPRESSED || unmap) {
             l2_table[l2_index + i] = cpu_to_be64(QCOW_OFLAG_ZERO);
             qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_REQUEST);
@@ -1983,7 +1983,7 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
 
         if (is_active_l1) {
             if (l2_dirty) {
-                qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+                qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
                 qcow2_cache_depends_on_flush(s->l2_table_cache);
             }
             qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 92701ab7af..5434e7d4c8 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -421,7 +421,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
 
     /* Now the new refcount block needs to be written to disk */
     BLKDBG_EVENT(bs->file, BLKDBG_REFBLOCK_ALLOC_WRITE);
-    qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache, *refcount_block);
+    qcow2_cache_entry_mark_dirty(s->refcount_block_cache, *refcount_block);
     ret = qcow2_cache_flush(bs, s->refcount_block_cache);
     if (ret < 0) {
         goto fail;
@@ -623,7 +623,7 @@ int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t start_offset,
                 goto fail;
             }
             memset(refblock_data, 0, s->cluster_size);
-            qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache,
+            qcow2_cache_entry_mark_dirty(s->refcount_block_cache,
                                          refblock_data);
 
             new_table[i] = block_offset;
@@ -656,7 +656,7 @@ int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t start_offset,
                 s->set_refcount(refblock_data, j, 1);
             }
 
-            qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache,
+            qcow2_cache_entry_mark_dirty(s->refcount_block_cache,
                                          refblock_data);
         }
 
@@ -845,8 +845,7 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
         }
         old_table_index = table_index;
 
-        qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache,
-                                     refcount_block);
+        qcow2_cache_entry_mark_dirty(s->refcount_block_cache, refcount_block);
 
         /* we can update the count and save it */
         block_index = cluster_index & (s->refcount_block_size - 1);
@@ -1316,8 +1315,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                             s->refcount_block_cache);
                     }
                     l2_table[j] = cpu_to_be64(entry);
-                    qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache,
-                                                 l2_table);
+                    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
                 }
             }
 
@@ -3180,7 +3178,7 @@ static int qcow2_discard_refcount_block(BlockDriverState *bs,
     }
     s->set_refcount(refblock, block_index, 0);
 
-    qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache, refblock);
+    qcow2_cache_entry_mark_dirty(s->refcount_block_cache, refblock);
 
     qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
 
-- 
2.13.6
