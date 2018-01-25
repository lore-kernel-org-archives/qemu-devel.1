Received: from eggs.gnu.org ([2001:4830:134:3::10]:40545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eeYm8-0002G6-QV
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 23:04:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eeYm3-0005dS-Vp
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 23:04:32 -0500
Received: from mga14.intel.com ([192.55.52.115]:64671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1eeYm3-0005Wb-HA
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 23:04:27 -0500
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu, 25 Jan 2018 12:03:28 +0800
Message-Id: <20180125040328.22867-7-tiwei.bie@intel.com>
In-Reply-To: <20180125040328.22867-1-tiwei.bie@intel.com>
References: <20180125040328.22867-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH v1 6/6] vhost-user: add VFIO based accelerators
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com, tiwei.bie@intel.com

This patch does some small extensions to vhost-user protocol to
support VFIO based accelerators, and makes it possible to get the
similar performance of VFIO based PCI passthru while keeping the
virtio device emulation in QEMU.

Any virtio ring compatible devices potentially can be used as the
vhost data path accelerators. We can setup the accelerator based
on the informations (e.g. memory table, features, ring info, etc)
available on the vhost backend. And accelerator will be able to use
the virtio ring provided by the virtio driver in the VM directly.
So the virtio driver in the VM can exchange e.g. network packets
with the accelerator directly via the virtio ring.

But for vhost-user, the critical issue in this case is that the
data path performance is relatively low and some host threads are
needed for the data path, because some necessary mechanisms are
missing to support:

1) guest driver notifies the device directly;
2) device interrupts the guest directly;

So this patch does some small extensions to vhost-user protocol
to make both of them possible. It leverages the same mechanisms
as the VFIO based PCI passthru.

A new protocol feature bit is added to negotiate the accelerator
feature support. Two new slave message types are added to control
the notify region and queue interrupt passthru for each queue.
>From the view of vhost-user protocol design, it's very flexible.
The passthru can be enabled/disabled for each queue individually,
and it's possible to accelerate each queue by different devices.

The key difference with PCI passthru is that, in this case only
the data path of the device (e.g. DMA ring, notify region and
queue interrupt) is pass-throughed to the VM, the device control
path (e.g. PCI configuration space and MMIO regions) is still
defined and emulated by QEMU.

The benefits of keeping virtio device emulation in QEMU compared
with virtio device PCI passthru include (but not limit to):

- consistent device interface for guest OS in the VM;
- max flexibility on the hardware (i.e. the accelerators) design;
- leveraging the existing virtio live-migration framework;

The virtual IOMMU isn't supported by the accelerators for now.
Because vhost-user currently lacks of an efficient way to share
the IOMMU table in VM to vhost backend. That's why the software
implementation of virtual IOMMU support in vhost-user backend
can't support dynamic mapping well. Once this problem is solved
in vhost-user, virtual IOMMU can be supported by accelerators
too, and the IOMMU feature bit checking in this patch can be
removed.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 docs/interop/vhost-user.txt    |  57 ++++++++++++
 hw/virtio/vhost-user.c         | 201 +++++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-user.h |  17 ++++
 3 files changed, 275 insertions(+)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 954771d0d8..15e917019a 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -116,6 +116,15 @@ Depending on the request type, payload can be:
     - 3: IOTLB invalidate
     - 4: IOTLB access fail
 
+ * Vring area description
+   -----------------------
+   | u64 | size | offset |
+   -----------------------
+
+   u64: a 64-bit unsigned integer
+   Size: a 64-bit size
+   Offset: a 64-bit offset
+
 In QEMU the vhost-user message is implemented with the following struct:
 
 typedef struct VhostUserMsg {
@@ -129,6 +138,7 @@ typedef struct VhostUserMsg {
         VhostUserMemory memory;
         VhostUserLog log;
         struct vhost_iotlb_msg iotlb;
+        VhostUserVringArea area;
     };
 } QEMU_PACKED VhostUserMsg;
 
@@ -317,6 +327,17 @@ The fd is provided via VHOST_USER_SET_SLAVE_REQ_FD ancillary data.
 A slave may then send VHOST_USER_SLAVE_* messages to the master
 using this fd communication channel.
 
