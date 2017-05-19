Received: from eggs.gnu.org ([2001:4830:134:3::10]:35569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBYTH-000761-Lf
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBYTF-0005g5-TU
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:20:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBYTF-0005fa-Eg
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:20:53 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 May 2017 11:19:47 +0800
Message-Id: <1495163989-9994-9-git-send-email-peterx@redhat.com>
In-Reply-To: <1495163989-9994-1-git-send-email-peterx@redhat.com>
References: <1495163989-9994-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 08/10] intel_iommu: support passthrough (PT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

Hardware support for VT-d device passthrough. Although current Linux can
live with iommu=pt even without this, but this is faster than when using
software passthrough.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c          | 231 ++++++++++++++++++++++++++++++-----------
 hw/i386/intel_iommu_internal.h |   1 +
 hw/i386/trace-events           |   2 +
 hw/i386/x86-iommu.c            |   1 +
 include/hw/i386/x86-iommu.h    |   1 +
 5 files changed, 177 insertions(+), 59 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index aac2cc7..15610b9 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -613,6 +613,11 @@ static inline bool vtd_ce_type_check(X86IOMMUState *x86_iommu,
             return false;
         }
         break;
+    case VTD_CONTEXT_TT_PASS_THROUGH:
+        if (!x86_iommu->pt_supported) {
+            return false;
+        }
+        break;
     default:
         /* Unknwon type */
         return false;
@@ -660,6 +665,29 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
     }
 }
 
+/* Find the VTD address space associated with a given bus number */
+static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bus_num)
+{
+    VTDBus *vtd_bus = s->vtd_as_by_bus_num[bus_num];
+    if (!vtd_bus) {
+        /*
+         * Iterate over the registered buses to find the one which
+         * currently hold this bus number, and update the bus_num
+         * lookup table:
+         */
+        GHashTableIter iter;
+
+        g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
+        while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
+            if (pci_bus_num(vtd_bus->bus) == bus_num) {
+                s->vtd_as_by_bus_num[bus_num] = vtd_bus;
+                return vtd_bus;
+            }
+        }
+    }
+    return vtd_bus;
+}
+
 /* Given the @iova, get relevant @slptep. @slpte_level will be the last level
  * of the translation, can be used for deciding the size of large page.
  */
@@ -906,6 +934,91 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
     return 0;
 }
 
+/*
+ * Fetch translation type for specific device. Returns <0 if error
+ * happens, otherwise return the shifted type to check against
+ * VTD_CONTEXT_TT_*.
+ */
+static int vtd_dev_get_trans_type(VTDAddressSpace *as)
+{
+    IntelIOMMUState *s;
+    VTDContextEntry ce;
+    int ret;
+
+    s = as->iommu_state;
+
+    ret = vtd_dev_to_context_entry(s, pci_bus_num(as->bus),
+                                   as->devfn, &ce);
+    if (ret) {
+        return ret;
+    }
+
+    return vtd_ce_get_type(&ce);
+}
+
+static bool vtd_dev_pt_enabled(VTDAddressSpace *as)
+{
+    int ret;
+
+    assert(as);
+
+    ret = vtd_dev_get_trans_type(as);
+    if (ret < 0) {
+        /*
+         * Possibly failed to parse the context entry for some reason
+         * (e.g., during init, or any guest configuration errors on
+         * context entries). We should assume PT not enabled for
+         * safety.
+         */
+        return false;
+    }
+
+    return ret == VTD_CONTEXT_TT_PASS_THROUGH;
+}
+
+/* Return whether the device is using IOMMU translation. */
+static bool vtd_switch_address_space(VTDAddressSpace *as)
+{
+    bool use_iommu;
+
+    assert(as);
+
+    use_iommu = as->iommu_state->dmar_enabled & !vtd_dev_pt_enabled(as);
+
+    trace_vtd_switch_address_space(pci_bus_num(as->bus),
+                                   VTD_PCI_SLOT(as->devfn),
+                                   VTD_PCI_FUNC(as->devfn),
+                                   use_iommu);
+
+    /* Turn off first then on the other */
+    if (use_iommu) {
+        memory_region_set_enabled(&as->sys_alias, false);
+        memory_region_set_enabled(&as->iommu, true);
+    } else {
+        memory_region_set_enabled(&as->iommu, false);
+        memory_region_set_enabled(&as->sys_alias, true);
+    }
+
+    return use_iommu;
+}
+
+static void vtd_switch_address_space_all(IntelIOMMUState *s)
+{
+    GHashTableIter iter;
+    VTDBus *vtd_bus;
+    int i;
+
+    g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
+    while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
+        for (i = 0; i < X86_IOMMU_PCI_DEVFN_MAX; i++) {
+            if (!vtd_bus->dev_as[i]) {
+                continue;
+            }
+            vtd_switch_address_space(vtd_bus->dev_as[i]);
+        }
+    }
+}
+
 static inline uint16_t vtd_make_source_id(uint8_t bus_num, uint8_t devfn)
 {
     return ((bus_num & 0xffUL) << 8) | (devfn & 0xffUL);
@@ -943,6 +1056,31 @@ static inline bool vtd_is_interrupt_addr(hwaddr addr)
     return VTD_INTERRUPT_ADDR_FIRST <= addr && addr <= VTD_INTERRUPT_ADDR_LAST;
 }
 
