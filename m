Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5259C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E61205ED
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E61205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ici0w-0001TP-50
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 22:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1ichuQ-0000zc-7u
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yan.y.zhao@intel.com>) id 1ichuK-0000hR-3Y
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:34:25 -0500
Received: from mga01.intel.com ([192.55.52.88]:11015)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
 id 1ichuI-0000bB-CG
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:34:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 19:34:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; d="scan'208";a="243094962"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
 by fmsmga002.fm.intel.com with ESMTP; 04 Dec 2019 19:34:16 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: alex.williamson@redhat.com
Subject: [RFC PATCH 2/9] vfio/pci: test existence before calling region->ops
Date: Wed,  4 Dec 2019 22:25:55 -0500
Message-Id: <20191205032555.29700-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205032419.29606-1-yan.y.zhao@intel.com>
References: <20191205032419.29606-1-yan.y.zhao@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
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
Cc: kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>, kvm@vger.kernel.org,
 libvir-list@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 zhenyuw@linux.intel.com, qemu-devel@nongnu.org, shaopeng.he@intel.com,
 zhi.a.wang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For regions registered through vfio_pci_register_dev_region(),
before calling region->ops, first check whether region->ops is not null.

As in the next two patches, dev regions of null region->ops are to be
registered by default on behalf of vendor driver, we need to check here
to prevent null pointer access if vendor driver forgets to handle those
dev regions

Cc: Kevin Tian <kevin.tian@intel.com>

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 drivers/vfio/pci/vfio_pci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 55080ff29495..f3730252ee82 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -398,8 +398,12 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
 
 	vdev->virq_disabled = false;
 
-	for (i = 0; i < vdev->num_regions; i++)
+	for (i = 0; i < vdev->num_regions; i++) {
+		if (!vdev->region[i].ops || vdev->region[i].ops->release)
+			continue;
+
 		vdev->region[i].ops->release(vdev, &vdev->region[i]);
+	}
 
 	vdev->num_regions = 0;
 	kfree(vdev->region);
@@ -900,7 +904,8 @@ static long vfio_pci_ioctl(void *device_data,
 			if (ret)
 				return ret;
 
-			if (vdev->region[i].ops->add_capability) {
+			if (vdev->region[i].ops &&
+					vdev->region[i].ops->add_capability) {
 				ret = vdev->region[i].ops->add_capability(vdev,
 						&vdev->region[i], &caps);
 				if (ret)
@@ -1251,6 +1256,9 @@ static ssize_t vfio_pci_rw(void *device_data, char __user *buf,
 		return vfio_pci_vga_rw(vdev, buf, count, ppos, iswrite);
 	default:
 		index -= VFIO_PCI_NUM_REGIONS;
+		if (!vdev->region[index].ops || !vdev->region[index].ops->rw)
+			return -EINVAL;
+
 		return vdev->region[index].ops->rw(vdev, buf,
 						   count, ppos, iswrite);
 	}
-- 
2.17.1


