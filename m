Received: from eggs.gnu.org ([2001:4830:134:3::10]:48312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eI9zF-0003yi-L5
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eI9zA-0000Bi-PS
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:26004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eI9zA-00006q-Dt
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:24 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Fri, 24 Nov 2017 16:52:35 +0800
Message-Id: <1511513560-28611-3-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1511513560-28611-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1511513560-28611-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 2/7] vfio: rename GuestIOMMU to be
 GuestIOMMUMR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, tianyu.lan@intel.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

Rename GuestIOMMU to GuestIOMMUMR as the existing GuestIOMMU is
for MemoryRegion related notifiers.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/vfio/common.c              | 15 ++++++++-------
 include/hw/vfio/vfio-common.h |  8 ++++----
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 1f7d516..3d40bec 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -348,7 +348,7 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void **vaddr,
 
 static void vfio_iommu_map_notify(IOMMUMRNotifier *n, IOMMUTLBEntry *iotlb)
 {
-    VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
+    VFIOGuestIOMMUMR *giommu = container_of(n, VFIOGuestIOMMUMR, n);
     VFIOContainer *container = giommu->container;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
     bool read_only;
@@ -478,7 +478,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     memory_region_ref(section->mr);
 
     if (memory_region_is_iommu(section->mr)) {
-        VFIOGuestIOMMU *giommu;
+        VFIOGuestIOMMUMR *giommu;
         IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
 
         trace_vfio_listener_region_add_iommu(iova, end);
@@ -500,7 +500,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
                                IOMMU_MR_EVENT_ALL,
                                section->offset_within_region,
                                int128_get64(llend));
-        QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_next);
+        QLIST_INSERT_HEAD(&container->giommu_mr_list, giommu, giommu_next);
 
         memory_region_register_iommu_notifier(section->mr, &giommu->n);
         memory_region_iommu_replay(giommu->iommu, &giommu->n);
@@ -567,9 +567,9 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 
     if (memory_region_is_iommu(section->mr)) {
-        VFIOGuestIOMMU *giommu;
+        VFIOGuestIOMMUMR *giommu;
 
-        QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
+        QLIST_FOREACH(giommu, &container->giommu_mr_list, giommu_next) {
             if (MEMORY_REGION(giommu->iommu) == section->mr &&
                 giommu->n.start == section->offset_within_region) {
                 memory_region_unregister_iommu_notifier(section->mr,
@@ -1163,12 +1163,13 @@ static void vfio_disconnect_container(VFIOGroup *group)
 
     if (QLIST_EMPTY(&container->group_list)) {
         VFIOAddressSpace *space = container->space;
-        VFIOGuestIOMMU *giommu, *tmp;
+        VFIOGuestIOMMUMR *giommu, *tmp;
 
         vfio_listener_release(container);
         QLIST_REMOVE(container, next);
 
-        QLIST_FOREACH_SAFE(giommu, &container->giommu_list, giommu_next, tmp) {
+        QLIST_FOREACH_SAFE(giommu, &container->giommu_mr_list,
+                           giommu_next, tmp) {
             memory_region_unregister_iommu_notifier(
                     MEMORY_REGION(giommu->iommu), &giommu->n);
             QLIST_REMOVE(giommu, giommu_next);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 865e3e7..702a085 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -87,19 +87,19 @@ typedef struct VFIOContainer {
      * contiguous IOVA window.  We may need to generalize that in
      * future
      */
-    QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
+    QLIST_HEAD(, VFIOGuestIOMMUMR) giommu_mr_list;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_ENTRY(VFIOContainer) next;
 } VFIOContainer;
 
-typedef struct VFIOGuestIOMMU {
+typedef struct VFIOGuestIOMMUMR {
     VFIOContainer *container;
     IOMMUMemoryRegion *iommu;
     hwaddr iommu_offset;
     IOMMUMRNotifier n;
-    QLIST_ENTRY(VFIOGuestIOMMU) giommu_next;
-} VFIOGuestIOMMU;
+    QLIST_ENTRY(VFIOGuestIOMMUMR) giommu_next;
+} VFIOGuestIOMMUMR;
 
 typedef struct VFIOHostDMAWindow {
     hwaddr min_iova;
-- 
1.9.1
