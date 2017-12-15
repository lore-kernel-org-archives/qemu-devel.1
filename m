Received: from eggs.gnu.org ([2001:4830:134:3::10]:55572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVI-0000X9-7T
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003JZ-U3
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:16 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:53 +0100
Message-Id: <1fb1816d471d712f2001ca3ce42c6682273c7daf.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 25/32] qcow2: Update
 expand_zero_clusters_in_l1() to support L2 slices
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

expand_zero_clusters_in_l1() expands zero clusters as a necessary step
to downgrade qcow2 images to a version that doesn't support metadata
zero clusters. This function takes an L1 table (which may or may not
be active) and iterates over all its L2 tables looking for zero
clusters.

Since we'll be loading L2 slices instead of full tables we need to add
an extra loop that iterates over all slices of each L2 table, and we
should also use the slice size when allocating the buffer used when
the L1 table is not active.

As a consequence of the new loop the refcount data also needs to be
loaded before the L2 data, but this is a trivial change with no side
effects.

This function doesn't need any additional changes so apart from that
this patch simply updates the variable name from l2_table to l2_slice.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 207 +++++++++++++++++++++++++++-----------------------
 1 file changed, 110 insertions(+), 97 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8f7a04ba7d..ab840a449f 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1872,15 +1872,19 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
 {
     BDRVQcow2State *s = bs->opaque;
     bool is_active_l1 = (l1_table == s->l1_table);
-    uint64_t *l2_table = NULL;
+    uint64_t *l2_slice = NULL;
+    unsigned slice, slice_size, n_slices;
     int ret;
     int i, j;
 
+    slice_size = s->l2_slice_size * sizeof(uint64_t);
+    n_slices = s->cluster_size / slice_size;
+
     if (!is_active_l1) {
         /* inactive L2 tables require a buffer to be stored in when loading
          * them from disk */
-        l2_table = qemu_try_blockalign(bs->file->bs, s->cluster_size);
-        if (l2_table == NULL) {
+        l2_slice = qemu_try_blockalign(bs->file->bs, slice_size);
+        if (l2_slice == NULL) {
             return -ENOMEM;
         }
     }
@@ -1907,124 +1911,133 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
             goto fail;
         }
 
-        if (is_active_l1) {
-            /* get active L2 tables from cache */
-            ret = qcow2_cache_get(bs, s->l2_table_cache, l2_offset,
-                    (void **)&l2_table);
-        } else {
-            /* load inactive L2 tables from disk */
-            ret = bdrv_read(bs->file, l2_offset / BDRV_SECTOR_SIZE,
-                            (void *)l2_table, s->cluster_sectors);
-        }
-        if (ret < 0) {
-            goto fail;
-        }
-
         ret = qcow2_get_refcount(bs, l2_offset >> s->cluster_bits,
                                  &l2_refcount);
         if (ret < 0) {
             goto fail;
         }
 
-        for (j = 0; j < s->l2_size; j++) {
-            uint64_t l2_entry = be64_to_cpu(l2_table[j]);
-            int64_t offset = l2_entry & L2E_OFFSET_MASK;
-            QCow2ClusterType cluster_type = qcow2_get_cluster_type(l2_entry);
-
-            if (cluster_type != QCOW2_CLUSTER_ZERO_PLAIN &&
-                cluster_type != QCOW2_CLUSTER_ZERO_ALLOC) {
-                continue;
+        for (slice = 0; slice < n_slices; slice++) {
+            uint64_t slice_offset = l2_offset + slice * slice_size;
+            if (is_active_l1) {
+                /* get active L2 tables from cache */
+                ret = qcow2_cache_get(bs, s->l2_table_cache, slice_offset,
+                                      (void **)&l2_slice);
+            } else {
+                /* load inactive L2 tables from disk */
+                ret = bdrv_read(bs->file, slice_offset >> BDRV_SECTOR_BITS,
+                                (void *)l2_slice,
+                                slice_size >> BDRV_SECTOR_BITS);
+            }
+            if (ret < 0) {
+                goto fail;
             }
 
-            if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
-                if (!bs->backing) {
-                    /* not backed; therefore we can simply deallocate the
-                     * cluster */
-                    l2_table[j] = 0;
-                    l2_dirty = true;
+            for (j = 0; j < s->l2_slice_size; j++) {
+                uint64_t l2_entry = be64_to_cpu(l2_slice[j]);
+                int64_t offset = l2_entry & L2E_OFFSET_MASK;
+                QCow2ClusterType cluster_type =
+                    qcow2_get_cluster_type(l2_entry);
+
+                if (cluster_type != QCOW2_CLUSTER_ZERO_PLAIN &&
+                    cluster_type != QCOW2_CLUSTER_ZERO_ALLOC) {
                     continue;
                 }
 
-                offset = qcow2_alloc_clusters(bs, s->cluster_size);
-                if (offset < 0) {
-                    ret = offset;
-                    goto fail;
-                }
+                if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
+                    if (!bs->backing) {
+                        /* not backed; therefore we can simply deallocate the
+                         * cluster */
+                        l2_slice[j] = 0;
+                        l2_dirty = true;
+                        continue;
+                    }
 
-                if (l2_refcount > 1) {
-                    /* For shared L2 tables, set the refcount accordingly (it is
-                     * already 1 and needs to be l2_refcount) */
-                    ret = qcow2_update_cluster_refcount(bs,
-                            offset >> s->cluster_bits,
+                    offset = qcow2_alloc_clusters(bs, s->cluster_size);
+                    if (offset < 0) {
+                        ret = offset;
+                        goto fail;
+                    }
+
+                    if (l2_refcount > 1) {
+                        /* For shared L2 tables, set the refcount accordingly
+                         * (it is already 1 and needs to be l2_refcount) */
+                        ret = qcow2_update_cluster_refcount(
+                            bs, offset >> s->cluster_bits,
                             refcount_diff(1, l2_refcount), false,
                             QCOW2_DISCARD_OTHER);
-                    if (ret < 0) {
+                        if (ret < 0) {
+                            qcow2_free_clusters(bs, offset, s->cluster_size,
+                                                QCOW2_DISCARD_OTHER);
+                            goto fail;
+                        }
+                    }
+                }
+
+                if (offset_into_cluster(s, offset)) {
+                    int l2_index = slice * s->l2_slice_size + j;
+                    qcow2_signal_corruption(
+                        bs, true, -1, -1,
+                        "Cluster allocation offset "
+                        "%#" PRIx64 " unaligned (L2 offset: %#"
+                        PRIx64 ", L2 index: %#x)", offset,
+                        l2_offset, l2_index);
+                    if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
                         qcow2_free_clusters(bs, offset, s->cluster_size,
-                                            QCOW2_DISCARD_OTHER);
-                        goto fail;
+                                            QCOW2_DISCARD_ALWAYS);
                     }
+                    ret = -EIO;
+                    goto fail;
                 }
-            }
 
-            if (offset_into_cluster(s, offset)) {
-                qcow2_signal_corruption(bs, true, -1, -1,
-                                        "Cluster allocation offset "
-                                        "%#" PRIx64 " unaligned (L2 offset: %#"
-                                        PRIx64 ", L2 index: %#x)", offset,
-                                        l2_offset, j);
-                if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
-                    qcow2_free_clusters(bs, offset, s->cluster_size,
-                                        QCOW2_DISCARD_ALWAYS);
+                ret = qcow2_pre_write_overlap_check(bs, 0, offset,
+                                                    s->cluster_size);
+                if (ret < 0) {
+                    if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
+                        qcow2_free_clusters(bs, offset, s->cluster_size,
+                                            QCOW2_DISCARD_ALWAYS);
+                    }
+                    goto fail;
                 }
-                ret = -EIO;
-                goto fail;
-            }
 
-            ret = qcow2_pre_write_overlap_check(bs, 0, offset, s->cluster_size);
-            if (ret < 0) {
-                if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
-                    qcow2_free_clusters(bs, offset, s->cluster_size,
-                                        QCOW2_DISCARD_ALWAYS);
+                ret = bdrv_pwrite_zeroes(bs->file, offset, s->cluster_size, 0);
+                if (ret < 0) {
+                    if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
+                        qcow2_free_clusters(bs, offset, s->cluster_size,
+                                            QCOW2_DISCARD_ALWAYS);
+                    }
+                    goto fail;
                 }
-                goto fail;
-            }
 
-            ret = bdrv_pwrite_zeroes(bs->file, offset, s->cluster_size, 0);
-            if (ret < 0) {
-                if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
-                    qcow2_free_clusters(bs, offset, s->cluster_size,
-                                        QCOW2_DISCARD_ALWAYS);
+                if (l2_refcount == 1) {
+                    l2_slice[j] = cpu_to_be64(offset | QCOW_OFLAG_COPIED);
+                } else {
+                    l2_slice[j] = cpu_to_be64(offset);
                 }
-                goto fail;
+                l2_dirty = true;
             }
 
-            if (l2_refcount == 1) {
-                l2_table[j] = cpu_to_be64(offset | QCOW_OFLAG_COPIED);
+            if (is_active_l1) {
+                if (l2_dirty) {
+                    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
+                    qcow2_cache_depends_on_flush(s->l2_table_cache);
+                }
+                qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
             } else {
-                l2_table[j] = cpu_to_be64(offset);
-            }
-            l2_dirty = true;
-        }
+                if (l2_dirty) {
+                    ret = qcow2_pre_write_overlap_check(
+                        bs, QCOW2_OL_INACTIVE_L2 | QCOW2_OL_ACTIVE_L2,
+                        slice_offset, slice_size);
+                    if (ret < 0) {
+                        goto fail;
+                    }
 
-        if (is_active_l1) {
-            if (l2_dirty) {
-                qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
-                qcow2_cache_depends_on_flush(s->l2_table_cache);
-            }
-            qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
-        } else {
-            if (l2_dirty) {
-                ret = qcow2_pre_write_overlap_check(bs,
-                        QCOW2_OL_INACTIVE_L2 | QCOW2_OL_ACTIVE_L2, l2_offset,
-                        s->cluster_size);
-                if (ret < 0) {
-                    goto fail;
-                }
-
-                ret = bdrv_write(bs->file, l2_offset / BDRV_SECTOR_SIZE,
-                                 (void *)l2_table, s->cluster_sectors);
-                if (ret < 0) {
-                    goto fail;
+                    ret = bdrv_write(bs->file, slice_offset >> BDRV_SECTOR_BITS,
+                                     (void *)l2_slice,
+                                     slice_size >> BDRV_SECTOR_BITS);
+                    if (ret < 0) {
+                        goto fail;
+                    }
                 }
             }
         }
@@ -2038,11 +2051,11 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
     ret = 0;
 
 fail:
-    if (l2_table) {
+    if (l2_slice) {
         if (!is_active_l1) {
-            qemu_vfree(l2_table);
+            qemu_vfree(l2_slice);
         } else {
-            qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
+            qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
         }
     }
     return ret;
-- 
2.11.0
