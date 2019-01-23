Received: from eggs.gnu.org ([209.51.188.92]:36951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmKeK-0005cl-4G
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmKeI-00043Y-Th
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:41:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1gmKeI-00042o-Lh
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:41:06 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 23 Jan 2019 16:40:35 +0100
Message-Id: <20190123154035.29425-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4] hw/vfio/common: Refactor container
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
Cc: aik@ozlabs.ru, groug@kaod.org

We introduce the vfio_init_container_type() helper.
It computes the highest usable iommu type and then
set the container and the iommu type.

Its usage in vfio_connect_container() makes the code
ready for addition of new iommu types.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- Take into account Alex' suggestions. Only exception is
  I kept v2 bool.

v2 -> v3:
- fix ret/errno

v1 -> v2:
- handle SPAPR case, s/ret/errno in error error_setg_errno,
  fix ret value when vfio_iommu_get_type fails
- removed Greg's R-b

v1:
- originally submitted in [RFC v2 00/28] vSMMUv3/pSMMUv3
  2 stage VFIO integration
---
 hw/vfio/common.c | 117 +++++++++++++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 45 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4262b80c44..eb209c776c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1036,6 +1036,61 @@ static void vfio_put_address_space(VFIOAddressSpac=
e *space)
     }
 }
=20
+/*
+ * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
+ */
+static int vfio_get_iommu_type(VFIOContainer *container,
+                               Error **errp)
+{
+    int iommu_types[] =3D { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
+                          VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU =
};
+    int fd =3D container->fd;
+    int i;
+
+    for (i =3D 0; i < ARRAY_SIZE(iommu_types); i++) {
+        if (ioctl(fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
+            return iommu_types[i];
+        }
+    }
+    error_setg(errp, "No available IOMMU models");
+    return -EINVAL;
+}
+
+static int vfio_init_container_type(VFIOContainer *container, int group_=
fd,
+                                    Error **errp)
+{
+    int iommu_type, ret;
+
+    iommu_type =3D vfio_get_iommu_type(container, errp);
+    if (iommu_type < 0) {
+        return iommu_type;
+    }
+
+    ret =3D ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd);
+    if (ret) {
+        error_setg_errno(errp, errno, "Failed to set group container");
+        return -errno;
+    }
+
+    while (ioctl(container->fd, VFIO_SET_IOMMU, iommu_type)) {
+        if (iommu_type =3D=3D VFIO_SPAPR_TCE_v2_IOMMU) {
+            /*
+             * On sPAPR, despite the IOMMU subdriver always advertises v=
1 and
+             * v2, the running platform may not support v2 and there is =
no
+             * way to guess it until an IOMMU group gets added to the co=
ntainer.
+             * So in case it fails with v2, try v1 as a fallback.
+             */
+            iommu_type =3D VFIO_SPAPR_TCE_IOMMU;
+            continue;
+        }
+        error_setg_errno(errp, errno, "Failed to set iommu for container=
");
+        return -errno;
+    }
+
+    container->iommu_type =3D iommu_type;
+    return 0;
+}
+
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                   Error **errp)
 {
@@ -1101,26 +1156,18 @@ static int vfio_connect_container(VFIOGroup *grou=
p, AddressSpace *as,
     container->fd =3D fd;
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
-    if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
-        ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
-        bool v2 =3D !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU=
);
+
+    ret =3D vfio_init_container_type(container, group->fd, errp);
+    if (ret) {
+        goto free_container_exit;
+    }
+
+    switch (container->iommu_type) {
+    case VFIO_TYPE1v2_IOMMU:
+    case VFIO_TYPE1_IOMMU:
+    {
         struct vfio_iommu_type1_info info;
=20
-        ret =3D ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &fd);
-        if (ret) {
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
-            goto free_container_exit;
-        }
-
         /*
          * FIXME: This assumes that a Type1 IOMMU can map any 64-bit
          * IOVA whatsoever.  That's not actually true, but the current
@@ -1137,30 +1184,13 @@ static int vfio_connect_container(VFIOGroup *grou=
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
-
-        ret =3D ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &fd);
-        if (ret) {
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
-            goto free_container_exit;
-        }
+        bool v2 =3D container->iommu_type =3D=3D VFIO_SPAPR_TCE_v2_IOMMU=
;
=20
         /*
          * The host kernel code implementing VFIO_IOMMU_DISABLE is calle=
d
@@ -1222,10 +1252,7 @@ static int vfio_connect_container(VFIOGroup *group=
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
