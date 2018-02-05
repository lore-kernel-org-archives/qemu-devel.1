Received: from eggs.gnu.org ([2001:4830:134:3::10]:43087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5R-0007oO-0Q
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eii5M-0000pn-5x
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:49:37 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Mon,  5 Feb 2018 16:33:27 +0200
Message-Id: <5f4db199b9637f4833b58487135124d70add8cf0.1517840877.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
In-Reply-To: <cover.1517840876.git.berto@igalia.com>
References: <cover.1517840876.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 27/39] qcow2: Update
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

qcow2_update_snapshot_refcount() increases the refcount of all
clusters of a given snapshot. In order to do that it needs to load all
its L2 tables and iterate over their entries. Since we'll be loading
L2 slices instead of full tables we need to add an extra loop that
iterates over all slices of each L2 table.

This function doesn't need any additional changes so apart from that
this patch simply updates the variable name from l2_table to l2_slice.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-refcount.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index dfa28301c4..d46b69d7f3 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1183,17 +1183,20 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
     int64_t l1_table_offset, int l1_size, int addend)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t *l1_table, *l2_table, l2_offset, entry, l1_size2, refcount;
+    uint64_t *l1_table, *l2_slice, l2_offset, entry, l1_size2, refcount;
     bool l1_allocated = false;
     int64_t old_entry, old_l2_offset;
+    unsigned slice, slice_size2, n_slices;
     int i, j, l1_modified = 0, nb_csectors;
     int ret;
 
     assert(addend >= -1 && addend <= 1);
 
-    l2_table = NULL;
+    l2_slice = NULL;
     l1_table = NULL;
     l1_size2 = l1_size * sizeof(uint64_t);
+    slice_size2 = s->l2_slice_size * sizeof(uint64_t);
+    n_slices = s->cluster_size / slice_size2;
 
     s->cache_discards = true;
 
@@ -1236,19 +1239,19 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                 goto fail;
             }
 
-            {
+            for (slice = 0; slice < n_slices; slice++) {
                 ret = qcow2_cache_get(bs, s->l2_table_cache,
-                                      l2_offset,
-                                      (void **) &l2_table);
+                                      l2_offset + slice * slice_size2,
+                                      (void **) &l2_slice);
                 if (ret < 0) {
                     goto fail;
                 }
 
-                for (j = 0; j < s->l2_size; j++) {
+                for (j = 0; j < s->l2_slice_size; j++) {
                     uint64_t cluster_index;
                     uint64_t offset;
 
-                    entry = be64_to_cpu(l2_table[j]);
+                    entry = be64_to_cpu(l2_slice[j]);
                     old_entry = entry;
                     entry &= ~QCOW_OFLAG_COPIED;
                     offset = entry & L2E_OFFSET_MASK;
@@ -1273,12 +1276,14 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                     case QCOW2_CLUSTER_NORMAL:
                     case QCOW2_CLUSTER_ZERO_ALLOC:
                         if (offset_into_cluster(s, offset)) {
+                            /* Here l2_index means table (not slice) index */
+                            int l2_index = slice * s->l2_slice_size + j;
                             qcow2_signal_corruption(
                                 bs, true, -1, -1, "Cluster "
                                 "allocation offset %#" PRIx64
                                 " unaligned (L2 offset: %#"
                                 PRIx64 ", L2 index: %#x)",
-                                offset, l2_offset, j);
+                                offset, l2_offset, l2_index);
                             ret = -EIO;
                             goto fail;
                         }
@@ -1317,14 +1322,13 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
                             qcow2_cache_set_dependency(bs, s->l2_table_cache,
                                                        s->refcount_block_cache);
                         }
-                        l2_table[j] = cpu_to_be64(entry);
+                        l2_slice[j] = cpu_to_be64(entry);
                         qcow2_cache_entry_mark_dirty(s->l2_table_cache,
-                                                     l2_table);
+                                                     l2_slice);
                     }
                 }
 
-                qcow2_cache_put(s->l2_table_cache, (void **) &l2_table);
-
+                qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
             }
 
             if (addend != 0) {
@@ -1352,8 +1356,8 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
 
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
