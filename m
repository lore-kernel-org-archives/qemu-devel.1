Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850DCC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD2920720
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD2920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlQTM-0008SO-CF
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 01:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jlQSV-0006zR-Ru; Wed, 17 Jun 2020 01:17:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:46527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jlQSS-0007e9-9s; Wed, 17 Jun 2020 01:17:59 -0400
IronPort-SDR: y5UiVoZ9wHNlGl3kd+ild4cQMyeDHvOkOjzxD23GHnt+uYWReDXzrZVtJtOqtj+/2eqXam5Ae9
 zEBPYJhEep3w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2020 22:17:50 -0700
IronPort-SDR: g0X2pHzPiUtr4xnM5VYSkCSi5FyHneJxAi5eOmx4G8zwNLMsP/eFV26/6j42Lz9YR4zuHqlNSd
 ZVry6ImYZRVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,521,1583222400"; d="scan'208";a="308681733"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.28.117])
 by orsmga008.jf.intel.com with ESMTP; 16 Jun 2020 22:17:50 -0700
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To: kbusch@kernel.org,
	kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH RESEND v2 2/2] nvme: allow cmb and pmr to be enabled on same
 device
Date: Tue, 16 Jun 2020 22:18:57 -0700
Message-Id: <20200617051857.20508-3-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200617051857.20508-1-andrzej.jakowski@linux.intel.com>
References: <20200617051857.20508-1-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.100;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:17:48
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So far it was not possible to have CMB and PMR emulated on the same
device, because BAR2 was used exclusively either of PMR or CMB. This
patch places CMB at BAR4 offset so it not conflicts with MSI-X vectors.

Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
---
 hw/block/nvme.c      | 122 ++++++++++++++++++++++++++++---------------
 hw/block/nvme.h      |   5 +-
 include/block/nvme.h |   4 +-
 3 files changed, 86 insertions(+), 45 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9f11f3e9da..62681966b9 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -22,12 +22,12 @@
  *              [pmrdev=<mem_backend_file_id>,] \
  *              max_ioqpairs=<N[optional]>
  *
- * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
- * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
+ * Note cmb_size_mb denotes size of CMB in MB. CMB when configured is assumed
+ * to be resident in BAR4 at certain offset - this is because BAR4 is also
+ * used for storing MSI-X table that is available at offset 0 in BAR4.
  *
- * cmb_size_mb= and pmrdev= options are mutually exclusive due to limitation
- * in available BAR's. cmb_size_mb= will take precedence over pmrdev= when
- * both provided.
+ * pmrdev is assumed to be resident in BAR2/BAR3. When configured it consumes
+ * whole BAR2/BAR3 exclusively.
  * Enabling pmr emulation can be achieved by pointing to memory-backend-file.
  * For example:
  * -object memory-backend-file,id=<mem_id>,share=on,mem-path=<file_path>, \
@@ -69,18 +69,19 @@
 
 static void nvme_process_sq(void *opaque);
 
-static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
+static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr, int size)
 {
-    hwaddr low = n->ctrl_mem.addr;
-    hwaddr hi  = n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size);
+    hwaddr low = n->bar4.addr + n->cmb_offset;
+    hwaddr hi  = low + NVME_CMBSZ_GETSIZE(n->bar.cmbsz);
 
-    return addr >= low && addr < hi;
+    return addr >= low && (addr + size) < hi;
 }
 
 static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
-    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
-        memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
+    hwaddr cmb_addr = n->bar4.addr + n->cmb_offset;
+    if (n->cmbsz && nvme_addr_is_cmb(n, addr, size)) {
+        memcpy(buf, (void *)&n->cmbuf[addr - cmb_addr], size);
         return;
     }
 
