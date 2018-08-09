Received: from eggs.gnu.org ([2001:4830:134:3::10]:60400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntT3-000841-Qc
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntT1-0002hN-6A
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:31:41 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Aug 2018 00:31:10 +0200
Message-Id: <20180809223117.7846-5-mreitz@redhat.com>
In-Reply-To: <20180809223117.7846-1-mreitz@redhat.com>
References: <20180809223117.7846-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/11] block: Storage child access function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

For completeness' sake, add a function for accessing a node's storage
child, too.  For filters, this is there filtered child; for non-filters,
this is bs->file.

Some places are deliberately left unconverted:
- BDS opening/closing functions where bs->file is handled specially
  (which is basically wrong, but at least simplifies probing)
- bdrv_co_block_status_from_file(), because its name implies that it
  points to ->file
- bdrv_snapshot_goto() in one places unrefs bs->file.  Such a
  modification is not covered by this patch and is therefore just
  safeguarded by an additional assert(), but otherwise kept as-is.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  6 +++++
 block.c                   | 51 ++++++++++++++++++++++++++++-----------
 block/io.c                | 20 +++++++++------
 block/qapi.c              |  7 +++---
 block/snapshot.c          | 40 +++++++++++++++++-------------
 5 files changed, 82 insertions(+), 42 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index fa9154899d..d3d8b22155 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1214,6 +1214,7 @@ int refresh_total_sectors(BlockDriverState *bs, int64_t hint);
 BdrvChild *bdrv_filtered_cow_child(BlockDriverState *bs);
 BdrvChild *bdrv_filtered_rw_child(BlockDriverState *bs);
 BdrvChild *bdrv_filtered_child(BlockDriverState *bs);
+BdrvChild *bdrv_storage_child(BlockDriverState *bs);
 BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs);
 BlockDriverState *bdrv_skip_rw_filters(BlockDriverState *bs);
 BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs);
@@ -1238,4 +1239,9 @@ static inline BlockDriverState *bdrv_filtered_bs(BlockDriverState *bs)
     return child_bs(bdrv_filtered_child(bs));
 }
 
+static inline BlockDriverState *bdrv_storage_bs(BlockDriverState *bs)
+{
+    return child_bs(bdrv_storage_child(bs));
+}
+
 #endif /* BLOCK_INT_H */
diff --git a/block.c b/block.c
index 61a2fe14eb..a3a121551a 100644
--- a/block.c
+++ b/block.c
@@ -3835,15 +3835,21 @@ exit:
 int64_t bdrv_get_allocated_file_size(BlockDriverState *bs)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *storage_bs;
+
     if (!drv) {
         return -ENOMEDIUM;
     }
+
     if (drv->bdrv_get_allocated_file_size) {
         return drv->bdrv_get_allocated_file_size(bs);
     }
-    if (bs->file) {
-        return bdrv_get_allocated_file_size(bs->file->bs);
+
+    storage_bs = bdrv_storage_bs(bs);
+    if (storage_bs) {
+        return bdrv_get_allocated_file_size(storage_bs);
     }
+
     return -ENOTSUP;
 }
 
