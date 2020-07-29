Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4E9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379B120656
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="TS9+H+kM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379B120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0uNl-0007XJ-ET
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 18:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0uED-0007iU-Aw; Wed, 29 Jul 2020 18:07:13 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0uEA-00005o-UU; Wed, 29 Jul 2020 18:07:12 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id C145DBFD63;
 Wed, 29 Jul 2020 22:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596060408;
 bh=eNlataF+0J7DJqtc2N5ssxzGdukz9hyR6Q933SUCGV4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TS9+H+kMAUfTx7pBvfs8hiubYjAZaORVc8D+4yHjIXzd8e1Bm4sYe1WEsoe7jsB2G
 Os8HBlOT282lPZTSByhAXBsN/cvNC9ziayR3hAS7R5i8yW26FVW420oCSr1dLQtHpS
 0OD1qkQQ+wqoCARQXZUKh+L5dxFTVDSTXEcbk48UvaHuRk6mwC5eVudR5v9Lgod1J2
 6E2iSFaa/2SX9dAwNkoqnTiw4EyJ+A9YxcmNVo/cMmu2C7xn99T5MFrIxO2WsVZOqk
 VA66UAb4IOB2rSwR7nI7Hnfk18ZSy65rhB2staO0mn0Mxn3u1qfPjpXKVdBx0/vdWv
 DOc7yY2JHWeaw==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/16] hw/block/nvme: be consistent about zeros vs zeroes
Date: Thu, 30 Jul 2020 00:06:34 +0200
Message-Id: <20200729220638.344477-13-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729220638.344477-1-its@irrelevant.dk>
References: <20200729220638.344477-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 14:23:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

The NVM Express specification generally uses 'zeroes' and not 'zeros',
so let us align with it.

Cc: Fam Zheng <fam@euphon.net>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/nvme.c         | 4 ++--
 hw/block/nvme.c      | 8 ++++----
 include/block/nvme.h | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index c1c4c07ac6cc..05485fdd1189 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -537,7 +537,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
                           s->page_size / sizeof(uint64_t) * s->page_size);
 
     oncs = le16_to_cpu(idctrl->oncs);
-    s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROS);
+    s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROES);
     s->supports_discard = !!(oncs & NVME_ONCS_DSM);
 
     memset(resp, 0, 4096);
@@ -1201,7 +1201,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     }
 
     NvmeCmd cmd = {
-        .opcode = NVME_CMD_WRITE_ZEROS,
+        .opcode = NVME_CMD_WRITE_ZEROES,
         .nsid = cpu_to_le32(s->nsid),
         .cdw10 = cpu_to_le32((offset >> s->blkshift) & 0xFFFFFFFF),
         .cdw11 = cpu_to_le32(((offset >> s->blkshift) >> 32) & 0xFFFFFFFF),
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 60034ea62ca8..2acde838986c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -616,7 +616,7 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     return NVME_NO_COMPLETE;
 }
 
-static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
+static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
@@ -716,8 +716,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
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
@@ -2337,7 +2337,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->sqes = (0x6 << 4) | 0x6;
     id->cqes = (0x4 << 4) | 0x4;
     id->nn = cpu_to_le32(n->num_namespaces);
-    id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROS | NVME_ONCS_TIMESTAMP |
+    id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES);
 
     subnqn = g_strdup_printf("nqn.2019-08.org.qemu:%s", n->params.serial);
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 370df7fc0570..65e68a82c897 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -460,7 +460,7 @@ enum NvmeIoCommands {
     NVME_CMD_READ               = 0x02,
     NVME_CMD_WRITE_UNCOR        = 0x04,
     NVME_CMD_COMPARE            = 0x05,
-    NVME_CMD_WRITE_ZEROS        = 0x08,
+    NVME_CMD_WRITE_ZEROES       = 0x08,
     NVME_CMD_DSM                = 0x09,
 };
 
@@ -838,7 +838,7 @@ enum NvmeIdCtrlOncs {
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


