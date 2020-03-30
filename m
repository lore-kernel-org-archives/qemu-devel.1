Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54394C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F9C2073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F9C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxj4-0004Qg-6u
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jIxht-0002bp-OF
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jIxhr-0000bZ-6O
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:56:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:55948)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrzej.jakowski@linux.intel.com>)
 id 1jIxhk-0007nO-Cw; Mon, 30 Mar 2020 12:56:04 -0400
IronPort-SDR: nevVBwZGR5SMSGfdwXMzcKieI6Mp+Xnedlt3Wy2SLFTa4V3nU4pIMpS6fUQOyvQNQCa9k4GFeX
 Br2PBga3FPuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 09:46:16 -0700
IronPort-SDR: mNmLfndxX5gfoZY/wCU4JNg3D49khcWhYuKrNgI5rPC1w/6+qJqAH+Z+HYeUI03V70n07tEeni
 ZA1xnMzcCr+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; d="scan'208";a="237403318"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.28.117])
 by orsmga007.jf.intel.com with ESMTP; 30 Mar 2020 09:46:15 -0700
From: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
To: kbusch@kernel.org,
	kwolf@redhat.com,
	mreitz@redhat.com
Subject: [PATCH RESEND v4] nvme: introduce PMR support from NVMe 1.4 spec
Date: Mon, 30 Mar 2020 09:46:56 -0700
Message-Id: <20200330164656.9348-1-andrzej.jakowski@linux.intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.24
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
Cc: haozhong.zhang@intel.com,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>, qemu-block@nongnu.org,
 stefanha@gmail.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 yi.z.zhang@linux.intel.com, junyan.he@intel.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch introduces support for PMR that has been defined as part of NVMe 1.4
spec. User can now specify a pmrdev option that should point to HostMemoryBackend.
pmrdev memory region will subsequently be exposed as PCI BAR 2 in emulated NVMe
device. Guest OS can perform mmio read and writes to the PMR region that will stay
persistent across system reboot.

Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Changelog:

v4:
 - replaced qemu_msync() use with qemu_ram_writeback() to allow pmem_persist()
   or qemu_msync() be called depending on configuration [4] (Stefan)

 - rephrased comments to improve clarity and fixed code style issues [4]
   (Stefan, Klaus)

v3:
 - reworked PMR to use HostMemoryBackend instead of directly mapping PMR
   backend file into qemu [1] (Stefan)

v2:
 - provided support for Bit 1 from PMRWBM register instead of Bit 0 to ensure
   improved performance in virtualized environment [2] (Stefan)

 - added check if pmr size is power of two in size [3] (David)

 - addressed cross compilation build problems reported by CI environment

v1:
 - inital push of PMR emulation

[1]: https://lore.kernel.org/qemu-devel/20200306223853.37958-1-andrzej.jakowski@linux.intel.com/
[2]: https://nvmexpress.org/wp-content/uploads/NVM-Express-1_4-2019.06.10-Ratified.pdf
[3]: https://lore.kernel.org/qemu-devel/20200218224811.30050-1-andrzej.jakowski@linux.intel.com/
[4]: https://lore.kernel.org/qemu-devel/20200318200303.11322-1-andrzej.jakowski@linux.intel.com/
 
---
Persistent Memory Region (PMR) is a new optional feature provided in NVMe 1.4
specification. This patch implements initial support for it in NVMe driver.
---
 hw/block/Makefile.objs |   2 +-
 hw/block/nvme.c        | 109 ++++++++++++++++++++++++++
 hw/block/nvme.h        |   2 +
 hw/block/trace-events  |   4 +
 include/block/nvme.h   | 172 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 288 insertions(+), 1 deletion(-)

diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index 4b4a2b338d..47960b5f0d 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -7,12 +7,12 @@ common-obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
 common-obj-$(CONFIG_XEN) += xen-block.o
 common-obj-$(CONFIG_ECC) += ecc.o
 common-obj-$(CONFIG_ONENAND) += onenand.o
