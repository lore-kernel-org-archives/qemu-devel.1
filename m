Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A14C4741F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 13:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82916239A1
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 13:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82916239A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMWO6-0001F8-HF
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 09:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kMWMS-0007qe-5d
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 09:05:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40272 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kMWMQ-0003Mz-1H
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 09:05:03 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id AFA9BD578B7977E05671;
 Sun, 27 Sep 2020 21:04:47 +0800 (CST)
Received: from localhost (10.174.185.104) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Sun, 27 Sep 2020
 21:04:41 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC PATCH 4/7] block-backend: add I/O hang drain when disbale
Date: Sun, 27 Sep 2020 21:04:17 +0800
Message-ID: <20200927130420.1095-5-fangying1@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200927130420.1095-1-fangying1@huawei.com>
References: <20200927130420.1095-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 09:04:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, Ying Fang <fangying1@huawei.com>,
 Jiahui Cen <cenjiahui@huawei.com>, zhang.zhanghailiang@huawei.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To disable I/O hang, all hanging AIOs need to be drained. A rehandle status
field is introduced to notify rehandle mechanism not to rehandle failed AIOs
when I/O hang is disabled.

Signed-off-by: Ying Fang <fangying1@huawei.com>
Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
---
 block/block-backend.c          | 85 ++++++++++++++++++++++++++++++++--
 include/sysemu/block-backend.h |  3 ++
 2 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index d0b2b59f55..95b2d6a679 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -37,6 +37,9 @@ static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb);
 
 /* block backend rehandle timer interval 5s */
 #define BLOCK_BACKEND_REHANDLE_TIMER_INTERVAL   5000
