Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C76C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDE2229EC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDE2229EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvH1e-0006qK-TJ
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 04:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40465)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvGzG-0008DA-Jc
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvGzF-0006sP-5M
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:07:58 -0400
Received: from relay.sw.ru ([185.231.240.75]:53644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvGzC-0006oQ-8L; Wed, 07 Aug 2019 04:07:54 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvGz8-000300-PH; Wed, 07 Aug 2019 11:07:50 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed,  7 Aug 2019 11:07:45 +0300
Message-Id: <20190807080750.15950-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807080750.15950-1-vsementsov@virtuozzo.com>
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 3/8] block/io: handle alignment and
 max_transfer for copy_range
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

copy_range ignores these limitations, let's improve it. block/backup
code handles max_transfer for copy_range by itself, now it's not needed
more, drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 11 ++---------
 block/io.c     | 41 +++++++++++++++++++++++++++++++++--------
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 3cdbe973e6..11e27c844d 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -54,7 +54,6 @@ typedef struct BackupBlockJob {
     QLIST_HEAD(, CowRequest) inflight_reqs;
 
     bool use_copy_range;
-    int64_t copy_range_size;
 
     BdrvRequestFlags write_flags;
     bool initializing_bitmap;
@@ -156,12 +155,11 @@ static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
     int ret;
     int nr_clusters;
     BlockBackend *blk = job->common.blk;
-    int nbytes;
+    int nbytes = end - start;
     int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
 
-    assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
+    assert(end - start < INT_MAX);
     assert(QEMU_IS_ALIGNED(start, job->cluster_size));
-    nbytes = MIN(job->copy_range_size, end - start);
     nr_clusters = DIV_ROUND_UP(nbytes, job->cluster_size);
     bdrv_reset_dirty_bitmap(job->copy_bitmap, start,
                             job->cluster_size * nr_clusters);
@@ -756,11 +754,6 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     job->copy_bitmap = copy_bitmap;
     copy_bitmap = NULL;
     job->use_copy_range = !compress; /* compression isn't supported for it */
-    job->copy_range_size = MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
-                                        blk_get_max_transfer(job->target));
-    job->copy_range_size = MAX(job->cluster_size,
-                               QEMU_ALIGN_UP(job->copy_range_size,
-                                             job->cluster_size));
 
     /* Required permissions are already taken with target's blk_new() */
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
diff --git a/block/io.c b/block/io.c
index 06305c6ea6..5abbd0fff2 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3005,6 +3005,12 @@ static int coroutine_fn bdrv_co_copy_range_internal(
 {
     BdrvTrackedRequest req;
     int ret;
+    uint32_t align = MAX(src->bs->bl.request_alignment,
+                         dst->bs->bl.request_alignment);
+    uint32_t max_transfer =
+            QEMU_ALIGN_DOWN(MIN_NON_ZERO(MIN_NON_ZERO(src->bs->bl.max_transfer,
+                                                      dst->bs->bl.max_transfer),
+                                         INT_MAX), align);
 
     /* TODO We can support BDRV_REQ_NO_FALLBACK here */
     assert(!(read_flags & BDRV_REQ_NO_FALLBACK));
@@ -3031,7 +3037,10 @@ static int coroutine_fn bdrv_co_copy_range_internal(
 
     if (!src->bs->drv->bdrv_co_copy_range_from
         || !dst->bs->drv->bdrv_co_copy_range_to
-        || src->bs->encrypted || dst->bs->encrypted) {
+        || src->bs->encrypted || dst->bs->encrypted ||
+        !QEMU_IS_ALIGNED(src_offset, src->bs->bl.request_alignment) ||
+        !QEMU_IS_ALIGNED(dst_offset, dst->bs->bl.request_alignment) ||
+        !QEMU_IS_ALIGNED(bytes, align)) {
         return -ENOTSUP;
     }
 
@@ -3046,11 +3055,22 @@ static int coroutine_fn bdrv_co_copy_range_internal(
             wait_serialising_requests(&req);
         }
 
-        ret = src->bs->drv->bdrv_co_copy_range_from(src->bs,
-                                                    src, src_offset,
-                                                    dst, dst_offset,
-                                                    bytes,
-                                                    read_flags, write_flags);
+        while (bytes) {
+            int num = MIN(bytes, max_transfer);
+
+            ret = src->bs->drv->bdrv_co_copy_range_from(src->bs,
+                                                        src, src_offset,
+                                                        dst, dst_offset,
+                                                        num,
+                                                        read_flags,
+                                                        write_flags);
+            if (ret < 0) {
+                break;
+            }
+            bytes -= num;
+            src_offset += num;
+            dst_offset += num;
+        }
 
         tracked_request_end(&req);
         bdrv_dec_in_flight(src->bs);
@@ -3060,12 +3080,17 @@ static int coroutine_fn bdrv_co_copy_range_internal(
                               BDRV_TRACKED_WRITE);
         ret = bdrv_co_write_req_prepare(dst, dst_offset, bytes, &req,
                                         write_flags);
-        if (!ret) {
+        while (!ret && bytes) {
+            int num = MIN(bytes, max_transfer);
+
             ret = dst->bs->drv->bdrv_co_copy_range_to(dst->bs,
                                                       src, src_offset,
                                                       dst, dst_offset,
-                                                      bytes,
+                                                      num,
                                                       read_flags, write_flags);
+            bytes -= num;
+            src_offset += num;
+            dst_offset += num;
         }
         bdrv_co_write_req_finish(dst, dst_offset, bytes, &req, ret);
         tracked_request_end(&req);
-- 
2.18.0


