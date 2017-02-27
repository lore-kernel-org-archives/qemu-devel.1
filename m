Received: from eggs.gnu.org ([2001:4830:134:3::10]:52023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1ciFeC-0001VF-UZ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 02:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1ciFe8-0004ER-CC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 02:23:04 -0500
Received: from [59.151.112.132] (port=42321 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1ciFe7-0004E1-42
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 02:23:00 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Mon, 27 Feb 2017 15:30:27 +0800
Message-ID: <1488180627-18258-4-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1488180627-18258-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1488180627-18258-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3] vfio-pci: process non fatal error of AER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.williamson@redhat.com, izumi.taku@jp.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

Make use of the non fatal error eventfd that the kernel module provide
to process the AER non fatal error. Fatal error still goes into the
legacy way which results in VM stop.

Register the handler, wait for notification. Construct aer message and
pass it to root port on notification. Root port will trigger an interrupt
to signal guest, then, the guest driver will do the recovery.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/vfio/pci.c              | 139 +++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h              |   2 +
 linux-headers/linux/vfio.h |   1 +
 3 files changed, 142 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3d0d005..55c6e05 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2422,6 +2422,21 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
                      "Could not enable error recovery for the device",
                      vbasedev->name);
     }
+
+    irq_info.index = VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX;
+    irq_info.count = 0; /* clear */
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    if (ret) {
+        /* This can fail for an old kernel or legacy PCI dev */
+        trace_vfio_populate_device_get_irq_info_failure();
+    } else if (irq_info.count == 1) {
+        vdev->pci_aer_non_fatal = true;
+    } else {
+        error_report(WARN_PREFIX
+                     "Couldn't enable non fatal error recovery for the device",
+                     vbasedev->name);
+    }
+
 }
 
 static void vfio_put_device(VFIOPCIDevice *vdev)
@@ -2432,6 +2447,128 @@ static void vfio_put_device(VFIOPCIDevice *vdev)
     vfio_put_base_device(&vdev->vbasedev);
 }
 
