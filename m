Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C56C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1ABF20716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1ABF20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45403 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwmF8-0004W1-1R
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 07:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCL-0007hV-NV
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:11:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCG-0001Yq-7g
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:11:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:58702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iwmCF-0001NW-Ty
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:11:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 04:11:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,377,1574150400"; d="scan'208";a="314070856"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2020 04:11:45 -0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v3 05/25] intel_iommu: provide get_iommu_context() callback
Date: Wed, 29 Jan 2020 04:16:36 -0800
Message-Id: <1580300216-86172-6-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.24
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
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, eric.auger@redhat.com, yi.y.sun@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Richard Henderson <rth@twiddle.net>,
 hao.wu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Yi L <yi.l.liu@intel.com>

This patch adds get_iommu_context() callback to return an
iommu_context Intel VT-d platform.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c         | 92 ++++++++++++++++++++++++++++++++++++++++---
 include/hw/i386/intel_iommu.h | 15 ++++++-
 2 files changed, 100 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1a37e97..1c1eb7f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3347,22 +3347,35 @@ static const MemoryRegionOps vtd_mem_ir_ops = {
     },
 };
 
-VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
+/**
+ * Caller should hold iommu_lock.
+ */
+static VTDBus *vtd_find_add_bus(IntelIOMMUState *s, PCIBus *bus)
 {
     uintptr_t key = (uintptr_t)bus;
-    VTDBus *vtd_bus = g_hash_table_lookup(s->vtd_as_by_busptr, &key);
-    VTDAddressSpace *vtd_dev_as;
-    char name[128];
+    VTDBus *vtd_bus;
 
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
+    return vtd_bus;
+}
+
+VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
+{
+    VTDBus *vtd_bus;
+    VTDAddressSpace *vtd_dev_as;
+    char name[128];
+
+    vtd_iommu_lock(s);
+    vtd_bus = vtd_find_add_bus(s, bus);
 
     vtd_dev_as = vtd_bus->dev_as[devfn];
 
@@ -3426,9 +3439,63 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
 
         vtd_switch_address_space(vtd_dev_as);
     }
+    vtd_iommu_unlock(s);
+
     return vtd_dev_as;
 }
 
+static int vtd_icx_register_ds_iommu(IOMMUContext *iommu_ctx,
+                                     DualStageIOMMUObject *dsi_obj)
+{
+    VTDIOMMUContext *vtd_dev_icx = container_of(iommu_ctx,
+                                               VTDIOMMUContext,
+                                               iommu_context);
+
+    vtd_dev_icx->dsi_obj = dsi_obj;
+    return 0;
+}
+
+static void vtd_icx_unregister_ds_iommu(IOMMUContext *iommu_ctx,
+                                        DualStageIOMMUObject *dsi_obj)
+{
+    VTDIOMMUContext *vtd_dev_icx = container_of(iommu_ctx,
+                                               VTDIOMMUContext,
+                                               iommu_context);
+
+    vtd_dev_icx->dsi_obj = NULL;
+}
+
+IOMMUContextOps vtd_iommu_context_ops = {
+    .register_ds_iommu = vtd_icx_register_ds_iommu,
+    .unregister_ds_iommu = vtd_icx_unregister_ds_iommu,
+};
+
+VTDIOMMUContext *vtd_find_add_icx(IntelIOMMUState *s,
+                                  PCIBus *bus, int devfn)
+{
+    VTDBus *vtd_bus;
+    VTDIOMMUContext *vtd_dev_icx;
+
+    vtd_iommu_lock(s);
+    vtd_bus = vtd_find_add_bus(s, bus);
+
+    vtd_dev_icx = vtd_bus->dev_icx[devfn];
+
+    if (!vtd_dev_icx) {
+        vtd_bus->dev_icx[devfn] = vtd_dev_icx =
+                    g_malloc0(sizeof(VTDIOMMUContext));
+        vtd_dev_icx->vtd_bus = vtd_bus;
+        vtd_dev_icx->devfn = (uint8_t)devfn;
+        vtd_dev_icx->iommu_state = s;
+        vtd_dev_icx->dsi_obj = NULL;
+        iommu_context_init(&vtd_dev_icx->iommu_context,
+                           &vtd_iommu_context_ops);
+    }
+    vtd_iommu_unlock(s);
+
+    return vtd_dev_icx;
+}
+
 static uint64_t get_naturally_aligned_size(uint64_t start,
                                            uint64_t size, int gaw)
 {
@@ -3722,8 +3789,21 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &vtd_as->as;
 }
 
+static IOMMUContext *vtd_dev_iommu_context(PCIBus *bus,
+                                           void *opaque, int devfn)
+{
+    IntelIOMMUState *s = opaque;
+    VTDIOMMUContext *vtd_icx;
+
+    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
+
+    vtd_icx = vtd_find_add_icx(s, bus, devfn);
+    return &vtd_icx->iommu_context;
+}
+
 static PCIIOMMUOps vtd_iommu_ops = {
     .get_address_space = vtd_host_dma_iommu,
+    .get_iommu_context = vtd_dev_iommu_context,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 66b931e..8571a85 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -68,6 +68,7 @@ typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
 typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
 typedef struct VTDPASIDDirEntry VTDPASIDDirEntry;
 typedef struct VTDPASIDEntry VTDPASIDEntry;
+typedef struct VTDIOMMUContext VTDIOMMUContext;
 
 /* Context-Entry */
 struct VTDContextEntry {
@@ -116,9 +117,20 @@ struct VTDAddressSpace {
     IOVATree *iova_tree;          /* Traces mapped IOVA ranges */
 };
 
+struct VTDIOMMUContext {
+    VTDBus *vtd_bus;
+    uint8_t devfn;
+    IOMMUContext iommu_context;
+    DualStageIOMMUObject *dsi_obj;
+    IntelIOMMUState *iommu_state;
+};
+
 struct VTDBus {
     PCIBus* bus;		/* A reference to the bus to provide translation for */
-    VTDAddressSpace *dev_as[0];	/* A table of VTDAddressSpace objects indexed by devfn */
+    /* A table of VTDAddressSpace objects indexed by devfn */
+    VTDAddressSpace *dev_as[PCI_DEVFN_MAX];
+    /* A table of VTDIOMMUContext objects indexed by devfn */
+    VTDIOMMUContext *dev_icx[PCI_DEVFN_MAX];
 };
 
 struct VTDIOTLBEntry {
@@ -282,5 +294,6 @@ struct IntelIOMMUState {
  * create a new one if none exists
  */
 VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn);
+VTDIOMMUContext *vtd_find_add_icx(IntelIOMMUState *s, PCIBus *bus, int devfn);
 
 #endif
-- 
2.7.4


