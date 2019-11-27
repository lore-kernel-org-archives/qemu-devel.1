Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33B4C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAFE5204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFE5204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia29D-0004eX-Ok
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:34:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia1kD-0006gY-7m
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1ia1kA-0003u8-GJ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 13:08:52 -0500
Received: from relay.sw.ru ([185.231.240.75]:49964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia1k6-0003ij-1V; Wed, 27 Nov 2019 13:08:46 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1ia1k1-0002UU-GL; Wed, 27 Nov 2019 21:08:41 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 7/7] block/block-copy: hide structure definitions
Date: Wed, 27 Nov 2019 21:08:40 +0300
Message-Id: <20191127180840.11937-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191127180840.11937-1-vsementsov@virtuozzo.com>
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hide structure definitions and add explicit API instead, to keep an
eye on the scope of the shared fields.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h | 57 +++------------------------------
 block/backup-top.c         |  6 ++--
 block/backup.c             | 27 ++++++++--------
 block/block-copy.c         | 64 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 68 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index d96b097267..753fa663ac 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -18,61 +18,9 @@
 #include "block/block.h"
 #include "qemu/co-shared-resource.h"
 
-typedef struct BlockCopyInFlightReq {
-    int64_t offset;
-    int64_t bytes;
-    QLIST_ENTRY(BlockCopyInFlightReq) list;
-    CoQueue wait_queue; /* coroutines blocked on this request */
-} BlockCopyInFlightReq;
-
 typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
 typedef void (*ProgressResetCallbackFunc)(void *opaque);
-typedef struct BlockCopyState {
-    /*
-     * BdrvChild objects are not owned or managed by block-copy. They are
-     * provided by block-copy user and user is responsible for appropriate
-     * permissions on these children.
-     */
-    BdrvChild *source;
-    BdrvChild *target;
-    BdrvDirtyBitmap *copy_bitmap;
-    int64_t cluster_size;
-    bool use_copy_range;
-    int64_t copy_size;
-    uint64_t len;
-    QLIST_HEAD(, BlockCopyInFlightReq) inflight_reqs;
-
-    BdrvRequestFlags write_flags;
-
-    /*
-     * skip_unallocated:
-     *
-     * Used by sync=top jobs, which first scan the source node for unallocated
-     * areas and clear them in the copy_bitmap.  During this process, the bitmap
-     * is thus not fully initialized: It may still have bits set for areas that
-     * are unallocated and should actually not be copied.
-     *
-     * This is indicated by skip_unallocated.
-     *
-     * In this case, block_copy() will query the source’s allocation status,
-     * skip unallocated regions, clear them in the copy_bitmap, and invoke
-     * block_copy_reset_unallocated() every time it does.
-     */
-    bool skip_unallocated;
-
-    /* progress_bytes_callback: called when some copying progress is done. */
-    ProgressBytesCallbackFunc progress_bytes_callback;
-
-    /*
-     * progress_reset_callback: called when some bytes reset from copy_bitmap
-     * (see @skip_unallocated above). The callee is assumed to recalculate how
-     * many bytes remain based on the dirty bit count of copy_bitmap.
-     */
-    ProgressResetCallbackFunc progress_reset_callback;
-    void *progress_opaque;
-
-    SharedResource *mem;
-} BlockCopyState;
+typedef struct BlockCopyState BlockCopyState;
 
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      int64_t cluster_size,
@@ -93,4 +41,7 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
 int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
                             bool *error_is_read);
 
+BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
+void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
+
 #endif /* BLOCK_COPY_H */
