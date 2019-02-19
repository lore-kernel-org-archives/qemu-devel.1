Received: from eggs.gnu.org ([209.51.188.92]:33561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gwCyg-0006Oa-Qc
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1gwCyg-0005oP-47
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:30:58 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17003)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1gwCyf-0005nZ-3A
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 16:30:58 -0500
From: Kirti Wankhede <kwankhede@nvidia.com>
Date: Wed, 20 Feb 2019 02:53:19 +0530
Message-ID: <1550611400-13703-5-git-send-email-kwankhede@nvidia.com>
In-Reply-To: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
References: <1550611400-13703-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 4/5] Add vfio_listerner_log_sync to mark
 dirty pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.williamson@redhat.com, cjia@nvidia.com
Cc: kevin.tian@intel.com, ziye.yang@intel.com, changpeng.liu@intel.com, yi.l.liu@intel.com, mlevitsk@redhat.com, eskultet@redhat.com, cohuck@redhat.com, dgilbert@redhat.com, jonathan.davies@nutanix.com, eauger@redhat.com, aik@ozlabs.ru, pasic@linux.ibm.com, felipe@nutanix.com, Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com, Ken.Xue@amd.com, zhi.a.wang@intel.com, yan.y.zhao@intel.com, yulei.zhang@intel.com, qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>

vfio_listerner_log_sync gets list of dirty pages from vendor driver and mark
those pages dirty.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
---
 hw/vfio/common.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4262b80c4450..84ba6808f7d0 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -36,6 +36,7 @@
 #include "sysemu/kvm.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "migration/migration.h"
 
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
@@ -698,9 +699,39 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 }
 
+static void vfio_listerner_log_sync(MemoryListener *listener,
+                                    MemoryRegionSection *section)
+{
+    uint64_t start_addr, size, pfn_count;
+    VFIOGroup *group;
+    VFIODevice *vbasedev;
+
+    QLIST_FOREACH(group, &vfio_group_list, next) {
+        QLIST_FOREACH(vbasedev, &group->device_list, next) {
+            if (vbasedev->device_state & VFIO_DEVICE_STATE_SAVING) {
+                continue;
+            } else {
+                return;
+            }
+        }
+    }
+
+    start_addr = TARGET_PAGE_ALIGN(section->offset_within_address_space);
+    size = int128_get64(section->size);
+    pfn_count = size >> TARGET_PAGE_BITS;
+
+    QLIST_FOREACH(group, &vfio_group_list, next) {
+        QLIST_FOREACH(vbasedev, &group->device_list, next) {
+            vfio_get_dirty_page_list(vbasedev, start_addr >> TARGET_PAGE_BITS,
+                                     pfn_count, TARGET_PAGE_SIZE);
+        }
+    }
+}
+
 static const MemoryListener vfio_memory_listener = {
     .region_add = vfio_listener_region_add,
     .region_del = vfio_listener_region_del,
+    .log_sync = vfio_listerner_log_sync,
 };
 
 static void vfio_listener_release(VFIOContainer *container)
-- 
2.7.0
