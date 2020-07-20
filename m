Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A56BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A67B22C9C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="l0gJltjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A67B22C9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxUBA-0004jd-HQ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7N-0007Fc-N6; Mon, 20 Jul 2020 07:38:01 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jxU7J-00059C-US; Mon, 20 Jul 2020 07:38:01 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 289F1BF7BC;
 Mon, 20 Jul 2020 11:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1595245076;
 bh=4Y6ZJAgxewapTBwrq8z29g0MxsTzobeq9e/qjftC6ec=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l0gJltjdwooJv4ebiuPZ50GMNq6/LzTlsgEVEl1aeaJ13RW5Q8ddipKx0N1BiPprf
 L7khqrEOUyluZfcLlLzvCb5vYj5j7rjq2WdWan2oYlpTSogbjZmAF9X+c4z7eA7ALU
 hS6l7pwd3YCaqJvG03YHWqxVAJXU4ZL1tFpIJIFzUG5WNKiJ42nsP/F0vVsMQlD5MO
 kw8HfhkCdaAaidFNw31F8r7JS9t/gl+y+LkpFVlgK2Mep20G1lYkLcNAUA83VNoVqO
 Uuyu43uhfVlToBmkZCkBdamykWyCuU0evkLAbDXPC8VWxKty6z5Zp8Zd88oHTXjPoo
 aYyRYCoDa/LvA==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/16] hw/block/nvme: add mapping helpers
Date: Mon, 20 Jul 2020 13:37:34 +0200
Message-Id: <20200720113748.322965-3-its@irrelevant.dk>
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

Add nvme_map_addr, nvme_map_addr_cmb and nvme_addr_to_cmb helpers and
use them in nvme_map_prp.

This fixes a bug where in the case of a CMB transfer, the device would
map to the buffer with a wrong length.

Fixes: b2b2b67a00574 ("nvme: Add support for Read Data and Write Data in CMBs.")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 109 +++++++++++++++++++++++++++++++++++-------
 hw/block/trace-events |   2 +
 2 files changed, 94 insertions(+), 17 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 4d7b730a62b6..9b1a080cdc70 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -109,6 +109,11 @@ static uint16_t nvme_sqid(NvmeRequest *req)
     return le16_to_cpu(req->sq->sqid);
 }
 
+static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
+{
+    return &n->cmbuf[addr - n->ctrl_mem.addr];
+}
+
 static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
 {
     hwaddr low = n->ctrl_mem.addr;
@@ -120,7 +125,7 @@ static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
 static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
     if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
-        memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
+        memcpy(buf, nvme_addr_to_cmb(n, addr), size);
         return;
     }
 
@@ -203,29 +208,91 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
     }
 }
 
+static uint16_t nvme_map_addr_cmb(NvmeCtrl *n, QEMUIOVector *iov, hwaddr addr,
+                                  size_t len)
+{
+    if (!len) {
+        return NVME_SUCCESS;
+    }
+
+    trace_pci_nvme_map_addr_cmb(addr, len);
+
+    if (!nvme_addr_is_cmb(n, addr) || !nvme_addr_is_cmb(n, addr + len - 1)) {
+        return NVME_DATA_TRAS_ERROR;
+    }
+
+    qemu_iovec_add(iov, nvme_addr_to_cmb(n, addr), len);
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_map_addr(NvmeCtrl *n, QEMUSGList *qsg, QEMUIOVector *iov,
+                              hwaddr addr, size_t len)
+{
+    if (!len) {
+        return NVME_SUCCESS;
+    }
+
+    trace_pci_nvme_map_addr(addr, len);
+
+    if (nvme_addr_is_cmb(n, addr)) {
+        if (qsg && qsg->sg) {
+            return NVME_INVALID_USE_OF_CMB | NVME_DNR;
+        }
+
+        assert(iov);
+
+        if (!iov->iov) {
+            qemu_iovec_init(iov, 1);
+        }
+
+        return nvme_map_addr_cmb(n, iov, addr, len);
+    }
+
+    if (iov && iov->iov) {
+        return NVME_INVALID_USE_OF_CMB | NVME_DNR;
+    }
+
+    assert(qsg);
+
+    if (!qsg->sg) {
+        pci_dma_sglist_init(qsg, &n->parent_obj, 1);
+    }
+
+    qemu_sglist_add(qsg, addr, len);
+
+    return NVME_SUCCESS;
+}
+
 static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
                              uint64_t prp2, uint32_t len, NvmeCtrl *n)
 {
     hwaddr trans_len = n->page_size - (prp1 % n->page_size);
     trans_len = MIN(len, trans_len);
     int num_prps = (len >> n->page_bits) + 1;
+    uint16_t status;
 
     if (unlikely(!prp1)) {
         trace_pci_nvme_err_invalid_prp();
         return NVME_INVALID_FIELD | NVME_DNR;
-    } else if (n->bar.cmbsz && prp1 >= n->ctrl_mem.addr &&
-               prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
-        qsg->nsg = 0;
+    }
+
+    if (nvme_addr_is_cmb(n, prp1)) {
         qemu_iovec_init(iov, num_prps);
-        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], trans_len);
     } else {
         pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
-        qemu_sglist_add(qsg, prp1, trans_len);
     }
