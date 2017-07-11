Received: from eggs.gnu.org ([2001:4830:134:3::10]:47337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxmi-0002Xx-Bk
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxmg-0007Vw-Bv
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:13:12 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:08:10 +0200
Message-Id: <20170711160814.20941-82-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 81/85] block/qcow2: Add qcow2_refcount_area()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

This function creates a collection of self-describing refcount
structures (including a new refcount table) at the end of a qcow2 image
file. Optionally, these structures can also describe a number of
additional clusters beyond themselves; this will be important for
preallocated truncation, which will place the data clusters and L2
tables there.

For now, we can use this function to replace the part of
alloc_refcount_block() that grows the refcount table (from which it is
actually derived).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170613202107.10125-13-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h              |   4 +
 block/qcow2-refcount.c     | 267 +++++++++++++++++++++++++++++++--------------
 block/qcow2.c              |  20 +++-
 tests/qemu-iotests/044.out |   2 +-
 4 files changed, 204 insertions(+), 89 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 2df05ac..3854080 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -525,6 +525,10 @@ static inline uint64_t refcount_diff(uint64_t r1, uint64_t r2)
 int qcow2_backing_read1(BlockDriverState *bs, QEMUIOVector *qiov,
                   int64_t sector_num, int nb_sectors);
 
+int64_t qcow2_refcount_metadata_size(int64_t clusters, size_t cluster_size,
+                                     int refcount_order, bool generous_increase,
+                                     uint64_t *refblock_count);
+
 int qcow2_mark_dirty(BlockDriverState *bs);
 int qcow2_mark_corrupt(BlockDriverState *bs);
 int qcow2_mark_consistent(BlockDriverState *bs);
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index e82e155..082b5de 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -34,6 +34,10 @@ static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size);
 static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
                             int64_t offset, int64_t length, uint64_t addend,
                             bool decrease, enum qcow2_discard_type type);
+static int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t offset,
+                                   uint64_t additional_clusters,
+                                   bool exact_size, int new_refblock_index,
+                                   uint64_t new_refblock_offset);
 
 static uint64_t get_refcount_ro0(const void *refcount_array, uint64_t index);
 static uint64_t get_refcount_ro1(const void *refcount_array, uint64_t index);
@@ -281,25 +285,6 @@ int qcow2_get_refcount(BlockDriverState *bs, int64_t cluster_index,
     return 0;
 }
 
-/*
- * Rounds the refcount table size up to avoid growing the table for each single
- * refcount block that is allocated.
- */
-static unsigned int next_refcount_table_size(BDRVQcow2State *s,
-    unsigned int min_size)
-{
-    unsigned int min_clusters = (min_size >> (s->cluster_bits - 3)) + 1;
-    unsigned int refcount_table_clusters =
-        MAX(1, s->refcount_table_size >> (s->cluster_bits - 3));
-
-    while (min_clusters > refcount_table_clusters) {
-        refcount_table_clusters = (refcount_table_clusters * 3 + 1) / 2;
-    }
-
-    return refcount_table_clusters << (s->cluster_bits - 3);
-}
-
-
 /* Checks if two offsets are described by the same refcount block */
 static int in_same_refcount_block(BDRVQcow2State *s, uint64_t offset_a,
     uint64_t offset_b)
@@ -321,7 +306,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
 {
     BDRVQcow2State *s = bs->opaque;
     unsigned int refcount_table_index;
-    int ret;
+    int64_t ret;
 
     BLKDBG_EVENT(bs->file, BLKDBG_REFBLOCK_ALLOC);
 
@@ -490,74 +475,201 @@ static int alloc_refcount_block(BlockDriverState *bs,
                                             (new_block >> s->cluster_bits) + 1),
                                         s->refcount_block_size);
 
