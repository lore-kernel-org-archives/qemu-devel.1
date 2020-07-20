Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C4AC433E8
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB0F2176B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="tduMP90Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB0F2176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxUCk-0006iN-QQ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7P-0007JD-Rs; Mon, 20 Jul 2020 07:38:03 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7N-0005AI-9K; Mon, 20 Jul 2020 07:38:03 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 683E2BF884;
 Mon, 20 Jul 2020 11:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1595245078;
 bh=CG5jYze8UKz6sj/L8pBqPciLlyMJBuuwVX5Jupg9hDI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tduMP90Q+f7vp1jzb9nFASMNVJjK5YxQsyiMMp/7Yf5lpZxoh4QU1v/BgL/uXlsTe
 /w420/veFPDq0SUxtnx2euEqJxBO8uc65H7AuldWEnJUJZNFNCm4EDkfXlLmDmivKH
 cOtNEDAvHa9HJmeYGT9Iv0B1Ihakwwaf4qmMPm9JLIb8VATl7Ggrl5AYAabhbgx8+s
 dAjSmvq7J4XzHG9+vMD0FZmujRP8rdetF2rqE9UTtdd6netmcXJMgw1zj+t6Z2EI4+
 Blg0+Uck96upZV+w1oP5I0POCxYYu5AgmSDTN85J+c1sC+gehtW3LuIVrOW7Y09SQI
 5lvlPZTYRQaag==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/16] hw/block/nvme: refactor dma read/write
Date: Mon, 20 Jul 2020 13:37:37 +0200
Message-Id: <20200720113748.322965-6-its@irrelevant.dk>
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

Refactor the nvme_dma_{read,write}_prp functions into a common function
taking a DMADirection parameter.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 88 ++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 45 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 6a1a1626b87b..d314a604db81 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -361,55 +361,50 @@ unmap:
     return status;
 }
 
-static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
-                                   uint64_t prp1, uint64_t prp2)
+static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
+                             uint64_t prp1, uint64_t prp2, DMADirection dir)
 {
     QEMUSGList qsg;
     QEMUIOVector iov;
     uint16_t status = NVME_SUCCESS;
 
-    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
-        return NVME_INVALID_FIELD | NVME_DNR;
+    status = nvme_map_prp(&qsg, &iov, prp1, prp2, len, n);
+    if (status) {
+        return status;
     }
+
     if (qsg.nsg > 0) {
-        if (dma_buf_write(ptr, len, &qsg)) {
-            status = NVME_INVALID_FIELD | NVME_DNR;
+        uint64_t residual;
+
+        if (dir == DMA_DIRECTION_TO_DEVICE) {
+            residual = dma_buf_write(ptr, len, &qsg);
+        } else {
+            residual = dma_buf_read(ptr, len, &qsg);
         }
-        qemu_sglist_destroy(&qsg);
-    } else {
-        if (qemu_iovec_to_buf(&iov, 0, ptr, len) != len) {
-            status = NVME_INVALID_FIELD | NVME_DNR;
-        }
-        qemu_iovec_destroy(&iov);
-    }
-    return status;
-}
 
-static uint16_t nvme_dma_read_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
-    uint64_t prp1, uint64_t prp2)
-{
-    QEMUSGList qsg;
-    QEMUIOVector iov;
-    uint16_t status = NVME_SUCCESS;
-
-    trace_pci_nvme_dma_read(prp1, prp2);
-
-    if (nvme_map_prp(&qsg, &iov, prp1, prp2, len, n)) {
-        return NVME_INVALID_FIELD | NVME_DNR;
-    }
-    if (qsg.nsg > 0) {
-        if (unlikely(dma_buf_read(ptr, len, &qsg))) {
+        if (unlikely(residual)) {
             trace_pci_nvme_err_invalid_dma();
             status = NVME_INVALID_FIELD | NVME_DNR;
         }
+
         qemu_sglist_destroy(&qsg);
     } else {
-        if (unlikely(qemu_iovec_from_buf(&iov, 0, ptr, len) != len)) {
+        size_t bytes;
+
+        if (dir == DMA_DIRECTION_TO_DEVICE) {
+            bytes = qemu_iovec_to_buf(&iov, 0, ptr, len);
+        } else {
+            bytes = qemu_iovec_from_buf(&iov, 0, ptr, len);
+        }
+
+        if (unlikely(bytes != len)) {
             trace_pci_nvme_err_invalid_dma();
             status = NVME_INVALID_FIELD | NVME_DNR;
         }
+
         qemu_iovec_destroy(&iov);
     }
+
     return status;
 }
 
@@ -840,8 +835,8 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
         nvme_clear_events(n, NVME_AER_TYPE_SMART);
     }
 
-    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
-                             prp2);
+    return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1, prp2,
+                        DMA_DIRECTION_FROM_DEVICE);
 }
 
 static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
@@ -862,8 +857,8 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
 
     trans_len = MIN(sizeof(fw_log) - off, buf_len);
 
-    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1,
-                             prp2);
+    return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1, prp2,
+                        DMA_DIRECTION_FROM_DEVICE);
 }
 
 static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
@@ -887,7 +882,8 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
 
     trans_len = MIN(sizeof(errlog) - off, buf_len);
 
-    return nvme_dma_read_prp(n, (uint8_t *)&errlog, trans_len, prp1, prp2);
+    return nvme_dma_prp(n, (uint8_t *)&errlog, trans_len, prp1, prp2,
+                        DMA_DIRECTION_FROM_DEVICE);
 }
 
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
@@ -1042,8 +1038,8 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
 
     trace_pci_nvme_identify_ctrl();
 
-    return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
-        prp1, prp2);
+    return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl), prp1,
+                        prp2, DMA_DIRECTION_FROM_DEVICE);
 }
 
 static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
@@ -1062,8 +1058,8 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
 
     ns = &n->namespaces[nsid - 1];
 
-    return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
-        prp1, prp2);
+    return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns), prp1,
+                        prp2, DMA_DIRECTION_FROM_DEVICE);
 }
 
 static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
@@ -1098,7 +1094,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
             break;
         }
     }
-    ret = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
+    ret = nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
+                       DMA_DIRECTION_FROM_DEVICE);
     g_free(list);
     return ret;
 }
@@ -1139,7 +1136,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c)
     ns_descrs->uuid.hdr.nidl = NVME_NIDT_UUID_LEN;
     stl_be_p(&ns_descrs->uuid.v, nsid);
 
-    return nvme_dma_read_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp2);
+    return nvme_dma_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp2,
+                        DMA_DIRECTION_FROM_DEVICE);
 }
 
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
@@ -1220,8 +1218,8 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
 
     uint64_t timestamp = nvme_get_timestamp(n);
 
-    return nvme_dma_read_prp(n, (uint8_t *)&timestamp,
-                                 sizeof(timestamp), prp1, prp2);
+    return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp1,
+                        prp2, DMA_DIRECTION_FROM_DEVICE);
 }
 
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
@@ -1352,8 +1350,8 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
     uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
 
-    ret = nvme_dma_write_prp(n, (uint8_t *)&timestamp,
-                                sizeof(timestamp), prp1, prp2);
+    ret = nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp1,
+                       prp2, DMA_DIRECTION_TO_DEVICE);
     if (ret != NVME_SUCCESS) {
         return ret;
     }
-- 
2.27.0


