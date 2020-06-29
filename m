Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F77C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:30:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7615255D8
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7615255D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpyYR-0005ah-Ur
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 14:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpyUg-0008Ke-7h; Mon, 29 Jun 2020 14:27:02 -0400
Received: from charlie.dont.surf ([128.199.63.193]:45824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jpyUb-0000Zj-4S; Mon, 29 Jun 2020 14:27:01 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id E8DD4BF767;
 Mon, 29 Jun 2020 18:26:53 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH 02/17] hw/block/nvme: additional tracing
Date: Mon, 29 Jun 2020 20:26:27 +0200
Message-Id: <20200629182642.1170387-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629182642.1170387-1-its@irrelevant.dk>
References: <20200629182642.1170387-1-its@irrelevant.dk>
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

Add various additional tracing and streamline nvme_identify_ns and
nvme_identify_nslist (they do not need to repeat the command, it is
already in the trace name).

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 19 +++++++++++++++++++
 hw/block/nvme.h       | 14 ++++++++++++++
 hw/block/trace-events | 13 +++++++++++--
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 71b388aa0e20..f5d9148f0936 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -331,6 +331,8 @@ static void nvme_post_cqes(void *opaque)
 static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
 {
     assert(cq->cqid == req->sq->cqid);
+    trace_pci_nvme_enqueue_req_completion(nvme_cid(req), cq->cqid,
+                                          req->status);
     QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
     QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
     timer_mod(cq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
@@ -343,6 +345,8 @@ static void nvme_rw_cb(void *opaque, int ret)
     NvmeCtrl *n = sq->ctrl;
     NvmeCQueue *cq = n->cq[sq->cqid];
 
+    trace_pci_nvme_rw_cb(nvme_cid(req));
+
     if (!ret) {
         block_acct_done(blk_get_stats(n->conf.blk), &req->acct);
         req->status = NVME_SUCCESS;
@@ -378,6 +382,8 @@ static uint16_t nvme_write_zeros(NvmeCtrl *n, NvmeNamespace *ns, NvmeCmd *cmd,
     uint64_t offset = slba << data_shift;
     uint32_t count = nlb << data_shift;
 
+    trace_pci_nvme_write_zeroes(nvme_cid(req), slba, nlb);
+
     if (unlikely(slba + nlb > ns->id_ns.nsze)) {
         trace_pci_nvme_err_invalid_lba_range(slba, nlb, ns->id_ns.nsze);
         return NVME_LBA_RANGE | NVME_DNR;
@@ -445,6 +451,8 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     NvmeNamespace *ns;
     uint32_t nsid = le32_to_cpu(cmd->nsid);
 
+    trace_pci_nvme_io_cmd(nvme_cid(req), nsid, nvme_sqid(req), cmd->opcode);
+
     if (unlikely(nsid == 0 || nsid > n->num_namespaces)) {
         trace_pci_nvme_err_invalid_ns(nsid, n->num_namespaces);
         return NVME_INVALID_NSID | NVME_DNR;
@@ -876,6 +884,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 
 static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
 {
+    trace_pci_nvme_admin_cmd(nvme_cid(req), nvme_sqid(req), cmd->opcode);
+
     switch (cmd->opcode) {
     case NVME_ADM_CMD_DELETE_SQ:
         return nvme_del_sq(n, cmd);
@@ -1204,6 +1214,8 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr addr, unsigned size)
     uint8_t *ptr = (uint8_t *)&n->bar;
     uint64_t val = 0;
 
+    trace_pci_nvme_mmio_read(addr);
+
     if (unlikely(addr & (sizeof(uint32_t) - 1))) {
         NVME_GUEST_ERR(pci_nvme_ub_mmiord_misaligned32,
                        "MMIO read not 32-bit aligned,"
@@ -1273,6 +1285,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             return;
         }
 
+        trace_pci_nvme_mmio_doorbell_cq(cq->cqid, new_head);
+
         start_sqs = nvme_cq_full(cq) ? 1 : 0;
         cq->head = new_head;
         if (start_sqs) {
@@ -1311,6 +1325,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             return;
         }
 
+        trace_pci_nvme_mmio_doorbell_sq(sq->sqid, new_tail);
+
         sq->tail = new_tail;
         timer_mod(sq->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 500);
     }
@@ -1320,6 +1336,9 @@ static void nvme_mmio_write(void *opaque, hwaddr addr, uint64_t data,
     unsigned size)
 {
     NvmeCtrl *n = (NvmeCtrl *)opaque;
+
+    trace_pci_nvme_mmio_write(addr, data);
+
     if (addr < sizeof(n->bar)) {
         nvme_write_bar(n, addr, data, size);
     } else if (addr >= 0x1000) {
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 1d30c0bca283..1bf5c80ed843 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -115,4 +115,18 @@ static inline uint64_t nvme_ns_nlbas(NvmeCtrl *n, NvmeNamespace *ns)
     return n->ns_size >> nvme_ns_lbads(ns);
 }
 
+static inline uint16_t nvme_cid(NvmeRequest *req)
+{
+    if (req) {
+        return le16_to_cpu(req->cqe.cid);
+    }
+
+    return 0xffff;
+}
+
+static inline uint16_t nvme_sqid(NvmeRequest *req)
+{
+    return le16_to_cpu(req->sq->sqid);
+}
+
 #endif /* HW_NVME_H */
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 958fcc5508d1..c40c0d2e4b28 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -33,19 +33,28 @@ pci_nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
 pci_nvme_irq_pin(void) "pulsing IRQ pin"
 pci_nvme_irq_masked(void) "IRQ is masked"
 pci_nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
+pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
+pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8""
 pci_nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
+pci_nvme_rw_cb(uint16_t cid) "cid %"PRIu16""
+pci_nvme_write_zeroes(uint16_t cid, uint64_t slba, uint32_t nlb) "cid %"PRIu16" slba %"PRIu64" nlb %"PRIu32""
 pci_nvme_create_sq(uint64_t addr, uint16_t sqid, uint16_t cqid, uint16_t qsize, uint16_t qflags) "create submission queue, addr=0x%"PRIx64", sqid=%"PRIu16", cqid=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16""
 pci_nvme_create_cq(uint64_t addr, uint16_t cqid, uint16_t vector, uint16_t size, uint16_t qflags, int ien) "create completion queue, addr=0x%"PRIx64", cqid=%"PRIu16", vector=%"PRIu16", qsize=%"PRIu16", qflags=%"PRIu16", ien=%d"
 pci_nvme_del_sq(uint16_t qid) "deleting submission queue sqid=%"PRIu16""
 pci_nvme_del_cq(uint16_t cqid) "deleted completion queue, cqid=%"PRIu16""
 pci_nvme_identify_ctrl(void) "identify controller"
-pci_nvme_identify_ns(uint16_t ns) "identify namespace, nsid=%"PRIu16""
-pci_nvme_identify_nslist(uint16_t ns) "identify namespace list, nsid=%"PRIu16""
+pci_nvme_identify_ns(uint32_t ns) "nsid %"PRIu32""
+pci_nvme_identify_nslist(uint32_t ns) "nsid %"PRIu32""
 pci_nvme_getfeat_vwcache(const char* result) "get feature volatile write cache, result=%s"
 pci_nvme_getfeat_numq(int result) "get feature number of queues, result=%d"
 pci_nvme_setfeat_numq(int reqcq, int reqsq, int gotcq, int gotsq) "requested cq_count=%d sq_count=%d, responding with cq_count=%d sq_count=%d"
 pci_nvme_setfeat_timestamp(uint64_t ts) "set feature timestamp = 0x%"PRIx64""
 pci_nvme_getfeat_timestamp(uint64_t ts) "get feature timestamp = 0x%"PRIx64""
+pci_nvme_enqueue_req_completion(uint16_t cid, uint16_t cqid, uint16_t status) "cid %"PRIu16" cqid %"PRIu16" status 0x%"PRIx16""
+pci_nvme_mmio_read(uint64_t addr) "addr 0x%"PRIx64""
+pci_nvme_mmio_write(uint64_t addr, uint64_t data) "addr 0x%"PRIx64" data 0x%"PRIx64""
+pci_nvme_mmio_doorbell_cq(uint16_t cqid, uint16_t new_head) "cqid %"PRIu16" new_head %"PRIu16""
+pci_nvme_mmio_doorbell_sq(uint16_t sqid, uint16_t new_tail) "cqid %"PRIu16" new_tail %"PRIu16""
 pci_nvme_mmio_intm_set(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask set, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_intm_clr(uint64_t data, uint64_t new_mask) "wrote MMIO, interrupt mask clr, data=0x%"PRIx64", new_mask=0x%"PRIx64""
 pci_nvme_mmio_cfg(uint64_t data) "wrote MMIO, config controller config=0x%"PRIx64""
-- 
2.27.0


