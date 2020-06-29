Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886CDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B6E206F1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B6E206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpzwA-0006O4-Lb
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 15:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpznr-0007Ub-To; Mon, 29 Jun 2020 15:50:55 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpznp-000608-L6; Mon, 29 Jun 2020 15:50:55 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 2CB11BF7EC;
 Mon, 29 Jun 2020 19:50:30 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 17/17] hw/block/nvme: use preallocated qsg/iov in nvme_dma_prp
Date: Mon, 29 Jun 2020 21:50:17 +0200
Message-Id: <20200629195017.1217056-18-its@irrelevant.dk>
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

Since clean up of the request qsg/iov is now always done post-use, there
is no need to use a stack-allocated qsg/iov in nvme_dma_prp.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ec08841f74b6..fa0f8e802d9b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -350,45 +350,39 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
                              uint64_t prp1, uint64_t prp2, DMADirection dir,
                              NvmeRequest *req)
 {
-    QEMUSGList qsg;
-    QEMUIOVector iov;
     uint16_t status = NVME_SUCCESS;
 
-    status = nvme_map_prp(n, &qsg, &iov, prp1, prp2, len, req);
+    status = nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, len, req);
     if (status) {
         return status;
     }
 
-    if (qsg.nsg > 0) {
+    if (req->qsg.nsg > 0) {
         uint64_t residual;
 
         if (dir == DMA_DIRECTION_TO_DEVICE) {
-            residual = dma_buf_write(ptr, len, &qsg);
+            residual = dma_buf_write(ptr, len, &req->qsg);
         } else {
-            residual = dma_buf_read(ptr, len, &qsg);
+            residual = dma_buf_read(ptr, len, &req->qsg);
         }
 
         if (unlikely(residual)) {
             trace_pci_nvme_err_invalid_dma();
             status = NVME_INVALID_FIELD | NVME_DNR;
         }
-
-        qemu_sglist_destroy(&qsg);
     } else {
         size_t bytes;
 
         if (dir == DMA_DIRECTION_TO_DEVICE) {
-            bytes = qemu_iovec_to_buf(&iov, 0, ptr, len);
+            bytes = qemu_iovec_to_buf(&req->iov, 0, ptr, len);
         } else {
-            bytes = qemu_iovec_from_buf(&iov, 0, ptr, len);
+            bytes = qemu_iovec_from_buf(&req->iov, 0, ptr, len);
         }
 
         if (unlikely(bytes != len)) {
             trace_pci_nvme_err_invalid_dma();
             status = NVME_INVALID_FIELD | NVME_DNR;
         }
-
-        qemu_iovec_destroy(&iov);
     }
 
     return status;
-- 
2.27.0