@@ -4252,7 +4258,7 @@ int bdrv_debug_breakpoint(BlockDriverState *bs, const char *event,
                           const char *tag)
 {
     while (bs && bs->drv && !bs->drv->bdrv_debug_breakpoint) {
-        bs = bs->file ? bs->file->bs : NULL;
+        bs = bdrv_storage_bs(bs);
     }
 
     if (bs && bs->drv && bs->drv->bdrv_debug_breakpoint) {
@@ -4265,7 +4271,7 @@ int bdrv_debug_breakpoint(BlockDriverState *bs, const char *event,
 int bdrv_debug_remove_breakpoint(BlockDriverState *bs, const char *tag)
 {
     while (bs && bs->drv && !bs->drv->bdrv_debug_remove_breakpoint) {
-        bs = bs->file ? bs->file->bs : NULL;
+        bs = bdrv_storage_bs(bs);
     }
 
     if (bs && bs->drv && bs->drv->bdrv_debug_remove_breakpoint) {
@@ -4278,7 +4284,7 @@ int bdrv_debug_remove_breakpoint(BlockDriverState *bs, const char *tag)
 int bdrv_debug_resume(BlockDriverState *bs, const char *tag)
 {
     while (bs && (!bs->drv || !bs->drv->bdrv_debug_resume)) {
-        bs = bs->file ? bs->file->bs : NULL;
+        bs = bdrv_storage_bs(bs);
     }
 
     if (bs && bs->drv && bs->drv->bdrv_debug_resume) {
@@ -4291,7 +4297,7 @@ int bdrv_debug_resume(BlockDriverState *bs, const char *tag)
 bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag)
 {
     while (bs && bs->drv && !bs->drv->bdrv_debug_is_suspended) {
-        bs = bs->file ? bs->file->bs : NULL;
+        bs = bdrv_storage_bs(bs);
     }
 
     if (bs && bs->drv && bs->drv->bdrv_debug_is_suspended) {
@@ -5388,14 +5394,21 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         bs->exact_filename[0] = '\0';
 
         drv->bdrv_refresh_filename(bs);
-    } else if (bs->file) {
-        /* Try to reconstruct valid information from the underlying file */
+    } else if (bdrv_storage_child(bs)) {
+        /* Try to reconstruct valid information from the underlying
+         * file -- this only works for format nodes (filter nodes
+         * cannot be probed and as such must be selected by the user
+         * either through an options dict, or through a special
+         * filename which the filter driver must construct in its
+         * .bdrv_refresh_filename() implementation) */
+        BlockDriverState *storage_bs = bdrv_storage_bs(bs);
 
         bs->exact_filename[0] = '\0';
 
         /*
          * We can use the underlying file's filename if:
          * - it has a filename,
+         * - the current BDS is not a filter,
          * - the file is a protocol BDS, and
          * - opening that file (as this BDS's format) will automatically create
          *   the BDS tree we have right now, that is:
@@ -5404,11 +5417,10 @@ void bdrv_refresh_filename(BlockDriverState *bs)
          *   - no non-file child of this BDS has been overridden by the user
          *   Both of these conditions are represented by generate_json_filename.
          */
-        if (bs->file->bs->exact_filename[0] &&
-            bs->file->bs->drv->bdrv_file_open &&
-            !generate_json_filename)
+        if (storage_bs->exact_filename[0] && storage_bs->drv->bdrv_file_open &&
+            !drv->is_filter && !generate_json_filename)
         {
-            strcpy(bs->exact_filename, bs->file->bs->exact_filename);
+            strcpy(bs->exact_filename, storage_bs->exact_filename);
         }
     }
 
@@ -5425,6 +5437,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
 char *bdrv_dirname(BlockDriverState *bs, Error **errp)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *storage_bs;
 
     if (!drv) {
         error_setg(errp, "Node '%s' is ejected", bs->node_name);
@@ -5435,8 +5448,9 @@ char *bdrv_dirname(BlockDriverState *bs, Error **errp)
         return drv->bdrv_dirname(bs, errp);
     }
 
-    if (bs->file) {
-        return bdrv_dirname(bs->file->bs, errp);
+    storage_bs = bdrv_storage_bs(bs);
+    if (storage_bs) {
+        return bdrv_dirname(storage_bs, errp);
     }
 
     bdrv_refresh_filename(bs);
@@ -5570,6 +5584,15 @@ BdrvChild *bdrv_filtered_child(BlockDriverState *bs)
     return cow_child ?: rw_child;
 }
 
+/*
+ * Return the child that stores the data that is allocated on this
+ * node.  This may or may not include metadata.
+ */
+BdrvChild *bdrv_storage_child(BlockDriverState *bs)
+{
+    return bdrv_filtered_rw_child(bs) ?: bs->file;
+}
+
 static BlockDriverState *bdrv_skip_filters(BlockDriverState *bs,
                                            bool stop_on_explicit_filter)
 {
diff --git a/block/io.c b/block/io.c
index 8a442d37b2..7fb81287c5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -120,6 +120,7 @@ static void bdrv_merge_limits(BlockLimits *dst, const BlockLimits *src)
 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *storage_bs = bdrv_storage_bs(bs);
     BlockDriverState *cow_bs = bdrv_filtered_cow_bs(bs);
     Error *local_err = NULL;
 
@@ -134,13 +135,13 @@ void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
                                 drv->bdrv_aio_preadv) ? 1 : 512;
 
     /* Take some limits from the children as a default */
-    if (bs->file) {
-        bdrv_refresh_limits(bs->file->bs, &local_err);
+    if (storage_bs) {
+        bdrv_refresh_limits(storage_bs, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
         }
-        bdrv_merge_limits(&bs->bl, &bs->file->bs->bl);
+        bdrv_merge_limits(&bs->bl, &storage_bs->bl);
     } else {
         bs->bl.min_mem_alignment = 512;
         bs->bl.opt_mem_alignment = getpagesize();
@@ -2412,6 +2413,7 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
                    bool is_read)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *storage_bs = bdrv_storage_bs(bs);
     int ret = -ENOTSUP;
 
     bdrv_inc_in_flight(bs);
@@ -2424,8 +2426,8 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
         } else {
             ret = drv->bdrv_save_vmstate(bs, qiov, pos);
         }
-    } else if (bs->file) {
-        ret = bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
+    } else if (storage_bs) {
+        ret = bdrv_co_rw_vmstate(storage_bs, qiov, pos, is_read);
     }
 
     bdrv_dec_in_flight(bs);
@@ -2561,6 +2563,7 @@ static void coroutine_fn bdrv_flush_co_entry(void *opaque)
 
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
 {
+    BlockDriverState *storage_bs;
     int current_gen;
     int ret = 0;
 
@@ -2590,7 +2593,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
     }
 
     /* Write back cached data to the OS even with cache=unsafe */
-    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_OS);
+    BLKDBG_EVENT(bdrv_storage_child(bs), BLKDBG_FLUSH_TO_OS);
     if (bs->drv->bdrv_co_flush_to_os) {
         ret = bs->drv->bdrv_co_flush_to_os(bs);
         if (ret < 0) {
@@ -2608,7 +2611,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
         goto flush_parent;
     }
 
-    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_DISK);
+    BLKDBG_EVENT(bdrv_storage_child(bs), BLKDBG_FLUSH_TO_DISK);
     if (!bs->drv) {
         /* bs->drv->bdrv_co_flush() might have ejected the BDS
          * (even in case of apparent success) */
@@ -2653,7 +2656,8 @@ int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
      * in the case of cache=unsafe, so there are no useless flushes.
      */
 flush_parent:
-    ret = bs->file ? bdrv_co_flush(bs->file->bs) : 0;
+    storage_bs = bdrv_storage_bs(bs);
+    ret = storage_bs ? bdrv_co_flush(storage_bs) : 0;
 out:
     /* Notify any pending flushes that we have completed */
     if (ret == 0) {
diff --git a/block/qapi.c b/block/qapi.c
index f2eb83945e..cbee819c13 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -500,7 +500,7 @@ static void bdrv_query_blk_stats(BlockDeviceStats *ds, BlockBackend *blk)
 static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
                                         bool blk_level)
 {
-    BlockDriverState *cow_bs;
+    BlockDriverState *storage_bs, *cow_bs;
     BlockStats *s = NULL;
 
     s = g_malloc0(sizeof(*s));
@@ -524,9 +524,10 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
 
     s->stats->wr_highest_offset = stat64_get(&bs->wr_highest_offset);
 
-    if (bs->file) {
+    storage_bs = bdrv_storage_bs(bs);
+    if (storage_bs) {
         s->has_parent = true;
-        s->parent = bdrv_query_bds_stats(bs->file->bs, blk_level);
+        s->parent = bdrv_query_bds_stats(storage_bs, blk_level);
     }
 
     cow_bs = bdrv_filtered_cow_bs(bs);
diff --git a/block/snapshot.c b/block/snapshot.c
index f9903bc94e..2c5997fc73 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -154,8 +154,9 @@ int bdrv_can_snapshot(BlockDriverState *bs)
     }
 
     if (!drv->bdrv_snapshot_create) {
-        if (bs->file != NULL) {
-            return bdrv_can_snapshot(bs->file->bs);
+        BlockDriverState *storage_bs = bdrv_storage_bs(bs);
+        if (storage_bs) {
+            return bdrv_can_snapshot(storage_bs);
         }
         return 0;
     }
@@ -167,14 +168,15 @@ int bdrv_snapshot_create(BlockDriverState *bs,
                          QEMUSnapshotInfo *sn_info)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *storage_bs = bdrv_storage_bs(bs);
     if (!drv) {
         return -ENOMEDIUM;
     }
     if (drv->bdrv_snapshot_create) {
         return drv->bdrv_snapshot_create(bs, sn_info);
     }
-    if (bs->file) {
-        return bdrv_snapshot_create(bs->file->bs, sn_info);
+    if (storage_bs) {
+        return bdrv_snapshot_create(storage_bs, sn_info);
     }
     return -ENOTSUP;
 }
@@ -184,6 +186,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
                        Error **errp)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *storage_bs;
     int ret, open_ret;
 
     if (!drv) {
@@ -204,37 +207,38 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         return ret;
     }
 
-    if (bs->file) {
-        BlockDriverState *file;
+    storage_bs = bdrv_storage_bs(bs);
+    if (storage_bs) {
         QDict *options = qdict_clone_shallow(bs->options);
         QDict *file_options;
         Error *local_err = NULL;
 
-        file = bs->file->bs;
         /* Prevent it from getting deleted when detached from bs */
-        bdrv_ref(file);
+        bdrv_ref(storage_bs);
 
         qdict_extract_subqdict(options, &file_options, "file.");
         qobject_unref(file_options);
-        qdict_put_str(options, "file", bdrv_get_node_name(file));
+        qdict_put_str(options, "file", bdrv_get_node_name(storage_bs));
 
         drv->bdrv_close(bs);
+
+        assert(bs->file->bs == storage_bs);
         bdrv_unref_child(bs, bs->file);
         bs->file = NULL;
 
-        ret = bdrv_snapshot_goto(file, snapshot_id, errp);
+        ret = bdrv_snapshot_goto(storage_bs, snapshot_id, errp);
         open_ret = drv->bdrv_open(bs, options, bs->open_flags, &local_err);
         qobject_unref(options);
         if (open_ret < 0) {
-            bdrv_unref(file);
+            bdrv_unref(storage_bs);
             bs->drv = NULL;
             /* A bdrv_snapshot_goto() error takes precedence */
             error_propagate(errp, local_err);
             return ret < 0 ? ret : open_ret;
         }
 
-        assert(bs->file->bs == file);
-        bdrv_unref(file);
+        assert(bs->file->bs == storage_bs);
+        bdrv_unref(storage_bs);
         return ret;
     }
 
@@ -270,6 +274,7 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
                          Error **errp)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *storage_bs = bdrv_storage_bs(bs);
     int ret;
 
     if (!drv) {
@@ -286,8 +291,8 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
 
     if (drv->bdrv_snapshot_delete) {
         ret = drv->bdrv_snapshot_delete(bs, snapshot_id, name, errp);
-    } else if (bs->file) {
-        ret = bdrv_snapshot_delete(bs->file->bs, snapshot_id, name, errp);
+    } else if (storage_bs) {
+        ret = bdrv_snapshot_delete(storage_bs, snapshot_id, name, errp);
     } else {
         error_setg(errp, "Block format '%s' used by device '%s' "
                    "does not support internal snapshot deletion",
@@ -323,14 +328,15 @@ int bdrv_snapshot_list(BlockDriverState *bs,
                        QEMUSnapshotInfo **psn_info)
 {
     BlockDriver *drv = bs->drv;
+    BlockDriverState *storage_bs = bdrv_storage_bs(bs);
     if (!drv) {
         return -ENOMEDIUM;
     }
     if (drv->bdrv_snapshot_list) {
         return drv->bdrv_snapshot_list(bs, psn_info);
     }
-    if (bs->file) {
-        return bdrv_snapshot_list(bs->file->bs, psn_info);
+    if (storage_bs) {
+        return bdrv_snapshot_list(storage_bs, psn_info);
     }
     return -ENOTSUP;
 }
-- 
2.17.1
