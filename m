Received: from eggs.gnu.org ([2001:4830:134:3::10]:34649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dUuXZ-0006OB-S2
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dUuXY-0005md-4S
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:45:21 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Tue, 11 Jul 2017 15:40:23 +0300
Message-Id: <20170711124024.1396-4-pbutsykin@virtuozzo.com>
In-Reply-To: <20170711124024.1396-1-pbutsykin@virtuozzo.com>
References: <20170711124024.1396-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 3/4] qcow2: add shrink image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org, pbutsykin@virtuozzo.com

This patch add shrinking of the image file for qcow2. As a result, this allows
us to reduce the virtual image size and free up space on the disk without
copying the image. Image can be fragmented and shrink is done by punching holes
in the image file.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c  |  40 ++++++++++++++++++
 block/qcow2-refcount.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c          |  42 ++++++++++++++-----
 block/qcow2.h          |  14 +++++++
 qapi/block-core.json   |   3 +-
 5 files changed, 198 insertions(+), 11 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 3d341fd9cb..04d48878af 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -32,6 +32,46 @@
 #include "qemu/bswap.h"
 #include "trace.h"
 
+int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t exact_size)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int new_l1_size, i, ret;
+
+    if (exact_size >= s->l1_size) {
+        return 0;
+    }
+
+    new_l1_size = exact_size;
+
+#ifdef DEBUG_ALLOC2
+    fprintf(stderr, "shrink l1_table from %d to %d\n", s->l1_size, new_l1_size);
+#endif
+
+    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_WRITE_TABLE);
+    ret = bdrv_pwrite_zeroes(bs->file, s->l1_table_offset +
+                                       sizeof(uint64_t) * new_l1_size,
+                             (s->l1_size - new_l1_size) * sizeof(uint64_t), 0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = bdrv_flush(bs->file->bs);
+    if (ret < 0) {
+        return ret;
+    }
+
+    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_FREE_L2_CLUSTERS);
+    for (i = s->l1_size - 1; i > new_l1_size - 1; i--) {
+        if ((s->l1_table[i] & L1E_OFFSET_MASK) == 0) {
+            continue;
+        }
+        qcow2_free_clusters(bs, s->l1_table[i] & L1E_OFFSET_MASK,
+                            s->cluster_size, QCOW2_DISCARD_ALWAYS);
+        s->l1_table[i] = 0;
+    }
+    return 0;
+}
+
 int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
                         bool exact_size)
 {
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 0141c9cbe7..e52d1698b5 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -29,6 +29,7 @@
 #include "block/qcow2.h"
 #include "qemu/range.h"
 #include "qemu/bswap.h"
+#include "qemu/cutils.h"
 
 static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size);
 static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
@@ -2945,3 +2946,112 @@ done:
     qemu_vfree(new_refblock);
     return ret;
 }
