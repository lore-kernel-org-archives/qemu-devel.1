Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED484C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7488206F1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7488206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpzsv-0008NE-29
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 15:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpznU-00076c-91; Mon, 29 Jun 2020 15:50:32 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpznS-0005wW-5i; Mon, 29 Jun 2020 15:50:31 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id C9E0FBF7F1;
 Mon, 29 Jun 2020 19:50:25 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 05/17] hw/block/nvme: refactor dma read/write
Date: Mon, 29 Jun 2020 21:50:05 +0200
Message-Id: <20200629195017.1217056-6-its@irrelevant.dk>
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

Refactor the nvme_dma_{read,write}_prp functions into a common function
taking a DMADirection parameter.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c | 88 ++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 45 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index ded78a2301a6..86d35547b752 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -326,55 +326,50 @@ unmap:
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
 
@@ -806,8 +801,8 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
         nvme_clear_events(n, NVME_AER_TYPE_SMART);
     }
 
-    return nvme_dma_read_prp(n, (uint8_t *) &smart + off, trans_len, prp1,
-                             prp2);
+    return nvme_dma_prp(n, (uint8_t *) &smart + off, trans_len, prp1, prp2,
+                        DMA_DIRECTION_FROM_DEVICE);
 }
 
 static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
@@ -828,8 +823,8 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
 
     trans_len = MIN(sizeof(fw_log) - off, buf_len);
 
-    return nvme_dma_read_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1,
-                             prp2);
+    return nvme_dma_prp(n, (uint8_t *) &fw_log + off, trans_len, prp1, prp2,
+                        DMA_DIRECTION_FROM_DEVICE);
 }
 
 static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
@@ -853,7 +848,8 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
 
     trans_len = MIN(sizeof(errlog) - off, buf_len);
 
-    return nvme_dma_read_prp(n, (uint8_t *)&errlog, trans_len, prp1, prp2);
+    return nvme_dma_prp(n, (uint8_t *)&errlog, trans_len, prp1, prp2,
+                        DMA_DIRECTION_FROM_DEVICE);
 }
 
 static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
@@ -1008,8 +1004,8 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c)
 
     trace_pci_nvme_identify_ctrl();
 
-    return nvme_dma_read_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl),
-        prp1, prp2);
+    return nvme_dma_prp(n, (uint8_t *)&n->id_ctrl, sizeof(n->id_ctrl), prp1,
+                        prp2, DMA_DIRECTION_FROM_DEVICE);
 }
 
 static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
@@ -1028,8 +1024,8 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c)
 
     ns = &n->namespaces[nsid - 1];
 
-    return nvme_dma_read_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns),
-        prp1, prp2);
+    return nvme_dma_prp(n, (uint8_t *)&ns->id_ns, sizeof(ns->id_ns), prp1,
+                        prp2, DMA_DIRECTION_FROM_DEVICE);
 }
 
 static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
@@ -1054,7 +1050,8 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
             break;
         }
     }
-    ret = nvme_dma_read_prp(n, (uint8_t *)list, data_len, prp1, prp2);
+    ret = nvme_dma_prp(n, (uint8_t *)list, data_len, prp1, prp2,
+                       DMA_DIRECTION_FROM_DEVICE);
     g_free(list);
     return ret;
 }
@@ -1095,7 +1092,8 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c)
     ns_descrs->uuid.hdr.nidl = NVME_NIDT_UUID_LEN;
     stl_be_p(&ns_descrs->uuid.v, nsid);
 
-    return nvme_dma_read_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp2);
+    return nvme_dma_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp2,
+                        DMA_DIRECTION_FROM_DEVICE);
 }
 
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
@@ -1176,8 +1174,8 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
 
     uint64_t timestamp = nvme_get_timestamp(n);
 
-    return nvme_dma_read_prp(n, (uint8_t *)&timestamp,
-                                 sizeof(timestamp), prp1, prp2);
+    return nvme_dma_prp(n, (uint8_t *)&timestamp, sizeof(timestamp), prp1,
+                        prp2, DMA_DIRECTION_FROM_DEVICE);
 }
 
 static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
@@ -1305,8 +1303,8 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd)
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


