Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2608DC2D0E2
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 00:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8F62071A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 00:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GFPoHMFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8F62071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKsGJ-0003zI-M2
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 20:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kKsEx-0002Xb-7B
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 20:02:31 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kKsEv-00018A-4E
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 20:02:30 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f6a8f370000>; Tue, 22 Sep 2020 16:56:39 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 23:57:19 +0000
Received: from kwankhede-dev.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 22 Sep 2020 23:57:11 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v26 03/17] vfio: Add save and load functions for VFIO PCI
 devices
Date: Wed, 23 Sep 2020 04:54:05 +0530
Message-ID: <1600817059-26721-4-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
References: <1600817059-26721-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1600818999; bh=fVVKupjBp5nVINBHcjYaq+u4sJhtvT0UMkUJdqNaspU=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:X-NVConfidentiality:MIME-Version:Content-Type;
 b=GFPoHMFGTVrS2FasKVCdR8inmPaJGGsf2jpyq3QXt8J5Hg1ZLqu+8ZWQWN4tHGTsJ
 1cRavVdf2Di7fDRITLtPpjq1w4DnWaW/2KzYGlJx7LMVZYG0coEMg5Vxx1iAKzntkC
 TCbDL/yDPKhE3fIIuJ7NaL+W7/UtQ+c+d7cllrxQsvOmn+8OQcBvE4n99xl4U0F1+S
 fEuBgG+qr40xVtv/rcb66C4Vl40lahTmw9MpnjQhBY4Z9qoR9ZYjgov+KyT6rZkOLD
 6qmENx3BtufapbGo81+t1dK9pTcaj783KE9PsY+R9DV7mK9nFN10gB3dBmJ3VhGndC
 fWCSddUGkE3nw==
Received-SPF: pass client-ip=216.228.121.64; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate25.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 19:57:12
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: cohuck@redhat.com, aik@ozlabs.ru, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, yi.l.liu@intel.com,
 quintela@redhat.com, ziye.yang@intel.com, armbru@redhat.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, felipe@nutanix.com,
 zhi.a.wang@intel.com, kevin.tian@intel.com, yan.y.zhao@intel.com,
 dgilbert@redhat.com, changpeng.liu@intel.com, eskultet@redhat.com,
 Ken.Xue@amd.com, jonathan.davies@nutanix.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These functions save and restore PCI device specific data - config
space of PCI device.
Used VMStateDescription to save and restore interrupt state.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/pci.c                 | 134 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h                 |   1 +
 include/hw/vfio/vfio-common.h |   2 +
 3 files changed, 137 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bffd5bfe3b78..9968cc553391 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -41,6 +41,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "migration/blocker.h"
+#include "migration/qemu-file.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
@@ -2401,11 +2402,142 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
     return OBJECT(vdev);
 }
 
