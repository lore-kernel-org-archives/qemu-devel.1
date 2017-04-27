Received: from eggs.gnu.org ([2001:4830:134:3::10]:47344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fpG-0003OY-OR
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fpB-0003w9-Pt
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6559)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3fpB-0003vo-Dt
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:34:57 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 27 Apr 2017 17:34:14 +0800
Message-Id: <1493285660-4470-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1493285660-4470-1-git-send-email-peterx@redhat.com>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 2/8] memory: rename IOMMUNotifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

Renaming it to IOMMUMRNotifier. This is a corresponding change to
previous patch, to emphasize that these notifiers are based on memory
regions.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c         | 20 ++++++++++----------
 hw/vfio/common.c              |  2 +-
 hw/virtio/vhost.c             |  2 +-
 include/exec/memory.h         | 28 ++++++++++++++--------------
 include/hw/i386/intel_iommu.h |  8 ++++----
 include/hw/vfio/vfio-common.h |  2 +-
 include/hw/virtio/vhost.h     |  4 ++--
 memory.c                      | 14 +++++++-------
 8 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dce1ee8..3306e6a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1041,7 +1041,7 @@ static void vtd_interrupt_remap_table_setup(IntelIOMMUState *s)
 
 static void vtd_iommu_replay_all(IntelIOMMUState *s)
 {
-    IntelIOMMUNotifierNode *node;
+    IntelIOMMUMRNotifierNode *node;
 
     QLIST_FOREACH(node, &s->notifiers_list, next) {
         memory_region_iommu_replay_all(&node->vtd_as->iommu);
@@ -1185,7 +1185,7 @@ static void vtd_iotlb_global_invalidate(IntelIOMMUState *s)
 
 static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
 {
-    IntelIOMMUNotifierNode *node;
+    IntelIOMMUMRNotifierNode *node;
     VTDContextEntry ce;
     VTDAddressSpace *vtd_as;
 
@@ -1213,7 +1213,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                                            uint16_t domain_id, hwaddr addr,
                                            uint8_t am)
 {
-    IntelIOMMUNotifierNode *node;
+    IntelIOMMUMRNotifierNode *node;
     VTDContextEntry ce;
     int ret;
 
@@ -2258,8 +2258,8 @@ static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
 {
     VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
     IntelIOMMUState *s = vtd_as->iommu_state;
-    IntelIOMMUNotifierNode *node = NULL;
-    IntelIOMMUNotifierNode *next_node = NULL;
+    IntelIOMMUMRNotifierNode *node = NULL;
+    IntelIOMMUMRNotifierNode *next_node = NULL;
 
     if (!s->caching_mode && new & IOMMU_MR_EVENT_MAP) {
         error_report("We need to set cache_mode=1 for intel-iommu to enable "
@@ -2702,7 +2702,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
 }
 
 /* Unmap the whole range in the notifier's scope. */
-static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
+static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUMRNotifier *n)
 {
     IOMMUTLBEntry entry;
     hwaddr size;
@@ -2757,9 +2757,9 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 
 static void vtd_address_space_unmap_all(IntelIOMMUState *s)
 {
-    IntelIOMMUNotifierNode *node;
+    IntelIOMMUMRNotifierNode *node;
     VTDAddressSpace *vtd_as;
-    IOMMUNotifier *n;
+    IOMMUMRNotifier *n;
 
     QLIST_FOREACH(node, &s->notifiers_list, next) {
         vtd_as = node->vtd_as;
@@ -2771,11 +2771,11 @@ static void vtd_address_space_unmap_all(IntelIOMMUState *s)
 
 static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
 {
-    memory_region_notify_one((IOMMUNotifier *)private, entry);
+    memory_region_notify_one((IOMMUMRNotifier *)private, entry);
     return 0;
 }
 
-static void vtd_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n)
+static void vtd_iommu_replay(MemoryRegion *mr, IOMMUMRNotifier *n)
 {
     VTDAddressSpace *vtd_as = container_of(mr, VTDAddressSpace, iommu);
     IntelIOMMUState *s = vtd_as->iommu_state;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a6ca10b..bd113b7 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -332,7 +332,7 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
     return true;
 }
 
-static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+static void vfio_iommu_map_notify(IOMMUMRNotifier *n, IOMMUTLBEntry *iotlb)
 {
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
     VFIOContainer *container = giommu->container;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 2e8d8fc..81a8aea 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -718,7 +718,7 @@ static void vhost_region_del(MemoryListener *listener,
     }
 }
 
-static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+static void vhost_iommu_unmap_notify(IOMMUMRNotifier *n, IOMMUTLBEntry *iotlb)
 {
     struct vhost_iommu *iommu = container_of(n, struct vhost_iommu, n);
     struct vhost_dev *hdev = iommu->hdev;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 90730b1..6be0c02 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -66,7 +66,7 @@ struct IOMMUTLBEntry {
 };
 
 /*
- * Bitmap for different IOMMUNotifier capabilities. Each notifier can
+ * Bitmap for different IOMMUMRNotifier capabilities. Each notifier can
  * register with one or multiple IOMMU Notifier capability bit(s).
  */
 typedef enum {
@@ -79,21 +79,21 @@ typedef enum {
 
 #define IOMMU_MR_EVENT_ALL (IOMMU_MR_EVENT_MAP | IOMMU_MR_EVENT_UNMAP)
 
-struct IOMMUNotifier;
-typedef void (*IOMMUNotify)(struct IOMMUNotifier *notifier,
+struct IOMMUMRNotifier;
+typedef void (*IOMMUNotify)(struct IOMMUMRNotifier *notifier,
                             IOMMUTLBEntry *data);
 
-struct IOMMUNotifier {
+struct IOMMUMRNotifier {
     IOMMUNotify notify;
     IOMMUMREventFlags notifier_flags;
     /* Notify for address space range start <= addr <= end */
     hwaddr start;
     hwaddr end;
-    QLIST_ENTRY(IOMMUNotifier) node;
+    QLIST_ENTRY(IOMMUMRNotifier) node;
 };
-typedef struct IOMMUNotifier IOMMUNotifier;
+typedef struct IOMMUMRNotifier IOMMUMRNotifier;
 
-static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
+static inline void iommu_notifier_init(IOMMUMRNotifier *n, IOMMUNotify fn,
                                        IOMMUMREventFlags flags,
                                        hwaddr start, hwaddr end)
 {
@@ -194,7 +194,7 @@ struct MemoryRegionIOMMUOps {
                                 IOMMUMREventFlags old_flags,
                                 IOMMUMREventFlags new_flags);
     /* Set this up to provide customized IOMMU replay function */
-    void (*replay)(MemoryRegion *iommu, IOMMUNotifier *notifier);
+    void (*replay)(MemoryRegion *iommu, IOMMUMRNotifier *notifier);
 };
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
@@ -239,7 +239,7 @@ struct MemoryRegion {
     const char *name;
     unsigned ioeventfd_nb;
     MemoryRegionIoeventfd *ioeventfds;
-    QLIST_HEAD(, IOMMUNotifier) iommu_notify;
+    QLIST_HEAD(, IOMMUMRNotifier) iommu_notify;
     IOMMUMREventFlags iommu_notify_flags;
 };
 
@@ -703,7 +703,7 @@ void memory_region_notify_iommu(MemoryRegion *mr,
  *         replaces all old entries for the same virtual I/O address range.
  *         Deleted entries have .@perm == 0.
  */
-void memory_region_notify_one(IOMMUNotifier *notifier,
+void memory_region_notify_one(IOMMUMRNotifier *notifier,
                               IOMMUTLBEntry *entry);
 
 /**
@@ -711,12 +711,12 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
  * IOMMU translation entries.
  *
  * @mr: the memory region to observe
- * @n: the IOMMUNotifier to be added; the notify callback receives a
+ * @n: the IOMMUMRNotifier to be added; the notify callback receives a
  *     pointer to an #IOMMUTLBEntry as the opaque value; the pointer
  *     ceases to be valid on exit from the notifier.
  */
 void memory_region_register_iommu_notifier(MemoryRegion *mr,
-                                           IOMMUNotifier *n);
+                                           IOMMUMRNotifier *n);
 
 /**
  * memory_region_iommu_replay: replay existing IOMMU translations to
@@ -728,7 +728,7 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
  * @is_write: Whether to treat the replay as a translate "write"
  *     through the iommu
  */
-void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
+void memory_region_iommu_replay(MemoryRegion *mr, IOMMUMRNotifier *n,
                                 bool is_write);
 
 /**
@@ -748,7 +748,7 @@ void memory_region_iommu_replay_all(MemoryRegion *mr);
  * @n: the notifier to be removed.
  */
 void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
-                                             IOMMUNotifier *n);
+                                             IOMMUMRNotifier *n);
 
 /**
  * memory_region_name: get a memory region's name
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 3e51876..f9ac0ec 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -63,7 +63,7 @@ typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
 typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
 typedef struct VTDIrq VTDIrq;
 typedef struct VTD_MSIMessage VTD_MSIMessage;
-typedef struct IntelIOMMUNotifierNode IntelIOMMUNotifierNode;
+typedef struct IntelIOMMUMRNotifierNode IntelIOMMUMRNotifierNode;
 
 /* Context-Entry */
 struct VTDContextEntry {
@@ -250,9 +250,9 @@ struct VTD_MSIMessage {
 /* When IR is enabled, all MSI/MSI-X data bits should be zero */
 #define VTD_IR_MSI_DATA          (0)
 
-struct IntelIOMMUNotifierNode {
+struct IntelIOMMUMRNotifierNode {
     VTDAddressSpace *vtd_as;
-    QLIST_ENTRY(IntelIOMMUNotifierNode) next;
+    QLIST_ENTRY(IntelIOMMUMRNotifierNode) next;
 };
 
 /* The iommu (DMAR) device state struct */
@@ -293,7 +293,7 @@ struct IntelIOMMUState {
     GHashTable *vtd_as_by_busptr;   /* VTDBus objects indexed by PCIBus* reference */
     VTDBus *vtd_as_by_bus_num[VTD_PCI_BUS_MAX]; /* VTDBus objects indexed by bus number */
     /* list of registered notifiers */
-    QLIST_HEAD(, IntelIOMMUNotifierNode) notifiers_list;
+    QLIST_HEAD(, IntelIOMMUMRNotifierNode) notifiers_list;
 
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c582de1..348d408 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -96,7 +96,7 @@ typedef struct VFIOGuestIOMMU {
     VFIOContainer *container;
     MemoryRegion *iommu;
     hwaddr iommu_offset;
-    IOMMUNotifier n;
+    IOMMUMRNotifier n;
     QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
 } VFIOGuestIOMMU;
 
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a450321..091cfad 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -42,7 +42,7 @@ struct vhost_iommu {
     struct vhost_dev *hdev;
     MemoryRegion *mr;
     hwaddr iommu_offset;
-    IOMMUNotifier n;
+    IOMMUMRNotifier n;
     QLIST_ENTRY(vhost_iommu) iommu_next;
 };
 
@@ -75,7 +75,7 @@ struct vhost_dev {
     struct vhost_log *log;
     QLIST_ENTRY(vhost_dev) entry;
     QLIST_HEAD(, vhost_iommu) iommu_list;
-    IOMMUNotifier n;
+    IOMMUMRNotifier n;
 };
 
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
diff --git a/memory.c b/memory.c
index 6237631..ffbd020 100644
--- a/memory.c
+++ b/memory.c
@@ -1581,7 +1581,7 @@ bool memory_region_is_logging(MemoryRegion *mr, uint8_t client)
 static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
 {
     IOMMUMREventFlags flags = IOMMU_MR_EVENT_NONE;
-    IOMMUNotifier *iommu_notifier;
+    IOMMUMRNotifier *iommu_notifier;
 
     IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
         flags |= iommu_notifier->notifier_flags;
@@ -1597,7 +1597,7 @@ static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
 }
 
 void memory_region_register_iommu_notifier(MemoryRegion *mr,
-                                           IOMMUNotifier *n)
+                                           IOMMUMRNotifier *n)
 {
     if (mr->alias) {
         memory_region_register_iommu_notifier(mr->alias, n);
@@ -1620,7 +1620,7 @@ uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr)
     return TARGET_PAGE_SIZE;
 }
 
-void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
+void memory_region_iommu_replay(MemoryRegion *mr, IOMMUMRNotifier *n,
                                 bool is_write)
 {
     hwaddr addr, granularity;
@@ -1650,7 +1650,7 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUNotifier *n,
 
 void memory_region_iommu_replay_all(MemoryRegion *mr)
 {
-    IOMMUNotifier *notifier;
+    IOMMUMRNotifier *notifier;
 
     IOMMU_NOTIFIER_FOREACH(notifier, mr) {
         memory_region_iommu_replay(mr, notifier, false);
@@ -1658,7 +1658,7 @@ void memory_region_iommu_replay_all(MemoryRegion *mr)
 }
 
 void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
-                                             IOMMUNotifier *n)
+                                             IOMMUMRNotifier *n)
 {
     if (mr->alias) {
         memory_region_unregister_iommu_notifier(mr->alias, n);
@@ -1668,7 +1668,7 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
     memory_region_update_iommu_notify_flags(mr);
 }
 
-void memory_region_notify_one(IOMMUNotifier *notifier,
+void memory_region_notify_one(IOMMUMRNotifier *notifier,
                               IOMMUTLBEntry *entry)
 {
     IOMMUMREventFlags request_flags;
@@ -1696,7 +1696,7 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
 void memory_region_notify_iommu(MemoryRegion *mr,
                                 IOMMUTLBEntry entry)
 {
-    IOMMUNotifier *iommu_notifier;
+    IOMMUMRNotifier *iommu_notifier;
 
     assert(memory_region_is_iommu(mr));
 
-- 
2.7.4
