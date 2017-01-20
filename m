Received: from eggs.gnu.org ([2001:4830:134:3::10]:48876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUYx1-0001vp-MV
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUYx0-0002fq-E1
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:09:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cUYx0-0002fS-4x
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:09:54 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 20 Jan 2017 21:08:53 +0800
Message-Id: <1484917736-32056-18-git-send-email-peterx@redhat.com>
In-Reply-To: <1484917736-32056-1-git-send-email-peterx@redhat.com>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v4 17/20] intel_iommu: allow dynamic switch
 of IOMMU region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

This is preparation work to finally enabled dynamic switching ON/OFF for
VT-d protection. The old VT-d codes is using static IOMMU address space,
and that won't satisfy vfio-pci device listeners.

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
 hw/i386/intel_iommu.c         | 78 ++++++++++++++++++++++++++++++++++++++++---
 hw/i386/trace-events          |  2 +-
 include/hw/i386/intel_iommu.h |  2 ++
 3 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4b08b4d..83a2e1f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1336,9 +1336,49 @@ static void vtd_handle_gcmd_sirtp(IntelIOMMUState *s)
     vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_IRTPS);
 }
 
+static void vtd_switch_address_space(VTDAddressSpace *as)
+{
+    assert(as);
+
+    trace_vtd_switch_address_space(pci_bus_num(as->bus),
+                                   VTD_PCI_SLOT(as->devfn),
+                                   VTD_PCI_FUNC(as->devfn),
+                                   as->iommu_state->dmar_enabled);
+
+    /* Turn off first then on the other */
+    if (as->iommu_state->dmar_enabled) {
+        memory_region_set_enabled(&as->sys_alias, false);
+        memory_region_set_enabled(&as->iommu, true);
+    } else {
+        memory_region_set_enabled(&as->iommu, false);
+        memory_region_set_enabled(&as->sys_alias, true);
+    }
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
 /* Handle Translation Enable/Disable */
 static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
 {
+    if (s->dmar_enabled == en) {
+        return;
+    }
+
     VTD_DPRINTF(CSR, "Translation Enable %s", (en ? "on" : "off"));
 
     if (en) {
@@ -1353,6 +1393,8 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
         /* Ok - report back to driver */
         vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_TES, 0);
     }
+
+    vtd_switch_address_space_all(s);
 }
 
 /* Handle Interrupt Remap Enable/Disable */
@@ -2566,15 +2608,43 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
         vtd_dev_as->devfn = (uint8_t)devfn;
         vtd_dev_as->iommu_state = s;
         vtd_dev_as->context_cache_entry.context_cache_gen = 0;
+
+        /*
+         * Memory region relationships looks like (Address range shows
+         * only lower 32 bits to make it short in length...):
+         *
+         * |-----------------+-------------------+----------|
+         * | Name            | Address range     | Priority |
+         * |-----------------+-------------------+----------+
+         * | vtd_root        | 00000000-ffffffff |        0 |
+         * |  intel_iommu    | 00000000-ffffffff |        1 |
+         * |  vtd_sys_alias  | 00000000-ffffffff |        1 |
+         * |  intel_iommu_ir | fee00000-feefffff |       64 |
+         * |-----------------+-------------------+----------|
+         *
+         * We enable/disable DMAR by switching enablement for
+         * vtd_sys_alias and intel_iommu regions. IR region is always
+         * enabled.
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
-                           &vtd_dev_as->iommu, name);
+        memory_region_init(&vtd_dev_as->root, OBJECT(s),
+                           "vtd_root", UINT64_MAX);
+        memory_region_add_subregion_overlap(&vtd_dev_as->root,
+                                            VTD_INTERRUPT_ADDR_FIRST,
+                                            &vtd_dev_as->iommu_ir, 64);
+        address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, name);
+        memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
+                                            &vtd_dev_as->sys_alias, 1);
+        memory_region_add_subregion_overlap(&vtd_dev_as->root, 0,
+                                            &vtd_dev_as->iommu, 1);
+        vtd_switch_address_space(vtd_dev_as);
     }
     return vtd_dev_as;
 }
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index a3e1a9d..bd57b0a 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -11,7 +11,6 @@ xen_pv_mmio_write(uint64_t addr) "WARNING: write to Xen PV Device MMIO space (ad
 x86_iommu_iec_notify(bool global, uint32_t index, uint32_t mask) "Notify IEC invalidation: global=%d index=%" PRIu32 " mask=%" PRIu32
 
 # hw/i386/intel_iommu.c
-vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
 vtd_inv_desc(const char *type, uint64_t hi, uint64_t lo) "invalidate desc type %s high 0x%"PRIx64" low 0x%"PRIx64
 vtd_inv_desc_cc_domain(uint16_t domain) "context invalidate domain 0x%"PRIx16
 vtd_inv_desc_cc_global(void) "context invalidate globally"
@@ -38,6 +37,7 @@ vtd_page_walk_one(uint32_t level, uint64_t iova, uint64_t gpa, uint64_t mask, in
 vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to unable to read"
 vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to perm empty"
 vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
+vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
 
 # hw/i386/amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index fe645aa..8f212a1 100644
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