@@ -167,17 +168,18 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
                              uint64_t prp2, uint32_t len, NvmeCtrl *n)
 {
     hwaddr trans_len = n->page_size - (prp1 % n->page_size);
+    hwaddr cmb_addr = n->bar4.addr + n->cmb_offset;
     trans_len = MIN(len, trans_len);
     int num_prps = (len >> n->page_bits) + 1;
 
     if (unlikely(!prp1)) {
         trace_pci_nvme_err_invalid_prp();
         return NVME_INVALID_FIELD | NVME_DNR;
-    } else if (n->bar.cmbsz && prp1 >= n->ctrl_mem.addr &&
-               prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
+    } else if (n->cmbsz && prp1 >= cmb_addr &&
+               prp1 < cmb_addr + int128_get64(n->bar4.size)) {
         qsg->nsg = 0;
         qemu_iovec_init(iov, num_prps);
-        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], trans_len);
+        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - cmb_addr], trans_len);
     } else {
         pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
         qemu_sglist_add(qsg, prp1, trans_len);
@@ -222,7 +224,8 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
                 if (qsg->nsg){
                     qemu_sglist_add(qsg, prp_ent, trans_len);
                 } else {
-                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->ctrl_mem.addr], trans_len);
+                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - cmb_addr],
+                                   trans_len);
                 }
                 len -= trans_len;
                 i++;
@@ -235,7 +238,8 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
             if (qsg->nsg) {
                 qemu_sglist_add(qsg, prp2, len);
             } else {
-                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem.addr], trans_len);
+                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - cmb_addr],
+                               trans_len);
             }
         }
     }
@@ -1360,6 +1364,7 @@ static const MemoryRegionOps nvme_cmb_ops = {
     },
 };
 
+
 static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
 {
     NvmeParams *params = &n->params;
@@ -1395,7 +1400,7 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
         return;
     }
 
-    if (!n->params.cmb_size_mb && n->pmrdev) {
+    if (n->pmrdev) {
         if (host_memory_backend_is_mapped(n->pmrdev)) {
             char *path = object_get_canonical_path_component(OBJECT(n->pmrdev));
             error_setg(errp, "can't use already busy memdev: %s", path);
@@ -1453,33 +1458,66 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     id_ns->nuse = id_ns->ncap;
 }
 
-static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
+#define NVME_MSIX_BIR (4)
+static void nvme_bar4_init(PCIDevice *pci_dev, Error **errp)
 {
-    NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_CMB_BIR);
-    NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
-
-    NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
-    NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
-    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
-    NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
-    NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
-    NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
-    NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
-
-    n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-    memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
-                          "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-    pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
+    NvmeCtrl *n = NVME(pci_dev);
+    int status;
+    uint64_t bar_size;
+    uint32_t msix_vectors;
+    uint32_t nvme_pba_offset;
+    uint32_t cmb_size_units;
+
+    msix_vectors = n->params.max_ioqpairs + 1;
+    nvme_pba_offset = PCI_MSIX_ENTRY_SIZE * msix_vectors;
+    bar_size = nvme_pba_offset + QEMU_ALIGN_UP(msix_vectors, 64) / 8;
+
+    if (n->params.cmb_size_mb) {
+        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
+        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
+        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
+        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
+        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
+        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
+        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
+
+        cmb_size_units = NVME_CMBSZ_GETSIZEUNITS(n->bar.cmbsz);
+        n->cmb_offset = QEMU_ALIGN_UP(bar_size, cmb_size_units);
+
+        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_MSIX_BIR);
+        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, n->cmb_offset / cmb_size_units);
+
+        n->cmbloc = n->bar.cmbloc;
+        n->cmbsz = n->bar.cmbsz;
+
+        n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
+
+        bar_size += n->cmb_offset;
+        bar_size += NVME_CMBSZ_GETSIZE(n->bar.cmbsz);
+    }
+
+    bar_size = pow2ceil(bar_size);
+
+    memory_region_init_io(&n->bar4, OBJECT(n), &nvme_cmb_ops, n,
+                          "nvme-bar4", bar_size);
+
+    status = msix_init(pci_dev, n->params.max_ioqpairs + 1,
+              &n->bar4, NVME_MSIX_BIR, 0,
+              &n->bar4, NVME_MSIX_BIR, nvme_pba_offset,
+              0, errp);
+
+    if (status) {
+        return;
+    }
+
+    pci_register_bar(pci_dev, NVME_MSIX_BIR,
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
                      PCI_BASE_ADDRESS_MEM_TYPE_64 |
-                     PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
+                     PCI_BASE_ADDRESS_MEM_PREFETCH, &n->bar4);
 }
 
 static void nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev)
 {
-    /* Controller Capabilities register */
-    NVME_CAP_SET_PMRS(n->bar.cap, 1);
-
     /* PMR Capabities register */
     n->bar.pmrcap = 0;
     NVME_PMRCAP_SET_RDS(n->bar.pmrcap, 0);
@@ -1537,13 +1575,10 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
                           n->reg_size);
     pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
                      PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
