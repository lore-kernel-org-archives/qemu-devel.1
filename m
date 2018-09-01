Received: from eggs.gnu.org ([2001:4830:134:3::10]:55115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6qR-0006KD-TI
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fw6oY-0005Ye-58
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 10:23:50 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Sat,  1 Sep 2018 16:22:59 +0200
Message-Id: <20180901142312.11662-8-eric.auger@redhat.com>
In-Reply-To: <20180901142312.11662-1-eric.auger@redhat.com>
References: <20180901142312.11662-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 07/20] hw/vfio/common: Force nested if iommu
 requires it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: alex.williamson@redhat.com, mst@redhat.com, cdall@kernel.org, jean-philippe.brucker@arm.com, peterx@redhat.com, yi.l.liu@intel.com

In case we detect the address space is translated by
a virtual IOMMU which requires nested stages, let's set up
the container with the VFIO_TYPE1_NESTING_IOMMU iommu_type.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/common.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 39f400b077..53ff7a6b39 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1041,11 +1041,15 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
  * nested only is selected if requested by @force_nested
  */
 static int vfio_iommu_get_type(VFIOContainer *container,
-                               Error **errp)
+                               bool force_nested, Error **errp)
 {
     int fd = container->fd;
 
-    if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
+    if (force_nested &&
+        ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_NESTING_IOMMU)) {
+        /* NESTED implies v2 */
+        return VFIO_TYPE1_NESTING_IOMMU;
+    } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
         return VFIO_TYPE1v2_IOMMU;
     } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU)) {
         return VFIO_TYPE1_IOMMU;
@@ -1085,9 +1089,16 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     VFIOContainer *container;
     int ret, fd;
     VFIOAddressSpace *space;
+    IOMMUMemoryRegion *iommu_mr;
     int iommu_type;
+    bool force_nested = false;
     bool v2 = false;
 
+    if (as != &address_space_memory && memory_region_is_iommu(as->root)) {
+        iommu_mr = IOMMU_MEMORY_REGION(as->root);
+        memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_VFIO_NESTED,
+                                     (void *)&force_nested);
+    }
 
     space = vfio_get_address_space(as);
 
@@ -1148,12 +1159,18 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
 
-    iommu_type = vfio_iommu_get_type(container, errp);
+    iommu_type = vfio_iommu_get_type(container, force_nested, errp);
     if (iommu_type < 0) {
             goto free_container_exit;
     }
 
+    if (force_nested && iommu_type != VFIO_TYPE1_NESTING_IOMMU) {
+            error_setg(errp, "nested mode requested by the virtual IOMMU "
+                       "but not supported by the vfio iommu");
+    }
+
     switch (iommu_type) {
+    case VFIO_TYPE1_NESTING_IOMMU:
     case VFIO_TYPE1v2_IOMMU:
     case VFIO_TYPE1_IOMMU:
     {
-- 
2.17.1
