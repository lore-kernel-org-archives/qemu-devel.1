Received: from eggs.gnu.org ([2001:4830:134:3::10]:53187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele2D-0003ZQ-Ow
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele2B-0005kq-EK
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:06:25 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:05:20 +0100
Message-Id: <20180213170529.10858-47-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 46/55] qcow2: Update
 expand_zero_clusters_in_l1() to support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Alberto Garcia <berto@igalia.com>

expand_zero_clusters_in_l1() expands zero clusters as a necessary step
to downgrade qcow2 images to a version that doesn't support metadata
zero clusters. This function takes an L1 table (which may or may not
be active) and iterates over all its L2 tables looking for zero
clusters.

Since we'll be loading L2 slices instead of full tables we need to add
an extra loop that iterates over all slices of each L2 table, and we
should also use the slice size when allocating the buffer used when
the L1 table is not active.

This function doesn't need any additional changes so apart from that
this patch simply updates the variable name from l2_table to l2_slice.

Finally, and since we have to touch the bdrv_read() / bdrv_write()
calls anyway, this patch takes the opportunity to replace them with
the byte-based bdrv_pread() / bdrv_pwrite().

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 43590976f730501688096cff103f2923b72b0f32.1517840877.git.berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 51 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index ccb2944eda..8fbaba008b 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1863,22 +1863,25 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
 {
     BDRVQcow2State *s = bs->opaque;
     bool is_active_l1 = (l1_table == s->l1_table);
-    uint64_t *l2_table = NULL;
+    uint64_t *l2_slice = NULL;
+    unsigned slice, slice_size2, n_slices;
     int ret;
     int i, j;
 
+    slice_size2 = s->l2_slice_size * sizeof(uint64_t);
+    n_slices = s->cluster_size / slice_size2;
+
     if (!is_active_l1) {
         /* inactive L2 tables require a buffer to be stored in when loading
          * them from disk */
-        l2_table = qemu_try_blockalign(bs->file->bs, s->cluster_size);
-        if (l2_table == NULL) {
+        l2_slice = qemu_try_blockalign(bs->file->bs, slice_size2);
+        if (l2_slice == NULL) {
             return -ENOMEM;
         }
     }
 
     for (i = 0; i < l1_size; i++) {
         uint64_t l2_offset = l1_table[i] & L1E_OFFSET_MASK;
-        bool l2_dirty = false;
         uint64_t l2_refcount;
 
         if (!l2_offset) {
@@ -1904,22 +1907,23 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
             goto fail;
         }
 
-        {
+        for (slice = 0; slice < n_slices; slice++) {
+            uint64_t slice_offset = l2_offset + slice * slice_size2;
+            bool l2_dirty = false;
             if (is_active_l1) {
                 /* get active L2 tables from cache */
-                ret = qcow2_cache_get(bs, s->l2_table_cache, l2_offset,
-                                      (void **)&l2_table);
+                ret = qcow2_cache_get(bs, s->l2_table_cache, slice_offset,
+                                      (void **)&l2_slice);
             } else {
                 /* load inactive L2 tables from disk */
-                ret = bdrv_read(bs->file, l2_offset / BDRV_SECTOR_SIZE,
-                                (void *)l2_table, s->cluster_sectors);
+                ret = bdrv_pread(bs->file, slice_offset, l2_slice, slice_size2);
             }
             if (ret < 0) {
                 goto fail;
             }
 
-            for (j = 0; j < s->l2_size; j++) {
-                uint64_t l2_entry = be64_to_cpu(l2_table[j]);
+            for (j = 0; j < s->l2_slice_size; j++) {
+                uint64_t l2_entry = be64_to_cpu(l2_slice[j]);
                 int64_t offset = l2_entry & L2E_OFFSET_MASK;
                 QCow2ClusterType cluster_type =
                     qcow2_get_cluster_type(l2_entry);
@@ -1933,7 +1937,7 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                     if (!bs->backing) {
                         /* not backed; therefore we can simply deallocate the
                          * cluster */
-                        l2_table[j] = 0;
+                        l2_slice[j] = 0;
                         l2_dirty = true;
                         continue;
                     }
@@ -1960,12 +1964,13 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                 }
 
                 if (offset_into_cluster(s, offset)) {
+                    int l2_index = slice * s->l2_slice_size + j;
                     qcow2_signal_corruption(
                         bs, true, -1, -1,
                         "Cluster allocation offset "
                         "%#" PRIx64 " unaligned (L2 offset: %#"
                         PRIx64 ", L2 index: %#x)", offset,
-                        l2_offset, j);
+                        l2_offset, l2_index);
                     if (cluster_type == QCOW2_CLUSTER_ZERO_PLAIN) {
                         qcow2_free_clusters(bs, offset, s->cluster_size,
                                             QCOW2_DISCARD_ALWAYS);
@@ -1994,30 +1999,30 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                 }
 
                 if (l2_refcount == 1) {
-                    l2_table[j] = cpu_to_be64(offset | QCOW_OFLAG_COPIED);
+                    l2_slice[j] = cpu_to_be64(offset | QCOW_OFLAG_COPIED);
                 } else {
-                    l2_table[j] = cpu_to_be64(offset);
+                    l2_slice[j] = cpu_to_be64(offset);
                 }
                 l2_dirty = true;
             }
 
             if (is_active_l1) {
                 if (l2_dirty) {
-                    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_table);
+                    qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
                     qcow2_cache_depends_on_flush(s->l2_table_cache);
                 }
-                qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
+                qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
             } else {
                 if (l2_dirty) {
                     ret = qcow2_pre_write_overlap_check(
                         bs, QCOW2_OL_INACTIVE_L2 | QCOW2_OL_ACTIVE_L2,
-                        l2_offset, s->cluster_size);
+                        slice_offset, slice_size2);
                     if (ret < 0) {
                         goto fail;
                     }
 
-                    ret = bdrv_write(bs->file, l2_offset / BDRV_SECTOR_SIZE,
-                                     (void *)l2_table, s->cluster_sectors);
+                    ret = bdrv_pwrite(bs->file, slice_offset,
+                                      l2_slice, slice_size2);
                     if (ret < 0) {
                         goto fail;
                     }
@@ -2034,11 +2039,11 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
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
2.13.6