+static void vfio_non_fatal_err_notifier_handler(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+    PCIDevice *dev = &vdev->pdev;
+    PCIEAERMsg msg = {
+        .severity = PCI_ERR_ROOT_CMD_NONFATAL_EN,
+        .source_id = (pci_bus_num(dev->bus) << 8) | dev->devfn,
+    };
+
+    if (!event_notifier_test_and_clear(&vdev->non_fatal_err_notifier)) {
+        return;
+    }
+
+    /* Populate the aer msg and send it to root port */
+    if (dev->exp.aer_cap) {
+        uint8_t *aer_cap = dev->config + dev->exp.aer_cap;
+        uint32_t uncor_status;
+        bool isfatal;
+
+        uncor_status = vfio_pci_read_config(dev,
+                            dev->exp.aer_cap + PCI_ERR_UNCOR_STATUS, 4);
+        if (!uncor_status) {
+            return;
+        }
+
+        isfatal = uncor_status & pci_get_long(aer_cap + PCI_ERR_UNCOR_SEVER);
+        if (isfatal) {
+            goto stop;
+        }
+
+        error_report("%s sending non fatal event to root port. uncor status = "
+                     "0x%"PRIx32, vdev->vbasedev.name, uncor_status);
+        pcie_aer_msg(dev, &msg);
+        return;
+    }
+
+stop:
+    /* Terminate the guest in case of fatal error */
+    error_report("%s(%s) fatal error detected. Please collect any data"
+            " possible and then kill the guest", __func__, vdev->vbasedev.name);
+    vm_stop(RUN_STATE_INTERNAL_ERROR);
+}
+
+/*
+ * Register non fatal error notifier for devices supporting error recovery.
+ * If we encounter a failure in this function, we report an error
+ * and continue after disabling error recovery support for the device.
+ */
+static void vfio_register_non_fatal_err_notifier(VFIOPCIDevice *vdev)
+{
+    int ret;
+    int argsz;
+    struct vfio_irq_set *irq_set;
+    int32_t *pfd;
+
+    if (!vdev->pci_aer_non_fatal) {
+        return;
+    }
+
+    if (event_notifier_init(&vdev->non_fatal_err_notifier, 0)) {
+        error_report("vfio: Unable to init event notifier for non-fatal error detection");
+        vdev->pci_aer_non_fatal = false;
+        return;
+    }
+
+    argsz = sizeof(*irq_set) + sizeof(*pfd);
+
+    irq_set = g_malloc0(argsz);
+    irq_set->argsz = argsz;
+    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
+                     VFIO_IRQ_SET_ACTION_TRIGGER;
+    irq_set->index = VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX;
+    irq_set->start = 0;
+    irq_set->count = 1;
+    pfd = (int32_t *)&irq_set->data;
+
+    *pfd = event_notifier_get_fd(&vdev->non_fatal_err_notifier);
+    qemu_set_fd_handler(*pfd, vfio_non_fatal_err_notifier_handler, NULL, vdev);
+
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
+    if (ret) {
+        error_report("vfio: Failed to set up non-fatal error notification");
+        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
+        event_notifier_cleanup(&vdev->non_fatal_err_notifier);
+        vdev->pci_aer_non_fatal = false;
+    }
+    g_free(irq_set);
+}
+
+static void vfio_unregister_non_fatal_err_notifier(VFIOPCIDevice *vdev)
+{
+    int argsz;
+    struct vfio_irq_set *irq_set;
+    int32_t *pfd;
+    int ret;
+
+    if (!vdev->pci_aer_non_fatal) {
+        return;
+    }
+
+    argsz = sizeof(*irq_set) + sizeof(*pfd);
+
+    irq_set = g_malloc0(argsz);
+    irq_set->argsz = argsz;
+    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
+                     VFIO_IRQ_SET_ACTION_TRIGGER;
+    irq_set->index = VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX;
+    irq_set->start = 0;
+    irq_set->count = 1;
+    pfd = (int32_t *)&irq_set->data;
+    *pfd = -1;
+
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
+    if (ret) {
+        error_report("vfio: Failed to de-assign error fd: %m");
+    }
+    g_free(irq_set);
+    qemu_set_fd_handler(event_notifier_get_fd(&vdev->non_fatal_err_notifier),
+                        NULL, NULL, vdev);
+    event_notifier_cleanup(&vdev->non_fatal_err_notifier);
+}
+
 static void vfio_err_notifier_handler(void *opaque)
 {
     VFIOPCIDevice *vdev = opaque;
@@ -2860,6 +2997,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
+    vfio_register_non_fatal_err_notifier(vdev);
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
@@ -2900,6 +3038,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
+    vfio_unregister_non_fatal_err_notifier(vdev);
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
     vfio_disable_interrupts(vdev);
     if (vdev->intx.mmap_timer) {
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 34e8b04..9d83349 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -119,6 +119,7 @@ typedef struct VFIOPCIDevice {
     void *igd_opregion;
     PCIHostDeviceAddress host;
     EventNotifier err_notifier;
+    EventNotifier non_fatal_err_notifier;
     EventNotifier req_notifier;
     int (*resetfn)(struct VFIOPCIDevice *);
     uint32_t vendor_id;
@@ -137,6 +138,7 @@ typedef struct VFIOPCIDevice {
     uint32_t igd_gms;
     uint8_t pm_cap;
     bool pci_aer;
+    bool pci_aer_non_fatal;
     bool req_enabled;
     bool has_flr;
     bool has_pm_reset;
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 759b850..c8f699c 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -433,6 +433,7 @@ enum {
 	VFIO_PCI_MSIX_IRQ_INDEX,
 	VFIO_PCI_ERR_IRQ_INDEX,
 	VFIO_PCI_REQ_IRQ_INDEX,
+	VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX,
 	VFIO_PCI_NUM_IRQS
 };
 
-- 
1.8.3.1