-common-obj-$(CONFIG_NVME_PCI) += nvme.o
 common-obj-$(CONFIG_SWIM) += swim.o
 
 common-obj-$(CONFIG_SH4) += tc58128.o
 
 obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
+obj-$(CONFIG_NVME_PCI) += nvme.o
 
 obj-y += dataplane/
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d28335cbf3..9b453423cf 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -19,10 +19,19 @@
  *      -drive file=<file>,if=none,id=<drive_id>
  *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
  *              cmb_size_mb=<cmb_size_mb[optional]>, \
+ *              [pmrdev=<mem_backend_file_id>,] \
  *              num_queues=<N[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
+ *
+ * cmb_size_mb= and pmrdev= options are mutually exclusive due to limitation
+ * in available BAR's. cmb_size_mb= will take precedence over pmrdev= when
+ * both provided.
+ * Enabling pmr emulation can be achieved by pointing to memory-backend-file.
+ * For example:
+ * -object memory-backend-file,id=<mem_id>,share=on,mem-path=<file_path>, \
+ *  size=<size> .... -device nvme,...,pmrdev=<mem_id>
  */
 
 #include "qemu/osdep.h"
@@ -35,7 +44,9 @@
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "sysemu/hostmem.h"
 #include "sysemu/block-backend.h"
+#include "exec/ram_addr.h"
 
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -1141,6 +1152,26 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
         NVME_GUEST_ERR(nvme_ub_mmiowr_cmbsz_readonly,
                        "invalid write to read only CMBSZ, ignored");
         return;
+    case 0xE00: /* PMRCAP */
+        NVME_GUEST_ERR(nvme_ub_mmiowr_pmrcap_readonly,
+                       "invalid write to PMRCAP register, ignored");
+        return;
+    case 0xE04: /* TODO PMRCTL */
+        break;
+    case 0xE08: /* PMRSTS */
+        NVME_GUEST_ERR(nvme_ub_mmiowr_pmrsts_readonly,
+                       "invalid write to PMRSTS register, ignored");
+        return;
+    case 0xE0C: /* PMREBS */
+        NVME_GUEST_ERR(nvme_ub_mmiowr_pmrebs_readonly,
+                       "invalid write to PMREBS register, ignored");
+        return;
+    case 0xE10: /* PMRSWTP */
+        NVME_GUEST_ERR(nvme_ub_mmiowr_pmrswtp_readonly,
+                       "invalid write to PMRSWTP register, ignored");
+        return;
+    case 0xE14: /* TODO PMRMSC */
+         break;
     default:
         NVME_GUEST_ERR(nvme_ub_mmiowr_invalid,
                        "invalid MMIO write,"
@@ -1169,6 +1200,16 @@ static uint64_t nvme_mmio_read(void *opaque, hwaddr addr, unsigned size)
     }
 
     if (addr < sizeof(n->bar)) {
+        /*
+         * When PMRWBM bit 1 is set then read from
+         * from PMRSTS should ensure prior writes
+         * made it to persistent media
+         */
+        if (addr == 0xE08 &&
+            (NVME_PMRCAP_PMRWBM(n->bar.pmrcap) & 0x02)) {
+            qemu_ram_writeback(n->pmrdev->mr.ram_block,
+                               0, n->pmrdev->size);
+        }
         memcpy(&val, ptr + addr, size);
     } else {
         NVME_GUEST_ERR(nvme_ub_mmiord_invalid_ofs,
@@ -1332,6 +1373,23 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         error_setg(errp, "serial property not set");
         return;
     }
+
+    if (!n->cmb_size_mb && n->pmrdev) {
+        if (host_memory_backend_is_mapped(n->pmrdev)) {
+            char *path = object_get_canonical_path_component(OBJECT(n->pmrdev));
+            error_setg(errp, "can't use already busy memdev: %s", path);
+            g_free(path);
+            return;
+        }
+
+        if (!is_power_of_2(n->pmrdev->size)) {
+            error_setg(errp, "pmr backend size needs to be power of 2 in size");
+            return;
+        }
+
+        host_memory_backend_set_mapped(n->pmrdev, true);
+    }
+
     blkconf_blocksizes(&n->conf);
     if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
                                        false, errp)) {
@@ -1415,6 +1473,51 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
             PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
             PCI_BASE_ADDRESS_MEM_PREFETCH, &n->ctrl_mem);
 
