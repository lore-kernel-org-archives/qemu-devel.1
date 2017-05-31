Received: from eggs.gnu.org ([2001:4830:134:3::10]:37617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dG4r2-00013k-Jz
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dG4r1-0004tR-0o
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:44:08 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Wed, 31 May 2017 17:43:30 +0300
Message-ID: <20170531144331.30173-2-pbutsykin@virtuozzo.com>
In-Reply-To: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/2] qcow2: add reduce image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, pbutsykin@virtuozzo.com

This patch adds the reduction of the image file for qcow2. As a result, this
allows us to reduce the virtual image size and free up space on the disk without
copying the image. Image can be fragmented and reduction is done by punching
holes in the image file.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 block/qcow2-cache.c    |  8 +++++
 block/qcow2-cluster.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2-refcount.c | 65 +++++++++++++++++++++++++++++++++++++++
 block/qcow2.c          | 40 ++++++++++++++++++------
 block/qcow2.h          |  4 +++
 qapi/block-core.json   |  4 ++-
 6 files changed, 193 insertions(+), 11 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 1d25147392..da55118ca7 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -411,3 +411,11 @@ void qcow2_cache_entry_mark_dirty(BlockDriverState *bs, Qcow2Cache *c,
     assert(c->entries[i].offset != 0);
     c->entries[i].dirty = true;
 }
+
+void qcow2_cache_entry_mark_clean(BlockDriverState *bs, Qcow2Cache *c,
+     void *table)
+{
+    int i = qcow2_cache_get_table_idx(bs, c, table);
+    assert(c->entries[i].offset != 0);
+    c->entries[i].dirty = false;
+}
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 347d94b0d2..47e04d7317 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -32,6 +32,89 @@
 #include "qemu/bswap.h"
 #include "trace.h"
 
+int qcow2_reduce_l1_table(BlockDriverState *bs, uint64_t max_size)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int64_t new_l1_size_bytes, free_l1_clusters;
+    uint64_t *new_l1_table;
+    int new_l1_size, i, ret;
+
+    if (max_size >= s->l1_size) {
+        return 0;
+    }
+
+    new_l1_size = max_size;
+
+#ifdef DEBUG_ALLOC2
+    fprintf(stderr, "reduce l1_table from %d to %" PRId64 "\n",
+            s->l1_size, new_l1_size);
+#endif
+
+    ret = qcow2_cache_flush(bs, s->l2_table_cache);
+    if (ret < 0) {
+        return ret;
+    }
+
+    BLKDBG_EVENT(bs->file, BLKDBG_L1_REDUCE_FREE_L2_CLUSTERS);
+    for (i = s->l1_size - 1; i > new_l1_size - 1; i--) {
+        if ((s->l1_table[i] & L1E_OFFSET_MASK) == 0) {
+            continue;
+        }
+        qcow2_free_clusters(bs, s->l1_table[i] & L1E_OFFSET_MASK,
+                            s->l2_size * sizeof(uint64_t),
+                            QCOW2_DISCARD_ALWAYS);
+    }
+
+    new_l1_size_bytes = sizeof(uint64_t) * new_l1_size;
+
+    BLKDBG_EVENT(bs->file, BLKDBG_L1_REDUCE_WRITE_TABLE);
+    ret = bdrv_pwrite_zeroes(bs->file, s->l1_table_offset + new_l1_size_bytes,
+                             s->l1_size * sizeof(uint64_t) - new_l1_size_bytes,
+                             0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = bdrv_flush(bs->file->bs);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* set new table size */
+    BLKDBG_EVENT(bs->file, BLKDBG_L1_REDUCE_ACTIVATE_TABLE);
+    new_l1_size = cpu_to_be32(new_l1_size);
+    ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, l1_size),
+                           &new_l1_size, sizeof(new_l1_size));
+    new_l1_size = be32_to_cpu(new_l1_size);
+    if (ret < 0) {
+        return ret;
+    }
+
+    BLKDBG_EVENT(bs->file, BLKDBG_L1_REDUCE_FREE_L1_CLUSTERS);
+    free_l1_clusters =
+        DIV_ROUND_UP(s->l1_size * sizeof(uint64_t), s->cluster_size) -
+        DIV_ROUND_UP(new_l1_size_bytes, s->cluster_size);
+    if (free_l1_clusters) {
+        qcow2_free_clusters(bs, s->l1_table_offset +
+                                ROUND_UP(new_l1_size_bytes, s->cluster_size),
+                            free_l1_clusters << s->cluster_bits,
+                            QCOW2_DISCARD_ALWAYS);
+    }
+
+    new_l1_table = qemu_try_blockalign(bs->file->bs,
+                                       align_offset(new_l1_size_bytes, 512));
+    if (new_l1_table == NULL) {
+        return -ENOMEM;
+    }
+    memcpy(new_l1_table, s->l1_table, new_l1_size_bytes);
+
+    qemu_vfree(s->l1_table);
+    s->l1_table = new_l1_table;
+    s->l1_size = new_l1_size;
+
+    return 0;
+}
+
 int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
                         bool exact_size)
 {
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 7c06061aae..5481b623cd 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -29,6 +29,7 @@
 #include "block/qcow2.h"
 #include "qemu/range.h"
 #include "qemu/bswap.h"
+#include "qemu/cutils.h"
 
 static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size);
 static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
@@ -2931,3 +2932,67 @@ done:
     qemu_vfree(new_refblock);
     return ret;
 }
