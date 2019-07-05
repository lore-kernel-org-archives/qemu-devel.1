Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF5FC0650E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A4E21670
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A4E21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjiol-0008Kr-C3
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 07:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52424)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hjiiv-00036Y-EF
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hjiir-0005wo-4j
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:2961)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hjiip-0005e0-Sx
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jul 2019 04:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,458,1557212400"; d="scan'208";a="363355011"
Received: from yiliu-dev.bj.intel.com ([10.238.156.139])
 by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2019 04:19:11 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Date: Fri,  5 Jul 2019 19:01:41 +0800
Message-Id: <1562324511-2910-9-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [RFC v1 08/18] vfio/pci: add vfio bind/unbind_gpasid
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

This patch adds vfio implementation PCIPASIDOps.bind_gpasid/unbind_pasid().
These two functions are used to propagate guest pasid bind and unbind
requests to host via vfio container ioctl.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/vfio/pci.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ab184ad..892b46c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2744,9 +2744,63 @@ static int vfio_pci_device_request_pasid_free(PCIBus *bus,
     return ret;
 }
 
+static void vfio_pci_device_bind_gpasid(PCIBus *bus, int32_t devfn,
+                                     struct gpasid_bind_data *g_bind_data)
+{
+    PCIDevice *pdev = bus->devices[devfn];
+    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    VFIOContainer *container = vdev->vbasedev.group->container;
+    struct vfio_iommu_type1_bind *bind;
+    struct vfio_iommu_type1_bind_guest_pasid *bind_guest_pasid;
+    unsigned long argsz;
+
+    argsz = sizeof(*bind) + sizeof(*bind_guest_pasid);
+    bind = g_malloc0(argsz);
+    bind->argsz = argsz;
+    bind->bind_type = VFIO_IOMMU_BIND_GUEST_PASID;
+    bind_guest_pasid = (struct vfio_iommu_type1_bind_guest_pasid *) &bind->data;
+    bind_guest_pasid->bind_data = *g_bind_data;
+
+    rcu_read_lock();
+    if (ioctl(container->fd, VFIO_IOMMU_BIND, bind) != 0) {
+        error_report("vfio_pci_device_bind_gpasid:"
+                     " bind failed, contanier: %p", container);
+    }
+    rcu_read_unlock();
+    g_free(bind);
+}
+
+static void vfio_pci_device_unbind_gpasid(PCIBus *bus, int32_t devfn,
+                                     struct gpasid_bind_data *g_bind_data)
+{
+    PCIDevice *pdev = bus->devices[devfn];
+    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    VFIOContainer *container = vdev->vbasedev.group->container;
+    struct vfio_iommu_type1_bind *bind;
+    struct vfio_iommu_type1_bind_guest_pasid *bind_guest_pasid;
+    unsigned long argsz;
+
+    argsz = sizeof(*bind) + sizeof(*bind_guest_pasid);
+    bind = g_malloc0(argsz);
+    bind->argsz = argsz;
+    bind->bind_type = VFIO_IOMMU_BIND_GUEST_PASID;
+    bind_guest_pasid = (struct vfio_iommu_type1_bind_guest_pasid *) &bind->data;
+    bind_guest_pasid->bind_data = *g_bind_data;
+
+    rcu_read_lock();
+    if (ioctl(container->fd, VFIO_IOMMU_UNBIND, bind) != 0) {
+        error_report("vfio_pci_device_unbind_gpasid:"
+                     " unbind failed, contanier: %p", container);
+    }
+    rcu_read_unlock();
+    g_free(bind);
+}
+
 static PCIPASIDOps vfio_pci_pasid_ops = {
     .alloc_pasid = vfio_pci_device_request_pasid_alloc,
     .free_pasid = vfio_pci_device_request_pasid_free,
+    .bind_gpasid = vfio_pci_device_bind_gpasid,
+    .unbind_gpasid = vfio_pci_device_unbind_gpasid,
 };
 
 static void vfio_realize(PCIDevice *pdev, Error **errp)
-- 
2.7.4