+    } else if (n->pmrdev) {
+        /* Controller Capabilities register */
+        NVME_CAP_SET_PMRS(n->bar.cap, 1);
+
+        /* PMR Capabities register */
+        n->bar.pmrcap = 0;
+        NVME_PMRCAP_SET_RDS(n->bar.pmrcap, 0);
+        NVME_PMRCAP_SET_WDS(n->bar.pmrcap, 0);
+        NVME_PMRCAP_SET_BIR(n->bar.pmrcap, 2);
+        NVME_PMRCAP_SET_PMRTU(n->bar.pmrcap, 0);
+        /* Turn on bit 1 support */
+        NVME_PMRCAP_SET_PMRWBM(n->bar.pmrcap, 0x02);
+        NVME_PMRCAP_SET_PMRTO(n->bar.pmrcap, 0);
+        NVME_PMRCAP_SET_CMSS(n->bar.pmrcap, 0);
+
+        /* PMR Control register */
+        n->bar.pmrctl = 0;
+        NVME_PMRCTL_SET_EN(n->bar.pmrctl, 0);
+
+        /* PMR Status register */
+        n->bar.pmrsts = 0;
+        NVME_PMRSTS_SET_ERR(n->bar.pmrsts, 0);
+        NVME_PMRSTS_SET_NRDY(n->bar.pmrsts, 0);
+        NVME_PMRSTS_SET_HSTS(n->bar.pmrsts, 0);
+        NVME_PMRSTS_SET_CBAI(n->bar.pmrsts, 0);
+
+        /* PMR Elasticity Buffer Size register */
+        n->bar.pmrebs = 0;
+        NVME_PMREBS_SET_PMRSZU(n->bar.pmrebs, 0);
+        NVME_PMREBS_SET_RBB(n->bar.pmrebs, 0);
+        NVME_PMREBS_SET_PMRWBZ(n->bar.pmrebs, 0);
+
+        /* PMR Sustained Write Throughput register */
+        n->bar.pmrswtp = 0;
+        NVME_PMRSWTP_SET_PMRSWTU(n->bar.pmrswtp, 0);
+        NVME_PMRSWTP_SET_PMRSWTV(n->bar.pmrswtp, 0);
+
+        /* PMR Memory Space Control register */
+        n->bar.pmrmsc = 0;
+        NVME_PMRMSC_SET_CMSE(n->bar.pmrmsc, 0);
+        NVME_PMRMSC_SET_CBA(n->bar.pmrmsc, 0);
+
+        pci_register_bar(pci_dev, NVME_PMRCAP_BIR(n->bar.pmrcap),
+            PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64 |
+            PCI_BASE_ADDRESS_MEM_PREFETCH, &n->pmrdev->mr);
     }
 
     for (i = 0; i < n->num_namespaces; i++) {
@@ -1445,11 +1548,17 @@ static void nvme_exit(PCIDevice *pci_dev)
     if (n->cmb_size_mb) {
         g_free(n->cmbuf);
     }
+
+    if (n->pmrdev) {
+        host_memory_backend_set_mapped(n->pmrdev, false);
+    }
     msix_uninit_exclusive_bar(pci_dev);
 }
 
 static Property nvme_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
