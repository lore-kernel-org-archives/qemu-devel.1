Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11631C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDBC320656
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 20:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBC320656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq0Jz-0006AJ-71
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 16:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq0H1-0003Qu-6Y; Mon, 29 Jun 2020 16:21:03 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jq0Gy-0002Ug-B2; Mon, 29 Jun 2020 16:21:02 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 35A70BF767;
 Mon, 29 Jun 2020 20:20:58 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 2/2] hw/block/nvme: handle dma errors
Date: Mon, 29 Jun 2020 22:20:53 +0200
Message-Id: <20200629202053.1223342-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629202053.1223342-1-its@irrelevant.dk>
References: <20200629202053.1223342-1-its@irrelevant.dk>
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

Handling DMA errors gracefully is required for the device to pass the
block/011 test ("disable PCI device while doing I/O") in the blktests
suite.

With this patch the device passes the test by retrying "critical"
transfers (posting of completion entries and processing of submission
queue entries).

If DMA errors occur at any other point in the execution of the command
(say, while mapping the PRPs), the command is aborted with a Data
Transfer Error status code.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/block/nvme.c       | 43 ++++++++++++++++++++++++++++++++-----------
 hw/block/trace-events |  2 ++
 include/block/nvme.h  |  2 +-
 3 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fa0f8e802d9b..94f5bf2a815f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -89,14 +89,14 @@ static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
     return addr >= low && addr < hi;
 }
 
-static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
+static int nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
     if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
         memcpy(buf, nvme_addr_to_cmb(n, addr), size);
-        return;
+        return 0;
     }
 
-    pci_dma_read(&n->parent_obj, addr, buf, size);
+    return pci_dma_read(&n->parent_obj, addr, buf, size);
 }
 
 static int nvme_check_sqid(NvmeCtrl *n, uint16_t sqid)
@@ -202,7 +202,7 @@ static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
     trace_pci_nvme_map_addr_cmb(addr, len);
 
     if (!nvme_addr_is_cmb(n, addr) || !nvme_addr_is_cmb(n, addr + len - 1)) {
-        return NVME_DATA_TRAS_ERROR;
+        return NVME_DATA_TRANSFER_ERROR;
     }
 
     qemu_iovec_add(iov, nvme_addr_to_cmb(n, addr), len);
@@ -257,6 +257,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
     int num_prps = (len >> n->page_bits) + 1;
     uint16_t status;
     bool prp_list_in_cmb = false;
+    int ret;
 
     trace_pci_nvme_map_prp(nvme_cid(req), trans_len, len, prp1, prp2,
                            num_prps);
@@ -295,7 +296,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
 
             nents = (len + n->page_size - 1) >> n->page_bits;
             prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
-            nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
+            ret = nvme_addr_read(n, prp2, (void *)prp_list, prp_trans);
+            if (ret) {
+                trace_pci_nvme_err_addr_read(prp2);
+                return NVME_DATA_TRANSFER_ERROR;
+            }
             while (len != 0) {
                 uint64_t prp_ent = le64_to_cpu(prp_list[i]);
 
@@ -312,8 +317,12 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
                     i = 0;
                     nents = (len + n->page_size - 1) >> n->page_bits;
                     prp_trans = MIN(n->max_prp_ents, nents) * sizeof(uint64_t);
-                    nvme_addr_read(n, prp_ent, (void *)prp_list,
-                        prp_trans);
+                    ret = nvme_addr_read(n, prp_ent, (void *)prp_list,
+                                         prp_trans);
+                    if (ret) {
+                        trace_pci_nvme_err_addr_read(prp_ent);
+                        return NVME_DATA_TRANSFER_ERROR;
+                    }
                     prp_ent = le64_to_cpu(prp_list[i]);
                 }
 
@@ -487,6 +496,7 @@ static void nvme_post_cqes(void *opaque)
     NvmeCQueue *cq = opaque;
     NvmeCtrl *n = cq->ctrl;
     NvmeRequest *req, *next;
+    int ret;
 
     QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
         NvmeSQueue *sq;
@@ -496,15 +506,21 @@ static void nvme_post_cqes(void *opaque)
             break;
         }
 
-        QTAILQ_REMOVE(&cq->req_list, req, entry);
         sq = req->sq;
         req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
         req->cqe.sq_id = cpu_to_le16(sq->sqid);
         req->cqe.sq_head = cpu_to_le16(sq->head);
         addr = cq->dma_addr + cq->tail * n->cqe_size;
+        ret = pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
+                            sizeof(req->cqe));
+        if (ret) {
+            trace_pci_nvme_err_addr_write(addr);
+            timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                      500 * SCALE_MS);
+            break;
+        }
+        QTAILQ_REMOVE(&cq->req_list, req, entry);
         nvme_inc_cq_tail(cq);
-        pci_dma_write(&n->parent_obj, addr, (void *)&req->cqe,
-            sizeof(req->cqe));
         nvme_req_clear(req);
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
@@ -1753,7 +1769,12 @@ static void nvme_process_sq(void *opaque)
 
     while (!(nvme_sq_empty(sq) || QTAILQ_EMPTY(&sq->req_list))) {
         addr = sq->dma_addr + sq->head * n->sqe_size;
-        nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd));
+        if (nvme_addr_read(n, addr, (void *)&cmd, sizeof(cmd))) {
+            trace_pci_nvme_err_addr_read(addr);
+            timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                      500 * SCALE_MS);
+            break;
+        }
         nvme_inc_sq_head(sq);
 
         req = QTAILQ_FIRST(&sq->req_list);
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 1b2c431e569e..e2a181a0915d 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -89,6 +89,8 @@ pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 # nvme traces for error conditions
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %"PRIu64""
 pci_nvme_err_aio(uint16_t cid, void *aio, const char *blkname, uint64_t offset, const char *opc, void *req, uint16_t status) "cid %"PRIu16" aio %p blk \"%s\" offset %"PRIu64" opc \"%s\" req %p status 0x%"PRIx16""
+pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
+pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
 pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 91456255ffa7..146c64e0bac7 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -629,7 +629,7 @@ enum NvmeStatusCodes {
     NVME_INVALID_OPCODE         = 0x0001,
     NVME_INVALID_FIELD          = 0x0002,
     NVME_CID_CONFLICT           = 0x0003,
-    NVME_DATA_TRAS_ERROR        = 0x0004,
+    NVME_DATA_TRANSFER_ERROR    = 0x0004,
     NVME_POWER_LOSS_ABORT       = 0x0005,
     NVME_INTERNAL_DEV_ERROR     = 0x0006,
     NVME_CMD_ABORT_REQ          = 0x0007,
-- 
2.27.0


