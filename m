Received: from eggs.gnu.org ([2001:4830:134:3::10]:35198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhuyijun@huawei.com>) id 1eEPpt-0002XC-2t
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 20:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhuyijun@huawei.com>) id 1eEPpo-0003ck-Po
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 20:16:21 -0500
From: <zhuyijun@huawei.com>
Date: Tue, 14 Nov 2017 09:15:50 +0800
Message-ID: <1510622154-17224-2-git-send-email-zhuyijun@huawei.com>
In-Reply-To: <1510622154-17224-1-git-send-email-zhuyijun@huawei.com>
References: <1510622154-17224-1-git-send-email-zhuyijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 1/5] hw/vfio: Add function for getting
 reserved_region of device iommu group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com
Cc: peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, zhaoshenglong@huawei.com

From: Zhu Yijun <zhuyijun@huawei.com>

With kernel 4.11, iommu/smmu will populate the MSI IOVA reserved window and
PCI reserved window which has to be excluded from Guest iova allocations.

However, If it falls within the Qemu default virtual memory address space,
then reserved regions may get allocated for a Guest VF DMA iova and it will
fail.

So get those reserved regions in this patch and create some holes in the Qemu
ram address in next patchset.

Signed-off-by: Zhu Yijun <zhuyijun@huawei.com>
---
 hw/vfio/common.c              | 67 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 |  2 ++
 hw/vfio/platform.c            |  2 ++
 include/exec/memory.h         |  7 +++++
 include/hw/vfio/vfio-common.h |  3 ++
 5 files changed, 81 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7b2924c..01bdbbd 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -40,6 +40,8 @@ struct vfio_group_head vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
 struct vfio_as_head vfio_address_spaces =
     QLIST_HEAD_INITIALIZER(vfio_address_spaces);
+struct reserved_ram_head reserved_ram_regions =
+    QLIST_HEAD_INITIALIZER(reserved_ram_regions);
 
 #ifdef CONFIG_KVM
 /*
@@ -52,6 +54,71 @@ struct vfio_as_head vfio_address_spaces =
 static int vfio_kvm_device_fd = -1;
 #endif
 
+void update_reserved_regions(hwaddr addr, hwaddr size)
+{
+    RAMRegion *reg, *new;
+
+    new = g_new(RAMRegion, 1);
+    new->base = addr;
+    new->size = size;
+
+    if (QLIST_EMPTY(&reserved_ram_regions)) {
+        QLIST_INSERT_HEAD(&reserved_ram_regions, new, next);
+        return;
+    }
+
+    /* make the base of reserved_ram_regions increase */
+    QLIST_FOREACH(reg, &reserved_ram_regions, next) {
+        if (addr > (reg->base + reg->size - 1)) {
+            if (!QLIST_NEXT(reg, next)) {
+                QLIST_INSERT_AFTER(reg, new, next);
+                break;
+            }
+            continue;
+        } else if (addr >= reg->base && addr <= (reg->base + reg->size - 1)) {
+            /* discard the duplicate entry */
+            if (addr == reg->base && size == reg->size) {
+                g_free(new);
+                break;
+            } else {
+                QLIST_INSERT_AFTER(reg, new, next);
+                break;
+            }
+        } else {
+            QLIST_INSERT_BEFORE(reg, new, next);
+            break;
+        }
+    }
+}
+
+void vfio_get_iommu_group_reserved_region(char *group_path)
+{
+    char *filename;
+    FILE *fp;
+    hwaddr start, end;
+    char str[10];
+    struct stat st;
+
+    filename = g_strdup_printf("%s/iommu_group/reserved_regions", group_path);
+    if (stat(filename, &st) < 0) {
+        g_free(filename);
+        return;
+    }
+
+    fp = fopen(filename, "r");
+    if (!fp) {
+        g_free(filename);
+        return;
+    }
+
+    while (fscanf(fp, "%"PRIx64" %"PRIx64" %s", &start, &end, str) != EOF) {
+        update_reserved_regions(start, (end - start + 1));
+    }
+
+    g_free(filename);
+    fclose(fp);
+}
+
 /*
  * Common VFIO interrupt disable
  */
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c977ee3..9bffb38 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2674,6 +2674,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vdev->vbasedev.type = VFIO_DEVICE_TYPE_PCI;
     vdev->vbasedev.dev = &vdev->pdev.qdev;
 
+    vfio_get_iommu_group_reserved_region(vdev->vbasedev.sysfsdev);
+
     tmp = g_strdup_printf("%s/iommu_group", vdev->vbasedev.sysfsdev);
     len = readlink(tmp, group_path, sizeof(group_path));
     g_free(tmp);
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index da84abf..d5bbc3a 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -578,6 +578,8 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
         return -errno;
     }
 
+    vfio_get_iommu_group_reserved_region(vbasedev->sysfsdev);
+
     tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);
     len = readlink(tmp, group_path, sizeof(group_path));
     g_free(tmp);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 5ed4042..2bcc83b 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -46,6 +46,13 @@
         OBJECT_GET_CLASS(IOMMUMemoryRegionClass, (obj), \
                          TYPE_IOMMU_MEMORY_REGION)
 
+/* Scattered RAM memory region struct */
+typedef struct RAMRegion {
+    hwaddr base;
+    hwaddr size;
+    QLIST_ENTRY(RAMRegion) next;
+} RAMRegion;
+
 typedef struct MemoryRegionOps MemoryRegionOps;
 typedef struct MemoryRegionMmio MemoryRegionMmio;
 
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index f3a2ac9..3483ca6 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -161,10 +161,13 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
 void vfio_put_group(VFIOGroup *group);
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
+void update_reserved_regions(hwaddr addr, hwaddr size);
+void vfio_get_iommu_group_reserved_region(char *group_path);
 
 extern const MemoryRegionOps vfio_region_ops;
 extern QLIST_HEAD(vfio_group_head, VFIOGroup) vfio_group_list;
 extern QLIST_HEAD(vfio_as_head, VFIOAddressSpace) vfio_address_spaces;
+extern QLIST_HEAD(reserved_ram_head, RAMRegion) reserved_ram_regions;
 
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
-- 
1.8.3.1
