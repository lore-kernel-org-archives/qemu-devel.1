Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FA0C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538512074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="cFn43aX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538512074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECcd-0008BB-8Y
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECZz-0002QQ-MV; Fri, 04 Sep 2020 10:20:39 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kECZv-0002gp-BJ; Fri, 04 Sep 2020 10:20:39 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id AC157BF8E7;
 Fri,  4 Sep 2020 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1599229232;
 bh=+LVYT8u/sgy2SdJk+2GYEVmsu8mUtbPV7TqY7WEojSE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cFn43aX0QajOqyc6ZcSnPk348A+mO4vVO0Fw6Q0NlCnH+t9cueD9c6NRqnkojhx/a
 xWJLJIZ1bfk0pKVQlgk5O9wfE4mXvqyeBnzoBIEcc380udGe7qB2EbR+FBV8p0uScG
 Ir1LBjJeNDU5xp7SVshtsP9bXXNlTFnjPimRXIGfVLlU43J5UOnlodKgvSKwn+baKx
 rfSRvs3NKBykJWU9c5Y9zeYBWcqH32EH4ikBuqlWSxmbQczWT/U9jF11/Hj4pElZfO
 E2pwZKMAqKZ2JGAKltCtkW2HVytQ4+/6dVpnhNZCi6aXfZQqkFsOCL4gOaqyhfmud3
 Oe7ahbX/MARMA==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/17] hw/block/nvme: handle dma errors
Date: Fri,  4 Sep 2020 16:19:41 +0200
Message-Id: <20200904141956.576630-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904141956.576630-1-its@irrelevant.dk>
References: <20200904141956.576630-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 10:20:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
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
index 63078f600920..49bcdf31ced6 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -140,14 +140,14 @@ static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
     return &n->cmbuf[addr - n->ctrl_mem.addr];
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
@@ -253,7 +253,7 @@ static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
     trace_pci_nvme_map_addr_cmb(addr, len);
 
     if (!nvme_addr_is_cmb(n, addr) || !nvme_addr_is_cmb(n, addr + len - 1)) {
-        return NVME_DATA_TRAS_ERROR;
+        return NVME_DATA_TRANSFER_ERROR;
     }
 
     qemu_iovec_add(iov, nvme_addr_to_cmb(n, addr), len);
@@ -307,6 +307,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
     int num_prps = (len >> n->page_bits) + 1;
     uint16_t status;
     bool prp_list_in_cmb = false;
+    int ret;
 
     QEMUSGList *qsg = &req->qsg;
     QEMUIOVector *iov = &req->iov;
@@ -347,7 +348,11 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
 
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
 
@@ -364,8 +369,12 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, uint64_t prp1, uint64_t prp2,
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
 
@@ -457,6 +466,7 @@ static void nvme_post_cqes(void *opaque)
     NvmeCQueue *cq = opaque;
     NvmeCtrl *n = cq->ctrl;
     NvmeRequest *req, *next;
+    int ret;
 
     QTAILQ_FOREACH_SAFE(req, &cq->req_list, entry, next) {
         NvmeSQueue *sq;
@@ -466,15 +476,21 @@ static void nvme_post_cqes(void *opaque)
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
         nvme_req_exit(req);
         QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
     }
@@ -1611,7 +1627,12 @@ static void nvme_process_sq(void *opaque)
 
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
index 72cf2d15cb8e..50d5702e6b80 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -86,6 +86,8 @@ pci_nvme_mmio_shutdown_cleared(void) "shutdown bit cleared"
 
 # nvme traces for error conditions
 pci_nvme_err_mdts(uint16_t cid, size_t len) "cid %"PRIu16" len %zu"
+pci_nvme_err_addr_read(uint64_t addr) "addr 0x%"PRIx64""
+pci_nvme_err_addr_write(uint64_t addr) "addr 0x%"PRIx64""
 pci_nvme_err_invalid_dma(void) "PRP/SGL is too small for transfer size"
 pci_nvme_err_invalid_prplist_ent(uint64_t prplist) "PRP list entry is null or not page aligned: 0x%"PRIx64""
 pci_nvme_err_invalid_prp2_align(uint64_t prp2) "PRP2 is not page aligned: 0x%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 65e68a82c897..c8d0a3473f0d 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -630,7 +630,7 @@ enum NvmeStatusCodes {
     NVME_INVALID_OPCODE         = 0x0001,
     NVME_INVALID_FIELD          = 0x0002,
     NVME_CID_CONFLICT           = 0x0003,
-    NVME_DATA_TRAS_ERROR        = 0x0004,
+    NVME_DATA_TRANSFER_ERROR    = 0x0004,
     NVME_POWER_LOSS_ABORT       = 0x0005,
     NVME_INTERNAL_DEV_ERROR     = 0x0006,
     NVME_CMD_ABORT_REQ          = 0x0007,
-- 
2.28.0


