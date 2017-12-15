Received: from eggs.gnu.org ([2001:4830:134:3::10]:55514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVH-0000Wq-9T
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003J3-Sr
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:15 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:44 +0100
Message-Id: <192986ad741749064e855bc67916a11460911992.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 16/32] qcow2: Update l2_allocate() to
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>

This patch updates l2_allocate() to support the qcow2 cache returning
L2 slices instead of full L2 tables.

The old code simply gets an L2 table from the cache and initializes it
with zeroes or with the contents of an existing table. With a cache
that returns slices instead of tables the idea remains the same, but
the code must now iterate over all the slices that are contained in an
L2 table.

Since now we're operating with slices the function can no longer
return the newly-allocated table, so it's up to the caller to retrieve
the appropriate L2 slice after calling l2_allocate() (note that with
this patch the caller is still loading full L2 tables, but we'll deal
with that in a separate patch).

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 86 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 34 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8d92d623d8..ecb75b6be6 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -264,11 +264,12 @@ int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)
  *
  */
 
-static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
+static int l2_allocate(BlockDriverState *bs, int l1_index)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t old_l2_offset;
-    uint64_t *l2_table = NULL;
+    uint64_t *l2_slice = NULL;
+    unsigned slice, slice_size, n_slices;
     int64_t l2_offset;
     int ret;
 
@@ -299,42 +300,50 @@ static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
 
     /* allocate a new entry in the l2 cache */
 
+    slice_size = s->l2_slice_size * sizeof(uint64_t);
+    n_slices = s->cluster_size / slice_size;
+
     trace_qcow2_l2_allocate_get_empty(bs, l1_index);
-    ret = qcow2_cache_get_empty(bs, s->l2_table_cache, l2_offset, (void**) table);
-    if (ret < 0) {
-        goto fail;
-    }
-
-    l2_table = *table;
-
-    if ((old_l2_offset & L1E_OFFSET_MASK) == 0) {
-        /* if there was no old l2 table, clear the new table */
-        memset(l2_table, 0, s->l2_size * sizeof(uint64_t));
-    } else {
-        uint64_t* old_table;
-
-        /* if there was an old l2 table, read it from the disk */
-        BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_COW_READ);
-        ret = qcow2_cache_get(bs, s->l2_table_cache,
-            old_l2_offset & L1E_OFFSET_MASK,
-            (void**) &old_table);
+    for (slice = 0; slice < n_slices; slice++) {
+        ret = qcow2_cache_get_empty(bs, s->l2_table_cache,
+                                    l2_offset + slice * slice_size,
+                                    (void **) &l2_slice);
         if (ret < 0) {
             goto fail;
         }
 
-        memcpy(l2_table, old_table, s->cluster_size);
+        if ((old_l2_offset & L1E_OFFSET_MASK) == 0) {
+            /* if there was no old l2 table, clear the new slice */
+            memset(l2_slice, 0, slice_size);
+        } else {
+            uint64_t *old_slice;
+            uint64_t old_l2_slice_offset =
+                (old_l2_offset & L1E_OFFSET_MASK) + slice * slice_size;
+
+            /* if there was an old l2 table, read an slice from the disk */
+            BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_COW_READ);
+            ret = qcow2_cache_get(bs, s->l2_table_cache, old_l2_slice_offset,
+                                  (void **) &old_slice);
+            if (ret < 0) {
+                goto fail;
+            }
+
+            memcpy(l2_slice, old_slice, slice_size);
 
-        qcow2_cache_put(s->l2_table_cache, (void **) &old_table);
-    }
+            qcow2_cache_put(s->l2_table_cache, (void **) &old_slice);
+        }
+
+        /* write the l2 slice to the file */
+        BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_WRITE);
 
-    /* write the l2 table to the file */
-    BLKDBG_EVENT(bs->file, BLKDBG_L2_ALLOC_WRITE);
+        trace_qcow2_l2_allocate_write_l2(bs, l1_index);
+        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
+        ret = qcow2_cache_flush(bs, s->l2_table_cache);
+        if (ret < 0) {
+            goto fail;
+        }
 
-    trace_qcow2_l2_allocate_write_l2(bs, l1_index);
-    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
-    ret = qcow2_cache_flush(bs, s->l2_table_cache);
-    if (ret < 0) {
-        goto fail;
+        qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
     }
 
     /* update the L1 entry */
@@ -345,14 +354,13 @@ static int l2_allocate(BlockDriverState *bs, int l1_index, uint64_t **table)
         goto fail;
     }
 
-    *table = l2_table;
     trace_qcow2_l2_allocate_done(bs, l1_index, 0);
     return 0;
 
 fail:
     trace_qcow2_l2_allocate_done(bs, l1_index, ret);
-    if (l2_table != NULL) {
-        qcow2_cache_put(s->l2_table_cache, (void **) table);
+    if (l2_slice != NULL) {
+        qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
     }
     s->l1_table[l1_index] = old_l2_offset;
     if (l2_offset > 0) {
@@ -696,8 +704,18 @@ static int get_cluster_table(BlockDriverState *bs, uint64_t offset,
             return ret;
         }
     } else {
+        uint64_t new_l2_offset;
         /* First allocate a new L2 table (and do COW if needed) */
-        ret = l2_allocate(bs, l1_index, &l2_table);
+        ret = l2_allocate(bs, l1_index);
+        if (ret < 0) {
+            return ret;
+        }
+
+        /* Get the offset of the newly-allocated l2 table */
+        new_l2_offset = s->l1_table[l1_index] & L1E_OFFSET_MASK;
+        assert(offset_into_cluster(s, new_l2_offset) == 0);
+        /* Load the l2 table in memory */
+        ret = l2_load(bs, offset, new_l2_offset, &l2_table);
         if (ret < 0) {
             return ret;
         }
-- 
2.11.0
