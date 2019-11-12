Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414ABC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C7972084E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DD25NvJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7972084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUaM4-0002y9-69
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 12:53:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwankhede@nvidia.com>) id 1iUa98-0002kn-Fc
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwankhede@nvidia.com>) id 1iUa97-00061C-1Y
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:40:06 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
 id 1iUa96-00060t-MK
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 12:40:04 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5dcaed0e0001>; Tue, 12 Nov 2019 09:34:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 12 Nov 2019 09:35:02 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 12 Nov 2019 09:35:02 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 17:35:02 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 12 Nov 2019 17:34:55 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v9 QEMU 06/15] vfio: Add save and load functions for VFIO PCI
 devices
Date: Tue, 12 Nov 2019 22:35:15 +0530
Message-ID: <1573578324-8389-7-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
References: <1573578324-8389-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1573580046; bh=j4/KvWgLLxkgeWa9pGzSN7ktFdT2r2sBXWZ7jLbIoY8=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
 Content-Type;
 b=DD25NvJfP8Q6fl6uEGc8j74XzaUCe75QkgS6B/cCjuo21XOtnCdkCnyFGfFPcqPXY
 8qhEpWLAH1yDMggr2Dn2NL3SsNGoWWb2LGw8qey6DgLI+3Au86tVb4OdopZSZMH8oF
 dtw6pWwwDRuL8mNxRWE2ekbhXcL/E9e77RZHtPab0361sSfnFbHB3yIW3g85tn9vXm
 CYAbPGzK3TU8TL8KXt9sMSH6vC20CxOreZNQlO8p3MK56qEmzrT/UMeWIO2yWdkEXW
 5zV6yic9UkCY+QPJ8HTVevPWjShcTMStmajTRchNu8U9QaXyTUF4caNgfWznCb/s7Y
 uMvpJCc71SVIw==
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 216.228.121.65
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yan.y.zhao@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These functions save and restore PCI device specific data - config
space of PCI device.
Tested save and restore with MSI and MSIX type.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/pci.c                 | 168 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |   2 +
 2 files changed, 170 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4ae02e71622a..2c22cca0c3be 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -41,6 +41,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "migration/blocker.h"
+#include "migration/qemu-file.h"
 
 #define TYPE_VFIO_PCI "vfio-pci"
 #define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
@@ -1620,6 +1621,55 @@ static void vfio_bars_prepare(VFIOPCIDevice *vdev)
     }
 }
 
+static int vfio_bar_validate(VFIOPCIDevice *vdev, int nr)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOBAR *bar = &vdev->bars[nr];
+    uint64_t addr;
+    uint32_t addr_lo, addr_hi = 0;
+
+    /* Skip unimplemented BARs and the upper half of 64bit BARS. */
+    if (!bar->size) {
+        return 0;
+    }
+
+    /* skip IO BAR */
+    if (bar->ioport) {
+        return 0;
+    }
+
+    addr_lo = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + nr * 4, 4);
+
+    addr_lo = addr_lo & (bar->ioport ? PCI_BASE_ADDRESS_IO_MASK :
+                                       PCI_BASE_ADDRESS_MEM_MASK);
+    if (bar->type == PCI_BASE_ADDRESS_MEM_TYPE_64) {
+        addr_hi = pci_default_read_config(pdev,
+                                         PCI_BASE_ADDRESS_0 + (nr + 1) * 4, 4);
+    }
+
+    addr = ((uint64_t)addr_hi << 32) | addr_lo;
+
+    if (!QEMU_IS_ALIGNED(addr, bar->size)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int vfio_bars_validate(VFIOPCIDevice *vdev)
+{
+    int i, ret;
+
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        ret = vfio_bar_validate(vdev, i);
+        if (ret) {
+            error_report("vfio: BAR address %d validation failed", i);
+            return ret;
+        }
+    }
+    return 0;
+}
+
 static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
 {
     VFIOBAR *bar = &vdev->bars[nr];
@@ -2402,11 +2452,129 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
     return OBJECT(vdev);
 }
 
