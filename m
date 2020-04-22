Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C11C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2547A20882
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2547A20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJWH-0001EA-B1
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jonathan.derrick@intel.com>) id 1jRJAr-0005Zd-Mr
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jonathan.derrick@intel.com>) id 1jRJAq-0001Tn-0C
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:28:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:13773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.derrick@intel.com>)
 id 1jRJAm-00019H-Hr
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:28:34 -0400
IronPort-SDR: jP9xqfCzVRfse7ulb0o7vdKLlBGwGYqF1lcr7YHbDIkd7Z/7GUoXNInfhprJ2MMrlyir7mahr9
 E09jOaLWVVoQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2020 10:28:18 -0700
IronPort-SDR: GIoBfjkDeD7w2hdiabPdW2SOdEki+l8ydPDm/m266t8HN5f/JoVFcTG/1OWHUbyg+4vRY8ADXc
 LmqU3ff6uroA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; d="scan'208";a="429999418"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.40])
 by orsmga005.jf.intel.com with ESMTP; 22 Apr 2020 10:28:18 -0700
From: Jon Derrick <jonathan.derrick@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/1] pci: vmd: Use Shadow MEMBAR registers for QEMU/KVM guests
Date: Wed, 22 Apr 2020 13:13:05 -0400
Message-Id: <20200422171305.10923-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200422171305.10923-1-jonathan.derrick@intel.com>
References: <20200422171305.10923-1-jonathan.derrick@intel.com>
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=jonathan.derrick@intel.com; helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 13:28:18
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.151
X-Mailman-Approved-At: Wed, 22 Apr 2020 13:49:16 -0400
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
Cc: linux-pci@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Andrzej Jakowski <andrzej.jakowski@intel.com>,
 Jon Derrick <jonathan.derrick@intel.com>,
 virtualization@lists.linux-foundation.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VMD device 28C0 provides native guest passthrough of the VMD endpoint
through the use of shadow registers that provide Host Physical Addresses
to correctly assign bridge windows. A quirk has been added to QEMU's
VFIO quirks to emulate the shadow registers for VMD devices which don't
support this mode natively in hardware.

The VFIO quirk assigns the VMD a subsystem vendor/device ID using the
standard QEMU vendor/device, which are typically only used for emulation
and not VFIO. There are no plans for an emulated VMD controller, but if
one is developed in the future, support for this mode can be added by
emulating the VMD VMLOCK and Shadow MEMBAR registers

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index dac91d60701d..764404b45ebb 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -598,6 +598,7 @@ static irqreturn_t vmd_irq(int irq, void *data)
 static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct vmd_dev *vmd;
+	unsigned long features = id->driver_data;
 	int i, err;
 
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
@@ -648,9 +649,14 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			return err;
 	}
 
+	/* VFIO-quirked VMD controllers emulate the Shadow MEMBAR feature */
+	if (dev->subsystem_vendor == PCI_SUBVENDOR_ID_REDHAT_QUMRANET &&
+	    dev->subsystem_device == PCI_SUBDEVICE_ID_QEMU)
+		features |= VMD_FEAT_HAS_MEMBAR_SHADOW;
+
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
-	err = vmd_enable_domain(vmd, (unsigned long) id->driver_data);
+	err = vmd_enable_domain(vmd, features);
 	if (err)
 		return err;
 
-- 
2.18.1


