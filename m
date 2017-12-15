Received: from eggs.gnu.org ([2001:4830:134:3::10]:55515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVH-0000Wr-9X
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003HO-6u
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:15 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:34 +0100
Message-Id: <3c5596196fac576592433452622c3fb8ce45979c.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 06/32] qcow2: Remove BDS parameter from
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

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
index 3deded348c..7b4c502908 100644
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
index 8163983d28..1f279a9151 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -325,7 +325,7 @@ static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
     BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_WRITE);
 
     trace_qcow2_l2_allocate_write_l2(bs, l1_index);
-    qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
     ret = qcow2_cache_flush(bs, s->l2_table_cache);
     if (ret < 0) {
         goto fail;
@@ -766,7 +766,7 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
     /* compressed clusters never have the copied flag */
 
     BLKDBG_EVENT(bs->file, BLKDBG_L2_UPDATE_COMPRESSED);
-    qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
     l2_table[l2_index] = cpu_to_be64(cluster_offset);
     qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
 
@@ -938,7 +938,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
     if (ret < 0) {
         goto err;
     }
-    qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
 
     assert(l2_index + m->nb_clusters <= s->l2_size);
     for (i = 0; i < m->nb_clusters; i++) {
@@ -1679,7 +1679,7 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
         }
 
         /* First remove L2 entries */
-        qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
         if (!full_discard && s->qcow_version >= 3) {
             l2_table[l2_index + i] = cpu_to_be64(QCOW_OFLAG_ZERO);
         } else {
@@ -1775,7 +1775,7 @@ static int zero_single_l2(BlockDriverState *bs, uint64_t offset,
             continue;
         }
 
-        qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
         if (cluster_type == QCOW2_CLUSTER_COMPRESSED || unmap) {
             l2_table[l2_index + i] = cpu_to_be64(QCOW_OFLAG_ZERO);
             qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_REQUEST);
@@ -1984,7 +1984,7 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
 
         if (is_active_l1) {
             if (l2_dirty) {
-                qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);
+                qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
                 qcow2_cache_depends_on_flush(s->l2_table_cache);
             }
             qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 3de1ab51ba..75b1472fc8 100644
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
 
@@ -3134,7 +3132,7 @@ static int qcow2_discard_refcount_block(BlockDriverState *bs,
     }
     s->set_refcount(refblock, block_index, 0);
 
-    qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache, refblock);
+    qcow2_cache_entry_mark_dirty(s->refcount_block_cache, refblock);
 
     qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
 
diff --git a/block/qcow2.h b/block/qcow2.h
index 6f0ff15dd0..caab8630d9 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -642,8 +642,7 @@ int qcow2_read_snapshots(BlockDriverState *bs);
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
