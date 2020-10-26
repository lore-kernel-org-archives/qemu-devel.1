Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74186C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37172076D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="i/Hqc4O7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37172076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzkR-0007hk-NM
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWzSU-000851-8W
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:10:34 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kWzSQ-00087Z-SE
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:10:33 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f96a07e0003>; Mon, 26 Oct 2020 03:10:06 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 10:10:19 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Oct 2020 10:10:11 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v29 03/17] vfio: Add save and load functions for VFIO PCI
 devices
Date: Mon, 26 Oct 2020 15:06:13 +0530
Message-ID: <1603704987-20977-4-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1603704987-20977-1-git-send-email-kwankhede@nvidia.com>
References: <1603704987-20977-1-git-send-email-kwankhede@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603707006; bh=wFYJR3j7Lma3d+9P6CvA7wH3CuJoeUz+IV88m4558PE=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:X-NVConfidentiality:MIME-Version:Content-Type;
 b=i/Hqc4O7OmdSNKXQxurQVCblPiOh2k3+KD+Vo9lm1pk7EwoNw105ARzipGFRvluj3
 rSWAQQXBXfSxp+r0ZKMJByf8ocYmIXsIrutWcbYXvin2jrwPTpYPzitoXKlmBdqLOw
 wlVJe0np/GMTYiAxvm/azznVBaK6boAkZk7mN+r20NMD0A2UOF5iiT/VETtoTiVWvJ
 vRXW4qEmGt778anjI1qwdwX7SGtOQDyRo00r3yvr/7aIII9eaLNSwwtP7jkptGj4sq
 Z9LMZGEm9c15GDhPeaAm9XKt70OpkyjLTsOBXOOQcUNisV+Fp+tSe7d+tmxgE5RX6/
 /ciBobtxsSh9Q==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 06:10:16
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: cohuck@redhat.com, zhi.wang.linux@gmail.com, aik@ozlabs.ru,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, peterx@redhat.com,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, artemp@nvidia.com,
 yi.l.liu@intel.com, quintela@redhat.com, ziye.yang@intel.com,
 armbru@redhat.com, mlevitsk@redhat.com, pasic@linux.ibm.com,
 felipe@nutanix.com, zhi.a.wang@intel.com, mcrossley@nvidia.com,
 kevin.tian@intel.com, yan.y.zhao@intel.com, dgilbert@redhat.com,
 changpeng.liu@intel.com, eskultet@redhat.com, Ken.Xue@amd.com,
 jonathan.davies@nutanix.com, pbonzini@redhat.com, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added functions to save and restore PCI device specific data,
specifically config space of PCI device.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/pci.c                 | 51 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-common.h |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bffd5bfe3b78..e27c88be6d85 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -41,6 +41,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "migration/blocker.h"
+#include "migration/qemu-file.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
@@ -2401,11 +2402,61 @@ static Object *vfio_pci_get_object(VFIODevice *vbasedev)
     return OBJECT(vdev);
 }
 
+static bool vfio_msix_present(void *opaque, int version_id)
+{
+    PCIDevice *pdev = opaque;
+
+    return msix_present(pdev);
+}
+
+const VMStateDescription vmstate_vfio_pci_config = {
+    .name = "VFIOPCIDevice",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
+        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+
+    vmstate_save_state(f, &vmstate_vfio_pci_config, vdev, NULL);
+}
+
+static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
+{
+    VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    PCIDevice *pdev = &vdev->pdev;
+    int ret;
+
+    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
+    if (ret) {
+        return ret;
+    }
+
+    vfio_pci_write_config(pdev, PCI_COMMAND,
+                          pci_get_word(pdev->config + PCI_COMMAND), 2);
+
+    if (msi_enabled(pdev)) {
+        vfio_msi_enable(vdev);
+    } else if (msix_enabled(pdev)) {
+        vfio_msix_enable(vdev);
+    }
+
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


