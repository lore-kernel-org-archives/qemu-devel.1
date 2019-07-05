Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7273CC48BD3
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F38E20989
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F38E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjiln-0004vP-HH
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 07:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52348)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hjiie-0002pB-DQ
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hjiic-0005qv-PH
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:2961)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hjiic-0005e0-EX
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jul 2019 04:18:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,458,1557212400"; d="scan'208";a="363354964"
Received: from yiliu-dev.bj.intel.com ([10.238.156.139])
 by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2019 04:18:57 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Date: Fri,  5 Jul 2019 19:01:36 +0800
Message-Id: <1562324511-2910-4-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [RFC v1 03/18] hw/pci: introduce PCIPASIDOps to
 PCIDevice
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

This patch introduces PCIPASIDOps for PASID related operations in
future usage like virt-SVA. Related discussions can be found in
below links.

https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00078.html
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00940.html

So far, to setup virt-SVA for assigned SVA capable device, needs to
configure host translation structures for specific pasid. (e.g. bind
guest page table to host and enable nested translation in host).
Besides, vIOMMU emulator needs to forward guest's cache invalidation
to host since host nested translation is enabled. e.g. on VT-d, guest
owns 1st level translation table, thus cache invalidation for 1st
level should be propagated to host.

This patch adds two functions: alloc_pasid and free_pasid to support
guest pasid allocation and free. The implementations of the callbacks
would be device passthru modules. Like vfio.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 hw/pci/pci.c         | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h | 14 ++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 8076a80..710f9e9 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2626,6 +2626,56 @@ void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
     bus->iommu_opaque = opaque;
 }
 
+void pci_setup_pasid_ops(PCIDevice *dev, PCIPASIDOps *ops)
+{
+    assert(ops && !dev->pasid_ops);
+    dev->pasid_ops = ops;
+}
+
+bool pci_device_is_ops_set(PCIBus *bus, int32_t devfn)
+{
+    PCIDevice *dev;
+
+    if (!bus) {
+        return false;
+    }
+
+    dev = bus->devices[devfn];
+    return !!(dev && dev->pasid_ops);
+}
+
+int pci_device_request_pasid_alloc(PCIBus *bus, int32_t devfn,
+                                   uint32_t min_pasid, uint32_t max_pasid)
+{
+    PCIDevice *dev;
+
+    if (!bus) {
+        return -1;
+    }
+
+    dev = bus->devices[devfn];
+    if (dev && dev->pasid_ops && dev->pasid_ops->alloc_pasid) {
+        return dev->pasid_ops->alloc_pasid(bus, devfn, min_pasid, max_pasid);
+    }
+    return -1;
+}
+
+int pci_device_request_pasid_free(PCIBus *bus, int32_t devfn,
+                                  uint32_t pasid)
+{
+    PCIDevice *dev;
+
+    if (!bus) {
+        return -1;
+    }
+
+    dev = bus->devices[devfn];
+    if (dev && dev->pasid_ops && dev->pasid_ops->free_pasid) {
+        return dev->pasid_ops->free_pasid(bus, devfn, pasid);
+    }
+    return -1;
+}
+
 static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
 {
     Range *range = opaque;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d082707..16e5b8e 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -262,6 +262,13 @@ struct PCIReqIDCache {
 };
 typedef struct PCIReqIDCache PCIReqIDCache;
 
+typedef struct PCIPASIDOps PCIPASIDOps;
+struct PCIPASIDOps {
+    int (*alloc_pasid)(PCIBus *bus, int32_t devfn,
+                         uint32_t min_pasid, uint32_t max_pasid);
+    int (*free_pasid)(PCIBus *bus, int32_t devfn, uint32_t pasid);
+};
+
 struct PCIDevice {
     DeviceState qdev;
 
@@ -351,6 +358,7 @@ struct PCIDevice {
     MSIVectorUseNotifier msix_vector_use_notifier;
     MSIVectorReleaseNotifier msix_vector_release_notifier;
     MSIVectorPollNotifier msix_vector_poll_notifier;
+    PCIPASIDOps *pasid_ops;
 };
 
 void pci_register_bar(PCIDevice *pci_dev, int region_num,
@@ -484,6 +492,12 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
 
+void pci_setup_pasid_ops(PCIDevice *dev, PCIPASIDOps *ops);
+bool pci_device_is_ops_set(PCIBus *bus, int32_t devfn);
+int pci_device_request_pasid_alloc(PCIBus *bus, int32_t devfn,
+                                   uint32_t min_pasid, uint32_t max_pasid);
+int pci_device_request_pasid_free(PCIBus *bus, int32_t devfn, uint32_t pasid);
+
 static inline void
 pci_set_byte(uint8_t *config, uint8_t val)
 {
-- 
2.7.4


