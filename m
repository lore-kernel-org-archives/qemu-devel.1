Received: from eggs.gnu.org ([2001:4830:134:3::10]:33402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9q-0007FQ-75
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9o-0005Pk-9F
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:42 -0500
Date: Tue, 10 Jan 2017 07:39:29 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-5-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 04/41] virtio: convert to use DMA api
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Jason Wang <jasowang@redhat.com>

Currently, all virtio devices bypass IOMMU completely. This is because
address_space_memory is assumed and used during DMA emulation. This
patch converts the virtio core API to use DMA API. This idea is

- introducing a new transport specific helper to query the dma address
  space. (only pci version is implemented).
- query and use this address space during virtio device guest memory
  accessing when iommu platform (VIRTIO_F_IOMMU_PLATFORM) was enabled
  for this device.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-access.h | 31 ++++++++++++++-------
 include/hw/virtio/virtio-bus.h    |  1 +
 include/hw/virtio/virtio.h        |  9 ++++---
 hw/block/virtio-blk.c             |  2 +-
 hw/char/virtio-serial-bus.c       |  3 ++-
 hw/scsi/virtio-scsi.c             |  4 ++-
 hw/virtio/virtio-bus.c            |  8 ++++++
 hw/virtio/virtio-pci.c            | 14 ++++++++++
 hw/virtio/virtio.c                | 57 +++++++++++++++++++++++++--------------
 9 files changed, 93 insertions(+), 36 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 440b455..91ae14d 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -17,6 +17,7 @@
 #define QEMU_VIRTIO_ACCESS_H
 
 #include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-bus.h"
 #include "exec/address-spaces.h"
 
 #if defined(TARGET_PPC64) || defined(TARGET_ARM)
@@ -40,45 +41,55 @@ static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 
 static inline uint16_t virtio_lduw_phys(VirtIODevice *vdev, hwaddr pa)
 {
+    AddressSpace *dma_as = vdev->dma_as;
+
     if (virtio_access_is_big_endian(vdev)) {
-        return lduw_be_phys(&address_space_memory, pa);
+        return lduw_be_phys(dma_as, pa);
     }
-    return lduw_le_phys(&address_space_memory, pa);
+    return lduw_le_phys(dma_as, pa);
 }
 
 static inline uint32_t virtio_ldl_phys(VirtIODevice *vdev, hwaddr pa)
 {
+    AddressSpace *dma_as = vdev->dma_as;
+
     if (virtio_access_is_big_endian(vdev)) {
-        return ldl_be_phys(&address_space_memory, pa);
+        return ldl_be_phys(dma_as, pa);
     }
-    return ldl_le_phys(&address_space_memory, pa);
+    return ldl_le_phys(dma_as, pa);
 }
 
 static inline uint64_t virtio_ldq_phys(VirtIODevice *vdev, hwaddr pa)
 {
+    AddressSpace *dma_as = vdev->dma_as;
+
     if (virtio_access_is_big_endian(vdev)) {
-        return ldq_be_phys(&address_space_memory, pa);
+        return ldq_be_phys(dma_as, pa);
     }
-    return ldq_le_phys(&address_space_memory, pa);
+    return ldq_le_phys(dma_as, pa);
 }
 
 static inline void virtio_stw_phys(VirtIODevice *vdev, hwaddr pa,
                                    uint16_t value)
 {
+    AddressSpace *dma_as = vdev->dma_as;
+
     if (virtio_access_is_big_endian(vdev)) {
-        stw_be_phys(&address_space_memory, pa, value);
+        stw_be_phys(dma_as, pa, value);
     } else {
-        stw_le_phys(&address_space_memory, pa, value);
+        stw_le_phys(dma_as, pa, value);
     }
 }
 
 static inline void virtio_stl_phys(VirtIODevice *vdev, hwaddr pa,
                                    uint32_t value)
 {
+    AddressSpace *dma_as = vdev->dma_as;
+
     if (virtio_access_is_big_endian(vdev)) {
-        stl_be_phys(&address_space_memory, pa, value);
+        stl_be_phys(dma_as, pa, value);
     } else {
-        stl_le_phys(&address_space_memory, pa, value);
+        stl_le_phys(dma_as, pa, value);
     }
 }
 
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index 8a51e2c..a63c1d2 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -88,6 +88,7 @@ typedef struct VirtioBusClass {
      * Note that changing this will break migration for this transport.
      */
     bool has_variable_vring_alignment;
+    AddressSpace *(*get_dma_as)(DeviceState *d);
 } VirtioBusClass;
 
 struct VirtioBusState {
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index ab0e030..5e4176f 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -92,6 +92,7 @@ struct VirtIODevice
     char *bus_name;
     uint8_t device_endian;
     bool use_guest_notifier_mask;
+    AddressSpace *dma_as;
     QLIST_HEAD(, VirtQueue) *vector_queues;
 };
 
