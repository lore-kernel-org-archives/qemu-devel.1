Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393D9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0817F2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0817F2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGr7-0006jN-Ax
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 14:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jhGn7-0002ed-EZ; Fri, 05 Jun 2020 14:10:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:40115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jhGn5-0002Ds-UJ; Fri, 05 Jun 2020 14:10:05 -0400
IronPort-SDR: 0atdZyu1aQ0PKqIpXA5zd1wcD+s3vt6h2H3HdTX/HgebYHnxL1MOTKNnJypEvu5DVR7eUuz2SC
 TOFsJ/SA7/QQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2020 11:10:01 -0700
IronPort-SDR: lw+ikJBO/g/a6aGKh+JLlpTJ6PYzKwMT0BSBeFHElPCz08RF8DpsRyG0+DpdOwlN6rzMcOR6B+
 qiVbHgO5u2sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,477,1583222400"; d="scan'208";a="258094540"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.28.117])
 by fmsmga007.fm.intel.com with ESMTP; 05 Jun 2020 11:10:00 -0700
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To: kbusch@kernel.org,
	kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH v1 2/2] nvme: allow cmb and pmr to be enabled on same device
Date: Fri,  5 Jun 2020 11:10:43 -0700
Message-Id: <20200605181043.28782-3-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200605181043.28782-1-andrzej.jakowski@linux.intel.com>
References: <20200605181043.28782-1-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.20;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 14:10:01
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 hw/block/nvme.c      | 127 +++++++++++++++++++++++++++++--------------
 hw/block/nvme.h      |   3 +-
 include/block/nvme.h |   4 +-
 3 files changed, 91 insertions(+), 43 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f0b45704be..353cf20e0a 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -22,12 +22,12 @@
  *              [pmrdev=<mem_backend_file_id>,] \
  *              num_queues=<N[optional]>
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
+ * pmrdev is assumed to be resident in BAR2. When configured it consumes whole
+ * BAR2 exclusively.
  * Enabling pmr emulation can be achieved by pointing to memory-backend-file.
  * For example:
  * -object memory-backend-file,id=<mem_id>,share=on,mem-path=<file_path>, \
@@ -64,9 +64,10 @@ static void nvme_process_sq(void *opaque);
 
 static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
-    if (n->cmbsz && addr >= n->ctrl_mem.addr &&
-                addr < (n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size))) {
-        memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
+    hwaddr cmb_addr = n->bar4.addr + n->cmb_offset;
+    if (n->cmbsz && addr >= cmb_addr &&
+        (addr + size) <= (cmb_addr + NVME_CMBSZ_GETSIZE(n->bar.cmbsz))) {
+        memcpy(buf, (void *)&n->cmbuf[addr - cmb_addr], size);
     } else {
         pci_dma_read(&n->parent_obj, addr, buf, size);
     }
@@ -152,17 +153,18 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
                              uint64_t prp2, uint32_t len, NvmeCtrl *n)
 {
     hwaddr trans_len = n->page_size - (prp1 % n->page_size);
+    hwaddr cmb_addr = n->bar4.addr + n->cmb_offset;
     trans_len = MIN(len, trans_len);
     int num_prps = (len >> n->page_bits) + 1;
 
     if (unlikely(!prp1)) {
         trace_nvme_err_invalid_prp();
         return NVME_INVALID_FIELD | NVME_DNR;
-    } else if (n->cmbsz && prp1 >= n->ctrl_mem.addr &&
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
@@ -207,7 +209,8 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
                 if (qsg->nsg){
                     qemu_sglist_add(qsg, prp_ent, trans_len);
                 } else {
-                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->ctrl_mem.addr], trans_len);
+                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - cmb_addr],
+                                   trans_len);
                 }
                 len -= trans_len;
                 i++;
@@ -220,7 +223,8 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
             if (qsg->nsg) {
                 qemu_sglist_add(qsg, prp2, len);
             } else {
-                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem.addr], trans_len);
+                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - cmb_addr],
+                               trans_len);
             }
         }
     }
@@ -1342,6 +1346,71 @@ static const MemoryRegionOps nvme_cmb_ops = {
     },
 };
 
