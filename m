Received: from eggs.gnu.org ([2001:4830:134:3::10]:44708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dIz-0003PR-8R
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dIv-0005lg-5m
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:13:41 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 12 Oct 2017 16:05:20 +0300
Message-Id: <08fde64b907b45afa4c4622de4799ce1c5144508.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 06/31] qcow2: Remove BDS parameter from
 qcow2_cache_entry_mark_dirty()
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

This function was only using the BlockDriverState parameter to pass it
to qcow2_cache_get_table_idx(). This is no longer necessary so this
parameter can be removed.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cache.c    |  3 +--
 block/qcow2-cluster.c  | 12 ++++++------
 block/qcow2-refcount.c | 14 ++++++--------
 block/qcow2.h          |  3 +--
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index dac99e95b0..e2502d32ae 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -400,8 +400,7 @@ void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table)
     assert(c->entries[i].ref >= 0);
 }
 
-void qcow2_cache_entry_mark_dirty(BlockDriverState *bs, Qcow2Cache *c,
-     void *table)
+void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table)
 {
     int i = qcow2_cache_get_table_idx(c, table);
     assert(c->entries[i].offset != 0);
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index b926549816..372cb64366 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -317,7 +317,7 @@ static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
     BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_WRITE);
 
     trace_qcow2_l2_allocate_write_l2(bs, l1_index);
-    qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
     ret = qcow2_cache_flush(bs, s->l2_table_cache);
     if (ret < 0) {
         goto fail;
@@ -758,7 +758,7 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
     /* compressed clusters never have the copied flag */
 
     BLKDBG_EVENT(bs->file, BLKDBG_L2_UPDATE_COMPRESSED);
-    qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
     l2_table[l2_index] = cpu_to_be64(cluster_offset);
     qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
 
@@ -930,7 +930,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
     if (ret < 0) {
         goto err;
     }
-    qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
 
     assert(l2_index + m->nb_clusters <= s->l2_size);
     for (i = 0; i < m->nb_clusters; i++) {
@@ -1660,7 +1660,7 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
         }
 
         /* First remove L2 entries */
-        qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
         if (!full_discard && s->qcow_version >= 3) {
             l2_table[l2_index + i] = cpu_to_be64(QCOW_OFLAG_ZERO);
         } else {
@@ -1756,7 +1756,7 @@ static int zero_single_l2(BlockDriverState *bs, uint64_t offset,
             continue;
         }
 
-        qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
         if (cluster_type == QCOW2_CLUSTER_COMPRESSED || unmap) {
             l2_table[l2_index + i] = cpu_to_be64(QCOW_OFLAG_ZERO);
             qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_REQUEST);
@@ -1965,7 +1965,7 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
 
         if (is_active_l1) {
             if (l2_dirty) {
-                qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+                qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
                 qcow2_cache_depends_on_flush(s->l2_table_cache);
             }
             qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index aa3fd6cf17..f0cc4f090a 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -414,7 +414,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
 
     /* Now the new refcount block needs to be written to disk */
     BLKDBG_EVENT(bs->file, BLKDBG_REFBLOCK_ALLOC_WRITE);
-    qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache, *refcount_block);
+    qcow2_cache_entry_mark_dirty(s->refcount_block_cache, *refcount_block);
     ret = qcow2_cache_flush(bs, s->refcount_block_cache);
     if (ret < 0) {
         goto fail;
@@ -616,7 +616,7 @@ int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t start_offset,
                 goto fail;
             }
             memset(refblock_data, 0, s->cluster_size);
-            qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache,
+            qcow2_cache_entry_mark_dirty(s->refcount_block_cache,
                                          refblock_data);
 
             new_table[i] = block_offset;
@@ -649,7 +649,7 @@ int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t start_offset,
                 s->set_refcount(refblock_data, j, 1);
             }
 
-            qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache,
+            qcow2_cache_entry_mark_dirty(s->refcount_block_cache,
                                          refblock_data);
         }
 
@@ -838,8 +838,7 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
         }
         old_table_index = table_index;
 
-        qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache,
-                                     refcount_block);
+        qcow2_cache_entry_mark_dirty(s->refcount_block_cache, refcount_block);
 
         /* we can update the count and save it */
         block_index = cluster_index & (s->refcount_block_size - 1);
@@ -1302,8 +1301,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                             s->refcount_block_cache);
                     }
                     l2_table[j] = cpu_to_be64(entry);
-                    qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache,
-                                                 l2_table);
+                    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
                 }
             }
 
@@ -3096,7 +3094,7 @@ static int qcow2_discard_refcount_block(BlockDriverState *bs,
     }
     s->set_refcount(refblock, block_index, 0);
 
-    qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache, refblock);
+    qcow2_cache_entry_mark_dirty(s->refcount_block_cache, refblock);
 
     qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
 
diff --git a/block/qcow2.h b/block/qcow2.h
index 782a206ecb..539c07a46f 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -648,8 +648,7 @@ int qcow2_read_snapshots(BlockDriverState *bs);
 Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables);
 int qcow2_cache_destroy(BlockDriverState* bs, Qcow2Cache *c);
 
-void qcow2_cache_entry_mark_dirty(BlockDriverState *bs, Qcow2Cache *c,
-     void *table);
+void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table);
 int qcow2_cache_flush(BlockDriverState *bs, Qcow2Cache *c);
 int qcow2_cache_write(BlockDriverState *bs, Qcow2Cache *c);
 int qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
-- 
2.11.0
