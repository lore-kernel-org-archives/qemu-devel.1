Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AF1C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 11:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A2E2070B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 11:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A2E2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jua8u-0006P9-9I
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 07:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jua1U-0002xL-Gr
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 07:19:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:51218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jua1S-0004uN-02
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 07:19:56 -0400
IronPort-SDR: T5aUbdJKJQLQkX3/s8BywlQ82NqrAVNhbi1+O1s0h7Qs7aEY/IJym+QP6njrjv8KkZQ43mwOBB
 NJWxuIIGl65w==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="148490163"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; d="scan'208";a="148490163"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2020 04:19:46 -0700
IronPort-SDR: NkjC46A5dyO3FA7F/UXCSi1T4pIBlWbfjWaYwG4bc94H4UU8gZYAFuJiFZvGzDviPD/SfKSSyJ
 ESEXb+B0Czgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; d="scan'208";a="307121404"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2020 04:19:45 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [RFC v8 09/25] hw/pci: introduce pci_device_set/unset_iommu_context()
Date: Sun, 12 Jul 2020 04:26:05 -0700
Message-Id: <1594553181-55810-10-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594553181-55810-1-git-send-email-yi.l.liu@intel.com>
References: <1594553181-55810-1-git-send-email-yi.l.liu@intel.com>
Received-SPF: pass client-ip=134.134.136.65; envelope-from=yi.l.liu@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/12 07:19:41
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, yi.l.liu@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, eric.auger@redhat.com, yi.y.sun@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, pbonzini@redhat.com,
 hao.wu@intel.com, jasowang@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For nesting IOMMU translation capable platforms, vIOMMUs running on
such system could be implemented upon physical IOMMU nested paging
(VFIO case). vIOMMU advertises such implementation by "want_nested"
attribute to PCIe devices (e.g. VFIO PCI). Once "want_nested" is
satisfied, device (VFIO case) should set HostIOMMUContext to vIOMMU,
thus vIOMMU could manage stage-1 translation. DMAs out from such
devices would be protected through the stage-1 page tables owned by
guest together with stage-2 page tables owned by host.

This patch adds pci_device_set/unset_iommu_context() to set/unset
HostIOMMUContext for a given PCIe device (VFIO case). Caller of set
should fail if set operation failed.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
rfcv5 (v2) -> rfcv6:
*) pci_device_set_iommu_context() returns 0 if callback is not implemented.
---
 hw/pci/pci.c         | 28 ++++++++++++++++++++++++++++
 include/hw/pci/pci.h | 10 ++++++++++
 2 files changed, 38 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 3c27805..59864c6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2743,6 +2743,34 @@ int pci_device_get_iommu_attr(PCIDevice *dev, IOMMUAttr attr, void *data)
     return -ENOENT;
 }
 
+int pci_device_set_iommu_context(PCIDevice *dev,
+                                 HostIOMMUContext *iommu_ctx)
+{
+    PCIBus *bus;
+    uint8_t devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &devfn);
+    if (bus && bus->iommu_ops &&
+        bus->iommu_ops->set_iommu_context) {
+        return bus->iommu_ops->set_iommu_context(bus,
+                              bus->iommu_opaque, devfn, iommu_ctx);
+    }
+    return 0;
+}
+
+void pci_device_unset_iommu_context(PCIDevice *dev)
+{
+    PCIBus *bus;
+    uint8_t devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &devfn);
+    if (bus && bus->iommu_ops &&
+        bus->iommu_ops->unset_iommu_context) {
+        bus->iommu_ops->unset_iommu_context(bus,
+                                 bus->iommu_opaque, devfn);
+    }
+}
+
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
 {
     bus->iommu_ops = ops;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f74161b..0647d64 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -9,6 +9,8 @@
 
 #include "hw/pci/pcie.h"
 
+#include "hw/iommu/host_iommu_context.h"
+
 extern bool pci_available;
 
 /* PCI bus */
@@ -495,10 +497,18 @@ struct PCIIOMMUOps {
                                 void *opaque, int32_t devfn);
     int (*get_iommu_attr)(PCIBus *bus, void *opaque, int32_t devfn,
                            IOMMUAttr attr, void *data);
+    int (*set_iommu_context)(PCIBus *bus, void *opaque,
+                             int32_t devfn,
+                             HostIOMMUContext *iommu_ctx);
+    void (*unset_iommu_context)(PCIBus *bus, void *opaque,
+                                int32_t devfn);
 };
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 int pci_device_get_iommu_attr(PCIDevice *dev, IOMMUAttr attr, void *data);
+int pci_device_set_iommu_context(PCIDevice *dev,
+                                 HostIOMMUContext *iommu_ctx);
+void pci_device_unset_iommu_context(PCIDevice *dev);
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *iommu_ops, void *opaque);
 
 static inline void
-- 
2.7.4


