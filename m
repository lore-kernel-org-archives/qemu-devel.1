Received: from eggs.gnu.org ([2001:4830:134:3::10]:40409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dW2fx-0004sw-2Q
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dW2fv-0004xL-ED
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:38:41 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 14 Jul 2017 18:37:48 +0300
Message-Id: <20170714153749.25132-4-pbutsykin@virtuozzo.com>
In-Reply-To: <20170714153749.25132-1-pbutsykin@virtuozzo.com>
References: <20170714153749.25132-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 3/4] qcow2: add shrink image support
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
 block/qcow2-cluster.c  |  50 +++++++++++++++++++++
 block/qcow2-refcount.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c          |  43 ++++++++++++++----
 block/qcow2.h          |  14 ++++++
 qapi/block-core.json   |   3 +-
 5 files changed, 220 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f06c08f64c..405bc2e7af 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -32,6 +32,56 @@
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
+                                       new_l1_size * sizeof(uint64_t),
+                             (s->l1_size - new_l1_size) * sizeof(uint64_t), 0);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    ret = bdrv_flush(bs->file->bs);
+    if (ret < 0) {
+        goto fail;
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
+
+fail:
+    /*
+     * If the write in the l1_table failed the image may contain partially
+     * overwritten the l1_table. In this case would be better to clear the
+     * l1_table in memory to avoid possible image corruption.
+     */
+    memset(s->l1_table + exact_size, 0,
+           (s->l1_size - new_l1_size) * sizeof(uint64_t));
+    return ret;
+}
+
 int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
                         bool exact_size)
 {
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index bbe5a2b2cc..6f7c3132c6 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -29,6 +29,7 @@
 #include "block/qcow2.h"
 #include "qemu/range.h"
 #include "qemu/bswap.h"
+#include "qemu/cutils.h"
 
 static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t size);
 static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
@@ -3061,3 +3062,122 @@ done:
     qemu_vfree(new_refblock);
     return ret;
 }
+
+static int qcow2_discard_refcount_block(BlockDriverState *bs,
+                                        uint64_t discard_block_offs)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t refblock_offs = get_refblock_offset(s, discard_block_offs);
+    uint64_t cluster_index = discard_block_offs >> s->cluster_bits;
+    uint32_t block_index = cluster_index & (s->refcount_block_size - 1);
+    void *refblock;
+    int ret;
+
+    assert(discard_block_offs != 0);
+
+    ret = qcow2_cache_get(bs, s->refcount_block_cache, refblock_offs,
+                          &refblock);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (s->get_refcount(refblock, block_index) != 1) {
+        qcow2_signal_corruption(bs, true, -1, -1, "Invalid refcount:"
+                                " refblock offset %#" PRIx64
+                                ", reftable index %u"
+                                ", block offset %#" PRIx64
+                                ", refcount %#" PRIx64,
+                                refblock_offs,
+                                offset_to_reftable_index(s, discard_block_offs),
+                                discard_block_offs,
+                                s->get_refcount(refblock, block_index));
+        qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+        return -EINVAL;
+    }
+    s->set_refcount(refblock, block_index, 0);
+
+    qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache, refblock);
+
+    qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
+
+    if (cluster_index < s->free_cluster_index) {
+        s->free_cluster_index = cluster_index;
+    }
+
+    refblock = qcow2_cache_is_table_offset(bs, s->refcount_block_cache,
+                                           discard_block_offs);
+    if (refblock) {
+        /* discard refblock from the cache if refblock is cached */
+        qcow2_cache_discard(bs, s->refcount_block_cache, refblock);
+    }
+    update_refcount_discard(bs, discard_block_offs, s->cluster_size);
+
+    return 0;
+}
+
+int qcow2_shrink_reftable(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+    uint64_t *reftable_tmp =
+        g_malloc(s->refcount_table_size * sizeof(uint64_t));
+    int i, ret;
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
+                           s->refcount_table_size * sizeof(uint64_t));
+    /*
+     * If the write in the reftable failed the image may contain partially
+     * overwritten the reftable. In this case would be better to clear the
+     * reftable in memory to avoid possible image corruption.
+     */
+    for (i = 0; i < s->refcount_table_size; i++) {
+        if (s->refcount_table[i] && !reftable_tmp[i]) {
+            if (ret == 0) {
+                ret = qcow2_discard_refcount_block(bs, s->refcount_table[i] &
+                                                       REFT_OFFSET_MASK);
+            }
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
index c144ea5620..bd281fdd04 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3120,18 +3120,43 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
     }
 
     old_length = bs->total_sectors * 512;
+    new_l1_size = size_to_l1(s, offset);
 
-    /* shrinking is currently not supported */
     if (offset < old_length) {
-        error_setg(errp, "qcow2 doesn't support shrinking images yet");
-        return -ENOTSUP;
-    }
+        if (prealloc != PREALLOC_MODE_OFF) {
+            error_setg(errp,
+                       "Preallocation can't be used for shrinking an image");
+            return -EINVAL;
+        }
 
-    new_l1_size = size_to_l1(s, offset);
-    ret = qcow2_grow_l1_table(bs, new_l1_size, true);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "Failed to grow the L1 table");
-        return ret;
+        ret = qcow2_cluster_discard(bs, ROUND_UP(offset, s->cluster_size),
+                                    old_length - ROUND_UP(offset,
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
 
     switch (prealloc) {
diff --git a/block/qcow2.h b/block/qcow2.h
index 52c374e9ed..5a289a81e2 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -521,6 +521,18 @@ static inline uint64_t refcount_diff(uint64_t r1, uint64_t r2)
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
@@ -584,10 +596,12 @@ int qcow2_inc_refcounts_imrt(BlockDriverState *bs, BdrvCheckResult *res,
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
index c437aa50ef..99cef55b7c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2487,7 +2487,8 @@
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
