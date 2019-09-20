Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9492C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7365C2080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7365C2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBK4J-0003qc-Sx
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBJme-0004hZ-0J
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iBJma-0000xR-IR
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:21:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:43794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBJmQ-0000gD-Ah; Fri, 20 Sep 2019 10:21:02 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iBJmM-0006b5-Tj; Fri, 20 Sep 2019 17:20:58 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v13 05/15] block/backup: introduce BlockCopyState
Date: Fri, 20 Sep 2019 17:20:46 +0300
Message-Id: <20190920142056.12778-6-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142056.12778-1-vsementsov@virtuozzo.com>
References: <20190920142056.12778-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, jsnow@redhat.com, stefanha@redhat.com, den@openvz.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split copying code part from backup to "block-copy", including separate
state structure and function renaming. This is needed to share it with
backup-top filter driver in further commits.

Notes:

1. As BlockCopyState keeps own BlockBackend objects, remaining
job->common.blk users only use it to get bs by blk_bs() call, so clear
job->commen.blk permissions set in block_job_create and add
job->source_bs to be used instead of blk_bs(job->common.blk), to keep
it more clear which bs we use when introduce backup-top filter in
further commit.

2. Rename s/initializing_bitmap/skip_unallocated/ to sound a bit better
as interface to BlockCopyState

3. Split is not very clean: there left some duplicated fields, backup
code uses some BlockCopyState fields directly, let's postpone it for
further improvements and keep this comment simpler for review.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c     | 370 ++++++++++++++++++++++++++++-----------------
 block/trace-events |  12 +-
 2 files changed, 239 insertions(+), 143 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index ae28849660..5dda1673ca 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -35,12 +35,52 @@ typedef struct CowRequest {
     CoQueue wait_queue; /* coroutines blocked on this request */
 } CowRequest;
 
+typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
+typedef void (*ProgressResetCallbackFunc)(void *opaque);
+typedef struct BlockCopyState {
+    BlockBackend *source;
+    BlockBackend *target;
+    BdrvDirtyBitmap *copy_bitmap;
+    int64_t cluster_size;
+    bool use_copy_range;
+    int64_t copy_range_size;
+    uint64_t len;
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
+} BlockCopyState;
+
 typedef struct BackupBlockJob {
     BlockJob common;
-    BlockBackend *target;
+    BlockDriverState *source_bs;
 
     BdrvDirtyBitmap *sync_bitmap;
-    BdrvDirtyBitmap *copy_bitmap;
 
     MirrorSyncMode sync_mode;
     BitmapSyncMode bitmap_mode;
@@ -53,11 +93,7 @@ typedef struct BackupBlockJob {
     NotifierWithReturn before_write;
     QLIST_HEAD(, CowRequest) inflight_reqs;
 
-    bool use_copy_range;
-    int64_t copy_range_size;
-
-    BdrvRequestFlags write_flags;
-    bool initializing_bitmap;
+    BlockCopyState *bcs;
 } BackupBlockJob;
 
 static const BlockJobDriver backup_job_driver;
@@ -99,9 +135,97 @@ static void cow_request_end(CowRequest *req)
     qemu_co_queue_restart_all(&req->wait_queue);
 }
 