+
+int qcow2_shrink_reftable(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t *reftable_tmp =
+        g_try_malloc(sizeof(uint64_t) * s->refcount_table_size);
+    int i, ret;
+
+    if (s->refcount_table_size && reftable_tmp == NULL) {
+        return -ENOMEM;
+    }
+
+    for (i = 0; i < s->refcount_table_size; i++) {
+        int64_t refblock_offs = s->refcount_table[i] & REFT_OFFSET_MASK;
+        void *refblock;
+        bool unused_block;
+
+        if (refblock_offs == 0) {
+            reftable_tmp[i] = 0;
+            continue;
+        }
+        ret = qcow2_cache_get(bs, s->refcount_block_cache, refblock_offs,
+                              &refblock);
+        if (ret < 0) {
+            goto out;
+        }
+
+        /* the refblock has own reference */
+        if (i == offset_to_reftable_index(s, refblock_offs)) {
+            uint64_t block_index = (refblock_offs >> s->cluster_bits) &
+                                   (s->refcount_block_size - 1);
+            uint64_t refcount = s->get_refcount(refblock, block_index);
+
+            s->set_refcount(refblock, block_index, 0);
+
+            unused_block = buffer_is_zero(refblock, s->cluster_size);
+
+            s->set_refcount(refblock, block_index, refcount);
+        } else {
+            unused_block = buffer_is_zero(refblock, s->cluster_size);
+        }
+        qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+
+        reftable_tmp[i] = unused_block ? 0 : cpu_to_be64(s->refcount_table[i]);
+    }
+
+    ret = bdrv_pwrite_sync(bs->file, s->refcount_table_offset, reftable_tmp,
+                           sizeof(uint64_t) * s->refcount_table_size);
+    if (ret < 0) {
+        goto out;
+    }
+
+    for (i = 0; i < s->refcount_table_size; i++) {
+        if (s->refcount_table[i] && !reftable_tmp[i]) {
+            uint64_t discard_offs = s->refcount_table[i] & REFT_OFFSET_MASK;
+            uint64_t refblock_offs = get_refblock_offset(s, discard_offs);
+            uint64_t cluster_index = discard_offs >> s->cluster_bits;
+            uint32_t block_index = cluster_index & (s->refcount_block_size - 1);
+            void *refblock;
+
+            assert(discard_offs != 0);
+
+            ret = qcow2_cache_get(bs, s->refcount_block_cache, refblock_offs,
+                                  &refblock);
+            if (ret < 0) {
+                goto out;
+            }
+
+            if (s->get_refcount(refblock, block_index) != 1) {
+                qcow2_signal_corruption(bs, true, -1, -1, "Invalid refcount:"
+                                        " refblock offset %#" PRIx64
+                                        ", reftable index %d"
+                                        ", block offset %#" PRIx64
+                                        ", refcount %#" PRIx64,
+                                        refblock_offs, i, discard_offs,
+                                        s->get_refcount(refblock, block_index));
+                qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+                ret = -EINVAL;
+                goto out;
+            }
+            s->set_refcount(refblock, block_index, 0);
+
+            qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache, refblock);
+
+            qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+
+            if (cluster_index < s->free_cluster_index) {
+                s->free_cluster_index = cluster_index;
+            }
+
+            refblock = qcow2_cache_is_table_offset(bs, s->refcount_block_cache,
+                                                   discard_offs);
+            if (refblock) {
+                /* discard refblock from the cache if refblock is cached */
+                qcow2_cache_discard(bs, s->refcount_block_cache, refblock);
+            }
+            update_refcount_discard(bs, discard_offs, s->cluster_size);
+            s->refcount_table[i] = 0;
+        }
+    }
+
+    if (!s->cache_discards) {
+        qcow2_process_discards(bs, ret);
+    }
+
+out:
+    g_free(reftable_tmp);
+    return ret;
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index 2f94f0326e..c7506ed971 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2589,6 +2589,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     int64_t new_l1_size;
+    uint64_t total_size;
     int ret;
 
     if (offset & 511) {
@@ -2602,17 +2603,38 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset, Error **errp)
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
+            error_setg_errno(errp, -ret, "Failed to discard cropped clusters");
+            return ret;
+        }
+
+        ret = qcow2_shrink_l1_table(bs, new_l1_size);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "Failed to reduce the number of L2 tables");
+            return ret;
+        }
+
+        ret = qcow2_shrink_reftable(bs);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
+                             "Failed to discard unused refblocks");
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
index bf6691dbd0..82e83dc0d5 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -488,6 +488,18 @@ static inline uint64_t refcount_diff(uint64_t r1, uint64_t r2)
     return r1 > r2 ? r1 - r2 : r2 - r1;
 }
 
+static inline
+uint32_t offset_to_reftable_index(BDRVQcow2State *s, uint64_t offset)
+{
+    return offset >> (s->refcount_block_bits + s->cluster_bits);
+}
+
+static inline uint64_t get_refblock_offset(BDRVQcow2State *s, uint64_t offset)
+{
+    uint32_t index = offset_to_reftable_index(s, offset);
+    return s->refcount_table[index] & REFT_OFFSET_MASK;
+}
+
 /* qcow2.c functions */
 int qcow2_backing_read1(BlockDriverState *bs, QEMUIOVector *qiov,
                   int64_t sector_num, int nb_sectors);
@@ -538,10 +550,12 @@ int qcow2_pre_write_overlap_check(BlockDriverState *bs, int ign, int64_t offset,
 int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_order,
                                 BlockDriverAmendStatusCB *status_cb,
                                 void *cb_opaque, Error **errp);
+int qcow2_shrink_reftable(BlockDriverState *bs);
 
 /* qcow2-cluster.c functions */
 int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
                         bool exact_size);
+int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t max_size);
 int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index);
 int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_offset);
 int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index f85c2235c7..bcbffa3339 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2372,7 +2372,8 @@
             'cluster_alloc_bytes', 'cluster_free', 'flush_to_os',
             'flush_to_disk', 'pwritev_rmw_head', 'pwritev_rmw_after_head',
             'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
-            'pwritev_zero', 'pwritev_done', 'empty_image_prepare' ] }
+            'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
+            'l1_shrink_write_table', 'l1_shrink_free_l2_clusters' ] }
 
 ##
 # @BlkdebugInjectErrorOptions:
-- 
2.13.0