+static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    PCIDevice *pdev = &vdev->pdev;
+    uint16_t pci_cmd;
+    int i;
+
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        uint32_t bar;
+
+        bar = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, 4);
+        qemu_put_be32(f, bar);
+    }
+
+    qemu_put_be32(f, vdev->interrupt);
+    if (vdev->interrupt == VFIO_INT_MSI) {
+        uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
+        bool msi_64bit;
+
+        msi_flags = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
+                                            2);
+        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
+
+        msi_addr_lo = pci_default_read_config(pdev,
+                                         pdev->msi_cap + PCI_MSI_ADDRESS_LO, 4);
+        qemu_put_be32(f, msi_addr_lo);
+
+        if (msi_64bit) {
+            msi_addr_hi = pci_default_read_config(pdev,
+                                             pdev->msi_cap + PCI_MSI_ADDRESS_HI,
+                                             4);
+        }
+        qemu_put_be32(f, msi_addr_hi);
+
+        msi_data = pci_default_read_config(pdev,
+                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
+                2);
+        qemu_put_be32(f, msi_data);
+    } else if (vdev->interrupt == VFIO_INT_MSIX) {
+        uint16_t offset;
+
+        /* save enable bit and maskall bit */
+        offset = pci_default_read_config(pdev,
+                                       pdev->msix_cap + PCI_MSIX_FLAGS + 1, 2);
+        qemu_put_be16(f, offset);
+        msix_save(pdev, f);
+    }
+    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
+    qemu_put_be16(f, pci_cmd);
+}
+
+static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    PCIDevice *pdev = &vdev->pdev;
+    uint32_t interrupt_type;
+    uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
+    uint16_t pci_cmd;
+    bool msi_64bit;
+    int i, ret;
+
+    /* retore pci bar configuration */
+    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
+    vfio_pci_write_config(pdev, PCI_COMMAND,
+                        pci_cmd & (!(PCI_COMMAND_IO | PCI_COMMAND_MEMORY)), 2);
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        uint32_t bar = qemu_get_be32(f);
+
+        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, bar, 4);
+    }
+
+    ret = vfio_bars_validate(vdev);
+    if (ret) {
+        return ret;
+    }
+
+    interrupt_type = qemu_get_be32(f);
+
+    if (interrupt_type == VFIO_INT_MSI) {
+        /* restore msi configuration */
+        msi_flags = pci_default_read_config(pdev,
+                                            pdev->msi_cap + PCI_MSI_FLAGS, 2);
+        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
+
+        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
+                              msi_flags & (!PCI_MSI_FLAGS_ENABLE), 2);
+
+        msi_addr_lo = qemu_get_be32(f);
+        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO,
+                              msi_addr_lo, 4);
+
+        msi_addr_hi = qemu_get_be32(f);
+        if (msi_64bit) {
+            vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI,
+                                  msi_addr_hi, 4);
+        }
+        msi_data = qemu_get_be32(f);
+        vfio_pci_write_config(pdev,
+                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
+                msi_data, 2);
+
+        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
+                              msi_flags | PCI_MSI_FLAGS_ENABLE, 2);
+    } else if (interrupt_type == VFIO_INT_MSIX) {
+        uint16_t offset = qemu_get_be16(f);
+
+        /* load enable bit and maskall bit */
+        vfio_pci_write_config(pdev, pdev->msix_cap + PCI_MSIX_FLAGS + 1,
+                              offset, 2);
+        msix_load(pdev, f);
+    }
+    pci_cmd = qemu_get_be16(f);
+    vfio_pci_write_config(pdev, PCI_COMMAND, pci_cmd, 2);
+    return 0;
+}
+
 static VFIODeviceOps vfio_pci_ops = {
     .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
     .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
     .vfio_eoi = vfio_intx_eoi,
     .vfio_get_object = vfio_pci_get_object,
+    .vfio_save_config = vfio_pci_save_config,
+    .vfio_load_config = vfio_pci_load_config,
 };
 
 int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 74261feaeac9..d69a7f3ae31e 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -120,6 +120,8 @@ struct VFIODeviceOps {
     int (*vfio_hot_reset_multi)(VFIODevice *vdev);
     void (*vfio_eoi)(VFIODevice *vdev);
     Object *(*vfio_get_object)(VFIODevice *vdev);
+    void (*vfio_save_config)(VFIODevice *vdev, QEMUFile *f);
+    int (*vfio_load_config)(VFIODevice *vdev, QEMUFile *f);
 };
 
 typedef struct VFIOGroup {
-- 
2.7.0


