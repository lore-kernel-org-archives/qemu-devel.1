Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB31C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C3F2071A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C3F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jydhU-0005lD-Fr
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 12:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jydfc-0003RU-3k; Thu, 23 Jul 2020 12:02:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:20013)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jydfY-0006kf-4D; Thu, 23 Jul 2020 12:02:07 -0400
IronPort-SDR: d1mw3Tb4C87KQ6yvtGVhNuRwYRFquXytJvI+bLTzNxxDJC7w+I5GqHo3sZzJasf59TzpZUZWiz
 s7rQ8LoRQVjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="168693377"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; d="scan'208";a="168693377"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 09:01:59 -0700
IronPort-SDR: cIqcEehseNEqXP9i/KW3LNvR8ZJ9UIdvQ343paCB8UXSu8o851Ln+B/3AU7ftndkSb2OO6y6Fk
 RUjfDt+rREpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; d="scan'208";a="319033244"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.61.79])
 by orsmga008.jf.intel.com with ESMTP; 23 Jul 2020 09:01:59 -0700
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To: kbusch@kernel.org,
	kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH v5 3/3] nvme: allow cmb and pmr to be enabled on same device
Date: Thu, 23 Jul 2020 09:03:25 -0700
Message-Id: <20200723160325.41734-4-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200723160325.41734-1-andrzej.jakowski@linux.intel.com>
References: <20200723160325.41734-1-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.88;
 envelope-from=andrzej.jakowski@linux.intel.com; helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 12:02:00
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: pbonzini@redhat.com, Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

So far it was not possible to have CMB and PMR emulated on the same
device, because BAR2 was used exclusively either of PMR or CMB. This
patch places CMB at BAR4 offset so it not conflicts with MSI-X vectors.

Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
---
 hw/block/nvme.c      | 120 +++++++++++++++++++++++++++++--------------
 hw/block/nvme.h      |   1 +
 include/block/nvme.h |   4 +-
 3 files changed, 85 insertions(+), 40 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 43866b744f..d55a71a346 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -22,12 +22,13 @@
  *              [pmrdev=<mem_backend_file_id>,] \
  *              max_ioqpairs=<N[optional]>
  *
- * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
- * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
+ * Note cmb_size_mb denotes size of CMB in MB. CMB when configured is assumed
+ * to be resident in BAR4 at offset that is 2MiB aligned. When CMB is emulated
+ * on Linux guest it is recommended to make cmb_size_mb multiple of 2. Both
+ * size and alignment restrictions are imposed by Linux guest.
  *
- * cmb_size_mb= and pmrdev= options are mutually exclusive due to limitation
- * in available BAR's. cmb_size_mb= will take precedence over pmrdev= when
- * both provided.
+ * pmrdev is assumed to be resident in BAR2/BAR3. When configured it consumes
+ * whole BAR2/BAR3 exclusively.
  * Enabling pmr emulation can be achieved by pointing to memory-backend-file.
  * For example:
  * -object memory-backend-file,id=<mem_id>,share=on,mem-path=<file_path>, \
@@ -57,8 +58,8 @@
 #define NVME_MAX_IOQPAIRS 0xffff
 #define NVME_DB_SIZE  4
 #define NVME_SPEC_VER 0x00010300
-#define NVME_CMB_BIR 2
 #define NVME_PMR_BIR 2
+#define NVME_MSIX_BIR 4
 #define NVME_TEMPERATURE 0x143
 #define NVME_TEMPERATURE_WARNING 0x157
 #define NVME_TEMPERATURE_CRITICAL 0x175
@@ -111,16 +112,18 @@ static uint16_t nvme_sqid(NvmeRequest *req)
 
 static bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
 {
-    hwaddr low = n->ctrl_mem.addr;
-    hwaddr hi  = n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size);
+    hwaddr low = memory_region_to_absolute_addr(&n->ctrl_mem, 0);
+    hwaddr hi  = low + int128_get64(n->ctrl_mem.size);
 
     return addr >= low && addr < hi;
 }
 
 static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
+    hwaddr cmb_addr = memory_region_to_absolute_addr(&n->ctrl_mem, 0);
+
     if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
-        memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
+        memcpy(buf, (void *)&n->cmbuf[addr - cmb_addr], size);
         return;
     }
 
