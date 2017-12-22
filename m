Received: from eggs.gnu.org ([2001:4830:134:3::10]:46048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eSH2g-000687-3c
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 01:42:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eSH2d-0007PY-Jb
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 01:42:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:46019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1eSH2d-0007Ia-5x
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 01:42:47 -0500
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri, 22 Dec 2017 14:41:51 +0800
Message-Id: <20171222064151.29266-4-tiwei.bie@intel.com>
In-Reply-To: <20171222064151.29266-1-tiwei.bie@intel.com>
References: <20171222064151.29266-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [RFC 3/3] vhost-user: add VFIO based accelerators
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com, tiwei.bie@intel.com

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 docs/interop/vhost-user.txt    |  57 ++++++
 hw/vfio/common.c               |   2 +-
 hw/virtio/vhost-user.c         | 381 ++++++++++++++++++++++++++++++++++++++++-
 hw/virtio/vhost.c              |   3 +-
 hw/virtio/virtio-pci.c         |   8 -
 hw/virtio/virtio-pci.h         |   8 +
 include/hw/vfio/vfio.h         |   2 +
 include/hw/virtio/vhost-user.h |  26 +++
 8 files changed, 476 insertions(+), 11 deletions(-)

diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index 954771d0d8..dd029e4b9d 100644
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
 
+ * VHOST_USER_SLAVE_VFIO_SET_VRING_GROUP_FD
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
+ * VHOST_USER_SLAVE_VFIO_SET_VRING_NOTIFY_AREA
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
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7b2924c0ef..53d8700581 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -49,7 +49,7 @@ struct vfio_as_head vfio_address_spaces =
  * initialized, this file descriptor is only released on QEMU exit and
  * we'll re-use it should another vfio device be attached before then.
  */
-static int vfio_kvm_device_fd = -1;
+int vfio_kvm_device_fd = -1;
 #endif
 
 /*
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 3e308d0a62..22d7dd5729 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -14,6 +14,8 @@
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/vhost-user.h"
 #include "hw/virtio/virtio-net.h"
+#include "hw/virtio/virtio-pci.h"
+#include "hw/vfio/vfio.h"
 #include "chardev/char-fe.h"
 #include "sysemu/kvm.h"
 #include "qemu/error-report.h"
@@ -35,6 +37,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_NET_MTU = 4,
     VHOST_USER_PROTOCOL_F_SLAVE_REQ = 5,
     VHOST_USER_PROTOCOL_F_CROSS_ENDIAN = 6,
+    VHOST_USER_PROTOCOL_F_VFIO = 7,
 
     VHOST_USER_PROTOCOL_F_MAX
 };
@@ -72,6 +75,8 @@ typedef enum VhostUserRequest {
 typedef enum VhostUserSlaveRequest {
     VHOST_USER_SLAVE_NONE = 0,
     VHOST_USER_SLAVE_IOTLB_MSG = 1,
+    VHOST_USER_SLAVE_VFIO_SET_VRING_GROUP_FD = 2,
+    VHOST_USER_SLAVE_VFIO_SET_VRING_NOTIFY_AREA = 3,
     VHOST_USER_SLAVE_MAX
 }  VhostUserSlaveRequest;
 
@@ -93,6 +98,12 @@ typedef struct VhostUserLog {
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
 
@@ -110,6 +121,7 @@ typedef struct VhostUserMsg {
         VhostUserMemory memory;
         VhostUserLog log;
         struct vhost_iotlb_msg iotlb;
+        VhostUserVringArea area;
     } payload;
 } QEMU_PACKED VhostUserMsg;
 
@@ -609,6 +621,342 @@ static int vhost_user_reset_device(struct vhost_dev *dev)
     return 0;
 }
 
+#ifdef CONFIG_KVM
+static int vfio_group_fd_to_id(int group_fd)
+{
+    char linkname[PATH_MAX];
+    char pathname[PATH_MAX];
+    char *filename;
+    int group_id, ret;
+
+    snprintf(linkname, sizeof(linkname), "/proc/self/fd/%d", group_fd);
+
+    ret = readlink(linkname, pathname, sizeof(pathname));
+    if (ret < 0) {
+        return -1;
+    }
+
+    filename = g_path_get_basename(pathname);
+    group_id = atoi(filename);
+    g_free(filename);
+
+    return group_id;
+}
+
+static int vhost_user_kvm_add_vfio_group(struct vhost_dev *dev,
+                                         int group_id, int group_fd)
+{
+    struct vhost_user *u = dev->opaque;
+    struct vhost_user_vfio_state *vfio = &u->shared->vfio;
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_GROUP,
+        .attr = KVM_DEV_VFIO_GROUP_ADD,
+    };
+    bool found = false;
+    int i, ret;
+
+    for (i = 0; i < vfio->nr_group; i++) {
+        if (vfio->group[i].id == group_id) {
+            found = true;
+            break;
+        }
+    }
+
+    if (found) {
+        close(group_fd);
+        vfio->group[i].refcnt++;
+        return 0;
+    }
+
+    if (vfio->nr_group >= VIRTIO_QUEUE_MAX) {
+        return -1;
+    }
+
+    vfio->group[i].id = group_id;
+    vfio->group[i].fd = group_fd;
+    vfio->group[i].refcnt = 1;
+
+    attr.addr = (uint64_t)(uintptr_t)&vfio->group[i].fd;
+
+again:
+    /* XXX: improve this */
+    if (vfio_kvm_device_fd < 0) {
+        struct kvm_create_device cd = {
+            .type = KVM_DEV_TYPE_VFIO,
+        };
+
+        ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
+        if (ret < 0) {
+            if (errno == EBUSY) {
+                goto again;
+            }
+            error_report("Failed to create KVM VFIO device.");
+            return -1;
+        }
+
+        vfio_kvm_device_fd = cd.fd;
+    }
+
+    ret = ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr);
+    if (ret < 0) {
+        error_report("Failed to add group %d to KVM VFIO device.",
+                     group_id);
+        return -1;
+    }
+
+    vfio->nr_group++;
+
+    return 0;
+}
+
+static int vhost_user_kvm_del_vfio_group(struct vhost_dev *dev, int group_id)
+{
+    struct vhost_user *u = dev->opaque;
+    struct vhost_user_vfio_state *vfio = &u->shared->vfio;
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_GROUP,
+        .attr = KVM_DEV_VFIO_GROUP_DEL,
+    };
+    bool found = false;
+    int i, ret;
+
+    kvm_irqchip_commit_routes(kvm_state);
+
+    for (i = 0; i < vfio->nr_group; i++) {
+        if (vfio->group[i].id == group_id) {
+            found = true;
+            break;
+        }
+    }
+
+    if (!found) {
+        return 0;
+    }
+
+    vfio->group[i].refcnt--;
+
+    if (vfio->group[i].refcnt == 0) {
+        attr.addr = (uint64_t)(uintptr_t)&vfio->group[i].fd;
+        ret = ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr);
+        if (ret < 0) {
+            error_report("Failed to remove group %d from KVM VFIO device.",
+                    group_id);
+            vfio->group[i].refcnt++;
+            return -1;
+        }
+
+        close(vfio->group[i].fd);
+
+        for (; i + 1 < vfio->nr_group; i++) {
+            vfio->group[i] = vfio->group[i + 1];
+        }
+        vfio->nr_group--;
+    }
+
+    return 0;
+}
+
+static int vhost_user_handle_vfio_set_vring_group_fd(struct vhost_dev *dev,
+                                                     uint64_t u64,
+                                                     int group_fd)
+{
+    struct vhost_user *u = dev->opaque;
+    struct vhost_user_vfio_state *vfio = &u->shared->vfio;
+    int qid = u64 & VHOST_USER_VRING_IDX_MASK;
+    int group_id, nvqs, ret = 0;
+
+    qemu_mutex_lock(&vfio->lock);
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_VFIO)) {
+        ret = -1;
+        goto out;
+    }
+
+    if (dev->vdev == NULL) {
+        error_report("vhost_dev isn't available.");
+        ret = -1;
+        goto out;
+    }
+
+    nvqs = virtio_get_num_queues(dev->vdev);
+    if (qid >= nvqs) {
+        error_report("invalid queue index.");
+        ret = -1;
+        goto out;
+    }
+
+    if (u64 & VHOST_USER_VRING_NOFD_MASK) {
+        group_id = vfio->group_id[qid];
+        if (group_id != -1) {
+            if (vhost_user_kvm_del_vfio_group(dev, group_id) < 0) {
+                ret = -1;
+                goto out;
+            }
+            vfio->group_id[qid] = -1;
+        }
+        goto out;
+    }
+
+    group_id = vfio_group_fd_to_id(group_fd);
+    if (group_id == -1) {
+        ret = -1;
+        goto out;
+    }
+
+    if (vfio->group_id[qid] == group_id) {
+        close(group_fd);
+        goto out;
+    }
+
+    if (vfio->group_id[qid] != -1) {
+        if (vhost_user_kvm_del_vfio_group(dev, vfio->group_id[qid]) < 0) {
+            ret = -1;
+            goto out;
+        }
+        vfio->group_id[qid] = -1;
+    }
+
+    if (vhost_user_kvm_add_vfio_group(dev, group_id, group_fd) < 0) {
+        ret = -1;
+        goto out;
+    }
+    vfio->group_id[qid] = group_id;
+
+out:
+    kvm_irqchip_commit_routes(kvm_state);
+    qemu_mutex_unlock(&vfio->lock);
+
+    if (ret != 0 && group_fd != -1) {
+        close(group_fd);
+    }
+
+    return ret;
+}
+#else
+static int vhost_user_handle_vfio_set_vring_group_fd(struct vhost_dev *dev,
+                                                     uint64_t u64,
+                                                     int group_fd)
+{
+    if (group_fd != -1) {
+        close(group_fd);
+    }
+
+    return 0;
+}
+#endif
+
+static int vhost_user_add_mapping(struct vhost_dev *dev, int qid, int fd,
+                                  uint64_t size, uint64_t offset)
+{
+    struct vhost_user *u = dev->opaque;
+    struct vhost_user_vfio_state *vfio = &u->shared->vfio;
+    MemoryRegion *sysmem = get_system_memory();
+    VirtIONetPCI *d;
+    VirtIOPCIProxy *proxy; /* XXX: handle non-PCI case */
+    uint64_t paddr;
+    void *addr;
+    char *name;
+
+    d = container_of(dev->vdev, VirtIONetPCI, vdev.parent_obj);
+    proxy = &d->parent_obj;
+
+    if ((proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) == 0 ||
+        size != virtio_pci_queue_mem_mult(proxy)) {
+        return -1;
+    }
+
+    addr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, offset);
+    if (addr == MAP_FAILED) {
+        error_report("Can't map notify region.");
+        return -1;
+    }
+
+    vfio->notify[qid].mmap.addr = addr;
+    vfio->notify[qid].mmap.size = size;
+
+    /* The notify_offset of each queue is queue_select */
+    paddr = proxy->modern_bar.addr + proxy->notify.offset +
+                virtio_pci_queue_mem_mult(proxy) * qid;
+
+    name = g_strdup_printf("vhost-user/vfio@%p mmaps[%d]", vfio, qid);
+    memory_region_init_ram_device_ptr(&vfio->notify[qid].mr,
+                                      memory_region_owner(sysmem),
+                                      name, size, addr);
+    g_free(name);
+    memory_region_add_subregion(sysmem, paddr, &vfio->notify[qid].mr);
+
+    return 0;
+}
+
+static int vhost_user_del_mapping(struct vhost_dev *dev, int qid)
+{
+    struct vhost_user *u = dev->opaque;
+    struct vhost_user_vfio_state *vfio = &u->shared->vfio;
+    MemoryRegion *sysmem = get_system_memory();
+
+    if (vfio->notify[qid].mmap.addr == NULL) {
+        return 0;
+    }
+
+    memory_region_del_subregion(sysmem, &vfio->notify[qid].mr);
+    object_unparent(OBJECT(&vfio->notify[qid].mr));
+
+    munmap(vfio->notify[qid].mmap.addr, vfio->notify[qid].mmap.size);
+    vfio->notify[qid].mmap.addr = NULL;
+    vfio->notify[qid].mmap.size = 0;
+
+    return 0;
+}
+
+static int vhost_user_handle_vfio_set_vring_notify_area(struct vhost_dev *dev,
+        VhostUserVringArea *notify_area, int fd)
+{
+    struct vhost_user *u = dev->opaque;
+    struct vhost_user_vfio_state *vfio = &u->shared->vfio;
+    int qid = notify_area->u64 & VHOST_USER_VRING_IDX_MASK;
+    int nvqs, ret = 0;
+
+    qemu_mutex_lock(&vfio->lock);
+
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_VFIO)) {
+        ret = -1;
+        goto out;
+    }
+
+    if (dev->vdev == NULL) {
+        error_report("vhost_dev isn't available.");
+        ret = -1;
+        goto out;
+    }
+
+    nvqs = virtio_get_num_queues(dev->vdev);
+    if (qid >= nvqs) {
+        error_report("invalid queue index.");
+        ret = -1;
+        goto out;
+    }
+
+    if (vfio->notify[qid].mmap.addr != NULL) {
+        vhost_user_del_mapping(dev, qid);
+    }
+
+    if (notify_area->u64 & VHOST_USER_VRING_NOFD_MASK) {
+        goto out;
+    }
+
+    ret = vhost_user_add_mapping(dev, qid, fd, notify_area->size,
+                                 notify_area->offset);
+
+out:
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
@@ -670,6 +1018,14 @@ static void slave_read(void *opaque)
     case VHOST_USER_SLAVE_IOTLB_MSG:
         ret = vhost_backend_handle_iotlb_msg(dev, &msg.payload.iotlb);
         break;
