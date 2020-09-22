Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75EBC4727E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F5A2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F5A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeaN-0000Eg-3o
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1kKeW1-0002FZ-LW; Tue, 22 Sep 2020 05:23:13 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:32658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1kKeVx-0005cZ-4x; Tue, 22 Sep 2020 05:23:13 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 60C37454AC;
 Tue, 22 Sep 2020 11:14:30 +0200 (CEST)
From: =?UTF-8?q?Fabian=20Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu 1/4] drive-mirror: add support for sync=bitmap mode=never
Date: Tue, 22 Sep 2020 11:14:15 +0200
Message-Id: <20200922091418.53562-2-f.gruenbichler@proxmox.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200922091418.53562-1-f.gruenbichler@proxmox.com>
References: <20200922091418.53562-1-f.gruenbichler@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.186.127.180;
 envelope-from=f.gruenbichler@proxmox.com; helo=proxmox-new.maurer-it.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 05:14:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Ma Haocong <mahaocong@didichuxing.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

This patch adds support for the "BITMAP" sync mode to drive-mirror and
blockdev-mirror. It adds support only for the BitmapSyncMode "never,"
because it's the simplest mode.

This mode simply uses a user-provided bitmap as an initial copy
manifest, and then does not clear any bits in the bitmap at the
conclusion of the operation.

Any new writes dirtied during the operation are copied out, in contrast
to backup. Note that whether these writes are reflected in the bitmap
at the conclusion of the operation depends on whether that bitmap is
actually recording!

This patch was originally based on one by Ma Haocong, but it has since
been modified pretty heavily.

Suggested-by: Ma Haocong <mahaocong@didichuxing.com>
Signed-off-by: Ma Haocong <mahaocong@didichuxing.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Fabian Grünbichler <f.gruenbichler@proxmox.com>
---
 include/block/block_int.h   |  4 +-
 block/mirror.c              | 98 ++++++++++++++++++++++++++++++-------
 blockdev.c                  | 39 +++++++++++++--
 tests/test-block-iothread.c |  4 +-
 qapi/block-core.json        | 29 +++++++++--
 5 files changed, 145 insertions(+), 29 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 38cad9d15c..8b7cec67ad 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1230,7 +1230,9 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
-                  MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
+                  MirrorSyncMode mode, BdrvDirtyBitmap *bitmap,
+                  BitmapSyncMode bitmap_mode,
+                  BlockMirrorBackingMode backing_mode,
                   bool zero_target,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
