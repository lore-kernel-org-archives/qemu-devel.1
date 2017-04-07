Received: from eggs.gnu.org ([2001:4830:134:3::10]:56917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cwRd2-0000LF-NS
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cwRcz-0005QU-Lc
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:00:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cwRcz-0005QF-DJ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:00:29 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri,  7 Apr 2017 18:59:07 +0800
Message-Id: <1491562755-23867-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1491562755-23867-1-git-send-email-peterx@redhat.com>
References: <1491562755-23867-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v9 1/9] memory: add section range info for
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, Marcel Apfelbaum <marcel@redhat.com>, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com

In this patch, IOMMUNotifier.{start|end} are introduced to store section
information for a specific notifier. When notification occurs, we not
only check the notification type (MAP|UNMAP), but also check whether the
notified iova range overlaps with the range of specific IOMMU notifier,
and skip those notifiers if not in the listened range.

When removing an region, we need to make sure we removed the correct
VFIOGuestIOMMU by checking the IOMMUNotifier.start address as well.

This patch is solving the problem that vfio-pci devices receive
duplicated UNMAP notification on x86 platform when vIOMMU is there. The
issue is that x86 IOMMU has a (0, 2^64-1) IOMMU region, which is
splitted by the (0xfee00000, 0xfeefffff) IRQ region. AFAIK
this (splitted IOMMU region) is only happening on x86.

This patch also helps vhost to leverage the new interface as well, so
that vhost won't get duplicated cache flushes. In that sense, it's an
slight performance improvement.

Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/common.c      | 12 +++++++++---
 hw/virtio/vhost.c     | 10 ++++++++--
 include/exec/memory.h | 19 ++++++++++++++++++-
 memory.c              |  9 +++++++++
 4 files changed, 44 insertions(+), 6 deletions(-)

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
index 613494d..185b95b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -736,14 +736,20 @@ static void vhost_iommu_region_add(MemoryListener *listener,
     struct vhost_dev *dev = container_of(listener, struct vhost_dev,
                                          iommu_listener);
     struct vhost_iommu *iommu;
+    Int128 end;
 
     if (!memory_region_is_iommu(section->mr)) {
         return;
     }
 
     iommu = g_malloc0(sizeof(*iommu));
-    iommu->n.notify = vhost_iommu_unmap_notify;
-    iommu->n.notifier_flags = IOMMU_NOTIFIER_UNMAP;
+    end = int128_add(int128_make64(section->offset_within_region),
+                     section->size);
+    end = int128_sub(end, int128_one());
+    iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
+                        IOMMU_NOTIFIER_UNMAP,
+                        section->offset_within_region,
+                        int128_get64(end));
     iommu->mr = section->mr;
     iommu->iommu_offset = section->offset_within_address_space -
                           section->offset_within_region;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index f20b191..0840c89 100644
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
index 4c95aaf..75ac595 100644
--- a/memory.c
+++ b/memory.c
@@ -1606,6 +1606,7 @@ void memory_region_register_iommu_notifier(MemoryRegion *mr,
 
     /* We need to register for at least one bitfield */
     assert(n->notifier_flags != IOMMU_NOTIFIER_NONE);
+    assert(n->start <= n->end);
     QLIST_INSERT_HEAD(&mr->iommu_notify, n, node);
     memory_region_update_iommu_notify_flags(mr);
 }
@@ -1667,6 +1668,14 @@ void memory_region_notify_iommu(MemoryRegion *mr,
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
