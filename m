Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76274CA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DFA221A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFA221A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdrb-0008HN-1j
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iNcl4-0006Eg-Tm
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iNcl2-0003G7-Mx
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:02:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:40489)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iNcl2-0002NX-Bn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:02:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 06:02:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; d="scan'208";a="210156343"
Received: from iov.bj.intel.com ([10.238.145.67])
 by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2019 06:02:09 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v2 21/22] intel_iommu: propagate PASID-based iotlb invalidation
 to host
Date: Thu, 24 Oct 2019 08:34:42 -0400
Message-Id: <1571920483-3382-22-git-send-email-yi.l.liu@intel.com>
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

This patch propagates PASID-based iotlb invalidation to host.

Intel VT-d 3.0 supports nested translation in PASID granularity. For guest
SVA support, nested translation is enabled for specific PASID. This is also
known as dual stage translation which gives better virtualization support.

Under such configuration, guest owns the GVA->GPA translation which is
configured as first level page table in host side for a specific pasid, and
host owns GPA->HPA translation. As guest owns first level translation table,
piotlb invalidation should be propagated to host since host IOMMU will cache
first level page table related mappings during DMA address translation.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c          | 127 +++++++++++++++++++++++++++++++++++++++++
 hw/i386/intel_iommu_internal.h |   7 +++
 2 files changed, 134 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6cd922f..5ca9ee1 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3092,15 +3092,142 @@ static bool vtd_process_pasid_desc(IntelIOMMUState *s,
     return (ret == 0) ? true : false;
 }
 
