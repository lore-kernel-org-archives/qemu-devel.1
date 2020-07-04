Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A58C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9982084C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9982084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrgXF-00035l-Rj
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 07:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jrgNL-0000k6-8b
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 07:30:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:24796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1jrgNI-0004KB-Vh
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 07:30:30 -0400
IronPort-SDR: ujDdiUAQ2RiJYIS1JkDe1nwxqe6xvsvaagZNztDRRV8A/SiACFuTB145iLNOE2Qo1AAty8BcNO
 Ijst1gGnxc4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="232105527"
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; d="scan'208";a="232105527"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2020 04:30:19 -0700
IronPort-SDR: DdVrKOdR64F6YWLBeLyRrYYOR3FlkI/xu+7LI/27hUFX2YTTlPffq+mv7EsXzeLzXBUzXozrCf
 m7LVtGlQsKbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,311,1589266800"; d="scan'208";a="266146804"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by fmsmga007.fm.intel.com with ESMTP; 04 Jul 2020 04:30:18 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [RFC v7 10/25] intel_iommu: add set/unset_iommu_context callback
Date: Sat,  4 Jul 2020 04:36:34 -0700
Message-Id: <1593862609-36135-11-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593862609-36135-1-git-send-email-yi.l.liu@intel.com>
References: <1593862609-36135-1-git-send-email-yi.l.liu@intel.com>
Received-SPF: pass client-ip=192.55.52.43; envelope-from=yi.l.liu@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 07:30:14
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 eric.auger@redhat.com, yi.y.sun@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, pbonzini@redhat.com,
 hao.wu@intel.com, jasowang@redhat.com, Richard Henderson <rth@twiddle.net>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds set/unset_iommu_context() impelementation in Intel
vIOMMU. PCIe devices (VFIO case) sets HostIOMMUContext to vIOMMU as
an ack of vIOMMU's "want_nested" attribute. Thus vIOMMU could build
DMA protection based on nested paging of host IOMMU.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c         | 71 ++++++++++++++++++++++++++++++++++++++++---
 include/hw/i386/intel_iommu.h | 21 ++++++++++---
 2 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2d6748f..8f7c957 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3359,23 +3359,33 @@ static const MemoryRegionOps vtd_mem_ir_ops = {
     },
 };
 
-VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
+/**
+ * Fetch a VTDBus instance for given PCIBus. If no existing instance,
+ * allocate one.
+ */
+static VTDBus *vtd_find_add_bus(IntelIOMMUState *s, PCIBus *bus)
 {
     uintptr_t key = (uintptr_t)bus;
     VTDBus *vtd_bus = g_hash_table_lookup(s->vtd_as_by_busptr, &key);
-    VTDAddressSpace *vtd_dev_as;
-    char name[128];
 
     if (!vtd_bus) {
         uintptr_t *new_key = g_malloc(sizeof(*new_key));
         *new_key = (uintptr_t)bus;
         /* No corresponding free() */
-        vtd_bus = g_malloc0(sizeof(VTDBus) + sizeof(VTDAddressSpace *) * \
-                            PCI_DEVFN_MAX);
+        vtd_bus = g_malloc0(sizeof(VTDBus));
         vtd_bus->bus = bus;
         g_hash_table_insert(s->vtd_as_by_busptr, new_key, vtd_bus);
     }
+    return vtd_bus;
+}
 
+VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
+{
+    VTDBus *vtd_bus;
+    VTDAddressSpace *vtd_dev_as;
+    char name[128];
+
+    vtd_bus = vtd_find_add_bus(s, bus);
     vtd_dev_as = vtd_bus->dev_as[devfn];
 
     if (!vtd_dev_as) {
@@ -3463,6 +3473,55 @@ static int vtd_dev_get_iommu_attr(PCIBus *bus, void *opaque, int32_t devfn,
     return ret;
 }
 
+static int vtd_dev_set_iommu_context(PCIBus *bus, void *opaque,
+                                     int devfn,
+                                     HostIOMMUContext *iommu_ctx)
+{
+    IntelIOMMUState *s = opaque;
+    VTDBus *vtd_bus;
+    VTDHostIOMMUContext *vtd_dev_icx;
+
+    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
+
+    vtd_bus = vtd_find_add_bus(s, bus);
+
+    vtd_iommu_lock(s);
+
+    vtd_dev_icx = vtd_bus->dev_icx[devfn];
+
+    assert(!vtd_dev_icx);
+
+    vtd_bus->dev_icx[devfn] = vtd_dev_icx =
+                    g_malloc0(sizeof(VTDHostIOMMUContext));
+    vtd_dev_icx->vtd_bus = vtd_bus;
+    vtd_dev_icx->devfn = (uint8_t)devfn;
+    vtd_dev_icx->iommu_state = s;
+    vtd_dev_icx->iommu_ctx = iommu_ctx;
+
+    vtd_iommu_unlock(s);
+
+    return 0;
+}
+
+static void vtd_dev_unset_iommu_context(PCIBus *bus, void *opaque, int devfn)
+{
+    IntelIOMMUState *s = opaque;
+    VTDBus *vtd_bus;
+    VTDHostIOMMUContext *vtd_dev_icx;
+
+    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
+
+    vtd_bus = vtd_find_add_bus(s, bus);
+
+    vtd_iommu_lock(s);
+
+    vtd_dev_icx = vtd_bus->dev_icx[devfn];
+    g_free(vtd_dev_icx);
+    vtd_bus->dev_icx[devfn] = NULL;
+
+    vtd_iommu_unlock(s);
+}
+
 static uint64_t get_naturally_aligned_size(uint64_t start,
                                            uint64_t size, int gaw)
 {
@@ -3759,6 +3818,8 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 static PCIIOMMUOps vtd_iommu_ops = {
     .get_address_space = vtd_host_dma_iommu,
     .get_iommu_attr = vtd_dev_get_iommu_attr,
+    .set_iommu_context = vtd_dev_set_iommu_context,
+    .unset_iommu_context = vtd_dev_unset_iommu_context,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 3870052..b5fefb9 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -64,6 +64,7 @@ typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
 typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
 typedef struct VTDPASIDDirEntry VTDPASIDDirEntry;
 typedef struct VTDPASIDEntry VTDPASIDEntry;
+typedef struct VTDHostIOMMUContext VTDHostIOMMUContext;
 
 /* Context-Entry */
 struct VTDContextEntry {
@@ -112,10 +113,20 @@ struct VTDAddressSpace {
     IOVATree *iova_tree;          /* Traces mapped IOVA ranges */
 };
 
+struct VTDHostIOMMUContext {
+    VTDBus *vtd_bus;
+    uint8_t devfn;
+    HostIOMMUContext *iommu_ctx;
+    IntelIOMMUState *iommu_state;
+};
+
 struct VTDBus {
-    PCIBus* bus;		/* A reference to the bus to provide translation for */
+    /* A reference to the bus to provide translation for */
+    PCIBus *bus;
     /* A table of VTDAddressSpace objects indexed by devfn */
-    VTDAddressSpace *dev_as[];
+    VTDAddressSpace *dev_as[PCI_DEVFN_MAX];
+    /* A table of VTDHostIOMMUContext objects indexed by devfn */
+    VTDHostIOMMUContext *dev_icx[PCI_DEVFN_MAX];
 };
 
 struct VTDIOTLBEntry {
@@ -269,8 +280,10 @@ struct IntelIOMMUState {
     bool dma_drain;                 /* Whether DMA r/w draining enabled */
 
     /*
-     * Protects IOMMU states in general.  Currently it protects the
-     * per-IOMMU IOTLB cache, and context entry cache in VTDAddressSpace.
+     * iommu_lock protects below:
+     * - per-IOMMU IOTLB caches
+     * - context entry cache in VTDAddressSpace
+     * - HostIOMMUContext pointer cached in vIOMMU
      */
     QemuMutex iommu_lock;
 };
-- 
2.7.4


