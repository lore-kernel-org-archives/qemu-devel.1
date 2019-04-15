Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C61C10F12
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E982075B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 14:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E982075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51279 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG2xj-0006rd-S2
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 10:51:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hG2vo-0005Ub-Ut
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hG2vk-0005SB-1H
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 10:49:59 -0400
Received: from relay.sw.ru ([185.231.240.75]:48882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hG2vg-0005QR-T2; Mon, 15 Apr 2019 10:49:54 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hG2ve-0002By-JB; Mon, 15 Apr 2019 17:49:50 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Mon, 15 Apr 2019 17:49:47 +0300
Message-Id: <20190415144948.78568-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190415144948.78568-1-vsementsov@virtuozzo.com>
References: <20190415144948.78568-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v6 4/5] block/backup: unify different modes
 code path
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
Message-ID: <20190415144947.6q2VmQ6VRN2xYGPr-itkpvz4BfGP8EwwknWt4oDsDUE@z>

Do full, top and incremental mode copying all in one place. This
unifies the code path and helps further improvements.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 43 ++++++++++---------------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 298e85f1a9..b54386b699 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -393,15 +393,23 @@ static bool bdrv_is_unallocated_range(BlockDriverState *bs,
     return offset >= end;
 }
 
-static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
+static int coroutine_fn backup_loop(BackupBlockJob *job)
 {
     int ret;
     bool error_is_read;
     int64_t offset;
     HBitmapIter hbi;
+    BlockDriverState *bs = blk_bs(job->common.blk);
 
     hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
     while ((offset = hbitmap_iter_next(&hbi)) != -1) {
+        if (job->sync_mode == MIRROR_SYNC_MODE_TOP &&
+            bdrv_is_unallocated_range(bs, offset, job->cluster_size))
+        {
+            hbitmap_reset(job->copy_bitmap, offset, job->cluster_size);
+            continue;
+        }
+
         do {
             if (yield_and_check(job)) {
                 return 0;
@@ -446,7 +454,6 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
     BlockDriverState *bs = blk_bs(s->common.blk);
-    int64_t offset;
     int ret = 0;
 
     QLIST_INIT(&s->inflight_reqs);
@@ -471,38 +478,8 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
              * notify callback service CoW requests. */
             job_yield(job);
         }
-    } else if (s->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
-        ret = backup_run_incremental(s);
     } else {
-        /* Both FULL and TOP SYNC_MODE's require copying.. */
-        for (offset = 0; offset < s->len;
-             offset += s->cluster_size) {
-            bool error_is_read;
-
-            if (yield_and_check(s)) {
-                break;
-            }
-
-            if (s->sync_mode == MIRROR_SYNC_MODE_TOP &&
-                bdrv_is_unallocated_range(bs, offset, s->cluster_size))
-            {
-                continue;
-            }
-
-            ret = backup_do_cow(s, offset, s->cluster_size,
-                                &error_is_read, false);
-            if (ret < 0) {
-                /* Depending on error action, fail now or retry cluster */
-                BlockErrorAction action =
-                    backup_error_action(s, error_is_read, -ret);
-                if (action == BLOCK_ERROR_ACTION_REPORT) {
-                    break;
-                } else {
-                    offset -= s->cluster_size;
-                    continue;
-                }
-            }
-        }
+        ret = backup_loop(s);
     }
 
     notifier_with_return_remove(&s->before_write);
-- 
2.18.0


