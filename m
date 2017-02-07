Received: from eggs.gnu.org ([2001:4830:134:3::10]:37059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cb1A4-0002PQ-I0
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cb1A2-0004mx-HE
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:30:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cb1A2-0004mZ-96
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:30:02 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  7 Feb 2017 16:28:19 +0800
Message-Id: <1486456099-7345-18-git-send-email-peterx@redhat.com>
In-Reply-To: <1486456099-7345-1-git-send-email-peterx@redhat.com>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 17/17] intel_iommu: enable vfio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com

This patch is based on Aviv Ben-David (<bd.aviv@gmail.com>)'s patch
upstream:

  "IOMMU: enable intel_iommu map and unmap notifiers"
  https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg01453.html

However I removed/fixed some content, and added my own codes.

Instead of translate() every page for iotlb invalidations (which is
slower), we walk the pages when needed and notify in a hook function.

This patch enables vfio devices for VT-d emulation.

And, since we already have vhost DMAR support via device-iotlb, a
natural benefit that this patch brings is that vt-d enabled vhost can
live even without ATS capability now. Though more tests are needed.

Reviewed-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c          | 191 ++++++++++++++++++++++++++++++++++++++---
 hw/i386/intel_iommu_internal.h |   1 +
 hw/i386/trace-events           |   1 +
 include/hw/i386/intel_iommu.h  |   8 ++
 4 files changed, 188 insertions(+), 13 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4fe161f..9b1ba1b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -806,7 +806,8 @@ next:
  * @private: private data for the hook function
  */
 static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t end,
-                         vtd_page_walk_hook hook_fn, void *private)
+                         vtd_page_walk_hook hook_fn, void *private,
+                         bool notify_unmap)
 {
     dma_addr_t addr = vtd_get_slpt_base_from_context(ce);
     uint32_t level = vtd_get_level_from_context_entry(ce);
@@ -821,7 +822,7 @@ static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t end,
     }
 
     return vtd_page_walk_level(addr, start, end, hook_fn, private,
-                               level, true, true, false);
+                               level, true, true, notify_unmap);
 }
 
 /* Map a device to its corresponding domain (context-entry) */
@@ -1038,6 +1039,15 @@ static void vtd_interrupt_remap_table_setup(IntelIOMMUState *s)
                 s->intr_root, s->intr_size);
 }
 
+static void vtd_iommu_replay_all(IntelIOMMUState *s)
+{
+    IntelIOMMUNotifierNode *node;
+
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        memory_region_iommu_replay_all(&node->vtd_as->iommu);
+    }
+}
+
 static void vtd_context_global_invalidate(IntelIOMMUState *s)
 {
     trace_vtd_inv_desc_cc_global();
@@ -1045,6 +1055,14 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
     if (s->context_cache_gen == VTD_CONTEXT_CACHE_GEN_MAX) {
         vtd_reset_context_cache(s);
     }
+    /*
+     * From VT-d spec 6.5.2.1, a global context entry invalidation
+     * should be followed by a IOTLB global invalidation, so we should
+     * be safe even without this. Hoewever, let's replay the region as
+     * well to be safer, and go back here when we need finer tunes for
+     * VT-d emulation codes.
+     */
+    vtd_iommu_replay_all(s);
 }
 
 
@@ -1111,6 +1129,16 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
                 trace_vtd_inv_desc_cc_device(bus_n, VTD_PCI_SLOT(devfn_it),
                                              VTD_PCI_FUNC(devfn_it));
                 vtd_as->context_cache_entry.context_cache_gen = 0;
+                /*
+                 * So a device is moving out of (or moving into) a
+                 * domain, a replay() suites here to notify all the
+                 * IOMMU_NOTIFIER_MAP registers about this change.
+                 * This won't bring bad even if we have no such
+                 * notifier registered - the IOMMU notification
+                 * framework will skip MAP notifications if that
+                 * happened.
+                 */
+                memory_region_iommu_replay_all(&vtd_as->iommu);
             }
         }
     }
@@ -1152,12 +1180,53 @@ static void vtd_iotlb_global_invalidate(IntelIOMMUState *s)
 {
     trace_vtd_iotlb_reset("global invalidation recved");
     vtd_reset_iotlb(s);
+    vtd_iommu_replay_all(s);
 }
 
 static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
 {
+    IntelIOMMUNotifierNode *node;
+    VTDContextEntry ce;
+    VTDAddressSpace *vtd_as;
+
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_domain,
                                 &domain_id);
