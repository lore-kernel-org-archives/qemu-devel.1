Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7354FC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315DA2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="i6kS1BfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315DA2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxUGg-0004hw-Et
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7n-00088c-Q4; Mon, 20 Jul 2020 07:38:27 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7k-0005C5-Tw; Mon, 20 Jul 2020 07:38:27 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id DAF42BF879;
 Mon, 20 Jul 2020 11:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1595245083;
 bh=ZzwIwEB1onnnuVBtIrVFoKxvAtkcUE+BLu5yUMskFPM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i6kS1BfE/RTc8g+Eprs3MJNsG9DdoArRZWHSCFVxSgs+i80patfVCGBxjzVFidz9n
 U2wyQBMvn5hDaLPeGFraNQko1yP6CaMeFm2XK1WvndtkekfTCBiizGG3+a+vG+ZQWq
 +LcmKmOS+SksWOoPPVoFJHp7RMLF1bhw3ahz5i+u6aDbOTF6A2exkkmpG3EcEsf6Ac
 wgartrdoHsqjtFa9BqnIqV2/0g482dz1UVJtFG3tLUAB/yy3yRoCaK1+niJdKJ4xo6
 cXczlBcfSyPx4jazldhNSyOouNNPCOQ3wLt1PUGvM9LWZXV3UyrnAjmHHwCKFnWEhn
 fFOyJMBBwdmwg==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/16] hw/block/nvme: remove NvmeCmd parameter
Date: Mon, 20 Jul 2020 13:37:47 +0200
Message-Id: <20200720113748.322965-16-its@irrelevant.dk>
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
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Keep a copy of the raw nvme command in the NvmeRequest and remove the
now redundant NvmeCmd parameter.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 177 +++++++++++++++++++++++++-----------------------
 hw/block/nvme.h |   1 +
 2 files changed, 93 insertions(+), 85 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index b53afdeb3fb6..0b3dceccc89b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -425,9 +425,9 @@ static uint16_t nvme_dma_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
     return status;
 }
 
-static uint16_t nvme_map(NvmeCtrl *n, NvmeCmd *cmd, size_t len,
-                         NvmeRequest *req)
+static uint16_t nvme_map(NvmeCtrl *n, size_t len, NvmeRequest *req)
 {
+    NvmeCmd *cmd = &req->cmd;
     uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
 
@@ -597,7 +597,7 @@ static void nvme_rw_cb(void *opaque, int ret)
     nvme_enqueue_req_completion(cq, req);
 }
 
-static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_flush(NvmeCtrl *n, NvmeRequest *req)
 {
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
          BLOCK_ACCT_FLUSH);
@@ -606,9 +606,9 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
 
-static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
+    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
     const uint8_t lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
     const uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
@@ -633,9 +633,9 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
 
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_rw(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
+    NvmeRwCmd *rw = (NvmeRwCmd *)&req->cmd;
     NvmeNamespace *ns = req->ns;
     uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
     uint64_t slba = le64_to_cpu(rw->slba);
@@ -664,7 +664,7 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         return status;
     }
 
-    if (nvme_map(n, cmd, data_size, req)) {
+    if (nvme_map(n, data_size, req)) {
         block_acct_invalid(blk_get_stats(n->conf.blk), acct);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -690,11 +690,12 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
 
-static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
-    uint32_t nsid = le32_to_cpu(cmd->nsid);
+    uint32_t nsid = le32_to_cpu(req->cmd.nsid);
 
-    trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req), cmd->opcode);
+    trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req),
+                          req->cmd.opcode);
 
     if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
         trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
@@ -702,16 +703,16 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     }
 
     req->ns = &n->namespaces[nsid - 1];
-    switch (cmd->opcode) {
+    switch (req->cmd.opcode) {
     case NVME_CMD_FLUSH:
-        return nvme_flush(n, cmd, req);
+        return nvme_flush(n, req);
     case NVME_CMD_WRITE_ZEROES:
-        return nvme_write_zeroes(n, cmd, req);
+        return nvme_write_zeroes(n, req);
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
-        return nvme_rw(n, cmd, req);
+        return nvme_rw(n, req);
     default:
-        trace_pci_nvme_err_invalid_opc(cmd->opcode);
+        trace_pci_nvme_err_invalid_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -727,10 +728,10 @@ static void nvme_free_sq(NvmeSQueue *sq, NvmeCtrl *n)
     }
 }
 
