Received: from eggs.gnu.org ([2001:4830:134:3::10]:47273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fp6-0003Fe-EK
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fp4-0003rp-OS
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:34:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3fp4-0003rJ-F0
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:34:50 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 27 Apr 2017 17:34:13 +0800
Message-Id: <1493285660-4470-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1493285660-4470-1-git-send-email-peterx@redhat.com>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 1/8] memory: rename IOMMU_NOTIFIER_*
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

IOMMU notifiers before are mostly used for [dev-]IOTLB stuffs. It is not
suitable for other kind of notifiers (one example would be the future
virt-svm support). Considering that current notifiers are targeted for
per memory region, renaming all the notifier types from IOMMU_NOTIFIER_*
prefix into IOMMU_MR_EVENT_* to better show its usage (for memory
regions).

Alongside, renaming IOMMUNotifierFlag into IOMMUMREventFlag.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/amd_iommu.c   |  6 +++---
 hw/i386/intel_iommu.c | 12 ++++++------
 hw/ppc/spapr_iommu.c  |  8 ++++----
 hw/vfio/common.c      |  2 +-
 hw/virtio/vhost.c     |  2 +-
 include/exec/memory.h | 20 ++++++++++----------
 memory.c              | 12 ++++++------
 7 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index f86a40a..315ec2a 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1067,12 +1067,12 @@ static const MemoryRegionOps mmio_mem_ops = {
 };
 
 static void amdvi_iommu_notify_flag_changed(MemoryRegion *iommu,
-                                            IOMMUNotifierFlag old,
-                                            IOMMUNotifierFlag new)
+                                            IOMMUMREventFlags old,
+                                            IOMMUMREventFlags new)
 {
     AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
 
-    if (new & IOMMU_NOTIFIER_MAP) {
+    if (new & IOMMU_MR_EVENT_MAP) {
         error_report("device %02x.%02x.%x requires iommu notifier which is not "
                      "currently supported", as->bus_num, PCI_SLOT(as->devfn),
                      PCI_FUNC(as->devfn));
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 02f047c..dce1ee8 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1132,7 +1132,7 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
                 /*
                  * So a device is moving out of (or moving into) a
                  * domain, a replay() suites here to notify all the
-                 * IOMMU_NOTIFIER_MAP registers about this change.
+                 * IOMMU_MR_EVENT_MAP registers about this change.
                  * This won't bring bad even if we have no such
                  * notifier registered - the IOMMU notification
                  * framework will skip MAP notifications if that
@@ -2253,21 +2253,21 @@ static IOMMUTLBEntry vtd_iommu_translate(MemoryRegion *iommu, hwaddr addr,
 }
 
 static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
-                                          IOMMUNotifierFlag old,
-                                          IOMMUNotifierFlag new)
+                                          IOMMUMREventFlags old,
+                                          IOMMUMREventFlags new)
 {
     VTDAddressSpace *vtd_as = container_of(iommu, VTDAddressSpace, iommu);
     IntelIOMMUState *s = vtd_as->iommu_state;
     IntelIOMMUNotifierNode *node = NULL;
     IntelIOMMUNotifierNode *next_node = NULL;
 
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
@@ -2277,7 +2277,7 @@ static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
     /* update notifier node with new flags */
     QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
         if (node->vtd_as == vtd_as) {
-            if (new == IOMMU_NOTIFIER_NONE) {
+            if (new == IOMMU_MR_EVENT_NONE) {
                 QLIST_REMOVE(node, next);
                 g_free(node);
             }
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 29c80bb..5e6e70b 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -158,14 +158,14 @@ static uint64_t spapr_tce_get_min_page_size(MemoryRegion *iommu)
 }
 
 static void spapr_tce_notify_flag_changed(MemoryRegion *iommu,
-                                          IOMMUNotifierFlag old,
-                                          IOMMUNotifierFlag new)
+                                          IOMMUMREventFlags old,
+                                          IOMMUMREventFlags new)
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
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 6b33b9f..a6ca10b 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -482,7 +482,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
                            section->size);
         llend = int128_sub(llend, int128_one());
         iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
-                            IOMMU_NOTIFIER_ALL,
+                            IOMMU_MR_EVENT_ALL,
                             section->offset_within_region,
                             int128_get64(llend));
         QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 0001e60..2e8d8fc 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -747,7 +747,7 @@ static void vhost_iommu_region_add(MemoryListener *listener,
                      section->size);
     end = int128_sub(end, int128_one());
     iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
-                        IOMMU_NOTIFIER_UNMAP,
+                        IOMMU_MR_EVENT_UNMAP,
                         section->offset_within_region,
                         int128_get64(end));
     iommu->mr = section->mr;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 99e0f54..90730b1 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -70,14 +70,14 @@ struct IOMMUTLBEntry {
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
+} IOMMUMREventFlags;
 
