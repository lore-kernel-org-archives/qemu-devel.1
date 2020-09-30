Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E750CC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 637B62075F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637B62075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYmh-0004e9-K4
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 05:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kNYhS-00073N-5I
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:47:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5156 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kNYhM-0003oG-Sn
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:47:01 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 36DBC4306B37C9C4DB62;
 Wed, 30 Sep 2020 17:46:53 +0800 (CST)
Received: from localhost (10.174.186.107) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 17:46:43 +0800
From: Jiahui Cen <cenjiahui@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC PATCH v2 4/8] block-backend: add I/O rehandle pause/unpause
Date: Wed, 30 Sep 2020 17:46:02 +0800
Message-ID: <20200930094606.5323-5-cenjiahui@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200930094606.5323-1-cenjiahui@huawei.com>
References: <20200930094606.5323-1-cenjiahui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.107]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=cenjiahui@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 05:46:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: kwolf@redhat.com, fangying1@huawei.com, cenjiahui@huawei.com,
 zhang.zhanghailiang@huawei.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sometimes there is no need to rehandle AIOs although I/O hang is enabled. For
example, when deleting a block backend, we have to wait AIO completed by calling
blk_drain(), but not care about the results. So a pause interface of I/O hang
is helpful to bypass the rehandle mechanism.

Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 block/block-backend.c          | 60 +++++++++++++++++++++++++++++++---
 include/sysemu/block-backend.h |  2 ++
 2 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 90fcc678b5..c16d95a2c9 100644
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
@@ -2461,6 +2466,51 @@ static void blk_rehandle_remove_aiocb(BlockBackend *blk, BlkAioEmAIOCB *acb)
     qatomic_dec(&blk->reinfo.in_flight);
 }
 
+static void blk_rehandle_drain(BlockBackend *blk)
+{
+    if (blk_bs(blk)) {
+        bdrv_drained_begin(blk_bs(blk));
+        BDRV_POLL_WHILE(blk_bs(blk), qatomic_read(&blk->reinfo.in_flight) > 0);
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
+void blk_rehandle_pause(BlockBackend *blk)
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
+void blk_rehandle_unpause(BlockBackend *blk)
+{
+    BlockBackendRehandleInfo *reinfo = &blk->reinfo;
+
+    aio_context_acquire(blk_get_aio_context(blk));
+    if (!reinfo->enable || reinfo->status == BLOCK_BACKEND_REHANDLE_NORMAL) {
+        aio_context_release(blk_get_aio_context(blk));
+        return;
+    }
+
+    reinfo->status = BLOCK_BACKEND_REHANDLE_NORMAL;
+    aio_context_release(blk_get_aio_context(blk));
+}
+
 static void blk_rehandle_timer_cb(void *opaque)
 {
     BlockBackend *blk = opaque;
@@ -2560,10 +2610,12 @@ static void blk_rehandle_aio_complete(BlkAioEmAIOCB *acb)
 
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
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index bfebe3a960..391a047444 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -268,6 +268,8 @@ const BdrvChild *blk_root(BlockBackend *blk);
 
 int blk_make_empty(BlockBackend *blk, Error **errp);
 
+void blk_rehandle_pause(BlockBackend *blk);
+void blk_rehandle_unpause(BlockBackend *blk);
 void blk_iohang_init(BlockBackend *blk, int64_t iohang_timeout);
 
 #endif
-- 
2.28.0


