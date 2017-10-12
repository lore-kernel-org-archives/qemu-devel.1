Received: from eggs.gnu.org ([2001:4830:134:3::10]:44481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dIV-00031D-1M
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e2dIQ-0005D5-Uv
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:13:11 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 12 Oct 2017 16:05:21 +0300
Message-Id: <2510b8a4c5a72033274ffe68955e482f9a87df1d.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
In-Reply-To: <cover.1507813391.git.berto@igalia.com>
References: <cover.1507813391.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 07/31] qcow2: Remove BDS parameter from
 qcow2_cache_put()
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
 block/qcow2-cache.c    |  2 +-
 block/qcow2-cluster.c  | 28 ++++++++++++++--------------
 block/qcow2-refcount.c | 30 +++++++++++++++---------------
 block/qcow2.h          |  2 +-
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index e2502d32ae..bd2bc7e063 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -386,7 +386,7 @@ int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
     return qcow2_cache_do_get(bs, c, offset, table, false);
 }
 
-void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table)
+void qcow2_cache_put(Qcow2Cache *c, void **table)
 {
     int i = qcow2_cache_get_table_idx(c, *table);
 
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 372cb64366..45d05f86fe 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -310,7 +310,7 @@ static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
 
         memcpy(l2_table, old_table, s->cluster_size);
 
-        qcow2_cache_put(bs, s->l2_table_cache, (void **) &old_table);
+        qcow2_cache_put(s->l2_table_cache, (void **) &old_table);
     }
 
     /* write the l2 table to the file */
@@ -338,7 +338,7 @@ static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
 fail:
     trace_qcow2_l2_allocate_done(bs, l1_index, ret);
     if (l2_table != NULL) {
-        qcow2_cache_put(bs, s->l2_table_cache, (void**) table);
+        qcow2_cache_put(s->l2_table_cache, (void **) table);
     }
     s->l1_table[l1_index] = old_l2_offset;
     if (l2_offset > 0) {
@@ -612,7 +612,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
         abort();
     }
 
-    qcow2_cache_put(bs, s->l2_table_cache, (void**) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
     bytes_available = (int64_t)c * s->cluster_size;
 
@@ -630,7 +630,7 @@ out:
     return type;
 
 fail:
-    qcow2_cache_put(bs, s->l2_table_cache, (void **)&l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **)&l2_table);
     return ret;
 }
 
@@ -737,13 +737,13 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
      * allocated. */
     cluster_offset = be64_to_cpu(l2_table[l2_index]);
     if (cluster_offset & L2E_OFFSET_MASK) {
-        qcow2_cache_put(bs, s->l2_table_cache, (void**) &l2_table);
+        qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
         return 0;
     }
 
     cluster_offset = qcow2_alloc_bytes(bs, compressed_size);
     if (cluster_offset < 0) {
-        qcow2_cache_put(bs, s->l2_table_cache, (void**) &l2_table);
+        qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
         return 0;
     }
 
@@ -760,7 +760,7 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
     BLKDBG_EVENT(bs->file, BLKDBG_L2_UPDATE_COMPRESSED);
     qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
     l2_table[l2_index] = cpu_to_be64(cluster_offset);
-    qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
     return cluster_offset;
 }
@@ -949,7 +949,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
      }
 
 
-    qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
     /*
      * If this was a COW, we need to decrease the refcount of the old cluster.
@@ -1167,7 +1167,7 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
 
     /* Cleanup */
 out:
-    qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
     /* Only return a host offset if we actually made progress. Otherwise we
      * would make requirements for handle_alloc() that it can't fulfill */
@@ -1315,7 +1315,7 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
         keep_old_clusters = true;
     }
 
-    qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
     if (!alloc_cluster_offset) {
         /* Allocate, if necessary at a given offset in the image file */
@@ -1671,7 +1671,7 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
         qcow2_free_any_clusters(bs, old_l2_entry, 1, type);
     }
 
-    qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
     return nb_clusters;
 }
@@ -1765,7 +1765,7 @@ static int zero_single_l2(BlockDriverState *bs, uint64_t offset,
         }
     }
 
-    qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
     return nb_clusters;
 }
@@ -1968,7 +1968,7 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                 qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
                 qcow2_cache_depends_on_flush(s->l2_table_cache);
             }