+VFIO based accelerators
+-----------------------
+
+The VFIO based accelerators feature is a protocol extension. It is supported
+when the protocol feature VHOST_USER_PROTOCOL_F_VFIO (bit 7) is set.
+
+The vhost-user backend will set the accelerator context via slave channel,
+and QEMU just needs to handle those messages passively. The accelerator
+context will be set for each queue independently. So the page-per-vq property
+should also be enabled.
+
 Protocol features
 -----------------
 
@@ -327,6 +348,7 @@ Protocol features
 #define VHOST_USER_PROTOCOL_F_MTU            4
 #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
 #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
+#define VHOST_USER_PROTOCOL_F_VFIO           7
 
 Master message types
 --------------------
@@ -614,6 +636,41 @@ Slave message types
       This request should be send only when VIRTIO_F_IOMMU_PLATFORM feature
       has been successfully negotiated.
 
+ * VHOST_USER_SLAVE_VRING_VFIO_GROUP_MSG
+
+      Id: 2
+      Equivalent ioctl: N/A
+      Slave payload: u64
+      Master payload: N/A
+
+      Sets the VFIO group file descriptor which is passed as ancillary data
+      for a specified queue (queue index is carried in the u64 payload).
+      Slave sends this request to tell QEMU to add or delete a VFIO group.
+      QEMU will delete the current group if any for the specified queue when the
+      message is sent without a file descriptor. A VFIO group will be actually
+      deleted when its reference count reaches zero.
+      This request should be sent only when VHOST_USER_PROTOCOL_F_VFIO protocol
+      feature has been successfully negotiated.
+
+ * VHOST_USER_SLAVE_VRING_NOTIFY_AREA_MSG
+
+      Id: 3
+      Equivalent ioctl: N/A
+      Slave payload: vring area description
+      Master payload: N/A
+
+      Sets the notify area for a specified queue (queue index is carried
+      in the u64 field of the vring area description). A file descriptor is
+      passed as ancillary data (typically it's a VFIO device fd). QEMU can
+      mmap the file descriptor based on the information carried in the vring
+      area description.
+      Slave sends this request to tell QEMU to add or delete a MemoryRegion
+      for a specified queue's notify MMIO region. QEMU will delete the current
+      MemoryRegion if any for the specified queue when the message is sent
+      without a file descriptor.
+      This request should be sent only when VHOST_USER_PROTOCOL_F_VFIO protocol
+      feature and VIRTIO_F_VERSION_1 feature have been successfully negotiated.
+
 VHOST_USER_PROTOCOL_F_REPLY_ACK:
 -------------------------------
 The original vhost-user specification only demands replies for certain
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 3e308d0a62..ec83746bd5 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -35,6 +35,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_NET_MTU = 4,
     VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
     VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
+    VHOST_USER_PROTOCOL_F_VFIO = 7,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -72,6 +73,8 @@ typedef enum VhostUserRequest {
 typedef enum VhostUserSlaveRequest {
     VHOST_USER_SLAVE_NONE = 0,
     VHOST_USER_SLAVE_IOTLB_MSG = 1,
+    VHOST_USER_SLAVE_VRING_VFIO_GROUP_MSG = 2,
+    VHOST_USER_SLAVE_VRING_NOTIFY_AREA_MSG = 3,
     VHOST_USER_SLAVE_MAX
 }  VhostUserSlaveRequest;
 
@@ -93,6 +96,12 @@ typedef struct VhostUserLog {
     uint64_t mmap_offset;
 } VhostUserLog;
 
+typedef struct VhostUserVringArea {
+    uint64_t u64;
+    uint64_t size;
+    uint64_t offset;
+} VhostUserVringArea;
+
 typedef struct VhostUserMsg {
     VhostUserRequest request;
 
@@ -110,6 +119,7 @@ typedef struct VhostUserMsg {
         VhostUserMemory memory;
         VhostUserLog log;
         struct vhost_iotlb_msg iotlb;
+        VhostUserVringArea area;
     } payload;
 } QEMU_PACKED VhostUserMsg;
 
@@ -415,9 +425,37 @@ static int vhost_user_set_vring_num(struct vhost_dev *dev,
     return vhost_set_vring(dev, VHOST_USER_SET_VRING_NUM, ring);
 }
 
+static void vhost_user_notify_region_remap(struct vhost_dev *dev, int queue_idx)
+{
+    struct vhost_user *u = dev->opaque;
+    VhostUserVFIOState *vfio = &u->shared->vfio;
+    VhostUserNotifyCtx *notify = &vfio->notify[queue_idx];
+    VirtIODevice *vdev = dev->vdev;
+
+    if (notify->addr && !notify->mapped) {
+        virtio_device_notify_region_map(vdev, queue_idx, &notify->mr);
+        notify->mapped = true;
+    }
+}
+
+static void vhost_user_notify_region_unmap(struct vhost_dev *dev, int queue_idx)
+{
+    struct vhost_user *u = dev->opaque;
+    VhostUserVFIOState *vfio = &u->shared->vfio;
+    VhostUserNotifyCtx *notify = &vfio->notify[queue_idx];
+    VirtIODevice *vdev = dev->vdev;
+
+    if (notify->addr && notify->mapped) {
+        virtio_device_notify_region_unmap(vdev, &notify->mr);
+        notify->mapped = false;
+    }
+}
+
 static int vhost_user_set_vring_base(struct vhost_dev *dev,
                                      struct vhost_vring_state *ring)
 {
+    vhost_user_notify_region_remap(dev, ring->index);
+
     return vhost_set_vring(dev, VHOST_USER_SET_VRING_BASE, ring);
 }
 
@@ -451,6 +489,8 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
         .size = sizeof(msg.payload.state),
     };
 
+    vhost_user_notify_region_unmap(dev, ring->index);
+
     if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
         return -1;
     }