@@ -170,9 +171,9 @@ bool virtqueue_rewind(VirtQueue *vq, unsigned int num);
 void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len, unsigned int idx);
 
-void virtqueue_map(VirtQueueElement *elem);
+void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem);
 void *virtqueue_pop(VirtQueue *vq, size_t sz);
-void *qemu_get_virtqueue_element(QEMUFile *f, size_t sz);
+void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz);
 void qemu_put_virtqueue_element(QEMUFile *f, VirtQueueElement *elem);
 int virtqueue_avail_bytes(VirtQueue *vq, unsigned int in_bytes,
                           unsigned int out_bytes);
@@ -255,7 +256,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
     DEFINE_PROP_BIT64("notify_on_empty", _state, _field,  \
                       VIRTIO_F_NOTIFY_ON_EMPTY, true), \
     DEFINE_PROP_BIT64("any_layout", _state, _field, \
-                      VIRTIO_F_ANY_LAYOUT, true)
+                      VIRTIO_F_ANY_LAYOUT, true), \
+    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
+                      VIRTIO_F_IOMMU_PLATFORM, false)
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 50bb0cb..702eda8 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -863,7 +863,7 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
             }
         }
 
-        req = qemu_get_virtqueue_element(f, sizeof(VirtIOBlockReq));
+        req = qemu_get_virtqueue_element(vdev, f, sizeof(VirtIOBlockReq));
         virtio_blk_init_request(s, virtio_get_queue(vdev, vq_idx), req);
         req->next = s->rq;
         s->rq = req;
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 7975c2c..d544cd9 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -732,6 +732,7 @@ static void virtio_serial_post_load_timer_cb(void *opaque)
 static int fetch_active_ports_list(QEMUFile *f,
                                    VirtIOSerial *s, uint32_t nr_active_ports)
 {
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
     uint32_t i;
 
     s->post_load = g_malloc0(sizeof(*s->post_load));
@@ -765,7 +766,7 @@ static int fetch_active_ports_list(QEMUFile *f,
             qemu_get_be64s(f, &port->iov_offset);
 
             port->elem =
-                qemu_get_virtqueue_element(f, sizeof(VirtQueueElement));
+                qemu_get_virtqueue_element(vdev, f, sizeof(VirtQueueElement));
 
             /*
              *  Port was throttled on source machine.  Let's
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 204e14f..ce19eff 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -198,12 +198,14 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     SCSIBus *bus = sreq->bus;
     VirtIOSCSI *s = container_of(bus, VirtIOSCSI, bus);
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
     VirtIOSCSIReq *req;
     uint32_t n;
 
     qemu_get_be32s(f, &n);
     assert(n < vs->conf.num_queues);
-    req = qemu_get_virtqueue_element(f, sizeof(VirtIOSCSIReq) + vs->cdb_size);
+    req = qemu_get_virtqueue_element(vdev, f,
+                                     sizeof(VirtIOSCSIReq) + vs->cdb_size);
     virtio_scsi_init_req(s, vs->cmd_vqs[n], req);
 
     if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index d6c0c72..d31cc00 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -28,6 +28,7 @@
 #include "hw/qdev.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio.h"
+#include "exec/address-spaces.h"
 
 /* #define DEBUG_VIRTIO_BUS */
 
@@ -61,6 +62,13 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
     if (klass->device_plugged != NULL) {
         klass->device_plugged(qbus->parent, errp);
     }
+
+    if (klass->get_dma_as != NULL &&
+        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
+        vdev->dma_as = klass->get_dma_as(qbus->parent);
+    } else {
+        vdev->dma_as = &address_space_memory;
+    }
 }
 
 /* Reset the virtio_bus */
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 21c2b9d..213d57e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1144,6 +1144,14 @@ static int virtio_pci_query_nvectors(DeviceState *d)
     return proxy->nvectors;
 }
 
