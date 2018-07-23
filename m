Received: from eggs.gnu.org ([2001:4830:134:3::10]:41082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIh-0001or-DC
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIg-00037H-0N
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:23 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:35 -0500
Message-Id: <20180723201748.25573-27-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 26/99] intel-iommu: remove
 IntelIOMMUNotifierNode
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

That is not really necessary.  Removing that node struct and put the
list entry directly into VTDAddressSpace.  It simplfies the code a lot.
Since at it, rename the old notifiers_list into vtd_as_with_notifiers.

CC: QEMU Stable <qemu-stable@nongnu.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit b4a4ba0d68f50f218ee3957b6638dbee32a5eeef)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/intel_iommu.c         | 41 ++++++++++-------------------------
 include/hw/i386/intel_iommu.h |  9 ++------
 2 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b359efd6f9..3df90457f8 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1248,10 +1248,10 @@ static void vtd_interrupt_remap_table_setup(IntelIOMMUState *s)
 
 static void vtd_iommu_replay_all(IntelIOMMUState *s)
 {
-    IntelIOMMUNotifierNode *node;
+    VTDAddressSpace *vtd_as;
 
-    QLIST_FOREACH(node, &s->notifiers_list, next) {
-        memory_region_iommu_replay_all(&node->vtd_as->iommu);
+    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
+        memory_region_iommu_replay_all(&vtd_as->iommu);
     }
 }
 
@@ -1372,7 +1372,6 @@ static void vtd_iotlb_global_invalidate(IntelIOMMUState *s)
 
 static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
 {
-    IntelIOMMUNotifierNode *node;
     VTDContextEntry ce;
     VTDAddressSpace *vtd_as;
 
@@ -1381,8 +1380,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_domain,
                                 &domain_id);
 
-    QLIST_FOREACH(node, &s->notifiers_list, next) {
-        vtd_as = node->vtd_as;
+    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
         if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                       vtd_as->devfn, &ce) &&
             domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
@@ -1402,12 +1400,11 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                                            uint16_t domain_id, hwaddr addr,
                                            uint8_t am)
 {
-    IntelIOMMUNotifierNode *node;
+    VTDAddressSpace *vtd_as;
     VTDContextEntry ce;
     int ret;
 
-    QLIST_FOREACH(node, &(s->notifiers_list), next) {
-        VTDAddressSpace *vtd_as = node->vtd_as;
+    QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
         ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                        vtd_as->devfn, &ce);
         if (!ret && domain_id == VTD_CONTEXT_ENTRY_DID(ce.hi)) {
@@ -2344,8 +2341,6 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
 {
     VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
     IntelIOMMUState *s = vtd_as->iommu_state;
-    IntelIOMMUNotifierNode *node = NULL;
-    IntelIOMMUNotifierNode *next_node = NULL;
 
     if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
         error_report("We need to set caching-mode=1 for intel-iommu to enable "
@@ -2354,21 +2349,9 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     }
 
     if (old == IOMMU_NOTIFIER_NONE) {
-        node = g_malloc0(sizeof(*node));
-        node->vtd_as = vtd_as;
-        QLIST_INSERT_HEAD(&s->notifiers_list, node, next);
-        return;
-    }
-
-    /* update notifier node with new flags */
-    QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
-        if (node->vtd_as == vtd_as) {
-            if (new == IOMMU_NOTIFIER_NONE) {
-                QLIST_REMOVE(node, next);
-                g_free(node);
-            }
-            return;
-        }
+        QLIST_INSERT_HEAD(&s->vtd_as_with_notifiers, vtd_as, next);
+    } else if (new == IOMMU_NOTIFIER_NONE) {
+        QLIST_REMOVE(vtd_as, next);
     }
 }
 
@@ -2838,12 +2821,10 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 
 static void vtd_address_space_unmap_all(IntelIOMMUState *s)
 {
-    IntelIOMMUNotifierNode *node;
     VTDAddressSpace *vtd_as;
     IOMMUNotifier *n;
 
-    QLIST_FOREACH(node, &s->notifiers_list, next) {
-        vtd_as = node->vtd_as;
+    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
         IOMMU_NOTIFIER_FOREACH(n, &vtd_as->iommu) {
             vtd_address_space_unmap(vtd_as, n);
         }
@@ -3088,7 +3069,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    QLIST_INIT(&s->notifiers_list);
+    QLIST_INIT(&s->vtd_as_with_notifiers);
     memset(s->vtd_as_by_bus_num, 0, sizeof(s->vtd_as_by_bus_num));
     memory_region_init_io(&s->csrmem, OBJECT(s), &vtd_mem_ops, s,
                           "intel_iommu", DMAR_REG_SIZE);
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 45ec8919b6..032e33bcb2 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -67,7 +67,6 @@ typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
 typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
 typedef struct VTDIrq VTDIrq;
 typedef struct VTD_MSIMessage VTD_MSIMessage;
-typedef struct IntelIOMMUNotifierNode IntelIOMMUNotifierNode;
 
 /* Context-Entry */
 struct VTDContextEntry {
@@ -93,6 +92,7 @@ struct VTDAddressSpace {
     MemoryRegion iommu_ir;      /* Interrupt region: 0xfeeXXXXX */
     IntelIOMMUState *iommu_state;
     VTDContextCacheEntry context_cache_entry;
+    QLIST_ENTRY(VTDAddressSpace) next;
 };
 
 struct VTDBus {
@@ -253,11 +253,6 @@ struct VTD_MSIMessage {
 /* When IR is enabled, all MSI/MSI-X data bits should be zero */
 #define VTD_IR_MSI_DATA          (0)
 
-struct IntelIOMMUNotifierNode {
-    VTDAddressSpace *vtd_as;
-    QLIST_ENTRY(IntelIOMMUNotifierNode) next;
-};
-
 /* The iommu (DMAR) device state struct */
 struct IntelIOMMUState {
     X86IOMMUState x86_iommu;
@@ -295,7 +290,7 @@ struct IntelIOMMUState {
     GHashTable *vtd_as_by_busptr;   /* VTDBus objects indexed by PCIBus* reference */
     VTDBus *vtd_as_by_bus_num[VTD_PCI_BUS_MAX]; /* VTDBus objects indexed by bus number */
     /* list of registered notifiers */
-    QLIST_HEAD(, IntelIOMMUNotifierNode) notifiers_list;
+    QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
 
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
-- 
2.17.1
