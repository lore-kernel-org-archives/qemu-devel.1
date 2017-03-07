Received: from eggs.gnu.org ([2001:4830:134:3::10]:60136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clAUt-0002h2-6n
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1clAUq-0007Ts-27
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:29:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1clAUp-0007TB-PO
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 03:29:27 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 859D483F45
	for <qemu-devel@nongnu.org>; Tue,  7 Mar 2017 08:29:27 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Date: Tue,  7 Mar 2017 16:29:21 +0800
Message-Id: <1488875361-4959-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH V2] virtio: do not require IOMMU to be created
 in advance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel@redhat.com, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

After commit 96a8821d2141 ("virtio: unbreak virtio-pci with IOMMU
after caching ring translations"), IOMMU was required to be created in
advance. This is because we can only get the correct dma_as after pci
IOMMU (e.g intel_iommu) was initialized. This is suboptimal and
inconvenient for user. This patch releases this by:

- introduce a bus_master_ready method for PCIDeviceClass and trigger
  this during pci_init_bus_master
- implement virtio-pci method and 1) reset the dma_as 2) re-register
  the memory listener to the new dma_as

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes from v1:
- only call bus_master_ready() from pcibus_machine_done() to avoid
  break hotplug.
---
 hw/pci/pci.c               |  7 ++++++-
 hw/virtio/virtio-pci.c     |  9 +++++++++
 hw/virtio/virtio.c         | 19 +++++++++++++++++++
 include/hw/pci/pci.h       |  1 +
 include/hw/virtio/virtio.h |  1 +
 5 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 273f1e4..df82863 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -99,7 +99,12 @@ static void pcibus_machine_done(Notifier *notifier, void *data)
 
     for (i = 0; i < ARRAY_SIZE(bus->devices); ++i) {
         if (bus->devices[i]) {
-            pci_init_bus_master(bus->devices[i]);
+            PCIDevice *pci_dev = bus->devices[i];
+            PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
+            pci_init_bus_master(pci_dev);
+            if (pc->bus_master_ready) {
+                pc->bus_master_ready(pci_dev);
+            }
         }
     }
 }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b76f3f6..21cbda2 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1845,6 +1845,14 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
     address_space_destroy(&proxy->modern_as);
 }
 
+static void virtio_pci_bus_master_ready(PCIDevice *pci_dev)
+{
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+
+    virtio_device_reset_dma_as(vdev);
+}
+
 static void virtio_pci_reset(DeviceState *qdev)
 {
     VirtIOPCIProxy *proxy = VIRTIO_PCI(qdev);
@@ -1904,6 +1912,7 @@ static void virtio_pci_class_init(ObjectClass *klass, void *data)
     dc->props = virtio_pci_properties;
     k->realize = virtio_pci_realize;
     k->exit = virtio_pci_exit;
+    k->bus_master_ready = virtio_pci_bus_master_ready;
     k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     k->revision = VIRTIO_PCI_ABI_VERSION;
     k->class_id = PCI_CLASS_OTHERS;
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index efce4b3..09f4cf4 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2594,6 +2594,25 @@ bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
     return virtio_bus_ioeventfd_enabled(vbus);
 }
 
+void virtio_device_reset_dma_as(VirtIODevice *vdev)
+{
+    DeviceState *qdev = DEVICE(vdev);
+    BusState *qbus = BUS(qdev_get_parent_bus(qdev));
+    VirtioBusState *bus = VIRTIO_BUS(qbus);
+    VirtioBusClass *klass = VIRTIO_BUS_GET_CLASS(bus);
+    bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
+
+    if (klass->get_dma_as != NULL && has_iommu) {
+        vdev->dma_as = klass->get_dma_as(qbus->parent);
+    } else {
+        vdev->dma_as = &address_space_memory;
+    }
+
+    memory_listener_unregister(&vdev->listener);
+    memory_listener_register(&vdev->listener, vdev->dma_as);
+}
+
+
 static const TypeInfo virtio_device_info = {
     .name = TYPE_VIRTIO_DEVICE,
     .parent = TYPE_DEVICE,
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 9349acb..e700a58 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -207,6 +207,7 @@ typedef struct PCIDeviceClass {
 
     void (*realize)(PCIDevice *dev, Error **errp);
     int (*init)(PCIDevice *dev);/* TODO convert to realize() and remove */
+    void (*bus_master_ready)(PCIDevice *dev);
     PCIUnregisterFunc *exit;
     PCIConfigReadFunc *config_read;
     PCIConfigWriteFunc *config_write;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 15efcf2..21fa273 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -283,6 +283,7 @@ void virtio_device_stop_ioeventfd(VirtIODevice *vdev);
 int virtio_device_grab_ioeventfd(VirtIODevice *vdev);
 void virtio_device_release_ioeventfd(VirtIODevice *vdev);
 bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev);
+void virtio_device_reset_dma_as(VirtIODevice *vdev);
 EventNotifier *virtio_queue_get_host_notifier(VirtQueue *vq);
 void virtio_queue_host_notifier_read(EventNotifier *n);
 void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
-- 
2.7.4
