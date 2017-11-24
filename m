Received: from eggs.gnu.org ([2001:4830:134:3::10]:48510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eI9zQ-00049e-VZ
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eI9zO-0000L1-JX
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:49873)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eI9zO-0000JB-8r
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 04:09:38 -0500
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Fri, 24 Nov 2017 16:52:39 +0800
Message-Id: <1511513560-28611-7-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1511513560-28611-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1511513560-28611-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 6/7] vfio/pci: add notify framework based on
 IOMMUObject
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

This patch introduce a notify framework for IOMMUObject.iommu_notifiers.
Introduce VFIOGuestIOMMUObject is to link VFIO Container and the new
IOMMUObject notififiers.

VFIOGuestIOMMUObject instance is allocated when device is assigned and
meanwhile vIOMMU is exposed to guest.

If there is IOMMUObject behind the device AddressSpace(a.ka vIOMMU exposed).
The VFIOGuestIOMMUObject instance would be allocated and inserted to the
VFIOContainer.giommu_object_list.

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/vfio/common.c              |  1 +
 hw/vfio/pci.c                 | 39 ++++++++++++++++++++++++++++++++++++++-
 include/hw/vfio/vfio-common.h |  9 +++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 3d40bec..9d53e1a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -990,6 +990,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container = g_malloc0(sizeof(*container));
     container->space = space;
     container->fd = fd;
+    QLIST_INIT(&container->giommu_object_list);
     if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
         ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
         bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c977ee3..5b77c7e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2642,6 +2642,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
+    AddressSpace *as;
+    IOMMUObject *iommu;
     char *tmp, group_path[PATH_MAX], *group_name;
     Error *err = NULL;
     ssize_t len;
@@ -2694,7 +2696,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     trace_vfio_realize(vdev->vbasedev.name, groupid);
 
-    group = vfio_get_group(groupid, pci_device_iommu_address_space(pdev), errp);
+    as = pci_device_iommu_address_space(pdev);
+    group = vfio_get_group(groupid, as, errp);
     if (!group) {
         goto error;
     }
@@ -2877,6 +2880,17 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
 
+    iommu = address_space_iommu_get(as);
+    if (iommu != NULL) {
+        VFIOGuestIOMMUObject *giommu;
+        giommu = g_malloc0(sizeof(*giommu));
+        giommu->iommu = iommu;
+        giommu->container = group->container;
+        QLIST_INSERT_HEAD(&group->container->giommu_object_list,
+                          giommu,
+                          giommu_next);
+    }
+
     return;
 
 out_teardown:
@@ -2907,6 +2921,28 @@ static void vfio_instance_finalize(Object *obj)
     vfio_put_group(group);
 }
 
+static void vfio_release_iommu_object(PCIDevice *pdev)
+{
+    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
+    AddressSpace *as;
+    IOMMUObject *iommu;
+
+    as = pci_device_iommu_address_space(pdev);
+    iommu = address_space_iommu_get(as);
+    if (iommu != NULL) {
+        VFIOGuestIOMMUObject *giommu, *tmp;
+        VFIOGroup *group;
+        group = vdev->vbasedev.group;
+
+        QLIST_FOREACH_SAFE(giommu,
+                           &group->container->giommu_object_list,
+                           giommu_next, tmp) {
+            QLIST_REMOVE(giommu, giommu_next);
+            g_free(giommu);
+        }
+    }
+    return;
+}
 static void vfio_exitfn(PCIDevice *pdev)
 {
     VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
@@ -2915,6 +2951,7 @@ static void vfio_exitfn(PCIDevice *pdev)
     vfio_unregister_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
     vfio_disable_interrupts(vdev);
+    vfio_release_iommu_object(pdev);
     if (vdev->intx.mmap_timer) {
         timer_free(vdev->intx.mmap_timer);
     }
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 702a085..77075d5 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -29,6 +29,7 @@
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 #endif
+#include "hw/core/iommu.h"
 
 #define ERR_PREFIX "vfio error: %s: "
 #define WARN_PREFIX "vfio warning: %s: "
@@ -88,6 +89,7 @@ typedef struct VFIOContainer {
      * future
      */
     QLIST_HEAD(, VFIOGuestIOMMUMR) giommu_mr_list;
+    QLIST_HEAD(, VFIOGuestIOMMUObject) giommu_object_list;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_ENTRY(VFIOContainer) next;
@@ -101,6 +103,13 @@ typedef struct VFIOGuestIOMMUMR {
     QLIST_ENTRY(VFIOGuestIOMMUMR) giommu_next;
 } VFIOGuestIOMMUMR;
 
+typedef struct VFIOGuestIOMMUObject {
+    VFIOContainer *container;
+    IOMMUObject *iommu;
+    IOMMUNotifier n;
+    QLIST_ENTRY(VFIOGuestIOMMUObject) giommu_next;
+} VFIOGuestIOMMUObject;
+
 typedef struct VFIOHostDMAWindow {
     hwaddr min_iova;
     hwaddr max_iova;
-- 
1.9.1
