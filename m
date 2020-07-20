Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E439C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A60F22B4E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="YOJa8LCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A60F22B4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxU9H-0001IN-CS
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7Q-0007L3-Nc; Mon, 20 Jul 2020 07:38:04 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7N-0005AH-4z; Mon, 20 Jul 2020 07:38:04 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id DF458BFAA6;
 Mon, 20 Jul 2020 11:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1595245079;
 bh=c7x+4H1twJz6PCcSCzeVfJq1LM4kdnzM1dix40VnXTw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YOJa8LCzzDnByLBT++2V2Xy40cwyXMTtyfwFF+QQrVAB2CrW7n9vBBRhHdsZR3RkF
 zMdVLeFw4ylmYoci5FSboDUNpINR+NP5tpckHyplmXlxMXr0EkUFFZNnemhDe8dmH4
 k8DsoG0D6iyBV0YW8cl6ogz/AWTOexICflzhJIXDO/2I4hUWI4KJiIt9oUyrdNkC+u
 T0YR6B5SQBxTANbMtJ6B/aRhTTZDXIJI0ueRAhNWDYaLI+x10DXkdWwDZ/Lf9UUR3W
 gStb0ZWEWfTzQcCI16P01DU2pzDfr9ScM7qRw0RxKzgT561QvWJDg7CsWBShgYzUW4
 klPdDap/UEwGg==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/16] hw/block/nvme: pass request along for tracing
Date: Mon, 20 Jul 2020 13:37:38 +0200
Message-Id: <20200720113748.322965-7-its@irrelevant.dk>
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

Pass along the NvmeRequest in various functions since it is very useful
for tracing.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c       | 67 +++++++++++++++++++++++++------------------
 hw/block/trace-events |  1 +
 2 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d314a604db81..f1e04608804b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -264,14 +264,18 @@ static uint16_t nvme_map_addr(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
     return NVME_SUCCESS;
 }
 
-static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
-                             uint64_t prp2, uint32_t len, NvmeCtrl *n)
+static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
+                             uint64_t prp1, uint64_t prp2, uint32_t len,
+                             NvmeRequest *req)
 {
     hwaddr trans_len = n->page_size - (prp1 % n->page_size);
     trans_len = MIN(len, trans_len);
     int num_prps = (len >> n->page_bits) + 1;
     uint16_t status;
 
+    trace_pci_nvme_map_prp(nvme_cid(req), trans_len, len, prp1, prp2,
+                           num_prps);
+
     if (unlikely(!prp1)) {
         trace_pci_nvme_err_invalid_prp();
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -362,13 +366,14 @@ unmap:
 }
 
 static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
-                             uint64_t prp1, uint64_t prp2, DMADirection dir)
+                             uint64_t prp1, uint64_t prp2, DMADirection dir,
+                             NvmeRequest *req)
 {
     QEMUSGList qsg;
     QEMUIOVector iov;
     uint16_t status = NVME_SUCCESS;
 
-    status = nvme_map_prp(&qsg, &iov, prp1, prp2, len, n);
+    status = nvme_map_prp(n, &qsg, &iov, prp1, prp2, len, req);
     if (status) {
         return status;
     }
@@ -613,7 +618,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
         return NVME_LBA_RANGE | NVME_DNR;
     }
 
-    if (nvme_map_prp(&req->qsg, &req->iov, prp1, prp2, data_size, n)) {
+    if (nvme_map_prp(n, &req->qsg, &req->iov, prp1, prp2, data_size, req)) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -836,7 +841,7 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
     }
 
     return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE);
+                        DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
@@ -858,7 +863,7 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
     trans_len = MIN(sizeof(fw_log) - off, buf_len);
 
     return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE);
+                        DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
@@ -883,7 +888,7 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
     trans_len = MIN(sizeof(errlog) - off, buf_len);
 
     return nvme_dma_prp(n, (uint8_t *)&errlog, trans_len, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE);
+                        DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
@@ -1031,7 +1036,8 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
     return NVME_SUCCESS;
 }
 
-static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
+                                   NvmeRequest *req)
 {
     uint64_t prp1 = le64_to_cpu(c->prp1);
     uint64_t prp2 = le64_to_cpu(c->prp2);
@@ -1039,10 +1045,11 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
     trace_pci_nvme_identify_ctrl();
 
     return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl), prp1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE);