-static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeDeleteQ *c = (NvmeDeleteQ *)cmd;
-    NvmeRequest *req, *next;
+    NvmeDeleteQ *c = (NvmeDeleteQ *)&req->cmd;
+    NvmeRequest *r, *next;
     NvmeSQueue *sq;
     NvmeCQueue *cq;
     uint16_t qid = le16_to_cpu(c->qid);
@@ -744,19 +745,19 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeCmd *cmd)
 
     sq = n->sq[qid];
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
-        req = QTAILQ_FIRST(&sq->out_req_list);
-        assert(req->aiocb);
-        blk_aio_cancel(req->aiocb);
+        r = QTAILQ_FIRST(&sq->out_req_list);
+        assert(r->aiocb);
+        blk_aio_cancel(r->aiocb);
     }
     if (!nvme_check_cqid(n, sq->cqid)) {
         cq = n->cq[sq->cqid];
         QTAILQ_REMOVE(&cq->sq_list, sq, entry);
 
         nvme_post_cqes(cq);
-        QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
-            if (req->sq == sq) {
-                QTAILQ_REMOVE(&cq->req_list, req, entry);
-                QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
+        QTAILQ_FOREACH_SAFE(r, &cq->req_list, entry, next) {
+            if (r->sq == sq) {
+                QTAILQ_REMOVE(&cq->req_list, r, entry);
+                QTAILQ_INSERT_TAIL(&sq->req_list, r, entry);
             }
         }
     }
@@ -793,10 +794,10 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
     n->sq[sqid] = sq;
 }
 
-static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeSQueue *sq;
-    NvmeCreateSq *c = (NvmeCreateSq *)cmd;
+    NvmeCreateSq *c = (NvmeCreateSq *)&req->cmd;
 
     uint16_t cqid = le16_to_cpu(c->cqid);
     uint16_t sqid = le16_to_cpu(c->sqid);
@@ -831,10 +832,10 @@ static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeCmd *cmd)
     return NVME_SUCCESS;
 }
 
-static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
-                                uint32_t buf_len, uint64_t off,
-                                NvmeRequest *req)
+static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
+                                uint64_t off, NvmeRequest *req)
 {
+    NvmeCmd *cmd = &req->cmd;
     uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
     uint32_t nsid = le32_to_cpu(cmd->nsid);
@@ -889,10 +890,11 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
                         DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
-                                 uint64_t off, NvmeRequest *req)
+static uint16_t nvme_fw_log_info(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
+                                 NvmeRequest *req)
 {
     uint32_t trans_len;
+    NvmeCmd *cmd = &req->cmd;
     uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
     NvmeFwSlotInfoLog fw_log = {
@@ -911,11 +913,11 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, NvmeCmd *cmd, uint32_t buf_len,
                         DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
-                                uint32_t buf_len, uint64_t off,
-                                NvmeRequest *req)
+static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
+                                uint64_t off, NvmeRequest *req)
 {
     uint32_t trans_len;
+    NvmeCmd *cmd = &req->cmd;
     uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
     NvmeErrorLog errlog;
@@ -936,8 +938,10 @@ static uint16_t nvme_error_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
                         DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_get_log(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeCmd *cmd = &req->cmd;
+
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
     uint32_t dw11 = le32_to_cpu(cmd->cdw11);
     uint32_t dw12 = le32_to_cpu(cmd->cdw12);
@@ -972,11 +976,11 @@ static uint16_t nvme_get_log(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 
     switch (lid) {
     case NVME_LOG_ERROR_INFO:
-        return nvme_error_info(n, cmd, rae, len, off, req);
+        return nvme_error_info(n, rae, len, off, req);
     case NVME_LOG_SMART_INFO:
-        return nvme_smart_info(n, cmd, rae, len, off, req);
+        return nvme_smart_info(n, rae, len, off, req);
     case NVME_LOG_FW_SLOT_INFO:
-        return nvme_fw_log_info(n, cmd, len, off, req);
+        return nvme_fw_log_info(n, len, off, req);
     default:
         trace_pci_nvme_err_invalid_log_page(nvme_cid(req), lid);
         return NVME_INVALID_FIELD | NVME_DNR;
@@ -994,9 +998,9 @@ static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
     }
 }
 
-static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_del_cq(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeDeleteQ *c = (NvmeDeleteQ *)cmd;
+    NvmeDeleteQ *c = (NvmeDeleteQ *)&req->cmd;
     NvmeCQueue *cq;
     uint16_t qid = le16_to_cpu(c->qid);
 
@@ -1037,10 +1041,10 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
     cq->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, nvme_post_cqes, cq);
 }
 
-static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
+static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeCQueue *cq;
-    NvmeCreateCq *c = (NvmeCreateCq *)cmd;
+    NvmeCreateCq *c = (NvmeCreateCq *)&req->cmd;
     uint16_t cqid = le16_to_cpu(c->cqid);
     uint16_t vector = le16_to_cpu(c->irq_vector);
     uint16_t qsize = le16_to_cpu(c->qsize);
@@ -1088,9 +1092,9 @@ static uint16_t nvme_create_cq(NvmeCtrl *n, NvmeCmd *cmd)
     return NVME_SUCCESS;
 }
 
