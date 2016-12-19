Received: from eggs.gnu.org ([2001:4830:134:3::10]:55950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIz8O-00070r-W1
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cIz8K-0001cN-4N
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:41:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cIz8J-0001cF-Rr
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 09:41:44 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon, 19 Dec 2016 22:41:26 +0800
Message-Id: <1482158486-18597-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH] intel_iommu: allow dynamic switch of IOMMU
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com, david@gibson.dropbear.id.au

This is preparation work to finally enabled dynamic switching ON/OFF for
VT-d protection. The old VT-d codes is using static IOMMU region, and
that won't satisfy vfio-pci device listeners.

Let me explain.

vfio-pci devices depend on the memory region listener and IOMMU replay
mechanism to make sure the device mapping is coherent with the guest
even if there are domain switches. And there are two kinds of domain
switches:

  (1) switch from domain A -> B
  (2) switch from domain A -> no domain (e.g., turn DMAR off)

Case (1) is handled by the context entry invalidation handling by the
VT-d replay logic. What the replay function should do here is to replay
the existing page mappings in domain B.

However for case (2), we don't want to replay any domain mappings - we
just need the default GPA->HPA mappings (the address_space_memory
mapping). And this patch helps on case (2) to build up the mapping
automatically by leveraging the vfio-pci memory listeners.

Another important thing that this patch does is to seperate
IR (Interrupt Remapping) from DMAR (DMA Remapping). IR region should not
depend on the DMAR region (like before this patch). It should be a
standalone region, and it should be able to be activated without
DMAR (which is a common behavior of Linux kernel - by default it enables
IR while disabled DMAR).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c         | 75 ++++++++++++++++++++++++++++++++++++++++---
 hw/i386/trace-events          |  3 ++
 include/hw/i386/intel_iommu.h |  2 ++
 3 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5f3e351..75a3f4e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1179,9 +1179,42 @@ static void vtd_handle_gcmd_sirtp(IntelIOMMUState *s)
     vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_IRTPS);
 }
 
+static void vtd_switch_address_space(IntelIOMMUState *s, bool enabled)
+{
+    GHashTableIter iter;
+    VTDBus *vtd_bus;
+    VTDAddressSpace *as;
+    int i;
+
+    g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
+    while (g_hash_table_iter_next (&iter, NULL, (void**)&vtd_bus)) {
+        for (i = 0; i < X86_IOMMU_PCI_DEVFN_MAX; i++) {
+            as = vtd_bus->dev_as[i];
+            if (as == NULL) {
+                continue;
+            }
+            trace_vtd_switch_address_space(pci_bus_num(vtd_bus->bus),
+                                           VTD_PCI_SLOT(i), VTD_PCI_FUNC(i),
+                                           enabled);
+            if (enabled) {
+                memory_region_add_subregion_overlap(&as->root, 0,
+                                                    &as->iommu, 2);
+            } else {
+                memory_region_del_subregion(&as->root, &as->iommu);
+            }
+        }
+    }
+}
+
 /* Handle Translation Enable/Disable */
 static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
 {
+    bool old = s->dmar_enabled;
+
+    if (old == en) {
+        return;
+    }
+
     VTD_DPRINTF(CSR, "Translation Enable %s", (en ? "on" : "off"));
 
     if (en) {
@@ -1196,6 +1229,8 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
         /* Ok - report back to driver */
         vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_TES, 0);
     }
+
+    vtd_switch_address_space(s, en);
 }
 
 /* Handle Interrupt Remap Enable/Disable */
@@ -2343,15 +2378,47 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
         vtd_dev_as->devfn = (uint8_t)devfn;
         vtd_dev_as->iommu_state = s;
         vtd_dev_as->context_cache_entry.context_cache_gen = 0;
+
+        /*
+         * When DMAR is disabled, memory region relationships looks
+         * like:
+         *
+         * 0000000000000000-ffffffffffffffff (prio 0, RW): vtd_root
+         *  0000000000000000-ffffffffffffffff (prio 1, RW): vtd_sys_alias
+         *  00000000fee00000-00000000feefffff (prio 64, RW): intel_iommu_ir
+         *
+         * When DMAR is disabled, it becomes:
+         *
+         * 0000000000000000-ffffffffffffffff (prio 0, RW): vtd_root
+         *  0000000000000000-ffffffffffffffff (prio 2, RW): intel_iommu
+         *  0000000000000000-ffffffffffffffff (prio 1, RW): vtd_sys_alias
+         *  00000000fee00000-00000000feefffff (prio 64, RW): intel_iommu_ir
+         *
+         * The intel_iommu region is dynamically added/removed.
+         */
         memory_region_init_iommu(&vtd_dev_as->iommu, OBJECT(s),
                                  &s->iommu_ops, "intel_iommu", UINT64_MAX);
+        memory_region_init_alias(&vtd_dev_as->sys_alias, OBJECT(s),
+                                 "vtd_sys_alias", get_system_memory(),
+                                 0, memory_region_size(get_system_memory()));
         memory_region_init_io(&vtd_dev_as->iommu_ir, OBJECT(s),
                               &vtd_mem_ir_ops, s, "intel_iommu_ir",
                               VTD_INTERRUPT_ADDR_SIZE);
-        memory_region_add_subregion(&vtd_dev_as->iommu, VTD_INTERRUPT_ADDR_FIRST,
-                                    &vtd_dev_as->iommu_ir);
-        address_space_init(&vtd_dev_as->as,
-                           &vtd_dev_as->iommu, "intel_iommu");
+        memory_region_init(&vtd_dev_as->root, OBJECT(s),
+                           "vtd_root", UINT64_MAX);
+        memory_region_add_subregion_overlap(&vtd_dev_as->root,
+                                            VTD_INTERRUPT_ADDR_FIRST,
+                                            &vtd_dev_as->iommu_ir, 64);
+        address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, name);
+        memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
+                                            &vtd_dev_as->sys_alias, 1);
+        if (s->dmar_enabled) {
+            memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
+                                                &vtd_dev_as->iommu, 2);
+        }
+        trace_vtd_switch_address_space(pci_bus_num(vtd_bus->bus),
+                                       VTD_PCI_SLOT(devfn), VTD_PCI_FUNC(devfn),
+                                       s->dmar_enabled);
     }
     return vtd_dev_as;
 }
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index d2b4973..aee93bb 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -10,6 +10,9 @@ xen_pv_mmio_write(uint64_t addr) "WARNING: write to Xen PV Device MMIO space (ad
 # hw/i386/x86-iommu.c
 x86_iommu_iec_notify(bool global, uint32_t index, uint32_t mask) "Notify IEC invalidation: global=%d index=%" PRIu32 " mask=%" PRIu32
 
+# hw/i386/intel_iommu.c
+vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
+
 # hw/i386/amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
 amdvi_cache_update(uint16_t domid, uint8_t bus, uint8_t slot, uint8_t func, uint64_t gpa, uint64_t txaddr) " update iotlb domid 0x%"PRIx16" devid: %02x:%02x.%x gpa 0x%"PRIx64" hpa 0x%"PRIx64
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 405c9d1..85c1b9b 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -83,6 +83,8 @@ struct VTDAddressSpace {
     uint8_t devfn;
     AddressSpace as;
     MemoryRegion iommu;
+    MemoryRegion root;
+    MemoryRegion sys_alias;
     MemoryRegion iommu_ir;      /* Interrupt region: 0xfeeXXXXX */
     IntelIOMMUState *iommu_state;
     VTDContextCacheEntry context_cache_entry;
-- 
2.7.4
