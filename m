Received: from eggs.gnu.org ([209.51.188.92]:38252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1gpBIJ-00043k-3q
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mahaocong_work@163.com>) id 1gpBIH-0001CD-FQ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:18:11 -0500
From: mahaocong <mahaocong_work@163.com>
Date: Thu, 31 Jan 2019 20:17:15 +0800
Message-Id: <20190131121715.22954-1-mahaocong_work@163.com>
Subject: [Qemu-devel] [PATCH v3] drive-mirror: add incremental mode
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

This patch adds possibility to start mirroring with user-created-bitmap.
On full mode, mirror create a non-named-bitmap by scanning whole block-chain,
and on top mode, mirror create a bitmap by scanning the top block layer. So I
think I can copy a user-created-bitmap and use it as the initial state of the
mirror, the same as incremental mode drive-backup, and I call this new mode
as incremental mode drive-mirror.

A possible usage scene of incremental mode mirror is live migration. For maintain
the block data and recover after a malfunction, someone may backup data to ceph
or other distributed storage. On qemu incremental backup, we need to create a new
bitmap and attach to block device before the first backup job. Then the bitmap
records the change after the backup job. If we want to migration this vm, we can
migrate block data between source and destionation by using drive-mirror directly,
or use backup data and backup-bitmap to reduce the data should be synchronize.
To do this, we should first create a new image in destination and set backing file
as backup image, then set backup-bitmap as the initial state of incremental mode
drive-mirror, and synchronize dirty block starting with the state set by the last
incremental backup job. When the mirror complete, we get an active layer on destination,
and its backing file is backup image on ceph. Then we can do live copy data from
backing files into overlay images by using block-stream, or do backup continually.

In this scene, It seems that If the guest os doesn't write too many data after the
last backup, the incremental mode may transmit less data than full mode or top
mode. However, if the write data is too many, there is no advantage on incremental
mode compare with other mode.

This scene can be described as following steps:
1.create rbd image in ceph, and map nbd device with rbd image.
2.create a new bitmap and attach to block device.
3.do full mode backup on nbd device and thus sync it to the rbd image.
4.severl times incremental mode backup.
5.create new image in destination and set its backing file as backup image.
6.do live-migration, and migrate block data by incremental mode drive-mirror
  with bitmap created from step 2.

Signed-off-by: Ma Haocong <mahaocong@didichuxing.com>
---
 compare with old version, there are following changes:
 1.replace the copy bitmap function by bdrv_merge_dirty_bitmap
 2.remove checking for cancelled after mirror_dirty_init_incremental for bitmap
   copyimg don't have yield point.
 3.adjuest input parameters on mirror_start_job and mirror_start, and so It is
   no need to find bitmap on mirror_dirty_init_incremental again.
 4.assert the bitmap name is NULL on blockdev_mirror_common.
 5.change the parameter's name in qmp command 'drive-mirror' from 'bitmap_name'
   to 'bitmap'.
 6.change the discribe of parameter 'bitmap' in block-core.json.

 block/mirror.c            | 46 ++++++++++++++++++++++++++++++++++------------
 blockdev.c                | 41 ++++++++++++++++++++++++++++++++++++-----
 include/block/block_int.h |  3 ++-
 qapi/block-core.json      |  7 ++++++-
 4 files changed, 78 insertions(+), 19 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index ab59ad77e8..c59aefe9f0 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -50,6 +50,7 @@ typedef struct MirrorBlockJob {
     /* Used to block operations on the drive-mirror-replace target */
     Error *replace_blocker;
     bool is_none_mode;
+    BdrvDirtyBitmap *src_bitmap;
     BlockMirrorBackingMode backing_mode;
     MirrorCopyMode copy_mode;
     BlockdevOnError on_source_error, on_target_error;
@@ -814,6 +815,15 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
     return 0;
 }
 
+/*
+ * init dirty bitmap by using user bitmap. usr->hbitmap will be copy to
+ * mirror bitmap->hbitmap instead of reuse it.
+ */
+static void coroutine_fn mirror_dirty_init_incremental(MirrorBlockJob *s, Error **errp)
+{
+    bdrv_merge_dirty_bitmap(s->dirty_bitmap, s->src_bitmap, NULL, errp);
+}
+
 /* Called when going out of the streaming phase to flush the bulk of the
  * data to the medium, or just before completing.
  */
@@ -839,6 +849,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
     char backing_filename[2]; /* we only need 2 characters because we are only
                                  checking for a NULL string */
     int ret = 0;
