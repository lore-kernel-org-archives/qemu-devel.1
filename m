Received: from eggs.gnu.org ([2001:4830:134:3::10]:39168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f6dwC-0005om-Cr
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f6dw9-0007Uk-97
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:15:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:48812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1f6dw8-0007PY-Rv
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:14:57 -0400
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu, 12 Apr 2018 23:12:30 +0800
Message-Id: <20180412151232.17506-5-tiwei.bie@intel.com>
In-Reply-To: <20180412151232.17506-1-tiwei.bie@intel.com>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [PATCH v3 4/6] virtio: support setting memory region
 based host notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com, tiwei.bie@intel.com

This patch introduces the support for setting memory region
based host notifiers for virtio device. This is helpful when
using a hardware accelerator for a virtio device, because
hardware heavily depends on the notification, this will allow
the guest driver in the VM to notify the hardware directly.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 hw/virtio/virtio-pci.c         | 22 ++++++++++++++++++++++
 hw/virtio/virtio.c             | 13 +++++++++++++
 include/hw/virtio/virtio-bus.h |  2 ++
 include/hw/virtio/virtio.h     |  2 ++
 4 files changed, 39 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1e8ab7bbc5..5eb0c323ca 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1037,6 +1037,27 @@ assign_error:
     return r;
 }
 
+static int virtio_pci_set_host_notifier_mr(DeviceState *d, int n,
+                                           MemoryRegion *mr, bool assign)
+{
+    VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
+    int offset;
+
+    if (n >= VIRTIO_QUEUE_MAX || !virtio_pci_modern(proxy) ||
+        virtio_pci_queue_mem_mult(proxy) != memory_region_size(mr)) {
+        return -1;
+    }
+
+    if (assign) {
+        offset = virtio_pci_queue_mem_mult(proxy) * n;
+        memory_region_add_subregion_overlap(&proxy->notify.mr, offset, mr, 1);
+    } else {
+        memory_region_del_subregion(&proxy->notify.mr, mr);
+    }
+
+    return 0;
+}
+
 static void virtio_pci_vmstate_change(DeviceState *d, bool running)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
@@ -2652,6 +2673,7 @@ static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
     k->has_extra_state = virtio_pci_has_extra_state;
     k->query_guest_notifiers = virtio_pci_query_guest_notifiers;
     k->set_guest_notifiers = virtio_pci_set_guest_notifiers;
+    k->set_host_notifier_mr = virtio_pci_set_host_notifier_mr;
     k->vmstate_change = virtio_pci_vmstate_change;
     k->pre_plugged = virtio_pci_pre_plugged;
     k->device_plugged = virtio_pci_device_plugged;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 006d3d1148..1debb0147b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2454,6 +2454,19 @@ EventNotifier *virtio_queue_get_host_notifier(VirtQueue *vq)
     return &vq->host_notifier;
 }
 
+int virtio_queue_set_host_notifier_mr(VirtIODevice *vdev, int n,
+                                      MemoryRegion *mr, bool assign)
+{
+    BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+
+    if (k->set_host_notifier_mr) {
+        return k->set_host_notifier_mr(qbus->parent, n, mr, assign);
+    }
+
+    return -1;
+}
+
 void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name)
 {
     g_free(vdev->bus_name);
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index ced3d2d2b0..7fec9dc929 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -52,6 +52,8 @@ typedef struct VirtioBusClass {
     bool (*has_extra_state)(DeviceState *d);
     bool (*query_guest_notifiers)(DeviceState *d);
     int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
+    int (*set_host_notifier_mr)(DeviceState *d, int n,
+                                MemoryRegion *mr, bool assign);
     void (*vmstate_change)(DeviceState *d, bool running);
     /*
      * Expose the features the transport layer supports before
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 098bdaaea3..9c1fa07d6d 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -239,6 +239,8 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align);
 void virtio_queue_notify(VirtIODevice *vdev, int n);
 uint16_t virtio_queue_vector(VirtIODevice *vdev, int n);
 void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector);
+int virtio_queue_set_host_notifier_mr(VirtIODevice *vdev, int n,
+                                      MemoryRegion *mr, bool assign);
 int virtio_set_status(VirtIODevice *vdev, uint8_t val);
 void virtio_reset(void *opaque);
 void virtio_update_irq(VirtIODevice *vdev);
-- 
2.11.0