@@ -609,6 +649,136 @@ static int vhost_user_reset_device(struct vhost_dev *dev)
     return 0;
 }
 
+static int vhost_user_handle_vring_vfio_group(struct vhost_dev *dev,
+                                              uint64_t u64,
+                                              int groupfd)
+{
+    struct vhost_user *u = dev->opaque;
+    VhostUserVFIOState *vfio = &u->shared->vfio;
+    int queue_idx = u64 & VHOST_USER_VRING_IDX_MASK;
+    VirtIODevice *vdev = dev->vdev;
+    VFIOGroup *group;
+    int ret = 0;
+
+    qemu_mutex_lock(&vfio->lock);
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_VFIO) ||
+        vdev == NULL ||
+        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM) ||
+        queue_idx >= virtio_get_num_queues(vdev)) {
+        ret = -1;
+        goto out;
+    }
+
+    if (vfio->group[queue_idx]) {
+        vfio_put_group(vfio->group[queue_idx]);
+        vfio->group[queue_idx] = NULL;
+    }
+
+    if (u64 & VHOST_USER_VRING_NOFD_MASK) {
+        goto out;
+    }
+
+    group = vfio_get_group_from_fd(groupfd, NULL, NULL);
+    if (group == NULL) {
+        ret = -1;
+        goto out;
+    }
+
+    if (group->fd != groupfd) {
+        close(groupfd);
+    }
+
+    vfio->group[queue_idx] = group;
+
+out:
+    kvm_irqchip_commit_routes(kvm_state);
+    qemu_mutex_unlock(&vfio->lock);
+
+    if (ret != 0 && groupfd != -1) {
+        close(groupfd);
+    }
+
+    return ret;
+}
+
+#define NOTIFY_PAGE_SIZE 0x1000
+
+static int vhost_user_handle_vring_notify_area(struct vhost_dev *dev,
+                                               VhostUserVringArea *area,
+                                               int fd)
+{
+    struct vhost_user *u = dev->opaque;
+    VhostUserVFIOState *vfio = &u->shared->vfio;
+    int queue_idx = area->u64 & VHOST_USER_VRING_IDX_MASK;
+    VirtIODevice *vdev = dev->vdev;
+    VhostUserNotifyCtx *notify;
+    void *addr = NULL;
+    int ret = 0;
+    char *name;
+
+    qemu_mutex_lock(&vfio->lock);
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_VFIO) ||
+        vdev == NULL || queue_idx >= virtio_get_num_queues(vdev) ||
+        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM) ||
+        !virtio_device_page_per_vq_enabled(vdev)) {
+        ret = -1;
+        goto out;
+    }
+
+    notify = &vfio->notify[queue_idx];
+
+    if (notify->addr) {
+        virtio_device_notify_region_unmap(vdev, &notify->mr);
+        munmap(notify->addr, NOTIFY_PAGE_SIZE);
+        object_unparent(OBJECT(&notify->mr));
+        notify->addr = NULL;
+    }
+
+    if (area->u64 & VHOST_USER_VRING_NOFD_MASK) {
+        goto out;
+    }
+
+    if (area->size < NOTIFY_PAGE_SIZE) {
+        ret = -1;
+        goto out;
+    }
+
+    addr = mmap(NULL, NOTIFY_PAGE_SIZE, PROT_READ | PROT_WRITE,
+                MAP_SHARED, fd, area->offset);
+    if (addr == MAP_FAILED) {
+        error_report("Can't map notify region.");
+        ret = -1;
+        goto out;
+    }
+
+    name = g_strdup_printf("vhost-user/vfio@%p mmaps[%d]", vfio, queue_idx);
+    memory_region_init_ram_device_ptr(&notify->mr, OBJECT(vdev), name,
+                                      NOTIFY_PAGE_SIZE, addr);
+    g_free(name);
+
+    if (virtio_device_notify_region_map(vdev, queue_idx, &notify->mr)) {
+        ret = -1;
+        goto out;
+    }
+
+    notify->addr = addr;
+    notify->mapped = true;
+
+out:
+    if (ret < 0 && addr != NULL) {
+        munmap(addr, NOTIFY_PAGE_SIZE);
+    }
+    if (fd != -1) {
+        close(fd);
+    }
+    qemu_mutex_unlock(&vfio->lock);
+    return ret;
+}
+
 static void slave_read(void *opaque)
 {
     struct vhost_dev *dev = opaque;
@@ -670,6 +840,12 @@ static void slave_read(void *opaque)
     case VHOST_USER_SLAVE_IOTLB_MSG:
         ret = vhost_backend_handle_iotlb_msg(dev, &msg.payload.iotlb);
         break;
+    case VHOST_USER_SLAVE_VRING_VFIO_GROUP_MSG:
+        ret = vhost_user_handle_vring_vfio_group(dev, msg.payload.u64, fd);
+        break;
+    case VHOST_USER_SLAVE_VRING_NOTIFY_AREA_MSG:
+        ret = vhost_user_handle_vring_notify_area(dev, &msg.payload.area, fd);
+        break;
     default:
         error_report("Received unexpected msg type.");
         if (fd != -1) {
@@ -772,6 +948,10 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
     u->slave_fd = -1;
     dev->opaque = u;
 
+    if (dev->vq_index == 0) {
+        qemu_mutex_init(&u->shared->vfio.lock);
+    }
+
     err = vhost_user_get_features(dev, &features);
     if (err < 0) {
         return err;
@@ -832,6 +1012,7 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
 static int vhost_user_cleanup(struct vhost_dev *dev)
 {
     struct vhost_user *u;
+    int i;
 
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
 
@@ -841,6 +1022,26 @@ static int vhost_user_cleanup(struct vhost_dev *dev)
         close(u->slave_fd);
         u->slave_fd = -1;
     }
+
+    if (dev->vq_index == 0) {
+        VhostUserVFIOState *vfio = &u->shared->vfio;
+
+        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+            if (vfio->notify[i].addr) {
+                munmap(vfio->notify[i].addr, NOTIFY_PAGE_SIZE);
+                object_unparent(OBJECT(&vfio->notify[i].mr));
+                vfio->notify[i].addr = NULL;
+            }
+
+            if (vfio->group[i]) {
+                vfio_put_group(vfio->group[i]);
+                vfio->group[i] = NULL;
+            }
+        }
+
+        qemu_mutex_destroy(&u->shared->vfio.lock);
+    }
+
     g_free(u);
     dev->opaque = 0;
 
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 4f5a1477d1..de8c647962 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -9,9 +9,26 @@
 #define HW_VIRTIO_VHOST_USER_H
 
 #include "chardev/char-fe.h"
+#include "hw/virtio/virtio.h"
+#include "hw/vfio/vfio-common.h"
+
+typedef struct VhostUserNotifyCtx {
+    void *addr;
+    MemoryRegion mr;
+    bool mapped;
+} VhostUserNotifyCtx;
+
+typedef struct VhostUserVFIOState {
+    /* The VFIO group associated with each queue */
+    VFIOGroup *group[VIRTIO_QUEUE_MAX];
+    /* The notify context of each queue */
+    VhostUserNotifyCtx notify[VIRTIO_QUEUE_MAX];
+    QemuMutex lock;
+} VhostUserVFIOState;
 
 typedef struct VhostUser {
     CharBackend chr;
+    VhostUserVFIOState vfio;
 } VhostUser;
 
 #endif
-- 
2.13.3
