Received: from eggs.gnu.org ([2001:4830:134:3::10]:41269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eAavW-0007kZ-Co
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eAavT-0004OF-MH
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:18:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:37808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eAavT-0004Mu-7o
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:18:19 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Fri,  3 Nov 2017 20:01:51 +0800
Message-Id: <1509710516-21084-2-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RESEND PATCH 1/6] memory: rename existing iommu
 notifier to be iommu mr notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, pbonzini@redhat.com, alex.williamson@redhat.com
Cc: tianyu.lan@intel.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

From: Peter Xu <peterx@redhat.com>

IOMMU notifiers before are mostly used for [dev-]IOTLB stuffs. It is not
suitable for other kind of notifiers (one example would be the future
virt-svm support). Considering that current notifiers are targeted for
per memory region, renaming the iommu notifier definitions.

* all the notifier types from IOMMU_NOTIFIER_* prefix into IOMMU_MR_EVENT_*
  to better show its usage (for memory regions).
* rename IOMMUNotifier to IOMMUMRNotifier
* rename iommu_notifier to iommu_mr_notifier

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/i386/amd_iommu.c           |  6 ++---
 hw/i386/intel_iommu.c         | 34 +++++++++++++-------------
 hw/ppc/spapr_iommu.c          |  8 +++----
 hw/s390x/s390-pci-bus.c       |  2 +-
 hw/vfio/common.c              | 10 ++++----
 hw/virtio/vhost.c             | 10 ++++----
 include/exec/memory.h         | 55 ++++++++++++++++++++++---------------------
 include/hw/i386/intel_iommu.h |  8 +++----
 include/hw/vfio/vfio-common.h |  2 +-
 include/hw/virtio/vhost.h     |  4 ++--
 memory.c                      | 37 +++++++++++++++--------------
 11 files changed, 89 insertions(+), 87 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index ad8155c..8f756e8 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1072,12 +1072,12 @@ static const MemoryRegionOps mmio_mem_ops = {
 };
 
 static void amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