+#define BLOCK_BACKEND_REHANDLE_NORMAL           1
+#define BLOCK_BACKEND_REHANDLE_DRAIN_REQUESTED  2
+#define BLOCK_BACKEND_REHANDLE_DRAINED          3
 
 enum BlockIOHangStatus {
     BLOCK_IO_HANG_STATUS_NORMAL = 0,
@@ -50,6 +53,8 @@ typedef struct BlockBackendRehandleInfo {
 
     unsigned int in_flight;
     QTAILQ_HEAD(, BlkAioEmAIOCB) re_aios;
+
+    int status;
 } BlockBackendRehandleInfo;
 
 typedef struct BlockBackendAioNotifier {
@@ -471,6 +476,8 @@ static void blk_delete(BlockBackend *blk)
     assert(!blk->refcnt);
     assert(!blk->name);
     assert(!blk->dev);
+    assert(atomic_read(&blk->reinfo.in_flight) == 0);
+    blk_rehandle_disable(blk);
     if (blk->public.throttle_group_member.throttle_state) {
         blk_io_limits_disable(blk);
     }
@@ -2460,6 +2467,37 @@ static void blk_rehandle_remove_aiocb(BlockBackend *blk, BlkAioEmAIOCB *acb)
     atomic_dec(&blk->reinfo.in_flight);
 }
 
+static void blk_rehandle_drain(BlockBackend *blk)
+{
+    if (blk_bs(blk)) {
+        bdrv_drained_begin(blk_bs(blk));
+        BDRV_POLL_WHILE(blk_bs(blk), atomic_read(&blk->reinfo.in_flight) > 0);
+        bdrv_drained_end(blk_bs(blk));
+    }
+}
+
+static bool blk_rehandle_is_paused(BlockBackend *blk)
+{
+    return blk->reinfo.status == BLOCK_BACKEND_REHANDLE_DRAIN_REQUESTED ||
+           blk->reinfo.status == BLOCK_BACKEND_REHANDLE_DRAINED;
+}
+
+static void blk_rehandle_pause(BlockBackend *blk)
+{
+    BlockBackendRehandleInfo *reinfo = &blk->reinfo;
+
+    aio_context_acquire(blk_get_aio_context(blk));
+    if (!reinfo->enable || reinfo->status == BLOCK_BACKEND_REHANDLE_DRAINED) {
+        aio_context_release(blk_get_aio_context(blk));
+        return;
+    }
+
+    reinfo->status = BLOCK_BACKEND_REHANDLE_DRAIN_REQUESTED;
+    blk_rehandle_drain(blk);
+    reinfo->status = BLOCK_BACKEND_REHANDLE_DRAINED;
+    aio_context_release(blk_get_aio_context(blk));
+}
+
 static void blk_rehandle_timer_cb(void *opaque)
 {
     BlockBackend *blk = opaque;
@@ -2559,10 +2597,12 @@ static void blk_rehandle_aio_complete(BlkAioEmAIOCB *acb)
 
     if (acb->has_returned) {
         blk_dec_in_flight(acb->rwco.blk);
-        need_rehandle = blk_rehandle_aio(acb, &has_timeout);
-        if (need_rehandle) {
-            blk_rehandle_insert_aiocb(acb->rwco.blk, acb);
-            return;
+        if (!blk_rehandle_is_paused(acb->rwco.blk)) {
+            need_rehandle = blk_rehandle_aio(acb, &has_timeout);
+            if (need_rehandle) {
+                blk_rehandle_insert_aiocb(acb->rwco.blk, acb);
+                return;
+            }
         }
 
         acb->common.cb(acb->common.opaque, acb->rwco.ret);
@@ -2576,6 +2616,42 @@ static void blk_rehandle_aio_complete(BlkAioEmAIOCB *acb)
     }
 }
 
+void blk_rehandle_enable(BlockBackend *blk)
+{
+    BlockBackendRehandleInfo *reinfo = &blk->reinfo;
+
+    aio_context_acquire(blk_get_aio_context(blk));
+    if (reinfo->enable) {
+        aio_context_release(blk_get_aio_context(blk));
+        return;
+    }
+
+    reinfo->ts = aio_timer_new(blk_get_aio_context(blk), QEMU_CLOCK_REALTIME,
+                               SCALE_MS, blk_rehandle_timer_cb, blk);
+    reinfo->timer_interval_ms = BLOCK_BACKEND_REHANDLE_TIMER_INTERVAL;
+    reinfo->status = BLOCK_BACKEND_REHANDLE_NORMAL;
+    reinfo->enable = true;
+    aio_context_release(blk_get_aio_context(blk));
+}
+
+void blk_rehandle_disable(BlockBackend *blk)
+{
+    if (!blk->reinfo.enable) {
+        return;
+    }
+
+    blk_rehandle_pause(blk);
+    timer_del(blk->reinfo.ts);
+    timer_free(blk->reinfo.ts);
+    blk->reinfo.ts = NULL;
+    blk->reinfo.enable = false;
+}
+
+bool blk_iohang_is_enabled(BlockBackend *blk)
+{
+    return blk->iohang_timeout != 0;
+}
+
 void blk_iohang_init(BlockBackend *blk, int64_t iohang_timeout)
 {
     if (!blk) {
@@ -2588,6 +2664,7 @@ void blk_iohang_init(BlockBackend *blk, int64_t iohang_timeout)
     blk->iohang_status = BLOCK_IO_HANG_STATUS_NORMAL;
     if (iohang_timeout > 0) {
         blk->iohang_timeout = iohang_timeout;
+        blk_rehandle_enable(blk);
     }
 }
 
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index bfebe3a960..375ae13b0b 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -268,6 +268,9 @@ const BdrvChild *blk_root(BlockBackend *blk);
 
 int blk_make_empty(BlockBackend *blk, Error **errp);
 
+void blk_rehandle_enable(BlockBackend *blk);
+void blk_rehandle_disable(BlockBackend *blk);
+bool blk_iohang_is_enabled(BlockBackend *blk);
 void blk_iohang_init(BlockBackend *blk, int64_t iohang_timeout);
 
 #endif
-- 
2.23.0


