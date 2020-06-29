Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C025AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:01:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7F720672
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7F720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpzy7-0000Bm-UX
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 16:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpznt-0007Xx-1f; Mon, 29 Jun 2020 15:50:57 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpznn-0005xj-7i; Mon, 29 Jun 2020 15:50:56 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 1E0DEBF80F;
 Mon, 29 Jun 2020 19:50:28 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 12/17] hw/block/nvme: refactor NvmeRequest clearing
Date: Mon, 29 Jun 2020 21:50:12 +0200
Message-Id: <20200629195017.1217056-13-its@irrelevant.dk>
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

Move clearing of the structure from "clear before use" to "clear after
use". Also, carry a reference to the namespace the (I/O) command is
acting on instead of passing it around explicitly.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c | 28 ++++++++++++++++------------
 hw/block/nvme.h |  1 +
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 12f1b6331c43..3d38f61b61e5 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -174,6 +174,12 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
     }
 }
 
+static void nvme_req_clear(NvmeRequest *req)
+{
+    req->ns = NULL;
+    memset(&req->cqe, 0x0, sizeof(req->cqe));
+}
+
 static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
                                   size_t len)
 {
@@ -423,6 +429,7 @@ static void nvme_post_cqes(void *opaque)
         nvme_inc_cq_tail(cq);
         pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
             sizeof(req->cqe));
+        nvme_req_clear(req);
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
     if (cq->tail != cq->head) {
@@ -569,8 +576,7 @@ static void nvme_rw_cb(void *opaque, int ret)
     nvme_enqueue_req_completion(cq, req);
 }
 
-static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_flush(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     block_acct_start(blk_get_stats(n->conf.blk), &req->acct, 0,
          BLOCK_ACCT_FLUSH);
@@ -579,10 +585,10 @@ static uint16_t nvme_flush(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     return NVME_NO_COMPLETE;
 }
 
-static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
+    NvmeNamespace *ns = req->ns;
     const uint8_t lba_index = NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas);
     const uint8_t data_shift = ns->id_ns.lbaf[lba_index].ds;
     uint64_t slba = le64_to_cpu(rw->slba);
@@ -606,10 +612,10 @@ static uint16_t nvme_write_zeroes(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     return NVME_NO_COMPLETE;
 }
 
-static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
-    NvmeRequest *req)
+static uint16_t nvme_rw(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
     NvmeRwCmd *rw = (NvmeRwCmd *)cmd;
+    NvmeNamespace *ns = req->ns;
     uint32_t nlb  = le32_to_cpu(rw->nlb) + 1;
     uint64_t slba = le64_to_cpu(rw->slba);
 
@@ -665,7 +671,6 @@ static uint16_t nvme_rw(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
 
 static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
-    NvmeNamespace *ns;
     uint32_t nsid = le32_to_cpu(cmd->nsid);
 
     trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req), cmd->opcode);
@@ -675,15 +680,15 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
         return NVME_INVALID_NSID | NVME_DNR;
     }
 
-    ns = &n->namespaces[nsid - 1];
+    req->ns = &n->namespaces[nsid - 1];
     switch (cmd->opcode) {
     case NVME_CMD_FLUSH:
-        return nvme_flush(n, ns, cmd, req);
+        return nvme_flush(n, cmd, req);
     case NVME_CMD_WRITE_ZEROES:
-        return nvme_write_zeroes(n, ns, cmd, req);
+        return nvme_write_zeroes(n, cmd, req);
     case NVME_CMD_WRITE:
     case NVME_CMD_READ:
-        return nvme_rw(n, ns, cmd, req);
+        return nvme_rw(n, cmd, req);
     default:
         trace_pci_nvme_err_invalid_opc(cmd->opcode);
         return NVME_INVALID_OPCODE | NVME_DNR;
@@ -1554,7 +1559,6 @@ static void nvme_process_sq(void *opaque)
         req = QTAILQ_FIRST(&sq->req_list);
         QTAILQ_REMOVE(&sq->req_list, req, entry);
         QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
-        memset(&req->cqe, 0, sizeof(req->cqe));
         req->cqe.cid = cmd.cid;
 
         status = sq->sqid ? nvme_io_cmd(n, &cmd, req) :
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index b5ce51c6e84b..6eaafd2e35f5 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -21,6 +21,7 @@ typedef struct NvmeAsyncEvent {
 
 typedef struct NvmeRequest {
     struct NvmeSQueue       *sq;
+    struct NvmeNamespace    *ns;
     BlockAIOCB              *aiocb;
     uint16_t                status;
     NvmeCqe                 cqe;
-- 
2.27.0