-#define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
+#define IOMMU_MR_EVENT_ALL (IOMMU_MR_EVENT_MAP | IOMMU_MR_EVENT_UNMAP)
 
 struct IOMMUNotifier;
 typedef void (*IOMMUNotify)(struct IOMMUNotifier *notifier,
@@ -85,7 +85,7 @@ typedef void (*IOMMUNotify)(struct IOMMUNotifier *notifier,
 
 struct IOMMUNotifier {
     IOMMUNotify notify;
-    IOMMUNotifierFlag notifier_flags;
+    IOMMUMREventFlags notifier_flags;
     /* Notify for address space range start <= addr <= end */
     hwaddr start;
     hwaddr end;
@@ -94,7 +94,7 @@ struct IOMMUNotifier {
 typedef struct IOMMUNotifier IOMMUNotifier;
 
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
-                                       IOMMUNotifierFlag flags,
+                                       IOMMUMREventFlags flags,
                                        hwaddr start, hwaddr end)
 {
     n->notify = fn;
@@ -191,8 +191,8 @@ struct MemoryRegionIOMMUOps {
     uint64_t (*get_min_page_size)(MemoryRegion *iommu);
     /* Called when IOMMU Notifier flag changed */
     void (*notify_flag_changed)(MemoryRegion *iommu,
-                                IOMMUNotifierFlag old_flags,
-                                IOMMUNotifierFlag new_flags);
+                                IOMMUMREventFlags old_flags,
+                                IOMMUMREventFlags new_flags);
     /* Set this up to provide customized IOMMU replay function */
     void (*replay)(MemoryRegion *iommu, IOMMUNotifier *notifier);
 };
@@ -240,7 +240,7 @@ struct MemoryRegion {
     unsigned ioeventfd_nb;
     MemoryRegionIoeventfd *ioeventfds;
     QLIST_HEAD(, IOMMUNotifier) iommu_notify;
-    IOMMUNotifierFlag iommu_notify_flags;
+    IOMMUMREventFlags iommu_notify_flags;
 };
 
 #define IOMMU_NOTIFIER_FOREACH(n, mr) \
diff --git a/memory.c b/memory.c
index b727f5e..6237631 100644
--- a/memory.c
+++ b/memory.c
@@ -1483,7 +1483,7 @@ void memory_region_init_iommu(MemoryRegion *mr,
     mr->iommu_ops = ops,
     mr->terminates = true;  /* then re-forwards */
     QLIST_INIT(&mr->iommu_notify);
-    mr->iommu_notify_flags = IOMMU_NOTIFIER_NONE;
+    mr->iommu_notify_flags = IOMMU_MR_EVENT_NONE;
 }
 
 static void memory_region_finalize(Object *obj)
@@ -1580,7 +1580,7 @@ bool memory_region_is_logging(MemoryRegion *mr, uint8_t client)
 
 static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
 {
-    IOMMUNotifierFlag flags = IOMMU_NOTIFIER_NONE;
+    IOMMUMREventFlags flags = IOMMU_MR_EVENT_NONE;
     IOMMUNotifier *iommu_notifier;
 
     IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
@@ -1605,7 +1605,7 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
     }
 
     /* We need to register for at least one bitfield */
-    assert(n->notifier_flags != IOMMU_NOTIFIER_NONE);
+    assert(n->notifier_flags != IOMMU_MR_EVENT_NONE);
     assert(n->start <= n->end);
     QLIST_INSERT_HEAD(&mr->iommu_notify, n, node);
     memory_region_update_iommu_notify_flags(mr);
@@ -1671,7 +1671,7 @@ void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
 void memory_region_notify_one(IOMMUNotifier *notifier,
                               IOMMUTLBEntry *entry)
 {
-    IOMMUNotifierFlag request_flags;
+    IOMMUMREventFlags request_flags;
 
     /*
      * Skip the notification if the notification does not overlap
@@ -1683,9 +1683,9 @@ void memory_region_notify_one(IOMMUNotifier *notifier,
     }
 
     if (entry->perm & IOMMU_RW) {
-        request_flags = IOMMU_NOTIFIER_MAP;
+        request_flags = IOMMU_MR_EVENT_MAP;
     } else {
-        request_flags = IOMMU_NOTIFIER_UNMAP;
+        request_flags = IOMMU_MR_EVENT_UNMAP;
     }
 
     if (notifier->notifier_flags & request_flags) {
-- 
2.7.4
