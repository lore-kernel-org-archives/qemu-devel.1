Received: from eggs.gnu.org ([2001:4830:134:3::10]:43128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5U-0007sM-5X
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5Q-0000wj-B8
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:40 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  5 Feb 2018 16:33:29 +0200
Message-Id: <c2ae9f31ed5b6e591477ad4654448badd1c89d73.1517840877.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 29/39] qcow2: Prepare
 expand_zero_clusters_in_l1() for adding L2 slice support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

Adding support for L2 slices to expand_zero_clusters_in_l1() needs
(among other things) an extra loop that iterates over all slices of
each L2 table.

Putting all changes in one patch would make it hard to read because
all semantic changes would be mixed with pure indentation changes.

To make things easier this patch simply creates a new block and
changes the indentation of all lines of code inside it. Thus, all
modifications in this patch are cosmetic. There are no semantic
changes and no variables are renamed yet. The next patch will take
care of that.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 187 ++++++++++++++++++++++++++------------------------
 1 file changed, 96 insertions(+), 91 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index ecfd4e7019..db829eb688 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1905,118 +1905,123 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
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
-        for (j = 0; j < s->l2_size; j++) {
-            uint64_t l2_entry = be64_to_cpu(l2_table[j]);
-            int64_t offset = l2_entry & L2E_OFFSET_MASK;
-            QCow2ClusterType cluster_type = qcow2_get_cluster_type(l2_entry);
-
-            if (cluster_type != QCOW2_CLUSTER_ZERO_PLAIN &&
-                cluster_type != QCOW2_CLUSTER_ZERO_ALLOC) {
-                continue;
+        {
+            if (is_active_l1) {
+                /* get active L2 tables from cache */
+                ret = qcow2_cache_get(bs, s->l2_table_cache, l2_offset,
+                                      (void **)&l2_table);
+            } else {
+                /* load inactive L2 tables from disk */
+                ret = bdrv_read(bs->file, l2_offset / BDRV_SECTOR_SIZE,
+                                (void *)l2_table, s->cluster_sectors);
             }
+            if (ret < 0) {
+                goto fail;
+            }
+
+            for (j = 0; j < s->l2_size; j++) {
+                uint64_t l2_entry = be64_to_cpu(l2_table[j]);
+                int64_t offset = l2_entry & L2E_OFFSET_MASK;
+                QCow2ClusterType cluster_type =
+                    qcow2_get_cluster_type(l2_entry);
 
-            if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
-                if (!bs->backing) {
-                    /* not backed; therefore we can simply deallocate the
-                     * cluster */
-                    l2_table[j] = 0;
-                    l2_dirty = true;
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
+                        l2_table[j] = 0;
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
+                    qcow2_signal_corruption(
+                        bs, true, -1, -1,
+                        "Cluster allocation offset "
+                        "%#" PRIx64 " unaligned (L2 offset: %#"
+                        PRIx64 ", L2 index: %#x)", offset,
+                        l2_offset, j);
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
+                    l2_table[j] = cpu_to_be64(offset | QCOW_OFLAG_COPIED);
+                } else {
+                    l2_table[j] = cpu_to_be64(offset);
                 }
-                goto fail;
+                l2_dirty = true;
             }
 
-            if (l2_refcount == 1) {
-                l2_table[j] = cpu_to_be64(offset | QCOW_OFLAG_COPIED);
+            if (is_active_l1) {
+                if (l2_dirty) {
+                    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
+                    qcow2_cache_depends_on_flush(s->l2_table_cache);
+                }
+                qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
             } else {
-                l2_table[j] = cpu_to_be64(offset);
-            }
-            l2_dirty = true;
-        }
+                if (l2_dirty) {
+                    ret = qcow2_pre_write_overlap_check(
+                        bs, QCOW2_OL_INACTIVE_L2 | QCOW2_OL_ACTIVE_L2,
+                        l2_offset, s->cluster_size);
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
+                    ret = bdrv_write(bs->file, l2_offset / BDRV_SECTOR_SIZE,
+                                     (void *)l2_table, s->cluster_sectors);
+                    if (ret < 0) {
+                        goto fail;
+                    }
                 }
             }
         }
-- 
2.11.0
