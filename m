Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AC4C0650E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5099C20989
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5099C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjilp-000528-Eb
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 07:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52387)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hjiig-0002qr-Tt
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hjiif-0005ss-Si
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:2961)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hjiif-0005e0-JC
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jul 2019 04:19:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,458,1557212400"; d="scan'208";a="363354990"
Received: from yiliu-dev.bj.intel.com ([10.238.156.139])
 by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2019 04:19:02 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Date: Fri,  5 Jul 2019 19:01:38 +0800
Message-Id: <1562324511-2910-6-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [RFC v1 05/18] vfio/pci: add pasid alloc/free
 implementation
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, jun.j.tian@intel.com,
 eric.auger@redhat.com, yi.y.sun@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds vfio implementation PCIPASIDOps.alloc_pasid/free_pasid().
These two functions are used to propagate guest pasid allocation and
free requests to host via vfio container ioctl.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 hw/vfio/pci.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ce3fe96..ab184ad 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2690,6 +2690,65 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
+static int vfio_pci_device_request_pasid_alloc(PCIBus *bus,
+                                               int32_t devfn,
+                                               uint32_t min_pasid,
+                                               uint32_t max_pasid)
+{
+    PCIDevice *pdev = bus->devices[devfn];
+    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    VFIOContainer *container = vdev->vbasedev.group->container;
+    struct vfio_iommu_type1_pasid_request req;
+    unsigned long argsz;
+    int pasid;
+
+    argsz = sizeof(req);
+    req.argsz = argsz;
+    req.flag = VFIO_IOMMU_PASID_ALLOC;
+    req.min_pasid = min_pasid;
+    req.max_pasid = max_pasid;
+
+    rcu_read_lock();
+    pasid = ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
+    if (pasid < 0) {
+        error_report("vfio_pci_device_request_pasid_alloc:"
+                     " request failed, contanier: %p", container);
+    }
+    rcu_read_unlock();
+    return pasid;
+}
+
+static int vfio_pci_device_request_pasid_free(PCIBus *bus,
+                                              int32_t devfn,
+                                              uint32_t pasid)
+{
+    PCIDevice *pdev = bus->devices[devfn];
+    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    VFIOContainer *container = vdev->vbasedev.group->container;
+    struct vfio_iommu_type1_pasid_request req;
+    unsigned long argsz;
+    int ret = 0;
+
+    argsz = sizeof(req);
+    req.argsz = argsz;
+    req.flag = VFIO_IOMMU_PASID_FREE;
+    req.pasid = pasid;
+
+    rcu_read_lock();
+    ret = ioctl(container->fd, VFIO_IOMMU_PASID_REQUEST, &req);
+    if (ret != 0) {
+        error_report("vfio_pci_device_request_pasid_free:"
+                     " request failed, contanier: %p", container);
+    }
+    rcu_read_unlock();
+    return ret;
+}
+
+static PCIPASIDOps vfio_pci_pasid_ops = {
+    .alloc_pasid = vfio_pci_device_request_pasid_alloc,
+    .free_pasid = vfio_pci_device_request_pasid_free,
+};
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev = PCI_VFIO(pdev);
@@ -2991,6 +3050,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
 
+    pci_setup_pasid_ops(pdev, &vfio_pci_pasid_ops);
+
     return;
 
 out_teardown:
-- 
2.7.4


