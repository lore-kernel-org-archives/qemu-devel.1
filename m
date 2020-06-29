Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FBAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4012076C
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4012076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpzst-0008KH-UZ
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 15:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpznq-0007Ru-IY; Mon, 29 Jun 2020 15:50:54 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpznn-0005xi-7M; Mon, 29 Jun 2020 15:50:54 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id C1130BF80E;
 Mon, 29 Jun 2020 19:50:27 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 11/17] hw/block/nvme: be consistent about zeros vs zeroes
Date: Mon, 29 Jun 2020 21:50:11 +0200
Message-Id: <20200629195017.1217056-12-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629195017.1217056-1-its@irrelevant.dk>
References: <20200629195017.1217056-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 14:26:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

The NVM Express specification generally uses 'zeroes' and not 'zeros'.
It might very well be wrong, but let us align with it.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 block/nvme.c         | 4 ++--
 hw/block/nvme.c      | 8 ++++----
 include/block/nvme.h | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 29e90557c428..bee0878dec71 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -465,7 +465,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
                           s->page_size / sizeof(uint64_t) * s->page_size);
 
     oncs = le16_to_cpu(idctrl->oncs);
-    s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROS);
+    s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROES);
     s->supports_discard = !!(oncs & NVME_ONCS_DSM);
 
     memset(resp, 0, 4096);
@@ -1117,7 +1117,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     }
 
     NvmeCmd cmd = {
-        .opcode = NVME_CMD_WRITE_ZEROS,
+        .opcode = NVME_CMD_WRITE_ZEROES,
         .nsid = cpu_to_le32(s->nsid),
         .cdw10 = cpu_to_le32((offset >> s->blkshift) & 0xFFFFFFFF),
         .cdw11 = cpu_to_le32(((offset >> s->blkshift) >> 32) & 0xFFFFFFFF),
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d5dff6869b69..12f1b6331c43 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -579,7 +579,7 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     return NVME_NO_COMPLETE;
 }
 
-static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
+static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
@@ -679,8 +679,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     switch (cmd->opcode) {
     case NVME_CMD_FLUSH:
         return nvme_flush(n, ns, cmd, req);
-    case NVME_CMD_WRITE_ZEROS:
-        return nvme_write_zeros(n, ns, cmd, req);
+    case NVME_CMD_WRITE_ZEROES:
+        return nvme_write_zeroes(n, ns, cmd, req);
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
         return nvme_rw(n, ns, cmd, req);
@@ -2280,7 +2280,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->sqes = (0x6 << 4) | 0x6;
     id->cqes = (0x4 << 4) | 0x4;
     id->nn = cpu_to_le32(n->num_namespaces);
-    id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP |
+    id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES);
 
     pstrcpy((char *) id->subnqn, sizeof(id->subnqn), "nqn.2019-08.org.qemu:");
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 60833039a6c5..91456255ffa7 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -459,7 +459,7 @@ enum NvmeIoCommands {
     NVME_CMD_READ               = 0x02,
     NVME_CMD_WRITE_UNCOR        = 0x04,
     NVME_CMD_COMPARE            = 0x05,
-    NVME_CMD_WRITE_ZEROS        = 0x08,
+    NVME_CMD_WRITE_ZEROES       = 0x08,
     NVME_CMD_DSM                = 0x09,
 };
 
@@ -837,7 +837,7 @@ enum NvmeIdCtrlOncs {
     NVME_ONCS_COMPARE       = 1 << 0,
     NVME_ONCS_WRITE_UNCORR  = 1 << 1,
     NVME_ONCS_DSM           = 1 << 2,
-    NVME_ONCS_WRITE_ZEROS   = 1 << 3,
+    NVME_ONCS_WRITE_ZEROES  = 1 << 3,
     NVME_ONCS_FEATURES      = 1 << 4,
     NVME_ONCS_RESRVATIONS   = 1 << 5,
     NVME_ONCS_TIMESTAMP     = 1 << 6,
-- 
2.27.0


