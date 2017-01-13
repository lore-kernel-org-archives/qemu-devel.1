Received: from eggs.gnu.org ([2001:4830:134:3::10]:51920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRsE8-00038X-4J
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cRsE6-00083s-HL
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:08:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cRsE6-00082E-8i
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 22:08:26 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri, 13 Jan 2017 11:06:40 +0800
Message-Id: <1484276800-26814-15-git-send-email-peterx@redhat.com>
In-Reply-To: <1484276800-26814-1-git-send-email-peterx@redhat.com>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v3 14/14] intel_iommu: enable vfio devices
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c         | 68 +++++++++++++++++++++++++++++++++++++------
 include/hw/i386/intel_iommu.h |  8 +++++
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2596f11..104200b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -839,7 +839,8 @@ next:
  * @private: private data for the hook function
  */
 static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t end,
-                         vtd_page_walk_hook hook_fn, void *private)
+                         vtd_page_walk_hook hook_fn, void *private,
+                         bool notify_unmap)
 {
     dma_addr_t addr = vtd_get_slpt_base_from_context(ce);
     uint32_t level = vtd_get_level_from_context_entry(ce);
@@ -858,7 +859,7 @@ static int vtd_page_walk(VTDContextEntry *ce, uint64_t start, uint64_t end,
     trace_vtd_page_walk(ce->hi, ce->lo, start, end);
 
     return vtd_page_walk_level(addr, start, end, hook_fn, private,
-                               level, true, true, NULL, false);
+                               level, true, true, NULL, notify_unmap);
 }
 
 /* Map a device to its corresponding domain (context-entry) */
@@ -1212,6 +1213,34 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
                                 &domain_id);
 }
 
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
+}
+
+
 static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
                                       hwaddr addr, uint8_t am)
 {
@@ -1222,6 +1251,7 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     info.addr = addr;
     info.mask = ~((1 << am) - 1);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &info);
+    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am);
 }
 
 /* Flush IOTLB
@@ -2244,15 +2274,34 @@ static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
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
+    if (!s->cache_mode_enabled && new & IOMMU_NOTIFIER_MAP) {
+        error_report("We need to set cache_mode=1 for intel-iommu to enable "
+                     "device assignment with IOMMU protection.");
         exit(1);
     }
+
+    /* Add new ndoe if no mapping was exising before this call */
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
@@ -2689,7 +2738,7 @@ static void vtd_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
          */
         trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
                                   PCI_FUNC(vtd_as->devfn), ce.hi, ce.lo);
-        vtd_page_walk(&ce, 0, ~0, vtd_replay_hook, (void *)n);
+        vtd_page_walk(&ce, 0, ~0, vtd_replay_hook, (void *)n, false);
     } else {
         trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
                                     PCI_FUNC(vtd_as->devfn));
@@ -2871,6 +2920,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    QLIST_INIT(&s->notifiers_list);
     memset(s->vtd_as_by_bus_num, 0, sizeof(s->vtd_as_by_bus_num));
     memory_region_init_io(&s->csrmem, OBJECT(s), &vtd_mem_ops, s,
                           "intel_iommu", DMAR_REG_SIZE);
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 9c3f6c0..832cfc9 100644
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