-static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
-                                   NvmeRequest *req)
+static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     uint64_t prp1 = le64_to_cpu(c->prp1);
     uint64_t prp2 = le64_to_cpu(c->prp2);
 
@@ -1100,10 +1104,10 @@ static uint16_t nvme_identify_ctrl(NvmeCtrl *n, NvmeIdentify *c,
                         prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
-                                 NvmeRequest *req)
+static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     uint32_t nsid = le32_to_cpu(c->nsid);
     uint64_t prp1 = le64_to_cpu(c->prp1);
     uint64_t prp2 = le64_to_cpu(c->prp2);
@@ -1121,9 +1125,9 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIdentify *c,
                         prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c,
-                                     NvmeRequest *req)
+static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     static const int data_len = NVME_IDENTIFY_DATA_SIZE;
     uint32_t min_nsid = le32_to_cpu(c->nsid);
     uint64_t prp1 = le64_to_cpu(c->prp1);
@@ -1160,9 +1164,9 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c,
     return ret;
 }
 
-static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c,
-                                            NvmeRequest *req)
+static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
     uint32_t nsid = le32_to_cpu(c->nsid);
     uint64_t prp1 = le64_to_cpu(c->prp1);
     uint64_t prp2 = le64_to_cpu(c->prp2);
@@ -1201,28 +1205,28 @@ static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c,
                         DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeIdentify *c = (NvmeIdentify *)cmd;
+    NvmeIdentify *c = (NvmeIdentify *)&req->cmd;
 
     switch (le32_to_cpu(c->cns)) {
     case NVME_ID_CNS_NS:
-        return nvme_identify_ns(n, c, req);
+        return nvme_identify_ns(n, req);
     case NVME_ID_CNS_CTRL:
-        return nvme_identify_ctrl(n, c, req);
+        return nvme_identify_ctrl(n, req);
     case NVME_ID_CNS_NS_ACTIVE_LIST:
-        return nvme_identify_nslist(n, c, req);
+        return nvme_identify_nslist(n, req);
     case NVME_ID_CNS_NS_DESCR_LIST:
-        return nvme_identify_ns_descr_list(n, c, req);
+        return nvme_identify_ns_descr_list(n, req);
     default:
         trace_pci_nvme_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 }
 
-static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)
 {
-    uint16_t sqid = le32_to_cpu(cmd->cdw10) & 0xffff;
+    uint16_t sqid = le32_to_cpu(req->cmd.cdw10) & 0xffff;
 
     req->cqe.result = 1;
     if (nvme_check_sqid(n, sqid)) {
@@ -1272,9 +1276,9 @@ static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
     return cpu_to_le64(ts.all);
 }
 
-static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
-                                           NvmeRequest *req)
+static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeCmd *cmd = &req->cmd;
     uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
 
@@ -1284,8 +1288,9 @@ static uint16_t nvme_get_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
                         prp2, DMA_DIRECTION_FROM_DEVICE, req);
 }
 
-static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeCmd *cmd = &req->cmd;
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
     uint32_t dw11 = le32_to_cpu(cmd->cdw11);
     uint32_t nsid = le32_to_cpu(cmd->nsid);
@@ -1359,7 +1364,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         result = n->features.async_config;
         goto out;
     case NVME_TIMESTAMP:
-        return nvme_get_feature_timestamp(n, cmd, req);
+        return nvme_get_feature_timestamp(n, req);
     default:
         break;
     }
@@ -1405,11 +1410,11 @@ out:
     return NVME_SUCCESS;
 }
 
