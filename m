Received: from eggs.gnu.org ([2001:4830:134:3::10]:33400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel.kucera@gmail.com>) id 1d6EPU-0004hp-NF
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel.kucera@gmail.com>) id 1d6EPP-0001OW-Q1
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:55:00 -0400
From: Daniel Kucera <daniel.kucera@gmail.com>
Date: Thu,  4 May 2017 12:54:40 +0200
Message-Id: <20170504105444.8940-1-daniel.kucera@gmail.com>
Subject: [Qemu-devel] [PATCH] mirror: add sync mode incremental to
 drive-mirror and blockdev-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Kucera <daniel.kucera@gmail.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "open list:Block Jobs" <qemu-block@nongnu.org>

parameter bitmap chooses existing dirtymap instead of newly created
in mirror_start_job

Signed-off-by: Daniel Kucera <daniel.kucera@gmail.com>
---
 block/mirror.c            | 47 ++++++++++++++++++++++++++++++-----------------
 blockdev.c                | 16 +++++++++++++++-
 include/block/block_int.h |  4 +++-
 qapi/block-core.json      | 12 ++++++++++--
 4 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 9f5eb69..1bfbe2e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -49,7 +49,7 @@ typedef struct MirrorBlockJob {
     BlockDriverState *to_replace;
     /* Used to block operations on the drive-mirror-replace target */
     Error *replace_blocker;
-    bool is_none_mode;
+    MirrorSyncMode sync_mode;
     BlockMirrorBackingMode backing_mode;
     BlockdevOnError on_source_error, on_target_error;
     bool synced;
@@ -523,7 +523,9 @@ static void mirror_exit(BlockJob *job, void *opaque)
     bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
                             &error_abort);
     if (s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
-        BlockDriverState *backing = s->is_none_mode ? src : s->base;
+        BlockDriverState *backing =
+        (s->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) ||
+        (s->sync_mode == MIRROR_SYNC_MODE_NONE) ? src : s->base;
         if (backing_bs(target_bs) != backing) {
             bdrv_set_backing_hd(target_bs, backing, &local_err);
             if (local_err) {
@@ -771,7 +773,8 @@ static void coroutine_fn mirror_run(void *opaque)
     mirror_free_init(s);
 
     s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    if (!s->is_none_mode) {
+    if ((s->sync_mode != MIRROR_SYNC_MODE_INCREMENTAL) &&
+      (s->sync_mode != MIRROR_SYNC_MODE_NONE)) {
         ret = mirror_dirty_init(s);
         if (ret < 0 || block_job_is_cancelled(&s->common)) {
             goto immediate_exit;
@@ -1114,7 +1117,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              BlockCompletionFunc *cb,
                              void *opaque,
                              const BlockJobDriver *driver,
-                             bool is_none_mode, BlockDriverState *base,
+                             MirrorSyncMode sync_mode, const char *bitmap,
+                             BlockDriverState *base,
                              bool auto_complete, const char *filter_node_name,
                              Error **errp)
 {
@@ -1203,7 +1207,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     s->replaces = g_strdup(replaces);
     s->on_source_error = on_source_error;
     s->on_target_error = on_target_error;
-    s->is_none_mode = is_none_mode;
+    s->sync_mode = sync_mode;
     s->backing_mode = backing_mode;
     s->base = base;
     s->granularity = granularity;
@@ -1213,9 +1217,21 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         s->should_complete = true;
     }
 
-    s->dirty_bitmap = bdrv_create_dirty_bitmap(bs, granularity, NULL, errp);
-    if (!s->dirty_bitmap) {
-        goto fail;
+    if (s->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
+        if (bitmap == NULL) {
+            error_setg(errp, "Mode incremental requires parameter 'bitmap'");
+            goto fail;
+        }
+        s->dirty_bitmap = bdrv_find_dirty_bitmap(bs, bitmap);
+        if (!s->dirty_bitmap) {
+            error_setg(errp, "Bitmap '%s' not found", bitmap);
+            goto fail;
+        }
+    } else {
+        s->dirty_bitmap = bdrv_create_dirty_bitmap(bs, granularity, NULL, errp);
+        if (!s->dirty_bitmap) {
+            goto fail;
+        }
     }
 
     /* Required permissions are already taken with blk_new() */
@@ -1265,24 +1281,20 @@ fail:
 void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
                   int64_t speed, uint32_t granularity, int64_t buf_size,
-                  MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
+                  MirrorSyncMode mode, const char *bitmap,
+                  BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name, Error **errp)
 {
-    bool is_none_mode;
     BlockDriverState *base;
 
-    if (mode == MIRROR_SYNC_MODE_INCREMENTAL) {
-        error_setg(errp, "Sync mode 'incremental' not supported");
-        return;
-    }
-    is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
     base = mode == MIRROR_SYNC_MODE_TOP ? backing_bs(bs) : NULL;
+
     mirror_start_job(job_id, bs, BLOCK_JOB_DEFAULT, target, replaces,
                      speed, granularity, buf_size, backing_mode,
                      on_source_error, on_target_error, unmap, NULL, NULL,
-                     &mirror_job_driver, is_none_mode, base, false,
+                     &mirror_job_driver, mode, bitmap, base, false,
                      filter_node_name, errp);
 }
 
@@ -1305,7 +1317,8 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
     mirror_start_job(job_id, bs, creation_flags, base, NULL, speed, 0, 0,
                      MIRROR_LEAVE_BACKING_CHAIN,
                      on_error, on_error, true, cb, opaque,
-                     &commit_active_job_driver, false, base, auto_complete,
+                     &commit_active_job_driver, MIRROR_SYNC_MODE_FULL,
+                     NULL, base, auto_complete,
                      filter_node_name, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/blockdev.c b/blockdev.c
index 6428206..a25e7a8 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3379,6 +3379,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    enum MirrorSyncMode sync,
                                    BlockMirrorBackingMode backing_mode,
                                    bool has_speed, int64_t speed,
+                                   bool has_bitmap, const char *bitmap,
                                    bool has_granularity, uint32_t granularity,
                                    bool has_buf_size, int64_t buf_size,
                                    bool has_on_source_error,
@@ -3435,12 +3436,22 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
         sync = MIRROR_SYNC_MODE_FULL;
     }
 
+    if (sync == MIRROR_SYNC_MODE_INCREMENTAL && !has_bitmap) {
+        error_setg(errp, "Mode incremental requires parameter 'bitmap'");
+        return;
+    }
+
+    if (has_bitmap && sync != MIRROR_SYNC_MODE_INCREMENTAL) {
+        error_setg(errp, "Bitmap set but mode is not incremental");
+        return;
+    }
+
     /* pass the node name to replace to mirror start since it's loose coupling
      * and will allow to check whether the node still exist at mirror completion
      */
     mirror_start(job_id, bs, target,
                  has_replaces ? replaces : NULL,
-                 speed, granularity, buf_size, sync, backing_mode,
+                 speed, granularity, buf_size, sync, bitmap, backing_mode,
                  on_source_error, on_target_error, unmap, filter_node_name,
                  errp);
 }
@@ -3575,6 +3586,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, target_bs,
                            arg->has_replaces, arg->replaces, arg->sync,
                            backing_mode, arg->has_speed, arg->speed,
+                           arg->has_bitmap, arg->bitmap,
                            arg->has_granularity, arg->granularity,
                            arg->has_buf_size, arg->buf_size,
                            arg->has_on_source_error, arg->on_source_error,
@@ -3593,6 +3605,7 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                          bool has_replaces, const char *replaces,
                          MirrorSyncMode sync,
                          bool has_speed, int64_t speed,
+                         bool has_bitmap, const char *bitmap,
                          bool has_granularity, uint32_t granularity,
                          bool has_buf_size, int64_t buf_size,
                          bool has_on_source_error,
@@ -3627,6 +3640,7 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
     blockdev_mirror_common(has_job_id ? job_id : NULL, bs, target_bs,
                            has_replaces, replaces, sync, backing_mode,
                            has_speed, speed,
+                           has_bitmap, bitmap,
                            has_granularity, granularity,
                            has_buf_size, buf_size,
                            has_on_source_error, on_source_error,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4f8cd29..3c59d69 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -827,6 +827,7 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
  * @granularity: The chosen granularity for the dirty bitmap.
  * @buf_size: The amount of data that can be in flight at one time.
  * @mode: Whether to collapse all images in the chain to the target.
+ * @bitmap: The dirty bitmap if sync_mode is MIRROR_SYNC_MODE_INCREMENTAL.
  * @backing_mode: How to establish the target's backing chain after completion.
  * @on_source_error: The action to take upon error reading from the source.
  * @on_target_error: The action to take upon error writing to the target.
@@ -844,7 +845,8 @@ void commit_active_start(const char *job_id, BlockDriverState *bs,
 void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
                   int64_t speed, uint32_t granularity, int64_t buf_size,
-                  MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
+                  MirrorSyncMode mode, const char *bitmap,
+                  BlockMirrorBackingMode backing_mode,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name, Error **errp);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 87fb747..8e3d9b2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1502,6 +1502,10 @@
 #
 # @speed:  the maximum speed, in bytes per second
 #
+# @bitmap: the name of dirty bitmap if sync is "incremental".
+#          Must be present if sync is "incremental", must NOT be present
+#          otherwise. (Since 2.10)
+#
 # @sync: what parts of the disk image should be copied to the destination
 #        (all the disk, only the sectors allocated in the topmost image, or
 #        only new I/O).
@@ -1533,7 +1537,7 @@
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*format': 'str', '*node-name': 'str', '*replaces': 'str',
             'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
-            '*speed': 'int', '*granularity': 'uint32',
+            '*speed': 'int', '*bitmap': 'str', '*granularity': 'uint32',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*unmap': 'bool' } }
@@ -1652,6 +1656,10 @@
 #
 # @speed:  the maximum speed, in bytes per second
 #
+# @bitmap: the name of dirty bitmap if sync is "incremental".
+#          Must be present if sync is "incremental", must NOT be present
+#          otherwise. (Since 2.10)
+#
 # @sync: what parts of the disk image should be copied to the destination
 #        (all the disk, only the sectors allocated in the topmost image, or
 #        only new I/O).
@@ -1694,7 +1702,7 @@
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*replaces': 'str',
             'sync': 'MirrorSyncMode',
-            '*speed': 'int', '*granularity': 'uint32',
+            '*speed': 'int', '*bitmap': 'str', '*granularity': 'uint32',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*filter-node-name': 'str' } }
-- 
2.9.3
