Received: from eggs.gnu.org ([209.51.188.92]:60345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gkEoX-0003CY-SM
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gkEoW-0008LW-T8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:03:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1gkEoW-0008Jx-KF
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:03:00 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 17 Jan 2019 22:02:45 +0100
Message-Id: <20190117210245.18364-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] hw/vfio/common: Refactor container
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com
Cc: groug@kaod.org, aik@ozlabs.ru

In vfio_connect_container() the code that selects the
iommu type can benefit from helpers such as
vfio_iommu_get_type() and vfio_init_container(). As
a result we end up with a switch/case on the iommu type
that makes the code a little bit more readable and ready
for addition of new iommu types. Also ioctl's get called
once per iommu_type.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- handle SPAPR case, s/ret/errno in error error_setg_errno,
  fix ret value when vfio_iommu_get_type fails
- removed Greg's R-b

v1:
- originally submitted in [RFC v2 00/28] vSMMUv3/pSMMUv3
  2 stage VFIO integration
---
 hw/vfio/common.c | 112 +++++++++++++++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 37 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4262b80c44..33335cee47 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1036,12 +1036,65 @@ static void vfio_put_address_space(VFIOAddressSpa=
ce *space)
     }
 }
=20
+/*
+ * vfio_iommu_get_type - selects the richest iommu_type (v2 first)
+ */
+static int vfio_iommu_get_type(VFIOContainer *container,
+                               Error **errp)
+{
+    int fd =3D container->fd;
+
+    if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
+        return VFIO_TYPE1v2_IOMMU;
+    } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU)) {
+        return VFIO_TYPE1_IOMMU;
+    } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU))=
 {
+        return VFIO_SPAPR_TCE_v2_IOMMU;
+    } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU)) {
+        return VFIO_SPAPR_TCE_IOMMU;
+    } else {
+        error_setg(errp, "No available IOMMU models");
+        return -EINVAL;
+    }
+}
+
+static int vfio_init_container(VFIOContainer *container, int group_fd,
+                               int iommu_type, Error **errp)
+{
+    int ret;
+
+    ret =3D ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd);
+    if (ret) {
+        error_setg_errno(errp, -ret, "failed to set group container");
+        return ret;
+    }
+
+    ret =3D ioctl(container->fd, VFIO_SET_IOMMU, iommu_type);
+    if (ret && iommu_type =3D=3D VFIO_SPAPR_TCE_v2_IOMMU) {
+        /*
+         * On sPAPR, despite the IOMMU subdriver always advertises v1 an=
d v2,
+         * the running platform may not support v2 and there is no way t=
o
+         * guess it until an IOMMU group gets added to the container. So=
 in
+         * case it fails with v2, try v1 as a fallback
+         */
+        iommu_type =3D VFIO_SPAPR_TCE_IOMMU;
+        ret =3D ioctl(container->fd, VFIO_SET_IOMMU, iommu_type);
+    }
+    if (ret) {
+        error_setg_errno(errp, -ret, "failed to set iommu for container"=
);
+        return ret;
+    }
+    container->iommu_type =3D iommu_type;
+    return ret;
+}
+
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                   Error **errp)
 {
     VFIOContainer *container;
     int ret, fd;
     VFIOAddressSpace *space;
+    int iommu_type;
=20
     space =3D vfio_get_address_space(as);
=20
@@ -1101,23 +1154,21 @@ static int vfio_connect_container(VFIOGroup *grou=
p, AddressSpace *as,
     container->fd =3D fd;
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
-    if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
-        ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
-        bool v2 =3D !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU=
);
+
+    iommu_type =3D vfio_iommu_get_type(container, errp);
+    if (iommu_type < 0) {
+            ret =3D -EINVAL;
+            goto free_container_exit;
+    }
+
+    switch (iommu_type) {
+    case VFIO_TYPE1v2_IOMMU:
+    case VFIO_TYPE1_IOMMU:
+    {
         struct vfio_iommu_type1_info info;
=20
-        ret =3D ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &fd);
+        ret =3D vfio_init_container(container, group->fd, iommu_type, er=
rp);
         if (ret) {
-            error_setg_errno(errp, errno, "failed to set group container=
");
-            ret =3D -errno;
-            goto free_container_exit;
-        }
-
-        container->iommu_type =3D v2 ? VFIO_TYPE1v2_IOMMU : VFIO_TYPE1_I=
OMMU;
-        ret =3D ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
-        if (ret) {
-            error_setg_errno(errp, errno, "failed to set iommu for conta=
iner");
-            ret =3D -errno;
             goto free_container_exit;
         }
=20
@@ -1137,31 +1188,21 @@ static int vfio_connect_container(VFIOGroup *grou=
p, AddressSpace *as,
         }
         vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
         container->pgsizes =3D info.iova_pgsizes;
-    } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU) ||
-               ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU))=
 {
+        break;
+    }
+    case VFIO_SPAPR_TCE_v2_IOMMU:
+    case VFIO_SPAPR_TCE_IOMMU:
+    {
         struct vfio_iommu_spapr_tce_info info;
-        bool v2 =3D !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_=
IOMMU);
+        bool v2;
=20
-        ret =3D ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &fd);
+        ret =3D vfio_init_container(container, group->fd, iommu_type, er=
rp);
         if (ret) {
-            error_setg_errno(errp, errno, "failed to set group container=
");
-            ret =3D -errno;
-            goto free_container_exit;
-        }
-        container->iommu_type =3D
-            v2 ? VFIO_SPAPR_TCE_v2_IOMMU : VFIO_SPAPR_TCE_IOMMU;
-        ret =3D ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
-        if (ret) {
-            container->iommu_type =3D VFIO_SPAPR_TCE_IOMMU;
-            v2 =3D false;
-            ret =3D ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
-        }
-        if (ret) {
-            error_setg_errno(errp, errno, "failed to set iommu for conta=
iner");
-            ret =3D -errno;
             goto free_container_exit;
         }
=20
+        v2 =3D container->iommu_type =3D=3D VFIO_SPAPR_TCE_v2_IOMMU;
+
         /*
          * The host kernel code implementing VFIO_IOMMU_DISABLE is calle=
d
          * when container fd is closed so we do not call it explicitly
@@ -1222,10 +1263,7 @@ static int vfio_connect_container(VFIOGroup *group=
, AddressSpace *as,
                               info.dma32_window_size - 1,
                               0x1000);
         }
-    } else {
-        error_setg(errp, "No available IOMMU models");
-        ret =3D -EINVAL;
-        goto free_container_exit;
+    }
     }
=20
     vfio_kvm_device_add_group(group);
--=20
2.20.1