-static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
-                                           NvmeRequest *req)
+static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeRequest *req)
 {
     uint16_t ret;
     uint64_t timestamp;
+    NvmeCmd *cmd = &req->cmd;
     uint64_t prp1 = le64_to_cpu(cmd->dptr.prp1);
     uint64_t prp2 = le64_to_cpu(cmd->dptr.prp2);
 
@@ -1424,8 +1429,9 @@ static uint16_t nvme_set_feature_timestamp(NvmeCtrl *n, NvmeCmd *cmd,
     return NVME_SUCCESS;
 }
 
-static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeRequest *req)
 {
+    NvmeCmd *cmd = &req->cmd;
     uint32_t dw10 = le32_to_cpu(cmd->cdw10);
     uint32_t dw11 = le32_to_cpu(cmd->cdw11);
     uint32_t nsid = le32_to_cpu(cmd->nsid);
@@ -1516,14 +1522,14 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         n->features.async_config = dw11;
         break;
     case NVME_TIMESTAMP:
-        return nvme_set_feature_timestamp(n, cmd, req);
+        return nvme_set_feature_timestamp(n, req);
     default:
         return NVME_FEAT_NOT_CHANGEABLE | NVME_DNR;
     }
     return NVME_SUCCESS;
 }
 
-static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_aer(NvmeCtrl *n, NvmeRequest *req)
 {
     trace_pci_nvme_aer(nvme_cid(req));
 
@@ -1542,33 +1548,33 @@ static uint16_t nvme_aer(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
 
-static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
+static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
 {
-    trace_pci_nvme_admin_cmd(nvme_cid(req), nvme_sqid(req), cmd->opcode);
+    trace_pci_nvme_admin_cmd(nvme_cid(req), nvme_sqid(req), req->cmd.opcode);
 
-    switch (cmd->opcode) {
+    switch (req->cmd.opcode) {
     case NVME_ADM_CMD_DELETE_SQ:
-        return nvme_del_sq(n, cmd);
+        return nvme_del_sq(n, req);
     case NVME_ADM_CMD_CREATE_SQ:
-        return nvme_create_sq(n, cmd);
+        return nvme_create_sq(n, req);
     case NVME_ADM_CMD_GET_LOG_PAGE:
-        return nvme_get_log(n, cmd, req);
+        return nvme_get_log(n, req);
     case NVME_ADM_CMD_DELETE_CQ:
-        return nvme_del_cq(n, cmd);
+        return nvme_del_cq(n, req);
     case NVME_ADM_CMD_CREATE_CQ:
-        return nvme_create_cq(n, cmd);
+        return nvme_create_cq(n, req);
     case NVME_ADM_CMD_IDENTIFY:
-        return nvme_identify(n, cmd, req);
+        return nvme_identify(n, req);
     case NVME_ADM_CMD_ABORT:
-        return nvme_abort(n, cmd, req);
+        return nvme_abort(n, req);
     case NVME_ADM_CMD_SET_FEATURES:
-        return nvme_set_feature(n, cmd, req);
+        return nvme_set_feature(n, req);
     case NVME_ADM_CMD_GET_FEATURES:
-        return nvme_get_feature(n, cmd, req);
+        return nvme_get_feature(n, req);
     case NVME_ADM_CMD_ASYNC_EV_REQ:
-        return nvme_aer(n, cmd, req);
+        return nvme_aer(n, req);
     default:
-        trace_pci_nvme_err_invalid_admin_opc(cmd->opcode);
+        trace_pci_nvme_err_invalid_admin_opc(req->cmd.opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
     }
 }
@@ -1593,9 +1599,10 @@ static void nvme_process_sq(void *opaque)
         QTAILQ_REMOVE(&sq->req_list, req, entry);
         QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
         req->cqe.cid = cmd.cid;
+        memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
 
-        status = sq->sqid ? nvme_io_cmd(n, &cmd, req) :
-            nvme_admin_cmd(n, &cmd, req);
+        status = sq->sqid ? nvme_io_cmd(n, req) :
+            nvme_admin_cmd(n, req);
         if (status != NVME_NO_COMPLETE) {
             req->status = status;
             nvme_enqueue_req_completion(cq, req);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 586fd3d62700..52ba794f2e9a 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -25,6 +25,7 @@ typedef struct NvmeRequest {
     BlockAIOCB              *aiocb;
     uint16_t                status;
     NvmeCqe                 cqe;
+    NvmeCmd                 cmd;
     BlockAcctCookie         acct;
     QEMUSGList              qsg;
     QEMUIOVector            iov;
-- 
2.27.0


