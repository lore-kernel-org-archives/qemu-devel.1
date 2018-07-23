Received: from eggs.gnu.org ([2001:4830:134:3::10]:41133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIj-0001qC-LD
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIi-0003AC-01
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:25 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:36 -0500
Message-Id: <20180723201748.25573-28-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 27/99] intel-iommu: add iommu lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Peter Xu <peterx@redhat.com>

SECURITY IMPLICATION: this patch fixes a potential race when multiple
threads access the IOMMU IOTLB cache.

Add a per-iommu big lock to protect IOMMU status.  Currently the only
thing to be protected is the IOTLB/context cache, since that can be
accessed even without BQL, e.g., in IO dataplane.

Note that we don't need to protect device page tables since that's fully
controlled by the guest kernel.  However there is still possibility that
malicious drivers will program the device to not obey the rule.  In that
case QEMU can't really do anything useful, instead the guest itself will
be responsible for all uncertainties.

CC: QEMU Stable <qemu-stable@nongnu.org>
Reported-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 1d9efa73e12ddf361ea997c2d532cc4afa6674d1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/intel_iommu.c         | 56 +++++++++++++++++++++++++++++------
 include/hw/i386/intel_iommu.h |  6 ++++
 2 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3df90457f8..8d4069de9f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -128,6 +128,16 @@ static uint64_t vtd_set_clear_mask_quad(IntelIOMMUState *s, hwaddr addr,
     return new_val;
 }
 
+static inline void vtd_iommu_lock(IntelIOMMUState *s)
+{
+    qemu_mutex_lock(&s->iommu_lock);
+}
+
+static inline void vtd_iommu_unlock(IntelIOMMUState *s)
+{
+    qemu_mutex_unlock(&s->iommu_lock);
+}
+
 /* GHashTable functions */
 static gboolean vtd_uint64_equal(gconstpointer v1, gconstpointer v2)
 {
@@ -172,9 +182,9 @@ static gboolean vtd_hash_remove_by_page(gpointer key, gpointer value,
 }
 
 /* Reset all the gen of VTDAddressSpace to zero and set the gen of
- * IntelIOMMUState to 1.
+ * IntelIOMMUState to 1.  Must be called with IOMMU lock held.
  */
-static void vtd_reset_context_cache(IntelIOMMUState *s)
+static void vtd_reset_context_cache_locked(IntelIOMMUState *s)
 {
     VTDAddressSpace *vtd_as;
     VTDBus *vtd_bus;
@@ -197,12 +207,20 @@ static void vtd_reset_context_cache(IntelIOMMUState *s)
     s->context_cache_gen = 1;
 }
 
-static void vtd_reset_iotlb(IntelIOMMUState *s)
+/* Must be called with IOMMU lock held. */
+static void vtd_reset_iotlb_locked(IntelIOMMUState *s)
 {
     assert(s->iotlb);
     g_hash_table_remove_all(s->iotlb);
 }
 
+static void vtd_reset_iotlb(IntelIOMMUState *s)
+{
+    vtd_iommu_lock(s);
+    vtd_reset_iotlb_locked(s);
+    vtd_iommu_unlock(s);
+}
+
 static uint64_t vtd_get_iotlb_key(uint64_t gfn, uint16_t source_id,
                                   uint32_t level)
 {
@@ -215,6 +233,7 @@ static uint64_t vtd_get_iotlb_gfn(hwaddr addr, uint32_t level)
     return (addr & vtd_slpt_level_page_mask(level)) >> VTD_PAGE_SHIFT_4K;
 }
 
+/* Must be called with IOMMU lock held */
 static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
                                        hwaddr addr)
 {
@@ -235,6 +254,7 @@ out:
     return entry;
 }
 
+/* Must be with IOMMU lock held */
 static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
                              uint16_t domain_id, hwaddr addr, uint64_t slpte,
                              uint8_t access_flags, uint32_t level)
@@ -246,7 +266,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
     trace_vtd_iotlb_page_update(source_id, addr, slpte, domain_id);
     if (g_hash_table_size(s->iotlb) >= VTD_IOTLB_MAX_SIZE) {
         trace_vtd_iotlb_reset("iotlb exceeds size limit");
-        vtd_reset_iotlb(s);
+        vtd_reset_iotlb_locked(s);
     }
 
     entry->gfn = gfn;
@@ -1106,7 +1126,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     IntelIOMMUState *s = vtd_as->iommu_state;
     VTDContextEntry ce;
     uint8_t bus_num = pci_bus_num(bus);
-    VTDContextCacheEntry *cc_entry = &vtd_as->context_cache_entry;
+    VTDContextCacheEntry *cc_entry;
     uint64_t slpte, page_mask;
     uint32_t level;
     uint16_t source_id = vtd_make_source_id(bus_num, devfn);
