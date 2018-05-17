Received: from eggs.gnu.org ([2001:4830:134:3::10]:59143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJElA-0000k7-Vc
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJEl9-0006dg-T8
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:59:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34688 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJEl9-0006d4-Kj
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:59:39 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 17 May 2018 16:59:17 +0800
Message-Id: <20180517085927.24925-3-peterx@redhat.com>
In-Reply-To: <20180517085927.24925-1-peterx@redhat.com>
References: <20180517085927.24925-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 02/12] intel-iommu: remove
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
Cc: Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

That is not really necessary.  Removing that node struct and put the
list entry directly into VTDAddressSpace.  It simplfies the code a lot.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/hw/i386/intel_iommu.h |  9 ++------
 hw/i386/intel_iommu.c         | 41 ++++++++++-------------------------
 2 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 45ec8919b6..220697253f 100644
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
+    QLIST_HEAD(, VTDAddressSpace) notifiers_list;
 
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b359efd6f9..5987b48d43 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1248,10 +1248,10 @@ static void vtd_interrupt_remap_table_setup(IntelIOMMUState *s)
 
 static void vtd_iommu_replay_all(IntelIOMMUState *s)
 {
-    IntelIOMMUNotifierNode *node;
+    VTDAddressSpace *vtd_as;
 
-    QLIST_FOREACH(node, &s->notifiers_list, next) {
-        memory_region_iommu_replay_all(&node->vtd_as->iommu);
+    QLIST_FOREACH(vtd_as, &s->notifiers_list, next) {
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
+    QLIST_FOREACH(vtd_as, &s->notifiers_list, next) {
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
+    QLIST_FOREACH(vtd_as, &(s->notifiers_list), next) {
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
@@ -2354,21 +2349,11 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
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
+        /* Insert new ones */
+        QLIST_INSERT_HEAD(&s->notifiers_list, vtd_as, next);
+    } else if (new == IOMMU_NOTIFIER_NONE) {
+        /* Remove old ones */
+        QLIST_REMOVE(vtd_as, next);
     }
 }
 
@@ -2838,12 +2823,10 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 
 static void vtd_address_space_unmap_all(IntelIOMMUState *s)
 {
-    IntelIOMMUNotifierNode *node;
     VTDAddressSpace *vtd_as;
     IOMMUNotifier *n;
 
-    QLIST_FOREACH(node, &s->notifiers_list, next) {
-        vtd_as = node->vtd_as;
+    QLIST_FOREACH(vtd_as, &s->notifiers_list, next) {
         IOMMU_NOTIFIER_FOREACH(n, &vtd_as->iommu) {
             vtd_address_space_unmap(vtd_as, n);
         }
-- 
2.17.0
