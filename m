Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176C8C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB2E2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB2E2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYmj-0004gU-Mp
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 05:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kNYhR-00072z-W0
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:47:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38748 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kNYhM-0003oQ-TJ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:47:01 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 1AF423D944E5AF00A8BE;
 Wed, 30 Sep 2020 17:46:54 +0800 (CST)
Received: from localhost (10.174.186.107) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 17:46:43 +0800
From: Jiahui Cen <cenjiahui@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC PATCH v2 3/8] block-backend: add I/O hang timeout
Date: Wed, 30 Sep 2020 17:46:01 +0800
Message-ID: <20200930094606.5323-4-cenjiahui@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200930094606.5323-1-cenjiahui@huawei.com>
References: <20200930094606.5323-1-cenjiahui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.107]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=cenjiahui@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 05:46:49
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

Not all errors would be fixed, so it is better to add a rehandle timeout
for I/O hang.

Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 block/block-backend.c          | 99 +++++++++++++++++++++++++++++++++-
 include/sysemu/block-backend.h |  2 +
 2 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 8050669d23..90fcc678b5 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -38,6 +38,11 @@ static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb);
 /* block backend rehandle timer interval 5s */
 #define BLOCK_BACKEND_REHANDLE_TIMER_INTERVAL   5000
 
+enum BlockIOHangStatus {
+    BLOCK_IO_HANG_STATUS_NORMAL = 0,
+    BLOCK_IO_HANG_STATUS_HANG,
+};
+
 typedef struct BlockBackendRehandleInfo {
     bool enable;
     QEMUTimer *ts;
@@ -109,6 +114,11 @@ struct BlockBackend {
     unsigned int in_flight;
 
     BlockBackendRehandleInfo reinfo;
+
+    int64_t iohang_timeout; /* The I/O hang timeout value in sec. */
+    int64_t iohang_time;    /* The I/O hang start time */
+    bool is_iohang_timeout;
+    int iohang_status;
 };
 
 typedef struct BlockBackendAIOCB {
@@ -2481,20 +2491,107 @@ static void blk_rehandle_timer_cb(void *opaque)
     aio_context_release(blk_get_aio_context(blk));
 }
 
+static bool blk_iohang_handle(BlockBackend *blk, int new_status)
+{
+    int64_t now;
+    int old_status = blk->iohang_status;
+    bool need_rehandle = false;
+
+    switch (new_status) {
+    case BLOCK_IO_HANG_STATUS_NORMAL:
+        if (old_status == BLOCK_IO_HANG_STATUS_HANG) {
+            /* Case when I/O Hang is recovered */
+            blk->is_iohang_timeout = false;
+            blk->iohang_time = 0;
+        }
+        break;
+    case BLOCK_IO_HANG_STATUS_HANG:
+        if (old_status != BLOCK_IO_HANG_STATUS_HANG) {
+            /* Case when I/O hang is first triggered */
+            blk->iohang_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
+            need_rehandle = true;
+        } else {
+            if (!blk->is_iohang_timeout) {
+                now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
+                if (now >= (blk->iohang_time + blk->iohang_timeout)) {
+                    /* Case when I/O hang is timeout */
+                    blk->is_iohang_timeout = true;
+                } else {
+                    /* Case when I/O hang is continued */
+                    need_rehandle = true;
+                }
+            }
+        }
+        break;
+    default:
+        break;
+    }
+
+    blk->iohang_status = new_status;
+    return need_rehandle;
+}
+
+static bool blk_rehandle_aio(BlkAioEmAIOCB *acb, bool *has_timeout)
+{
+    bool need_rehandle = false;
+
+    /* Rehandle aio which returns EIO before hang timeout */
+    if (acb->rwco.ret == -EIO) {
+        if (acb->rwco.blk->is_iohang_timeout) {
+            /* I/O hang has timeout and not recovered */
+            *has_timeout = true;
+        } else {
+            need_rehandle = blk_iohang_handle(acb->rwco.blk,
+                                              BLOCK_IO_HANG_STATUS_HANG);
+            /* I/O hang timeout first trigger */
+            if (acb->rwco.blk->is_iohang_timeout) {
+                *has_timeout = true;
+            }
+        }
+    }
+
+    return need_rehandle;
+}
+
 static void blk_rehandle_aio_complete(BlkAioEmAIOCB *acb)
 {
+    bool has_timeout = false;
+    bool need_rehandle = false;
+
     if (acb->has_returned) {
         blk_dec_in_flight(acb->rwco.blk);
-        if (acb->rwco.ret == -EIO) {
+        need_rehandle = blk_rehandle_aio(acb, &has_timeout);
+        if (need_rehandle) {
             blk_rehandle_insert_aiocb(acb->rwco.blk, acb);
             return;
         }
 
         acb->common.cb(acb->common.opaque, acb->rwco.ret);
+
+        /* I/O hang return to normal status */
+        if (!has_timeout) {
+            blk_iohang_handle(acb->rwco.blk, BLOCK_IO_HANG_STATUS_NORMAL);
+        }
+
         qemu_aio_unref(acb);
     }
 }
 
+void blk_iohang_init(BlockBackend *blk, int64_t iohang_timeout)
+{
+    if (!blk) {
+        return;
+    }
+
+    blk->is_iohang_timeout = false;
+    blk->iohang_time = 0;
+    blk->iohang_timeout = 0;
+    blk->iohang_status = BLOCK_IO_HANG_STATUS_NORMAL;
+    if (iohang_timeout > 0) {
+        blk->iohang_timeout = iohang_timeout;
+    }
+}
+
 void blk_register_buf(BlockBackend *blk, void *host, size_t size)
 {
     bdrv_register_buf(blk_bs(blk), host, size);
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 8203d7f6f9..bfebe3a960 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -268,4 +268,6 @@ const BdrvChild *blk_root(BlockBackend *blk);
 
 int blk_make_empty(BlockBackend *blk, Error **errp);
 
+void blk_iohang_init(BlockBackend *blk, int64_t iohang_timeout);
+
 #endif
-- 
2.28.0


