Received: from eggs.gnu.org ([2001:4830:134:3::10]:47367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fpI-0003Pv-Ml
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3fpH-00040D-Mk
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3fpH-0003zc-DW
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:35:03 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 27 Apr 2017 17:34:15 +0800
Message-Id: <1493285660-4470-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1493285660-4470-1-git-send-email-peterx@redhat.com>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 3/8] memory: rename iommu_notifier_init()
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

It's new name is iommu_mr_notifier_init(). Again, literal changes only.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/vfio/common.c      | 8 ++++----
 hw/virtio/vhost.c     | 8 ++++----
 include/exec/memory.h | 7 ++++---
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index bd113b7..6b3953b 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -481,10 +481,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
         llend = int128_add(int128_make64(section->offset_within_region),
                            section->size);
         llend = int128_sub(llend, int128_one());
-        iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
-                            IOMMU_MR_EVENT_ALL,
-                            section->offset_within_region,
-                            int128_get64(llend));
+        iommu_mr_notifier_init(&giommu->n, vfio_iommu_map_notify,
+                               IOMMU_MR_EVENT_ALL,
+                               section->offset_within_region,
+                               int128_get64(llend));
         QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
 
         memory_region_register_iommu_notifier(giommu->iommu, &giommu->n);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 81a8aea..7449cf8 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -746,10 +746,10 @@ static void vhost_iommu_region_add(MemoryListener *listener,
     end = int128_add(int128_make64(section->offset_within_region),
                      section->size);
     end = int128_sub(end, int128_one());
-    iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
-                        IOMMU_MR_EVENT_UNMAP,
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
index 6be0c02..8d8dcb2 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -93,9 +93,10 @@ struct IOMMUMRNotifier {
 };
 typedef struct IOMMUMRNotifier IOMMUMRNotifier;
 
-static inline void iommu_notifier_init(IOMMUMRNotifier *n, IOMMUNotify fn,
-                                       IOMMUMREventFlags flags,
-                                       hwaddr start, hwaddr end)
+static inline void iommu_mr_notifier_init(IOMMUMRNotifier *n,
+                                          IOMMUNotify fn,
+                                          IOMMUMREventFlags flags,
+                                          hwaddr start, hwaddr end)
 {
     n->notify = fn;
     n->notifier_flags = flags;
-- 
2.7.4
