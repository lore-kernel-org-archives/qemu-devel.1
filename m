Received: from eggs.gnu.org ([2001:4830:134:3::10]:45776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1f0g0U-0003oX-72
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1f0g0R-0006MN-0D
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:14:46 -0400
Received: from [45.249.212.35] (port=60095 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1f0g0Q-0006Kx-5J
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 00:14:42 -0400
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Tue, 27 Mar 2018 12:14:06 +0800
Message-ID: <1522124046-34596-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND v10] vhost: used_memslots refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, arei.gonglei@huawei.com, jianjay.zhou@huawei.com, liuzhe13@huawei.com

Used_memslots is shared by vhost kernel and user, it is equal to
dev->mem->nregions, which is correct for vhost kernel, but not for
vhost user, the latter one uses memory regions that have file
descriptor. E.g. a VM has a vhost-user NIC and 8(vhost user memslot
upper limit) memory slots, it will be failed to hotplug a new DIMM
device since vhost_has_free_slot() finds no free slot left. It
should be successful if only part of memory slots have file
descriptor, so setting used memslots for vhost-user and
vhost-kernel respectively.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
Signed-off-by: Liuzhe <liuzhe13@huawei.com>
---

v10:
 - fix misaligned access to structures
 - refine on setting used_memslots for vhost-user to
   avoid side effect
 - distinguish "has free memslots" and "out of memslots"
v7 ... v9:
 - rebased on the master
v2 ... v6:
 - delete the "used_memslots" global variable, and add it
   for vhost-user and vhost-kernel separately
 - refine the function, commit log
 - used_memslots refactoring

 hw/virtio/vhost-backend.c         | 21 ++++++++++++++++++++-
 hw/virtio/vhost-user.c            | 36 +++++++++++++++++++++++++++++++++---
 hw/virtio/vhost.c                 | 13 ++++++-------
 include/hw/virtio/vhost-backend.h |  8 ++++++--
 4 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 7f09efa..3539b5f 100644
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
@@ -62,6 +64,21 @@ static int vhost_kernel_memslots_limit(struct vhost_dev *dev)
     return limit;
 }
 
