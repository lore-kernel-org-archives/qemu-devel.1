Received: from eggs.gnu.org ([209.51.188.92]:49879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gx3TL-0002FV-BN
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gx3TJ-0004oH-Ug
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:34:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gx3TJ-0004if-A5
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:34:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AF1A3688B
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 05:33:57 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 21 Feb 2019 22:33:57 -0700
Message-ID: <155081363698.23160.8018986798435862933.stgit@gimli.home>
In-Reply-To: <155081340903.23160.4034617687275790161.stgit@gimli.home>
References: <155081340903.23160.4034617687275790161.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 2/2] hw/vfio/common: Refactor container
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

We introduce the vfio_init_container_type() helper.
It computes the highest usable iommu type and then
set the container and the iommu type.

Its usage in vfio_connect_container() makes the code
ready for addition of new iommu types.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c |  114 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 44 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 9c3796e7db43..df2b4721bffb 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1054,6 +1054,60 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
     }
 }
 
+/*
+ * vfio_get_iommu_type - selects the richest iommu_type (v2 first)
+ */
+static int vfio_get_iommu_type(VFIOContainer *container,
+                               Error **errp)
+{
+    int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
+                          VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU };
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(iommu_types); i++) {
+        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
+            return iommu_types[i];
+        }
+    }
+    error_setg(errp, "No available IOMMU models");
+    return -EINVAL;
+}
+
+static int vfio_init_container(VFIOContainer *container, int group_fd,
+                               Error **errp)
+{
+    int iommu_type, ret;
+
+    iommu_type = vfio_get_iommu_type(container, errp);
+    if (iommu_type < 0) {
+        return iommu_type;
+    }
+
+    ret = ioctl(group_fd, VFIO_GROUP_SET_CONTAINER, &container->fd);
+    if (ret) {
+        error_setg_errno(errp, errno, "Failed to set group container");
+        return -errno;
+    }
+
+    while (ioctl(container->fd, VFIO_SET_IOMMU, iommu_type)) {
+        if (iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
+            /*
+             * On sPAPR, despite the IOMMU subdriver always advertises v1 and
+             * v2, the running platform may not support v2 and there is no
+             * way to guess it until an IOMMU group gets added to the container.
+             * So in case it fails with v2, try v1 as a fallback.
+             */
+            iommu_type = VFIO_SPAPR_TCE_IOMMU;
+            continue;
+        }
+        error_setg_errno(errp, errno, "Failed to set iommu for container");
+        return -errno;
+    }
+
+    container->iommu_type = iommu_type;
+    return 0;
+}
+
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                   Error **errp)
 {
@@ -1119,25 +1173,17 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->fd = fd;
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
-    if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
-        ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
-        bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU);
-        struct vfio_iommu_type1_info info;
 
-        ret = ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &fd);
-        if (ret) {
-            error_setg_errno(errp, errno, "failed to set group container");
-            ret = -errno;
-            goto free_container_exit;
-        }
+    ret = vfio_init_container(container, group->fd, errp);
+    if (ret) {
+        goto free_container_exit;
+    }
 
-        container->iommu_type = v2 ? VFIO_TYPE1v2_IOMMU : VFIO_TYPE1_IOMMU;
-        ret = ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
-        if (ret) {
-            error_setg_errno(errp, errno, "failed to set iommu for container");
-            ret = -errno;
-            goto free_container_exit;
-        }
+    switch (container->iommu_type) {
+    case VFIO_TYPE1v2_IOMMU:
+    case VFIO_TYPE1_IOMMU:
+    {
+        struct vfio_iommu_type1_info info;
 
         /*
          * FIXME: This assumes that a Type1 IOMMU can map any 64-bit
@@ -1155,30 +1201,13 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         }
         vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
         container->pgsizes = info.iova_pgsizes;
-    } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU) ||
-               ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU)) {
+        break;
+    }
+    case VFIO_SPAPR_TCE_v2_IOMMU:
+    case VFIO_SPAPR_TCE_IOMMU:
+    {
         struct vfio_iommu_spapr_tce_info info;
-        bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU);
-
-        ret = ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &fd);
-        if (ret) {
-            error_setg_errno(errp, errno, "failed to set group container");
-            ret = -errno;
-            goto free_container_exit;
-        }
-        container->iommu_type =
-            v2 ? VFIO_SPAPR_TCE_v2_IOMMU : VFIO_SPAPR_TCE_IOMMU;
-        ret = ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
-        if (ret) {
-            container->iommu_type = VFIO_SPAPR_TCE_IOMMU;
-            v2 = false;
-            ret = ioctl(fd, VFIO_SET_IOMMU, container->iommu_type);
-        }
-        if (ret) {
-            error_setg_errno(errp, errno, "failed to set iommu for container");
-            ret = -errno;
-            goto free_container_exit;
-        }
+        bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
 
         /*
          * The host kernel code implementing VFIO_IOMMU_DISABLE is called
@@ -1240,10 +1269,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                               info.dma32_window_size - 1,
                               0x1000);
         }
-    } else {
-        error_setg(errp, "No available IOMMU models");
-        ret = -EINVAL;
-        goto free_container_exit;
+    }
     }
 
     vfio_kvm_device_add_group(group);