-            qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+            qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
         } else {
             if (l2_dirty) {
                 ret = qcow2_pre_write_overlap_check(bs,
@@ -1999,7 +1999,7 @@ fail:
         if (!is_active_l1) {
             qemu_vfree(l2_table);
         } else {
-            qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+            qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
         }
     }
     return ret;
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index f0cc4f090a..e93c1acd79 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -277,7 +277,7 @@ int qcow2_get_refcount(BlockDriverState *bs, int64_t cluster_index,
     block_index = cluster_index & (s->refcount_block_size - 1);
     *refcount = s->get_refcount(refcount_block, block_index);
 
-    qcow2_cache_put(bs, s->refcount_block_cache, &refcount_block);
+    qcow2_cache_put(s->refcount_block_cache, &refcount_block);
 
     return 0;
 }
@@ -442,7 +442,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
         return -EAGAIN;
     }
 
-    qcow2_cache_put(bs, s->refcount_block_cache, refcount_block);
+    qcow2_cache_put(s->refcount_block_cache, refcount_block);
 
     /*
      * If we come here, we need to grow the refcount table. Again, a new
@@ -494,7 +494,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
 
 fail:
     if (*refcount_block != NULL) {
-        qcow2_cache_put(bs, s->refcount_block_cache, refcount_block);
+        qcow2_cache_put(s->refcount_block_cache, refcount_block);
     }
     return ret;
 }
@@ -653,7 +653,7 @@ int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t start_offset,
                                          refblock_data);
         }
 
-        qcow2_cache_put(bs, s->refcount_block_cache, &refblock_data);
+        qcow2_cache_put(s->refcount_block_cache, &refblock_data);
     }
 
     assert(block_offset == table_offset);
@@ -829,7 +829,7 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
         /* Load the refcount block and allocate it if needed */
         if (table_index != old_table_index) {
             if (refcount_block) {
-                qcow2_cache_put(bs, s->refcount_block_cache, &refcount_block);
+                qcow2_cache_put(s->refcount_block_cache, &refcount_block);
             }
             ret = alloc_refcount_block(bs, cluster_index, &refcount_block);
             if (ret < 0) {
@@ -867,7 +867,7 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
             table = qcow2_cache_is_table_offset(bs, s->refcount_block_cache,
                                                 offset);
             if (table != NULL) {
-                qcow2_cache_put(bs, s->refcount_block_cache, &refcount_block);
+                qcow2_cache_put(s->refcount_block_cache, &refcount_block);
                 qcow2_cache_discard(bs, s->refcount_block_cache, table);
             }
 
@@ -890,7 +890,7 @@ fail:
 
     /* Write last changed block to disk */
     if (refcount_block) {
-        qcow2_cache_put(bs, s->refcount_block_cache, &refcount_block);
+        qcow2_cache_put(s->refcount_block_cache, &refcount_block);
     }
 
     /*
@@ -1305,7 +1305,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                 }
             }
 
-            qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+            qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
             if (addend != 0) {
                 ret = qcow2_update_cluster_refcount(bs, l2_offset >>
@@ -1333,7 +1333,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
     ret = bdrv_flush(bs);
 fail:
     if (l2_table) {
-        qcow2_cache_put(bs, s->l2_table_cache, (void**) &l2_table);
+        qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
     }
 
     s->cache_discards = false;
@@ -2787,7 +2787,7 @@ static int walk_over_reftable(BlockDriverState *bs, uint64_t **new_reftable,
                                     new_reftable_size, new_refblock,
                                     new_refblock_empty, allocated, errp);
                     if (ret < 0) {
-                        qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+                        qcow2_cache_put(s->refcount_block_cache, &refblock);
                         return ret;
                     }
 
@@ -2800,7 +2800,7 @@ static int walk_over_reftable(BlockDriverState *bs, uint64_t **new_reftable,
                 if (new_refcount_bits < 64 && refcount >> new_refcount_bits) {
                     uint64_t offset;
 
-                    qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+                    qcow2_cache_put(s->refcount_block_cache, &refblock);
 
                     offset = ((reftable_index << s->refcount_block_bits)
                               + refblock_index) << s->cluster_bits;
@@ -2821,7 +2821,7 @@ static int walk_over_reftable(BlockDriverState *bs, uint64_t **new_reftable,
                 new_refblock_empty = new_refblock_empty && refcount == 0;
             }
 
-            qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+            qcow2_cache_put(s->refcount_block_cache, &refblock);
         } else {
             /* No refblock means every refcount is 0 */
             for (refblock_index = 0; refblock_index < s->refcount_block_size;
@@ -3089,14 +3089,14 @@ static int qcow2_discard_refcount_block(BlockDriverState *bs,
                                 offset_to_reftable_index(s, discard_block_offs),
                                 discard_block_offs,
                                 s->get_refcount(refblock, block_index));
-        qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+        qcow2_cache_put(s->refcount_block_cache, &refblock);
         return -EINVAL;
     }
     s->set_refcount(refblock, block_index, 0);
 
     qcow2_cache_entry_mark_dirty(s->refcount_block_cache, refblock);
 
-    qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+    qcow2_cache_put(s->refcount_block_cache, &refblock);
 
     if (cluster_index < s->free_cluster_index) {
         s->free_cluster_index = cluster_index;
@@ -3149,7 +3149,7 @@ int qcow2_shrink_reftable(BlockDriverState *bs)
         } else {
             unused_block = buffer_is_zero(refblock, s->cluster_size);
         }
-        qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+        qcow2_cache_put(s->refcount_block_cache, &refblock);
 
         reftable_tmp[i] = unused_block ? 0 : cpu_to_be64(s->refcount_table[i]);
     }
diff --git a/block/qcow2.h b/block/qcow2.h
index 539c07a46f..7fa195bc22 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -662,7 +662,7 @@ int qcow2_cache_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
     void **table);
 int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
     void **table);
-void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table);
+void qcow2_cache_put(Qcow2Cache *c, void **table);
 void *qcow2_cache_is_table_offset(BlockDriverState *bs, Qcow2Cache *c,
                                   uint64_t offset);
 void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, void *table);
-- 
2.11.0
