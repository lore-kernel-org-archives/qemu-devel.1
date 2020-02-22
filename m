Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEC1C35669
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DAE208C3
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DAE208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Pl7-0003x5-F0
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 03:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1j5Pjj-0002B6-NA
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1j5Pjh-0007zZ-NE
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:02:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:49238)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1j5Pjh-0007tq-Dt
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:02:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Feb 2020 00:01:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,471,1574150400"; d="scan'208";a="240547677"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga006.jf.intel.com with ESMTP; 22 Feb 2020 00:01:57 -0800
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [RFC v3.1 09/22] hw/pci: add pci_device_host_iommu_context()
Date: Sat, 22 Feb 2020 00:07:10 -0800
Message-Id: <1582358843-51931-10-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582358843-51931-1-git-send-email-yi.l.liu@intel.com>
References: <1582358843-51931-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 eric.auger@redhat.com, yi.y.sun@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, pbonzini@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds pci_device_host_iommu_context() to expose HostIOMMUContext
to vIOMMU emulators via pci layer.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/pci/pci.c         | 8 ++++++++
 include/hw/pci/pci.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 3166cc3..288576f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2689,6 +2689,14 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
     return &address_space_memory;
 }
 
+HostIOMMUContext *pci_device_host_iommu_context(PCIDevice *dev)
+{
+    if (dev && dev->host_iommu_fn) {
+        return dev->host_iommu_fn(dev);
+    }
+    return NULL;
+}
+
 void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
 {
     bus->iommu_fn = fn;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e44eefb..cb514d0 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -494,6 +494,7 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
 void pci_device_setup_iommu(PCIDevice *dev, PCIHostIOMMUFunc fn);
 void pci_device_unset_iommu(PCIDevice *dev);
+HostIOMMUContext *pci_device_host_iommu_context(PCIDevice *dev);
 
 static inline void
 pci_set_byte(uint8_t *config, uint8_t val)
-- 
2.7.4


