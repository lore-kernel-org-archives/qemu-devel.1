Received: from eggs.gnu.org ([2001:4830:134:3::10]:55618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVJ-0000YG-8X
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003In-Sk
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:16 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:35 +0100
Message-Id: <faadd3224ae4eb688e65d1f363e3056c7554cf26.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 07/32] qcow2: Remove BDS parameter from
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

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
index 7b4c502908..10f0b7fa87 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -407,7 +407,7 @@ int qcow2_cache_get_empty(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
     return qcow2_cache_do_get(bs, c, offset, table, false);
 }
 
-void qcow2_cache_put(BlockDriverState *bs, Qcow2Cache *c, void **table)
+void qcow2_cache_put(Qcow2Cache *c, void **table)
 {
     int i = qcow2_cache_get_table_idx(c, *table);
 
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 1f279a9151..4a7b46038b 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -318,7 +318,7 @@ static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
 
         memcpy(l2_table, old_table, s->cluster_size);
 
-        qcow2_cache_put(bs, s->l2_table_cache, (void **) &old_table);
+        qcow2_cache_put(s->l2_table_cache, (void **) &old_table);
     }
 
     /* write the l2 table to the file */
@@ -346,7 +346,7 @@ static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
 fail:
     trace_qcow2_l2_allocate_done(bs, l1_index, ret);
     if (l2_table != NULL) {
-        qcow2_cache_put(bs, s->l2_table_cache, (void**) table);
+        qcow2_cache_put(s->l2_table_cache, (void **) table);
     }
     s->l1_table[l1_index] = old_l2_offset;
     if (l2_offset > 0) {
@@ -620,7 +620,7 @@ int qcow2_get_cluster_offset(BlockDriverState *bs, uint64_t offset,
         abort();
     }
 
-    qcow2_cache_put(bs, s->l2_table_cache, (void**) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
     bytes_available = (int64_t)c * s->cluster_size;
 
@@ -638,7 +638,7 @@ out:
     return type;
 
 fail:
-    qcow2_cache_put(bs, s->l2_table_cache, (void **)&l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **)&l2_table);
     return ret;
 }
 
@@ -745,13 +745,13 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
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
 
@@ -768,7 +768,7 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
     BLKDBG_EVENT(bs->file, BLKDBG_L2_UPDATE_COMPRESSED);
     qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
     l2_table[l2_index] = cpu_to_be64(cluster_offset);
-    qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
     return cluster_offset;
 }
@@ -957,7 +957,7 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m)
      }
 
 
-    qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
     /*
      * If this was a COW, we need to decrease the refcount of the old cluster.
@@ -1175,7 +1175,7 @@ static int handle_copied(BlockDriverState *bs, uint64_t guest_offset,
 
     /* Cleanup */
 out:
-    qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
     /* Only return a host offset if we actually made progress. Otherwise we
      * would make requirements for handle_alloc() that it can't fulfill */
@@ -1334,7 +1334,7 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
         keep_old_clusters = true;
     }
 
-    qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
     if (!alloc_cluster_offset) {
         /* Allocate, if necessary at a given offset in the image file */
@@ -1690,7 +1690,7 @@ static int discard_single_l2(BlockDriverState *bs, uint64_t offset,
         qcow2_free_any_clusters(bs, old_l2_entry, 1, type);
     }
 
-    qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
     return nb_clusters;
 }
@@ -1784,7 +1784,7 @@ static int zero_single_l2(BlockDriverState *bs, uint64_t offset,
         }
     }
 
-    qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+    qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
     return nb_clusters;
 }
@@ -1987,7 +1987,7 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                 qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
                 qcow2_cache_depends_on_flush(s->l2_table_cache);
             }