+
+    status = nvme_map_addr(n, qsg, iov, prp1, trans_len);
+    if (status) {
+        goto unmap;
+    }
+
     len -= trans_len;
     if (len) {
         if (unlikely(!prp2)) {
             trace_pci_nvme_err_invalid_prp2_missing();
+            status = NVME_INVALID_FIELD | NVME_DNR;
             goto unmap;
         }
         if (len > n->page_size) {
@@ -242,6 +309,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
                 if (i == n->max_prp_ents - 1 && len > n->page_size) {
                     if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
                         trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
+                        status = NVME_INVALID_FIELD | NVME_DNR;
                         goto unmap;
                     }
 
@@ -255,14 +323,14 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
 
                 if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
                     trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
+                    status = NVME_INVALID_FIELD | NVME_DNR;
                     goto unmap;
                 }
 
                 trans_len = MIN(len, n->page_size);
-                if (qsg->nsg){
-                    qemu_sglist_add(qsg, prp_ent, trans_len);
-                } else {
-                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->ctrl_mem.addr], trans_len);
+                status = nvme_map_addr(n, qsg, iov, prp_ent, trans_len);
+                if (status) {
+                    goto unmap;
                 }
                 len -= trans_len;
                 i++;
@@ -270,20 +338,27 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
         } else {
             if (unlikely(prp2 & (n->page_size - 1))) {
                 trace_pci_nvme_err_invalid_prp2_align(prp2);
+                status = NVME_INVALID_FIELD | NVME_DNR;
                 goto unmap;
             }
-            if (qsg->nsg) {
-                qemu_sglist_add(qsg, prp2, len);
-            } else {
-                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem.addr], trans_len);
+            status = nvme_map_addr(n, qsg, iov, prp2, len);
+            if (status) {
+                goto unmap;
             }
         }
     }
     return NVME_SUCCESS;
 
- unmap:
-    qemu_sglist_destroy(qsg);
-    return NVME_INVALID_FIELD | NVME_DNR;
+unmap:
+    if (iov && iov->iov) {
+        qemu_iovec_destroy(iov);
+    }
+
+    if (qsg && qsg->sg) {
+        qemu_sglist_destroy(qsg);
+    }
+
+    return status;
 }
 
 static uint16_t nvme_dma_write_prp(NvmeCtrl *n, uint8_t *ptr, uint32_t len,
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 7b7303cab1dd..f3b2d004e078 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -33,6 +33,8 @@ pci_nvme_irq_msix(uint32_t vector) "raising MSI-X IRQ vector %u"
 pci_nvme_irq_pin(void) "pulsing IRQ pin"
 pci_nvme_irq_masked(void) "IRQ is masked"
 pci_nvme_dma_read(uint64_t prp1, uint64_t prp2) "DMA read, prp1=0x%"PRIx64" prp2=0x%"PRIx64""
+pci_nvme_map_addr(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
+pci_nvme_map_addr_cmb(uint64_t addr, uint64_t len) "addr 0x%"PRIx64" len %"PRIu64""
 pci_nvme_io_cmd(uint16_t cid, uint32_t nsid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" nsid %"PRIu32" sqid %"PRIu16" opc 0x%"PRIx8""
 pci_nvme_admin_cmd(uint16_t cid, uint16_t sqid, uint8_t opcode) "cid %"PRIu16" sqid %"PRIu16" opc 0x%"PRIx8""
 pci_nvme_rw(const char *verb, uint32_t blk_count, uint64_t byte_count, uint64_t lba) "%s %"PRIu32" blocks (%"PRIu64" bytes) from LBA %"PRIu64""
-- 
2.27.0


