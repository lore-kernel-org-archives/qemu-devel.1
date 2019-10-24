Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA61CA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B5421655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B5421655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNddu-00041A-2j
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckI-0005FW-Gz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckG-0002Su-Ls
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:40489)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iNckG-0002NX-E6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 06:01:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; d="scan'208";a="210156206"
Received: from iov.bj.intel.com ([10.238.145.67])
 by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2019 06:01:27 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v2 07/22] hw/pci: introduce pci_device_iommu_context()
Date: Thu, 24 Oct 2019 08:34:28 -0400
Message-Id: <1571920483-3382-8-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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
 eric.auger@redhat.com, yi.y.sun@intel.com, jacob.jun.pan@linux.intel.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds pci_device_iommu_context() to get an iommu_context
for a given device. A new callback is added in PCIIOMMUOps. Users
who wants to listen to events issued by vIOMMU could use this new
interface to get an iommu_context and register their own notifiers,
then wait for notifications from vIOMMU. e.g. VFIO is the first user
of it to listen to the PASID_ALLOC/PASID_BIND/CACHE_INV events and
propagate the events to host.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/pci/pci.c         | 16 ++++++++++++++++
 include/hw/pci/pci.h |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b5ce9ca..4e6af06 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2625,6 +2625,22 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     return &address_space_memory;
 }
 
+IOMMUContext *pci_device_iommu_context(PCIDevice *dev)
+{
+    PCIBus *bus = pci_get_bus(dev);
+    PCIBus *iommu_bus = bus;
+
+    while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
+        iommu_bus = pci_get_bus(iommu_bus->parent_dev);
+    }
+    if (iommu_bus && iommu_bus->iommu_ops &&
+        iommu_bus->iommu_ops->get_iommu_context) {
+        return iommu_bus->iommu_ops->get_iommu_context(bus,
+                           iommu_bus->iommu_opaque, dev->devfn);
+    }
+    return NULL;
+}
+
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
 {
     bus->iommu_ops = ops;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d9fed8d..ccada47 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -9,6 +9,8 @@
 
 #include "hw/pci/pcie.h"
 
+#include "hw/iommu/iommu.h"
+
 extern bool pci_available;
 
 /* PCI bus */
@@ -484,9 +486,12 @@ typedef struct PCIIOMMUOps PCIIOMMUOps;
 struct PCIIOMMUOps {
     AddressSpace * (*get_address_space)(PCIBus *bus,
                                 void *opaque, int32_t devfn);
+    IOMMUContext * (*get_iommu_context)(PCIBus *bus,
+                                void *opaque, int32_t devfn);
 };
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
+IOMMUContext *pci_device_iommu_context(PCIDevice *dev);
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *iommu_ops, void *opaque);
 
 static inline void
-- 
2.7.4