-            qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+            qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
         } else {
             if (l2_dirty) {
                 ret = qcow2_pre_write_overlap_check(bs,
@@ -2018,7 +2018,7 @@ fail:
         if (!is_active_l1) {
             qemu_vfree(l2_table);
         } else {
-            qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+            qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
         }
     }
     return ret;
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 75b1472fc8..2c37492b4d 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -277,7 +277,7 @@ int qcow2_get_refcount(BlockDriverState *bs, int64_t cluster_index,
     block_index = cluster_index & (s->refcount_block_size - 1);
     *refcount = s->get_refcount(refcount_block, block_index);
 
-    qcow2_cache_put(bs, s->refcount_block_cache, &refcount_block);
+    qcow2_cache_put(s->refcount_block_cache, &refcount_block);
 
     return 0;
 }
@@ -449,7 +449,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
         return -EAGAIN;
     }
 
-    qcow2_cache_put(bs, s->refcount_block_cache, refcount_block);
+    qcow2_cache_put(s->refcount_block_cache, refcount_block);
 
     /*
      * If we come here, we need to grow the refcount table. Again, a new
@@ -501,7 +501,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
 
 fail:
     if (*refcount_block != NULL) {
-        qcow2_cache_put(bs, s->refcount_block_cache, refcount_block);
+        qcow2_cache_put(s->refcount_block_cache, refcount_block);
     }
     return ret;
 }
@@ -660,7 +660,7 @@ int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t start_offset,
                                          refblock_data);
         }
 
-        qcow2_cache_put(bs, s->refcount_block_cache, &refblock_data);
+        qcow2_cache_put(s->refcount_block_cache, &refblock_data);
     }
 
     assert(block_offset == table_offset);
@@ -836,7 +836,7 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
         /* Load the refcount block and allocate it if needed */
         if (table_index != old_table_index) {
             if (refcount_block) {
-                qcow2_cache_put(bs, s->refcount_block_cache, &refcount_block);
+                qcow2_cache_put(s->refcount_block_cache, &refcount_block);
             }
             ret = alloc_refcount_block(bs, cluster_index, &refcount_block);
             if (ret < 0) {
@@ -874,7 +874,7 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
             table = qcow2_cache_is_table_offset(bs, s->refcount_block_cache,
                                                 offset);
             if (table != NULL) {
-                qcow2_cache_put(bs, s->refcount_block_cache, &refcount_block);
+                qcow2_cache_put(s->refcount_block_cache, &refcount_block);
                 qcow2_cache_discard(bs, s->refcount_block_cache, table);
             }
 
@@ -897,7 +897,7 @@ fail:
 
     /* Write last changed block to disk */
     if (refcount_block) {
-        qcow2_cache_put(bs, s->refcount_block_cache, &refcount_block);
+        qcow2_cache_put(s->refcount_block_cache, &refcount_block);
     }
 
     /*
@@ -1319,7 +1319,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                 }
             }
 
-            qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
+            qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
 
             if (addend != 0) {
                 ret = qcow2_update_cluster_refcount(bs, l2_offset >>
@@ -1347,7 +1347,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
     ret = bdrv_flush(bs);
 fail:
     if (l2_table) {
-        qcow2_cache_put(bs, s->l2_table_cache, (void**) &l2_table);
+        qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
     }
 
     s->cache_discards = false;
@@ -2801,7 +2801,7 @@ static int walk_over_reftable(BlockDriverState *bs, uint64_t **new_reftable,
                                     new_reftable_size, new_refblock,
                                     new_refblock_empty, allocated, errp);
                     if (ret < 0) {
-                        qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+                        qcow2_cache_put(s->refcount_block_cache, &refblock);
                         return ret;
                     }
 
@@ -2814,7 +2814,7 @@ static int walk_over_reftable(BlockDriverState *bs, uint64_t **new_reftable,
                 if (new_refcount_bits < 64 && refcount >> new_refcount_bits) {
                     uint64_t offset;
 
-                    qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+                    qcow2_cache_put(s->refcount_block_cache, &refblock);
 
                     offset = ((reftable_index << s->refcount_block_bits)
                               + refblock_index) << s->cluster_bits;
@@ -2835,7 +2835,7 @@ static int walk_over_reftable(BlockDriverState *bs, uint64_t **new_reftable,
                 new_refblock_empty = new_refblock_empty && refcount == 0;
             }
 
-            qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+            qcow2_cache_put(s->refcount_block_cache, &refblock);
         } else {
             /* No refblock means every refcount is 0 */
             for (refblock_index = 0; refblock_index < s->refcount_block_size;
@@ -3127,14 +3127,14 @@ static int qcow2_discard_refcount_block(BlockDriverState *bs,
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
@@ -3187,7 +3187,7 @@ int qcow2_shrink_reftable(BlockDriverState *bs)
         } else {
             unused_block = buffer_is_zero(refblock, s->cluster_size);
         }
-        qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+        qcow2_cache_put(s->refcount_block_cache, &refblock);
 
         reftable_tmp[i] = unused_block ? 0 : cpu_to_be64(s->refcount_table[i]);
     }
diff --git a/block/qcow2.h b/block/qcow2.h
index caab8630d9..e78d0c2316 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -656,7 +656,7 @@ int qcow2_cache_get(BlockDriverState *bs, Qcow2Cache *c, uint64_t offset,
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
