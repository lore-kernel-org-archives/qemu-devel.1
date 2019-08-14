Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753F3C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 14:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9222084F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 14:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9222084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxuYu-0006rb-DJ
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 10:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxuUo-00043U-Iy
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxuUn-0002DA-Ce
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 10:43:26 -0400
Received: from relay.sw.ru ([185.231.240.75]:49608)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxuUi-0002AH-Qn; Wed, 14 Aug 2019 10:43:22 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxuUf-0007hk-JB; Wed, 14 Aug 2019 17:43:17 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed, 14 Aug 2019 17:43:15 +0300
Message-Id: <20190814144315.89729-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190814144315.89729-1-vsementsov@virtuozzo.com>
References: <20190814144315.89729-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 4/4] block/backup: fix and improve skipping
 unallocated in backup_do_cow
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
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

1. There is a bug: after detection an allocated area of skip_bytes
length we ignore skip_bytes variable and my finish up by copying more
than skip_bytes.

2. If request area is allocated we call block_status for each cluster
on each loop iteration, even if after the first call we know that the
whole request area is allocated.

Solve all of this by handling resetting all unallocated bytes from
requested area before copying loop.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 9bddea1b59..d0815b21c8 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -257,7 +257,6 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     int ret = 0;
     int64_t start, end; /* bytes */
     void *bounce_buffer = NULL;
-    int64_t skip_bytes;
 
     qemu_co_rwlock_rdlock(&job->flush_rwlock);
 
@@ -269,6 +268,22 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     wait_for_overlapping_requests(job, start, end);
     cow_request_begin(&cow_request, job, start, end);
 
+    if (job->initializing_bitmap) {
+        int64_t off = start;
+        int64_t count;
+
+        while (off < end) {
+            off = bdrv_dirty_bitmap_next_dirty(job->copy_bitmap,
+                                               off, end - off);
+            if (off < 0) {
+                break;
+            }
+
+            backup_bitmap_reset_unallocated(job, off, &count);
+            off += count;
+        }
+    }
+
     while (start < end) {
         int64_t dirty_end;
 
@@ -277,15 +292,6 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
             break;
         }
 
-        if (job->initializing_bitmap) {
-            ret = backup_bitmap_reset_unallocated(job, start, &skip_bytes);
-            if (ret == 0) {
-                trace_backup_do_cow_skip_range(job, start, skip_bytes);
-                start += skip_bytes;
-                continue;
-            }
-        }
-
         dirty_end = bdrv_dirty_bitmap_next_zero(job->copy_bitmap, start,
                                                 (end - start));
         if (dirty_end < 0) {
-- 
2.18.0