-                                            IOMMUNotifierFlag old,
-                                            IOMMUNotifierFlag new)
+                                            IOMMUMREventFlag old,
+                                            IOMMUMREventFlag new)
 {
     AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
 
-    if (new & IOMMU_NOTIFIER_MAP) {
+    if (new & IOMMU_MR_EVENT_MAP) {
         error_report("device %02x.%02x.%x requires iommu notifier which is not "
                      "currently supported", as->bus_num, PCI_SLOT(as->devfn),
                      PCI_FUNC(as->devfn));
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3a5bb0b..e81c706 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1234,7 +1234,7 @@ static void vtd_interrupt_remap_table_setup(IntelIOMMUState *s)
 
 static void vtd_iommu_replay_all(IntelIOMMUState *s)
 {
-    IntelIOMMUNotifierNode *node;
+    IntelIOMMUMRNotifierNode *node;
 
     QLIST_FOREACH(node, &s->notifiers_list, next) {
         memory_region_iommu_replay_all(&node->vtd_as->iommu);
@@ -1308,7 +1308,7 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
                 /*
                  * So a device is moving out of (or moving into) a
                  * domain, a replay() suites here to notify all the
-                 * IOMMU_NOTIFIER_MAP registers about this change.
+                 * IOMMU_MR_EVENT_MAP registers about this change.
                  * This won't bring bad even if we have no such
                  * notifier registered - the IOMMU notification
                  * framework will skip MAP notifications if that
@@ -1358,7 +1358,7 @@ static void vtd_iotlb_global_invalidate(IntelIOMMUState *s)
 
 static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
 {
-    IntelIOMMUNotifierNode *node;
+    IntelIOMMUMRNotifierNode *node;
     VTDContextEntry ce;
     VTDAddressSpace *vtd_as;
 
@@ -1388,7 +1388,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                                            uint16_t domain_id, hwaddr addr,
                                            uint8_t am)
 {
-    IntelIOMMUNotifierNode *node;
+    IntelIOMMUMRNotifierNode *node;
     VTDContextEntry ce;
     int ret;
 
@@ -2318,21 +2318,21 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
 }
 
 static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
-                                          IOMMUNotifierFlag old,
-                                          IOMMUNotifierFlag new)
+                                          IOMMUMREventFlag old,
+                                          IOMMUMREventFlag new)
 {
     VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
     IntelIOMMUState *s = vtd_as->iommu_state;
-    IntelIOMMUNotifierNode *node = NULL;
-    IntelIOMMUNotifierNode *next_node = NULL;
+    IntelIOMMUMRNotifierNode *node = NULL;
+    IntelIOMMUMRNotifierNode *next_node = NULL;
 
-    if (!s->caching_mode && new & IOMMU_NOTIFIER_MAP) {
+    if (!s->caching_mode && new & IOMMU_MR_EVENT_MAP) {
         error_report("We need to set cache_mode=1 for intel-iommu to enable "
                      "device assignment with IOMMU protection.");
         exit(1);
     }
 
-    if (old == IOMMU_NOTIFIER_NONE) {
+    if (old == IOMMU_MR_EVENT_NONE) {
         node = g_malloc0(sizeof(*node));
         node->vtd_as = vtd_as;
         QLIST_INSERT_HEAD(&s->notifiers_list, node, next);
@@ -2342,7 +2342,7 @@ static void vtd_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     /* update notifier node with new flags */
     QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
         if (node->vtd_as == vtd_as) {
-            if (new == IOMMU_NOTIFIER_NONE) {
+            if (new == IOMMU_MR_EVENT_NONE) {
                 QLIST_REMOVE(node, next);
                 g_free(node);
             }
@@ -2759,7 +2759,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
 }
 
 /* Unmap the whole range in the notifier's scope. */
-static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
+static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUMRNotifier *n)
 {
     IOMMUTLBEntry entry;
     hwaddr size;
@@ -2814,13 +2814,13 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 
 static void vtd_address_space_unmap_all(IntelIOMMUState *s)
 {
-    IntelIOMMUNotifierNode *node;
+    IntelIOMMUMRNotifierNode *node;
     VTDAddressSpace *vtd_as;
-    IOMMUNotifier *n;
+    IOMMUMRNotifier *n;
 
     QLIST_FOREACH(node, &s->notifiers_list, next) {
         vtd_as = node->vtd_as;
-        IOMMU_NOTIFIER_FOREACH(n, &vtd_as->iommu) {
+        IOMMU_MR_NOTIFIER_FOREACH(n, &vtd_as->iommu) {
             vtd_address_space_unmap(vtd_as, n);
         }
     }
@@ -2828,11 +2828,11 @@ static void vtd_address_space_unmap_all(IntelIOMMUState *s)
 
 static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
 {
-    memory_region_notify_one((IOMMUNotifier *)private, entry);
+    memory_region_notify_one((IOMMUMRNotifier *)private, entry);
     return 0;
 }
 
-static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
+static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUMRNotifier *n)
 {
     VTDAddressSpace *vtd_as = container_of(iommu_mr, VTDAddressSpace, iommu);
     IntelIOMMUState *s = vtd_as->iommu_state;
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 5ccd785..088f614 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -161,14 +161,14 @@ static uint64_t spapr_tce_get_min_page_size(IOMMUMemoryRegion *iommu)
 }
 
 static void spapr_tce_notify_flag_changed(IOMMUMemoryRegion *iommu,
-                                          IOMMUNotifierFlag old,
-                                          IOMMUNotifierFlag new)
+                                          IOMMUMREventFlag old,
+                                          IOMMUMREventFlag new)
 {
     struct sPAPRTCETable *tbl = container_of(iommu, sPAPRTCETable, iommu);
 
-    if (old == IOMMU_NOTIFIER_NONE && new != IOMMU_NOTIFIER_NONE) {
+    if (old == IOMMU_MR_EVENT_NONE && new != IOMMU_MR_EVENT_NONE) {
         spapr_tce_set_need_vfio(tbl, true);
-    } else if (old != IOMMU_NOTIFIER_NONE && new == IOMMU_NOTIFIER_NONE) {
+    } else if (old != IOMMU_MR_EVENT_NONE && new == IOMMU_MR_EVENT_NONE) {
         spapr_tce_set_need_vfio(tbl, false);
     }
 }
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e7a58e8..10b7020 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -398,7 +398,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
 }
 
 static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
-                                  IOMMUNotifier *notifier)
+                                  IOMMUMRNotifier *notifier)
 {
     /* It's impossible to plug a pci device on s390x that already has iommu
      * mappings which need to be replayed, that is due to the "one iommu per
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7b2924c..1f7d516 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -346,7 +346,7 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
     return true;
 }
 
-static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+static void vfio_iommu_map_notify(IOMMUMRNotifier *n, IOMMUTLBEntry *iotlb)
 {
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
     VFIOContainer *container = giommu->container;
@@ -496,10 +496,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
         llend = int128_add(int128_make64(section->offset_within_region),
                            section->size);
         llend = int128_sub(llend, int128_one());
-        iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
-                            IOMMU_NOTIFIER_ALL,
-                            section->offset_within_region,
-                            int128_get64(llend));
+        iommu_mr_notifier_init(&giommu->n, vfio_iommu_map_notify,
+                               IOMMU_MR_EVENT_ALL,
+                               section->offset_within_region,
+                               int128_get64(llend));
         QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
 
         memory_region_register_iommu_notifier(section->mr, &giommu->n);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ddc42f0..e2c1228 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -719,7 +719,7 @@ static void vhost_region_del(MemoryListener *listener,
     }
 }
 
-static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
+static void vhost_iommu_unmap_notify(IOMMUMRNotifier *n, IOMMUTLBEntry *iotlb)
 {
     struct vhost_iommu *iommu = container_of(n, struct vhost_iommu, n);
     struct vhost_dev *hdev = iommu->hdev;
@@ -747,10 +747,10 @@ static void vhost_iommu_region_add(MemoryListener *listener,
     end = int128_add(int128_make64(section->offset_within_region),
                      section->size);
     end = int128_sub(end, int128_one());
-    iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
-                        IOMMU_NOTIFIER_UNMAP,
-                        section->offset_within_region,
-                        int128_get64(end));
+    iommu_mr_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
+                           IOMMU_MR_EVENT_UNMAP,
+                           section->offset_within_region,
+                           int128_get64(end));
     iommu->mr = section->mr;
     iommu->iommu_offset = section->offset_within_address_space -
                           section->offset_within_region;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5ed4042..03595e3 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -75,36 +75,36 @@ struct IOMMUTLBEntry {
 };
 
 /*
- * Bitmap for different IOMMUNotifier capabilities. Each notifier can
+ * Bitmap for different IOMMUMRNotifier capabilities. Each notifier can
  * register with one or multiple IOMMU Notifier capability bit(s).
  */
 typedef enum {
-    IOMMU_NOTIFIER_NONE = 0,
+    IOMMU_MR_EVENT_NONE = 0,
     /* Notify cache invalidations */
-    IOMMU_NOTIFIER_UNMAP = 0x1,
+    IOMMU_MR_EVENT_UNMAP = 0x1,
     /* Notify entry changes (newly created entries) */
-    IOMMU_NOTIFIER_MAP = 0x2,
-} IOMMUNotifierFlag;
+    IOMMU_MR_EVENT_MAP = 0x2,
+} IOMMUMREventFlag;
 
-#define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
+#define IOMMU_MR_EVENT_ALL (IOMMU_MR_EVENT_MAP | IOMMU_MR_EVENT_UNMAP)
 
-struct IOMMUNotifier;
-typedef void (*IOMMUNotify)(struct IOMMUNotifier *notifier,
+struct IOMMUMRNotifier;
+typedef void (*IOMMUMRNotify)(struct IOMMUMRNotifier *notifier,
                             IOMMUTLBEntry *data);
 
-struct IOMMUNotifier {
-    IOMMUNotify notify;
-    IOMMUNotifierFlag notifier_flags;
+struct IOMMUMRNotifier {
+    IOMMUMRNotify notify;
+    IOMMUMREventFlag notifier_flags;
     /* Notify for address space range start <= addr <= end */
     hwaddr start;
     hwaddr end;
-    QLIST_ENTRY(IOMMUNotifier) node;
+    QLIST_ENTRY(IOMMUMRNotifier) node;
 };
-typedef struct IOMMUNotifier IOMMUNotifier;
+typedef struct IOMMUMRNotifier IOMMUMRNotifier;
 
-static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
-                                       IOMMUNotifierFlag flags,
-                                       hwaddr start, hwaddr end)
+static inline void iommu_mr_notifier_init(IOMMUMRNotifier *n, IOMMUMRNotify fn,
+                                          IOMMUMREventFlag flags,
+                                          hwaddr start, hwaddr end)
 {
     n->notify = fn;
     n->notifier_flags = flags;
@@ -206,10 +206,10 @@ typedef struct IOMMUMemoryRegionClass {
     uint64_t (*get_min_page_size)(IOMMUMemoryRegion *iommu);
     /* Called when IOMMU Notifier flag changed */
     void (*notify_flag_changed)(IOMMUMemoryRegion *iommu,
-                                IOMMUNotifierFlag old_flags,
-                                IOMMUNotifierFlag new_flags);
+                                IOMMUMREventFlag old_flags,
+                                IOMMUMREventFlag new_flags);
     /* Set this up to provide customized IOMMU replay function */
-    void (*replay)(IOMMUMemoryRegion *iommu, IOMMUNotifier *notifier);
+    void (*replay)(IOMMUMemoryRegion *iommu, IOMMUMRNotifier *notifier);
 } IOMMUMemoryRegionClass;
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
@@ -259,11 +259,11 @@ struct MemoryRegion {
 struct IOMMUMemoryRegion {
     MemoryRegion parent_obj;
 
-    QLIST_HEAD(, IOMMUNotifier) iommu_notify;
-    IOMMUNotifierFlag iommu_notify_flags;
+    QLIST_HEAD(, IOMMUMRNotifier) iommu_notify;
+    IOMMUMREventFlag iommu_notify_flags;
 };
 
-#define IOMMU_NOTIFIER_FOREACH(n, mr) \
+#define IOMMU_MR_NOTIFIER_FOREACH(n, mr) \
     QLIST_FOREACH((n), &(mr)->iommu_notify, node)
 
 /**
@@ -879,7 +879,7 @@ void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
  *         replaces all old entries for the same virtual I/O address range.
  *         Deleted entries have .@perm == 0.
  */
-void memory_region_notify_one(IOMMUNotifier *notifier,
+void memory_region_notify_one(IOMMUMRNotifier *notifier,
                               IOMMUTLBEntry *entry);
 
 /**
@@ -887,12 +887,12 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
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
@@ -902,7 +902,8 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
  * @iommu_mr: the memory region to observe
  * @n: the notifier to which to replay iommu mappings
  */
-void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n);
+void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr,
+                                IOMMUMRNotifier *n);
 
 /**
  * memory_region_iommu_replay_all: replay existing IOMMU translations
@@ -921,7 +922,7 @@ void memory_region_iommu_replay_all(IOMMUMemoryRegion *iommu_mr);
  * @n: the notifier to be removed.
  */
 void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
-                                             IOMMUNotifier *n);
+                                             IOMMUMRNotifier *n);
 
 /**
  * memory_region_name: get a memory region's name
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index ac15e6b..c85f9ff 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -65,7 +65,7 @@ typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
 typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
 typedef struct VTDIrq VTDIrq;
 typedef struct VTD_MSIMessage VTD_MSIMessage;
-typedef struct IntelIOMMUNotifierNode IntelIOMMUNotifierNode;
+typedef struct IntelIOMMUMRNotifierNode IntelIOMMUMRNotifierNode;
 
 /* Context-Entry */
 struct VTDContextEntry {
@@ -251,9 +251,9 @@ struct VTD_MSIMessage {
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
index f3a2ac9..865e3e7 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -97,7 +97,7 @@ typedef struct VFIOGuestIOMMU {
     VFIOContainer *container;
     IOMMUMemoryRegion *iommu;
     hwaddr iommu_offset;
-    IOMMUNotifier n;
+    IOMMUMRNotifier n;
     QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
 } VFIOGuestIOMMU;
 
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 467dc77..ffe9d9f 100644
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
index e26e5a3..77fb3ef 100644
--- a/memory.c
+++ b/memory.c
@@ -1689,7 +1689,7 @@ void memory_region_init_iommu(void *_iommu_mr,
     iommu_mr = IOMMU_MEMORY_REGION(mr);
     mr->terminates = true;  /* then re-forwards */
     QLIST_INIT(&iommu_mr->iommu_notify);
-    iommu_mr->iommu_notify_flags = IOMMU_NOTIFIER_NONE;
+    iommu_mr->iommu_notify_flags = IOMMU_MR_EVENT_NONE;
 }
 
 static void memory_region_finalize(Object *obj)
@@ -1786,12 +1786,12 @@ bool memory_region_is_logging(MemoryRegion *mr, uint8_t client)
 
 static void memory_region_update_iommu_notify_flags(IOMMUMemoryRegion *iommu_mr)
 {
-    IOMMUNotifierFlag flags = IOMMU_NOTIFIER_NONE;
-    IOMMUNotifier *iommu_notifier;
+    IOMMUMREventFlag flags = IOMMU_MR_EVENT_NONE;
+    IOMMUMRNotifier *iommu_mr_notifier;
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
 
-    IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
-        flags |= iommu_notifier->notifier_flags;
+    IOMMU_MR_NOTIFIER_FOREACH(iommu_mr_notifier, iommu_mr) {
+        flags |= iommu_mr_notifier->notifier_flags;
     }
 
     if (flags != iommu_mr->iommu_notify_flags && imrc->notify_flag_changed) {
@@ -1804,7 +1804,7 @@ static void memory_region_update_iommu_notify_flags(IOMMUMemoryRegion *iommu_mr)
 }
 
 void memory_region_register_iommu_notifier(MemoryRegion *mr,
-                                           IOMMUNotifier *n)
+                                           IOMMUMRNotifier *n)
 {
     IOMMUMemoryRegion *iommu_mr;
 
@@ -1815,7 +1815,7 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
 
     /* We need to register for at least one bitfield */
     iommu_mr = IOMMU_MEMORY_REGION(mr);
-    assert(n->notifier_flags != IOMMU_NOTIFIER_NONE);
+    assert(n->notifier_flags != IOMMU_MR_EVENT_NONE);
     assert(n->start <= n->end);
     QLIST_INSERT_HEAD(&iommu_mr->iommu_notify, n, node);
     memory_region_update_iommu_notify_flags(iommu_mr);
@@ -1831,7 +1831,8 @@ uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iommu_mr)
     return TARGET_PAGE_SIZE;
 }
 
-void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
+void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr,
+                                IOMMUMRNotifier *n)
 {
     MemoryRegion *mr = MEMORY_REGION(iommu_mr);
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
@@ -1862,15 +1863,15 @@ void memory_region_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
 
 void memory_region_iommu_replay_all(IOMMUMemoryRegion *iommu_mr)
 {
-    IOMMUNotifier *notifier;
+    IOMMUMRNotifier *notifier;
 
-    IOMMU_NOTIFIER_FOREACH(notifier, iommu_mr) {
+    IOMMU_MR_NOTIFIER_FOREACH(notifier, iommu_mr) {
         memory_region_iommu_replay(iommu_mr, notifier);
     }
 }
 
 void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
-                                             IOMMUNotifier *n)
+                                             IOMMUMRNotifier *n)
 {
     IOMMUMemoryRegion *iommu_mr;
 
@@ -1883,10 +1884,10 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
     memory_region_update_iommu_notify_flags(iommu_mr);
 }
 
-void memory_region_notify_one(IOMMUNotifier *notifier,
+void memory_region_notify_one(IOMMUMRNotifier *notifier,
                               IOMMUTLBEntry *entry)
 {
-    IOMMUNotifierFlag request_flags;
+    IOMMUMREventFlag request_flags;
 
     /*
      * Skip the notification if the notification does not overlap
@@ -1898,9 +1899,9 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
     }
 
     if (entry->perm & IOMMU_RW) {
-        request_flags = IOMMU_NOTIFIER_MAP;
+        request_flags = IOMMU_MR_EVENT_MAP;
     } else {
-        request_flags = IOMMU_NOTIFIER_UNMAP;
+        request_flags = IOMMU_MR_EVENT_UNMAP;
     }
 
     if (notifier->notifier_flags & request_flags) {
@@ -1911,12 +1912,12 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
 void memory_region_notify_iommu(IOMMUMemoryRegion *iommu_mr,
                                 IOMMUTLBEntry entry)
 {
-    IOMMUNotifier *iommu_notifier;
+    IOMMUMRNotifier *iommu_mr_notifier;
 
     assert(memory_region_is_iommu(MEMORY_REGION(iommu_mr)));
 
-    IOMMU_NOTIFIER_FOREACH(iommu_notifier, iommu_mr) {
-        memory_region_notify_one(iommu_notifier, &entry);
+    IOMMU_MR_NOTIFIER_FOREACH(iommu_mr_notifier, iommu_mr) {
+        memory_region_notify_one(iommu_mr_notifier, &entry);
     }
 }
 
-- 
1.9.1
