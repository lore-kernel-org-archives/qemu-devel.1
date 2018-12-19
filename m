Received: from eggs.gnu.org ([2001:4830:134:3::10]:53901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1gZVhV-0004cl-J7
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 01:51:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1gZVhU-0003RY-1y
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 01:51:25 -0500
From: mahaocong <mahaocong_work@163.com>
Date: Wed, 19 Dec 2018 14:50:20 +0800
Message-Id: <20181219065020.81256-2-mahaocong_work@163.com>
In-Reply-To: <20181219065020.81256-1-mahaocong_work@163.com>
References: <20181219065020.81256-1-mahaocong_work@163.com>
Subject: [Qemu-devel] [PATCH v1] migration: add incremental mode on
 drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, mahaocong <mahaocong@didichuxing.com>

From: mahaocong <mahaocong@didichuxing.com>

Signed-off-by: mahaocong <mahaocong@didichuxing.com>
---
 block/dirty-bitmap.c         | 14 ++++++++++
 block/mirror.c               | 63 +++++++++++++++++++++++++++++++++++---------
 blockdev.c                   | 36 +++++++++++++++++++++++--
 include/block/block_int.h    |  3 ++-
 include/block/dirty-bitmap.h |  3 +++
 include/qemu/hbitmap.h       |  2 ++
 qapi/block-core.json         |  4 ++-
 util/hbitmap.c               | 28 ++++++++++++++++++++
 8 files changed, 136 insertions(+), 17 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 89fd1d7..118447d 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -348,6 +348,20 @@ BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
     return ret;
 }
 
+BdrvDirtyBitmap *bdrv_copy_dirty_bitmap_locked(BdrvDirtyBitmap *src,
+                                               BdrvDirtyBitmap *dest,
+                                               Error **errp)
+{
+    qemu_mutex_lock(src->mutex);
+    if (!hbitmap_copy(dest->bitmap, src->bitmap)) {
+        error_setg(errp, "Error: copy src bitmap failed");
+        return NULL;
+    }
+    qemu_mutex_unlock(src->mutex);
+
+    return dest;
+}
+
 /**
  * Truncates _all_ bitmaps attached to a BDS.
  * Called with BQL taken.
diff --git a/block/mirror.c b/block/mirror.c
index ab59ad7..a860fe7 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -50,6 +50,8 @@ typedef struct MirrorBlockJob {
     /* Used to block operations on the drive-mirror-replace target */
     Error *replace_blocker;
     bool is_none_mode;
+    bool is_inc_mode;
+    char *bitmap_name;
     BlockMirrorBackingMode backing_mode;
     MirrorCopyMode copy_mode;
     BlockdevOnError on_source_error, on_target_error;
@@ -814,6 +816,28 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
     return 0;
 }
 
+/*
+ * init dirty bitmap by using user bitmap. usr->hbitmap will be copy to
+ * mirror bitmap->hbitmap instead of reuse it.
+ */
+static int coroutine_fn mirror_dirty_init_incremental(MirrorBlockJob *s)
+{
+    BlockDriverState *bs = s->mirror_top_bs->backing->bs;
+    BdrvDirtyBitmap *src, *dest;
+
+    dest = s->dirty_bitmap;
+    src = bdrv_find_dirty_bitmap(bs, s->bitmap_name);
+    if (!src) {
+        return -1;
+    }
+
+    if (!bdrv_copy_dirty_bitmap_locked(src, dest, NULL)) {
+        return -1;
+    }
+
+    return 0;
+}
+
 /* Called when going out of the streaming phase to flush the bulk of the
  * data to the medium, or just before completing.
  */
@@ -913,9 +937,17 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
 
     s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     if (!s->is_none_mode) {
-        ret = mirror_dirty_init(s);
-        if (ret < 0 || job_is_cancelled(&s->common.job)) {
-            goto immediate_exit;
+        /* incremental mode */
+        if (s->is_inc_mode) {
+            ret = mirror_dirty_init_incremental(s);
+            if (ret < 0 || job_is_cancelled(&s->common.job)) {
+                goto immediate_exit;
+            }
+        } else {
+            ret = mirror_dirty_init(s);
+            if (ret < 0 || job_is_cancelled(&s->common.job)) {
+                goto immediate_exit;
+            }
         }
     }
 
@@ -1484,7 +1516,9 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              BlockCompletionFunc *cb,
                              void *opaque,
                              const BlockJobDriver *driver,
-                             bool is_none_mode, BlockDriverState *base,
+                             bool is_none_mode, bool is_inc_mode,
+                             const char *bitmap_name,
+                             BlockDriverState *base,
                              bool auto_complete, const char *filter_node_name,
                              bool is_mirror, MirrorCopyMode copy_mode,
                              Error **errp)
