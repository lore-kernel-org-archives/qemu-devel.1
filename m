Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7A6CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0676620679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0676620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdNq-0001PJ-Bb
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckq-0005x1-B5
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:02:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iNckn-0002xm-Ps
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:02:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:40529)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iNckn-0002c5-C8
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:02:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Oct 2019 06:02:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; d="scan'208";a="210156312"
Received: from iov.bj.intel.com ([10.238.145.67])
 by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2019 06:01:58 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v2 17/22] intel_iommu: replay pasid binds after context cache
 invalidation
Date: Thu, 24 Oct 2019 08:34:38 -0400
Message-Id: <1571920483-3382-18-git-send-email-yi.l.liu@intel.com>
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

This patch replays guest pasid bindings after context cache invalidation.
This is a behavior to ensure safety. Actually, programmer should issue
pasid cache invalidation with proper granularity after issuing a context
cache invalidation.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c          | 68 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/intel_iommu_internal.h |  3 ++
 hw/i386/trace-events           |  1 +
 3 files changed, 72 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a9e660c..6bceb7f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -70,6 +70,10 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 static void vtd_pasid_cache_reset(IntelIOMMUState *s);
 static int vtd_update_pe_cache_for_dev(IntelIOMMUState *s,
               VTDBus *vtd_bus, int devfn, int pasid, VTDPASIDEntry *pe);
+static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
+                                           uint16_t *did, bool is_dsi);
+static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
+                                  VTDBus *vtd_bus, uint16_t devfn);
 
 static void vtd_panic_require_caching_mode(void)
 {
@@ -1861,6 +1865,10 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
      * VT-d emulation codes.
      */
     vtd_iommu_replay_all(s);
+
+    vtd_iommu_lock(s);
+    vtd_replay_guest_pasid_bindings(s, NULL, false);
+    vtd_iommu_unlock(s);
 }
 
 static void vtd_bind_guest_pasid(IntelIOMMUState *s, VTDBus *vtd_bus,
@@ -1981,6 +1989,22 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
                  * happened.
                  */
                 vtd_sync_shadow_page_table(vtd_as);
+                /*
+                 * Per spec, context flush should also followed with PASID
+                 * cache and iotlb flush. Regards to a device selective
+                 * context cache invalidation:
+                 * if (emaulted_device)
+                 *    modify the pasid cache gen and pasid-based iotlb gen
+                 *    value (will be added in following patches)
+                 * else if (assigned_device)
+                 *    check if the device has been bound to any pasid
+                 *    invoke pasid_unbind regards to each bound pasid
+                 * Here, we have vtd_pasid_cache_devsi() to invalidate pasid
+                 * caches, while for piotlb in QEMU, we don't have it yet, so
+                 * no handling. For assigned device, host iommu driver would
+                 * flush piotlb when a pasid unbind is passdown to it.
+                 */
+                 vtd_pasid_cache_devsi(s, vtd_bus, devfn_it);
             }
         }
     }
@@ -2516,6 +2540,11 @@ static inline bool vtd_pc_is_pasid_si(struct VTDPASIDCacheInfo *pc_info)
     return pc_info->flags & VTD_PASID_CACHE_PASIDSI;
 }
 
+static inline bool vtd_pc_is_dev_si(struct VTDPASIDCacheInfo *pc_info)
+{
+    return pc_info->flags & VTD_PASID_CACHE_DEVSI;
+}
+
 static inline int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s,
                                             uint8_t bus_num,
                                             uint8_t devfn,
@@ -2578,6 +2607,8 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
     devfn = vtd_pasid_as->devfn;
 
     if (pc_entry->pasid_cache_gen &&
+        (vtd_pc_is_dev_si(pc_info) ? (((pc_info->devfn == devfn)) &&
+         (pc_info->vtd_bus == vtd_bus)) : 1) &&
         (vtd_pc_is_dom_si(pc_info) ? (pc_info->domain_id == did) : 1) &&
         (vtd_pc_is_pasid_si(pc_info) ? (pc_info->pasid == pasid) : 1)) {
         /*
@@ -2934,6 +2965,43 @@ static int vtd_pasid_cache_psi(IntelIOMMUState *s,
     return 0;
 }
 
+static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
+                                  VTDBus *vtd_bus, uint16_t devfn)
+{
+    VTDPASIDCacheInfo pc_info;
+    VTDContextEntry ce;
+    vtd_pt_walk_info info;
+
+    trace_vtd_pasid_cache_devsi(devfn);
+
+    pc_info.flags = VTD_PASID_CACHE_DEVSI;
+    pc_info.vtd_bus = vtd_bus;
+    pc_info.devfn = devfn;
+
+    vtd_iommu_lock(s);
+    g_hash_table_foreach_remove(s->vtd_pasid_as, vtd_flush_pasid, &pc_info);
+
+    /*
+     * To be safe, after invalidating the pasid caches,
+     * emulator needs to replay the pasid bindings by
+     * walking guest pasid dir and pasid table.
+     */
+    if (vtd_bus->dev_ic[devfn] &&
+        !vtd_dev_to_context_entry(s,
+                                  pci_bus_num(vtd_bus->bus),
+                                  devfn, &ce)) {
+        info.flags = 0x0;
+        info.did = 0;
+        info.ic = vtd_bus->dev_ic[devfn];
+        vtd_sm_pasid_table_walk(s,
+                                VTD_CE_GET_PASID_DIR_TABLE(&ce),
+                                0,
+                                VTD_MAX_HPASID,
+                                &info);
+    }
+    vtd_iommu_unlock(s);
+}
+
 /**
  * Caller of this function should hold iommu_lock
  */
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index eab65ef..908536c 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -494,9 +494,12 @@ typedef enum VTDPASIDOp VTDPASIDOp;
 struct VTDPASIDCacheInfo {
 #define VTD_PASID_CACHE_DOMSI   (1ULL << 0);
 #define VTD_PASID_CACHE_PASIDSI (1ULL << 1);
+#define VTD_PASID_CACHE_DEVSI   (1ULL << 2);
     uint32_t flags;
     uint16_t domain_id;
     uint32_t pasid;
+    VTDBus *vtd_bus;
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


