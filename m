Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94528C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711BC206B9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711BC206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYDxB-0003jy-IQ
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 15:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1jYDvg-0001hS-Lo
 for qemu-devel@nongnu.org; Mon, 11 May 2020 15:17:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:15027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1jYDvf-0001bB-Dx
 for qemu-devel@nongnu.org; Mon, 11 May 2020 15:17:32 -0400
IronPort-SDR: OK1SdtoHI4Z94rsvnymImHXLFEeGy4tp334Z5hrx9WANmyACIs7VRg4epDSUkFP7hW39utoaLz
 alfbqXGpFG2Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2020 12:17:21 -0700
IronPort-SDR: roRqwOjLYhkQ32MOBY1NWaG8Rq4NfXfjhv0xHiAE0sHLAo09c8dlxaMkE1RMVc64sRzQVz9coz
 nUt+Po+4mQ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; d="scan'208";a="463494245"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
 by fmsmga006.fm.intel.com with ESMTP; 11 May 2020 12:17:21 -0700
From: Jon Derrick <jonathan.derrick@intel.com>
To: <linux-pci@vger.kernel.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] PCI: vmd: Use Shadow MEMBAR registers for QEMU/KVM
 guests
Date: Mon, 11 May 2020 15:01:29 -0400
Message-Id: <20200511190129.9313-4-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200511190129.9313-1-jonathan.derrick@intel.com>
References: <20200511190129.9313-1-jonathan.derrick@intel.com>
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=jonathan.derrick@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 15:17:21
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
 virtualization@lists.linux-foundation.org,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jon Derrick <jonathan.derrick@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VMD device 28C0 natively assists guest passthrough of the VMD endpoint
through the use of shadow registers that provide Host Physical Addresses
to correctly assign bridge windows. These shadow registers are only
available if VMD config space register 0x70, bit 1 is set.

For existing VMD which don't natively support the shadow register, VMD
config space register 0x70 is reserved and will return 0. Future VMD
will have these registers natively in hardware, but existing VMD can
still use this feature by emulating the config space register and shadow
registers.

QEMU has been modified to emulate this config space register and the
shadow membar registers for VMDs which don't natively support this
feature. This patch updates the supported device list to allow this
feature to be used on these VMDs.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e386d4eac407..ee71d0989875 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -600,6 +600,7 @@ static irqreturn_t vmd_irq(int irq, void *data)
 static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct vmd_dev *vmd;
+	unsigned long features = id->driver_data;
 	int i, err;
 
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
@@ -652,7 +653,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
-	err = vmd_enable_domain(vmd, (unsigned long) id->driver_data);
+	err = vmd_enable_domain(vmd, features);
 	if (err)
 		return err;
 
@@ -716,16 +717,20 @@ static int vmd_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
 
 static const struct pci_device_id vmd_ids[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
-		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
-		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
-		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.18.1


