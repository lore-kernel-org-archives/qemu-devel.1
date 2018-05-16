Received: from eggs.gnu.org ([2001:4830:134:3::10]:54110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fIyFn-0007pN-2k
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fIyFl-0005mn-Ij
	for qemu-devel@nongnu.org; Wed, 16 May 2018 11:22:11 -0400
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Date: Wed, 16 May 2018 16:20:21 +0100
Message-ID: <20180516152026.2920-2-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v2 1/6] hw/vfio: Retrieve valid iova ranges from
 kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: drjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, eric.auger@redhat.com, zhaoshenglong@huawei.com, jonathan.cameron@huawei.com, linuxarm@huawei.com, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

This makes use of the newly introduced iova cap chains added
to the  type1 VFIO_IOMMU_GET_INFO ioctl.

The retrieved iova info is stored in a list for later use.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/vfio/common.c              | 108 +++++++++++++++++++++++++++++++++++++++---
 include/hw/vfio/vfio-common.h |   7 +++
 linux-headers/linux/vfio.h    |  23 +++++++++
 3 files changed, 132 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 07ffa0b..94d7b24 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -40,6 +40,8 @@ struct vfio_group_head vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
 struct vfio_as_head vfio_address_spaces =
     QLIST_HEAD_INITIALIZER(vfio_address_spaces);
+struct vfio_iova_head vfio_iova_regions =
+    QLIST_HEAD_INITIALIZER(vfio_iova_regions);
 
 #ifdef CONFIG_KVM
 /*
@@ -1030,6 +1032,85 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
     }
 }
 
+static void vfio_iommu_get_iova_ranges(struct vfio_iommu_type1_info *info)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_iommu_type1_info_cap_iova_range *cap_iova;
+    VFIOIovaRange *iova, *tmp, *prev = NULL;
+    void *ptr = info;
+    bool found = false;
+    int i;
+
+    if (!(info->flags & VFIO_IOMMU_INFO_CAPS)) {
+        return;
+    }
+
+    for (hdr = ptr + info->cap_offset; hdr != ptr; hdr = ptr + hdr->next) {
+        if (hdr->id == VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE) {
+            found = true;
+            break;
+        }
+    }
+
+    if (!found) {
+        return;
+    }
+
+    /* purge the current iova list, if any */
+    QLIST_FOREACH_SAFE(iova, &vfio_iova_regions, next, tmp) {
+        QLIST_REMOVE(iova, next);
+        g_free(iova);
+    }
+
+    cap_iova = container_of(hdr, struct vfio_iommu_type1_info_cap_iova_range,
+                            header);
+
+    /* populate the list */
+    for (i = 0; i < cap_iova->nr_iovas; i++) {
+        iova = g_malloc0(sizeof(*iova));
+        iova->start = cap_iova->iova_ranges[i].start;
+        iova->end = cap_iova->iova_ranges[i].end;
+
+        if (prev) {
+            QLIST_INSERT_AFTER(prev, iova, next);
+        } else {
+            QLIST_INSERT_HEAD(&vfio_iova_regions, iova, next);
+        }
+        prev = iova;
+    }
+
+    return;
+}
+
+static int vfio_get_iommu_info(VFIOContainer *container,
+                         struct vfio_iommu_type1_info **info)
+{
+
+    size_t argsz = sizeof(struct vfio_iommu_type1_info);
+
+
+    *info = g_malloc0(argsz);
+
+retry:
+    (*info)->argsz = argsz;
+
+    if (ioctl(container->fd, VFIO_IOMMU_GET_INFO, *info)) {
+        g_free(*info);
+        *info = NULL;
+        return -errno;
+    }
+
+    if (((*info)->argsz > argsz)) {
+        argsz = (*info)->argsz;
+        *info = g_realloc(*info, argsz);
+        goto retry;
+    }
+
+    vfio_iommu_get_iova_ranges(*info);
+
+    return 0;
+}
+
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                   Error **errp)
 {
@@ -1044,6 +1125,15 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
             group->container = container;
             QLIST_INSERT_HEAD(&container->group_list, group, container_next);
             vfio_kvm_device_add_group(group);
+
+            /* New group might change the valid iovas. Get the updated list */
+            if ((container->iommu_type == VFIO_TYPE1_IOMMU) ||
+                (container->iommu_type == VFIO_TYPE1v2_IOMMU)) {
+                struct vfio_iommu_type1_info *info;
+
+                vfio_get_iommu_info(container, &info);
+                g_free(info);
+            }
             return 0;
         }
     }