@@ -1123,6 +1143,10 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
      */
     assert(!vtd_is_interrupt_addr(addr));
 
+    vtd_iommu_lock(s);
+
+    cc_entry = &vtd_as->context_cache_entry;
+
     /* Try to fetch slpte form IOTLB */
     iotlb_entry = vtd_lookup_iotlb(s, source_id, addr);
     if (iotlb_entry) {
@@ -1182,7 +1206,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
          * IOMMU region can be swapped back.
          */
         vtd_pt_enable_fast_path(s, source_id);
-
+        vtd_iommu_unlock(s);
         return true;
     }
 
@@ -1203,6 +1227,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     vtd_update_iotlb(s, source_id, VTD_CONTEXT_ENTRY_DID(ce.hi), addr, slpte,
                      access_flags, level);
 out:
+    vtd_iommu_unlock(s);
     entry->iova = addr & page_mask;
     entry->translated_addr = vtd_get_slpte_addr(slpte, s->aw_bits) & page_mask;
     entry->addr_mask = ~page_mask;
@@ -1210,6 +1235,7 @@ out:
     return true;
 
 error:
+    vtd_iommu_unlock(s);
     entry->iova = 0;
     entry->translated_addr = 0;
     entry->addr_mask = 0;
@@ -1258,10 +1284,13 @@ static void vtd_iommu_replay_all(IntelIOMMUState *s)
 static void vtd_context_global_invalidate(IntelIOMMUState *s)
 {
     trace_vtd_inv_desc_cc_global();
+    /* Protects context cache */
+    vtd_iommu_lock(s);
     s->context_cache_gen++;
     if (s->context_cache_gen == VTD_CONTEXT_CACHE_GEN_MAX) {
-        vtd_reset_context_cache(s);
+        vtd_reset_context_cache_locked(s);
     }
+    vtd_iommu_unlock(s);
     vtd_switch_address_space_all(s);
     /*
      * From VT-d spec 6.5.2.1, a global context entry invalidation
@@ -1313,7 +1342,9 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
             if (vtd_as && ((devfn_it & mask) == (devfn & mask))) {
                 trace_vtd_inv_desc_cc_device(bus_n, VTD_PCI_SLOT(devfn_it),
                                              VTD_PCI_FUNC(devfn_it));
+                vtd_iommu_lock(s);
                 vtd_as->context_cache_entry.context_cache_gen = 0;
+                vtd_iommu_unlock(s);
                 /*
                  * Do switch address space when needed, in case if the
                  * device passthrough bit is switched.
@@ -1377,8 +1408,10 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
 
     trace_vtd_inv_desc_iotlb_domain(domain_id);
 
+    vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_domain,
                                 &domain_id);
+    vtd_iommu_unlock(s);
 
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
         if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
@@ -1426,7 +1459,9 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     info.domain_id = domain_id;
     info.addr = addr;
     info.mask = ~((1 << am) - 1);
+    vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &info);
+    vtd_iommu_unlock(s);
     vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am);
 }
 
@@ -2929,8 +2964,10 @@ static void vtd_init(IntelIOMMUState *s)
         s->cap |= VTD_CAP_CM;
     }
 
-    vtd_reset_context_cache(s);
-    vtd_reset_iotlb(s);
+    vtd_iommu_lock(s);
+    vtd_reset_context_cache_locked(s);
+    vtd_reset_iotlb_locked(s);
+    vtd_iommu_unlock(s);
 
     /* Define registers with default values and bit semantics */
     vtd_define_long(s, DMAR_VER_REG, 0x10UL, 0, 0);
@@ -3070,6 +3107,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     }
 
     QLIST_INIT(&s->vtd_as_with_notifiers);
+    qemu_mutex_init(&s->iommu_lock);
     memset(s->vtd_as_by_bus_num, 0, sizeof(s->vtd_as_by_bus_num));
     memory_region_init_io(&s->csrmem, OBJECT(s), &vtd_mem_ops, s,
                           "intel_iommu", DMAR_REG_SIZE);
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 032e33bcb2..016e74bedb 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -300,6 +300,12 @@ struct IntelIOMMUState {
     OnOffAuto intr_eim;             /* Toggle for EIM cabability */
     bool buggy_eim;                 /* Force buggy EIM unless eim=off */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
+
+    /*
+     * Protects IOMMU states in general.  Currently it protects the
+     * per-IOMMU IOTLB cache, and context entry cache in VTDAddressSpace.
+     */
+    QemuMutex iommu_lock;
 };
 
 /* Find the VTD Address space associated with the given bus pointer,
-- 
2.17.1
