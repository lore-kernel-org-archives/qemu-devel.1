Received: from eggs.gnu.org ([209.51.188.92]:37910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt3S-0001DK-3U
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt3R-00040T-1G
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:05:06 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 12 Apr 2019 12:03:35 +0200
Message-Id: <20190412100354.6409-9-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v3 08/27] hw/vfio/common: Force nested if iommu
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
Cc: alex.williamson@redhat.com, mst@redhat.com, jean-philippe.brucker@arm.com, peterx@redhat.com, yi.l.liu@intel.com, vincent.stehle@arm.com

In case we detect the address space is translated by
a virtual IOMMU which requires nested stages, let's set up
the container with the VFIO_TYPE1_NESTING_IOMMU iommu_type.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- add "nested only is selected if requested by @force_nested"
  comment in this patch
---
 hw/vfio/common.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f88fd10ca3..49ce874244 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1119,14 +1119,19 @@ static void vfio_put_address_space(VFIOAddressSpa=
ce *space)
  * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
  */
 static int vfio_get_iommu_type(VFIOContainer *container,
+                               bool force_nested,
                                Error **errp)
 {
-    int iommu_types[] =3D { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
+    int iommu_types[] =3D { VFIO_TYPE1_NESTING_IOMMU,
+                          VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
                           VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU =
};
     int i;
=20
     for (i =3D 0; i < ARRAY_SIZE(iommu_types); i++) {
         if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) =
{
+            if (iommu_types[i] =3D=3D VFIO_TYPE1_NESTING_IOMMU && !force=
_nested) {
+                continue;
+            }
             return iommu_types[i];
         }
     }
@@ -1135,11 +1140,11 @@ static int vfio_get_iommu_type(VFIOContainer *con=
tainer,
 }
=20
 static int vfio_init_container(VFIOContainer *container, int group_fd,
-                               Error **errp)
+                               bool force_nested, Error **errp)
 {
     int iommu_type, ret;
=20
-    iommu_type =3D vfio_get_iommu_type(container, errp);
+    iommu_type =3D vfio_get_iommu_type(container, force_nested, errp);
     if (iommu_type < 0) {
         return iommu_type;
     }
@@ -1175,6 +1180,14 @@ static int vfio_connect_container(VFIOGroup *group=
, AddressSpace *as,
     VFIOContainer *container;
     int ret, fd;
     VFIOAddressSpace *space;
+    IOMMUMemoryRegion *iommu_mr;
+    bool force_nested =3D false;
+
+    if (as !=3D &address_space_memory && memory_region_is_iommu(as->root=
)) {
+        iommu_mr =3D IOMMU_MEMORY_REGION(as->root);
+        memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_VFIO_NESTED,
+                                     (void *)&force_nested);
+    }
=20
     space =3D vfio_get_address_space(as);
=20
@@ -1235,12 +1248,18 @@ static int vfio_connect_container(VFIOGroup *grou=
p, AddressSpace *as,
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
=20
-    ret =3D vfio_init_container(container, group->fd, errp);
+    ret =3D vfio_init_container(container, group->fd, force_nested, errp=
);
     if (ret) {
         goto free_container_exit;
     }
=20
+    if (force_nested && container->iommu_type !=3D VFIO_TYPE1_NESTING_IO=
MMU) {
+            error_setg(errp, "nested mode requested by the virtual IOMMU=
 "
+                       "but not supported by the vfio iommu");
+    }
+
     switch (container->iommu_type) {
+    case VFIO_TYPE1_NESTING_IOMMU:
     case VFIO_TYPE1v2_IOMMU:
     case VFIO_TYPE1_IOMMU:
     {
--=20
2.20.1
