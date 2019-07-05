Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F60AC0650E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D631B21670
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D631B21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjj3s-0003SF-6H
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 07:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52647)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hjijX-0003Or-1a
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hjijU-0006IX-0T
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:2989)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hjijT-00060B-Lh
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jul 2019 04:19:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,458,1557212400"; d="scan'208";a="363355073"
Received: from yiliu-dev.bj.intel.com ([10.238.156.139])
 by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2019 04:19:36 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Date: Fri,  5 Jul 2019 19:01:50 +0800
Message-Id: <1562324511-2910-18-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [RFC v1 17/18] intel_iommu: propagate PASID-based
 iotlb flush to host
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

Intel VT-d 3.0 supports nested translation in PASID granularity. For guest
SVA support, nested translation is enabled for specific PASID. In such case,
guest owns the GVA->GPA translation which is configured as first level page
table in host side for a specific pasid, and host owns GPA->HPA translation.
As guest owns first level translation table, guest's PASID-based IOTLB(piotlb)
flush should be propagated to host since host IOMMU will cache first level
page table related mappings during DMA address translation.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c          | 68 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/intel_iommu_internal.h |  7 +++++
 2 files changed, 75 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7a778d8..e4286e5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2516,15 +2516,83 @@ static bool vtd_process_pasid_desc(IntelIOMMUState *s,
     return (ret == 0) ? true : false;
 }
 
+static inline bool vtd_pasid_cache_valid(VTDAddressSpace *vtd_pasid_as)
+{
+    return (vtd_pasid_as->iommu_state->pasid_cache_gen &&
+            (vtd_pasid_as->iommu_state->pasid_cache_gen
+             == vtd_pasid_as->pasid_cache_entry.pasid_cache_gen));
+}
+
+static void vtd_flush_pasid_iotlb(gpointer key, gpointer value,
+                                  gpointer user_data)
+{
+    VTDPIOTLBInvInfo *piotlb_info = user_data;
+    VTDAddressSpace *vtd_pasid_as = value;
+    uint16_t did;
+
+    /*
+     * Actually, needs to check whether the pasid entry cache stored in
+     * vtd_pasid_as is valid or not. "invalid" means the pasid cache
+     * has been flushed, thus host should have done such piotlb flush,
+     * no need to pass down piotlb flush to host. Only when pasid entry
+     * cache is "valid", should a piotlb flush pass down to host. Because
+     * In such case, it is due to mapping changes in guest, a piotlb flush
+     * in host is required.
+     */
+    if (!vtd_pasid_as || !vtd_pasid_cache_valid(vtd_pasid_as)) {
+        return;
+    }
+
+    did = vtd_pe_get_domain_id(
+                &(vtd_pasid_as->pasid_cache_entry.pasid_entry));
+    /*
+     * vtd_pasid_as should be non-NULL and the pasid_cache_gen
+     * should be non-zero. If vtd_pasid_as management is clean,
+     * the vtd_pasid_as is non-NULL is enough.
+     */
+    if ((piotlb_info->domain_id == did) &&
+        (piotlb_info->pasid == vtd_pasid_as->pasid)) {
+        pci_device_flush_pasid_iotlb(vtd_pasid_as->bus,
+                            vtd_pasid_as->devfn, &piotlb_info->tlb_info);
+    }
+}
+
 static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
                                         uint16_t domain_id,
                                         uint32_t pasid)
 {
+    VTDPIOTLBInvInfo piotlb_info;
+    struct iommu_cache_invalidate_info *inv_info = &piotlb_info.tlb_info;
+
+    piotlb_info.domain_id = domain_id;
+    piotlb_info.pasid = pasid;
+    inv_info->version = IOMMU_CACHE_INVALIDATE_INFO_VERSION_1;
+    inv_info->cache = IOMMU_CACHE_INV_TYPE_IOTLB;
+    inv_info->granularity = IOMMU_INV_GRANU_PASID;
+    inv_info->pasid_info.pasid = pasid;
+    inv_info->pasid_info.flags = IOMMU_INV_PASID_FLAGS_PASID;
+    g_hash_table_foreach(s->vtd_pasid_as, vtd_flush_pasid_iotlb, &piotlb_info);
 }
 
 static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
                              uint32_t pasid, hwaddr addr, uint8_t am, bool ih)
 {
+    VTDPIOTLBInvInfo piotlb_info;
+    struct iommu_cache_invalidate_info *inv_info = &piotlb_info.tlb_info;
+
+    piotlb_info.domain_id = domain_id;
+    piotlb_info.pasid = pasid;
+    inv_info->version = IOMMU_CACHE_INVALIDATE_INFO_VERSION_1;
+    inv_info->cache = IOMMU_CACHE_INV_TYPE_IOTLB;
+    inv_info->granularity = IOMMU_INV_GRANU_ADDR;
+    inv_info->addr_info.flags = IOMMU_INV_ADDR_FLAGS_PASID;
+    inv_info->addr_info.flags |= ih ? IOMMU_INV_ADDR_FLAGS_LEAF : 0;
+    inv_info->addr_info.pasid = pasid;
+    inv_info->addr_info.addr = addr;
+    inv_info->addr_info.granule_size = 1 << (12 + am);
+    inv_info->addr_info.nb_granules = 1;
+
+    g_hash_table_foreach(s->vtd_pasid_as, vtd_flush_pasid_iotlb, &piotlb_info);
 }
 
 static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 69cd879..556ea8d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -506,6 +506,13 @@ struct VTDPASIDCacheInfo {
 };
 typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
 
+struct VTDPIOTLBInvInfo {
+    uint16_t domain_id;
+    uint32_t pasid;
+    struct iommu_cache_invalidate_info tlb_info;
+};
+typedef struct VTDPIOTLBInvInfo VTDPIOTLBInvInfo;
+
 /* Masks for struct VTDRootEntry */
 #define VTD_ROOT_ENTRY_P            1ULL
 #define VTD_ROOT_ENTRY_CTP          (~0xfffULL)
-- 
2.7.4