+    Error *local_err = NULL;
 
     if (job_is_cancelled(&s->common.job)) {
         goto immediate_exit;
@@ -913,9 +924,19 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
 
     s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     if (!s->is_none_mode) {
-        ret = mirror_dirty_init(s);
-        if (ret < 0 || job_is_cancelled(&s->common.job)) {
-            goto immediate_exit;
+        /* incremental mode */
+        if (s->src_bitmap) {
+            mirror_dirty_init_incremental(s, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                ret = -1;
+                goto immediate_exit;
+            }
+        } else {
+            ret = mirror_dirty_init(s);
+            if (ret < 0 || job_is_cancelled(&s->common.job)) {
+                goto immediate_exit;
+            }
         }
     }
 
@@ -1484,7 +1505,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              BlockCompletionFunc *cb,
                              void *opaque,
                              const BlockJobDriver *driver,
-                             bool is_none_mode, BlockDriverState *base,
+                             bool is_none_mode, BdrvDirtyBitmap *src_bitmap,
+                             BlockDriverState *base,
                              bool auto_complete, const char *filter_node_name,
                              bool is_mirror, MirrorCopyMode copy_mode,
                              Error **errp)
@@ -1598,6 +1620,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     s->on_source_error = on_source_error;
     s->on_target_error = on_target_error;
     s->is_none_mode = is_none_mode;
+    s->src_bitmap = src_bitmap;
     s->backing_mode = backing_mode;
     s->copy_mode = copy_mode;
     s->base = base;
@@ -1664,7 +1687,8 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
-                  MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
+                  MirrorSyncMode mode, BdrvDirtyBitmap *src_bitmap,
+                  BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name,
@@ -1673,17 +1697,14 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
     bool is_none_mode;
     BlockDriverState *base;
 
-    if (mode == MIRROR_SYNC_MODE_INCREMENTAL) {
-        error_setg(errp, "Sync mode 'incremental' not supported");
-        return;
-    }
     is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
     base = mode == MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;
     mirror_start_job(job_id, bs, creation_flags, target, replaces,
                      speed, granularity, buf_size, backing_mode,
                      on_source_error, on_target_error, unmap, NULL, NULL,
-                     &mirror_job_driver, is_none_mode, base, false,
-                     filter_node_name, true, copy_mode, errp);
+                     &mirror_job_driver, is_none_mode,
+                     src_bitmap, base, false, filter_node_name, true,
+                     copy_mode, errp);
 }
 
 void commit_active_start(const char *job_id, BlockDriverState *bs,
@@ -1707,7 +1728,8 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
     mirror_start_job(job_id, bs, creation_flags, base, NULL, speed, 0, 0,
                      MIRROR_LEAVE_BACKING_CHAIN,
                      on_error, on_error, true, cb, opaque,
-                     &commit_active_job_driver, false, base, auto_complete,
+                     &commit_active_job_driver, false,
+                     NULL, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
                      &local_err);
     if (local_err) {
diff --git a/blockdev.c b/blockdev.c
index e6c8349409..969362d36a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -992,9 +992,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
     blk = blockdev_init(filename, bs_opts, &local_err);
     bs_opts = NULL;
     if (!blk) {
-        if (local_err) {
-            error_propagate(errp, local_err);
-        }
+        error_propagate(errp, local_err);
         goto fail;
     } else {
         assert(!local_err);
@@ -3663,6 +3661,8 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    BlockDriverState *target,
                                    bool has_replaces, const char *replaces,
                                    enum MirrorSyncMode sync,
+                                   bool has_bitmap,
+                                   const char *bitmap_name,
                                    BlockMirrorBackingMode backing_mode,
                                    bool has_speed, int64_t speed,
                                    bool has_granularity, uint32_t granularity,
@@ -3680,6 +3680,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    Error **errp)
 {
     int job_flags = JOB_DEFAULT;
+    BdrvDirtyBitmap *src_bitmap = NULL;
 
     if (!has_speed) {
         speed = 0;
@@ -3702,6 +3703,24 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
     if (!has_filter_node_name) {
         filter_node_name = NULL;
     }
+    if (!has_bitmap) {
+        bitmap_name = NULL;
+    }
+    /*
+     * In incremental mode, we should create null name bitmap by
+     * using user bitmap's granularity.
+     */
+    if (sync == MIRROR_SYNC_MODE_INCREMENTAL) {
+        assert(bitmap_name);
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
@@ -3739,7 +3758,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
      */
     mirror_start(job_id, bs, target,
                  has_replaces ? replaces : NULL, job_flags,
-                 speed, granularity, buf_size, sync, backing_mode,
+                 speed, granularity, buf_size, sync, src_bitmap, backing_mode,
                  on_source_error, on_target_error, unmap, filter_node_name,
                  copy_mode, errp);
 }
@@ -3786,6 +3805,16 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     if (arg->sync == MIRROR_SYNC_MODE_NONE) {
         source = bs;
     }
+    if ((arg->sync == MIRROR_SYNC_MODE_INCREMENTAL) &&
+        (!arg->has_bitmap)) {
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
@@ -3880,6 +3909,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
 
     blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, target_bs,
                            arg->has_replaces, arg->replaces, arg->sync,
+                           arg->has_bitmap, arg->bitmap,
                            backing_mode, arg->has_speed, arg->speed,
                            arg->has_granularity, arg->granularity,
                            arg->has_buf_size, arg->buf_size,
@@ -3937,7 +3967,8 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
     bdrv_set_aio_context(target_bs, aio_context);
 
     blockdev_mirror_common(has_job_id ? job_id : NULL, bs, target_bs,
-                           has_replaces, replaces, sync, backing_mode,
+                           has_replaces, replaces, sync, false, NULL,
+                           backing_mode,
                            has_speed, speed,
                            has_granularity, granularity,
                            has_buf_size, buf_size,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f605622216..57a441f992 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1054,7 +1054,8 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
-                  MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
+                  MirrorSyncMode mode, BdrvDirtyBitmap *src_bitmap,
+                  BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 762000f31f..e4004cf28b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1727,6 +1727,11 @@
 #        (all the disk, only the sectors allocated in the topmost image, or
 #        only new I/O).
 #
+# @bitmap: the name of a pre-existing bitmap to use in incremental mode;
+#          must be present for incremental mode and absent otherwise. In
+#          incremental mode, granularity should not be set, because the bitmap's
+#          granularity is used instead (since 4.0).
+#
 # @granularity: granularity of the dirty bitmap, default is 64K
 #               if the image format doesn't have clusters, 4K if the clusters
 #               are smaller than that, else the cluster size.  Must be a
@@ -1768,7 +1773,7 @@
 { 'struct': 'DriveMirror',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*format': 'str', '*node-name': 'str', '*replaces': 'str',
-            'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
+            'sync': 'MirrorSyncMode', '*bitmap': 'str', '*mode': 'NewImageMode',
             '*speed': 'int', '*granularity': 'uint32',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
-- 
2.14.1
