Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64126C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B269208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B269208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jByij-0004M1-F0
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 06:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBydC-0002zs-K9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jBydB-0001Zp-0c
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:30:30 -0400
Received: from relay.sw.ru ([185.231.240.75]:33074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jByd3-0001Ro-Hu; Wed, 11 Mar 2020 06:30:21 -0400
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1jBycx-0005cJ-TW; Wed, 11 Mar 2020 13:30:16 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 2/9] block/block-copy: fix progress calculation
Date: Wed, 11 Mar 2020 13:29:57 +0300
Message-Id: <20200311103004.7649-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200311103004.7649-1-vsementsov@virtuozzo.com>
References: <20200311103004.7649-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, andrey.shinkevich@virtuozzo.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Assume we have two regions, A and B, and region B is in-flight now,
region A is not yet touched, but it is unallocated and should be
skipped.

Correspondingly, as progress we have

  total = A + B
  current = 0

If we reset unallocated region A and call progress_reset_callback,
it will calculate 0 bytes dirty in the bitmap and call
job_progress_set_remaining, which will set

   total = current + 0 = 0 + 0 = 0

So, B bytes are actually removed from total accounting. When job
finishes we'll have

   total = 0
   current = B

, which doesn't sound good.

This is because we didn't considered in-flight bytes, actually when
calculating remaining, we should have set (in_flight + dirty_bytes)
as remaining, not only dirty_bytes.

To fix it, let's refactor progress calculation, moving it to block-copy
itself instead of fixing callback. And, of course, track in_flight
bytes count.

We still have to keep one callback, to maintain backup job bytes_read
calculation, but it will go on soon, when we turn the whole backup
process into one block_copy call.

Cc: qemu-stable@nongnu.org
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 include/block/block-copy.h | 15 +++++----------
 block/backup.c             | 13 ++-----------
 block/block-copy.c         | 16 ++++++++++++----
 3 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 0a161724d7..9def00068c 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -26,7 +26,6 @@ typedef struct BlockCopyInFlightReq {
 } BlockCopyInFlightReq;
 
 typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
-typedef void (*ProgressResetCallbackFunc)(void *opaque);
 typedef struct BlockCopyState {
     /*
      * BdrvChild objects are not owned or managed by block-copy. They are
@@ -36,6 +35,7 @@ typedef struct BlockCopyState {
     BdrvChild *source;
     BdrvChild *target;
     BdrvDirtyBitmap *copy_bitmap;
+    int64_t in_flight_bytes;
     int64_t cluster_size;
     bool use_copy_range;
     int64_t copy_size;
@@ -60,15 +60,9 @@ typedef struct BlockCopyState {
      */
     bool skip_unallocated;
 
+    ProgressMeter *progress;
     /* progress_bytes_callback: called when some copying progress is done. */
     ProgressBytesCallbackFunc progress_bytes_callback;
-
-    /*
-     * progress_reset_callback: called when some bytes reset from copy_bitmap
-     * (see @skip_unallocated above). The callee is assumed to recalculate how
-     * many bytes remain based on the dirty bit count of copy_bitmap.
-     */
-    ProgressResetCallbackFunc progress_reset_callback;
     void *progress_opaque;
 
     SharedResource *mem;
@@ -79,12 +73,13 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      BdrvRequestFlags write_flags,
                                      Error **errp);
 
-void block_copy_set_callbacks(
+void block_copy_set_progress_callback(
         BlockCopyState *s,
         ProgressBytesCallbackFunc progress_bytes_callback,
-        ProgressResetCallbackFunc progress_reset_callback,
         void *progress_opaque);
 
+void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm);
+
 void block_copy_state_free(BlockCopyState *s);
 
 int64_t block_copy_reset_unallocated(BlockCopyState *s,
diff --git a/block/backup.c b/block/backup.c
index 1383e219f5..8694e0394b 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -57,15 +57,6 @@ static void backup_progress_bytes_callback(int64_t bytes, void *opaque)
     BackupBlockJob *s = opaque;
 
     s->bytes_read += bytes;
-    job_progress_update(&s->common.job, bytes);
-}
-
-static void backup_progress_reset_callback(void *opaque)
-{
-    BackupBlockJob *s = opaque;
-    uint64_t estimate = bdrv_get_dirty_count(s->bcs->copy_bitmap);
-
-    job_progress_set_remaining(&s->common.job, estimate);
 }
 
 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
@@ -464,8 +455,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     job->cluster_size = cluster_size;
     job->len = len;
 
-    block_copy_set_callbacks(bcs, backup_progress_bytes_callback,
-                             backup_progress_reset_callback, job);
+    block_copy_set_progress_callback(bcs, backup_progress_bytes_callback, job);
+    block_copy_set_progress_meter(bcs, &job->common.job.progress);
 
     /* Required permissions are already taken by backup-top target */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
diff --git a/block/block-copy.c b/block/block-copy.c
index 79798a1567..e2d7b3b887 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -127,17 +127,20 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
     return s;
 }
 
-void block_copy_set_callbacks(
+void block_copy_set_progress_callback(
         BlockCopyState *s,
         ProgressBytesCallbackFunc progress_bytes_callback,
-        ProgressResetCallbackFunc progress_reset_callback,
         void *progress_opaque)
 {
     s->progress_bytes_callback = progress_bytes_callback;
-    s->progress_reset_callback = progress_reset_callback;
     s->progress_opaque = progress_opaque;
 }
 
+void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm)
+{
+    s->progress = pm;
+}
+
 /*
  * block_copy_do_copy
  *
@@ -269,7 +272,9 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
 
     if (!ret) {
         bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
-        s->progress_reset_callback(s->progress_opaque);
+        progress_set_remaining(s->progress,
+                               bdrv_get_dirty_count(s->copy_bitmap) +
+                               s->in_flight_bytes);
     }
 
     *count = bytes;
@@ -331,15 +336,18 @@ int coroutine_fn block_copy(BlockCopyState *s,
         trace_block_copy_process(s, start);
 
         bdrv_reset_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
+        s->in_flight_bytes += chunk_end - start;
 
         co_get_from_shres(s->mem, chunk_end - start);
         ret = block_copy_do_copy(s, start, chunk_end, error_is_read);
         co_put_to_shres(s->mem, chunk_end - start);
+        s->in_flight_bytes -= chunk_end - start;
         if (ret < 0) {
             bdrv_set_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
             break;
         }
 
+        progress_work_done(s->progress, chunk_end - start);
         s->progress_bytes_callback(chunk_end - start, s->progress_opaque);
         start = chunk_end;
         ret = 0;
-- 
2.21.0