-    if (blocks_used > QCOW_MAX_REFTABLE_SIZE / sizeof(uint64_t)) {
-        return -EFBIG;
+    /* Create the new refcount table and blocks */
+    uint64_t meta_offset = (blocks_used * s->refcount_block_size) *
+        s->cluster_size;
+
+    ret = qcow2_refcount_area(bs, meta_offset, 0, false,
+                              refcount_table_index, new_block);
+    if (ret < 0) {
+        return ret;
     }
 
-    /* And now we need at least one block more for the new metadata */
-    uint64_t table_size = next_refcount_table_size(s, blocks_used + 1);
-    uint64_t last_table_size;
-    uint64_t blocks_clusters;
-    do {
-        uint64_t table_clusters =
-            size_to_clusters(s, table_size * sizeof(uint64_t));
-        blocks_clusters = 1 +
-            DIV_ROUND_UP(table_clusters, s->refcount_block_size);
-        uint64_t meta_clusters = table_clusters + blocks_clusters;
+    ret = load_refcount_block(bs, new_block, refcount_block);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* If we were trying to do the initial refcount update for some cluster
+     * allocation, we might have used the same clusters to store newly
+     * allocated metadata. Make the caller search some new space. */
+    return -EAGAIN;
+
+fail_block:
+    if (*refcount_block != NULL) {
+        qcow2_cache_put(bs, s->refcount_block_cache, refcount_block);
+    }
+    return ret;
+}
+
+/*
+ * Starting at @start_offset, this function creates new self-covering refcount
+ * structures: A new refcount table and refcount blocks which cover all of
+ * themselves, and a number of @additional_clusters beyond their end.
+ * @start_offset must be at the end of the image file, that is, there must be
+ * only empty space beyond it.
+ * If @exact_size is false, the refcount table will have 50 % more entries than
+ * necessary so it will not need to grow again soon.
+ * If @new_refblock_offset is not zero, it contains the offset of a refcount
+ * block that should be entered into the new refcount table at index
+ * @new_refblock_index.
+ *
+ * Returns: The offset after the new refcount structures (i.e. where the
+ *          @additional_clusters may be placed) on success, -errno on error.
+ */
+static int64_t qcow2_refcount_area(BlockDriverState *bs, uint64_t start_offset,
+                                   uint64_t additional_clusters,
+                                   bool exact_size, int new_refblock_index,
+                                   uint64_t new_refblock_offset)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t total_refblock_count_u64, additional_refblock_count;
+    int total_refblock_count, table_size, area_reftable_index, table_clusters;
+    int i;
+    uint64_t table_offset, block_offset, end_offset;
+    int ret;
+    uint64_t *new_table;
 
-        last_table_size = table_size;
-        table_size = next_refcount_table_size(s, blocks_used +
-            DIV_ROUND_UP(meta_clusters, s->refcount_block_size));
+    assert(!(start_offset % s->cluster_size));
 
-    } while (last_table_size != table_size);
+    qcow2_refcount_metadata_size(start_offset / s->cluster_size +
+                                 additional_clusters,
+                                 s->cluster_size, s->refcount_order,
+                                 !exact_size, &total_refblock_count_u64);
+    if (total_refblock_count_u64 > QCOW_MAX_REFTABLE_SIZE) {
+        return -EFBIG;
+    }
+    total_refblock_count = total_refblock_count_u64;
 
-#ifdef DEBUG_ALLOC2
-    fprintf(stderr, "qcow2: Grow refcount table %" PRId32 " => %" PRId64 "\n",
-        s->refcount_table_size, table_size);
-#endif
+    /* Index in the refcount table of the first refcount block to cover the area
+     * of refcount structures we are about to create; we know that
+     * @total_refblock_count can cover @start_offset, so this will definitely
+     * fit into an int. */
+    area_reftable_index = (start_offset / s->cluster_size) /
+                          s->refcount_block_size;
 
-    /* Create the new refcount table and blocks */
-    uint64_t meta_offset = (blocks_used * s->refcount_block_size) *
-        s->cluster_size;
-    uint64_t table_offset = meta_offset + blocks_clusters * s->cluster_size;
-    uint64_t *new_table = g_try_new0(uint64_t, table_size);
-    void *new_blocks = g_try_malloc0(blocks_clusters * s->cluster_size);
+    if (exact_size) {
+        table_size = total_refblock_count;
+    } else {
+        table_size = total_refblock_count +
+                     DIV_ROUND_UP(total_refblock_count, 2);
+    }
+    /* The qcow2 file can only store the reftable size in number of clusters */
+    table_size = ROUND_UP(table_size, s->cluster_size / sizeof(uint64_t));
+    table_clusters = (table_size * sizeof(uint64_t)) / s->cluster_size;
 
