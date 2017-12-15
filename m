Received: from eggs.gnu.org ([2001:4830:134:3::10]:55503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVH-0000Wp-1N
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ePpVC-0003J5-SV
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 07:54:15 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Fri, 15 Dec 2017 13:53:52 +0100
Message-Id: <192f0a4a1888e7e18cb7cec9fdbeadad5417b4ef.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
In-Reply-To: <cover.1513342045.git.berto@igalia.com>
References: <cover.1513342045.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 24/32] qcow2: Update
 qcow2_update_snapshot_refcount() to support L2 slices
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

qcow2_update_snapshot_refcount() increases the refcount of all
clusters of a given snapshot. In order to do that it needs to load all
its L2 tables and iterate over their entries. Since we'll be loading
L2 slices instead of full tables we need to add an extra loop that
iterates over all slices of each L2 table.

This function doesn't need any additional changes so apart from that
this patch simply updates the variable name from l2_table to l2_slice.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-refcount.c | 150 ++++++++++++++++++++++++++-----------------------
 1 file changed, 80 insertions(+), 70 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 51094fbcfb..45c7bb0ff6 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1183,18 +1183,22 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
     int64_t l1_table_offset, int l1_size, int addend)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t *l1_table, *l2_table, l2_offset, entry, l1_size2, refcount;
+    uint64_t *l1_table, *l2_slice, l2_offset, entry, l1_size2, refcount;
     bool l1_allocated = false;
     int64_t old_entry, old_l2_offset;
+    unsigned slice, slice_size, n_slices;
     int i, j, l1_modified = 0, nb_csectors;
     int ret;
 
     assert(addend >= -1 && addend <= 1);
 
-    l2_table = NULL;
+    l2_slice = NULL;
     l1_table = NULL;
     l1_size2 = l1_size * sizeof(uint64_t);
 
+    slice_size = s->l2_slice_size * sizeof(uint64_t);
+    n_slices = s->cluster_size / slice_size;
+
     s->cache_discards = true;
 
     /* WARNING: qcow2_snapshot_goto relies on this function not using the
@@ -1236,91 +1240,97 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                 goto fail;
             }
 
-            ret = qcow2_cache_get(bs, s->l2_table_cache, l2_offset,
-                (void**) &l2_table);
-            if (ret < 0) {
-                goto fail;
-            }
+            for (slice = 0; slice < n_slices; slice++) {
+                ret = qcow2_cache_get(bs, s->l2_table_cache,
+                                      l2_offset + slice * slice_size,
+                                      (void **) &l2_slice);
+                if (ret < 0) {
+                    goto fail;
+                }
 
-            for (j = 0; j < s->l2_size; j++) {
-                uint64_t cluster_index;
-                uint64_t offset;
+                for (j = 0; j < s->l2_slice_size; j++) {
+                    uint64_t cluster_index;
+                    uint64_t offset;
 
-                entry = be64_to_cpu(l2_table[j]);
-                old_entry = entry;
-                entry &= ~QCOW_OFLAG_COPIED;
-                offset = entry & L2E_OFFSET_MASK;
+                    entry = be64_to_cpu(l2_slice[j]);
+                    old_entry = entry;
+                    entry &= ~QCOW_OFLAG_COPIED;
+                    offset = entry & L2E_OFFSET_MASK;
 
-                switch (qcow2_get_cluster_type(entry)) {
-                case QCOW2_CLUSTER_COMPRESSED:
-                    nb_csectors = ((entry >> s->csize_shift) &
-                                   s->csize_mask) + 1;
-                    if (addend != 0) {
-                        ret = update_refcount(bs,
-                                (entry & s->cluster_offset_mask) & ~511,
+                    switch (qcow2_get_cluster_type(entry)) {
+                    case QCOW2_CLUSTER_COMPRESSED:
+                        nb_csectors = ((entry >> s->csize_shift) &
+                                       s->csize_mask) + 1;
+                        if (addend != 0) {
+                            ret = update_refcount(
+                                bs, (entry & s->cluster_offset_mask) & ~511,
                                 nb_csectors * 512, abs(addend), addend < 0,
                                 QCOW2_DISCARD_SNAPSHOT);
-                        if (ret < 0) {
+                            if (ret < 0) {
+                                goto fail;
+                            }
+                        }
+                        /* compressed clusters are never modified */
+                        refcount = 2;
+                        break;
+
+                    case QCOW2_CLUSTER_NORMAL:
+                    case QCOW2_CLUSTER_ZERO_ALLOC:
+                        if (offset_into_cluster(s, offset)) {
+                            int l2_index = slice * s->l2_slice_size + j;
+                            qcow2_signal_corruption(
+                                bs, true, -1, -1, "Cluster "
+                                "allocation offset %#" PRIx64
+                                " unaligned (L2 offset: %#"
+                                PRIx64 ", L2 index: %#x)",
+                                offset, l2_offset, l2_index);
+                            ret = -EIO;
                             goto fail;
                         }
