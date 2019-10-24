Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDE4CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011692084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011692084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdgH-0000II-IM
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckM-0005Kg-AX
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckG-0002TH-Tm
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:40482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iNckG-0002MX-KR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:01:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 06:01:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; d="scan'208";a="210156218"
Received: from iov.bj.intel.com ([10.238.145.67])
 by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2019 06:01:30 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v2 08/22] intel_iommu: provide get_iommu_context() callback
Date: Thu, 24 Oct 2019 08:34:29 -0400
Message-Id: <1571920483-3382-9-git-send-email-yi.l.liu@intel.com>
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

This patch adds get_iommu_context() callback to return an iommu_context
Intel VT-d platform.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c         | 57 ++++++++++++++++++++++++++++++++++++++-----
 include/hw/i386/intel_iommu.h | 14 ++++++++++-
 2 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 67a7836..e9f8692 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3288,22 +3288,33 @@ static const MemoryRegionOps vtd_mem_ir_ops = {
     },
 };
 
-VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
+static VTDBus *vtd_find_add_bus(IntelIOMMUState *s, PCIBus *bus)
 {
     uintptr_t key = (uintptr_t)bus;
-    VTDBus *vtd_bus = g_hash_table_lookup(s->vtd_as_by_busptr, &key);
-    VTDAddressSpace *vtd_dev_as;
-    char name[128];
+    VTDBus *vtd_bus;
 
+    vtd_iommu_lock(s);
+    vtd_bus = g_hash_table_lookup(s->vtd_as_by_busptr, &key);
     if (!vtd_bus) {
         uintptr_t *new_key = g_malloc(sizeof(*new_key));
         *new_key = (uintptr_t)bus;
         /* No corresponding free() */
-        vtd_bus = g_malloc0(sizeof(VTDBus) + sizeof(VTDAddressSpace *) * \
-                            PCI_DEVFN_MAX);
+        vtd_bus = g_malloc0(sizeof(VTDBus) + PCI_DEVFN_MAX * \
+                    (sizeof(VTDAddressSpace *) + sizeof(VTDIOMMUContext *)));
         vtd_bus->bus = bus;
         g_hash_table_insert(s->vtd_as_by_busptr, new_key, vtd_bus);
     }
+    vtd_iommu_unlock(s);
+    return vtd_bus;
+}
+
+VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
+{
+    VTDBus *vtd_bus;
+    VTDAddressSpace *vtd_dev_as;
+    char name[128];
+
+    vtd_bus = vtd_find_add_bus(s, bus);
 
     vtd_dev_as = vtd_bus->dev_as[devfn];
 
@@ -3370,6 +3381,27 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
     return vtd_dev_as;
 }
 
+VTDIOMMUContext *vtd_find_add_ic(IntelIOMMUState *s,
+                                 PCIBus *bus, int devfn)
+{
+    VTDBus *vtd_bus;
+    VTDIOMMUContext *vtd_dev_ic;
+
+    vtd_bus = vtd_find_add_bus(s, bus);
+
+    vtd_dev_ic = vtd_bus->dev_ic[devfn];
+
+    if (!vtd_dev_ic) {
+        vtd_bus->dev_ic[devfn] = vtd_dev_ic =
+                    g_malloc0(sizeof(VTDIOMMUContext));
+        vtd_dev_ic->vtd_bus = vtd_bus;
+        vtd_dev_ic->devfn = (uint8_t)devfn;
+        vtd_dev_ic->iommu_state = s;
+        iommu_context_init(&vtd_dev_ic->iommu_context);
+    }
+    return vtd_dev_ic;
+}
+
 static uint64_t get_naturally_aligned_size(uint64_t start,
                                            uint64_t size, int gaw)
 {
@@ -3666,8 +3698,21 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &vtd_as->as;
 }
 
+static IOMMUContext *vtd_dev_iommu_context(PCIBus *bus,
+                                           void *opaque, int devfn)
+{
+    IntelIOMMUState *s = opaque;
+    VTDIOMMUContext *vtd_ic;
+
+    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
+
+    vtd_ic = vtd_find_add_ic(s, bus, devfn);
+    return &vtd_ic->iommu_context;
+}
+
 static PCIIOMMUOps vtd_iommu_ops = {
     .get_address_space = vtd_host_dma_iommu,
+    .get_iommu_context = vtd_dev_iommu_context,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 6062588..1c580c1 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -68,6 +68,7 @@ typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
 typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
 typedef struct VTDPASIDDirEntry VTDPASIDDirEntry;
 typedef struct VTDPASIDEntry VTDPASIDEntry;
+typedef struct VTDIOMMUContext VTDIOMMUContext;
 
 /* Context-Entry */
 struct VTDContextEntry {
@@ -116,9 +117,19 @@ struct VTDAddressSpace {
     IOVATree *iova_tree;          /* Traces mapped IOVA ranges */
 };
 
+struct VTDIOMMUContext {
+    VTDBus *vtd_bus;
+    uint8_t devfn;
+    IOMMUContext iommu_context;
+    IntelIOMMUState *iommu_state;
+};
+
 struct VTDBus {
     PCIBus* bus;		/* A reference to the bus to provide translation for */
-    VTDAddressSpace *dev_as[0];	/* A table of VTDAddressSpace objects indexed by devfn */
+    /* A table of VTDAddressSpace objects indexed by devfn */
+    VTDAddressSpace *dev_as[PCI_DEVFN_MAX];
+    /* A table of VTDIOMMUContext objects indexed by devfn */
+    VTDIOMMUContext *dev_ic[PCI_DEVFN_MAX];
 };
 
 struct VTDIOTLBEntry {
@@ -282,5 +293,6 @@ struct IntelIOMMUState {
  * create a new one if none exists
  */
 VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn);
+VTDIOMMUContext *vtd_find_add_ic(IntelIOMMUState *s, PCIBus *bus, int devfn);
 
 #endif
-- 
2.7.4