diff --git a/block/mirror.c b/block/mirror.c
index 26acf4af6f..d64c8203ef 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -50,7 +50,7 @@ typedef struct MirrorBlockJob {
     BlockDriverState *to_replace;
     /* Used to block operations on the drive-mirror-replace target */
     Error *replace_blocker;
-    bool is_none_mode;
+    MirrorSyncMode sync_mode;
     BlockMirrorBackingMode backing_mode;
     /* Whether the target image requires explicit zero-initialization */
     bool zero_target;
@@ -65,6 +65,8 @@ typedef struct MirrorBlockJob {
     size_t buf_size;
     int64_t bdev_length;
     unsigned long *cow_bitmap;
+    BdrvDirtyBitmap *sync_bitmap;
+    BitmapSyncMode bitmap_mode;
     BdrvDirtyBitmap *dirty_bitmap;
     BdrvDirtyBitmapIter *dbi;
     uint8_t *buf;
@@ -677,7 +679,8 @@ static int mirror_exit_common(Job *job)
     bdrv_child_refresh_perms(mirror_top_bs, mirror_top_bs->backing,
                              &error_abort);
     if (!abort && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
-        BlockDriverState *backing = s->is_none_mode ? src : s->base;
+        BlockDriverState *backing;
+        backing = s->sync_mode == MIRROR_SYNC_MODE_NONE ? src : s->base;
         BlockDriverState *unfiltered_target = bdrv_skip_filters(target_bs);
 
         if (bdrv_cow_bs(unfiltered_target) != backing) {
@@ -774,6 +777,16 @@ static void mirror_abort(Job *job)
     assert(ret == 0);
 }
 
+/* Always called after commit/abort. */
+static void mirror_clean(Job *job)
+{
+    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
+
+    if (s->sync_bitmap) {
+        bdrv_dirty_bitmap_set_busy(s->sync_bitmap, false);
+    }
+}
+
 static void coroutine_fn mirror_throttle(MirrorBlockJob *s)
 {
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
@@ -955,7 +968,8 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
     mirror_free_init(s);
 
     s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    if (!s->is_none_mode) {
+    if ((s->sync_mode == MIRROR_SYNC_MODE_TOP) ||
+        (s->sync_mode == MIRROR_SYNC_MODE_FULL)) {
         ret = mirror_dirty_init(s);
         if (ret < 0 || job_is_cancelled(&s->common.job)) {
             goto immediate_exit;
@@ -1188,6 +1202,7 @@ static const BlockJobDriver mirror_job_driver = {
         .run                    = mirror_run,
         .prepare                = mirror_prepare,
         .abort                  = mirror_abort,
+        .clean                  = mirror_clean,
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
     },
@@ -1203,6 +1218,7 @@ static const BlockJobDriver commit_active_job_driver = {
         .run                    = mirror_run,
         .prepare                = mirror_prepare,
         .abort                  = mirror_abort,
+        .clean                  = mirror_clean,
         .pause                  = mirror_pause,
         .complete               = mirror_complete,
     },
@@ -1550,7 +1566,10 @@ static BlockJob *mirror_start_job(
                              BlockCompletionFunc *cb,
                              void *opaque,
                              const BlockJobDriver *driver,
-                             bool is_none_mode, BlockDriverState *base,
+                             MirrorSyncMode sync_mode,
+                             BdrvDirtyBitmap *bitmap,
+                             BitmapSyncMode bitmap_mode,
+                             BlockDriverState *base,
                              bool auto_complete, const char *filter_node_name,
                              bool is_mirror, MirrorCopyMode copy_mode,
                              Error **errp)
@@ -1563,10 +1582,39 @@ static BlockJob *mirror_start_job(
     Error *local_err = NULL;
     int ret;
 
-    if (granularity == 0) {
-        granularity = bdrv_get_default_bitmap_granularity(target);
+    if (sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
+        error_setg(errp, "Sync mode '%s' not supported",
+                   MirrorSyncMode_str(sync_mode));
+        return NULL;
+    } else if (sync_mode == MIRROR_SYNC_MODE_BITMAP) {
+        if (!bitmap) {
+            error_setg(errp, "Must provide a valid bitmap name for '%s'"
+                       " sync mode",
+                       MirrorSyncMode_str(sync_mode));
+            return NULL;
+        } else if (bitmap_mode != BITMAP_SYNC_MODE_NEVER) {
+            error_setg(errp,
+                       "Bitmap Sync Mode '%s' is not supported by Mirror",
+                       BitmapSyncMode_str(bitmap_mode));
+        }
+    } else if (bitmap) {
+        error_setg(errp,
+                   "sync mode '%s' is not compatible with bitmaps",
+                   MirrorSyncMode_str(sync_mode));
+        return NULL;
     }
 
+    if (bitmap) {
+        if (granularity) {
+            error_setg(errp, "granularity (%d)"
+                       "cannot be specified when a bitmap is provided",
+                       granularity);
+            return NULL;
+        }
+        granularity = bdrv_dirty_bitmap_granularity(bitmap);
+    } else if (granularity == 0) {
+        granularity = bdrv_get_default_bitmap_granularity(target);
+    }
     assert(is_power_of_2(granularity));
 
     if (buf_size < 0) {
@@ -1705,7 +1753,9 @@ static BlockJob *mirror_start_job(
     s->replaces = g_strdup(replaces);
     s->on_source_error = on_source_error;
     s->on_target_error = on_target_error;
-    s->is_none_mode = is_none_mode;
+    s->sync_mode = sync_mode;
+    s->sync_bitmap = bitmap;
+    s->bitmap_mode = bitmap_mode;
     s->backing_mode = backing_mode;
     s->zero_target = zero_target;
     s->copy_mode = copy_mode;
@@ -1726,6 +1776,18 @@ static BlockJob *mirror_start_job(
         bdrv_disable_dirty_bitmap(s->dirty_bitmap);
     }
 
+    if (s->sync_bitmap) {
+        bdrv_dirty_bitmap_set_busy(s->sync_bitmap, true);
+    }
+
+    if (s->sync_mode == MIRROR_SYNC_MODE_BITMAP) {
+        bdrv_merge_dirty_bitmap(s->dirty_bitmap, s->sync_bitmap,
+                                NULL, &local_err);
+        if (local_err) {
+            goto fail;
+        }
+    }
+
     ret = block_job_add_bdrv(&s->common, "source", bs, 0,
                              BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
                              BLK_PERM_CONSISTENT_READ,
@@ -1803,6 +1865,9 @@ fail:
         if (s->dirty_bitmap) {
             bdrv_release_dirty_bitmap(s->dirty_bitmap);
         }
+        if (s->sync_bitmap) {
+            bdrv_dirty_bitmap_set_busy(s->sync_bitmap, false);
+        }
         job_early_fail(&s->common.job);
     }
 
@@ -1820,29 +1885,23 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, const char *replaces,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
-                  MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
+                  MirrorSyncMode mode, BdrvDirtyBitmap *bitmap,
+                  BitmapSyncMode bitmap_mode,
+                  BlockMirrorBackingMode backing_mode,
                   bool zero_target,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name,
                   MirrorCopyMode copy_mode, Error **errp)
 {
-    bool is_none_mode;
     BlockDriverState *base;
 
-    if ((mode == MIRROR_SYNC_MODE_INCREMENTAL) ||
-        (mode == MIRROR_SYNC_MODE_BITMAP)) {
-        error_setg(errp, "Sync mode '%s' not supported",
-                   MirrorSyncMode_str(mode));
-        return;
-    }
-    is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
     base = mode == MIRROR_SYNC_MODE_TOP ? bdrv_backing_chain_next(bs) : NULL;
     mirror_start_job(job_id, bs, creation_flags, target, replaces,
                      speed, granularity, buf_size, backing_mode, zero_target,
                      on_source_error, on_target_error, unmap, NULL, NULL,
-                     &mirror_job_driver, is_none_mode, base, false,
-                     filter_node_name, true, copy_mode, errp);
+                     &mirror_job_driver, mode, bitmap, bitmap_mode, base,
+                     false, filter_node_name, true, copy_mode, errp);
 }
 
 BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
@@ -1868,7 +1927,8 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
                      job_id, bs, creation_flags, base, NULL, speed, 0, 0,
                      MIRROR_LEAVE_BACKING_CHAIN, false,
                      on_error, on_error, true, cb, opaque,
-                     &commit_active_job_driver, false, base, auto_complete,
+                     &commit_active_job_driver, MIRROR_SYNC_MODE_FULL,
+                     NULL, 0, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
                      &local_err);
     if (local_err) {
diff --git a/blockdev.c b/blockdev.c
index 7f2561081e..6baa1a33f5 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2920,6 +2920,10 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    BlockDriverState *target,
                                    bool has_replaces, const char *replaces,
                                    enum MirrorSyncMode sync,
+                                   bool has_bitmap,
+                                   const char *bitmap_name,
+                                   bool has_bitmap_mode,
+                                   BitmapSyncMode bitmap_mode,
                                    BlockMirrorBackingMode backing_mode,
                                    bool zero_target,
                                    bool has_speed, int64_t speed,
@@ -2939,6 +2943,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
 {
     BlockDriverState *unfiltered_bs;
     int job_flags = JOB_DEFAULT;
+    BdrvDirtyBitmap *bitmap = NULL;
 
     if (!has_speed) {
         speed = 0;
@@ -2993,6 +2998,29 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
         sync = MIRROR_SYNC_MODE_FULL;
     }
 
+    if (has_bitmap) {
+        if (granularity) {
+            error_setg(errp, "Granularity and bitmap cannot both be set");
+            return;
+        }
+
+        if (!has_bitmap_mode) {
+            error_setg(errp, "bitmap-mode must be specified if"
+                       " a bitmap is provided");
+            return;
+        }
+
+        bitmap = bdrv_find_dirty_bitmap(bs, bitmap_name);
+        if (!bitmap) {
+            error_setg(errp, "Dirty bitmap '%s' not found", bitmap_name);
+            return;
+        }
+
+        if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_ALLOW_RO, errp)) {
+            return;
+        }
+    }
+
     if (!has_replaces) {
         /* We want to mirror from @bs, but keep implicit filters on top */
         unfiltered_bs = bdrv_skip_implicit_filters(bs);
@@ -3039,8 +3067,8 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
      * and will allow to check whether the node still exist at mirror completion
      */
     mirror_start(job_id, bs, target,
-                 has_replaces ? replaces : NULL, job_flags,
-                 speed, granularity, buf_size, sync, backing_mode, zero_target,
+                 has_replaces ? replaces : NULL, job_flags, speed, granularity,
+                 buf_size, sync, bitmap, bitmap_mode, backing_mode, zero_target,
                  on_source_error, on_target_error, unmap, filter_node_name,
                  copy_mode, errp);
 }
@@ -3185,6 +3213,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
 
     blockdev_mirror_common(arg->has_job_id ? arg->job_id : NULL, bs, target_bs,
                            arg->has_replaces, arg->replaces, arg->sync,
+                           arg->has_bitmap, arg->bitmap,
+                           arg->has_bitmap_mode, arg->bitmap_mode,
                            backing_mode, zero_target,
                            arg->has_speed, arg->speed,
                            arg->has_granularity, arg->granularity,
@@ -3206,6 +3236,8 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
                          const char *device, const char *target,
                          bool has_replaces, const char *replaces,
                          MirrorSyncMode sync,
+                         bool has_bitmap, const char *bitmap,
+                         bool has_bitmap_mode, BitmapSyncMode bitmap_mode,
                          bool has_speed, int64_t speed,
                          bool has_granularity, uint32_t granularity,
                          bool has_buf_size, int64_t buf_size,
@@ -3255,7 +3287,8 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
     }
 
     blockdev_mirror_common(has_job_id ? job_id : NULL, bs, target_bs,
-                           has_replaces, replaces, sync, backing_mode,
+                           has_replaces, replaces, sync, has_bitmap,
+                           bitmap, has_bitmap_mode, bitmap_mode, backing_mode,
                            zero_target, has_speed, speed,
                            has_granularity, granularity,
                            has_buf_size, buf_size,
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 3f866a35c6..500ede71c8 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -623,8 +623,8 @@ static void test_propagate_mirror(void)
 
     /* Start a mirror job */
     mirror_start("job0", src, target, NULL, JOB_DEFAULT, 0, 0, 0,
-                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN, false,
-                 BLOCKDEV_ON_ERROR_REPORT, BLOCKDEV_ON_ERROR_REPORT,
+                 MIRROR_SYNC_MODE_NONE, NULL, 0, MIRROR_OPEN_BACKING_CHAIN,
+                 false, BLOCKDEV_ON_ERROR_REPORT, BLOCKDEV_ON_ERROR_REPORT,
                  false, "filter_node", MIRROR_COPY_MODE_BACKGROUND,
                  &error_abort);
     job = job_get("job0");
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2d94873ca0..dac5497084 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1961,10 +1961,19 @@
 #        (all the disk, only the sectors allocated in the topmost image, or
 #        only new I/O).
 #
+# @bitmap: The name of a bitmap to use for sync=bitmap mode. This argument must
+#          be present for bitmap mode and absent otherwise. The bitmap's
+#          granularity is used instead of @granularity (since 5.2).
+#
+# @bitmap-mode: Specifies the type of data the bitmap should contain after
+#               the operation concludes. Must be present if sync is "bitmap".
+#               Must NOT be present otherwise. (Since 5.2)
+#
 # @granularity: granularity of the dirty bitmap, default is 64K
 #               if the image format doesn't have clusters, 4K if the clusters
 #               are smaller than that, else the cluster size.  Must be a
-#               power of 2 between 512 and 64M (since 1.4).
+#               power of 2 between 512 and 64M. Must not be specified if
+#               @bitmap is present (since 1.4).
 #
 # @buf-size: maximum amount of data in flight from source to
 #            target (since 1.4).
@@ -2002,7 +2011,9 @@
 { 'struct': 'DriveMirror',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*format': 'str', '*node-name': 'str', '*replaces': 'str',
-            'sync': 'MirrorSyncMode', '*mode': 'NewImageMode',
+            'sync': 'MirrorSyncMode', '*bitmap': 'str',
+            '*bitmap-mode': 'BitmapSyncMode',
+            '*mode': 'NewImageMode',
             '*speed': 'int', '*granularity': 'uint32',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
@@ -2270,10 +2281,19 @@
 #        (all the disk, only the sectors allocated in the topmost image, or
 #        only new I/O).
 #
+# @bitmap: The name of a bitmap to use for sync=bitmap mode. This argument must
+#          be present for bitmap mode and absent otherwise. The bitmap's
+#          granularity is used instead of @granularity (since 5.2).
+#
+# @bitmap-mode: Specifies the type of data the bitmap should contain after
+#               the operation concludes. Must be present if sync is "bitmap".
+#               Must NOT be present otherwise. (Since 5.2)
+#
 # @granularity: granularity of the dirty bitmap, default is 64K
 #               if the image format doesn't have clusters, 4K if the clusters
 #               are smaller than that, else the cluster size.  Must be a
-#               power of 2 between 512 and 64M
+#               power of 2 between 512 and 64M . Must not be specified if
+#               @bitmap is present.
 #
 # @buf-size: maximum amount of data in flight from source to
 #            target
@@ -2322,7 +2342,8 @@
 { 'command': 'blockdev-mirror',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             '*replaces': 'str',
-            'sync': 'MirrorSyncMode',
+            'sync': 'MirrorSyncMode', '*bitmap': 'str',
+            '*bitmap-mode': 'BitmapSyncMode',
             '*speed': 'int', '*granularity': 'uint32',
             '*buf-size': 'int', '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
-- 
2.20.1