+    case VHOST_USER_SLAVE_VFIO_SET_VRING_GROUP_FD:
+        ret = vhost_user_handle_vfio_set_vring_group_fd(dev,
+                    msg.payload.u64, fd);
+        break;
+    case VHOST_USER_SLAVE_VFIO_SET_VRING_NOTIFY_AREA:
+        ret = vhost_user_handle_vfio_set_vring_notify_area(dev,
+                    &msg.payload.area, fd);
+        break;
     default:
         error_report("Received unexpected msg type.");
         if (fd != -1) {
@@ -763,7 +1119,7 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
 {
     uint64_t features, protocol_features;
     struct vhost_user *u;
-    int err;
+    int i, err;
 
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
 
@@ -772,6 +1128,13 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
     u->slave_fd = -1;
     dev->opaque = u;
 
+    if (dev->vq_index == 0) {
+        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+            u->shared->vfio.group_id[i] = -1;
+        }
+        qemu_mutex_init(&u->shared->vfio.lock);
+    }
+
     err = vhost_user_get_features(dev, &features);
     if (err < 0) {
         return err;
@@ -832,6 +1195,7 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
 static int vhost_user_cleanup(struct vhost_dev *dev)
 {
     struct vhost_user *u;
+    int i;
 
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
 
@@ -841,6 +1205,21 @@ static int vhost_user_cleanup(struct vhost_dev *dev)
         close(u->slave_fd);
         u->slave_fd = -1;
     }
+
+    if (dev->vq_index == 0) {
+        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+            vhost_user_del_mapping(dev, i);
+        }
+
+#ifdef CONFIG_KVM
+        while (u->shared->vfio.nr_group > 0) {
+            int group_id;
+            group_id = u->shared->vfio.group[0].id;
+            vhost_user_kvm_del_vfio_group(dev, group_id);
+        }
+#endif
+    }
+
     g_free(u);
     dev->opaque = 0;
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e4290ce93d..a001a0936a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -612,7 +612,8 @@ static void vhost_set_memory(MemoryListener *listener,
 static bool vhost_section(MemoryRegionSection *section)
 {
     return memory_region_is_ram(section->mr) &&
-        !memory_region_is_rom(section->mr);
+        !memory_region_is_rom(section->mr) &&
+        !memory_region_is_ram_device(section->mr);
 }
 
 static void vhost_begin(MemoryListener *listener)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e92837c42b..c28fed8676 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -219,14 +219,6 @@ static bool virtio_pci_ioeventfd_enabled(DeviceState *d)
     return (proxy->flags & VIRTIO_PCI_FLAG_USE_IOEVENTFD) != 0;
 }
 
-#define QEMU_VIRTIO_PCI_QUEUE_MEM_MULT 0x1000
-
-static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy *proxy)
-{
-    return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
-        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
-}
-
 static int virtio_pci_ioeventfd_assign(DeviceState *d, EventNotifier *notifier,
                                        int n, bool assign)
 {
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 12d3a90686..f2a613569b 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -209,6 +209,14 @@ static inline void virtio_pci_disable_modern(VirtIOPCIProxy *proxy)
     proxy->disable_modern = true;
 }
 
