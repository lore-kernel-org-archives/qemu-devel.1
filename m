Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADB4C48BD5
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:34:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B5C20989
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B5C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjixp-0007mt-EH
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 07:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52593)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hjijT-0003M6-KG
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hjijR-0006Fb-Ar
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:2961)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hjijM-0005e0-L0
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jul 2019 04:19:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,458,1557212400"; d="scan'208";a="363355039"
Received: from yiliu-dev.bj.intel.com ([10.238.156.139])
 by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2019 04:19:25 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Date: Fri,  5 Jul 2019 19:01:46 +0800
Message-Id: <1562324511-2910-14-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [RFC v1 13/18] intel_iommu: flush pasid cache after a
 DSI context cache flush
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

This patch flushes pasid cache after a device selective context cache
flush. This is a behavior to ensure safety. Actually, programmer should
issue a pasid cache flush following a device selective context cache
invalidation.

TODO: global and domain selective context cache flush should also be
followed with a proper pasid cache flush. Also needs to consider pasid
bind replay.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c          | 22 ++++++++++++++++++++++
 hw/i386/intel_iommu_internal.h |  2 ++
 hw/i386/trace-events           |  1 +
 3 files changed, 25 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d897a52..3b213a4 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -70,6 +70,8 @@ static void vtd_pasid_cache_reset(IntelIOMMUState *s);
 static int vtd_pasid_cache_psi(IntelIOMMUState *s,
                                uint16_t domain_id,
                                uint32_t pasid);
+static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
+                                  uint16_t devfn);
 static VTDContextCacheEntry *vtd_find_context_cache(IntelIOMMUState *s,
                                                     PCIBus *bus, int devfn);
 static void vtd_invalidate_pe_cache(IntelIOMMUState *s,
@@ -1955,6 +1957,7 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
                  *    check if the device has been bound to any pasid
                  *    invoke pasid_unbind regards to each bound pasid
                  */
+                 vtd_pasid_cache_devsi(s, devfn_it);
             }
         }
     }
@@ -3686,6 +3689,11 @@ static inline bool vtd_pc_is_pasid_si(struct VTDPASIDCacheInfo *pc_info)
     return pc_info->flags & VTD_PASID_CACHE_PASIDSI;
 }
 
+static inline bool vtd_pc_is_dev_si(struct VTDPASIDCacheInfo *pc_info)
+{
+    return pc_info->flags & VTD_PASID_CACHE_DEVSI;
+}
+
 /**
  * This function is used to clear pasid_cache_gen of cached pasid
  * entry in vtd_pasid_as instance. Caller of this function should
@@ -3709,6 +3717,7 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
     pasid = vtd_pasid_as->pasid;
     devfn = vtd_pasid_as->devfn;
     if (vtd_pasid_as->pasid_cache_entry.pasid_cache_gen &&
+        (vtd_pc_is_dev_si(pc_info) ? (pc_info->devfn == devfn) : 1) &&
         (vtd_pc_is_dom_si(pc_info) ? (pc_info->domain_id == did) : 1) &&
         (vtd_pc_is_pasid_si(pc_info) ? (pc_info->pasid == pasid) : 1)) {
         /*
@@ -3917,6 +3926,19 @@ static int vtd_pasid_cache_psi(IntelIOMMUState *s,
     return 0;
 }
 
+static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
+                                  uint16_t devfn)
+{
+    VTDPASIDCacheInfo pc_info;
+
+    trace_vtd_pasid_cache_devsi(devfn);
+
+    pc_info.flags = VTD_PASID_CACHE_DEVSI;
+    pc_info.devfn = devfn;
+
+    g_hash_table_foreach_remove(s->vtd_pasid_as, vtd_flush_pasid, &pc_info);
+}
+
 /**
  * Caller of this function should hold iommu_lock
  */
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index f9a4ac6..021d358 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -485,9 +485,11 @@ typedef enum VTDPASIDOp VTDPASIDOp;
 struct VTDPASIDCacheInfo {
 #define VTD_PASID_CACHE_DOMSI   (1ULL << 0);
 #define VTD_PASID_CACHE_PASIDSI (1ULL << 1);
+#define VTD_PASID_CACHE_DEVSI   (1ULL << 2);
     uint32_t flags;
     uint16_t domain_id;
     uint32_t pasid;
+    uint16_t devfn;
 };
 typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
 
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 7912ae1..25bd6a4 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -26,6 +26,7 @@ vtd_pasid_cache_reset(void) ""
 vtd_pasid_cache_gsi(void) ""
 vtd_pasid_cache_dsi(uint16_t domain) "Domian slective PC invalidation domain 0x%"PRIx16
 vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID slective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
+vtd_pasid_cache_devsi(uint16_t devfn) "Dev slective PC invalidation dev: 0x%"PRIx16
 vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
 vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
 vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
-- 
2.7.4


