Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB7DC19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F532229EC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F532229EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvH0o-0004Ag-DR
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 04:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40460)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvGzG-0008Cr-G5
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvGzF-0006sj-C4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:07:58 -0400
Received: from relay.sw.ru ([185.231.240.75]:53658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvGzC-0006oS-61; Wed, 07 Aug 2019 04:07:54 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvGz8-000300-Sj; Wed, 07 Aug 2019 11:07:50 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed,  7 Aug 2019 11:07:46 +0300
Message-Id: <20190807080750.15950-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807080750.15950-1-vsementsov@virtuozzo.com>
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 4/8] block/backup: improve unallocated clusters
 skipping
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

Limit block_status querying to request bounds on write notifier to
avoid extra seeking.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 11e27c844d..a4d37d2d62 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -180,14 +180,14 @@ static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
  * return via pnum the number of contiguous clusters sharing this allocation.
  */
 static int backup_is_cluster_allocated(BackupBlockJob *s, int64_t offset,
-                                       int64_t *pnum)
+                                       int64_t bytes, int64_t *pnum)
 {
     BlockDriverState *bs = blk_bs(s->common.blk);
     int64_t count, total_count = 0;
-    int64_t bytes = s->len - offset;
     int ret;
 
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
+    bytes = MIN(s->len - offset, bytes);
 
     while (true) {
         ret = bdrv_is_allocated(bs, offset, bytes, &count);
@@ -224,12 +224,13 @@ static int backup_is_cluster_allocated(BackupBlockJob *s, int64_t offset,
  *         1 otherwise, and -ret on error.
  */
 static int64_t backup_bitmap_reset_unallocated(BackupBlockJob *s,
-                                               int64_t offset, int64_t *count)
+                                               int64_t offset, int64_t bytes,
+                                               int64_t *pnum)
 {
     int ret;
-    int64_t clusters, bytes, estimate;
+    int64_t clusters, estimate;
 
-    ret = backup_is_cluster_allocated(s, offset, &clusters);
+    ret = backup_is_cluster_allocated(s, offset, bytes, &clusters);
     if (ret < 0) {
         return ret;
     }
@@ -242,7 +243,7 @@ static int64_t backup_bitmap_reset_unallocated(BackupBlockJob *s,
         job_progress_set_remaining(&s->common.job, estimate);
     }
 
-    *count = bytes;
+    *pnum = bytes;
     return ret;
 }
 
@@ -255,7 +256,6 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     int ret = 0;
     int64_t start, end; /* bytes */
     void *bounce_buffer = NULL;
-    int64_t skip_bytes;
 
     qemu_co_rwlock_rdlock(&job->flush_rwlock);
 
@@ -267,6 +267,18 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     wait_for_overlapping_requests(job, start, end);
     cow_request_begin(&cow_request, job, start, end);
 
+    if (job->initializing_bitmap) {
+        int64_t off, chunk;
+
+        for (off = offset; offset < end; offset += chunk) {
+            ret = backup_bitmap_reset_unallocated(job, off, end - off, &chunk);
+            if (ret < 0) {
+                chunk = job->cluster_size;
+            }
+        }
+    }
+    ret = 0;
+
     while (start < end) {
         int64_t dirty_end;
 
@@ -276,15 +288,6 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
             continue; /* already copied */
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
                                                 end - start);
         if (dirty_end < 0) {
@@ -546,7 +549,8 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
                 goto out;
             }
 
-            ret = backup_bitmap_reset_unallocated(s, offset, &count);
+            ret = backup_bitmap_reset_unallocated(s, offset, s->len - offset,
+                                                  &count);
             if (ret < 0) {
                 goto out;
             }
-- 
2.18.0


