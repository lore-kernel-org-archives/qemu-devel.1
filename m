Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D37C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F35B320684
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35B320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51307 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG309-0000Vv-8Q
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 10:54:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hG2vo-0005Ug-VJ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hG2vk-0005S1-13
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:50:00 -0400
Received: from relay.sw.ru ([185.231.240.75]:48870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hG2vh-0005QI-0Z; Mon, 15 Apr 2019 10:49:54 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hG2ve-0002By-A1; Mon, 15 Apr 2019 17:49:50 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon, 15 Apr 2019 17:49:45 +0300
Message-Id: <20190415144948.78568-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190415144948.78568-1-vsementsov@virtuozzo.com>
References: <20190415144948.78568-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v6 2/5] block/backup: move to copy_bitmap with
 granularity
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
	jsnow@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415144945.PEjTN-cp57393UmTYThH0mff2gVCEPmzVYsfXmCz_fw@z>

We are going to share this bitmap between backup and backup-top filter
driver, so let's share something more meaningful. It also simplifies
some calculations.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index d9f5db18ac..510fc54f98 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -113,7 +113,8 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
     int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
     int write_flags = job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0;
 
-    hbitmap_reset(job->copy_bitmap, start / job->cluster_size, 1);
+    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
+    hbitmap_reset(job->copy_bitmap, start, job->cluster_size);
     nbytes = MIN(job->cluster_size, job->len - start);
     if (!*bounce_buffer) {
         *bounce_buffer = blk_blockalign(blk, job->cluster_size);
@@ -147,7 +148,7 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
 
     return nbytes;
 fail:
-    hbitmap_set(job->copy_bitmap, start / job->cluster_size, 1);
+    hbitmap_set(job->copy_bitmap, start, job->cluster_size);
     return ret;
 
 }
@@ -167,16 +168,15 @@ static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
     int write_flags = job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0;
 
     assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
+    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
     nbytes = MIN(job->copy_range_size, end - start);
     nr_clusters = DIV_ROUND_UP(nbytes, job->cluster_size);
-    hbitmap_reset(job->copy_bitmap, start / job->cluster_size,
-                  nr_clusters);
+    hbitmap_reset(job->copy_bitmap, start, job->cluster_size * nr_clusters);
     ret = blk_co_copy_range(blk, start, job->target, start, nbytes,
                             read_flags, write_flags);
     if (ret < 0) {
         trace_backup_do_cow_copy_range_fail(job, start, ret);
-        hbitmap_set(job->copy_bitmap, start / job->cluster_size,
-                    nr_clusters);
+        hbitmap_set(job->copy_bitmap, start, job->cluster_size * nr_clusters);
         return ret;
     }
 
@@ -204,7 +204,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     cow_request_begin(&cow_request, job, start, end);
 
     while (start < end) {
-        if (!hbitmap_get(job->copy_bitmap, start / job->cluster_size)) {
+        if (!hbitmap_get(job->copy_bitmap, start)) {
             trace_backup_do_cow_skip(job, start);
             start += job->cluster_size;
             continue; /* already copied */
@@ -300,6 +300,11 @@ static void backup_clean(Job *job)
     assert(s->target);
     blk_unref(s->target);
     s->target = NULL;
+
+    if (s->copy_bitmap) {
+        hbitmap_free(s->copy_bitmap);
+        s->copy_bitmap = NULL;
+    }
 }
 
 static void backup_attached_aio_context(BlockJob *job, AioContext *aio_context)
@@ -312,7 +317,6 @@ static void backup_attached_aio_context(BlockJob *job, AioContext *aio_context)
 void backup_do_checkpoint(BlockJob *job, Error **errp)
 {
     BackupBlockJob *backup_job = container_of(job, BackupBlockJob, common);
-    int64_t len;
 
     assert(block_job_driver(job) == &backup_job_driver);
 
@@ -322,8 +326,7 @@ void backup_do_checkpoint(BlockJob *job, Error **errp)
         return;
     }
 
-    len = DIV_ROUND_UP(backup_job->len, backup_job->cluster_size);
-    hbitmap_set(backup_job->copy_bitmap, 0, len);
+    hbitmap_set(backup_job->copy_bitmap, 0, backup_job->len);
 }
 
 static void backup_drain(BlockJob *job)
@@ -378,16 +381,16 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
 {
     int ret;
     bool error_is_read;
-    int64_t cluster;
+    int64_t offset;
     HBitmapIter hbi;
 
     hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
-    while ((cluster = hbitmap_iter_next(&hbi)) != -1) {
+    while ((offset = hbitmap_iter_next(&hbi)) != -1) {
         do {
             if (yield_and_check(job)) {
                 return 0;
             }
-            ret = backup_do_cow(job, cluster * job->cluster_size,
+            ret = backup_do_cow(job, offset,
                                 job->cluster_size, &error_is_read, false);
             if (ret < 0 && backup_error_action(job, error_is_read, -ret) ==
                            BLOCK_ERROR_ACTION_REPORT)
@@ -409,12 +412,9 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
     while (bdrv_dirty_bitmap_next_dirty_area(job->sync_bitmap,
                                              &offset, &bytes))
     {
-        uint64_t cluster = offset / job->cluster_size;
-        uint64_t end_cluster = DIV_ROUND_UP(offset + bytes, job->cluster_size);
+        hbitmap_set(job->copy_bitmap, offset, bytes);
 
-        hbitmap_set(job->copy_bitmap, cluster, end_cluster - cluster);
-
-        offset = end_cluster * job->cluster_size;
+        offset += bytes;
         if (offset >= job->len) {
             break;
         }
@@ -423,30 +423,27 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
 
     /* TODO job_progress_set_remaining() would make more sense */
     job_progress_update(&job->common.job,
-        job->len - hbitmap_count(job->copy_bitmap) * job->cluster_size);
+        job->len - hbitmap_count(job->copy_bitmap));
 }
 
 static int coroutine_fn backup_run(Job *job, Error **errp)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
     BlockDriverState *bs = blk_bs(s->common.blk);
-    int64_t offset, nb_clusters;
+    int64_t offset;
     int ret = 0;
 
     QLIST_INIT(&s->inflight_reqs);
     qemu_co_rwlock_init(&s->flush_rwlock);
 
-    nb_clusters = DIV_ROUND_UP(s->len, s->cluster_size);
     job_progress_set_remaining(job, s->len);
 
-    s->copy_bitmap = hbitmap_alloc(nb_clusters, 0);
     if (s->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
         backup_incremental_init_copy_bitmap(s);
     } else {
-        hbitmap_set(s->copy_bitmap, 0, nb_clusters);
+        hbitmap_set(s->copy_bitmap, 0, s->len);
     }
 
-
     s->before_write.notify = backup_before_write_notify;
     bdrv_add_before_write_notifier(bs, &s->before_write);
 
@@ -527,7 +524,6 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
     /* wait until pending backup_do_cow() calls have completed */
     qemu_co_rwlock_wrlock(&s->flush_rwlock);
     qemu_co_rwlock_unlock(&s->flush_rwlock);
-    hbitmap_free(s->copy_bitmap);
 
     return ret;
 }
@@ -678,6 +674,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     } else {
         job->cluster_size = MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
     }
+
+    job->copy_bitmap = hbitmap_alloc(len, ctz32(job->cluster_size));
     job->use_copy_range = true;
     job->copy_range_size = MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
                                         blk_get_max_transfer(job->target));
-- 
2.18.0


