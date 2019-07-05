Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BDAC468AD
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00CA214AF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00CA214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjj3s-0003Sx-4j
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 07:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52527)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hjijC-0003Ez-RB
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hjij9-00063U-6n
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:2978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hjij7-0005xj-Gh
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jul 2019 04:19:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,458,1557212400"; d="scan'208";a="363355046"
Received: from yiliu-dev.bj.intel.com ([10.238.156.139])
 by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2019 04:19:28 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Date: Fri,  5 Jul 2019 19:01:47 +0800
Message-Id: <1562324511-2910-15-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [RFC v1 14/18] hw/pci: add flush_pasid_iotlb() in
 PCIPASIDOps
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

This patch adds flush_pasid_iotlb() in PCIPASIDOps for passing guest
PASID-based iotlb flush operation to host via vfio interface.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/pci/pci.c         | 15 +++++++++++++++
 include/hw/pci/pci.h |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2229229..cf92bed 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2706,6 +2706,21 @@ void pci_device_unbind_gpasid(PCIBus *bus, int32_t devfn,
     }
 }
 
+void pci_device_flush_pasid_iotlb(PCIBus *bus, int32_t devfn,
+                            struct iommu_cache_invalidate_info *info)
+{
+    PCIDevice *dev;
+
+    if (!bus) {
+        return;
+    }
+
+    dev = bus->devices[devfn];
+    if (dev && dev->pasid_ops) {
+        dev->pasid_ops->flush_pasid_iotlb(bus, devfn, info);
+    }
+}
+
 static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
 {
     Range *range = opaque;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 8d849e6..77e6bb1 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -272,6 +272,8 @@ struct PCIPASIDOps {
                             struct gpasid_bind_data *g_bind_data);
     void (*unbind_gpasid)(PCIBus *bus, int32_t devfn,
                             struct gpasid_bind_data *g_bind_data);
+    void (*flush_pasid_iotlb)(PCIBus *bus, int32_t devfn,
+                            struct iommu_cache_invalidate_info *info);
 };
 
 struct PCIDevice {
@@ -506,6 +508,8 @@ void pci_device_bind_gpasid(PCIBus *bus, int32_t devfn,
                             struct gpasid_bind_data *g_bind_data);
 void pci_device_unbind_gpasid(PCIBus *bus, int32_t devfn,
                             struct gpasid_bind_data *g_bind_data);
+void pci_device_flush_pasid_iotlb(PCIBus *bus, int32_t devfn,
+                            struct iommu_cache_invalidate_info *info);
 
 static inline void
 pci_set_byte(uint8_t *config, uint8_t val)
-- 
2.7.4