-    assert(table_size > 0 && blocks_clusters > 0);
-    if (new_table == NULL || new_blocks == NULL) {
+    if (table_size > QCOW_MAX_REFTABLE_SIZE) {
+        return -EFBIG;
+    }
+
+    new_table = g_try_new0(uint64_t, table_size);
+
+    assert(table_size > 0);
+    if (new_table == NULL) {
         ret = -ENOMEM;
-        goto fail_table;
+        goto fail;
     }
 
     /* Fill the new refcount table */
-    memcpy(new_table, s->refcount_table,
-        s->refcount_table_size * sizeof(uint64_t));
-    new_table[refcount_table_index] = new_block;
+    if (table_size > s->max_refcount_table_index) {
+        /* We're actually growing the reftable */
+        memcpy(new_table, s->refcount_table,
+               (s->max_refcount_table_index + 1) * sizeof(uint64_t));
+    } else {
+        /* Improbable case: We're shrinking the reftable. However, the caller
+         * has assured us that there is only empty space beyond @start_offset,
+         * so we can simply drop all of the refblocks that won't fit into the
+         * new reftable. */
+        memcpy(new_table, s->refcount_table, table_size * sizeof(uint64_t));
+    }
 
-    int i;
-    for (i = 0; i < blocks_clusters; i++) {
-        new_table[blocks_used + i] = meta_offset + (i * s->cluster_size);
+    if (new_refblock_offset) {
+        assert(new_refblock_index < total_refblock_count);
+        new_table[new_refblock_index] = new_refblock_offset;
     }
 
-    /* Fill the refcount blocks */
-    uint64_t table_clusters = size_to_clusters(s, table_size * sizeof(uint64_t));
-    int block = 0;
-    for (i = 0; i < table_clusters + blocks_clusters; i++) {
-        s->set_refcount(new_blocks, block++, 1);
+    /* Count how many new refblocks we have to create */
+    additional_refblock_count = 0;
+    for (i = area_reftable_index; i < total_refblock_count; i++) {
+        if (!new_table[i]) {
+            additional_refblock_count++;
+        }
     }
 
+    table_offset = start_offset + additional_refblock_count * s->cluster_size;
+    end_offset = table_offset + table_clusters * s->cluster_size;
+
+    /* Fill the refcount blocks, and create new ones, if necessary */
+    block_offset = start_offset;
+    for (i = area_reftable_index; i < total_refblock_count; i++) {
+        void *refblock_data;
+        uint64_t first_offset_covered;
+
+        /* Reuse an existing refblock if possible, create a new one otherwise */
+        if (new_table[i]) {
+            ret = qcow2_cache_get(bs, s->refcount_block_cache, new_table[i],
+                                  &refblock_data);
+            if (ret < 0) {
+                goto fail;
+            }
+        } else {
+            ret = qcow2_cache_get_empty(bs, s->refcount_block_cache,
+                                        block_offset, &refblock_data);
+            if (ret < 0) {
+                goto fail;
+            }
+            memset(refblock_data, 0, s->cluster_size);
+            qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache,
+                                         refblock_data);
+
+            new_table[i] = block_offset;
+            block_offset += s->cluster_size;
+        }
+
+        /* First host offset covered by this refblock */
+        first_offset_covered = (uint64_t)i * s->refcount_block_size *
+                               s->cluster_size;
+        if (first_offset_covered < end_offset) {
+            int j, end_index;
+
+            /* Set the refcount of all of the new refcount structures to 1 */
+
+            if (first_offset_covered < start_offset) {
+                assert(i == area_reftable_index);
+                j = (start_offset - first_offset_covered) / s->cluster_size;
+                assert(j < s->refcount_block_size);
+            } else {
+                j = 0;
+            }
+
+            end_index = MIN((end_offset - first_offset_covered) /
+                            s->cluster_size,
+                            s->refcount_block_size);
+
+            for (; j < end_index; j++) {
+                /* The caller guaranteed us this space would be empty */
+                assert(s->get_refcount(refblock_data, j) == 0);
+                s->set_refcount(refblock_data, j, 1);
+            }
+
+            qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache,
+                                         refblock_data);
+        }
+
+        qcow2_cache_put(bs, s->refcount_block_cache, &refblock_data);
+    }
+
+    assert(block_offset == table_offset);
+
     /* Write refcount blocks to disk */
     BLKDBG_EVENT(bs->file, BLKDBG_REFBLOCK_ALLOC_WRITE_BLOCKS);
-    ret = bdrv_pwrite_sync(bs->file, meta_offset, new_blocks,
-        blocks_clusters * s->cluster_size);
-    g_free(new_blocks);
-    new_blocks = NULL;
+    ret = qcow2_cache_flush(bs, s->refcount_block_cache);
     if (ret < 0) {
-        goto fail_table;
+        goto fail;
     }
 
     /* Write refcount table to disk */
-    for(i = 0; i < table_size; i++) {
+    for (i = 0; i < total_refblock_count; i++) {
         cpu_to_be64s(&new_table[i]);
     }
 
@@ -565,10 +677,10 @@ static int alloc_refcount_block(BlockDriverState *bs,
     ret = bdrv_pwrite_sync(bs->file, table_offset, new_table,
         table_size * sizeof(uint64_t));
     if (ret < 0) {
-        goto fail_table;
+        goto fail;
     }
 
-    for(i = 0; i < table_size; i++) {
+    for (i = 0; i < total_refblock_count; i++) {
         be64_to_cpus(&new_table[i]);
     }
 
@@ -584,7 +696,7 @@ static int alloc_refcount_block(BlockDriverState *bs,
                            offsetof(QCowHeader, refcount_table_offset),
                            &data, sizeof(data));
     if (ret < 0) {
-        goto fail_table;
+        goto fail;
     }
 
     /* And switch it in memory */
@@ -601,23 +713,10 @@ static int alloc_refcount_block(BlockDriverState *bs,
     qcow2_free_clusters(bs, old_table_offset, old_table_size * sizeof(uint64_t),
                         QCOW2_DISCARD_OTHER);
 
-    ret = load_refcount_block(bs, new_block, refcount_block);
-    if (ret < 0) {
-        return ret;
-    }
-
-    /* If we were trying to do the initial refcount update for some cluster
-     * allocation, we might have used the same clusters to store newly
-     * allocated metadata. Make the caller search some new space. */
-    return -EAGAIN;
+    return end_offset;
 
-fail_table:
-    g_free(new_blocks);
+fail:
     g_free(new_table);
-fail_block:
-    if (*refcount_block != NULL) {
-        qcow2_cache_put(bs, s->refcount_block_cache, refcount_block);
-    }
     return ret;
 }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 47537d0..46edea8 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2559,12 +2559,14 @@ done:
  * @clusters: number of clusters to refcount (including data and L1/L2 tables)
  * @cluster_size: size of a cluster, in bytes
  * @refcount_order: refcount bits power-of-2 exponent
+ * @generous_increase: allow for the refcount table to be 1.5x as large as it
+ *                     needs to be
  *
  * Returns: Number of bytes required for refcount blocks and table metadata.
  */
-static int64_t qcow2_refcount_metadata_size(int64_t clusters,
-                                            size_t cluster_size,
-                                            int refcount_order)
+int64_t qcow2_refcount_metadata_size(int64_t clusters, size_t cluster_size,
+                                     int refcount_order, bool generous_increase,
+                                     uint64_t *refblock_count)
 {
     /*
      * Every host cluster is reference-counted, including metadata (even
@@ -2587,8 +2589,18 @@ static int64_t qcow2_refcount_metadata_size(int64_t clusters,
         blocks = DIV_ROUND_UP(clusters + table + blocks, refcounts_per_block);
         table = DIV_ROUND_UP(blocks, blocks_per_table_cluster);
         n = clusters + blocks + table;
+
+        if (n == last && generous_increase) {
+            clusters += DIV_ROUND_UP(table, 2);
+            n = 0; /* force another loop */
+            generous_increase = false;
+        }
     } while (n != last);
 
+    if (refblock_count) {
+        *refblock_count = blocks;
+    }
+
     return (blocks + table) * cluster_size;
 }
 
@@ -2625,7 +2637,7 @@ static int64_t qcow2_calc_prealloc_size(int64_t total_size,
     /* total size of refcount table and blocks */
     meta_size += qcow2_refcount_metadata_size(
             (meta_size + aligned_total_size) / cluster_size,
-            cluster_size, refcount_order);
+            cluster_size, refcount_order, false, NULL);
 
     return meta_size + aligned_total_size;
 }
diff --git a/tests/qemu-iotests/044.out b/tests/qemu-iotests/044.out
index 4789a53..703cf3d 100644
--- a/tests/qemu-iotests/044.out
+++ b/tests/qemu-iotests/044.out
@@ -1,6 +1,6 @@
 No errors were found on the image.
 7292415/33554432 = 21.73% allocated, 0.00% fragmented, 0.00% compressed clusters
-Image end offset: 4296152064
+Image end offset: 4296217088
 .
 ----------------------------------------------------------------------
 Ran 1 tests
-- 
2.9.4