+#define QEMU_VIRTIO_PCI_QUEUE_MEM_MULT 0x1000
+
+static inline int virtio_pci_queue_mem_mult(struct VirtIOPCIProxy *proxy)
+{
+    return (proxy->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ) ?
+        QEMU_VIRTIO_PCI_QUEUE_MEM_MULT : 4;
+}
+
 /*
  * virtio-scsi-pci: This extends VirtioPCIProxy.
  */
diff --git a/include/hw/vfio/vfio.h b/include/hw/vfio/vfio.h
index 86248f5436..7425fcd90c 100644
--- a/include/hw/vfio/vfio.h
+++ b/include/hw/vfio/vfio.h
@@ -1,6 +1,8 @@
 #ifndef HW_VFIO_H
 #define HW_VFIO_H
 
+extern int vfio_kvm_device_fd;
+
 bool vfio_eeh_as_ok(AddressSpace *as);
 int vfio_eeh_as_op(AddressSpace *as, uint32_t op);
 
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 10d698abe2..cc998f4f43 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -9,9 +9,35 @@
 #define HW_VIRTIO_VHOST_USER_H
 
 #include "chardev/char-fe.h"
+#include "hw/virtio/virtio.h"
+
+struct vhost_user_vfio_state {
+    /* The group ID associated with each queue */
+    int group_id[VIRTIO_QUEUE_MAX];
+
+    /* The notify context of each queue */
+    struct {
+        struct {
+            uint64_t size;
+            void *addr;
+        } mmap;
+        MemoryRegion mr;
+    } notify[VIRTIO_QUEUE_MAX];
+
+    /* The vfio groups associated with this vhost user */
+    struct {
+        int fd;
+        int id;
+        int refcnt;
+    } group[VIRTIO_QUEUE_MAX];
+    int nr_group;
+
+    QemuMutex lock;
+};
 
 typedef struct VhostUser {
     CharBackend chr;
+    struct vhost_user_vfio_state vfio;
 } VhostUser;
 
 #endif
-- 
2.13.3