@@ -1598,6 +1632,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     s->on_source_error = on_source_error;
     s->on_target_error = on_target_error;
     s->is_none_mode = is_none_mode;
+    s->is_inc_mode = is_inc_mode;
+    s->bitmap_name = g_strdup(bitmap_name);
     s->backing_mode = backing_mode;
     s->copy_mode = copy_mode;
     s->base = base;
@@ -1648,6 +1684,7 @@ fail:
         bdrv_ref(mirror_top_bs);
 
         g_free(s->replaces);
+        g_free(s->bitmap_name);
         blk_unref(s->target);
         bs_opaque->job = NULL;
         job_early_fail(&s->common.job);
@@ -1664,26 +1701,25 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
-                  MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
+                  MirrorSyncMode mode, const char *bitmap_name,
+                  BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name,
                   MirrorCopyMode copy_mode, Error **errp)
 {
-    bool is_none_mode;
+    bool is_none_mode, is_inc_mode;
     BlockDriverState *base;
 
-    if (mode == MIRROR_SYNC_MODE_INCREMENTAL) {
-        error_setg(errp, "Sync mode 'incremental' not supported");
-        return;
-    }
     is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
+    is_inc_mode = mode == MIRROR_SYNC_MODE_INCREMENTAL;
     base = mode == MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;
     mirror_start_job(job_id, bs, creation_flags, target, replaces,
                      speed, granularity, buf_size, backing_mode,
                      on_source_error, on_target_error, unmap, NULL, NULL,
-                     &mirror_job_driver, is_none_mode, base, false,
-                     filter_node_name, true, copy_mode, errp);
+                     &mirror_job_driver, is_none_mode, is_inc_mode,
+                     bitmap_name, base, false, filter_node_name, true,
+                     copy_mode, errp);
 }
 
 void commit_active_start(const char *job_id, BlockDriverState *bs,
@@ -1707,7 +1743,8 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
     mirror_start_job(job_id, bs, creation_flags, base, NULL, speed, 0, 0,
                      MIRROR_LEAVE_BACKING_CHAIN,
                      on_error, on_error, true, cb, opaque,
-                     &commit_active_job_driver, false, base, auto_complete,
+                     &commit_active_job_driver, false, false,
+                     NULL, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
                      &local_err);
     if (local_err) {
diff --git a/blockdev.c b/blockdev.c
index e6c8349..4ac36f3 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3663,6 +3663,8 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    BlockDriverState *target,
                                    bool has_replaces, const char *replaces,
                                    enum MirrorSyncMode sync,
+                                   bool has_bitmap_name,
+                                   const char *bitmap_name,
                                    BlockMirrorBackingMode backing_mode,
                                    bool has_speed, int64_t speed,
                                    bool has_granularity, uint32_t granularity,
@@ -3680,6 +3682,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    Error **errp)
 {
     int job_flags = JOB_DEFAULT;
+    BdrvDirtyBitmap *src_bitmap;
 
     if (!has_speed) {
         speed = 0;
@@ -3702,6 +3705,23 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
     if (!has_filter_node_name) {
         filter_node_name = NULL;
     }
+    if (!has_bitmap_name) {
+        bitmap_name = NULL;
+    }
+    /*
+     * In incremental mode, we should create null name bitmap by
+     * using user bitmap's granularity.
+     */
+    if (sync == MIRROR_SYNC_MODE_INCREMENTAL && bitmap_name != NULL) {
+        src_bitmap = bdrv_find_dirty_bitmap(bs, bitmap_name);
+        if (!src_bitmap) {
+            error_setg(errp, "Error: can't find dirty bitmap "
+                       "before start incremental drive-mirror");
+            return;
+        }
+        granularity = bdrv_dirty_bitmap_granularity(src_bitmap);
+    }
+
     if (!has_copy_mode) {
         copy_mode = MIRROR_COPY_MODE_BACKGROUND;
     }
@@ -3739,7 +3759,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
      */
     mirror_start(job_id, bs, target,
                  has_replaces ? replaces : NULL, job_flags,
-                 speed, granularity, buf_size, sync, backing_mode,
+                 speed, granularity, buf_size, sync, bitmap_name, backing_mode,
                  on_source_error, on_target_error, unmap, filter_node_name,
                  copy_mode, errp);
 }
@@ -3786,6 +3806,16 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     if (arg->sync == MIRROR_SYNC_MODE_NONE) {
         source = bs;
     }
+    if ((arg->sync == MIRROR_SYNC_MODE_INCREMENTAL) &&
+        (!arg->has_bitmap_name)) {
+        error_setg(errp, "incremental mode must specify the bitmap name");
+        goto out;
+    }
+    if ((arg->sync == MIRROR_SYNC_MODE_INCREMENTAL) &&
+        (arg->has_granularity)) {
+        error_setg(errp, "incremental mode can not set bitmap granularity");
+        goto out;
+    }
 
     size = bdrv_getlength(bs);
     if (size < 0) {
@@ -3880,6 +3910,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
 
     blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, target_bs,
                            arg->has_replaces, arg->replaces, arg->sync,
+                           arg->has_bitmap_name, arg->bitmap_name,
                            backing_mode, arg->has_speed, arg->speed,
                            arg->has_granularity, arg->granularity,
                            arg->has_buf_size, arg->buf_size,
@@ -3937,7 +3968,8 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
     bdrv_set_aio_context(target_bs, aio_context);
 
     blockdev_mirror_common(has_job_id ? job_id : NULL, bs, target_bs,
-                           has_replaces, replaces, sync, backing_mode,
+                           has_replaces, replaces, sync, false, NULL,
+                           backing_mode,
                            has_speed, speed,
                            has_granularity, granularity,
                            has_buf_size, buf_size,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f605622..2f4725e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1054,7 +1054,8 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
-                  MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
+                  MirrorSyncMode mode, const char *bitmap_name,
+                  BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name,
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index 8f38a3d..d354d8f 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -21,6 +21,9 @@ BdrvDirtyBitmap *bdrv_dirty_bitmap_abdicate(BlockDriverState *bs,
 BdrvDirtyBitmap *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
                                            BdrvDirtyBitmap *bitmap,
                                            Error **errp);
+BdrvDirtyBitmap *bdrv_copy_dirty_bitmap_locked(BdrvDirtyBitmap *src,
+                                               BdrvDirtyBitmap *dest,
+                                               Error **errp);
 void bdrv_dirty_bitmap_enable_successor(BdrvDirtyBitmap *bitmap);
 BdrvDirtyBitmap *bdrv_find_dirty_bitmap(BlockDriverState *bs,
                                         const char *name);
diff --git a/include/qemu/hbitmap.h b/include/qemu/hbitmap.h
index a7cb780..6de3b4e 100644
--- a/include/qemu/hbitmap.h
+++ b/include/qemu/hbitmap.h
@@ -91,6 +91,8 @@ bool hbitmap_merge(const HBitmap *a, const HBitmap *b, HBitmap *result);
  */
 bool hbitmap_can_merge(const HBitmap *a, const HBitmap *b);
 
+bool hbitmap_copy(HBitmap *dst, const HBitmap *src);
+
 /**
  * hbitmap_empty:
  * @hb: HBitmap to operate on.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 762000f..b51e57c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1727,6 +1727,8 @@
 #        (all the disk, only the sectors allocated in the topmost image, or
 #        only new I/O).
 #
+# @bitmap-name: the bitmap to be used in incremental mode.
+#
 # @granularity: granularity of the dirty bitmap, default is 64K
 #               if the image format doesn't have clusters, 4K if the clusters
 #               are smaller than that, else the cluster size.  Must be a
@@ -1768,7 +1770,7 @@
 { 'struct': 'DriveMirror',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*format': 'str', '*node-name': 'str', '*replaces': 'str',
-            'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
+            'sync': 'MirrorSyncMode', '*bitmap-name': 'str', '*mode': 'NewImageMode',
             '*speed': 'int', '*granularity': 'uint32',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
diff --git a/util/hbitmap.c b/util/hbitmap.c
index 8d402c5..7ae2fc2 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -765,6 +765,34 @@ bool hbitmap_merge(const HBitmap *a, const HBitmap *b, HBitmap *result)
     return true;
 }
 
+/*
+ * Copy HBitmaps form src to dst.
+ *
+ * @return true if the copy was successful,
+ *         false if it was not attempted.
+ */
+bool hbitmap_copy(HBitmap *dst, const HBitmap *src)
+{
+    int i;
+
+    if ((dst->size != src->size) || (dst->granularity != src->granularity)) {
+        return false;
+    }
+
+    if (hbitmap_count(src) == 0) {
+        return true;
+    }
+
+    for (i = HBITMAP_LEVELS - 1; i >= 0; i--) {
+        memcpy(dst->levels[i], src->levels[i],
+               src->sizes[i] * sizeof(unsigned long));
+    }
+
+    dst->count = src->count;
+    return true;
+}
+
+
 HBitmap *hbitmap_create_meta(HBitmap *hb, int chunk_size)
 {
     assert(!(chunk_size & (chunk_size - 1)));
-- 
1.8.3.1