diff --git a/block/backup-top.c b/block/backup-top.c
index 7cdb1f8eba..1026628b57 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -38,6 +38,7 @@ typedef struct BDRVBackupTopState {
     BlockCopyState *bcs;
     BdrvChild *target;
     bool active;
+    int64_t cluster_size;
 } BDRVBackupTopState;
 
 static coroutine_fn int backup_top_co_preadv(
@@ -51,8 +52,8 @@ static coroutine_fn int backup_top_cbw(BlockDriverState *bs, uint64_t offset,
                                        uint64_t bytes)
 {
     BDRVBackupTopState *s = bs->opaque;
-    uint64_t end = QEMU_ALIGN_UP(offset + bytes, s->bcs->cluster_size);
-    uint64_t off = QEMU_ALIGN_DOWN(offset, s->bcs->cluster_size);
+    uint64_t end = QEMU_ALIGN_UP(offset + bytes, s->cluster_size);
+    uint64_t off = QEMU_ALIGN_DOWN(offset, s->cluster_size);
 
     return block_copy(s->bcs, off, end - off, NULL);
 }
@@ -227,6 +228,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
         goto failed_after_append;
     }
 
+    state->cluster_size = cluster_size;
     state->bcs = block_copy_state_new(top->backing, state->target,
                                       cluster_size, write_flags, &local_err);
     if (local_err) {
diff --git a/block/backup.c b/block/backup.c
index cf62b1a38c..acab0d08da 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -48,6 +48,7 @@ typedef struct BackupBlockJob {
     int64_t cluster_size;
 
     BlockCopyState *bcs;
+    BdrvDirtyBitmap *bcs_bitmap;
 } BackupBlockJob;
 
 static const BlockJobDriver backup_job_driver;
@@ -63,7 +64,7 @@ static void backup_progress_bytes_callback(int64_t bytes, void *opaque)
 static void backup_progress_reset_callback(void *opaque)
 {
     BackupBlockJob *s = opaque;
-    uint64_t estimate = bdrv_get_dirty_count(s->bcs->copy_bitmap);
+    uint64_t estimate = bdrv_get_dirty_count(s->bcs_bitmap);
 
     job_progress_set_remaining(&s->common.job, estimate);
 }
@@ -111,8 +112,7 @@ static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
 
     if (ret < 0 && job->bitmap_mode == BITMAP_SYNC_MODE_ALWAYS) {
         /* If we failed and synced, merge in the bits we didn't copy: */
-        bdrv_dirty_bitmap_merge_internal(bm, job->bcs->copy_bitmap,
-                                         NULL, true);
+        bdrv_dirty_bitmap_merge_internal(bm, job->bcs_bitmap, NULL, true);
     }
 }
 
@@ -151,7 +151,7 @@ void backup_do_checkpoint(BlockJob *job, Error **errp)
         return;
     }
 
