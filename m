Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0DDC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A362176B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="ReUC2jk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A362176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxUBT-00055g-LY
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7R-0007M5-7t; Mon, 20 Jul 2020 07:38:05 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7O-0005Al-AO; Mon, 20 Jul 2020 07:38:04 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 4E585BFAB3;
 Mon, 20 Jul 2020 11:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1595245079;
 bh=+tWOIeXB0ZO5Ihx+AnxRD0s9Xn4zPdaK6mml9KOBePY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ReUC2jk4agOh0Mp4OnMjL4i9sQnXcTrixD1gNvSFjDK8Uo3LE2aT16rZ16qzBi1VT
 xV0XUAKjc66UCycZgi1YQ4WLlmh5CdUyZVpXTDVMZNZicdTTdzTSxtu82dsVuiIkug
 Xf8uOrtQnpVDRe324u/TarOSXH728oINT0YvXmmFQ4UOo5+6m1L9cRD5CgAPQmCYb2
 EHJ52tBTC5vcLenktEDf8YzZJc3iYfEAe1SpEdsuQi7VgD/WeYol6JUQr9/9WzQLRE
 T/GJ5ye/hoctDTEno/hLmqhDiKgF7Eo4spNthHnUrsGl96CSuti2Swxy1rXisSOa5s
 gn2aojqgMqvzQ==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/16] hw/block/nvme: add request mapping helper
Date: Mon, 20 Jul 2020 13:37:39 +0200
Message-Id: <20200720113748.322965-8-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720113748.322965-1-its@irrelevant.dk>
References: <20200720113748.322965-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 07:37:55
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Introduce the nvme_map helper to remove some noise in the main nvme_rw
function.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f1e04608804b..68c33a11c144 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -413,6 +413,15 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
     return status;
 }
 
+static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, size_t len,
+                         NvmeRequest *req)
+{
+    uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
+    uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
+
+    return nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);
+}
+
 static void nvme_post_cqes(void *opaque)
 {
     NvmeCQueue *cq = opaque;
@@ -600,8 +609,6 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
     uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
     uint64_t slba = le64_to_cpu(rw->slba);
-    uint64_t prp1 = le64_to_cpu(rw->dptr.prp1);
-    uint64_t prp2 = le64_to_cpu(rw->dptr.prp2);
 
     uint8_t lba_index  = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
     uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
@@ -618,7 +625,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
         return NVME_LBA_RANGE | NVME_DNR;
     }
 
-    if (nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, data_size, req)) {
+    if (nvme_map(n, cmd, data_size, req)) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
-- 
2.27.0


