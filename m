Received: from eggs.gnu.org ([2001:4830:134:3::10]:39361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1esj67-00051m-3m
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 00:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1esj66-0008Gq-5A
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 00:55:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:54640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1esj65-0008E6-SW
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 00:55:42 -0500
From: Yulei Zhang <yulei.zhang@intel.com>
Date: Mon,  5 Mar 2018 14:00:53 +0800
Message-Id: <1520229653-10658-5-git-send-email-yulei.zhang@intel.com>
In-Reply-To: <1520229653-10658-1-git-send-email-yulei.zhang@intel.com>
References: <1520229653-10658-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [PATCH V3 4/4] vifo: introduce new VFIO ioctl
 VFIO_IOMMU_GET_DIRTY_BITMAP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kevin.tian@intel.com, zhenyuw@linux.intel.com, kwankhede@nvidia.com, alex.williamson@redhat.com, Yulei Zhang <yulei.zhang@intel.com>

New VFIO ioctl VFIO_IOMMU_GET_DIRTY_BITMAP is used to fetch the
bitmap of pinned memory in iommu container, we need copy those
memory to the target during the migration as they are dirtied by
mdev devices.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 hw/vfio/common.c           | 34 ++++++++++++++++++++++++++++++++++
 linux-headers/linux/vfio.h | 14 ++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7b2924c..a952554 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -35,6 +35,7 @@
 #include "sysemu/kvm.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "exec/ram_addr.h"
 
 struct vfio_group_head vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
@@ -624,9 +625,42 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 }
 
+static void vfio_log_sync(MemoryListener *listener,
+                          MemoryRegionSection *section)
+{
+    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
+    VFIOGroup *group = QLIST_FIRST(&container->group_list);
+    VFIODevice *vbasedev;
+    QLIST_FOREACH(vbasedev, &group->device_list, next) {
+        if (vbasedev->device_state == VFIO_DEVICE_START) {
+            return;
+        }
+    }
+
+    struct vfio_iommu_get_dirty_bitmap *d;
+    ram_addr_t size = int128_get64(section->size);
+    unsigned long page_nr = size >> TARGET_PAGE_BITS;
+    unsigned long bitmap_size =
+                    (BITS_TO_LONGS(page_nr) + 1) * sizeof(unsigned long);
+    d = g_malloc0(sizeof(*d) + bitmap_size);
+    d->start_addr = section->offset_within_address_space;
+    d->page_nr = page_nr;
+
+    if (ioctl(container->fd, VFIO_IOMMU_GET_DIRTY_BITMAP, d)) {
+        error_report("vfio: Failed to fetch dirty pages for migration");
+        goto exit;
+    }
+
+    cpu_physical_memory_set_dirty_lebitmap((unsigned long *)&d->dirty_bitmap,
+                                           d->start_addr, d->page_nr);
+exit:
+    g_free(d);
+}
+
 static const MemoryListener vfio_memory_listener = {
     .region_add = vfio_listener_region_add,
     .region_del = vfio_listener_region_del,
+    .log_sync = vfio_log_sync,
 };
 
 static void vfio_listener_release(VFIOContainer *container)
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 4451a8f..a41f73b 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -574,6 +574,20 @@ struct vfio_iommu_type1_dma_unmap {
 #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
 #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
 
+/**
+ * VFIO_IOMMU_GET_DIRTY_BITMAP - _IOW(VFIO_TYPE, VFIO_BASE + 17,
+ *				    struct vfio_iommu_get_dirty_bitmap)
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct vfio_iommu_get_dirty_bitmap {
+	__u64	       start_addr;
+	__u64	       page_nr;
+	__u8           dirty_bitmap[];
+};
+
+#define VFIO_IOMMU_GET_DIRTY_BITMAP _IO(VFIO_TYPE, VFIO_BASE + 17)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
2.7.4
