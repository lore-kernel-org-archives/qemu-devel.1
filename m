Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4FDC4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45AB1206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AB1206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8QuF-0000DR-BR
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 11:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8Qn5-00024x-7w
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i8Qn3-00036W-93
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:13:47 -0400
Received: from relay.sw.ru ([185.231.240.75]:57852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8Qmz-00034A-Ur; Thu, 12 Sep 2019 11:13:42 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i8Qmx-0000kk-2b; Thu, 12 Sep 2019 18:13:39 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Thu, 12 Sep 2019 18:13:37 +0300
Message-Id: <20190912151338.21225-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190912151338.21225-1-vsementsov@virtuozzo.com>
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 3/4] block/mirror: support unaligned write in
 active mirror
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
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
 block/mirror.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index d176bf5920..d192f6a96b 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1204,6 +1204,39 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
                      QEMUIOVector *qiov, int flags)
 {
     int ret;
+    size_t qiov_offset = 0;
+
+    if (!QEMU_IS_ALIGNED(offset, job->granularity) &&
+        bdrv_dirty_bitmap_get(job->dirty_bitmap, offset)) {
+            /*
+             * Dirty unaligned padding
+             * 1. It's already dirty, no damage to "actively_synced" if we just
+             *    skip unaligned part.
+             * 2. If we copy it, we can't reset corresponding bit in
+             *    dirty_bitmap as there may be some "dirty" bytes still not
+             *    copied.
+             * So, just ignore it.
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
 
     bdrv_reset_dirty_bitmap(job->dirty_bitmap, offset, bytes);
 
@@ -1211,7 +1244,8 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
 
     switch (method) {
     case MIRROR_METHOD_COPY:
-        ret = blk_co_pwritev(job->target, offset, bytes, qiov, flags);
+        ret = blk_co_pwritev_part(job->target, offset, bytes,
+                                  qiov, qiov_offset, flags);
         break;
 
     case MIRROR_METHOD_ZERO:
@@ -1640,6 +1674,9 @@ static BlockJob *mirror_start_job(
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


