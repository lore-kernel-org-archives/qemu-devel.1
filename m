Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC62CECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38782084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38782084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqyl-0005LI-BT
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqtM-0005x7-Cw
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIqtL-0004B1-1C
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:07:20 -0400
Received: from relay.sw.ru ([185.231.240.75]:60302)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIqtH-000479-ML; Fri, 11 Oct 2019 05:07:15 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIqtE-0000XM-Qx; Fri, 11 Oct 2019 12:07:12 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 4/5] block/mirror: support unaligned write in active mirror
Date: Fri, 11 Oct 2019 12:07:10 +0300
Message-Id: <20191011090711.19940-5-vsementsov@virtuozzo.com>
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

Prior 9adc1cb49af8d do_sync_target_write had a bug: it reset aligned-up
region in the dirty bitmap, which means that we may not copy some bytes
and assume them copied, which actually leads to producing corrupted
target.

So 9adc1cb49af8d forced dirty bitmap granularity to be
request_alignment for mirror-top filter, so we are not working with
unaligned requests. However forcing large alignment obviously decreases
performance of unaligned requests.

This commit provides another solution for the problem: if unaligned
padding is already dirty, we can safely ignore it, as
1. It's dirty, it will be copied by mirror_iteration anyway
2. It's dirty, so skipping it now we don't increase dirtiness of the
   bitmap and therefore don't damage "synchronicity" of the
   write-blocking mirror.

If unaligned padding is not dirty, we just write it, no reason to touch
dirty bitmap if we succeed (on failure we'll set the whole region
ofcourse, but we loss "synchronicity" on failure anyway).

Note: we need to disable dirty_bitmap, otherwise we will not be able to
see in do_sync_target_write bitmap state before current operation. We
may of course check dirty bitmap before the operation in
bdrv_mirror_top_do_write and remember it, but we don't need active
dirty bitmap for write-blocking mirror anyway.

New code-path is unused until the following commit reverts
9adc1cb49af8d.

Suggested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/mirror.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 1ae57a5131..1ed1d79ff8 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1182,14 +1182,67 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
                      QEMUIOVector *qiov, int flags)
 {
     int ret;
+    size_t qiov_offset = 0;
+    int64_t bitmap_offset, bitmap_end;
 
-    bdrv_reset_dirty_bitmap(job->dirty_bitmap, offset, bytes);
+    if (!QEMU_IS_ALIGNED(offset, job->granularity) &&
+        bdrv_dirty_bitmap_get(job->dirty_bitmap, offset))
+    {
+            /*
+             * Dirty unaligned padding: ignore it.
+             *
+             * Reasoning:
+             * 1. If we copy it, we can't reset corresponding bit in
+             *    dirty_bitmap as there may be some "dirty" bytes still not
+             *    copied.
+             * 2. It's already dirty, so skipping it we don't diverge mirror
+             *    progress.
+             *
+             * Note, that because of this, guest write may have no contribution
+             * into mirror converge, but that's not bad, as we have background
+             * process of mirroring. If under some bad circumstances (high guest
+             * IO load) background process starve, we will not converge anyway,
+             * even if each write will contribute, as guest is not guaranteed to
+             * rewrite the whole disk.
+             */
+            qiov_offset = QEMU_ALIGN_UP(offset, job->granularity) - offset;
+            if (bytes <= qiov_offset) {
+                /* nothing to do after shrink */
+                return;
+            }
+            offset += qiov_offset;
+            bytes -= qiov_offset;
+    }
+
+    if (!QEMU_IS_ALIGNED(offset + bytes, job->granularity) &&
+        bdrv_dirty_bitmap_get(job->dirty_bitmap, offset + bytes - 1))
+    {
+        uint64_t tail = (offset + bytes) % job->granularity;
+
+        if (bytes <= tail) {
+            /* nothing to do after shrink */
+            return;
+        }
+        bytes -= tail;
+    }
+
+    /*
+     * Tails are either clean or shrunk, so for bitmap resetting
+     * we safely align the range down.
+     */
+    bitmap_offset = QEMU_ALIGN_UP(offset, job->granularity);
+    bitmap_end = QEMU_ALIGN_DOWN(offset + bytes, job->granularity);
+    if (bitmap_offset < bitmap_end) {
+        bdrv_reset_dirty_bitmap(job->dirty_bitmap, bitmap_offset,
+                                bitmap_end - bitmap_offset);
+    }
 
     job_progress_increase_remaining(&job->common.job, bytes);
 
     switch (method) {
     case MIRROR_METHOD_COPY:
-        ret = blk_co_pwritev(job->target, offset, bytes, qiov, flags);
+        ret = blk_co_pwritev_part(job->target, offset, bytes,
+                                  qiov, qiov_offset, flags);
         break;
 
     case MIRROR_METHOD_ZERO:
@@ -1211,7 +1264,16 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
     } else {
         BlockErrorAction action;
 
-        bdrv_set_dirty_bitmap(job->dirty_bitmap, offset, bytes);
+        /*
+         * We failed, so we should mark dirty the whole area, aligned up.
+         * Note that we don't care about shrunk tails if any: they were dirty
+         * at function start, and they must be still dirty, as we've locked
+         * the region for in-flight op.
+         */
+        bitmap_offset = QEMU_ALIGN_DOWN(offset, job->granularity);
+        bitmap_end = QEMU_ALIGN_UP(offset + bytes, job->granularity);
+        bdrv_set_dirty_bitmap(job->dirty_bitmap, bitmap_offset,
+                              bitmap_end - bitmap_offset);
         job->actively_synced = false;
 
         action = mirror_error_action(job, false, -ret);
@@ -1618,6 +1680,9 @@ static BlockJob *mirror_start_job(
     if (!s->dirty_bitmap) {
         goto fail;
     }
+    if (s->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING) {
+        bdrv_disable_dirty_bitmap(s->dirty_bitmap);
+    }
 
     ret = block_job_add_bdrv(&s->common, "source", bs, 0,
                              BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
-- 
2.21.0


