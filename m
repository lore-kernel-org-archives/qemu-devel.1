Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2E8C35669
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D822071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 08:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D822071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5PtN-0002Km-Sg
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 03:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yi.l.liu@intel.com>) id 1j5Pjm-0002Bf-Jt
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1j5Pji-00081x-UM
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:02:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:49242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1j5Pji-0007zy-LK
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:02:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Feb 2020 00:01:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,471,1574150400"; d="scan'208";a="240547695"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga006.jf.intel.com with ESMTP; 22 Feb 2020 00:01:57 -0800
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org,
	alex.williamson@redhat.com,
	peterx@redhat.com
Subject: [RFC v3.1 15/22] intel_iommu: replay guest pasid bindings to host
Date: Sat, 22 Feb 2020 00:07:16 -0800
Message-Id: <1582358843-51931-16-git-send-email-yi.l.liu@intel.com>
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
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, eric.auger@redhat.com, yi.y.sun@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, pbonzini@redhat.com,
 Richard Henderson <rth@twiddle.net>, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds guest pasid bindings replay for domain
selective pasid cache invalidation(dsi) and global pasid
cache invalidation by walking guest pasid table.

Reason:
Guest OS may flush the pasid cache with a larger granularity.
e.g. guest does a svm_bind() but flush the pasid cache with
global or domain selective pasid cache invalidation instead
of pasid selective(psi) pasid cache invalidation. Regards to
such case, it works in host. Per spec, a global or domain
selective pasid cache invalidation should be able to cover
what a pasid selective invalidation does. The only concern
is performance deduction since dsi and global cache invalidation
will flush more than psi. To align with native, vIOMMU needs
emulator needs to do replay for the two invalidation granularity
to reflect the latest pasid bindings in guest pasid table.

Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu.c          | 183 ++++++++++++++++++++++++++++++++++++++---
 hw/i386/intel_iommu_internal.h |   1 +
 2 files changed, 173 insertions(+), 11 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8bd27b1..e7c9677 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -68,6 +68,8 @@ static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
 static void vtd_pasid_cache_reset(IntelIOMMUState *s);
+static int vtd_update_pe_cache_for_dev(IntelIOMMUState *s,
+              VTDBus *vtd_bus, int devfn, int pasid, VTDPASIDEntry *pe);
 
 static void vtd_panic_require_caching_mode(void)
 {
@@ -2631,6 +2633,127 @@ remove:
     return true;
 }
 
+/**
+ * Constant information used during pasid table walk
+   @vtd_bus, @devfn: device info
+ * @flags: indicates if it is domain selective walk
+ * @did: domain ID of the pasid table walk
+ */
+typedef struct {
+    VTDBus *vtd_bus;
+    uint16_t devfn;
+#define VTD_PASID_TABLE_DID_SEL_WALK   (1ULL << 0);
+    uint32_t flags;
+    uint16_t did;
+} vtd_pasid_table_walk_info;
+
+static bool vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
+                                       dma_addr_t pt_base,
+                                       int start,
+                                       int end,
+                                       vtd_pasid_table_walk_info *info)
+{
+    VTDPASIDEntry pe;
+    int pasid = start;
+    int pasid_next;
+
+    while (pasid < end) {
+        pasid_next = pasid + 1;
+
+        if (!vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe)
+            && vtd_pe_present(&pe)) {
+            if (vtd_update_pe_cache_for_dev(s, info->vtd_bus,
+                                      info->devfn, pasid, &pe)) {
+                error_report_once("%s, bus: %d, devfn: %d, pasid: %d",
+                                  __func__,
+                                  pci_bus_num(info->vtd_bus->bus),
+                                  info->devfn, pasid);
+                return false;
+            }
+        }
+        pasid = pasid_next;
+    }
+    return true;
+}
+
+/*
+ * Currently, VT-d scalable mode pasid table is a two level table,
+ * this function aims to loop a range of PASIDs in a given pasid
+ * table to identify the pasid config in guest.
+ */
+static void vtd_sm_pasid_table_walk(IntelIOMMUState *s,
+                                    dma_addr_t pdt_base,
+                                    int start,
+                                    int end,
+                                    vtd_pasid_table_walk_info *info)
+{
+    VTDPASIDDirEntry pdire;
+    int pasid = start;
+    int pasid_next;
+    dma_addr_t pt_base;
+
+    while (pasid < end) {
+        pasid_next = pasid + VTD_PASID_TBL_ENTRY_NUM;
+        if (!vtd_get_pdire_from_pdir_table(pdt_base, pasid, &pdire)
+            && vtd_pdire_present(&pdire)) {
+            pt_base = pdire.val & VTD_PASID_TABLE_BASE_ADDR_MASK;
+            if (!vtd_sm_pasid_table_walk_one(s,
+                              pt_base, pasid, pasid_next, info)) {
+                break;
+            }
+        }
+        pasid = pasid_next;
+    }
+}
+
+/**
+ * This function replay the guest pasid bindings to hots by
+ * walking the guest PASID table. This ensures host will have
+ * latest guest pasid bindings.
+ */
+static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
+                                            uint16_t *did,
+                                            bool is_dsi)
+{
+    VTDContextEntry ce;
+    VTDBus *vtd_bus;
+    int bus_n, devfn;
+    vtd_pasid_table_walk_info info;
+
+    if (is_dsi) {
+        info.flags = VTD_PASID_TABLE_DID_SEL_WALK;
+        info.did = *did;
+    }
+
+    /*
+     * In this replay, only needs to care about the devices which
+     * has iommu_context created. For the one not have iommu_context,
+     * it is not necessary to replay the bindings since their cache
+     * could be re-created in the next DMA address transaltion.
+     */
+    for (bus_n = 0; bus_n < PCI_BUS_MAX; bus_n++) {
+        vtd_bus = vtd_find_as_from_bus_num(s, bus_n);
+        if (!vtd_bus) {
+            continue;
+        }
+        for (devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
+            PCIDevice *dev;
+
+            dev = vtd_bus->bus->devices[devfn];
+            if (pci_device_host_iommu_context(dev) &&
+                !vtd_dev_to_context_entry(s, bus_n, devfn, &ce)) {
+                info.vtd_bus = vtd_bus;
+                info.devfn = devfn;
+                vtd_sm_pasid_table_walk(s,
+                                        VTD_CE_GET_PASID_DIR_TABLE(&ce),
+                                        0,
+                                        VTD_MAX_HPASID,
+                                        &info);
+            }
+        }
+    }
+}
+
 static int vtd_pasid_cache_dsi(IntelIOMMUState *s, uint16_t domain_id)
 {
     VTDPASIDCacheInfo pc_info;
@@ -2649,13 +2772,14 @@ static int vtd_pasid_cache_dsi(IntelIOMMUState *s, uint16_t domain_id)
     vtd_iommu_unlock(s);
 
     /*
-     * TODO: Domain selective PASID cache invalidation
-     * flushes all the pasid caches within a domain. To
-     * be safe, after invalidating the pasid caches, emulator
-     * needs to replay the pasid bindings by walking guest
-     * pasid dir and pasid table. e.g. When the guest setup a
-     * new PASID entry then send a PASID DSI.
+     * Domain selective PASID cache invalidation flushes
+     * all the pasid caches within a domain. To be safe,
+     * after invalidating the pasid caches, emulator needs
+     * to replay the pasid bindings by walking guest pasid
+     * dir and pasid table. e.g. When the guest setup a new
+     * PASID entry then send a PASID DSI.
      */
+    vtd_replay_guest_pasid_bindings(s, &domain_id, true);
     return 0;
 }
 