-    if (msix_init_exclusive_bar(pci_dev, n->params.msix_qsize, 4, errp)) {
-        return;
-    }
 
-    if (n->params.cmb_size_mb) {
-        nvme_init_cmb(n, pci_dev);
-    } else if (n->pmrdev) {
+    nvme_bar4_init(pci_dev, errp);
+
+    if (n->pmrdev) {
         nvme_init_pmr(n, pci_dev);
     }
 }
@@ -1583,6 +1618,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_CSS(n->bar.cap, 1);
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
     NVME_CAP_SET_CMBS(n->bar.cap, n->params.cmb_size_mb ? 1 : 0);
+    NVME_CAP_SET_PMRS(n->bar.cap, n->pmrdev ? 1 : 0);
 
     n->bar.vs = 0x00010200;
     n->bar.intmc = n->bar.intms = 0;
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 1d30c0bca2..bc233e6a68 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -80,7 +80,7 @@ static inline uint8_t nvme_ns_lbads(NvmeNamespace *ns)
 typedef struct NvmeCtrl {
     PCIDevice    parent_obj;
     MemoryRegion iomem;
-    MemoryRegion ctrl_mem;
+    MemoryRegion bar4;
     NvmeBar      bar;
     BlockConf    conf;
     NvmeParams   params;
@@ -94,6 +94,9 @@ typedef struct NvmeCtrl {
     uint32_t    num_namespaces;
     uint32_t    max_q_ents;
     uint64_t    ns_size;
+    uint32_t    cmbsz;
+    uint32_t    cmbloc;
+    uint32_t    cmb_offset;
     uint8_t     *cmbuf;
     uint32_t    irq_status;
     uint64_t    host_timestamp;                 /* Timestamp sent by the host */
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 14cf398dfa..76d15bdf9f 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -216,9 +216,11 @@ enum NvmeCmbszMask {
     (cmbsz |= (uint64_t)(val & CMBSZ_SZU_MASK) << CMBSZ_SZU_SHIFT)
 #define NVME_CMBSZ_SET_SZ(cmbsz, val)    \
     (cmbsz |= (uint64_t)(val & CMBSZ_SZ_MASK) << CMBSZ_SZ_SHIFT)
+#define NVME_CMBSZ_GETSIZEUNITS(cmbsz) \
+    (1 << (12 + 4 * NVME_CMBSZ_SZU(cmbsz)))
 
 #define NVME_CMBSZ_GETSIZE(cmbsz) \
-    (NVME_CMBSZ_SZ(cmbsz) * (1 << (12 + 4 * NVME_CMBSZ_SZU(cmbsz))))
+    (NVME_CMBSZ_SZ(cmbsz) * NVME_CMBSZ_GETSIZEUNITS(cmbsz))
 
 enum NvmePmrcapShift {
     PMRCAP_RDS_SHIFT      = 3,
-- 
2.21.1


