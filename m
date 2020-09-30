Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E77C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:54:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E7F2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E7F2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYoL-0006Wh-Lf
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 05:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kNYhS-000743-SL
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:47:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5157 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kNYhN-0003oL-Ca
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:47:02 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0352F2C7253BBC742785;
 Wed, 30 Sep 2020 17:46:54 +0800 (CST)
Received: from localhost (10.174.186.107) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 17:46:44 +0800
From: Jiahui Cen <cenjiahui@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC PATCH v2 5/8] block-backend: enable I/O hang when timeout is set
Date: Wed, 30 Sep 2020 17:46:03 +0800
Message-ID: <20200930094606.5323-6-cenjiahui@huawei.com>
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

Setting a non-zero timeout of I/O hang indicates I/O hang is enabled for the
block backend. And when the block backend is going to be deleted, we should
disable I/O hang.

Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 block/block-backend.c          | 40 ++++++++++++++++++++++++++++++++++
 include/sysemu/block-backend.h |  1 +
 2 files changed, 41 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index c16d95a2c9..c812b3a9c7 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -34,6 +34,7 @@
 #define NOT_DONE 0x7fffffff /* used while emulated sync operation in progress */
 
 static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb);
+static void blk_rehandle_disable(BlockBackend *blk);
 
 /* block backend rehandle timer interval 5s */
 #define BLOCK_BACKEND_REHANDLE_TIMER_INTERVAL   5000
@@ -476,6 +477,8 @@ static void blk_delete(BlockBackend *blk)
     assert(!blk->refcnt);
     assert(!blk->name);
     assert(!blk->dev);
+    assert(qatomic_read(&blk->reinfo.in_flight) == 0);
+    blk_rehandle_disable(blk);
     if (blk->public.throttle_group_member.throttle_state) {
         blk_io_limits_disable(blk);
     }
@@ -2629,6 +2632,42 @@ static void blk_rehandle_aio_complete(BlkAioEmAIOCB *acb)
     }
 }
 
+static void blk_rehandle_enable(BlockBackend *blk)
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
+static void blk_rehandle_disable(BlockBackend *blk)
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
@@ -2641,6 +2680,7 @@ void blk_iohang_init(BlockBackend *blk, int64_t iohang_timeout)
     blk->iohang_status = BLOCK_IO_HANG_STATUS_NORMAL;
     if (iohang_timeout > 0) {
         blk->iohang_timeout = iohang_timeout;
+        blk_rehandle_enable(blk);
     }
 }
 
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 391a047444..851b90b99b 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -270,6 +270,7 @@ int blk_make_empty(BlockBackend *blk, Error **errp);
 
 void blk_rehandle_pause(BlockBackend *blk);
 void blk_rehandle_unpause(BlockBackend *blk);
+bool blk_iohang_is_enabled(BlockBackend *blk);
 void blk_iohang_init(BlockBackend *blk, int64_t iohang_timeout);
 
 #endif
-- 
2.28.0


