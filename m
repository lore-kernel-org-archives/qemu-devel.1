Received: from eggs.gnu.org ([2001:4830:134:3::10]:49877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1egXTU-0002jO-Nu
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1egXTR-0007FJ-DD
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:05:28 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 30 Jan 2018 17:04:35 +0200
Message-Id: <20180130150435.2553-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH] qcow2: Replace align_offset() with ROUND_UP()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

The align_offset() function is equivalent to the ROUND_UP() macro so
there's no need to use the former. The ROUND_UP() name is also a bit
more explicit.

This patch uses ROUND_UP() instead of the slower QEMU_ALIGN_UP()
because align_offset() already requires that the second parameter is a
power of two.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-bitmap.c   |  2 +-
 block/qcow2-cluster.c  |  4 ++--
 block/qcow2-refcount.c |  4 ++--
 block/qcow2-snapshot.c | 10 +++++-----
 block/qcow2.c          | 12 ++++++------
 block/qcow2.h          |  6 ------
 6 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index efa10c6663..1cf99ca51e 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -413,7 +413,7 @@ static inline void bitmap_dir_entry_to_be(Qcow2BitmapDirEntry *entry)
 
 static inline int calc_dir_entry_size(size_t name_size, size_t extra_data_size)
 {
-    return align_offset(sizeof(Qcow2BitmapDirEntry) +
+    return ROUND_UP(sizeof(Qcow2BitmapDirEntry) +
                         name_size + extra_data_size, 8);
 }
 
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index a3fec27bf9..29d70e1f3e 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -127,11 +127,11 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
 
     new_l1_size2 = sizeof(uint64_t) * new_l1_size;
     new_l1_table = qemu_try_blockalign(bs->file->bs,
-                                       align_offset(new_l1_size2, 512));
+                                       ROUND_UP(new_l1_size2, 512));
     if (new_l1_table == NULL) {
         return -ENOMEM;
     }