+
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        vtd_as = node->vtd_as;
+        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                      vtd_as->devfn, &ce) &&
+            domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
+            memory_region_iommu_replay_all(&vtd_as->iommu);
+        }
+    }
+}
+
+static int vtd_page_invalidate_notify_hook(IOMMUTLBEntry *entry,
+                                           void *private)
+{
+    memory_region_notify_iommu((MemoryRegion *)private, *entry);
+    return 0;
+}
+
+static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
+                                           uint16_t domain_id, hwaddr addr,
+                                           uint8_t am)
+{
+    IntelIOMMUNotifierNode *node;
+    VTDContextEntry ce;
+    int ret;
+
+    QLIST_FOREACH(node, &(s->notifiers_list), next) {
+        VTDAddressSpace *vtd_as = node->vtd_as;
+        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                       vtd_as->devfn, &ce);
+        if (!ret && domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
+            vtd_page_walk(&ce, addr, addr + (1 << am) * VTD_PAGE_SIZE,
+                          vtd_page_invalidate_notify_hook,
+                          (void *)&vtd_as->iommu, true);
+        }
+    }
 }
 
 static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
@@ -1170,6 +1239,7 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     info.addr = addr;
     info.mask = ~((1 << am) - 1);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &info);
+    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am);
 }
 
 /* Flush IOTLB
@@ -2187,15 +2257,33 @@ static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
                                           IOMMUNotifierFlag new)
 {
     VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    IntelIOMMUNotifierNode *node = NULL;
+    IntelIOMMUNotifierNode *next_node = NULL;
 
-    if (new & IOMMU_NOTIFIER_MAP) {
-        error_report("Device at bus %s addr %02x.%d requires iommu "
-                     "notifier which is currently not supported by "
-                     "intel-iommu emulation",
-                     vtd_as->bus->qbus.name, PCI_SLOT(vtd_as->devfn),
-                     PCI_FUNC(vtd_as->devfn));
+    if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
+        error_report("We need to set cache_mode=1 for intel-iommu to enable "
+                     "device assignment with IOMMU protection.");
         exit(1);
     }
+
+    if (old == IOMMU_NOTIFIER_NONE) {
+        node = g_malloc0(sizeof(*node));
+        node->vtd_as = vtd_as;
+        QLIST_INSERT_HEAD(&s->notifiers_list, node, next);
+        return;
+    }
+
+    /* update notifier node with new flags */
+    QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
+        if (node->vtd_as == vtd_as) {
+            if (new == IOMMU_NOTIFIER_NONE) {
+                QLIST_REMOVE(node, next);
+                g_free(node);
+            }
+            return;
+        }
+    }
 }
 
 static const VMStateDescription vtd_vmstate = {
@@ -2612,6 +2700,74 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
     return vtd_dev_as;
 }
 
+/* Unmap the whole range in the notifier's scope. */
+static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
+{
+    IOMMUTLBEntry entry;
+    hwaddr size;
+    hwaddr start = n->start;
+    hwaddr end = n->end;
+
+    /*
+     * Note: all the codes in this function has a assumption that IOVA
+     * bits are no more than VTD_MGAW bits (which is restricted by
+     * VT-d spec), otherwise we need to consider overflow of 64 bits.
+     */
+
+    if (end > VTD_ADDRESS_SIZE) {
+        /*
+         * Don't need to unmap regions that is bigger than the whole
+         * VT-d supported address space size
+         */
+        end = VTD_ADDRESS_SIZE;
+    }
+
+    assert(start <= end);
+    size = end - start;
+
+    if (ctpop64(size) != 1) {
+        /*
+         * This size cannot format a correct mask. Let's enlarge it to
+         * suite the minimum available mask.
+         */
+        int n = 64 - clz64(size);
+        if (n > VTD_MGAW) {
+            /* should not happen, but in case it happens, limit it */
+            n = VTD_MGAW;
+        }
+        size = 1ULL << n;
+    }
+
+    entry.target_as = &address_space_memory;
+    /* Adjust iova for the size */
+    entry.iova = n->start & ~(size - 1);
+    /* This field is meaningless for unmap */
+    entry.translated_addr = 0;
+    entry.perm = IOMMU_NONE;
+    entry.addr_mask = size - 1;
+
+    trace_vtd_as_unmap_whole(pci_bus_num(as->bus),
+                             VTD_PCI_SLOT(as->devfn),
+                             VTD_PCI_FUNC(as->devfn),
+                             entry.iova, size);
+
+    memory_region_notify_one(n, &entry);
+}
+
+static void vtd_address_space_unmap_all(IntelIOMMUState *s)
+{
+    IntelIOMMUNotifierNode *node;
+    VTDAddressSpace *vtd_as;
+    IOMMUNotifier *n;
+
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        vtd_as = node->vtd_as;
+        IOMMU_NOTIFIER_FOREACH(n, &vtd_as->iommu) {
+            vtd_address_space_unmap(vtd_as, n);
+        }
+    }
+}
+
 static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
 {
     memory_region_notify_one((IOMMUNotifier *)private, entry);
@@ -2625,16 +2781,19 @@ static void vtd_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
     uint8_t bus_n = pci_bus_num(vtd_as->bus);
     VTDContextEntry ce;
 
+    /*
+     * The replay can be triggered by either a invalidation or a newly
+     * created entry. No matter what, we release existing mappings
+     * (it means flushing caches for UNMAP-only registers).
+     */
+    vtd_address_space_unmap(vtd_as, n);
+
     if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
-        /*
-         * Scanned a valid context entry, walk over the pages and
-         * notify when needed.
-         */
         trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
                                   PCI_FUNC(vtd_as->devfn),
                                   VTD_CONTEXT_ENTRY_DID(ce.hi),
                                   ce.hi, ce.lo);