@@ -2723,6 +2847,42 @@ static inline void vtd_fill_in_pe_cache(
 }
 
 /**
+ * This function updates the pasid entry cached in &vtd_pasid_as.
+ */
+static int vtd_update_pe_cache_for_dev(IntelIOMMUState *s,
+                                       VTDBus *vtd_bus,
+                                       int devfn, int pasid,
+                                       VTDPASIDEntry *pe)
+{
+    VTDPASIDAddressSpace *vtd_pasid_as;
+    VTDPASIDCacheEntry *pc_entry;
+    int ret;
+
+    vtd_iommu_lock(s);
+    vtd_pasid_as = vtd_add_find_pasid_as(s, vtd_bus,
+                                        devfn, pasid);
+    if (!vtd_pasid_as) {
+        error_report_once("%s, fatal error happened!\n", __func__);
+        ret = -1;
+        goto out;
+    }
+
+    pc_entry = &vtd_pasid_as->pasid_cache_entry;
+    if (pc_entry->pasid_cache_gen == s->pasid_cache_gen &&
+        vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
+        /* No need to go further as cached pasid entry is latest */
+        ret = 0;
+        goto out;
+    }
+
+    vtd_fill_in_pe_cache(vtd_pasid_as, pe);
+    ret = 0;
+out:
+    vtd_iommu_unlock(s);
+    return ret;
+}
+
+/**
  * Caller of this function should hold iommu_lock
  */
 static void vtd_new_pasid_bind_for_dev(IntelIOMMUState *s, VTDBus *vtd_bus,
@@ -2869,12 +3029,13 @@ static int vtd_pasid_cache_gsi(IntelIOMMUState *s)
     vtd_iommu_unlock(s);
 
     /*
-     * TODO: Global PASID cache invalidation may be
-     * flushes all the pasid caches. To be safe, after
-     * invalidating the pasid caches, emulator needs
-     * to replay the pasid bindings by walking guest
-     * pasid dir and pasid table.
+     * Global PASID cache invalidation flushes all
+     * the pasid caches. To be safe, after invalidating
+     * the pasid caches, emulator needs to replay the
+     * pasid bindings by walking guest pasid dir and
+     * pasid table.
      */
+    vtd_replay_guest_pasid_bindings(s, NULL, false);
     return 0;
 }
 
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 9ee5856..46cec5c 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -554,6 +554,7 @@ typedef struct VTDPASIDCacheInfo VTDPASIDCacheInfo;
 #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
 #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
 #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
+#define VTD_PASID_TBL_ENTRY_NUM       (1ULL << 6)
 
 /* PASID Granular Translation Type Mask */
 #define VTD_PASID_ENTRY_P              1ULL
-- 
2.7.4


