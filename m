Received: from eggs.gnu.org ([2001:4830:134:3::10]:48666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1elJL5-0001ND-7B
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1elJL3-0005Jp-RF
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:00:31 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon, 12 Feb 2018 18:58:17 +0000
Message-Id: <1518461904-5305-16-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1518461904-5305-1-git-send-email-eric.auger@redhat.com>
References: <1518461904-5305-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v6 15/22] virtio-iommu: Implement fault reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

The event queue allows to report asynchronous errors.
The translate function now injects faults when relevant.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/trace-events   |  1 +
 hw/virtio/virtio-iommu.c | 67 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index e3a916c..ce718e8 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -54,3 +54,4 @@ virtio_iommu_unmap_inc_interval(uint64_t low, uint64_t high) "Unmap inc [0x%"PRI
 virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
 virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t addr, uint64_t size, uint32_t flags, size_t filled) "dev= %d, subtype=%d addr=0x%"PRIx64" size=0x%"PRIx64" flags=%d filled=0x%lx"
 virtio_iommu_fill_none_property(uint32_t devid) "devid=%d"
+virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uint64_t addr) "FAULT reason=%d flags=%d endpoint=%d address =0x%"PRIx64
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index c81a24b..010e8e0 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -697,15 +697,61 @@ push:
     }
 }
 
+static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reason,
+                                      uint32_t flags, uint32_t endpoint,
+                                      uint64_t address)
+{
+    VirtIODevice *vdev = &viommu->parent_obj;
+    VirtQueue *vq = viommu->event_vq;
+    struct virtio_iommu_fault fault;
+    VirtQueueElement *elem;
+    size_t sz;
+
+    memset(&fault, 0, sizeof(fault));
+    fault.reason = reason;
+    fault.flags = flags;
+    fault.endpoint = endpoint;
+    fault.address = address;
+
+    for (;;) {
+        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+
+        if (!elem) {
+            virtio_error(vdev,
+                         "no buffer available in event queue to report event");
+            return;
+        }
+
+        if (iov_size(elem->in_sg, elem->in_num) < sizeof(fault)) {
+            virtio_error(vdev, "error buffer of wrong size");
+            virtqueue_detach_element(vq, elem, 0);
+            g_free(elem);
+            continue;
+        }
+        break;
+    }
+    /* we have a buffer to fill in */
+    sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
+                      &fault, sizeof(fault));
+    assert(sz == sizeof(fault));
+
+    trace_virtio_iommu_report_fault(reason, flags, endpoint, address);
+    virtqueue_push(vq, elem, sz);
+    virtio_notify(vdev, vq);
+    g_free(elem);
+
+}
+
 static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                                             IOMMUAccessFlags flag)
 {
     IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
     VirtIOIOMMU *s = sdev->viommu;
-    uint32_t sid;
+    uint32_t sid, flags;
     viommu_endpoint *ep;
     viommu_mapping *mapping;
     viommu_interval interval;
+    bool read_fault, write_fault;
 
     interval.low = addr;
     interval.high = addr + 1;
@@ -726,6 +772,8 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(sid));
     if (!ep) {
         error_report("%s sid=%d is not known!!", __func__, sid);
+        virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_UNKNOWN,
+                                  0, sid, 0);
         goto unlock;
     }
 
@@ -733,6 +781,8 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s %02x:%02x.%01x not attached to any domain\n",
                       __func__, PCI_BUS_NUM(sid), PCI_SLOT(sid), PCI_FUNC(sid));
+        virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_DOMAIN,
+                                  0, sid, 0);
         goto unlock;
     }
 
@@ -741,14 +791,25 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s no mapping for 0x%"PRIx64" for sid=%d\n",
                       __func__, addr, sid);
+        virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
+                                  0, sid, addr);
         goto unlock;
     }
 
-    if (((flag & IOMMU_RO) && !(mapping->flags & VIRTIO_IOMMU_MAP_F_READ)) ||
-        ((flag & IOMMU_WO) && !(mapping->flags & VIRTIO_IOMMU_MAP_F_WRITE))) {
+    read_fault = (flag & IOMMU_RO) &&
+                    !(mapping->flags & VIRTIO_IOMMU_MAP_F_READ);
+    write_fault = (flag & IOMMU_WO) &&
+                    !(mapping->flags & VIRTIO_IOMMU_MAP_F_WRITE);
+
+    flags = read_fault ? VIRTIO_IOMMU_FAULT_F_READ : 0;
+    flags |= write_fault ? VIRTIO_IOMMU_FAULT_F_WRITE : 0;
+    if (flags) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Permission error on 0x%"PRIx64"(%d): allowed=%d\n",
                       addr, flag, mapping->flags);
+        flags |= VIRTIO_IOMMU_FAULT_F_ADDRESS;
+        virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPING,
+                                  flags, sid, addr);
         goto unlock;
     }
     entry.translated_addr = addr - mapping->virt_addr + mapping->phys_addr;
-- 
1.9.1