-        vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n);
+        vtd_page_walk(&ce, 0, ~0ULL, vtd_replay_hook, (void *)n, false);
     } else {
         trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
                                     PCI_FUNC(vtd_as->devfn));
@@ -2753,6 +2912,11 @@ static void vtd_reset(DeviceState *dev)
 
     VTD_DPRINTF(GENERAL, "");
     vtd_init(s);
+
+    /*
+     * When device reset, throw away all mappings and external caches
+     */
+    vtd_address_space_unmap_all(s);
 }
 
 static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
@@ -2816,6 +2980,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    QLIST_INIT(&s->notifiers_list);
     memset(s->vtd_as_by_bus_num, 0, sizeof(s->vtd_as_by_bus_num));
     memory_region_init_io(&s->csrmem, OBJECT(s), &vtd_mem_ops, s,
                           "intel_iommu", DMAR_REG_SIZE);
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 4104121..29d6707 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -197,6 +197,7 @@
 #define VTD_DOMAIN_ID_MASK          ((1UL << VTD_DOMAIN_ID_SHIFT) - 1)
 #define VTD_CAP_ND                  (((VTD_DOMAIN_ID_SHIFT - 4) / 2) & 7ULL)
 #define VTD_MGAW                    39  /* Maximum Guest Address Width */
+#define VTD_ADDRESS_SIZE            (1ULL << VTD_MGAW)
 #define VTD_CAP_MGAW                (((VTD_MGAW - 1) & 0x3fULL) << 16)
 #define VTD_MAMV                    18ULL
 #define VTD_CAP_MAMV                (VTD_MAMV << 48)
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index ebb650b..77d4373 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -37,6 +37,7 @@ vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"P
 vtd_page_walk_skip_perm(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to perm empty"
 vtd_page_walk_skip_reserve(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"PRIx64" - 0x%"PRIx64" due to rsrv set"
 vtd_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
+vtd_as_unmap_whole(uint8_t bus, uint8_t slot, uint8_t fn, uint64_t iova, uint64_t size) "Device %02x:%02x.%x start 0x%"PRIx64" size 0x%"PRIx64
 
 # hw/i386/amd_iommu.c
 amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 8f212a1..3e51876 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -63,6 +63,7 @@ typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
 typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
 typedef struct VTDIrq VTDIrq;
 typedef struct VTD_MSIMessage VTD_MSIMessage;
+typedef struct IntelIOMMUNotifierNode IntelIOMMUNotifierNode;
 
 /* Context-Entry */
 struct VTDContextEntry {
@@ -249,6 +250,11 @@ struct VTD_MSIMessage {
 /* When IR is enabled, all MSI/MSI-X data bits should be zero */
 #define VTD_IR_MSI_DATA          (0)
 
+struct IntelIOMMUNotifierNode {
+    VTDAddressSpace *vtd_as;
+    QLIST_ENTRY(IntelIOMMUNotifierNode) next;
+};
+
 /* The iommu (DMAR) device state struct */
 struct IntelIOMMUState {
     X86IOMMUState x86_iommu;
@@ -286,6 +292,8 @@ struct IntelIOMMUState {
     MemoryRegionIOMMUOps iommu_ops;
     GHashTable *vtd_as_by_busptr;   /* VTDBus objects indexed by PCIBus* reference */
     VTDBus *vtd_as_by_bus_num[VTD_PCI_BUS_MAX]; /* VTDBus objects indexed by bus number */
+    /* list of registered notifiers */
+    QLIST_HEAD(, IntelIOMMUNotifierNode) notifiers_list;
 
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
-- 
2.7.4
