Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D9AC32751
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 19:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8002085B
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 19:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8002085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwX8W-0005Ua-Gt
	for qemu-devel@archiver.kernel.org; Sat, 10 Aug 2019 15:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44035)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwX5z-0000Jn-9p
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 15:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hwX5x-0007CC-RV
 for qemu-devel@nongnu.org; Sat, 10 Aug 2019 15:32:07 -0400
Received: from relay.sw.ru ([185.231.240.75]:48776)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwX5s-00076z-FR; Sat, 10 Aug 2019 15:32:01 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hwX5p-0000nK-Ho; Sat, 10 Aug 2019 22:31:57 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Sat, 10 Aug 2019 22:31:54 +0300
Message-Id: <20190810193155.58637-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190810193155.58637-1-vsementsov@virtuozzo.com>
References: <20190810193155.58637-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3 6/7] block/backup: teach
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

backup_cow_with_offload can transfer more than one cluster. Let
backup_cow_with_bounce_buffer behave similarly. It reduces the number
of IO requests, since there is no need to copy cluster by cluster.

Logic around bounce_buffer allocation changed: we can't just allocate
one-cluster-sized buffer to share for all iterations. We can't also
allocate buffer of full-request length it may be too large, so
BACKUP_MAX_BOUNCE_BUFFER is introduced. And finally, allocation logic
is to allocate a buffer sufficient to handle all remaining iterations
at the point where we need the buffer for the first time.

Bonus: get rid of pointer-to-pointer.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 65 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index d482d93458..65f7212c85 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -27,6 +27,7 @@
 #include "qemu/error-report.h"
 
 #define BACKUP_CLUSTER_SIZE_DEFAULT (1 << 16)
+#define BACKUP_MAX_BOUNCE_BUFFER (64 * 1024 * 1024)
 
 typedef struct CowRequest {
     int64_t start_byte;
@@ -98,44 +99,55 @@ static void cow_request_end(CowRequest *req)
     qemu_co_queue_restart_all(&req->wait_queue);
 }
 
-/* Copy range to target with a bounce buffer and return the bytes copied. If
- * error occurred, return a negative error number */
+/*
+ * Copy range to target with a bounce buffer and return the bytes copied. If
+ * error occurred, return a negative error number
+ *
+ * @bounce_buffer is assumed to enough to store
+ * MIN(BACKUP_MAX_BOUNCE_BUFFER, @end - @start) bytes
+ */
 static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
                                                       int64_t start,
                                                       int64_t end,
                                                       bool is_write_notifier,
                                                       bool *error_is_read,
-                                                      void **bounce_buffer)
+                                                      void *bounce_buffer)
 {
     int ret;
     BlockBackend *blk = job->common.blk;
-    int nbytes;
+    int nbytes, remaining_bytes;
     int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
 
     assert(QEMU_IS_ALIGNED(start, job->cluster_size));
-    bdrv_reset_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
-    nbytes = MIN(job->cluster_size, job->len - start);
-    if (!*bounce_buffer) {
-        *bounce_buffer = blk_blockalign(blk, job->cluster_size);
-    }
+    bdrv_reset_dirty_bitmap(job->copy_bitmap, start, end - start);
+    nbytes = MIN(end - start, job->len - start);
 
-    ret = blk_co_pread(blk, start, nbytes, *bounce_buffer, read_flags);
-    if (ret < 0) {
-        trace_backup_do_cow_read_fail(job, start, ret);
-        if (error_is_read) {
-            *error_is_read = true;
+
+    remaining_bytes = nbytes;
+    while (remaining_bytes) {
+        int chunk = MIN(BACKUP_MAX_BOUNCE_BUFFER, remaining_bytes);
+
+        ret = blk_co_pread(blk, start, chunk, bounce_buffer, read_flags);
+        if (ret < 0) {
+            trace_backup_do_cow_read_fail(job, start, ret);
+            if (error_is_read) {
+                *error_is_read = true;
+            }
+            goto fail;
         }
-        goto fail;
-    }
 
-    ret = blk_co_pwrite(job->target, start, nbytes, *bounce_buffer,
-                        job->write_flags);
-    if (ret < 0) {
-        trace_backup_do_cow_write_fail(job, start, ret);
-        if (error_is_read) {
-            *error_is_read = false;
+        ret = blk_co_pwrite(job->target, start, chunk, bounce_buffer,
+                            job->write_flags);
+        if (ret < 0) {
+            trace_backup_do_cow_write_fail(job, start, ret);
+            if (error_is_read) {
+                *error_is_read = false;
+            }
+            goto fail;
         }
-        goto fail;
+
+        start += chunk;
+        remaining_bytes -= chunk;
     }
 
     return nbytes;
@@ -301,9 +313,14 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
             }
         }
         if (!job->use_copy_range) {
+            if (!bounce_buffer) {
+                size_t len = MIN(BACKUP_MAX_BOUNCE_BUFFER,
+                                 MAX(dirty_end - start, end - dirty_end));
+                bounce_buffer = blk_try_blockalign(job->common.blk, len);
+            }
             ret = backup_cow_with_bounce_buffer(job, start, dirty_end,
                                                 is_write_notifier,
-                                                error_is_read, &bounce_buffer);
+                                                error_is_read, bounce_buffer);
         }
         if (ret < 0) {
             break;
-- 
2.18.0