@@ -207,17 +210,18 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
                              uint64_t prp2, uint32_t len, NvmeCtrl *n)
 {
     hwaddr trans_len = n->page_size - (prp1 % n->page_size);
+    hwaddr cmb_addr = memory_region_to_absolute_addr(&n->ctrl_mem, 0);
     trans_len = MIN(len, trans_len);
     int num_prps = (len >> n->page_bits) + 1;
 
     if (unlikely(!prp1)) {
         trace_pci_nvme_err_invalid_prp();
         return NVME_INVALID_FIELD | NVME_DNR;
-    } else if (n->bar.cmbsz && prp1 >= n->ctrl_mem.addr &&
-               prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)) {
+    } else if (n->bar.cmbsz && prp1 >= cmb_addr &&
+               prp1 < cmb_addr + int128_get64(n->ctrl_mem.size)) {
         qsg->nsg = 0;
         qemu_iovec_init(iov, num_prps);
-        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - n->ctrl_mem.addr], trans_len);
+        qemu_iovec_add(iov, (void *)&n->cmbuf[prp1 - cmb_addr], trans_len);
     } else {
         pci_dma_sglist_init(qsg, &n->parent_obj, num_prps);
         qemu_sglist_add(qsg, prp1, trans_len);
@@ -262,7 +266,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
                 if (qsg->nsg){
                     qemu_sglist_add(qsg, prp_ent, trans_len);
                 } else {
-                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - n->ctrl_mem.addr], trans_len);
+                    qemu_iovec_add(iov, (void *)&n->cmbuf[prp_ent - cmb_addr], trans_len);
                 }
                 len -= trans_len;
                 i++;
@@ -275,7 +279,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOVector *iov, uint64_t prp1,
             if (qsg->nsg) {
                 qemu_sglist_add(qsg, prp2, len);
             } else {
-                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - n->ctrl_mem.addr], trans_len);
+                qemu_iovec_add(iov, (void *)&n->cmbuf[prp2 - cmb_addr], trans_len);
             }
         }
     }
@@ -1980,7 +1984,7 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
         return;
     }
 
-    if (!n->params.cmb_size_mb && n->pmrdev) {
+    if (n->pmrdev) {
         if (host_memory_backend_is_mapped(n->pmrdev)) {
             char *path = object_get_canonical_path_component(OBJECT(n->pmrdev));
             error_setg(errp, "can't use already busy memdev: %s", path);
@@ -2042,33 +2046,73 @@ static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
     id_ns->nuse = id_ns->ncap;
 }
 
-static void nvme_init_cmb(NvmeCtrl *n, PCIDevice *pci_dev)
+static void nvme_bar4_init(PCIDevice *pci_dev, Error **errp)
 {
-    NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_CMB_BIR);
-    NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
+    NvmeCtrl *n = NVME(pci_dev);
+    int status;
+    uint64_t bar_size, cmb_offset = 0;
+    uint32_t msix_vectors;
+    uint32_t nvme_pba_offset;
+    uint32_t cmb_size_units;
+
+    msix_vectors = n->params.msix_qsize;
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
+        /* Linux guest requires it to be 2MiB aligned */
+        cmb_offset = QEMU_ALIGN_UP(bar_size, 2 * cmb_size_units);
+
+        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, NVME_MSIX_BIR);
+        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, cmb_offset / cmb_size_units);
+
+        n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
+
+        bar_size += cmb_offset;
+        bar_size += NVME_CMBSZ_GETSIZE(n->bar.cmbsz);
+    }
+
+    bar_size = pow2ceil(bar_size);
+
+    /*
+     * Create memory region for BAR4, then overlap cmb, msix and pba
+     * tables on top of it.
+     */
+    memory_region_init(&n->bar4, OBJECT(n), "nvme-bar4", bar_size);
+
+    if (n->params.cmb_size_mb) {
+        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
+                              "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
 
-    NVME_CMBSZ_SET_SQS(n->bar.cmbsz, 1);
-    NVME_CMBSZ_SET_CQS(n->bar.cmbsz, 0);
-    NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 0);
-    NVME_CMBSZ_SET_RDS(n->bar.cmbsz, 1);
-    NVME_CMBSZ_SET_WDS(n->bar.cmbsz, 1);
-    NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
-    NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
+        memory_region_add_subregion(&n->bar4, cmb_offset, &n->ctrl_mem);
+    }
+
+    status = msix_init(pci_dev, n->params.msix_qsize,
+                       &n->bar4, NVME_MSIX_BIR, 0,
+                       &n->bar4, NVME_MSIX_BIR, nvme_pba_offset,
+                       0, errp);
+
+    if (status) {
+        return;
+    }
 
-    n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-    memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n,
-                          "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
-    pci_register_bar(pci_dev, NVME_CMBLOC_BIR(n->bar.cmbloc),
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
@@ -2126,13 +2170,10 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
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
@@ -2199,6 +2240,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     NVME_CAP_SET_CSS(n->bar.cap, 1);
     NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
     NVME_CAP_SET_CMBS(n->bar.cap, n->params.cmb_size_mb ? 1 : 0);
+    NVME_CAP_SET_PMRS(n->bar.cap, n->pmrdev ? 1 : 0);
 
     n->bar.vs = NVME_SPEC_VER;
     n->bar.intmc = n->bar.intms = 0;
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 0b6a8ae665..f291395cd0 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -91,6 +91,7 @@ typedef struct NvmeCtrl {
     PCIDevice    parent_obj;
     MemoryRegion iomem;
     MemoryRegion ctrl_mem;
+    MemoryRegion bar4;
     NvmeBar      bar;
     BlockConf    conf;
     NvmeParams   params;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index d641ca6649..77b59d18dd 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -217,9 +217,11 @@ enum NvmeCmbszMask {
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