+static void block_copy_state_free(BlockCopyState *s)
+{
+    if (!s) {
+        return;
+    }
+
+    bdrv_release_dirty_bitmap(blk_bs(s->source), s->copy_bitmap);
+    blk_unref(s->source);
+    blk_unref(s->target);
+    g_free(s);
+}
+
+static BlockCopyState *block_copy_state_new(
+        BlockDriverState *source, BlockDriverState *target,
+        int64_t cluster_size, BdrvRequestFlags write_flags,
+        ProgressBytesCallbackFunc progress_bytes_callback,
+        ProgressResetCallbackFunc progress_reset_callback,
+        void *progress_opaque, Error **errp)
+{
+    BlockCopyState *s;
+    int ret;
+    uint64_t no_resize = BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
+                         BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD;
+    BdrvDirtyBitmap *copy_bitmap;
+
+    copy_bitmap = bdrv_create_dirty_bitmap(source, cluster_size, NULL, errp);
+    if (!copy_bitmap) {
+        return NULL;
+    }
+    bdrv_disable_dirty_bitmap(copy_bitmap);
+
+    s = g_new(BlockCopyState, 1);
+    *s = (BlockCopyState) {
+        .source = blk_new(bdrv_get_aio_context(source),
+                          BLK_PERM_CONSISTENT_READ, no_resize),
+        .target = blk_new(bdrv_get_aio_context(target),
+                          BLK_PERM_WRITE, no_resize),
+        .copy_bitmap = copy_bitmap,
+        .cluster_size = cluster_size,
+        .len = bdrv_dirty_bitmap_size(copy_bitmap),
+        .write_flags = write_flags,
+        .progress_bytes_callback = progress_bytes_callback,
+        .progress_reset_callback = progress_reset_callback,
+        .progress_opaque = progress_opaque,
+    };
+
+    s->copy_range_size = QEMU_ALIGN_DOWN(MIN(blk_get_max_transfer(s->source),
+                                             blk_get_max_transfer(s->target)),
+                                         s->cluster_size);
+    /*
+     * Set use_copy_range, consider the following:
+     * 1. Compression is not supported for copy_range.
+     * 2. copy_range does not respect max_transfer (it's a TODO), so we factor
+     *    that in here. If max_transfer is smaller than the job->cluster_size,
+     *    we do not use copy_range (in that case it's zero after aligning down
+     *    above).
+     */
+    s->use_copy_range =
+        !(write_flags & BDRV_REQ_WRITE_COMPRESSED) && s->copy_range_size > 0;
+
+    /*
+     * We just allow aio context change on our block backends. block_copy() user
+     * (now it's only backup) is responsible for source and target being in same
+     * aio context.
+     */
+    blk_set_disable_request_queuing(s->source, true);
+    blk_set_allow_aio_context_change(s->source, true);
+    blk_set_disable_request_queuing(s->target, true);
+    blk_set_allow_aio_context_change(s->target, true);
+
+    ret = blk_insert_bs(s->source, source, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    ret = blk_insert_bs(s->target, target, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    return s;
+
+fail:
+    block_copy_state_free(s);
+
+    return NULL;
+}
+
 /* Copy range to target with a bounce buffer and return the bytes copied. If
  * error occurred, return a negative error number */
-static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
+static int coroutine_fn block_copy_with_bounce_buffer(BlockCopyState *s,
                                                       int64_t start,
                                                       int64_t end,
                                                       bool is_write_notifier,
@@ -109,30 +233,29 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
                                                       void **bounce_buffer)
 {
     int ret;
-    BlockBackend *blk = job->common.blk;
     int nbytes;
     int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
 
-    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
-    bdrv_reset_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
-    nbytes = MIN(job->cluster_size, job->len - start);
+    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
+    bdrv_reset_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
+    nbytes = MIN(s->cluster_size, s->len - start);
     if (!*bounce_buffer) {
-        *bounce_buffer = blk_blockalign(blk, job->cluster_size);
+        *bounce_buffer = blk_blockalign(s->source, s->cluster_size);
     }
 
-    ret = blk_co_pread(blk, start, nbytes, *bounce_buffer, read_flags);
+    ret = blk_co_pread(s->source, start, nbytes, *bounce_buffer, read_flags);
     if (ret < 0) {
-        trace_backup_do_cow_read_fail(job, start, ret);
+        trace_block_copy_with_bounce_buffer_read_fail(s, start, ret);
         if (error_is_read) {
             *error_is_read = true;
         }
         goto fail;
     }
 
-    ret = blk_co_pwrite(job->target, start, nbytes, *bounce_buffer,
-                        job->write_flags);
+    ret = blk_co_pwrite(s->target, start, nbytes, *bounce_buffer,
+                        s->write_flags);
     if (ret < 0) {
-        trace_backup_do_cow_write_fail(job, start, ret);
+        trace_block_copy_with_bounce_buffer_write_fail(s, start, ret);
         if (error_is_read) {
             *error_is_read = false;
         }
@@ -141,36 +264,35 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
 
     return nbytes;
 fail:
-    bdrv_set_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
+    bdrv_set_dirty_bitmap(s->copy_bitmap, start, s->cluster_size);
     return ret;
 
 }
 
 /* Copy range to target and return the bytes copied. If error occurred, return a
  * negative error number. */
-static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
+static int coroutine_fn block_copy_with_offload(BlockCopyState *s,
                                                 int64_t start,
                                                 int64_t end,
                                                 bool is_write_notifier)
 {
     int ret;
     int nr_clusters;
-    BlockBackend *blk = job->common.blk;
     int nbytes;
     int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
 
-    assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
-    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
-    nbytes = MIN(job->copy_range_size, MIN(end, job->len) - start);
-    nr_clusters = DIV_ROUND_UP(nbytes, job->cluster_size);
-    bdrv_reset_dirty_bitmap(job->copy_bitmap, start,
-                            job->cluster_size * nr_clusters);
-    ret = blk_co_copy_range(blk, start, job->target, start, nbytes,
-                            read_flags, job->write_flags);
+    assert(QEMU_IS_ALIGNED(s->copy_range_size, s->cluster_size));
+    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
+    nbytes = MIN(s->copy_range_size, MIN(end, s->len) - start);
+    nr_clusters = DIV_ROUND_UP(nbytes, s->cluster_size);
+    bdrv_reset_dirty_bitmap(s->copy_bitmap, start,
+                            s->cluster_size * nr_clusters);
+    ret = blk_co_copy_range(s->source, start, s->target, start, nbytes,
+                            read_flags, s->write_flags);
     if (ret < 0) {
-        trace_backup_do_cow_copy_range_fail(job, start, ret);
-        bdrv_set_dirty_bitmap(job->copy_bitmap, start,
-                              job->cluster_size * nr_clusters);
+        trace_block_copy_with_offload_fail(s, start, ret);
+        bdrv_set_dirty_bitmap(s->copy_bitmap, start,
+                              s->cluster_size * nr_clusters);
         return ret;
     }
 
@@ -181,10 +303,10 @@ static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
  * Check if the cluster starting at offset is allocated or not.
  * return via pnum the number of contiguous clusters sharing this allocation.
  */
-static int backup_is_cluster_allocated(BackupBlockJob *s, int64_t offset,
-                                       int64_t *pnum)
+static int block_copy_is_cluster_allocated(BlockCopyState *s, int64_t offset,
+                                           int64_t *pnum)
 {
-    BlockDriverState *bs = blk_bs(s->common.blk);
+    BlockDriverState *bs = blk_bs(s->source);
     int64_t count, total_count = 0;
     int64_t bytes = s->len - offset;
     int ret;
@@ -225,13 +347,13 @@ static int backup_is_cluster_allocated(BackupBlockJob *s, int64_t offset,
  * @return 0 when the cluster at @offset was unallocated,
  *         1 otherwise, and -ret on error.
  */
-static int64_t backup_bitmap_reset_unallocated(BackupBlockJob *s,
-                                               int64_t offset, int64_t *count)
+static int64_t block_copy_reset_unallocated(BlockCopyState *s,
+                                            int64_t offset, int64_t *count)
 {
     int ret;
-    int64_t clusters, bytes, estimate;
+    int64_t clusters, bytes;
 
-    ret = backup_is_cluster_allocated(s, offset, &clusters);
+    ret = block_copy_is_cluster_allocated(s, offset, &clusters);
     if (ret < 0) {
         return ret;
     }
@@ -240,46 +362,51 @@ static int64_t backup_bitmap_reset_unallocated(BackupBlockJob *s,
 
     if (!ret) {
         bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
-        estimate = bdrv_get_dirty_count(s->copy_bitmap);
-        job_progress_set_remaining(&s->common.job, estimate);
+        s->progress_reset_callback(s->progress_opaque);
     }
 
     *count = bytes;
     return ret;
 }
 
-static int coroutine_fn backup_do_copy(BackupBlockJob *job,
-                                       int64_t start, uint64_t bytes,
-                                       bool *error_is_read,
-                                       bool is_write_notifier)
+static int coroutine_fn block_copy(BlockCopyState *s,
+                                   int64_t start, uint64_t bytes,
+                                   bool *error_is_read,
+                                   bool is_write_notifier)
 {
     int ret = 0;
     int64_t end = bytes + start; /* bytes */
     void *bounce_buffer = NULL;
     int64_t status_bytes;
 
-    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
-    assert(QEMU_IS_ALIGNED(end, job->cluster_size));
+    /*
+     * block_copy() user is responsible for keeping source and target in same
+     * aio context
+     */
+    assert(blk_get_aio_context(s->source) == blk_get_aio_context(s->target));
+
+    assert(QEMU_IS_ALIGNED(start, s->cluster_size));
+    assert(QEMU_IS_ALIGNED(end, s->cluster_size));
 
     while (start < end) {
         int64_t dirty_end;
 
-        if (!bdrv_dirty_bitmap_get(job->copy_bitmap, start)) {
-            trace_backup_do_cow_skip(job, start);
-            start += job->cluster_size;
+        if (!bdrv_dirty_bitmap_get(s->copy_bitmap, start)) {
+            trace_block_copy_skip(s, start);
+            start += s->cluster_size;
             continue; /* already copied */
         }
 
-        dirty_end = bdrv_dirty_bitmap_next_zero(job->copy_bitmap, start,
+        dirty_end = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, start,
                                                 (end - start));
         if (dirty_end < 0) {
             dirty_end = end;
         }
 
-        if (job->initializing_bitmap) {
-            ret = backup_bitmap_reset_unallocated(job, start, &status_bytes);
+        if (s->skip_unallocated) {
+            ret = block_copy_reset_unallocated(s, start, &status_bytes);
             if (ret == 0) {
-                trace_backup_do_cow_skip_range(job, start, status_bytes);
+                trace_block_copy_skip_range(s, start, status_bytes);
                 start += status_bytes;
                 continue;
             }
@@ -287,17 +414,17 @@ static int coroutine_fn backup_do_copy(BackupBlockJob *job,
             dirty_end = MIN(dirty_end, start + status_bytes);
         }
 
-        trace_backup_do_cow_process(job, start);
+        trace_block_copy_process(s, start);
 
-        if (job->use_copy_range) {
-            ret = backup_cow_with_offload(job, start, dirty_end,
+        if (s->use_copy_range) {
+            ret = block_copy_with_offload(s, start, dirty_end,
                                           is_write_notifier);
             if (ret < 0) {
-                job->use_copy_range = false;
+                s->use_copy_range = false;
             }
         }
-        if (!job->use_copy_range) {
-            ret = backup_cow_with_bounce_buffer(job, start, dirty_end,
+        if (!s->use_copy_range) {
+            ret = block_copy_with_bounce_buffer(s, start, dirty_end,
                                                 is_write_notifier,
                                                 error_is_read, &bounce_buffer);
         }
@@ -305,12 +432,8 @@ static int coroutine_fn backup_do_copy(BackupBlockJob *job,
             break;
         }
 
-        /* Publish progress, guest I/O counts as progress too.  Note that the
-         * offset field is an opaque progress value, it is not a disk offset.
-         */
         start += ret;
-        job->bytes_read += ret;
-        job_progress_update(&job->common.job, ret);
+        s->progress_bytes_callback(ret, s->progress_opaque);
         ret = 0;
     }
 
@@ -321,6 +444,22 @@ static int coroutine_fn backup_do_copy(BackupBlockJob *job,
     return ret;
 }
 
+static void backup_progress_bytes_callback(int64_t bytes, void *opaque)
+{
+    BackupBlockJob *s = opaque;
+
+    s->bytes_read += bytes;
+    job_progress_update(&s->common.job, bytes);
+}
+
+static void backup_progress_reset_callback(void *opaque)
+{
+    BackupBlockJob *s = opaque;
+    uint64_t estimate = bdrv_get_dirty_count(s->bcs->copy_bitmap);
+
+    job_progress_set_remaining(&s->common.job, estimate);
+}
+
 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
                                       int64_t offset, uint64_t bytes,
                                       bool *error_is_read,
@@ -340,8 +479,8 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     wait_for_overlapping_requests(job, start, end);
     cow_request_begin(&cow_request, job, start, end);
 
-    ret = backup_do_copy(job, start, end - start, error_is_read,
-                         is_write_notifier);
+    ret = block_copy(job->bcs, start, end - start, error_is_read,
+                     is_write_notifier);
 
     cow_request_end(&cow_request);
 
@@ -359,7 +498,7 @@ static int coroutine_fn backup_before_write_notify(
     BackupBlockJob *job = container_of(notifier, BackupBlockJob, before_write);
     BdrvTrackedRequest *req = opaque;
 
-    assert(req->bs == blk_bs(job->common.blk));
+    assert(req->bs == job->source_bs);
     assert(QEMU_IS_ALIGNED(req->offset, BDRV_SECTOR_SIZE));
     assert(QEMU_IS_ALIGNED(req->bytes, BDRV_SECTOR_SIZE));
 
@@ -369,7 +508,6 @@ static int coroutine_fn backup_before_write_notify(
 static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
 {
     BdrvDirtyBitmap *bm;
-    BlockDriverState *bs = blk_bs(job->common.blk);
     bool sync = (((ret == 0) || (job->bitmap_mode == BITMAP_SYNC_MODE_ALWAYS)) \
                  && (job->bitmap_mode != BITMAP_SYNC_MODE_NEVER));
 
@@ -378,20 +516,20 @@ static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
          * We succeeded, or we always intended to sync the bitmap.
          * Delete this bitmap and install the child.
          */
-        bm = bdrv_dirty_bitmap_abdicate(bs, job->sync_bitmap, NULL);
+        bm = bdrv_dirty_bitmap_abdicate(job->source_bs, job->sync_bitmap, NULL);
     } else {
         /*
          * We failed, or we never intended to sync the bitmap anyway.
          * Merge the successor back into the parent, keeping all data.
          */
-        bm = bdrv_reclaim_dirty_bitmap(bs, job->sync_bitmap, NULL);
+        bm = bdrv_reclaim_dirty_bitmap(job->source_bs, job->sync_bitmap, NULL);
     }
 
     assert(bm);
 
     if (ret < 0 && job->bitmap_mode == BITMAP_SYNC_MODE_ALWAYS) {
         /* If we failed and synced, merge in the bits we didn't copy: */
-        bdrv_dirty_bitmap_merge_internal(bm, job->copy_bitmap,
+        bdrv_dirty_bitmap_merge_internal(bm, job->bcs->copy_bitmap,
                                          NULL, true);
     }
 }
@@ -415,16 +553,8 @@ static void backup_abort(Job *job)
 static void backup_clean(Job *job)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
-    BlockDriverState *bs = blk_bs(s->common.blk);
 
-    if (s->copy_bitmap) {
-        bdrv_release_dirty_bitmap(bs, s->copy_bitmap);
-        s->copy_bitmap = NULL;
-    }
-
-    assert(s->target);
-    blk_unref(s->target);
-    s->target = NULL;
+    block_copy_state_free(s->bcs);
 }
 
 void backup_do_checkpoint(BlockJob *job, Error **errp)
@@ -439,7 +569,7 @@ void backup_do_checkpoint(BlockJob *job, Error **errp)
         return;
     }
 
-    bdrv_set_dirty_bitmap(backup_job->copy_bitmap, 0, backup_job->len);
+    bdrv_set_dirty_bitmap(backup_job->bcs->copy_bitmap, 0, backup_job->len);
 }
 
 static BlockErrorAction backup_error_action(BackupBlockJob *job,
@@ -482,7 +612,7 @@ static int coroutine_fn backup_loop(BackupBlockJob *job)
     BdrvDirtyBitmapIter *bdbi;
     int ret = 0;
 
-    bdbi = bdrv_dirty_iter_new(job->copy_bitmap);
+    bdbi = bdrv_dirty_iter_new(job->bcs->copy_bitmap);
     while ((offset = bdrv_dirty_iter_next(bdbi)) != -1) {
         do {
             if (yield_and_check(job)) {
@@ -509,7 +639,7 @@ static void backup_init_copy_bitmap(BackupBlockJob *job)
     uint64_t estimate;
 
     if (job->sync_mode == MIRROR_SYNC_MODE_BITMAP) {
-        ret = bdrv_dirty_bitmap_merge_internal(job->copy_bitmap,
+        ret = bdrv_dirty_bitmap_merge_internal(job->bcs->copy_bitmap,
                                                job->sync_bitmap,
                                                NULL, true);
         assert(ret);
@@ -519,19 +649,18 @@ static void backup_init_copy_bitmap(BackupBlockJob *job)
              * We can't hog the coroutine to initialize this thoroughly.
              * Set a flag and resume work when we are able to yield safely.
              */
-            job->initializing_bitmap = true;
+            job->bcs->skip_unallocated = true;
         }
-        bdrv_set_dirty_bitmap(job->copy_bitmap, 0, job->len);
+        bdrv_set_dirty_bitmap(job->bcs->copy_bitmap, 0, job->len);
     }
 
-    estimate = bdrv_get_dirty_count(job->copy_bitmap);
+    estimate = bdrv_get_dirty_count(job->bcs->copy_bitmap);
     job_progress_set_remaining(&job->common.job, estimate);
 }
 
 static int coroutine_fn backup_run(Job *job, Error **errp)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
-    BlockDriverState *bs = blk_bs(s->common.blk);
     int ret = 0;
 
     QLIST_INIT(&s->inflight_reqs);
@@ -540,7 +669,7 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
     backup_init_copy_bitmap(s);
 
     s->before_write.notify = backup_before_write_notify;
-    bdrv_add_before_write_notifier(bs, &s->before_write);
+    bdrv_add_before_write_notifier(s->source_bs, &s->before_write);
 
     if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
         int64_t offset = 0;
@@ -552,14 +681,14 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
                 goto out;
             }
 
-            ret = backup_bitmap_reset_unallocated(s, offset, &count);
+            ret = block_copy_reset_unallocated(s->bcs, offset, &count);
             if (ret < 0) {
                 goto out;
             }
 
             offset += count;
         }
-        s->initializing_bitmap = false;
+        s->bcs->skip_unallocated = false;
     }
 
     if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
@@ -646,9 +775,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
 {
     int64_t len;
     BackupBlockJob *job = NULL;
-    int ret;
     int64_t cluster_size;
-    BdrvDirtyBitmap *copy_bitmap = NULL;
+    BdrvRequestFlags write_flags;
 
     assert(bs);
     assert(target);
@@ -713,33 +841,14 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         goto error;
     }
 
-    copy_bitmap = bdrv_create_dirty_bitmap(bs, cluster_size, NULL, errp);
-    if (!copy_bitmap) {
-        goto error;
-    }
-    bdrv_disable_dirty_bitmap(copy_bitmap);
-
     /* job->len is fixed, so we can't allow resize */
-    job = block_job_create(job_id, &backup_job_driver, txn, bs,
-                           BLK_PERM_CONSISTENT_READ,
-                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
-                           BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD,
+    job = block_job_create(job_id, &backup_job_driver, txn, bs, 0, BLK_PERM_ALL,
                            speed, creation_flags, cb, opaque, errp);
     if (!job) {
         goto error;
     }
 
-    /* The target must match the source in size, so no resize here either */
-    job->target = blk_new(job->common.job.aio_context,
-                          BLK_PERM_WRITE,
-                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
-                          BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD);
-    ret = blk_insert_bs(job->target, target, errp);
-    if (ret < 0) {
-        goto error;
-    }
-    blk_set_disable_request_queuing(job->target, true);
-
+    job->source_bs = bs;
     job->on_source_error = on_source_error;
     job->on_target_error = on_target_error;
     job->sync_mode = sync_mode;
@@ -760,28 +869,19 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
      * For more information see commit f8d59dfb40bb and test
      * tests/qemu-iotests/222
      */
-    job->write_flags =
-        (bdrv_chain_contains(target, bs) ? BDRV_REQ_SERIALISING : 0) |
-        (compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
+    write_flags = (bdrv_chain_contains(target, bs) ? BDRV_REQ_SERIALISING : 0) |
+                  (compress ? BDRV_REQ_WRITE_COMPRESSED : 0),
+
+    job->bcs = block_copy_state_new(bs, target, cluster_size, write_flags,
+                                    backup_progress_bytes_callback,
+                                    backup_progress_reset_callback, job, errp);
+    if (!job->bcs) {
+        goto error;
+    }
 
     job->cluster_size = cluster_size;
-    job->copy_bitmap = copy_bitmap;
-    copy_bitmap = NULL;
-    job->copy_range_size = MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
-                                        blk_get_max_transfer(job->target));
-    job->copy_range_size = QEMU_ALIGN_DOWN(job->copy_range_size,
-                                           job->cluster_size);
-    /*
-     * Set use_copy_range, consider the following:
-     * 1. Compression is not supported for copy_range.
-     * 2. copy_range does not respect max_transfer (it's a TODO), so we factor
-     *    that in here. If max_transfer is smaller than the job->cluster_size,
-     *    we do not use copy_range (in that case it's zero after aligning down
-     *    above).
-     */
-    job->use_copy_range = !compress && job->copy_range_size > 0;
 
-    /* Required permissions are already taken with target's blk_new() */
+    /* Required permissions are already taken by block-copy-state target */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
     job->len = len;
@@ -789,10 +889,6 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     return &job->common;
 
  error:
-    if (copy_bitmap) {
-        assert(!job || !job->copy_bitmap);
-        bdrv_release_dirty_bitmap(bs, copy_bitmap);
-    }
     if (sync_bitmap) {
         bdrv_reclaim_dirty_bitmap(bs, sync_bitmap, NULL);
     }
diff --git a/block/trace-events b/block/trace-events
index 04209f058d..6e7532f48b 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -40,12 +40,12 @@ mirror_yield_in_flight(void *s, int64_t offset, int in_flight) "s %p offset %" P
 # backup.c
 backup_do_cow_enter(void *job, int64_t start, int64_t offset, uint64_t bytes) "job %p start %" PRId64 " offset %" PRId64 " bytes %" PRIu64
 backup_do_cow_return(void *job, int64_t offset, uint64_t bytes, int ret) "job %p offset %" PRId64 " bytes %" PRIu64 " ret %d"
-backup_do_cow_skip(void *job, int64_t start) "job %p start %"PRId64
-backup_do_cow_skip_range(void *job, int64_t start, uint64_t bytes) "job %p start %"PRId64" bytes %"PRId64
-backup_do_cow_process(void *job, int64_t start) "job %p start %"PRId64
-backup_do_cow_read_fail(void *job, int64_t start, int ret) "job %p start %"PRId64" ret %d"
-backup_do_cow_write_fail(void *job, int64_t start, int ret) "job %p start %"PRId64" ret %d"
-backup_do_cow_copy_range_fail(void *job, int64_t start, int ret) "job %p start %"PRId64" ret %d"
+block_copy_skip(void *bcs, int64_t start) "bcs %p start %"PRId64
+block_copy_skip_range(void *bcs, int64_t start, uint64_t bytes) "bcs %p start %"PRId64" bytes %"PRId64
+block_copy_process(void *bcs, int64_t start) "bcs %p start %"PRId64
+block_copy_with_bounce_buffer_read_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PRId64" ret %d"
+block_copy_with_bounce_buffer_write_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PRId64" ret %d"
+block_copy_with_offload_fail(void *bcs, int64_t start, int ret) "bcs %p start %"PRId64" ret %d"
 
 # ../blockdev.c
 qmp_block_job_cancel(void *job) "job %p"
-- 
2.21.0


