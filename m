Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7E4C19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C92229EC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C92229EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvH1j-00073d-L1
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 04:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40458)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvGzG-0008Co-Ff
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvGzF-0006sY-AB
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:07:58 -0400
Received: from relay.sw.ru ([185.231.240.75]:53648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvGzC-0006oK-8M; Wed, 07 Aug 2019 04:07:54 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvGz9-000300-8d; Wed, 07 Aug 2019 11:07:51 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed,  7 Aug 2019 11:07:50 +0300
Message-Id: <20190807080750.15950-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807080750.15950-1-vsementsov@virtuozzo.com>
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 8/8] block/backup: backup_do_cow: use
 bdrv_dirty_bitmap_next_dirty_area
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

Use effective bdrv_dirty_bitmap_next_dirty_area interface.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 56 ++++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index f19c9195fe..5ede0c8290 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -235,25 +235,28 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
 {
     CowRequest cow_request;
     int ret = 0;
-    int64_t start, end; /* bytes */
+    uint64_t off, cur_bytes;
+    int64_t aligned_offset, aligned_bytes, aligned_end;
     BdrvRequestFlags read_flags =
             is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
 
     qemu_co_rwlock_rdlock(&job->flush_rwlock);
 
-    start = QEMU_ALIGN_DOWN(offset, job->cluster_size);
-    end = QEMU_ALIGN_UP(bytes + offset, job->cluster_size);
+    aligned_offset = QEMU_ALIGN_DOWN(offset, job->cluster_size);
+    aligned_end = QEMU_ALIGN_UP(bytes + offset, job->cluster_size);
+    aligned_bytes = aligned_end - aligned_offset;
 
-    trace_backup_do_cow_enter(job, start, offset, bytes);
+    trace_backup_do_cow_enter(job, aligned_offset, offset, bytes);
 
-    wait_for_overlapping_requests(job, start, end);
-    cow_request_begin(&cow_request, job, start, end);
+    wait_for_overlapping_requests(job, aligned_offset, aligned_end);
+    cow_request_begin(&cow_request, job, aligned_offset, aligned_end);
 
     if (job->initializing_bitmap) {
-        int64_t off, chunk;
+        int64_t chunk;
 
-        for (off = offset; offset < end; offset += chunk) {
-            ret = backup_bitmap_reset_unallocated(job, off, end - off, &chunk);
+        for (off = aligned_offset; off < aligned_end; off += chunk) {
+            ret = backup_bitmap_reset_unallocated(job, off, aligned_end - off,
+                                                  &chunk);
             if (ret < 0) {
                 chunk = job->cluster_size;
             }
@@ -261,47 +264,36 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     }
     ret = 0;
 
-    while (start < end) {
-        int64_t dirty_end;
-        int64_t cur_bytes;
-
-        if (!bdrv_dirty_bitmap_get(job->copy_bitmap, start)) {
-            trace_backup_do_cow_skip(job, start);
-            start += job->cluster_size;
-            continue; /* already copied */
-        }
-
-        dirty_end = bdrv_dirty_bitmap_next_zero(job->copy_bitmap, start,
-                                                end - start);
-        if (dirty_end < 0) {
-            dirty_end = end;
-        }
-
-        trace_backup_do_cow_process(job, start);
-        cur_bytes = MIN(dirty_end - start, job->len - start);
-        bdrv_reset_dirty_bitmap(job->copy_bitmap, start, dirty_end - start);
+    off = aligned_offset;
+    cur_bytes = aligned_bytes;
+    while (bdrv_dirty_bitmap_next_dirty_area(job->copy_bitmap,
+                                             &off, &cur_bytes))
+    {
+        trace_backup_do_cow_process(job, off);
+        bdrv_reset_dirty_bitmap(job->copy_bitmap, off, cur_bytes);
 
         if (job->use_copy_range) {
-            ret = backup_cow_with_offload(job, start, cur_bytes, read_flags);
+            ret = backup_cow_with_offload(job, off, cur_bytes, read_flags);
             if (ret < 0) {
                 job->use_copy_range = false;
             }
         }
         if (!job->use_copy_range) {
-            ret = backup_cow_with_bounce_buffer(job, start, cur_bytes,
+            ret = backup_cow_with_bounce_buffer(job, off, cur_bytes,
                                                 read_flags, error_is_read);
         }
         if (ret < 0) {
-            bdrv_set_dirty_bitmap(job->copy_bitmap, start, dirty_end - start);
+            bdrv_set_dirty_bitmap(job->copy_bitmap, off, cur_bytes);
             break;
         }
 
         /* Publish progress, guest I/O counts as progress too.  Note that the
          * offset field is an opaque progress value, it is not a disk offset.
          */
-        start += cur_bytes;
+        off += cur_bytes;
         job->bytes_read += cur_bytes;
         job_progress_update(&job->common.job, cur_bytes);
+        cur_bytes = offset + bytes - off;
     }
 
     cow_request_end(&cow_request);
-- 
2.18.0