@@ -1071,7 +1161,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU) ||
         ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
         bool v2 = !!ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU);
-        struct vfio_iommu_type1_info info;
+        struct vfio_iommu_type1_info *info;
 
         ret = ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &fd);
         if (ret) {
@@ -1095,14 +1185,14 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
          * existing Type1 IOMMUs generally support any IOVA we're
          * going to actually try in practice.
          */
-        info.argsz = sizeof(info);
-        ret = ioctl(fd, VFIO_IOMMU_GET_INFO, &info);
+        ret = vfio_get_iommu_info(container, &info);
         /* Ignore errors */
-        if (ret || !(info.flags & VFIO_IOMMU_INFO_PGSIZES)) {
+        if (ret || !(info->flags & VFIO_IOMMU_INFO_PGSIZES)) {
             /* Assume 4k IOVA page size */
-            info.iova_pgsizes = 4096;
+            info->iova_pgsizes = 4096;
         }
-        vfio_host_win_add(container, 0, (hwaddr)-1, info.iova_pgsizes);
+        vfio_host_win_add(container, 0, (hwaddr)-1, info->iova_pgsizes);
+        g_free(info);
     } else if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_IOMMU) ||
                ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_SPAPR_TCE_v2_IOMMU)) {
         struct vfio_iommu_spapr_tce_info info;
@@ -1256,6 +1346,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
     if (QLIST_EMPTY(&container->group_list)) {
         VFIOAddressSpace *space = container->space;
         VFIOGuestIOMMU *giommu, *tmp;
+        VFIOIovaRange *iova, *next_iova;
 
         QLIST_REMOVE(container, next);
 
@@ -1266,6 +1357,11 @@ static void vfio_disconnect_container(VFIOGroup *group)
             g_free(giommu);
         }
 
+        QLIST_FOREACH_SAFE(iova, &vfio_iova_regions, next, next_iova) {
+            QLIST_REMOVE(iova, next);
+            g_free(iova);
+        }
+
         trace_vfio_disconnect_container(container->fd);
         close(container->fd);
         g_free(container);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index d936014..874fe2c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -164,6 +164,12 @@ typedef struct VFIODisplay {
     } dmabuf;
 } VFIODisplay;
 
+typedef struct VFIOIovaRange {
+    uint64_t start;
+    uint64_t end;
+    QLIST_ENTRY(VFIOIovaRange) next;
+} VFIOIovaRange;
+
 void vfio_put_base_device(VFIODevice *vbasedev);
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
@@ -187,6 +193,7 @@ int vfio_get_device(VFIOGroup *group, const char *name,
 extern const MemoryRegionOps vfio_region_ops;
 extern QLIST_HEAD(vfio_group_head, VFIOGroup) vfio_group_list;
 extern QLIST_HEAD(vfio_as_head, VFIOAddressSpace) vfio_address_spaces;
+extern QLIST_HEAD(vfio_iova_head, VFIOIovaRange) vfio_iova_regions;
 
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 3a0a305..117341d 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -589,7 +589,30 @@ struct vfio_iommu_type1_info {
 	__u32	argsz;
 	__u32	flags;
 #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
+#define VFIO_IOMMU_INFO_CAPS	(1 << 1)	/* Info supports caps */
 	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
+	__u32   cap_offset;	/* Offset within info struct of first cap */
+};
+
+/*
+ * The IOVA capability allows to report the valid IOVA range(s)
+ * excluding any reserved regions associated with dev group. Any dma
+ * map attempt outside the valid iova range will return error.
+ *
+ * The structures below define version 1 of this capability.
+ */
+#define VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE  1
+
+struct vfio_iova_range {
+	__u64	start;
+	__u64	end;
+};
+
+struct vfio_iommu_type1_info_cap_iova_range {
+	struct vfio_info_cap_header header;
+	__u32	nr_iovas;
+	__u32	reserved;
+	struct vfio_iova_range iova_ranges[];
 };
 
 #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
-- 
2.7.4
