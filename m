Received: from eggs.gnu.org ([2001:4830:134:3::10]:36894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cb19T-0001tv-7U
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cb19S-0004Pu-05
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:29:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cb19R-0004Ou-N8
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:29:25 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  7 Feb 2017 16:28:12 +0800
Message-Id: <1486456099-7345-11-git-send-email-peterx@redhat.com>
In-Reply-To: <1486456099-7345-1-git-send-email-peterx@redhat.com>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v7 10/17] memory: add section range info for
 IOMMU notifier
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

In this patch, IOMMUNotifier.{start|end} are introduced to store section
information for a specific notifier. When notification occurs, we not
only check the notification type (MAP|UNMAP), but also check whether the
notified iova range overlaps with the range of specific IOMMU notifier,
and skip those notifiers if not in the listened range.

When removing an region, we need to make sure we removed the correct
VFIOGuestIOMMU by checking the IOMMUNotifier.start address as well.

Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/common.c      | 12 +++++++++---
 hw/virtio/vhost.c     |  4 ++--
 include/exec/memory.h | 19 ++++++++++++++++++-
 memory.c              |  9 +++++++++
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f3ba9b9..6b33b9f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -478,8 +478,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
         giommu->iommu_offset = section->offset_within_address_space -
                                section->offset_within_region;
         giommu->container = container;
-        giommu->n.notify = vfio_iommu_map_notify;
-        giommu->n.notifier_flags = IOMMU_NOTIFIER_ALL;
+        llend = int128_add(int128_make64(section->offset_within_region),
+                           section->size);
+        llend = int128_sub(llend, int128_one());
+        iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
+                            IOMMU_NOTIFIER_ALL,
+                            section->offset_within_region,
+                            int128_get64(llend));
         QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
 
         memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
@@ -550,7 +555,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
         VFIOGuestIOMMU *giommu;
 
         QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
-            if (giommu->iommu == section->mr) {
+            if (giommu->iommu == section->mr &&
+                giommu->n.start == section->offset_within_region) {
                 memory_region_unregister_iommu_notifier(giommu->iommu,
                                                         &giommu->n);
                 QLIST_REMOVE(giommu, giommu_next);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index febe519..ccf8b2e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1244,8 +1244,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         .priority = 10
     };
 
-    hdev->n.notify = vhost_iommu_unmap_notify;
-    hdev->n.notifier_flags = IOMMU_NOTIFIER_UNMAP;
+    iommu_notifier_init(&hdev->n, vhost_iommu_unmap_notify,
+                        IOMMU_NOTIFIER_UNMAP, 0, ~0ULL);
 
     if (hdev->migration_blocker == NULL) {
         if (!(hdev->features & (0x1ULL << VHOST_F_LOG_ALL))) {
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 987f925..805a88a 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -77,13 +77,30 @@ typedef enum {
 
 #define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
 
+struct IOMMUNotifier;
+typedef void (*IOMMUNotify)(struct IOMMUNotifier *notifier,
+                            IOMMUTLBEntry *data);
+
 struct IOMMUNotifier {
-    void (*notify)(struct IOMMUNotifier *notifier, IOMMUTLBEntry *data);
+    IOMMUNotify notify;
     IOMMUNotifierFlag notifier_flags;
+    /* Notify for address space range start <= addr <= end */
+    hwaddr start;
+    hwaddr end;
     QLIST_ENTRY(IOMMUNotifier) node;
 };
 typedef struct IOMMUNotifier IOMMUNotifier;
 
+static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
+                                       IOMMUNotifierFlag flags,
+                                       hwaddr start, hwaddr end)
+{
+    n->notify = fn;
+    n->notifier_flags = flags;
+    n->start = start;
+    n->end = end;
+}
+
 /* New-style MMIO accessors can indicate that the transaction failed.
  * A zero (MEMTX_OK) response means success; anything else is a failure
  * of some kind. The memory subsystem will bitwise-OR together results
diff --git a/memory.c b/memory.c
index 6c58373..4900bbf 100644
--- a/memory.c
+++ b/memory.c
@@ -1610,6 +1610,7 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
 
     /* We need to register for at least one bitfield */
     assert(n->notifier_flags != IOMMU_NOTIFIER_NONE);
+    assert(n->start <= n->end);
     QLIST_INSERT_HEAD(&mr->iommu_notify, n, node);
     memory_region_update_iommu_notify_flags(mr);
 }
@@ -1671,6 +1672,14 @@ void memory_region_notify_iommu(MemoryRegion *mr,
     }
 
     QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
+        /*
+         * Skip the notification if the notification does not overlap
+         * with registered range.
+         */
+        if (iommu_notifier->start > entry.iova + entry.addr_mask + 1 ||
+            iommu_notifier->end < entry.iova) {
+            continue;
+        }
         if (iommu_notifier->notifier_flags & request_flags) {
             iommu_notifier->notify(iommu_notifier, &entry);
         }
-- 
2.7.4