+                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
+                                 NvmeRequest *req)
 {
     NvmeNamespace *ns;
     uint32_t nsid = le32_to_cpu(c->nsid);
@@ -1059,10 +1066,11 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
     ns = &n->namespaces[nsid - 1];
 
     return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns), prp1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE);
+                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c,
+                                     NvmeRequest *req)
 {
     static const int data_len = NVME_IDENTIFY_DATA_SIZE;
     uint32_t min_nsid = le32_to_cpu(c->nsid);
@@ -1095,12 +1103,13 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
         }
     }
     ret = nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
-                       DMA_DIRECTION_FROM_DEVICE);
+                       DMA_DIRECTION_FROM_DEVICE, req);
     g_free(list);
     return ret;
 }
 
-static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c)
+static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c,
+                                            NvmeRequest *req)
 {
     uint32_t nsid = le32_to_cpu(c->nsid);
     uint64_t prp1 = le64_to_cpu(c->prp1);
@@ -1137,22 +1146,22 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c)
     stl_be_p(&ns_descrs->uuid.v, nsid);
 
     return nvme_dma_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp2,
-                        DMA_DIRECTION_FROM_DEVICE);
+                        DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     NvmeIdentify *c = (NvmeIdentify *)cmd;
 
     switch (le32_to_cpu(c->cns)) {
     case NVME_ID_CNS_NS:
-        return nvme_identify_ns(n, c);
+        return nvme_identify_ns(n, c, req);
     case NVME_ID_CNS_CTRL:
-        return nvme_identify_ctrl(n, c);
+        return nvme_identify_ctrl(n, c, req);
     case NVME_ID_CNS_NS_ACTIVE_LIST:
-        return nvme_identify_nslist(n, c);
+        return nvme_identify_nslist(n, c, req);
     case NVME_ID_CNS_NS_DESCR_LIST:
-        return nvme_identify_ns_descr_list(n, c);
+        return nvme_identify_ns_descr_list(n, c, req);
     default:
         trace_pci_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -1211,7 +1220,8 @@ static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
     return cpu_to_le64(ts.all);
 }
 
-static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
+                                           NvmeRequest *req)
 {
     uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
@@ -1219,7 +1229,7 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
     uint64_t timestamp = nvme_get_timestamp(n);
 
     return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp1,
-                        prp2, DMA_DIRECTION_FROM_DEVICE);
+                        prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
@@ -1297,7 +1307,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         result = n->features.async_config;
         goto out;
     case NVME_TIMESTAMP:
-        return nvme_get_feature_timestamp(n, cmd);
+        return nvme_get_feature_timestamp(n, cmd, req);
     default:
         break;
     }
@@ -1343,7 +1353,8 @@ out:
     return NVME_SUCCESS;
 }
 
-static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
+                                           NvmeRequest *req)
 {
     uint16_t ret;
     uint64_t timestamp;
@@ -1351,7 +1362,7 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
     uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
 
     ret = nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp1,
-                       prp2, DMA_DIRECTION_TO_DEVICE);
+                       prp2, DMA_DIRECTION_TO_DEVICE, req);
     if (ret != NVME_SUCCESS) {
         return ret;
     }
@@ -1453,7 +1464,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         n->features.async_config = dw11;
         break;
     case NVME_TIMESTAMP:
-        return nvme_set_feature_timestamp(n, cmd);
+        return nvme_set_feature_timestamp(n, cmd, req);
     default:
         return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
     }
@@ -1495,7 +1506,7 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     case NVME_ADM_CMD_CREATE_CQ:
         return nvme_create_cq(n, cmd);
     case NVME_ADM_CMD_IDENTIFY:
-        return nvme_identify(n, cmd);
+        return nvme_identify(n, cmd, req);
     case NVME_ADM_CMD_ABORT:
         return nvme_abort(n, cmd, req);
     case NVME_ADM_CMD_SET_FEATURES:
diff --git a/hw/block/trace-events b/hw/block/trace-events
index f3b2d004e078..6d0cd588c786 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -35,6 +35,7 @@ pci_nvme_irq_masked(void) "IRQ is masked"
 pci_nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
 pci_nvme_map_addr(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
 pci_nvme_map_addr_cmb(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
+pci_nvme_map_prp(uint16_t cid, uint64_t trans_len, uint32_t len, uint64_t prp1, uint64_t prp2, int num_prps) "cid %"PRIu16" trans_len %"PRIu64" len %"PRIu32" prp1 0x%"PRIx64" prp2 0x%"PRIx64" num_prps %d"
 pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8""
 pci_nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
-- 
2.27.0


