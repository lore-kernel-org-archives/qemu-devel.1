Received: from eggs.gnu.org ([2001:4830:134:3::10]:53732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eUzzo-0001ZZ-BQ
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eUzzk-0004TP-7g
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:07:08 -0500
Received: from [45.249.212.32] (port=56510 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eUzzj-0004RF-BN
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 14:07:04 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Sat, 30 Dec 2017 03:06:00 +0800
Message-ID: <1514574360-31788-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4] vhost: set used memslots for vhost-user and
 vhost-kernel respectively
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, jianjay.zhou@huawei.com, Zhe Liu <gary.liuzhe@huawei.com>

Used_memslots is equal to dev->mem->nregions now, it is true for
vhost kernel, but not for vhost user, which uses the memory regions
that have file descriptor. In fact, not all of the memory regions
have file descriptor.
It is usefully in some scenarios, e.g. used_memslots is 8, and only
5 memory slots can be used by vhost user, it is failed to hotplug
a new DIMM memory because vhost_has_free_slot just returned false,
however we can hotplug it safely in fact.

Meanwhile, instead of asserting in vhost_user_set_mem_table(),
error number is used to gracefully prevent device to start. This
fixed the VM crash issue.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
Signed-off-by: Zhe Liu <gary.liuzhe@huawei.com>
---
 hw/virtio/vhost-backend.c         | 15 +++++++-
 hw/virtio/vhost-user.c            | 73 +++++++++++++++++++++++++++------------
 hw/virtio/vhost.c                 | 18 +++++-----
 include/hw/virtio/vhost-backend.h |  6 ++--
 4 files changed, 77 insertions(+), 35 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 7f09efa..59def69 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -15,6 +15,8 @@
 #include "hw/virtio/vhost-backend.h"
 #include "qemu/error-report.h"
 
+static unsigned int vhost_kernel_used_memslots;
+
 static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int request,
                              void *arg)
 {
@@ -62,6 +64,11 @@ static int vhost_kernel_memslots_limit(struct vhost_dev *dev)
     return limit;
 }
 