+#define NVME_MSIX_BIR (4)
+static void nvme_bar4_init(PCIDevice *pci_dev)
+{
+    NvmeCtrl *n = NVME(pci_dev);
+    int status;
+    uint64_t bar_size = 4096;
+    uint32_t nvme_pba_offset = bar_size / 2;
+    uint32_t nvme_pba_size = QEMU_ALIGN_UP(n->num_queues, 64) / 8;
+    uint32_t cmb_size_units;
+
+    if (n->num_queues * PCI_MSIX_ENTRY_SIZE > nvme_pba_offset) {
+        nvme_pba_offset = n->num_queues * PCI_MSIX_ENTRY_SIZE;
+    }
+
+    if (nvme_pba_offset + nvme_pba_size > 4096) {
+        bar_size = nvme_pba_offset + nvme_pba_size;
+    }
+
+    if (n->cmb_size_mb) {
+        /* Contoller capabilities */
+        NVME_CAP_SET_CMBS(n->bar.cap, 1);
+
+        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
+        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
+        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
+        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
+        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
+        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
+        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->cmb_size_mb);
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
+    status = msix_init(pci_dev, n->num_queues,
+              &n->bar4, NVME_MSIX_BIR, 0,
+              &n->bar4, NVME_MSIX_BIR, nvme_pba_offset,
+              0, NULL);
+
+    if (status) {
+        return;
+    }
+
+    pci_register_bar(pci_dev, NVME_MSIX_BIR,
+             PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
+             PCI_BASE_ADDRESS_MEM_PREFETCH, &n->bar4);
+
+}
+
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n = NVME(pci_dev);
@@ -1372,7 +1441,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         return;
     }
 
-    if (!n->cmb_size_mb && n->pmrdev) {
+    if (n->pmrdev) {
         if (host_memory_backend_is_mapped(n->pmrdev)) {
             char *path = object_get_canonical_path_component(OBJECT(n->pmrdev));
             error_setg(errp, "can't use already busy memdev: %s", path);
@@ -1413,7 +1482,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     pci_register_bar(pci_dev, 0,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
         &n->iomem);
-    msix_init_exclusive_bar(pci_dev, n->num_queues, 4, NULL);
 
     id->vid = cpu_to_le16(pci_get_word(pci_conf + PCI_VENDOR_ID));
     id->ssvid = cpu_to_le16(pci_get_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID));
@@ -1445,35 +1513,12 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     NVME_CAP_SET_CSS(n->bar.cap, 1);
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
 
+    nvme_bar4_init(pci_dev);
+
     n->bar.vs = 0x00010200;
     n->bar.intmc = n->bar.intms = 0;
 
-    if (n->cmb_size_mb) {
-        /* Contoller capabilities */
-        NVME_CAP_SET_CMBS(n->bar.cap, 1);
-
-        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
-        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
-
-        NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
-        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
-        NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
-        NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->cmb_size_mb);
-
-        n->cmbloc = n->bar.cmbloc;
-        n->cmbsz = n->bar.cmbsz;
-
-        n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
-                              "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-        pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
-            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
-            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
-
-    } else if (n->pmrdev) {
+    if (n->pmrdev) {
         /* Controller Capabilities register */
         NVME_CAP_SET_PMRS(n->bar.cap, 1);
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 6520a9f0be..b983fc0005 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -60,7 +60,7 @@ typedef struct NvmeNamespace {
 typedef struct NvmeCtrl {
     PCIDevice    parent_obj;
     MemoryRegion iomem;
-    MemoryRegion ctrl_mem;
+    MemoryRegion bar4;
     NvmeBar      bar;
     BlockConf    conf;
 
@@ -77,6 +77,7 @@ typedef struct NvmeCtrl {
     uint32_t    cmb_size_mb;
     uint32_t    cmbsz;
     uint32_t    cmbloc;
+    uint32_t    cmb_offset;
     uint8_t     *cmbuf;
     uint64_t    irq_status;
     uint64_t    host_timestamp;                 /* Timestamp sent by the host */
diff --git a/include/block/nvme.h b/include/block/nvme.h
index b48349dbd0..47379e1a27 100644
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


