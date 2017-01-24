Received: from eggs.gnu.org ([2001:4830:134:3::10]:53596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVyKY-0006GV-QD
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVyKW-0006r3-2Y
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:28:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVyKV-0006qo-Po
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:27:59 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue, 24 Jan 2017 18:26:11 +0800
Message-Id: <1485253571-19058-19-git-send-email-peterx@redhat.com>
In-Reply-To: <1485253571-19058-1-git-send-email-peterx@redhat.com>
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 18/18] intel_iommu: enable vfio devices
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c          | 151 ++++++++++++++++++++++++++++++++++++++---
 hw/i386/intel_iommu_internal.h |   1 +
 hw/i386/trace-events           |   1 +
 include/hw/i386/intel_iommu.h  |   8 +++
 4 files changed, 150 insertions(+), 11 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0c43745..60dbe56 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -805,7 +805,8 @@ next:
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
@@ -1164,14 +1165,60 @@ static uint64_t vtd_context_cache_invalidate(IntelIOMMUState *s, uint64_t val)
 
 static void vtd_iotlb_global_invalidate(IntelIOMMUState *s)
 {
+    IntelIOMMUNotifierNode *node;
+
     trace_vtd_iotlb_reset("global invalidation recved");
     vtd_reset_iotlb(s);
+
+    QLIST_FOREACH(node, &s->notifiers_list, next) {
+        memory_region_iommu_replay_all(&node->vtd_as->iommu);
+    }
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
@@ -1184,6 +1231,7 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     info.addr = addr;
     info.mask = ~((1 << am) - 1);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &info);
+    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am);
 }
 
 /* Flush IOTLB
@@ -2193,15 +2241,33 @@ static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
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
@@ -2618,6 +2684,65 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
     return vtd_dev_as;
 }
 
+/*
+ * Unmap the whole range in the notifier's scope. If we have recorded
+ * any high watermark (VTDAddressSpace.iova_max), we use it to limit
+ * the n->end as well.
+ */
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
+            trace_vtd_err("Address space unmap found size too big");
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
 static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
 {
     memory_region_notify_one((IOMMUNotifier *)private, entry);
@@ -2633,14 +2758,17 @@ static void vtd_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
 
     if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
         /*
-         * Scanned a valid context entry, walk over the pages and
-         * notify when needed.
+         * Scanned a valid context entry, we first make sure to remove
+         * all existing mappings in old domain, by sending UNMAP to
+         * all the notifiers. Then, we walk over the pages and notify
+         * with existing mapped new entries in the new domain.
          */
         trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
                                   PCI_FUNC(vtd_as->devfn),
                                   VTD_CONTEXT_ENTRY_DID(ce.hi),
                                   ce.hi, ce.lo);
-        vtd_page_walk(&ce, 0, ~0, vtd_replay_hook, (void *)n);
+        vtd_address_space_unmap(vtd_as, n);
+        vtd_page_walk(&ce, 0, ~0, vtd_replay_hook, (void *)n, false);
     } else {
         trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
                                     PCI_FUNC(vtd_as->devfn));
@@ -2822,6 +2950,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
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
index bd57b0a..ef725ca 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -38,6 +38,7 @@ vtd_page_walk_skip_read(uint64_t iova, uint64_t next) "Page walk skip iova 0x%"P
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
