Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD16C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957F42075D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="uOuLH4om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957F42075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0uIF-0005dM-SM
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 18:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0uEE-0007mA-R7; Wed, 29 Jul 2020 18:07:14 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34814)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0uEB-00006F-OZ; Wed, 29 Jul 2020 18:07:14 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 0AB80BFD95;
 Wed, 29 Jul 2020 22:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596060409;
 bh=f4o65hK/qlwKgqBdl9qivIMOxb6C9aGrDxihNb44Vy4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uOuLH4om9f+1lpOXSWXUSEadXObVPlM2thun9dAgzKUJ5SmdlUrF/0LPbrx2bPeuW
 isKFgCHhQNPegx5AzCxGXpsMxvQ1LPJ+X5/mBK8DYMYC5dC/r2Is4P5/6UnoNhQcCW
 uvDkeR8T89+pdmgoUZH9o/u55TjS2PiBEF8CFwFJLv9m2PargmhYT6fDk5pppflwZA
 QK2f/UhCPmsg4aP0ZT6HzP1rsG1D7zuv7vpxLNtcXR/h7bCHxcaU8J9JIZE0hQG9tK
 v5BiOjEw/irXKskbnMUt6R4b/NkBcXrBpZhOszswl0uHrZ/+nU6d7QtY1mP8pcrSv1
 i1bA75okAynWg==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/16] hw/block/nvme: use preallocated qsg/iov in
 nvme_dma_prp
Date: Thu, 30 Jul 2020 00:06:37 +0200
Message-Id: <20200729220638.344477-16-its@irrelevant.dk>
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

Since clean up of the request qsg/iov is now always done post-use, there
is no need to use a stack-allocated qsg/iov in nvme_dma_prp.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 045dd55376a5..55b1a68ced8c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -381,50 +381,45 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
 }
 
 static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
-                             uint64_t prp1, uint64_t prp2, DMADirection dir)
+                             uint64_t prp1, uint64_t prp2, DMADirection dir,
+                             NvmeRequest *req)
 {
-    QEMUSGList qsg;
-    QEMUIOVector iov;
     uint16_t status = NVME_SUCCESS;
 
-    status = nvme_map_prp(&qsg, &iov, prp1, prp2, len, n);
+    status = nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, len, n);
     if (status) {
         return status;
     }
 
     /* assert that only one of qsg and iov carries data */
-    assert((qsg.nsg > 0) != (iov.niov > 0));
+    assert((req->qsg.nsg > 0) != (req->iov.niov > 0));
 
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
@@ -893,7 +888,7 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
     }
 
     return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE);
+                        DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_fw_log_info(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
@@ -916,7 +911,7 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
     trans_len = MIN(sizeof(fw_log) - off, buf_len);
 
     return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE);
+                        DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
@@ -941,7 +936,7 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
     trans_len = MIN(sizeof(errlog) - off, buf_len);
 
     return nvme_dma_prp(n, (uint8_t *)&errlog, trans_len, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE);
+                        DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
@@ -1107,7 +1102,7 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
     trace_pci_nvme_identify_ctrl();
 
     return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl), prp1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE);
+                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
@@ -1128,7 +1123,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
     ns = &n->namespaces[nsid - 1];
 
     return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns), prp1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE);
+                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
@@ -1165,7 +1160,7 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
         }
     }
     ret = nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
-                       DMA_DIRECTION_FROM_DEVICE);
+                       DMA_DIRECTION_FROM_DEVICE, req);
     g_free(list);
     return ret;
 }
@@ -1208,7 +1203,7 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
     stl_be_p(&ns_descrs->uuid.v, nsid);
 
     return nvme_dma_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE);
+                        DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
@@ -1291,7 +1286,7 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
     uint64_t timestamp = nvme_get_timestamp(n);
 
     return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE);
+                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
@@ -1425,7 +1420,7 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
     uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
 
     ret = nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp1,
-                       prp2, DMA_DIRECTION_TO_DEVICE);
+                       prp2, DMA_DIRECTION_TO_DEVICE, req);
     if (ret != NVME_SUCCESS) {
         return ret;
     }
-- 
2.27.0


