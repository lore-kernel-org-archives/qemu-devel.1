Received: from eggs.gnu.org ([209.51.188.92]:55682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gw192-0002tU-US
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:52:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gw190-0001B8-VM
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:52:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:25125)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1gw18z-00019y-01
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:52:50 -0500
From: Yan Zhao <yan.y.zhao@intel.com>
Date: Tue, 19 Feb 2019 16:52:41 +0800
Message-Id: <1550566361-3697-1-git-send-email-yan.y.zhao@intel.com>
In-Reply-To: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
References: <1550566254-3545-1-git-send-email-yan.y.zhao@intel.com>
Subject: [Qemu-devel] [PATCH 3/5] vfio/migration: tracking of dirty page in
 system memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, qemu-devel@nongnu.org
Cc: intel-gvt-dev@lists.freedesktop.org, Zhengxiao.zx@Alibaba-inc.com, yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com, changpeng.liu@intel.com, Ken.Xue@amd.com, kwankhede@nvidia.com, kevin.tian@intel.com, cjia@nvidia.com, arei.gonglei@huawei.com, kvm@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>

register the log_sync interface to hook into ram's live migration
callbacks.

ram_save_pending
   |->migration_bitmap_sync
       |->memory_global_dirty_log_sync
           |->memory_region_sync_dirty_bitmap
               |->listener->log_sync(listener, &mrs);

So, the dirty page produced by vfio device in system memory will be
save/load by ram's live migration code iteratively.

Bitmap of device's dirty page in system memory is retrieved from Dirty Bitmap
Region

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 hw/vfio/common.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7c185e5a..719e750 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -27,6 +27,7 @@
 
 #include "hw/vfio/vfio-common.h"
 #include "hw/vfio/vfio.h"
+#include "hw/vfio/pci.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "hw/hw.h"
@@ -698,9 +699,34 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 }
 
+static void vfio_log_sync(MemoryListener *listener,
+                          MemoryRegionSection *section)
+{
+    VFIOContainer *container = container_of(listener, VFIOContainer, listener);
+    VFIOGroup *group = QLIST_FIRST(&container->group_list);
+    VFIODevice *vbasedev;
+    VFIOPCIDevice *vdev;
+
+    ram_addr_t size = int128_get64(section->size);
+    uint64_t page_nr = size >> TARGET_PAGE_BITS;
+    uint64_t start_addr = section->offset_within_address_space;
+
+    QLIST_FOREACH(vbasedev, &group->device_list, next) {
+        vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+        if (!vdev->migration ||
+                !vfio_device_data_cap_system_memory(vdev) ||
+                !(vdev->migration->device_state & VFIO_DEVICE_STATE_LOGGING)) {
+            continue;
+        }
+
+        vfio_set_dirty_page_bitmap(vdev, start_addr, page_nr);
+    }
+}
+
 static const MemoryListener vfio_memory_listener = {
     .region_add = vfio_listener_region_add,
     .region_del = vfio_listener_region_del,
+    .log_sync = vfio_log_sync,
 };
 
 static void vfio_listener_release(VFIOContainer *container)
-- 
2.7.4
