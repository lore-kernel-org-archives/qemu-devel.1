Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EABECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD3E2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD3E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqv1-00086u-K0
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqtM-0005xb-J6
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqtL-0004Bi-Fi
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:07:20 -0400
Received: from relay.sw.ru ([185.231.240.75]:60324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIqtH-000478-MV; Fri, 11 Oct 2019 05:07:15 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIqtE-0000XM-4e; Fri, 11 Oct 2019 12:07:12 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/5] block/mirror: simplify do_sync_target_write
Date: Fri, 11 Oct 2019 12:07:08 +0300
Message-Id: <20191011090711.19940-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011090711.19940-1-vsementsov@virtuozzo.com>
References: <20191011090711.19940-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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

do_sync_target_write is called from bdrv_mirror_top_do_write after
write/discard operation, all inside active_write/active_write_settle
protecting us from mirror iteration. So the whole area is dirty for
sure, no reason to examine dirty bitmap.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 95 +++++++++++++++-----------------------------------
 1 file changed, 28 insertions(+), 67 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index fe984efb90..1ae57a5131 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1181,84 +1181,45 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
                      uint64_t offset, uint64_t bytes,
                      QEMUIOVector *qiov, int flags)
 {
-    QEMUIOVector target_qiov;
-    uint64_t dirty_offset = offset;
-    uint64_t dirty_bytes;
-
-    if (qiov) {
-        qemu_iovec_init(&target_qiov, qiov->niov);
-    }
-
-    while (true) {
-        bool valid_area;
-        int ret;
-
-        bdrv_dirty_bitmap_lock(job->dirty_bitmap);
-        dirty_bytes = MIN(offset + bytes - dirty_offset, INT_MAX);
-        valid_area = bdrv_dirty_bitmap_next_dirty_area(job->dirty_bitmap,
-                                                       &dirty_offset,
-                                                       &dirty_bytes);
-        if (!valid_area) {
-            bdrv_dirty_bitmap_unlock(job->dirty_bitmap);
-            break;
-        }
+    int ret;
 
-        bdrv_reset_dirty_bitmap_locked(job->dirty_bitmap,
-                                       dirty_offset, dirty_bytes);
-        bdrv_dirty_bitmap_unlock(job->dirty_bitmap);
+    bdrv_reset_dirty_bitmap(job->dirty_bitmap, offset, bytes);
 
-        job_progress_increase_remaining(&job->common.job, dirty_bytes);
+    job_progress_increase_remaining(&job->common.job, bytes);
 
-        assert(dirty_offset - offset <= SIZE_MAX);
-        if (qiov) {
-            qemu_iovec_reset(&target_qiov);
-            qemu_iovec_concat(&target_qiov, qiov,
-                              dirty_offset - offset, dirty_bytes);
-        }
-
-        switch (method) {
-        case MIRROR_METHOD_COPY:
-            ret = blk_co_pwritev(job->target, dirty_offset, dirty_bytes,
-                                 qiov ? &target_qiov : NULL, flags);
-            break;
+    switch (method) {
+    case MIRROR_METHOD_COPY:
+        ret = blk_co_pwritev(job->target, offset, bytes, qiov, flags);
+        break;
 
-        case MIRROR_METHOD_ZERO:
-            assert(!qiov);
-            ret = blk_co_pwrite_zeroes(job->target, dirty_offset, dirty_bytes,
-                                       flags);
-            break;
+    case MIRROR_METHOD_ZERO:
+        assert(!qiov);
+        ret = blk_co_pwrite_zeroes(job->target, offset, bytes, flags);
+        break;
 
-        case MIRROR_METHOD_DISCARD:
-            assert(!qiov);
-            ret = blk_co_pdiscard(job->target, dirty_offset, dirty_bytes);
-            break;
+    case MIRROR_METHOD_DISCARD:
+        assert(!qiov);
+        ret = blk_co_pdiscard(job->target, offset, bytes);
+        break;
 
-        default:
-            abort();
-        }
+    default:
+        abort();
+    }
 
-        if (ret >= 0) {
-            job_progress_update(&job->common.job, dirty_bytes);
-        } else {
-            BlockErrorAction action;
+    if (ret >= 0) {
+        job_progress_update(&job->common.job, bytes);
+    } else {
+        BlockErrorAction action;
 
-            bdrv_set_dirty_bitmap(job->dirty_bitmap, dirty_offset, dirty_bytes);
-            job->actively_synced = false;
+        bdrv_set_dirty_bitmap(job->dirty_bitmap, offset, bytes);
+        job->actively_synced = false;
 
-            action = mirror_error_action(job, false, -ret);
-            if (action == BLOCK_ERROR_ACTION_REPORT) {
-                if (!job->ret) {
-                    job->ret = ret;
-                }
-                break;
+        action = mirror_error_action(job, false, -ret);
+        if (action == BLOCK_ERROR_ACTION_REPORT) {
+            if (!job->ret) {
+                job->ret = ret;
             }
         }
-
-        dirty_offset += dirty_bytes;
-    }
-
-    if (qiov) {
-        qemu_iovec_destroy(&target_qiov);
     }
 }
 
-- 
2.21.0


