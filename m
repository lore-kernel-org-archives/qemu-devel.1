Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D105DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 03:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E44A208B8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 03:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E44A208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je95T-0002R5-So
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 23:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1je94h-000171-JY
 for qemu-devel@nongnu.org; Wed, 27 May 2020 23:19:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:32183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1je94e-00022M-Vn
 for qemu-devel@nongnu.org; Wed, 27 May 2020 23:19:19 -0400
IronPort-SDR: kHmnFzon/1VaZDywm9Gqo6VwQI8tAtTdJ5Ct5c3du4rAxKjFdFfDZfYDu9CxMQjIdpgPMyF+0e
 /JhZX5cGrU1g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 20:19:04 -0700
IronPort-SDR: LjFKusOUpCdcMzwd/6vY5dknjYysVFJ9uKGPyE6ATNDYCOsWRcbWrA20KhYNtHtrZily4xC4yt
 lbfVVgG7PdJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; d="scan'208";a="310775953"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
 by FMSMGA003.fm.intel.com with ESMTP; 27 May 2020 20:19:04 -0700
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] PCI: vmd: Use Shadow MEMBAR registers for QEMU/KVM
 guests
Date: Wed, 27 May 2020 23:02:40 -0400
Message-Id: <20200528030240.16024-4-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200528030240.16024-1-jonathan.derrick@intel.com>
References: <20200528030240.16024-1-jonathan.derrick@intel.com>
Received-SPF: pass client-ip=192.55.52.43;
 envelope-from=jonathan.derrick@intel.com; helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 23:19:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jon Derrick <jonathan.derrick@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VMD device 28C0 natively assists guest passthrough of the VMD endpoint
through the use of shadow registers that provide Host Physical Addresses
to correctly assign bridge windows. These shadow registers are only
available if VMD config space register 0x70, bit 1 is set.

In order to support this mode in existing VMD devices which don't
natively support the shadow register, it was decided that the hypervisor
could offer the shadow registers in a vendor-specific PCI capability.

QEMU has been modified to create this vendor-specific capability and
supply the shadow membar registers for VMDs which don't natively support
this feature. This patch adds this mode and updates the supported device
list to allow this feature to be used on these VMDs.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e386d4e..76d8acb 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -40,13 +40,19 @@ enum vmd_features {
 	 * membars, in order to allow proper address translation during
 	 * resource assignment to enable guest virtualization
 	 */
-	VMD_FEAT_HAS_MEMBAR_SHADOW	= (1 << 0),
+	VMD_FEAT_HAS_MEMBAR_SHADOW		= (1 << 0),
 
 	/*
 	 * Device may provide root port configuration information which limits
 	 * bus numbering
 	 */
-	VMD_FEAT_HAS_BUS_RESTRICTIONS	= (1 << 1),
+	VMD_FEAT_HAS_BUS_RESTRICTIONS		= (1 << 1),
+
+	/*
+	 * Device contains physical location shadow registers in
+	 * vendor-specific capability space
+	 */
+	VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP	= (1 << 2),
 };
 
 /*
@@ -454,6 +460,28 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 		}
 	}
 
+	if (features & VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP) {
+		int pos = pci_find_capability(vmd->dev, PCI_CAP_ID_VNDR);
+		u32 reg, regu;
+
+		pci_read_config_dword(vmd->dev, pos + 4, &reg);
+
+		/* "SHDW" */
+		if (pos && reg == 0x53484457) {
+			pci_read_config_dword(vmd->dev, pos + 8, &reg);
+			pci_read_config_dword(vmd->dev, pos + 12, &regu);
+			offset[0] = vmd->dev->resource[VMD_MEMBAR1].start -
+					(((u64) regu << 32 | reg) &
+					 PCI_BASE_ADDRESS_MEM_MASK);
+
+			pci_read_config_dword(vmd->dev, pos + 16, &reg);
+			pci_read_config_dword(vmd->dev, pos + 20, &regu);
+			offset[1] = vmd->dev->resource[VMD_MEMBAR2].start -
+					(((u64) regu << 32 | reg) &
+					 PCI_BASE_ADDRESS_MEM_MASK);
+		}
+	}
+
 	/*
 	 * Certain VMD devices may have a root port configuration option which
 	 * limits the bus range to between 0-127, 128-255, or 224-255
@@ -716,16 +744,20 @@ static int vmd_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
 
 static const struct pci_device_id vmd_ids[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
-		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
-		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
-		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
1.8.3.1


