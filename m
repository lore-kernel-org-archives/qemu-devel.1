Received: from eggs.gnu.org ([2001:4830:134:3::10]:47513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fpq-0003uh-Gi
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fpl-0004JS-IM
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3fpl-0004Iw-9A
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:33 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 27 Apr 2017 17:34:17 +0800
Message-Id: <1493285660-4470-6-git-send-email-peterx@redhat.com>
In-Reply-To: <1493285660-4470-1-git-send-email-peterx@redhat.com>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 5/8] memory: rename *iommu_notifier*
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

Renaming *iommu_notifiers* into *iotlb_notifiers*. Again, let's reserve
the iommu_notifier keyword to the notifiers that will be for per-iommu,
and let the old per-mr notifier be iotlb_notifiers.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/common.c      |  6 +++---
 hw/virtio/vhost.c     |  4 ++--
 include/exec/memory.h |  8 ++++----
 memory.c              | 20 ++++++++++----------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 6b3953b..7b639ea 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -487,7 +487,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
                                int128_get64(llend));
         QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
 
-        memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
+        memory_region_register_iotlb_notifier(giommu->iommu, &giommu->n);
         memory_region_iommu_replay(giommu->iommu, &giommu->n, false);
 
         return;
@@ -557,7 +557,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
         QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
             if (giommu->iommu == section->mr &&
                 giommu->n.start == section->offset_within_region) {
-                memory_region_unregister_iommu_notifier(giommu->iommu,
+                memory_region_unregister_iotlb_notifier(giommu->iommu,
                                                         &giommu->n);
                 QLIST_REMOVE(giommu, giommu_next);
                 g_free(giommu);
@@ -1147,7 +1147,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
         QLIST_REMOVE(container, next);
 
         QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
-            memory_region_unregister_iommu_notifier(giommu->iommu, &giommu->n);
+            memory_region_unregister_iotlb_notifier(giommu->iommu, &giommu->n);
             QLIST_REMOVE(giommu, giommu_next);
             g_free(giommu);
         }
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7449cf8..a1e03ed 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -754,7 +754,7 @@ static void vhost_iommu_region_add(MemoryListener *listener,
     iommu->iommu_offset = section->offset_within_address_space -
                           section->offset_within_region;
     iommu->hdev = dev;
-    memory_region_register_iommu_notifier(section->mr, &iommu->n);
+    memory_region_register_iotlb_notifier(section->mr, &iommu->n);
     QLIST_INSERT_HEAD(&dev->iommu_list, iommu, iommu_next);
     /* TODO: can replay help performance here? */
 }
@@ -773,7 +773,7 @@ static void vhost_iommu_region_del(MemoryListener *listener,
     QLIST_FOREACH(iommu, &dev->iommu_list, iommu_next) {
         if (iommu->mr == section->mr &&
             iommu->n.start == section->offset_within_region) {
-            memory_region_unregister_iommu_notifier(iommu->mr,
+            memory_region_unregister_iotlb_notifier(iommu->mr,
                                                     &iommu->n);
             QLIST_REMOVE(iommu, iommu_next);
             g_free(iommu);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 09188a6..e5707b3 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -708,7 +708,7 @@ void memory_region_notify_iotlb_one(IOMMUMRNotifier *notifier,
                                     IOMMUTLBEntry *entry);
 
 /**
- * memory_region_register_iommu_notifier: register a notifier for changes to
+ * memory_region_register_iotlb_notifier: register a notifier for changes to
  * IOMMU translation entries.
  *
  * @mr: the memory region to observe
@@ -716,7 +716,7 @@ void memory_region_notify_iotlb_one(IOMMUMRNotifier *notifier,
  *     pointer to an #IOMMUTLBEntry as the opaque value; the pointer
  *     ceases to be valid on exit from the notifier.
  */
-void memory_region_register_iommu_notifier(MemoryRegion *mr,
+void memory_region_register_iotlb_notifier(MemoryRegion *mr,
                                            IOMMUMRNotifier *n);
 
 /**
@@ -741,14 +741,14 @@ void memory_region_iommu_replay(MemoryRegion *mr, IOMMUMRNotifier *n,
 void memory_region_iommu_replay_all(MemoryRegion *mr);
 
 /**
- * memory_region_unregister_iommu_notifier: unregister a notifier for
+ * memory_region_unregister_iotlb_notifier: unregister a notifier for
  * changes to IOMMU translation entries.
  *
  * @mr: the memory region which was observed and for which notity_stopped()
  *      needs to be called
  * @n: the notifier to be removed.
  */
-void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
+void memory_region_unregister_iotlb_notifier(MemoryRegion *mr,
                                              IOMMUMRNotifier *n);
 
 /**
diff --git a/memory.c b/memory.c
index c6532e4..6af523e 100644
--- a/memory.c
+++ b/memory.c
@@ -1581,10 +1581,10 @@ bool memory_region_is_logging(MemoryRegion *mr, uint8_t client)
 static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
 {
     IOMMUMREventFlags flags = IOMMU_MR_EVENT_NONE;
-    IOMMUMRNotifier *iommu_notifier;
+    IOMMUMRNotifier *iotlb_notifier;
 
-    IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
-        flags |= iommu_notifier->notifier_flags;
+    IOMMU_NOTIFIER_FOREACH(iotlb_notifier, mr) {
+        flags |= iotlb_notifier->notifier_flags;
     }
 
     if (flags != mr->iommu_notify_flags &&
@@ -1596,11 +1596,11 @@ static void memory_region_update_iommu_notify_flags(MemoryRegion *mr)
     mr->iommu_notify_flags = flags;
 }
 
-void memory_region_register_iommu_notifier(MemoryRegion *mr,
+void memory_region_register_iotlb_notifier(MemoryRegion *mr,
                                            IOMMUMRNotifier *n)
 {
     if (mr->alias) {
-        memory_region_register_iommu_notifier(mr->alias, n);
+        memory_region_register_iotlb_notifier(mr->alias, n);
         return;
     }
 
@@ -1657,11 +1657,11 @@ void memory_region_iommu_replay_all(MemoryRegion *mr)
     }
 }
 
-void memory_region_unregister_iommu_notifier(MemoryRegion *mr,
+void memory_region_unregister_iotlb_notifier(MemoryRegion *mr,
                                              IOMMUMRNotifier *n)
 {
     if (mr->alias) {
-        memory_region_unregister_iommu_notifier(mr->alias, n);
+        memory_region_unregister_iotlb_notifier(mr->alias, n);
         return;
     }
     QLIST_REMOVE(n, node);
@@ -1696,12 +1696,12 @@ void memory_region_notify_iotlb_one(IOMMUMRNotifier *notifier,
 void memory_region_notify_iotlb(MemoryRegion *mr,
                                 IOMMUTLBEntry entry)
 {
-    IOMMUMRNotifier *iommu_notifier;
+    IOMMUMRNotifier *iotlb_notifier;
 
     assert(memory_region_is_iommu(mr));
 
-    IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
-        memory_region_notify_iotlb_one(iommu_notifier, &entry);
+    IOMMU_NOTIFIER_FOREACH(iotlb_notifier, mr) {
+        memory_region_notify_iotlb_one(iotlb_notifier, &entry);
     }
 }
 
-- 
2.7.4