-    bdrv_set_dirty_bitmap(backup_job->bcs->copy_bitmap, 0, backup_job->len);
+    bdrv_set_dirty_bitmap(backup_job->bcs_bitmap, 0, backup_job->len);
 }
 
 static BlockErrorAction backup_error_action(BackupBlockJob *job,
@@ -196,7 +196,7 @@ static int coroutine_fn backup_loop(BackupBlockJob *job)
     BdrvDirtyBitmapIter *bdbi;
     int ret = 0;
 
-    bdbi = bdrv_dirty_iter_new(job->bcs->copy_bitmap);
+    bdbi = bdrv_dirty_iter_new(job->bcs_bitmap);
     while ((offset = bdrv_dirty_iter_next(bdbi)) != -1) {
         do {
             if (yield_and_check(job)) {
@@ -216,13 +216,13 @@ static int coroutine_fn backup_loop(BackupBlockJob *job)
     return ret;
 }
 
-static void backup_init_copy_bitmap(BackupBlockJob *job)
+static void backup_init_bcs_bitmap(BackupBlockJob *job)
 {
     bool ret;
     uint64_t estimate;
 
     if (job->sync_mode == MIRROR_SYNC_MODE_BITMAP) {
-        ret = bdrv_dirty_bitmap_merge_internal(job->bcs->copy_bitmap,
+        ret = bdrv_dirty_bitmap_merge_internal(job->bcs_bitmap,
                                                job->sync_bitmap,
                                                NULL, true);
         assert(ret);
@@ -232,12 +232,12 @@ static void backup_init_copy_bitmap(BackupBlockJob *job)
              * We can't hog the coroutine to initialize this thoroughly.
              * Set a flag and resume work when we are able to yield safely.
              */
-            job->bcs->skip_unallocated = true;
+            block_copy_set_skip_unallocated(job->bcs, true);
         }
-        bdrv_set_dirty_bitmap(job->bcs->copy_bitmap, 0, job->len);
+        bdrv_set_dirty_bitmap(job->bcs_bitmap, 0, job->len);
     }
 
-    estimate = bdrv_get_dirty_count(job->bcs->copy_bitmap);
+    estimate = bdrv_get_dirty_count(job->bcs_bitmap);
     job_progress_set_remaining(&job->common.job, estimate);
 }
 
@@ -246,7 +246,7 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
     int ret = 0;
 
-    backup_init_copy_bitmap(s);
+    backup_init_bcs_bitmap(s);
 
     if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
         int64_t offset = 0;
@@ -265,12 +265,12 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
 
             offset += count;
         }
-        s->bcs->skip_unallocated = false;
+        block_copy_set_skip_unallocated(s->bcs, false);
     }
 
     if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
         /*
-         * All bits are set in copy_bitmap to allow any cluster to be copied.
+         * All bits are set in bcs_bitmap to allow any cluster to be copied.
          * This does not actually require them to be copied.
          */
         while (!job_is_cancelled(job)) {
@@ -458,6 +458,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     job->sync_bitmap = sync_bitmap;
     job->bitmap_mode = bitmap_mode;
     job->bcs = bcs;
+    job->bcs_bitmap = block_copy_dirty_bitmap(bcs);
     job->cluster_size = cluster_size;
     job->len = len;
 
diff --git a/block/block-copy.c b/block/block-copy.c
index aca44b13fb..7e14e86a2d 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -24,6 +24,60 @@
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
 
+typedef struct BlockCopyInFlightReq {
+    int64_t offset;
+    int64_t bytes;
+    QLIST_ENTRY(BlockCopyInFlightReq) list;
+    CoQueue wait_queue; /* coroutines blocked on this request */
+} BlockCopyInFlightReq;
+
+typedef struct BlockCopyState {
+    /*
+     * BdrvChild objects are not owned or managed by block-copy. They are
+     * provided by block-copy user and user is responsible for appropriate
+     * permissions on these children.
+     */
+    BdrvChild *source;
+    BdrvChild *target;
+    BdrvDirtyBitmap *copy_bitmap;
+    int64_t cluster_size;
+    bool use_copy_range;
+    int64_t copy_size;
+    uint64_t len;
+    QLIST_HEAD(, BlockCopyInFlightReq) inflight_reqs;
+
+    BdrvRequestFlags write_flags;
+
+    /*
+     * skip_unallocated:
+     *
+     * Used by sync=top jobs, which first scan the source node for unallocated
+     * areas and clear them in the copy_bitmap.  During this process, the bitmap
+     * is thus not fully initialized: It may still have bits set for areas that
+     * are unallocated and should actually not be copied.
+     *
+     * This is indicated by skip_unallocated.
+     *
+     * In this case, block_copy() will query the source’s allocation status,
+     * skip unallocated regions, clear them in the copy_bitmap, and invoke
+     * block_copy_reset_unallocated() every time it does.
+     */
+    bool skip_unallocated;
+
+    /* progress_bytes_callback: called when some copying progress is done. */
+    ProgressBytesCallbackFunc progress_bytes_callback;
+
+    /*
+     * progress_reset_callback: called when some bytes reset from copy_bitmap
+     * (see @skip_unallocated above). The callee is assumed to recalculate how
+     * many bytes remain based on the dirty bit count of copy_bitmap.
+     */
+    ProgressResetCallbackFunc progress_reset_callback;
+    void *progress_opaque;
+
+    SharedResource *mem;
+} BlockCopyState;
+
 static BlockCopyInFlightReq *block_copy_find_inflight_req(BlockCopyState *s,
                                                           int64_t offset,
                                                           int64_t bytes)
@@ -492,3 +546,13 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t bytes,
 
     return 0;
 }
+
+BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s)
+{
+    return s->copy_bitmap;
+}
+
+void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip)
+{
+    s->skip_unallocated = skip;
+}
-- 
2.21.0


