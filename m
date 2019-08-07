Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E61FC19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1681229EC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1681229EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvH1e-0006ok-5f
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 04:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40467)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvGzG-0008DW-Lt
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvGzF-0006sq-Cw
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:07:58 -0400
Received: from relay.sw.ru ([185.231.240.75]:53630)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvGzC-0006oN-8W; Wed, 07 Aug 2019 04:07:54 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvGz9-000300-5v; Wed, 07 Aug 2019 11:07:51 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed,  7 Aug 2019 11:07:49 +0300
Message-Id: <20190807080750.15950-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807080750.15950-1-vsementsov@virtuozzo.com>
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 7/8] block/backup: merge duplicated logic into
 backup_do_cow
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
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

backup_cow_with_offload and backup_cow_with_bounce_buffer contains a
lot of duplicated logic. Move it into backup_do_cow.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 83 +++++++++++++++++++-------------------------------
 1 file changed, 31 insertions(+), 52 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index c765c073ad..f19c9195fe 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -100,84 +100,60 @@ static void cow_request_end(CowRequest *req)
 
 /* Copy range to target with a bounce buffer and return the bytes copied. If
  * error occurred, return a negative error number */
-static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
-                                                      int64_t start,
-                                                      int64_t end,
-                                                      bool is_write_notifier,
-                                                      bool *error_is_read)
+static int coroutine_fn backup_cow_with_bounce_buffer(
+        BackupBlockJob *job, int64_t offset, int64_t bytes,
+        BdrvRequestFlags read_flags, bool *error_is_read)
 {
-    int ret;
+    int ret = 0;
     BlockBackend *blk = job->common.blk;
-    int nbytes;
-    int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
-    void *bounce_buffer = blk_try_blockalign(blk, end);
+    void *bounce_buffer = blk_try_blockalign(blk, bytes);
 
     if (!bounce_buffer) {
         return -ENOMEM;
     }
 
-    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
-    bdrv_reset_dirty_bitmap(job->copy_bitmap, start, end - start);
-
-    nbytes = MIN(end - start, job->len - start);
-
-    ret = blk_co_pread(blk, start, nbytes, bounce_buffer, read_flags);
+    ret = blk_co_pread(blk, offset, bytes, bounce_buffer, read_flags);
     if (ret < 0) {
-        trace_backup_do_cow_read_fail(job, start, ret);
+        trace_backup_do_cow_read_fail(job, offset, ret);
         if (error_is_read) {
             *error_is_read = true;
         }
-        goto fail;
+        goto out;
     }
 
-    ret = blk_co_pwrite(job->target, start, nbytes, bounce_buffer,
+    ret = blk_co_pwrite(job->target, offset, bytes, bounce_buffer,
                         job->write_flags);
     if (ret < 0) {
-        trace_backup_do_cow_write_fail(job, start, ret);
+        trace_backup_do_cow_write_fail(job, offset, ret);
         if (error_is_read) {
             *error_is_read = false;
         }
-        goto fail;
+        goto out;
     }
 
+out:
     qemu_vfree(bounce_buffer);
-    return nbytes;
 
-fail:
-    bdrv_set_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
-    qemu_vfree(bounce_buffer);
     return ret;
-
 }
 
 /* Copy range to target and return the bytes copied. If error occurred, return a
  * negative error number. */
 static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
-                                                int64_t start,
-                                                int64_t end,
-                                                bool is_write_notifier)
+                                                int64_t offset,
+                                                int64_t bytes,
+                                                BdrvRequestFlags read_flags)
 {
     int ret;
-    int nr_clusters;
     BlockBackend *blk = job->common.blk;
-    int nbytes = MIN(end - start, job->len - start);
-    int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
-
-    assert(end - start < INT_MAX);
-    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
-    nr_clusters = DIV_ROUND_UP(nbytes, job->cluster_size);
-    bdrv_reset_dirty_bitmap(job->copy_bitmap, start,
-                            job->cluster_size * nr_clusters);
-    ret = blk_co_copy_range(blk, start, job->target, start, nbytes,
+
+    ret = blk_co_copy_range(blk, offset, job->target, offset, bytes,
                             read_flags, job->write_flags);
     if (ret < 0) {
-        trace_backup_do_cow_copy_range_fail(job, start, ret);
-        bdrv_set_dirty_bitmap(job->copy_bitmap, start,
-                              job->cluster_size * nr_clusters);
-        return ret;
+        trace_backup_do_cow_copy_range_fail(job, offset, ret);
     }
 
-    return nbytes;
+    return ret;
 }
 
 /*
@@ -260,6 +236,8 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     CowRequest cow_request;
     int ret = 0;
     int64_t start, end; /* bytes */
+    BdrvRequestFlags read_flags =
+            is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
 
     qemu_co_rwlock_rdlock(&job->flush_rwlock);
 
@@ -285,6 +263,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
 
     while (start < end) {
         int64_t dirty_end;
+        int64_t cur_bytes;
 
         if (!bdrv_dirty_bitmap_get(job->copy_bitmap, start)) {
             trace_backup_do_cow_skip(job, start);
@@ -299,30 +278,30 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
         }
 
         trace_backup_do_cow_process(job, start);
+        cur_bytes = MIN(dirty_end - start, job->len - start);
+        bdrv_reset_dirty_bitmap(job->copy_bitmap, start, dirty_end - start);
 
         if (job->use_copy_range) {
-            ret = backup_cow_with_offload(job, start, dirty_end,
-                                          is_write_notifier);
+            ret = backup_cow_with_offload(job, start, cur_bytes, read_flags);
             if (ret < 0) {
                 job->use_copy_range = false;
             }
         }
         if (!job->use_copy_range) {
-            ret = backup_cow_with_bounce_buffer(job, start, dirty_end,
-                                                is_write_notifier,
-                                                error_is_read);
+            ret = backup_cow_with_bounce_buffer(job, start, cur_bytes,
+                                                read_flags, error_is_read);
         }
         if (ret < 0) {
+            bdrv_set_dirty_bitmap(job->copy_bitmap, start, dirty_end - start);
             break;
         }
 
         /* Publish progress, guest I/O counts as progress too.  Note that the
          * offset field is an opaque progress value, it is not a disk offset.
          */
-        start += ret;
-        job->bytes_read += ret;
-        job_progress_update(&job->common.job, ret);
-        ret = 0;
+        start += cur_bytes;
+        job->bytes_read += cur_bytes;
+        job_progress_update(&job->common.job, cur_bytes);
     }
 
     cow_request_end(&cow_request);
-- 
2.18.0


