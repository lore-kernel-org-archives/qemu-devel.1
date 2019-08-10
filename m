Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A296FC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 19:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4C72085B
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 19:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4C72085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwX79-0002la-Pt
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 15:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44022)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwX5y-0000Ii-U4
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 15:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwX5x-0007By-Q2
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 15:32:06 -0400
Received: from relay.sw.ru ([185.231.240.75]:48794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwX5s-000773-FE; Sat, 10 Aug 2019 15:32:01 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwX5o-0000nK-QL; Sat, 10 Aug 2019 22:31:56 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Sat, 10 Aug 2019 22:31:49 +0300
Message-Id: <20190810193155.58637-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190810193155.58637-1-vsementsov@virtuozzo.com>
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3 1/7] block/backup: deal with zero detection
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

We have detect_zeroes option, so at least for blockdev-backup user
should define it if zero-detection is needed. For drive-backup leave
detection enabled by default but do it through existing option instead
of open-coding.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c | 15 ++++++---------
 blockdev.c     |  8 ++++----
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index adc4d44244..d815436455 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -113,7 +113,10 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
     BlockBackend *blk = job->common.blk;
     int nbytes;
     int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
-    int write_flags = job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0;
+    int write_flags =
+            (job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0) |
+            (job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
+
 
     assert(QEMU_IS_ALIGNED(start, job->cluster_size));
     bdrv_reset_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
@@ -131,14 +134,8 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
         goto fail;
     }
 
-    if (buffer_is_zero(*bounce_buffer, nbytes)) {
-        ret = blk_co_pwrite_zeroes(job->target, start,
-                                   nbytes, write_flags | BDRV_REQ_MAY_UNMAP);
-    } else {
-        ret = blk_co_pwrite(job->target, start,
-                            nbytes, *bounce_buffer, write_flags |
-                            (job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0));
-    }
+    ret = blk_co_pwrite(job->target, start, nbytes, *bounce_buffer,
+                        write_flags);
     if (ret < 0) {
         trace_backup_do_cow_write_fail(job, start, ret);
         if (error_is_read) {
diff --git a/blockdev.c b/blockdev.c
index 29c6c6044a..2d7e7be538 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3613,7 +3613,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
     BlockDriverState *source = NULL;
     BlockJob *job = NULL;
     AioContext *aio_context;
-    QDict *options = NULL;
+    QDict *options;
     Error *local_err = NULL;
     int flags;
     int64_t size;
@@ -3686,10 +3686,10 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
         goto out;
     }
 
+    options = qdict_new();
+    qdict_put_str(options, "discard", "unmap");
+    qdict_put_str(options, "detect-zeroes", "unmap");
     if (backup->format) {
-        if (!options) {
-            options = qdict_new();
-        }
         qdict_put_str(options, "driver", backup->format);
     }
 
-- 
2.18.0