-    memset(new_l1_table, 0, align_offset(new_l1_size2, 512));
+    memset(new_l1_table, 0, ROUND_UP(new_l1_size2, 512));
 
     if (s->l1_size) {
         memcpy(new_l1_table, s->l1_table, s->l1_size * sizeof(uint64_t));
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 92701ab7af..1d520615a8 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1202,7 +1202,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *bs,
      * l1_table_offset when it is the current s->l1_table_offset! Be careful
      * when changing this! */
     if (l1_table_offset != s->l1_table_offset) {
-        l1_table = g_try_malloc0(align_offset(l1_size2, 512));
+        l1_table = g_try_malloc0(ROUND_UP(l1_size2, 512));
         if (l1_size2 && l1_table == NULL) {
             ret = -ENOMEM;
             goto fail;
@@ -2545,7 +2545,7 @@ int qcow2_check_metadata_overlap(BlockDriverState *bs, int ign, int64_t offset,
     }
 
     /* align range to test to cluster boundaries */
-    size = align_offset(offset_into_cluster(s, offset) + size, s->cluster_size);
+    size = ROUND_UP(offset_into_cluster(s, offset) + size, s->cluster_size);
     offset = start_of_cluster(s, offset);
 
     if ((chk & QCOW2_OL_ACTIVE_L1) && s->l1_size) {
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 44243e0e95..cee25f582b 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -66,7 +66,7 @@ int qcow2_read_snapshots(BlockDriverState *bs)
 
     for(i = 0; i < s->nb_snapshots; i++) {
         /* Read statically sized part of the snapshot header */
-        offset = align_offset(offset, 8);
+        offset = ROUND_UP(offset, 8);
         ret = bdrv_pread(bs->file, offset, &h, sizeof(h));
         if (ret < 0) {
             goto fail;
@@ -155,7 +155,7 @@ static int qcow2_write_snapshots(BlockDriverState *bs)
     offset = 0;
     for(i = 0; i < s->nb_snapshots; i++) {
         sn = s->snapshots + i;
-        offset = align_offset(offset, 8);
+        offset = ROUND_UP(offset, 8);
         offset += sizeof(h);
         offset += sizeof(extra);
         offset += strlen(sn->id_str);
@@ -215,7 +215,7 @@ static int qcow2_write_snapshots(BlockDriverState *bs)
         assert(id_str_size <= UINT16_MAX && name_size <= UINT16_MAX);
         h.id_str_size = cpu_to_be16(id_str_size);
         h.name_size = cpu_to_be16(name_size);
-        offset = align_offset(offset, 8);
+        offset = ROUND_UP(offset, 8);
 
         ret = bdrv_pwrite(bs->file, offset, &h, sizeof(h));
         if (ret < 0) {
@@ -441,7 +441,7 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
     /* The VM state isn't needed any more in the active L1 table; in fact, it
      * hurts by causing expensive COW for the next snapshot. */
     qcow2_cluster_discard(bs, qcow2_vm_state_offset(s),
-                          align_offset(sn->vm_state_size, s->cluster_size),
+                          ROUND_UP(sn->vm_state_size, s->cluster_size),
                           QCOW2_DISCARD_NEVER, false);
 
 #ifdef DEBUG_ALLOC
@@ -710,7 +710,7 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
     }
     new_l1_bytes = sn->l1_size * sizeof(uint64_t);
     new_l1_table = qemu_try_blockalign(bs->file->bs,
-                                       align_offset(new_l1_bytes, 512));
+                                       ROUND_UP(new_l1_bytes, 512));
     if (new_l1_table == NULL) {
         return -ENOMEM;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 1f80961e1b..e09d5c2a74 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1354,7 +1354,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
 
     if (s->l1_size > 0) {
         s->l1_table = qemu_try_blockalign(bs->file->bs,
-            align_offset(s->l1_size * sizeof(uint64_t), 512));
+            ROUND_UP(s->l1_size * sizeof(uint64_t), 512));
         if (s->l1_table == NULL) {
             error_setg(errp, "Could not allocate L1 table");
             ret = -ENOMEM;
@@ -2615,19 +2615,19 @@ static int64_t qcow2_calc_prealloc_size(int64_t total_size,
 {
     int64_t meta_size = 0;
     uint64_t nl1e, nl2e;
-    int64_t aligned_total_size = align_offset(total_size, cluster_size);
+    int64_t aligned_total_size = ROUND_UP(total_size, cluster_size);
 
     /* header: 1 cluster */
     meta_size += cluster_size;
 
     /* total size of L2 tables */
     nl2e = aligned_total_size / cluster_size;
-    nl2e = align_offset(nl2e, cluster_size / sizeof(uint64_t));
+    nl2e = ROUND_UP(nl2e, cluster_size / sizeof(uint64_t));
     meta_size += nl2e * sizeof(uint64_t);
 
     /* total size of L1 tables */
     nl1e = nl2e * sizeof(uint64_t) / cluster_size;
-    nl1e = align_offset(nl1e, cluster_size / sizeof(uint64_t));
+    nl1e = ROUND_UP(nl1e, cluster_size / sizeof(uint64_t));
     meta_size += nl1e * sizeof(uint64_t);
 
     /* total size of refcount table and blocks */
@@ -3681,7 +3681,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     has_backing_file = !!optstr;
     g_free(optstr);
 
-    virtual_size = align_offset(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
+    virtual_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
                                 cluster_size);
 
     /* Check that virtual disk size is valid */
@@ -3702,7 +3702,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
             goto err;
         }
 
-        virtual_size = align_offset(ssize, cluster_size);
+        virtual_size = ROUND_UP(ssize, cluster_size);
 
         if (has_backing_file) {
             /* We don't how much of the backing chain is shared by the input
diff --git a/block/qcow2.h b/block/qcow2.h
index 46c8cf44ec..33d2eb0ead 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -468,12 +468,6 @@ static inline int offset_to_l2_index(BDRVQcow2State *s, int64_t offset)
     return (offset >> s->cluster_bits) & (s->l2_size - 1);
 }
 
-static inline int64_t align_offset(int64_t offset, int n)
-{
-    offset = (offset + n - 1) & ~(n - 1);
-    return offset;
-}
-
 static inline int64_t qcow2_vm_state_offset(BDRVQcow2State *s)
 {
     return (int64_t)s->l1_vm_state_index << (s->cluster_bits + s->l2_bits);
-- 
2.11.0
