Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEDFC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB6F2064C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 12:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB6F2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwmMj-0000GR-Al
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 07:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCz-0000QH-RS
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1iwmCy-0003nn-8w
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:12:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:58712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1iwmCx-0001Pn-Sp
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 07:12:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 04:11:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,377,1574150400"; d="scan'208";a="314071275"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by fmsmga001.fm.intel.com with ESMTP; 29 Jan 2020 04:11:52 -0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Subject: [RFC v3 20/25] intel_iommu: replay pasid binds after context cache
 invalidation
Date: Wed, 29 Jan 2020 04:16:51 -0800
Message-Id: <1580300216-86172-21-git-send-email-yi.l.liu@intel.com>
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

This patch replays guest pasid bindings after context cache
invalidation. This is a behavior to ensure safety. Actually,
programmer should issue pasid cache invalidation with proper
granularity after issuing a context cache invalidation.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c          | 67 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/intel_iommu_internal.h |  6 +++-
 hw/i386/trace-events           |  1 +
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1665843..6422add 100644
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
@@ -1865,6 +1869,10 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
      * VT-d emulation codes.
      */
     vtd_iommu_replay_all(s);
+
+    vtd_iommu_lock(s);
+    vtd_replay_guest_pasid_bindings(s, NULL, false);
+    vtd_iommu_unlock(s);
 }
 
 static int vtd_bind_guest_pasid(IntelIOMMUState *s, VTDBus *vtd_bus,
@@ -1986,6 +1994,22 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
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
+                 * flush piotlb when a pasid unbind is pass down to it.
+                 */
+                 vtd_pasid_cache_devsi(s, vtd_bus, devfn_it);
             }
         }
     }
@@ -2581,6 +2605,12 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
         /* Fall through */
     case VTD_PASID_CACHE_GLOBAL:
         break;
+    case VTD_PASID_CACHE_DEVSI:
+        if (pc_info->vtd_bus != vtd_bus ||
+            pc_info->devfn == devfn) {
+            return false;
+        }
+        break;
     default:
         return false;
     }
@@ -2944,6 +2974,43 @@ static int vtd_pasid_cache_psi(IntelIOMMUState *s,
     return 0;
 }
 
+static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
+                                  VTDBus *vtd_bus, uint16_t devfn)
+{
+    VTDPASIDCacheInfo pc_info;
+    VTDContextEntry ce;
+    vtd_pasid_table_walk_info info;
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
+    if (vtd_bus->dev_icx[devfn] &&
+        !vtd_dev_to_context_entry(s,
+                                  pci_bus_num(vtd_bus->bus),
+                                  devfn, &ce)) {
+        info.flags = 0x0;
+        info.did = 0;
+        info.vtd_icx = vtd_bus->dev_icx[devfn];
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
index cd96b6e..a487b30 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -504,13 +504,17 @@ struct VTDPASIDCacheInfo {
 #define VTD_PASID_CACHE_GLOBAL   (1ULL << 0)
 #define VTD_PASID_CACHE_DOMSI    (1ULL << 1)
 #define VTD_PASID_CACHE_PASIDSI  (1ULL << 2)
+#define VTD_PASID_CACHE_DEVSI    (1ULL << 3)
     uint32_t flags;
     uint16_t domain_id;
     uint32_t pasid;
+    VTDBus *vtd_bus;
+    uint16_t devfn;
 };
 #define VTD_PASID_CACHE_INFO_MASK    (VTD_PASID_CACHE_GLOBAL | \
                                       VTD_PASID_CACHE_DOMSI  | \
-                                      VTD_PASID_CACHE_PASIDSI)
+                                      VTD_PASID_CACHE_PASIDSI | \
+                                      VTD_PASID_CACHE_DEVSI)
 typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
 
 /* Masks for struct VTDRootEntry */
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 87364a3..75f5002 100644
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