+    DEFINE_PROP_LINK("pmrdev", NvmeCtrl, pmrdev, TYPE_MEMORY_BACKEND,
+                     HostMemoryBackend *),
     DEFINE_PROP_STRING("serial", NvmeCtrl, serial),
     DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, cmb_size_mb, 0),
     DEFINE_PROP_UINT32("num_queues", NvmeCtrl, num_queues, 64),
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 557194ee19..6520a9f0be 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -83,6 +83,8 @@ typedef struct NvmeCtrl {
     uint64_t    timestamp_set_qemu_clock_ms;    /* QEMU clock time */
 
     char            *serial;
+    HostMemoryBackend *pmrdev;
+
     NvmeNamespace   *namespaces;
     NvmeSQueue      **sq;
     NvmeCQueue      **cq;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index bf6d11b58b..aca54bda14 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -110,6 +110,10 @@ nvme_ub_mmiowr_ssreset_w1c_unsupported(void) "attempted to W1C CSTS.NSSRO but CA
 nvme_ub_mmiowr_ssreset_unsupported(void) "attempted NVM subsystem reset but CAP.NSSRS is zero (not supported)"
 nvme_ub_mmiowr_cmbloc_reserved(void) "invalid write to reserved CMBLOC when CMBSZ is zero, ignored"
 nvme_ub_mmiowr_cmbsz_readonly(void) "invalid write to read only CMBSZ, ignored"
+nvme_ub_mmiowr_pmrcap_readonly(void) "invalid write to read only PMRCAP, ignored"
+nvme_ub_mmiowr_pmrsts_readonly(void) "invalid write to read only PMRSTS, ignored"
+nvme_ub_mmiowr_pmrebs_readonly(void) "invalid write to read only PMREBS, ignored"
+nvme_ub_mmiowr_pmrswtp_readonly(void) "invalid write to read only PMRSWTP, ignored"
 nvme_ub_mmiowr_invalid(uint64_t offset, uint64_t data) "invalid MMIO write, offset=0x%"PRIx64", data=0x%"PRIx64""
 nvme_ub_mmiord_misaligned32(uint64_t offset) "MMIO read not 32-bit aligned, offset=0x%"PRIx64""
 nvme_ub_mmiord_toosmall(uint64_t offset) "MMIO read smaller than 32-bits, offset=0x%"PRIx64""
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 8fb941c653..5525c8e343 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -15,6 +15,13 @@ typedef struct NvmeBar {
     uint64_t    acq;
     uint32_t    cmbloc;
     uint32_t    cmbsz;
+    uint8_t     padding[3520]; /* not used by QEMU */
+    uint32_t    pmrcap;
+    uint32_t    pmrctl;
+    uint32_t    pmrsts;
+    uint32_t    pmrebs;
+    uint32_t    pmrswtp;
+    uint32_t    pmrmsc;
 } NvmeBar;
 
 enum NvmeCapShift {
@@ -27,6 +34,7 @@ enum NvmeCapShift {
     CAP_CSS_SHIFT      = 37,
     CAP_MPSMIN_SHIFT   = 48,
     CAP_MPSMAX_SHIFT   = 52,
+    CAP_PMR_SHIFT      = 56,
 };
 
 enum NvmeCapMask {
@@ -39,6 +47,7 @@ enum NvmeCapMask {
     CAP_CSS_MASK       = 0xff,
     CAP_MPSMIN_MASK    = 0xf,
     CAP_MPSMAX_MASK    = 0xf,
+    CAP_PMR_MASK       = 0x1,
 };
 
 #define NVME_CAP_MQES(cap)  (((cap) >> CAP_MQES_SHIFT)   & CAP_MQES_MASK)
@@ -69,6 +78,8 @@ enum NvmeCapMask {
                                                            << CAP_MPSMIN_SHIFT)
 #define NVME_CAP_SET_MPSMAX(cap, val) (cap |= (uint64_t)(val & CAP_MPSMAX_MASK)\
                                                             << CAP_MPSMAX_SHIFT)
+#define NVME_CAP_SET_PMRS(cap, val) (cap |= (uint64_t)(val & CAP_PMR_MASK)\
+                                                            << CAP_PMR_SHIFT)
 
 enum NvmeCcShift {
     CC_EN_SHIFT     = 0,
@@ -205,6 +216,167 @@ enum NvmeCmbszMask {
 #define NVME_CMBSZ_GETSIZE(cmbsz) \
     (NVME_CMBSZ_SZ(cmbsz) * (1 << (12 + 4 * NVME_CMBSZ_SZU(cmbsz))))
 
+enum NvmePmrcapShift {
+    PMRCAP_RDS_SHIFT      = 3,
+    PMRCAP_WDS_SHIFT      = 4,
+    PMRCAP_BIR_SHIFT      = 5,
+    PMRCAP_PMRTU_SHIFT    = 8,
+    PMRCAP_PMRWBM_SHIFT   = 10,
+    PMRCAP_PMRTO_SHIFT    = 16,
+    PMRCAP_CMSS_SHIFT     = 24,
+};
+
+enum NvmePmrcapMask {
+    PMRCAP_RDS_MASK      = 0x1,
+    PMRCAP_WDS_MASK      = 0x1,
+    PMRCAP_BIR_MASK      = 0x7,
+    PMRCAP_PMRTU_MASK    = 0x3,
+    PMRCAP_PMRWBM_MASK   = 0xf,
+    PMRCAP_PMRTO_MASK    = 0xff,
+    PMRCAP_CMSS_MASK     = 0x1,
+};
+
+#define NVME_PMRCAP_RDS(pmrcap)    \
+    ((pmrcap >> PMRCAP_RDS_SHIFT)   & PMRCAP_RDS_MASK)
+#define NVME_PMRCAP_WDS(pmrcap)    \
+    ((pmrcap >> PMRCAP_WDS_SHIFT)   & PMRCAP_WDS_MASK)
+#define NVME_PMRCAP_BIR(pmrcap)    \
+    ((pmrcap >> PMRCAP_BIR_SHIFT)   & PMRCAP_BIR_MASK)
+#define NVME_PMRCAP_PMRTU(pmrcap)    \
+    ((pmrcap >> PMRCAP_PMRTU_SHIFT)   & PMRCAP_PMRTU_MASK)
+#define NVME_PMRCAP_PMRWBM(pmrcap)    \
+    ((pmrcap >> PMRCAP_PMRWBM_SHIFT)   & PMRCAP_PMRWBM_MASK)
+#define NVME_PMRCAP_PMRTO(pmrcap)    \
+    ((pmrcap >> PMRCAP_PMRTO_SHIFT)   & PMRCAP_PMRTO_MASK)
+#define NVME_PMRCAP_CMSS(pmrcap)    \
+    ((pmrcap >> PMRCAP_CMSS_SHIFT)   & PMRCAP_CMSS_MASK)
+
+#define NVME_PMRCAP_SET_RDS(pmrcap, val)   \
+    (pmrcap |= (uint64_t)(val & PMRCAP_RDS_MASK) << PMRCAP_RDS_SHIFT)
+#define NVME_PMRCAP_SET_WDS(pmrcap, val)   \
+    (pmrcap |= (uint64_t)(val & PMRCAP_WDS_MASK) << PMRCAP_WDS_SHIFT)
+#define NVME_PMRCAP_SET_BIR(pmrcap, val)   \
+    (pmrcap |= (uint64_t)(val & PMRCAP_BIR_MASK) << PMRCAP_BIR_SHIFT)
+#define NVME_PMRCAP_SET_PMRTU(pmrcap, val)   \
+    (pmrcap |= (uint64_t)(val & PMRCAP_PMRTU_MASK) << PMRCAP_PMRTU_SHIFT)
+#define NVME_PMRCAP_SET_PMRWBM(pmrcap, val)   \
+    (pmrcap |= (uint64_t)(val & PMRCAP_PMRWBM_MASK) << PMRCAP_PMRWBM_SHIFT)
+#define NVME_PMRCAP_SET_PMRTO(pmrcap, val)   \
+    (pmrcap |= (uint64_t)(val & PMRCAP_PMRTO_MASK) << PMRCAP_PMRTO_SHIFT)
+#define NVME_PMRCAP_SET_CMSS(pmrcap, val)   \
+    (pmrcap |= (uint64_t)(val & PMRCAP_CMSS_MASK) << PMRCAP_CMSS_SHIFT)
+
+enum NvmePmrctlShift {
+    PMRCTL_EN_SHIFT   = 0,
+};
+
+enum NvmePmrctlMask {
+    PMRCTL_EN_MASK   = 0x1,
+};
+
+#define NVME_PMRCTL_EN(pmrctl)  ((pmrctl >> PMRCTL_EN_SHIFT)   & PMRCTL_EN_MASK)
+
+#define NVME_PMRCTL_SET_EN(pmrctl, val)   \
+    (pmrctl |= (uint64_t)(val & PMRCTL_EN_MASK) << PMRCTL_EN_SHIFT)
+
+enum NvmePmrstsShift {
+    PMRSTS_ERR_SHIFT    = 0,
+    PMRSTS_NRDY_SHIFT   = 8,
+    PMRSTS_HSTS_SHIFT   = 9,
+    PMRSTS_CBAI_SHIFT   = 12,
+};
+
+enum NvmePmrstsMask {
+    PMRSTS_ERR_MASK    = 0xff,
+    PMRSTS_NRDY_MASK   = 0x1,
+    PMRSTS_HSTS_MASK   = 0x7,
+    PMRSTS_CBAI_MASK   = 0x1,
+};
+
+#define NVME_PMRSTS_ERR(pmrsts)     \
+    ((pmrsts >> PMRSTS_ERR_SHIFT)   & PMRSTS_ERR_MASK)
+#define NVME_PMRSTS_NRDY(pmrsts)    \
+    ((pmrsts >> PMRSTS_NRDY_SHIFT)   & PMRSTS_NRDY_MASK)
+#define NVME_PMRSTS_HSTS(pmrsts)    \
+    ((pmrsts >> PMRSTS_HSTS_SHIFT)   & PMRSTS_HSTS_MASK)
+#define NVME_PMRSTS_CBAI(pmrsts)    \
+    ((pmrsts >> PMRSTS_CBAI_SHIFT)   & PMRSTS_CBAI_MASK)
+
+#define NVME_PMRSTS_SET_ERR(pmrsts, val)   \
+    (pmrsts |= (uint64_t)(val & PMRSTS_ERR_MASK) << PMRSTS_ERR_SHIFT)
+#define NVME_PMRSTS_SET_NRDY(pmrsts, val)   \
+    (pmrsts |= (uint64_t)(val & PMRSTS_NRDY_MASK) << PMRSTS_NRDY_SHIFT)
+#define NVME_PMRSTS_SET_HSTS(pmrsts, val)   \
+    (pmrsts |= (uint64_t)(val & PMRSTS_HSTS_MASK) << PMRSTS_HSTS_SHIFT)
+#define NVME_PMRSTS_SET_CBAI(pmrsts, val)   \
+    (pmrsts |= (uint64_t)(val & PMRSTS_CBAI_MASK) << PMRSTS_CBAI_SHIFT)
+
+enum NvmePmrebsShift {
+    PMREBS_PMRSZU_SHIFT   = 0,
+    PMREBS_RBB_SHIFT      = 4,
+    PMREBS_PMRWBZ_SHIFT   = 8,
+};
+
+enum NvmePmrebsMask {
+    PMREBS_PMRSZU_MASK   = 0xf,
+    PMREBS_RBB_MASK      = 0x1,
+    PMREBS_PMRWBZ_MASK   = 0xffffff,
+};
+
+#define NVME_PMREBS_PMRSZU(pmrebs)  \
+    ((pmrebs >> PMREBS_PMRSZU_SHIFT)   & PMREBS_PMRSZU_MASK)
+#define NVME_PMREBS_RBB(pmrebs)     \
+    ((pmrebs >> PMREBS_RBB_SHIFT)   & PMREBS_RBB_MASK)
+#define NVME_PMREBS_PMRWBZ(pmrebs)  \
+    ((pmrebs >> PMREBS_PMRWBZ_SHIFT)   & PMREBS_PMRWBZ_MASK)
+
+#define NVME_PMREBS_SET_PMRSZU(pmrebs, val)   \
+    (pmrebs |= (uint64_t)(val & PMREBS_PMRSZU_MASK) << PMREBS_PMRSZU_SHIFT)
+#define NVME_PMREBS_SET_RBB(pmrebs, val)   \
+    (pmrebs |= (uint64_t)(val & PMREBS_RBB_MASK) << PMREBS_RBB_SHIFT)
+#define NVME_PMREBS_SET_PMRWBZ(pmrebs, val)   \
+    (pmrebs |= (uint64_t)(val & PMREBS_PMRWBZ_MASK) << PMREBS_PMRWBZ_SHIFT)
+
+enum NvmePmrswtpShift {
+    PMRSWTP_PMRSWTU_SHIFT   = 0,
+    PMRSWTP_PMRSWTV_SHIFT   = 8,
+};
+
+enum NvmePmrswtpMask {
+    PMRSWTP_PMRSWTU_MASK   = 0xf,
+    PMRSWTP_PMRSWTV_MASK   = 0xffffff,
+};
+
+#define NVME_PMRSWTP_PMRSWTU(pmrswtp)   \
+    ((pmrswtp >> PMRSWTP_PMRSWTU_SHIFT)   & PMRSWTP_PMRSWTU_MASK)
+#define NVME_PMRSWTP_PMRSWTV(pmrswtp)   \
+    ((pmrswtp >> PMRSWTP_PMRSWTV_SHIFT)   & PMRSWTP_PMRSWTV_MASK)
+
+#define NVME_PMRSWTP_SET_PMRSWTU(pmrswtp, val)   \
+    (pmrswtp |= (uint64_t)(val & PMRSWTP_PMRSWTU_MASK) << PMRSWTP_PMRSWTU_SHIFT)
+#define NVME_PMRSWTP_SET_PMRSWTV(pmrswtp, val)   \
+    (pmrswtp |= (uint64_t)(val & PMRSWTP_PMRSWTV_MASK) << PMRSWTP_PMRSWTV_SHIFT)
+
+enum NvmePmrmscShift {
+    PMRMSC_CMSE_SHIFT   = 1,
+    PMRMSC_CBA_SHIFT    = 12,
+};
+
+enum NvmePmrmscMask {
+    PMRMSC_CMSE_MASK   = 0x1,
+    PMRMSC_CBA_MASK    = 0xfffffffffffff,
+};
+
+#define NVME_PMRMSC_CMSE(pmrmsc)    \
+    ((pmrmsc >> PMRMSC_CMSE_SHIFT)   & PMRMSC_CMSE_MASK)
+#define NVME_PMRMSC_CBA(pmrmsc)     \
+    ((pmrmsc >> PMRMSC_CBA_SHIFT)   & PMRMSC_CBA_MASK)
+
+#define NVME_PMRMSC_SET_CMSE(pmrmsc, val)   \
+    (pmrmsc |= (uint64_t)(val & PMRMSC_CMSE_MASK) << PMRMSC_CMSE_SHIFT)
+#define NVME_PMRMSC_SET_CBA(pmrmsc, val)   \
+    (pmrmsc |= (uint64_t)(val & PMRMSC_CBA_MASK) << PMRMSC_CBA_SHIFT)
+
 typedef struct NvmeCmd {
     uint8_t     opcode;
     uint8_t     fuse;
-- 
2.21.1