-                    }
-                    /* compressed clusters are never modified */
-                    refcount = 2;
-                    break;
 
-                case QCOW2_CLUSTER_NORMAL:
-                case QCOW2_CLUSTER_ZERO_ALLOC:
-                    if (offset_into_cluster(s, offset)) {
-                        qcow2_signal_corruption(bs, true, -1, -1, "Cluster "
-                                                "allocation offset %#" PRIx64
-                                                " unaligned (L2 offset: %#"
-                                                PRIx64 ", L2 index: %#x)",
-                                                offset, l2_offset, j);
-                        ret = -EIO;
-                        goto fail;
-                    }
+                        cluster_index = offset >> s->cluster_bits;
+                        assert(cluster_index);
+                        if (addend != 0) {
+                            ret = qcow2_update_cluster_refcount(
+                                bs, cluster_index, abs(addend), addend < 0,
+                                QCOW2_DISCARD_SNAPSHOT);
+                            if (ret < 0) {
+                                goto fail;
+                            }
+                        }
 
-                    cluster_index = offset >> s->cluster_bits;
-                    assert(cluster_index);
-                    if (addend != 0) {
-                        ret = qcow2_update_cluster_refcount(bs,
-                                    cluster_index, abs(addend), addend < 0,
-                                    QCOW2_DISCARD_SNAPSHOT);
+                        ret = qcow2_get_refcount(bs, cluster_index, &refcount);
                         if (ret < 0) {
                             goto fail;
                         }
-                    }
+                        break;
 
-                    ret = qcow2_get_refcount(bs, cluster_index, &refcount);
-                    if (ret < 0) {
-                        goto fail;
-                    }
-                    break;
+                    case QCOW2_CLUSTER_ZERO_PLAIN:
+                    case QCOW2_CLUSTER_UNALLOCATED:
+                        refcount = 0;
+                        break;
 
-                case QCOW2_CLUSTER_ZERO_PLAIN:
-                case QCOW2_CLUSTER_UNALLOCATED:
-                    refcount = 0;
-                    break;
-
-                default:
-                    abort();
-                }
+                    default:
+                        abort();
+                    }
 
-                if (refcount == 1) {
-                    entry |= QCOW_OFLAG_COPIED;
-                }
-                if (entry != old_entry) {
-                    if (addend > 0) {
-                        qcow2_cache_set_dependency(bs, s->l2_table_cache,
-                            s->refcount_block_cache);
+                    if (refcount == 1) {
+                        entry |= QCOW_OFLAG_COPIED;
+                    }
+                    if (entry != old_entry) {
+                        if (addend > 0) {
+                            qcow2_cache_set_dependency(bs, s->l2_table_cache,
+                                                       s->refcount_block_cache);
+                        }
+                        l2_slice[j] = cpu_to_be64(entry);
+                        qcow2_cache_entry_mark_dirty(s->l2_table_cache,
+                                                     l2_slice);
                     }
-                    l2_table[j] = cpu_to_be64(entry);
-                    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
                 }
+
+                qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
             }
 
-            qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
-
             if (addend != 0) {
                 ret = qcow2_update_cluster_refcount(bs, l2_offset >>
                                                         s->cluster_bits,
@@ -1346,8 +1356,8 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
 
     ret = bdrv_flush(bs);
 fail:
-    if (l2_table) {
-        qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
+    if (l2_slice) {
+        qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
     }
 
     s->cache_discards = false;
-- 
2.11.0
