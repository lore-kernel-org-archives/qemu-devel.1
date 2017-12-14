Received: from eggs.gnu.org ([2001:4830:134:3::10]:36312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ePWVO-0000Uy-Gj
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ePWVL-0001xj-99
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:37:06 -0500
Received: from [45.249.212.32] (port=34850 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ePWVK-0001tN-LS
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:37:03 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Fri, 15 Dec 2017 00:36:31 +0800
Message-ID: <1513269392-23224-2-git-send-email-jianjay.zhou@huawei.com>
In-Reply-To: <1513269392-23224-1-git-send-email-jianjay.zhou@huawei.com>
References: <1513269392-23224-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/2] vhost: add used memslot number for
 vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com
Cc: weidong.huang@huawei.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com, gary.liuzhe@huawei.com

Used_memslots is equal to dev->mem->nregions now, it is true for
vhost kernel, but not for vhost user, which uses the memory regions
that have file descriptor. In fact, not all of the memory regions
have file descriptor.
It is usefully in some scenarios, e.g. used_memslots is 8, and only
5 memory slots can be used by vhost user, it is failed to hot plug
a new memory RAM because vhost_has_free_slot just returned false,
but we can hot plug it safely in fact.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
Signed-off-by: Zhe Liu <gary.liuzhe@huawei.com>
---
 hw/virtio/vhost-user.c            | 31 +++++++++++++++++++++++++++++++
 hw/virtio/vhost.c                 | 25 +++++++++++++++++++++----
 include/hw/virtio/vhost-backend.h |  4 ++++
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 093675e..58a4cec 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -122,6 +122,8 @@ static VhostUserMsg m __attribute__ ((unused));
 /* The version of the protocol we support */
 #define VHOST_USER_VERSION    (0x1)
 
+static unsigned int vhost_user_used_memslots;
+
 struct vhost_user {
     CharBackend *chr;
     int slave_fd;
@@ -922,6 +924,33 @@ static void vhost_user_set_iotlb_callback(struct vhost_dev *dev, int enabled)
     /* No-op as the receive channel is not dedicated to IOTLB messages. */
 }
 
+static void vhost_user_set_used_memslots(struct vhost_dev *dev)
+{
+    int counter = 0;
+    int i;
+
+    for (i = 0; i < dev->mem->nregions; ++i) {
+        struct vhost_memory_region *reg = dev->mem->regions + i;
+        ram_addr_t offset;
+        MemoryRegion *mr;
+        int fd;
+
+        assert((uintptr_t)reg->userspace_addr == reg->userspace_addr);
+        mr = memory_region_from_host((void *)(uintptr_t)reg->userspace_addr,
+                                    &offset);
+        fd = memory_region_get_fd(mr);
+        if (fd > 0) {
+            counter++;
+        }
+    }
+    vhost_user_used_memslots = counter;
+}
+
+static unsigned int vhost_user_get_used_memslots(void)
+{
+    return vhost_user_used_memslots;
+}
+
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_init,
@@ -948,4 +977,6 @@ const VhostOps user_ops = {
         .vhost_net_set_mtu = vhost_user_net_set_mtu,
         .vhost_set_iotlb_callback = vhost_user_set_iotlb_callback,
         .vhost_send_device_iotlb_msg = vhost_user_send_device_iotlb_msg,
+        .vhost_set_used_memslots = vhost_user_set_used_memslots,
+        .vhost_get_used_memslots = vhost_user_get_used_memslots,
 };
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e4290ce..0cf8a53 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -49,14 +49,21 @@ static QLIST_HEAD(, vhost_dev) vhost_devices =
 
 bool vhost_has_free_slot(void)
 {
-    unsigned int slots_limit = ~0U;
     struct vhost_dev *hdev;
 
     QLIST_FOREACH(hdev, &vhost_devices, entry) {
         unsigned int r = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
-        slots_limit = MIN(slots_limit, r);
+
+        if (hdev->vhost_ops->vhost_get_used_memslots) {
+            if (hdev->vhost_ops->vhost_get_used_memslots() >= r) {
+                return false;
+            }
+        } else if (used_memslots >= r) {
+            return false;
+        }
     }
-    return slots_limit > used_memslots;
+
+    return true;
 }
 
 static void vhost_dev_sync_region(struct vhost_dev *dev,
@@ -607,6 +614,9 @@ static void vhost_set_memory(MemoryListener *listener,
     dev->mem_changed_end_addr = MAX(dev->mem_changed_end_addr, start_addr + size - 1);
     dev->memory_changed = true;
     used_memslots = dev->mem->nregions;
+    if (dev->vhost_ops->vhost_set_used_memslots) {
+        dev->vhost_ops->vhost_set_used_memslots(dev);
+    }
 }
 
 static bool vhost_section(MemoryRegionSection *section)
@@ -1239,6 +1249,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     uint64_t features;
     int i, r, n_initialized_vqs = 0;
     Error *local_err = NULL;
+    unsigned int n_memslots = 0;
 
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
@@ -1251,7 +1262,13 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    if (used_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
+    if (hdev->vhost_ops->vhost_get_used_memslots) {
+        n_memslots = hdev->vhost_ops->vhost_get_used_memslots();
+    } else {
+        n_memslots = used_memslots;
+    }
+
+    if (n_memslots > hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
         error_report("vhost backend memory slots limit is less"
                 " than current number of present memory slots");
         r = -1;
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index a7a5f22..19961b5 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -84,6 +84,8 @@ typedef void (*vhost_set_iotlb_callback_op)(struct vhost_dev *dev,
                                            int enabled);
 typedef int (*vhost_send_device_iotlb_msg_op)(struct vhost_dev *dev,
                                               struct vhost_iotlb_msg *imsg);
+typedef void (*vhost_set_used_memslots_op)(struct vhost_dev *dev);
+typedef unsigned int (*vhost_get_used_memslots_op)(void);
 
 typedef struct VhostOps {
     VhostBackendType backend_type;
@@ -118,6 +120,8 @@ typedef struct VhostOps {
     vhost_vsock_set_running_op vhost_vsock_set_running;
     vhost_set_iotlb_callback_op vhost_set_iotlb_callback;
     vhost_send_device_iotlb_msg_op vhost_send_device_iotlb_msg;
+    vhost_set_used_memslots_op vhost_set_used_memslots;
+    vhost_get_used_memslots_op vhost_get_used_memslots;
 } VhostOps;
 
 extern const VhostOps user_ops;
-- 
1.8.3.1