+static AddressSpace *virtio_pci_get_dma_as(DeviceState *d)
+{
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
+    PCIDevice *dev = &proxy->pci_dev;
+
+    return pci_get_address_space(dev);
+}
+
 static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
                                    struct virtio_pci_cap *cap)
 {
@@ -1601,6 +1609,11 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
     }
 
     if (legacy) {
+        if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
+            error_setg(errp, "VIRTIO_F_IOMMU_PLATFORM was supported by"
+                       "neither legacy nor transitional device.");
+            return ;
+        }
         /* legacy and transitional */
         pci_set_word(config + PCI_SUBSYSTEM_VENDOR_ID,
                      pci_get_word(config + PCI_VENDOR_ID));
@@ -2520,6 +2533,7 @@ static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
     k->query_nvectors = virtio_pci_query_nvectors;
     k->ioeventfd_enabled = virtio_pci_ioeventfd_enabled;
     k->ioeventfd_assign = virtio_pci_ioeventfd_assign;
+    k->get_dma_as = virtio_pci_get_dma_as;
 }
 
 static const TypeInfo virtio_pci_bus_info = {
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d40711a..933a3d7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -23,6 +23,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "migration/migration.h"
 #include "hw/virtio/virtio-access.h"
+#include "sysemu/dma.h"
 
 /*
  * The alignment to use between consumer and producer parts of vring.
@@ -121,7 +122,7 @@ void virtio_queue_update_rings(VirtIODevice *vdev, int n)
 static void vring_desc_read(VirtIODevice *vdev, VRingDesc *desc,
                             hwaddr desc_pa, int i)
 {
-    address_space_read(&address_space_memory, desc_pa + i * sizeof(VRingDesc),
+    address_space_read(vdev->dma_as, desc_pa + i * sizeof(VRingDesc),
                        MEMTXATTRS_UNSPECIFIED, (void *)desc, sizeof(VRingDesc));
     virtio_tswap64s(vdev, &desc->addr);
     virtio_tswap32s(vdev, &desc->len);
@@ -163,7 +164,7 @@ static inline void vring_used_write(VirtQueue *vq, VRingUsedElem *uelem,
     virtio_tswap32s(vq->vdev, &uelem->id);
     virtio_tswap32s(vq->vdev, &uelem->len);
     pa = vq->vring.used + offsetof(VRingUsed, ring[i]);
-    address_space_write(&address_space_memory, pa, MEMTXATTRS_UNSPECIFIED,
+    address_space_write(vq->vdev->dma_as, pa, MEMTXATTRS_UNSPECIFIED,
                        (void *)uelem, sizeof(VRingUsedElem));
 }
 
@@ -249,6 +250,7 @@ int virtio_queue_empty(VirtQueue *vq)
 static void virtqueue_unmap_sg(VirtQueue *vq, const VirtQueueElement *elem,
                                unsigned int len)
 {
+    AddressSpace *dma_as = vq->vdev->dma_as;
     unsigned int offset;
     int i;
 
@@ -256,17 +258,18 @@ static void virtqueue_unmap_sg(VirtQueue *vq, const VirtQueueElement *elem,
     for (i = 0; i < elem->in_num; i++) {
         size_t size = MIN(len - offset, elem->in_sg[i].iov_len);
 
-        cpu_physical_memory_unmap(elem->in_sg[i].iov_base,
-                                  elem->in_sg[i].iov_len,
-                                  1, size);
+        dma_memory_unmap(dma_as, elem->in_sg[i].iov_base,
+                         elem->in_sg[i].iov_len,
+                         DMA_DIRECTION_FROM_DEVICE, size);
 
         offset += size;
     }
 
     for (i = 0; i < elem->out_num; i++)
-        cpu_physical_memory_unmap(elem->out_sg[i].iov_base,
-                                  elem->out_sg[i].iov_len,
-                                  0, elem->out_sg[i].iov_len);
+        dma_memory_unmap(dma_as, elem->out_sg[i].iov_base,
+                         elem->out_sg[i].iov_len,
+                         DMA_DIRECTION_TO_DEVICE,
+                         elem->out_sg[i].iov_len);
 }
 
 /* virtqueue_detach_element:
@@ -560,7 +563,10 @@ static bool virtqueue_map_desc(VirtIODevice *vdev, unsigned int *p_num_sg,
             goto out;
         }
 
-        iov[num_sg].iov_base = cpu_physical_memory_map(pa, &len, is_write);
+        iov[num_sg].iov_base = dma_memory_map(vdev->dma_as, pa, &len,
+                                              is_write ?
+                                              DMA_DIRECTION_FROM_DEVICE :
+                                              DMA_DIRECTION_TO_DEVICE);
         if (!iov[num_sg].iov_base) {
             virtio_error(vdev, "virtio: bogus descriptor or out of resources");
             goto out;
@@ -597,9 +603,9 @@ static void virtqueue_undo_map_desc(unsigned int out_num, unsigned int in_num,
     }
 }
 
-static void virtqueue_map_iovec(struct iovec *sg, hwaddr *addr,
-                                unsigned int *num_sg, unsigned int max_size,
-                                int is_write)
+static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
+                                hwaddr *addr, unsigned int *num_sg,
+                                unsigned int max_size, int is_write)
 {
     unsigned int i;
     hwaddr len;
@@ -618,7 +624,10 @@ static void virtqueue_map_iovec(struct iovec *sg, hwaddr *addr,
 
     for (i = 0; i < *num_sg; i++) {
         len = sg[i].iov_len;
-        sg[i].iov_base = cpu_physical_memory_map(addr[i], &len, is_write);
+        sg[i].iov_base = dma_memory_map(vdev->dma_as,
+                                        addr[i], &len, is_write ?
+                                        DMA_DIRECTION_FROM_DEVICE :
+                                        DMA_DIRECTION_TO_DEVICE);
         if (!sg[i].iov_base) {
             error_report("virtio: error trying to map MMIO memory");
             exit(1);
@@ -630,12 +639,15 @@ static void virtqueue_map_iovec(struct iovec *sg, hwaddr *addr,
     }
 }
 
-void virtqueue_map(VirtQueueElement *elem)
+void virtqueue_map(VirtIODevice *vdev, VirtQueueElement *elem)
 {
-    virtqueue_map_iovec(elem->in_sg, elem->in_addr, &elem->in_num,
-                        VIRTQUEUE_MAX_SIZE, 1);
-    virtqueue_map_iovec(elem->out_sg, elem->out_addr, &elem->out_num,
-                        VIRTQUEUE_MAX_SIZE, 0);
+    virtqueue_map_iovec(vdev, elem->in_sg, elem->in_addr, &elem->in_num,
+                        MIN(ARRAY_SIZE(elem->in_sg), ARRAY_SIZE(elem->in_addr)),
+                        1);
+    virtqueue_map_iovec(vdev, elem->out_sg, elem->out_addr, &elem->out_num,
+                        MIN(ARRAY_SIZE(elem->out_sg),
+                        ARRAY_SIZE(elem->out_addr)),
+                        0);
 }
 
 static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_num)
@@ -788,7 +800,7 @@ typedef struct VirtQueueElementOld {
     struct iovec out_sg[VIRTQUEUE_MAX_SIZE];
 } VirtQueueElementOld;
 
-void *qemu_get_virtqueue_element(QEMUFile *f, size_t sz)
+void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
 {
     VirtQueueElement *elem;
     VirtQueueElementOld data;
@@ -819,7 +831,7 @@ void *qemu_get_virtqueue_element(QEMUFile *f, size_t sz)
         elem->out_sg[i].iov_len = data.out_sg[i].iov_len;
     }
 
-    virtqueue_map(elem);
+    virtqueue_map(vdev, elem);
     return elem;
 }
 
@@ -878,6 +890,11 @@ static int virtio_validate_features(VirtIODevice *vdev)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
 
+    if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM) &&
+        !virtio_vdev_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
+        return -EFAULT;
+    }
+
     if (k->validate_features) {
         return k->validate_features(vdev);
     } else {
-- 
MST
