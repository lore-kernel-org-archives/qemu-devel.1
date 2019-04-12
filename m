Received: from eggs.gnu.org ([209.51.188.92]:38887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt5D-0003Pl-5Q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt5C-0005Vm-6w
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:06:55 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 12 Apr 2019 12:03:52 +0200
Message-Id: <20190412100354.6409-26-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v3 25/27] vfio-pci: register handler for iommu
 fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: alex.williamson@redhat.com, mst@redhat.com, jean-philippe.brucker@arm.com, peterx@redhat.com, yi.l.liu@intel.com, vincent.stehle@arm.com

We use the VFIO_PCI_DMA_FAULT_IRQ_INDEX "irq" index to set/unset
a notifier for physical DMA faults. The associated eventfd is
triggered, in nested mode, whenever a fault is detected at IOMMU
physical level.

The actual handler will be implemented in subsequent patches.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
---
 hw/vfio/pci.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h |  1 +
 2 files changed, 46 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index aeb4dfa388..91714cea84 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2722,6 +2722,49 @@ static void vfio_unregister_req_notifier(VFIOPCIDe=
vice *vdev)
     vdev->req_enabled =3D false;
 }
=20
+static void vfio_dma_fault_notifier_handler(void *opaque)
+{
+    VFIOPCIDevice *vdev =3D opaque;
+
+    if (!event_notifier_test_and_clear(&vdev->dma_fault_notifier)) {
+        return;
+    }
+}
+
+static void vfio_register_dma_fault_notifier(VFIOPCIDevice *vdev)
+{
+    Error *err =3D NULL;
+    int32_t fd;
+
+    if (event_notifier_init(&vdev->dma_fault_notifier, 0)) {
+        error_report("vfio: Unable to init event notifier for dma fault"=
);
+        return;
+    }
+
+    fd =3D event_notifier_get_fd(&vdev->dma_fault_notifier);
+    qemu_set_fd_handler(fd, vfio_dma_fault_notifier_handler, NULL, vdev)=
;
+
+    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_DMA_FAULT_IRQ_I=
NDEX, 0,
+                           VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+        qemu_set_fd_handler(fd, NULL, NULL, vdev);
+        event_notifier_cleanup(&vdev->dma_fault_notifier);
+    }
+}
+
+static void vfio_unregister_dma_fault_notifier(VFIOPCIDevice *vdev)
+{
+    Error *err =3D NULL;
+
+    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_DMA_FAULT_IRQ_I=
NDEX, 0,
+                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
+        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+    }
+    qemu_set_fd_handler(event_notifier_get_fd(&vdev->dma_fault_notifier)=
,
+                        NULL, NULL, vdev);
+    event_notifier_cleanup(&vdev->dma_fault_notifier);
+}
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev =3D PCI_VFIO(pdev);
@@ -3007,6 +3050,7 @@ static void vfio_realize(PCIDevice *pdev, Error **e=
rrp)
=20
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
+    vfio_register_dma_fault_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
=20
     return;
@@ -3045,6 +3089,7 @@ static void vfio_exitfn(PCIDevice *pdev)
=20
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
+    vfio_unregister_dma_fault_notifier(vdev);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
     vfio_disable_interrupts(vdev);
     if (vdev->intx.mmap_timer) {
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c11c3f1670..55b14a1ece 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -135,6 +135,7 @@ typedef struct VFIOPCIDevice {
     PCIHostDeviceAddress host;
     EventNotifier err_notifier;
     EventNotifier req_notifier;
+    EventNotifier dma_fault_notifier;
     int (*resetfn)(struct VFIOPCIDevice *);
     uint32_t vendor_id;
     uint32_t device_id;
--=20
2.20.1