+static void vtd_invalidate_piotlb(IntelIOMMUState *s, VTDBus *vtd_bus,
+                                  int devfn, IOMMUCTXCacheInvInfo *inv_info)
+{
+#ifdef __linux__
+    VTDIOMMUContext *vtd_ic;
+    IOMMUCTXEventData event_data;
+    vtd_ic = vtd_bus->dev_ic[devfn];
+    if (!vtd_ic) {
+        return;
+    }
+    event_data.event = IOMMU_CTX_EVENT_CACHE_INV;
+    event_data.data = inv_info;
+    iommu_ctx_event_notify(&vtd_ic->iommu_context, &event_data);
+#endif
+}
+
+static inline bool vtd_pasid_cache_valid(
+                          VTDPASIDAddressSpace *vtd_pasid_as)
+{
+    return (vtd_pasid_as->iommu_state->pasid_cache_gen &&
+            (vtd_pasid_as->iommu_state->pasid_cache_gen
+             == vtd_pasid_as->pasid_cache_entry.pasid_cache_gen));
+}
+
+/**
+ * This function is a loop function for the s->vtd_pasid_as
+ * list with VTDPIOTLBInvInfo as execution filter. It propagates
+ * the piotlb invalidation to host. Caller of this function
+ * should hold iommu_lock.
+ */
+static void vtd_flush_pasid_iotlb(gpointer key, gpointer value,
+                                  gpointer user_data)
+{
+    VTDPIOTLBInvInfo *piotlb_info = user_data;
+    VTDPASIDAddressSpace *vtd_pasid_as = value;
+    uint16_t did;
+
+    /*
+     * Needs to check whether the pasid entry cache stored in
+     * vtd_pasid_as is valid or not. "invalid" means the pasid
+     * cache has been flushed, thus host should have done piotlb
+     * invalidation together with a pasid cache invalidation, so
+     * no need to pass down piotlb invalidation to host for better
+     * performance. Only when pasid entry cache is "valid", should
+     * a piotlb invalidation be propagated to host since it means
+     * guest just modified a mapping in its page table.
+     */
+    if (!vtd_pasid_cache_valid(vtd_pasid_as)) {
+        return;
+    }
+
+    did = vtd_pe_get_domain_id(
+                &(vtd_pasid_as->pasid_cache_entry.pasid_entry));
+
+    if ((piotlb_info->domain_id == did) &&
+        (piotlb_info->pasid == vtd_pasid_as->pasid)) {
+        vtd_invalidate_piotlb(vtd_pasid_as->iommu_state,
+                              vtd_pasid_as->vtd_bus,
+                              vtd_pasid_as->devfn,
+                              &piotlb_info->inv_info);
+    }
+
+    /*
+     * TODO: needs to add QEMU piotlb flush when QEMU piotlb
+     * infrastructure is ready. For now, it is enough for passthru
+     * devices.
+     */
+}
+
 static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
                                         uint16_t domain_id,
                                         uint32_t pasid)
 {
+#ifdef __linux__
+    VTDPIOTLBInvInfo piotlb_info;
+    struct iommu_cache_invalidate_info *cache_info;
+    IOMMUCTXCacheInvInfo *inv_info = &piotlb_info.inv_info;
+
+    cache_info = g_malloc0(sizeof(*cache_info));
+    cache_info->version = IOMMU_CACHE_INVALIDATE_INFO_VERSION_1;
+    cache_info->cache = IOMMU_CACHE_INV_TYPE_IOTLB;
+    cache_info->granularity = IOMMU_INV_GRANU_PASID;
+    cache_info->pasid_info.pasid = pasid;
+    cache_info->pasid_info.flags = IOMMU_INV_PASID_FLAGS_PASID;
+    inv_info->info = cache_info;
+    piotlb_info.domain_id = domain_id;
+    piotlb_info.pasid = pasid;
+
+    vtd_iommu_lock(s);
+    /*
+     * Here loops all the vtd_pasid_as instances in s->vtd_pasid_as
+     * to find out the affected devices since piotlb invalidation
+     * should check pasid cache per architecture point of view.
+     */
+    g_hash_table_foreach(s->vtd_pasid_as,
+                         vtd_flush_pasid_iotlb, &piotlb_info);
+    vtd_iommu_unlock(s);
+
+    g_free(cache_info);
+#endif
 }
 
 static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
                              uint32_t pasid, hwaddr addr, uint8_t am, bool ih)
 {
+#ifdef __linux__
+    VTDPIOTLBInvInfo piotlb_info;
+    struct iommu_cache_invalidate_info *cache_info;
+    IOMMUCTXCacheInvInfo *inv_info = &piotlb_info.inv_info;
+
+    cache_info = g_malloc0(sizeof(*cache_info));
+    cache_info->version = IOMMU_CACHE_INVALIDATE_INFO_VERSION_1;
+    cache_info->cache = IOMMU_CACHE_INV_TYPE_IOTLB;
+    cache_info->granularity = IOMMU_INV_GRANU_ADDR;
+    cache_info->addr_info.flags = IOMMU_INV_ADDR_FLAGS_PASID;
+    cache_info->addr_info.flags |= ih ? IOMMU_INV_ADDR_FLAGS_LEAF : 0;
+    cache_info->addr_info.pasid = pasid;
+    cache_info->addr_info.addr = addr;
+    cache_info->addr_info.granule_size = 1 << (12 + am);
+    cache_info->addr_info.nb_granules = 1;
+    inv_info->info = cache_info;
+    piotlb_info.domain_id = domain_id;
+    piotlb_info.pasid = pasid;
+
+    vtd_iommu_lock(s);
+    /*
+     * Here loops all the vtd_pasid_as instances in s->vtd_pasid_as
+     * to find out the affected devices since piotlb invalidation
+     * should check pasid cache per architecture point of view.
+     */
+    g_hash_table_foreach(s->vtd_pasid_as,
+                         vtd_flush_pasid_iotlb, &piotlb_info);
+    vtd_iommu_unlock(s);
+
+    g_free(cache_info);
+#endif
 }
 
 static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index eddfe54..6a83f6c 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -516,6 +516,13 @@ struct VTDPASIDCacheInfo {
 };
 typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
 
+struct VTDPIOTLBInvInfo {
+    uint16_t domain_id;
+    uint32_t pasid;
+    IOMMUCTXCacheInvInfo inv_info;
+};
+typedef struct VTDPIOTLBInvInfo VTDPIOTLBInvInfo;
+
 /* Masks for struct VTDRootEntry */
 #define VTD_ROOT_ENTRY_P            1ULL
 #define VTD_ROOT_ENTRY_CTP          (~0xfffULL)
-- 
2.7.4