+static bool vhost_kernel_has_free_memslots(struct vhost_dev *dev)
+{
+    return vhost_kernel_used_memslots < vhost_kernel_memslots_limit(dev);
+}
+
 static int vhost_kernel_net_set_backend(struct vhost_dev *dev,
                                         struct vhost_vring_file *file)
 {
@@ -233,11 +240,16 @@ static void vhost_kernel_set_iotlb_callback(struct vhost_dev *dev,
         qemu_set_fd_handler((uintptr_t)dev->opaque, NULL, NULL, NULL);
 }
 
+static void vhost_kernel_set_used_memslots(struct vhost_dev *dev)
+{
+    vhost_kernel_used_memslots = dev->mem->nregions;
+}
+
 static const VhostOps kernel_ops = {
         .backend_type = VHOST_BACKEND_TYPE_KERNEL,
         .vhost_backend_init = vhost_kernel_init,
         .vhost_backend_cleanup = vhost_kernel_cleanup,
-        .vhost_backend_memslots_limit = vhost_kernel_memslots_limit,
+        .vhost_backend_has_free_memslots = vhost_kernel_has_free_memslots,
         .vhost_net_set_backend = vhost_kernel_net_set_backend,
         .vhost_scsi_set_endpoint = vhost_kernel_scsi_set_endpoint,
         .vhost_scsi_clear_endpoint = vhost_kernel_scsi_clear_endpoint,
@@ -264,6 +276,7 @@ static const VhostOps kernel_ops = {
 #endif /* CONFIG_VHOST_VSOCK */
         .vhost_set_iotlb_callback = vhost_kernel_set_iotlb_callback,
         .vhost_send_device_iotlb_msg = vhost_kernel_send_device_iotlb_msg,
+        .vhost_set_used_memslots = vhost_kernel_set_used_memslots,
 };
 
 int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType backend_type)
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 093675e..3fa5531 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -122,6 +122,8 @@ static VhostUserMsg m __attribute__ ((unused));
 /* The version of the protocol we support */
 #define VHOST_USER_VERSION    (0x1)
 
+static bool vhost_user_free_memslots = true;
+
 struct vhost_user {
     CharBackend *chr;
     int slave_fd;
@@ -289,12 +291,42 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
     return 0;
 }
 
+static int vhost_user_prepare_msg(struct vhost_dev *dev, VhostUserMemory *mem,
+                                  int *fds)
+{
+    int i, fd;
+
+    for (i = 0, mem->nregions = 0; i < dev->mem->nregions; ++i) {
+        struct vhost_memory_region *reg = dev->mem->regions + i;
+        ram_addr_t offset;
+        MemoryRegion *mr;
+
+        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
+        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
+                                     &offset);
+        fd = memory_region_get_fd(mr);
+        if (fd > 0) {
+            if (mem->nregions == VHOST_MEMORY_MAX_NREGIONS) {
+                vhost_user_free_memslots = false;
+                return -1;
+            }
+
+            mem->regions[mem->nregions].userspace_addr = reg->userspace_addr;
+            mem->regions[mem->nregions].memory_size = reg->memory_size;
+            mem->regions[mem->nregions].guest_phys_addr = reg->guest_phys_addr;
+            mem->regions[mem->nregions].mmap_offset = offset;
+            fds[mem->nregions++] = fd;
+        }
+    }
+
+    return 0;
+}
+
 static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                     struct vhost_memory *mem)
 {
     int fds[VHOST_MEMORY_MAX_NREGIONS];
-    int i, fd;
-    size_t fd_num = 0;
+    size_t fd_num;
     bool reply_supported = virtio_has_feature(dev->protocol_features,
                                               VHOST_USER_PROTOCOL_F_REPLY_ACK);
 
@@ -307,26 +339,12 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
         msg.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
-    for (i = 0; i < dev->mem->nregions; ++i) {
-        struct vhost_memory_region *reg = dev->mem->regions + i;
-        ram_addr_t offset;
-        MemoryRegion *mr;
-
-        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
-        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
-                                     &offset);
-        fd = memory_region_get_fd(mr);
-        if (fd > 0) {
-            msg.payload.memory.regions[fd_num].userspace_addr = reg->userspace_addr;
-            msg.payload.memory.regions[fd_num].memory_size  = reg->memory_size;
-            msg.payload.memory.regions[fd_num].guest_phys_addr = reg->guest_phys_addr;
-            msg.payload.memory.regions[fd_num].mmap_offset = offset;
-            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
-            fds[fd_num++] = fd;
-        }
+    if (vhost_user_prepare_msg(dev, &msg.payload.memory, fds) < 0) {
+        error_report("Failed preparing vhost-user memory table msg");
+        return -1;
     }
 
-    msg.payload.memory.nregions = fd_num;
+    fd_num = msg.payload.memory.nregions;
 
     if (!fd_num) {
         error_report("Failed initializing vhost-user memory map, "
@@ -815,9 +833,9 @@ static int vhost_user_get_vq_index(struct vhost_dev *dev, int idx)
     return idx;
 }
 
-static int vhost_user_memslots_limit(struct vhost_dev *dev)
+static bool vhost_user_has_free_memslots(struct vhost_dev *dev)
 {
-    return VHOST_MEMORY_MAX_NREGIONS;
+    return vhost_user_free_memslots;
 }
 
 static bool vhost_user_requires_shm_log(struct vhost_dev *dev)
@@ -922,11 +940,19 @@ static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
     /* No-op as the receive channel is not dedicated to IOTLB messages. */
 }
 
+static void vhost_user_set_used_memslots(struct vhost_dev *dev)
+{
+    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    VhostUserMsg msg;
+
+    vhost_user_prepare_msg(dev, &msg.payload.memory, fds);
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_init,
         .vhost_backend_cleanup = vhost_user_cleanup,
-        .vhost_backend_memslots_limit = vhost_user_memslots_limit,
+        .vhost_backend_has_free_memslots = vhost_user_has_free_memslots,
         .vhost_set_log_base = vhost_user_set_log_base,
         .vhost_set_mem_table = vhost_user_set_mem_table,
         .vhost_set_vring_addr = vhost_user_set_vring_addr,
@@ -948,4 +974,5 @@ const VhostOps user_ops = {
         .vhost_net_set_mtu = vhost_user_net_set_mtu,
         .vhost_set_iotlb_callback = vhost_user_set_iotlb_callback,
         .vhost_send_device_iotlb_msg = vhost_user_send_device_iotlb_msg,
+        .vhost_set_used_memslots = vhost_user_set_used_memslots,
 };
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e4290ce..1e52825 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -43,20 +43,20 @@
 static struct vhost_log *vhost_log;
 static struct vhost_log *vhost_log_shm;
 
-static unsigned int used_memslots;
 static QLIST_HEAD(, vhost_dev) vhost_devices =
     QLIST_HEAD_INITIALIZER(vhost_devices);
 
 bool vhost_has_free_slot(void)
 {
-    unsigned int slots_limit = ~0U;
     struct vhost_dev *hdev;
 
     QLIST_FOREACH(hdev, &vhost_devices, entry) {
-        unsigned int r = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
-        slots_limit = MIN(slots_limit, r);
+        if (!hdev->vhost_ops->vhost_backend_has_free_memslots(hdev)) {
+            return false;
+        }
     }
-    return slots_limit > used_memslots;
+
+    return true;
 }
 
 static void vhost_dev_sync_region(struct vhost_dev *dev,
@@ -606,7 +606,7 @@ static void vhost_set_memory(MemoryListener *listener,
     dev->mem_changed_start_addr = MIN(dev->mem_changed_start_addr, start_addr);
     dev->mem_changed_end_addr = MAX(dev->mem_changed_end_addr, start_addr + size - 1);
     dev->memory_changed = true;
-    used_memslots = dev->mem->nregions;
+    dev->vhost_ops->vhost_set_used_memslots(dev);
 }
 
 static bool vhost_section(MemoryRegionSection *section)
@@ -1251,9 +1251,9 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    if (used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
-        error_report("vhost backend memory slots limit is less"
-                " than current number of present memory slots");
+    if (!hdev->vhost_ops->vhost_backend_has_free_memslots(hdev)) {
+        error_report("vhost backend memory slots limit is less than "
+                     "current number of present memory slots");
         r = -1;
         goto fail;
     }
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index a7a5f22..ea01d5f 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -31,7 +31,7 @@ struct vhost_iotlb_msg;
 
 typedef int (*vhost_backend_init)(struct vhost_dev *dev, void *opaque);
 typedef int (*vhost_backend_cleanup)(struct vhost_dev *dev);
-typedef int (*vhost_backend_memslots_limit)(struct vhost_dev *dev);
+typedef bool (*vhost_backend_has_free_memslots)(struct vhost_dev *dev);
 
 typedef int (*vhost_net_set_backend_op)(struct vhost_dev *dev,
                                 struct vhost_vring_file *file);
@@ -84,12 +84,13 @@ typedef void (*vhost_set_iotlb_callback_op)(struct vhost_dev *dev,
                                            int enabled);
 typedef int (*vhost_send_device_iotlb_msg_op)(struct vhost_dev *dev,
                                               struct vhost_iotlb_msg *imsg);
+typedef void (*vhost_set_used_memslots_op)(struct vhost_dev *dev);
 
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
     vhost_backend_cleanup vhost_backend_cleanup;
-    vhost_backend_memslots_limit vhost_backend_memslots_limit;
+    vhost_backend_has_free_memslots vhost_backend_has_free_memslots;
     vhost_net_set_backend_op vhost_net_set_backend;
     vhost_net_set_mtu_op vhost_net_set_mtu;
     vhost_scsi_set_endpoint_op vhost_scsi_set_endpoint;
@@ -118,6 +119,7 @@ typedef struct VhostOps {
     vhost_vsock_set_running_op vhost_vsock_set_running;
     vhost_set_iotlb_callback_op vhost_set_iotlb_callback;
     vhost_send_device_iotlb_msg_op vhost_send_device_iotlb_msg;
+    vhost_set_used_memslots_op vhost_set_used_memslots;
 } VhostOps;
 
 extern const VhostOps user_ops;
-- 
1.8.3.1
