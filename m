Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917CBC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D988229EC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D988229EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGzx-0001bf-Ld
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 04:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40459)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvGzG-0008Cp-Fh
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvGzF-0006sd-AL
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:07:58 -0400
Received: from relay.sw.ru ([185.231.240.75]:53632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvGzC-0006oM-8X; Wed, 07 Aug 2019 04:07:54 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvGz9-000300-2g; Wed, 07 Aug 2019 11:07:51 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed,  7 Aug 2019 11:07:48 +0300
Message-Id: <20190807080750.15950-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807080750.15950-1-vsementsov@virtuozzo.com>
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 6/8] block/backup: teach
 backup_cow_with_bounce_buffer to copy more at once
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

backup_cow_with_offload can transfer more than on cluster. Let
backup_cow_with_bounce_buffer behave similarly. It reduces number
of IO and there are no needs to copy cluster by cluster.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index eb41e4af4f..c765c073ad 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -104,22 +104,24 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
                                                       int64_t start,
                                                       int64_t end,
                                                       bool is_write_notifier,
-                                                      bool *error_is_read,
-                                                      void **bounce_buffer)
+                                                      bool *error_is_read)
 {
     int ret;
     BlockBackend *blk = job->common.blk;
     int nbytes;
     int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
+    void *bounce_buffer = blk_try_blockalign(blk, end);
 
-    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
-    bdrv_reset_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
-    nbytes = MIN(job->cluster_size, job->len - start);
-    if (!*bounce_buffer) {
-        *bounce_buffer = blk_blockalign(blk, job->cluster_size);
+    if (!bounce_buffer) {
+        return -ENOMEM;
     }
 
-    ret = blk_co_pread(blk, start, nbytes, *bounce_buffer, read_flags);
+    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
+    bdrv_reset_dirty_bitmap(job->copy_bitmap, start, end - start);
+
+    nbytes = MIN(end - start, job->len - start);
+
+    ret = blk_co_pread(blk, start, nbytes, bounce_buffer, read_flags);
     if (ret < 0) {
         trace_backup_do_cow_read_fail(job, start, ret);
         if (error_is_read) {
@@ -128,7 +130,7 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
         goto fail;
     }
 
-    ret = blk_co_pwrite(job->target, start, nbytes, *bounce_buffer,
+    ret = blk_co_pwrite(job->target, start, nbytes, bounce_buffer,
                         job->write_flags);
     if (ret < 0) {
         trace_backup_do_cow_write_fail(job, start, ret);
@@ -138,9 +140,12 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
         goto fail;
     }
 
+    qemu_vfree(bounce_buffer);
     return nbytes;
+
 fail:
     bdrv_set_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
+    qemu_vfree(bounce_buffer);
     return ret;
 
 }
@@ -255,7 +260,6 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     CowRequest cow_request;
     int ret = 0;
     int64_t start, end; /* bytes */
-    void *bounce_buffer = NULL;
 
     qemu_co_rwlock_rdlock(&job->flush_rwlock);
 
@@ -306,7 +310,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
         if (!job->use_copy_range) {
             ret = backup_cow_with_bounce_buffer(job, start, dirty_end,
                                                 is_write_notifier,
-                                                error_is_read, &bounce_buffer);
+                                                error_is_read);
         }
         if (ret < 0) {
             break;
@@ -321,10 +325,6 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
         ret = 0;
     }
 
-    if (bounce_buffer) {
-        qemu_vfree(bounce_buffer);
-    }
-
     cow_request_end(&cow_request);
 
     trace_backup_do_cow_return(job, offset, bytes, ret);
-- 
2.18.0