+static int vfio_get_pci_irq_state(QEMUFile *f, void *pv, size_t size,
+                             const VMStateField *field)
+{
+    VFIOPCIDevice *vdev = container_of(pv, VFIOPCIDevice, vbasedev);
+    PCIDevice *pdev = &vdev->pdev;
+    uint32_t interrupt_type;
+
+    interrupt_type = qemu_get_be32(f);
+
+    if (interrupt_type == VFIO_INT_MSI) {
+        uint32_t msi_flags, msi_addr_lo, msi_addr_hi = 0, msi_data;
+        bool msi_64bit;
+
+        /* restore msi configuration */
+        msi_flags = pci_default_read_config(pdev,
+                                            pdev->msi_cap + PCI_MSI_FLAGS, 2);
+        msi_64bit = (msi_flags & PCI_MSI_FLAGS_64BIT);
+
+        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
+                              msi_flags & ~PCI_MSI_FLAGS_ENABLE, 2);
+
+        msi_addr_lo = pci_default_read_config(pdev,
+                                        pdev->msi_cap + PCI_MSI_ADDRESS_LO, 4);
+        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO,
+                              msi_addr_lo, 4);
+
+        if (msi_64bit) {
+            msi_addr_hi = pci_default_read_config(pdev,
+                                        pdev->msi_cap + PCI_MSI_ADDRESS_HI, 4);
+            vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI,
+                                  msi_addr_hi, 4);
+        }
+
+        msi_data = pci_default_read_config(pdev,
+                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
+                2);
+
+        vfio_pci_write_config(pdev,
+                pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
+                msi_data, 2);
+
+        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
+                              msi_flags | PCI_MSI_FLAGS_ENABLE, 2);
+    } else if (interrupt_type == VFIO_INT_MSIX) {
+        uint16_t offset;
+
+        msix_load(pdev, f);
+        offset = pci_default_read_config(pdev,
+                                       pdev->msix_cap + PCI_MSIX_FLAGS + 1, 2);
+        /* load enable bit and maskall bit */
+        vfio_pci_write_config(pdev, pdev->msix_cap + PCI_MSIX_FLAGS + 1,
+                              offset, 2);
+    }
+    return 0;
+}
+
+static int vfio_put_pci_irq_state(QEMUFile *f, void *pv, size_t size,
+                             const VMStateField *field, QJSON *vmdesc)
+{
+    VFIOPCIDevice *vdev = container_of(pv, VFIOPCIDevice, vbasedev);
+    PCIDevice *pdev = &vdev->pdev;
+
+    qemu_put_be32(f, vdev->interrupt);
+    if (vdev->interrupt == VFIO_INT_MSIX) {
+        msix_save(pdev, f);
+    }
+
+    return 0;
+}
+
+static const VMStateInfo vmstate_info_vfio_pci_irq_state = {
+    .name = "VFIO PCI irq state",
+    .get  = vfio_get_pci_irq_state,
+    .put  = vfio_put_pci_irq_state,
+};
+
+const VMStateDescription vmstate_vfio_pci_config = {
+    .name = "VFIOPCIDevice",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT32_POSITIVE_LE(version_id, VFIOPCIDevice),
+        VMSTATE_BUFFER_UNSAFE_INFO(interrupt, VFIOPCIDevice, 1,
+                                   vmstate_info_vfio_pci_irq_state,
+                                   sizeof(int32_t)),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    PCIDevice *pdev = &vdev->pdev;
+
+
+    pci_device_save(pdev, f);
+    vmstate_save_state(f, &vmstate_vfio_pci_config, vbasedev, NULL);
+}
+
+static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    PCIDevice *pdev = &vdev->pdev;
+    uint16_t pci_cmd;
+    int ret, i;
+
+    ret = pci_device_load(pdev, f);
+    if (ret) {
+        return ret;
+    }
+
+    /* retore pci bar configuration */
+    pci_cmd = pci_default_read_config(pdev, PCI_COMMAND, 2);
+    vfio_pci_write_config(pdev, PCI_COMMAND,
+                        pci_cmd & ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY), 2);
+    for (i = 0; i < PCI_ROM_SLOT; i++) {
+        uint32_t bar = pci_default_read_config(pdev,
+                                               PCI_BASE_ADDRESS_0 + i * 4, 4);
+
+        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i * 4, bar, 4);
+    }
+
+    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vbasedev,
+                             vdev->version_id);
+
+    vfio_pci_write_config(pdev, PCI_COMMAND, pci_cmd, 2);
+    return ret;
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
@@ -2755,6 +2887,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vdev->vbasedev.ops = &vfio_pci_ops;
     vdev->vbasedev.type = VFIO_DEVICE_TYPE_PCI;
     vdev->vbasedev.dev = DEVICE(vdev);
+    vdev->vbasedev.device_state = 0;
+    vdev->version_id = 1;
 
     tmp = g_strdup_printf("%s/iommu_group", vdev->vbasedev.sysfsdev);
     len = readlink(tmp, group_path, sizeof(group_path));
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index bce71a9ac93f..9f46af7e153f 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -156,6 +156,7 @@ struct VFIOPCIDevice {
     uint32_t display_yres;
     int32_t bootindex;
     uint32_t igd_gms;
+    int32_t version_id;     /* Version id needed for VMState */
     OffAutoPCIBAR msix_relo;
     uint8_t pm_cap;
     uint8_t nv_gpudirect_clique;
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index fe99c36a693a..ba6169cd926e 100644
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


