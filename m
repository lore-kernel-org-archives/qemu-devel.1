Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B78C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 437C2206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="emEmAQ4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437C2206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0uEo-00006H-IX
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 18:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0uDn-0006oM-MF; Wed, 29 Jul 2020 18:06:47 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34634)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0uDl-0008Ue-8K; Wed, 29 Jul 2020 18:06:47 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 338C6BFB1A;
 Wed, 29 Jul 2020 22:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596060403;
 bh=S/yn54QhYH9YbEzB2qoXQo0fc/7zblQ0igTfbaqcaug=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=emEmAQ4W/lswc2/YD9mfYNnWX+WB6t/i0F4Aaj9OStDs/Td4MS9GaVAYN35CHbNS6
 hlG8xLvAk0HRMfzuHVEpQmiMvn4TXcdoPOlMJrHbSADH5AhAoRhQ8SE/DOmDV30Jvc
 7Fhh75BgLSf/FaGeXU+dgppSzCADx6RMgZkyxCXisDODeBVxhP8gR8aw2XC1AQEwuP
 cxMCprTnMt2LJQsKeu5a2JraCHep4DiPekFUc1GnoZdBi9B/WrGkGSuKTBA04UT729
 gkIEbVAkGc8hfo8T1I+Dc9xTKpNocJiK5gvgO+zDRhIn+/71HA//h8r/Gyif1KuxQg
 k843UgV/1WVoQ==
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/16] hw/block/nvme: add mapping helpers
Date: Thu, 30 Jul 2020 00:06:24 +0200
Message-Id: <20200729220638.344477-3-its@irrelevant.dk>
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

Add nvme_map_addr, nvme_map_addr_cmb and nvme_addr_to_cmb helpers and
use them in nvme_map_prp.

This fixes a bug where in the case of a CMB transfer, the device would
map to the buffer with a wrong length.

Fixes: b2b2b67a00574 ("nvme: Add support for Read Data and Write Data in CMBs.")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
---
 hw/block/nvme.c       | 111 +++++++++++++++++++++++++++++++++++-------
 hw/block/trace-events |   2 +
 2 files changed, 96 insertions(+), 17 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 25b87486ea5a..0422d4397d76 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -117,10 +117,17 @@ static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
     return addr >= low && addr < hi;
 }
 
+static inline void *nvme_addr_to_cmb(NvmeCtrl *n, hwaddr addr)
+{
+    assert(nvme_addr_is_cmb(n, addr));
+
+    return &n->cmbuf[addr - n->ctrl_mem.addr];
+}
+
 static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
     if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
-        memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
+        memcpy(buf, nvme_addr_to_cmb(n, addr), size);
         return;
     }
 
@@ -203,29 +210,91 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
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
@@ -242,6 +311,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
                 if (i == n->max_prp_ents - 1 && len > n->page_size) {
                     if (unlikely(!prp_ent || prp_ent & (n->page_size - 1))) {
                         trace_pci_nvme_err_invalid_prplist_ent(prp_ent);
+                        status = NVME_INVALID_FIELD | NVME_DNR;
                         goto unmap;
                     }
 
@@ -255,14 +325,14 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
 
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
@@ -270,20 +340,27 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
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