+static void vhost_kernel_set_used_memslots(struct vhost_dev *dev)
+{
+    vhost_kernel_used_memslots = dev->mem->nregions;
+}
+
+static bool vhost_kernel_has_free_memslots(struct vhost_dev *dev)
+{
+    return vhost_kernel_used_memslots < vhost_kernel_memslots_limit(dev);
+}
+
+static bool vhost_kernel_out_of_memslots(struct vhost_dev *dev)
+{
+    return vhost_kernel_used_memslots > vhost_kernel_memslots_limit(dev);
+}
+
 static int vhost_kernel_net_set_backend(struct vhost_dev *dev,
                                         struct vhost_vring_file *file)
 {
@@ -237,7 +254,9 @@ static const VhostOps kernel_ops = {
         .backend_type = VHOST_BACKEND_TYPE_KERNEL,
         .vhost_backend_init = vhost_kernel_init,
         .vhost_backend_cleanup = vhost_kernel_cleanup,
-        .vhost_backend_memslots_limit = vhost_kernel_memslots_limit,
+        .vhost_set_used_memslots = vhost_kernel_set_used_memslots,
+        .vhost_backend_has_free_memslots = vhost_kernel_has_free_memslots,
+        .vhost_out_of_memslots = vhost_kernel_out_of_memslots,
         .vhost_net_set_backend = vhost_kernel_net_set_backend,
         .vhost_scsi_set_endpoint = vhost_kernel_scsi_set_endpoint,
         .vhost_scsi_clear_endpoint = vhost_kernel_scsi_clear_endpoint,
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 44aea5c..9691806 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -170,6 +170,8 @@ static VhostUserMsg m __attribute__ ((unused));
 /* The version of the protocol we support */
 #define VHOST_USER_VERSION    (0x1)
 
+static unsigned int vhost_user_used_memslots;
+
 struct vhost_user {
     struct vhost_dev *dev;
     CharBackend *chr;
@@ -1289,9 +1291,35 @@ static int vhost_user_get_vq_index(struct vhost_dev *dev, int idx)
     return idx;
 }
 
-static int vhost_user_memslots_limit(struct vhost_dev *dev)
+static void vhost_user_set_used_memslots(struct vhost_dev *dev)
+{
+    int i, fd;
+    unsigned int fd_num = 0;
+
+    for (i = 0; i < dev->mem->nregions; ++i) {
+        struct vhost_memory_region *reg = dev->mem->regions + i;
+        ram_addr_t offset;
+        MemoryRegion *mr;
+
+        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
+        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
+                                     &offset);
+        fd = memory_region_get_fd(mr);
+        if (fd > 0) {
+            fd_num++;
+        }
+    }
+    vhost_user_used_memslots = fd_num;
+}
+
+static bool vhost_user_has_free_memslots(struct vhost_dev *dev)
+{
+    return vhost_user_used_memslots < VHOST_MEMORY_MAX_NREGIONS;
+}
+
+static bool vhost_user_out_of_memslots(struct vhost_dev *dev)
 {
-    return VHOST_MEMORY_MAX_NREGIONS;
+    return vhost_user_used_memslots > VHOST_MEMORY_MAX_NREGIONS;
 }
 
 static bool vhost_user_requires_shm_log(struct vhost_dev *dev)
@@ -1563,7 +1591,9 @@ const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_init,
         .vhost_backend_cleanup = vhost_user_cleanup,
-        .vhost_backend_memslots_limit = vhost_user_memslots_limit,
+        .vhost_set_used_memslots = vhost_user_set_used_memslots,
+        .vhost_backend_has_free_memslots = vhost_user_has_free_memslots,
+        .vhost_out_of_memslots = vhost_user_out_of_memslots,
         .vhost_set_log_base = vhost_user_set_log_base,
         .vhost_set_mem_table = vhost_user_set_mem_table,
         .vhost_set_vring_addr = vhost_user_set_vring_addr,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 250f886..706951a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -44,20 +44,19 @@
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
+    return true;
 }
 
 static void vhost_dev_sync_region(struct vhost_dev *dev,
@@ -446,7 +445,6 @@ static void vhost_commit(MemoryListener *listener)
                        dev->n_mem_sections * sizeof dev->mem->regions[0];
     dev->mem = g_realloc(dev->mem, regions_size);
     dev->mem->nregions = dev->n_mem_sections;
-    used_memslots = dev->mem->nregions;
     for (i = 0; i < dev->n_mem_sections; i++) {
         struct vhost_memory_region *cur_vmr = dev->mem->regions + i;
         struct MemoryRegionSection *mrs = dev->mem_sections + i;
@@ -458,6 +456,7 @@ static void vhost_commit(MemoryListener *listener)
             mrs->offset_within_region;
         cur_vmr->flags_padding   = 0;
     }
+    dev->vhost_ops->vhost_set_used_memslots(dev);
 
     if (!dev->started) {
         goto out;
@@ -1248,7 +1247,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
-    if (used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
+    if (hdev->vhost_ops->vhost_out_of_memslots(hdev)) {
         error_report("vhost backend memory slots limit is less"
                 " than current number of present memory slots");
         r = -1;
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 5dac61f..f7ab82d 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -36,7 +36,9 @@ struct vhost_iotlb_msg;
 
 typedef int (*vhost_backend_init)(struct vhost_dev *dev, void *opaque);
 typedef int (*vhost_backend_cleanup)(struct vhost_dev *dev);
-typedef int (*vhost_backend_memslots_limit)(struct vhost_dev *dev);
+typedef void (*vhost_set_used_memslots_op)(struct vhost_dev *dev);
+typedef bool (*vhost_backend_has_free_memslots)(struct vhost_dev *dev);
+typedef bool (*vhost_out_of_memslots)(struct vhost_dev *dev);
 
 typedef int (*vhost_net_set_backend_op)(struct vhost_dev *dev,
                                 struct vhost_vring_file *file);
@@ -105,7 +107,9 @@ typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
     vhost_backend_cleanup vhost_backend_cleanup;
-    vhost_backend_memslots_limit vhost_backend_memslots_limit;
+    vhost_set_used_memslots_op vhost_set_used_memslots;
+    vhost_backend_has_free_memslots vhost_backend_has_free_memslots;
+    vhost_out_of_memslots vhost_out_of_memslots;
     vhost_net_set_backend_op vhost_net_set_backend;
     vhost_net_set_mtu_op vhost_net_set_mtu;
     vhost_scsi_set_endpoint_op vhost_scsi_set_endpoint;
-- 
1.8.3.1