+static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_id)
+{
+    VTDBus *vtd_bus;
+    VTDAddressSpace *vtd_as;
+    bool success = false;
+
+    vtd_bus = vtd_find_as_from_bus_num(s, VTD_SID_TO_BUS(source_id));
+    if (!vtd_bus) {
+        goto out;
+    }
+
+    vtd_as = vtd_bus->dev_as[VTD_SID_TO_DEVFN(source_id)];
+    if (!vtd_as) {
+        goto out;
+    }
+
+    if (vtd_switch_address_space(vtd_as) == false) {
+        /* We switched off IOMMU region successfully. */
+        success = true;
+    }
+
+out:
+    trace_vtd_pt_enable_fast_path(source_id, success);
+}
+
 /* Map dev to context-entry then do a paging-structures walk to do a iommu
  * translation.
  *
@@ -1014,6 +1152,30 @@ static void vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         cc_entry->context_cache_gen = s->context_cache_gen;
     }
 
+    /*
+     * We don't need to translate for pass-through context entries.
+     * Also, let's ignore IOTLB caching as well for PT devices.
+     */
+    if (vtd_ce_get_type(&ce) == VTD_CONTEXT_TT_PASS_THROUGH) {
+        entry->translated_addr = entry->iova;
+        entry->addr_mask = VTD_PAGE_SIZE - 1;
+        entry->perm = IOMMU_RW;
+        trace_vtd_translate_pt(source_id, entry->iova);
+
+        /*
+         * When this happens, it means firstly caching-mode is not
+         * enabled, and this is the first passthrough translation for
+         * the device. Let's enable the fast path for passthrough.
+         *
+         * When passthrough is disabled again for the device, we can
+         * capture it via the context entry invalidation, then the
+         * IOMMU region can be swapped back.
+         */
+        vtd_pt_enable_fast_path(s, source_id);
+
+        return;
+    }
+
     ret_fr = vtd_iova_to_slpte(&ce, addr, is_write, &slpte, &level,
                                &reads, &writes);
     if (ret_fr) {
@@ -1083,6 +1245,7 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
     if (s->context_cache_gen == VTD_CONTEXT_CACHE_GEN_MAX) {
         vtd_reset_context_cache(s);
     }
+    vtd_switch_address_space_all(s);
     /*
      * From VT-d spec 6.5.2.1, a global context entry invalidation
      * should be followed by a IOTLB global invalidation, so we should
@@ -1093,29 +1256,6 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
     vtd_iommu_replay_all(s);
 }
 
-
-/* Find the VTD address space currently associated with a given bus number,
- */
-static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bus_num)
-{
-    VTDBus *vtd_bus = s->vtd_as_by_bus_num[bus_num];
-    if (!vtd_bus) {
-        /* Iterate over the registered buses to find the one
-         * which currently hold this bus number, and update the bus_num lookup table:
-         */
-        GHashTableIter iter;
-
-        g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
-        while (g_hash_table_iter_next (&iter, NULL, (void**)&vtd_bus)) {
-            if (pci_bus_num(vtd_bus->bus) == bus_num) {
-                s->vtd_as_by_bus_num[bus_num] = vtd_bus;
-                return vtd_bus;
-            }
-        }
-    }
-    return vtd_bus;
-}
-
 /* Do a context-cache device-selective invalidation.
  * @func_mask: FM field after shifting
  */