+
+int qcow2_reftable_shrink(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int i, ret;
+
+    ret = qcow2_cache_flush(bs, s->refcount_block_cache);
+    if (ret < 0) {
+        return ret;
+    }
+
+    for (i = 0; i < s->refcount_table_size; i++) {
+        int64_t refblock_offs = s->refcount_table[i] & REFT_OFFSET_MASK;
+        void *refblock;
+        bool unused_block;
+
+        if (refblock_offs == 0) {
+            continue;
+        }
+        ret = qcow2_cache_get(bs, s->refcount_block_cache, refblock_offs,
+                              &refblock);
+        if (ret < 0) {
+            return ret;
+        }
+
+        /* the refblock has own reference */
+        if (i == refblock_offs >> (s->refcount_block_bits + s->cluster_bits)) {
+            uint64_t blk_index = (refblock_offs >> s->cluster_bits) &
+                                 (s->refcount_block_size - 1);
+            uint64_t refcount = s->get_refcount(refblock, blk_index);
+
+            s->set_refcount(refblock, blk_index, 0);
+
+            unused_block = buffer_is_zero(refblock, s->refcount_block_size);
+
+            s->set_refcount(refblock, blk_index, refcount);
+        } else {
+            unused_block = buffer_is_zero(refblock, s->refcount_block_size);
+        }
+
+        if (unused_block) {
+            qcow2_free_clusters(bs, refblock_offs, s->cluster_size,
+                                QCOW2_DISCARD_ALWAYS);
+            qcow2_cache_entry_mark_clean(bs, s->refcount_block_cache, refblock);
+            s->refcount_table[i] = 0;
+        }
+        qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+    }
+
+    for (i = 0; i < s->refcount_table_size; i++) {
+        s->refcount_table[i] = cpu_to_be64(s->refcount_table[i]);
+    }
+    ret = bdrv_pwrite_sync(bs->file, s->refcount_table_offset,
+                            s->refcount_table,
+                            sizeof(uint64_t) * s->refcount_table_size);
+    if (ret < 0) {
+        return ret;
+    }
+    for (i = 0; i < s->refcount_table_size; i++) {
+        s->refcount_table[i] = be64_to_cpu(s->refcount_table[i]);
+    }
+
+    return 0;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index a8d61f0981..4da8bc85d1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2545,6 +2545,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     int64_t new_l1_size;
+    uint64_t total_size;
     int ret;
 
     if (offset & 511) {
@@ -2558,17 +2559,36 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
         return -ENOTSUP;
     }
 
-    /* shrinking is currently not supported */
-    if (offset < bs->total_sectors * 512) {
-        error_setg(errp, "qcow2 doesn't support shrinking images yet");
-        return -ENOTSUP;
-    }
-
     new_l1_size = size_to_l1(s, offset);
-    ret = qcow2_grow_l1_table(bs, new_l1_size, true);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "Failed to grow the L1 table");
-        return ret;
+    total_size = bs->total_sectors << BDRV_SECTOR_BITS;
+
+    if (offset < total_size) {
+        ret = qcow2_cluster_discard(bs, ROUND_UP(offset, s->cluster_size),
+                                    total_size - ROUND_UP(offset,
+                                                          s->cluster_size),
+                                    QCOW2_DISCARD_ALWAYS, true);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to discard reduced clasters");
+            return ret;
+        }
+
+        ret = qcow2_reduce_l1_table(bs, new_l1_size);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to reduce the L1 table");
+            return ret;
+        }
+
+        ret = qcow2_reftable_shrink(bs);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to shrink the refcount table");
+            return ret;
+        }
+    } else {
+        ret = qcow2_grow_l1_table(bs, new_l1_size, true);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to grow the L1 table");
+            return ret;
+        }
     }
 
     /* write updated header.size */
diff --git a/block/qcow2.h b/block/qcow2.h
index 1801dc30dc..03cebabb3d 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -531,10 +531,12 @@ int qcow2_pre_write_overlap_check(BlockDriverState *bs, int ign, int64_t offset,
 int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
                                 BlockDriverAmendStatusCB *status_cb,
                                 void *cb_opaque, Error **errp);
+int qcow2_reftable_shrink(BlockDriverState *bs);
 
 /* qcow2-cluster.c functions */
 int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
                         bool exact_size);
+int qcow2_reduce_l1_table(BlockDriverState *bs, uint64_t max_size);
 int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index);
 int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset);
 int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
@@ -583,6 +585,8 @@ int qcow2_cache_destroy(BlockDriverState* bs, Qcow2Cache *c);
 
 void qcow2_cache_entry_mark_dirty(BlockDriverState *bs, Qcow2Cache *c,
      void *table);
+void qcow2_cache_entry_mark_clean(BlockDriverState *bs, Qcow2Cache *c,
+     void *table);
 int qcow2_cache_flush(BlockDriverState *bs, Qcow2Cache *c);
 int qcow2_cache_write(BlockDriverState *bs, Qcow2Cache *c);
 int qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6b974b952f..dcd2d0241f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2371,7 +2371,9 @@
             'cluster_alloc_bytes', 'cluster_free', 'flush_to_os',
             'flush_to_disk', 'pwritev_rmw_head', 'pwritev_rmw_after_head',
             'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
-            'pwritev_zero', 'pwritev_done', 'empty_image_prepare' ] }
+            'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
+            'l1_reduce_write_table', 'l1_reduce_activate_table',
+            'l1_reduce_free_l2_clusters', 'l1_reduce_free_l1_clusters' ] }
 
 ##
 # @BlkdebugInjectErrorOptions:
-- 
2.11.0