@@ -1158,6 +1298,11 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
                                              VTD_PCI_FUNC(devfn_it));
                 vtd_as->context_cache_entry.context_cache_gen = 0;
                 /*
+                 * Do switch address space when needed, in case if the
+                 * device passthrough bit is switched.
+                 */
+                vtd_switch_address_space(vtd_as);
+                /*
                  * So a device is moving out of (or moving into) a
                  * domain, a replay() suites here to notify all the
                  * IOMMU_NOTIFIER_MAP registers about this change.
@@ -1389,42 +1534,6 @@ static void vtd_handle_gcmd_sirtp(IntelIOMMUState *s)
     vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_IRTPS);
 }
 
-static void vtd_switch_address_space(VTDAddressSpace *as)
-{
-    assert(as);
-
-    trace_vtd_switch_address_space(pci_bus_num(as->bus),
-                                   VTD_PCI_SLOT(as->devfn),
-                                   VTD_PCI_FUNC(as->devfn),
-                                   as->iommu_state->dmar_enabled);
-
-    /* Turn off first then on the other */
-    if (as->iommu_state->dmar_enabled) {
-        memory_region_set_enabled(&as->sys_alias, false);
-        memory_region_set_enabled(&as->iommu, true);
-    } else {
-        memory_region_set_enabled(&as->iommu, false);
-        memory_region_set_enabled(&as->sys_alias, true);
-    }
-}
-
-static void vtd_switch_address_space_all(IntelIOMMUState *s)
-{
-    GHashTableIter iter;
-    VTDBus *vtd_bus;
-    int i;
-
-    g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
-    while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
-        for (i = 0; i < X86_IOMMU_PCI_DEVFN_MAX; i++) {
-            if (!vtd_bus->dev_as[i]) {
-                continue;
-            }
-            vtd_switch_address_space(vtd_bus->dev_as[i]);
-        }
-    }
-}
-
 /* Handle Translation Enable/Disable */
 static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
 {
@@ -2872,6 +2981,10 @@ static void vtd_init(IntelIOMMUState *s)
         s->ecap |= VTD_ECAP_DT;
     }
 
+    if (x86_iommu->pt_supported) {
+        s->ecap |= VTD_ECAP_PT;
+    }
+
     if (s->caching_mode) {
         s->cap |= VTD_CAP_CM;
     }
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 29d6707..0e73a65 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -187,6 +187,7 @@
 /* Interrupt Remapping support */
 #define VTD_ECAP_IR                 (1ULL << 3)
 #define VTD_ECAP_EIM                (1ULL << 4)
+#define VTD_ECAP_PT                 (1ULL << 6)
 #define VTD_ECAP_MHMV               (15ULL << 20)
 
 /* CAP_REG */
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 04a6980..72556da 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -38,6 +38,8 @@ vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"P
 vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
 vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
 vtd_as_unmap_whole(uint8_t bus, uint8_t slot, uint8_t fn, uint64_t iova, uint64_t size) "Device %02x:%02x.%x start 0x%"PRIx64" size 0x%"PRIx64
+vtd_translate_pt(uint16_t sid, uint64_t addr) "source id 0x%"PRIu16", iova 0x%"PRIx64
+vtd_pt_enable_fast_path(uint16_t sid, bool success) "sid 0x%"PRIu16" %d"
 
 # hw/i386/amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 02b8825..293caf8 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -91,6 +91,7 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
 static Property x86_iommu_properties[] = {
     DEFINE_PROP_BOOL("intremap", X86IOMMUState, intr_supported, false),
     DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
+    DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index 361c07c..ef89c0c 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -74,6 +74,7 @@ struct X86IOMMUState {
     SysBusDevice busdev;
     bool intr_supported;        /* Whether vIOMMU supports IR */
     bool dt_supported;          /* Whether vIOMMU supports DT */
+    bool pt_supported;          /* Whether vIOMMU supports pass-through */
     IommuType type;             /* IOMMU type - AMD/Intel     */
     QLIST_HEAD(, IEC_Notifier) iec_notifiers; /* IEC notify list */
 };
-- 
2.7.4
