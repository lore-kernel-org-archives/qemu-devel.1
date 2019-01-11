Received: from eggs.gnu.org ([209.51.188.92]:59400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gi08U-0000ut-Dg
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:58:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gi08R-0001hs-GZ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:58:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1gi08R-0001gu-03
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:58:19 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 11 Jan 2019 17:58:00 +0100
Message-Id: <20190111165801.15181-2-eric.auger@redhat.com>
In-Reply-To: <20190111165801.15181-1-eric.auger@redhat.com>
References: <20190111165801.15181-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] vfio-pci: Introduce
 vfio_register_event_notifier helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com

The code used to attach the eventfd handler for the ERR and
REQ irq indices can be factorized into a helper. In subsequent
patches we will extend this helper to support other irq indices.

We test the notification is allowed outside of the helper:
respectively check vdev->pci_aer and VFIO_FEATURE_ENABLE_REQ.
Depending on the returned value we set vdev->pci_aer and
vdev->req_enabled. An error handle is introduced for future usage
although not strictly useful here.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/pci.c | 291 ++++++++++++++++++++++----------------------------
 1 file changed, 127 insertions(+), 164 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c0cb1ec289..c589a4e666 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -105,6 +105,95 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
     vfio_unmask_single_irqindex(vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 }
 
+/*
+ * vfio_register_event_notifier - setup/tear down eventfd
+ * notification and handling for IRQ indices that span over
+ * a single IRQ
+ *
+ * @vdev: VFIO device handle
+ * @index: IRQ index the eventfd/handler is associated to
+ * @target_state: true means notifier needs to be set up
+ * @handler to attach if @target_state is true
+ * @errp error handle
+ */
+static int vfio_register_event_notifier(VFIOPCIDevice *vdev,
+                                        int index,
+                                        bool target_state,
+                                        void (*handler)(void *opaque),
+                                        Error **errp)
+{
+    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
+                                      .index = index };
+    struct vfio_irq_set *irq_set;
+    EventNotifier *notifier;
+    int argsz, ret = 0;
+    int32_t *pfd, fd;
+
+    switch (index) {
+    case VFIO_PCI_REQ_IRQ_INDEX:
+        notifier = &vdev->req_notifier;
+        break;
+    case VFIO_PCI_ERR_IRQ_INDEX:
+        notifier = &vdev->err_notifier;
+        break;
+    default:
+        return -EINVAL;
+    }
+
+    if (ioctl(vdev->vbasedev.fd,
+              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count < 1) {
+        error_setg_errno(errp, errno,
+                         "no irq index %d available", index);
+        return -EINVAL;
+    }
+
+    if (target_state) {
+        ret = event_notifier_init(notifier, 0);
+        if (ret) {
+            error_setg_errno(errp, -ret,
+                             "Unable to init event notifier for irq index %d",
+                             index);
+            return ret;
+        }
+    }
+
+    argsz = sizeof(*irq_set) + sizeof(*pfd);
+
+    irq_set = g_malloc0(argsz);
+    irq_set->argsz = argsz;
+    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
+                     VFIO_IRQ_SET_ACTION_TRIGGER;
+    irq_set->index = index;
+    irq_set->start = 0;
+    irq_set->count = 1;
+    pfd = (int32_t *)&irq_set->data;
+
+    if (!notifier) {
+        return -EINVAL;
+    }
+
+    fd = event_notifier_get_fd(notifier);
+
+    if (target_state) {
+        qemu_set_fd_handler(fd, handler, NULL, vdev);
+        *pfd = fd;
+    } else {
+        qemu_set_fd_handler(fd, NULL, NULL, vdev);
+        event_notifier_cleanup(notifier);
+        *pfd = -1;
+    }
+
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
+    g_free(irq_set);
+
+    if (ret) {
+        error_setg_errno(errp, -ret,
+                         "vfio: Failed to %s eventfd signalling for index %d",
+                         *pfd < 0 ? "set up" : "tear down", index);
+    }
+    return ret;
+}
+
 static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
 #ifdef CONFIG_KVM
@@ -2621,86 +2710,6 @@ static void vfio_err_notifier_handler(void *opaque)
     vm_stop(RUN_STATE_INTERNAL_ERROR);
 }
 
-/*
- * Registers error notifier for devices supporting error recovery.
- * If we encounter a failure in this function, we report an error
- * and continue after disabling error recovery support for the
- * device.
- */
-static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
-{
-    int ret;
-    int argsz;
-    struct vfio_irq_set *irq_set;
-    int32_t *pfd;
-
-    if (!vdev->pci_aer) {
-        return;
-    }
-
-    if (event_notifier_init(&vdev->err_notifier, 0)) {
-        error_report("vfio: Unable to init event notifier for error detection");
-        vdev->pci_aer = false;
-        return;
-    }
-
-    argsz = sizeof(*irq_set) + sizeof(*pfd);
-
-    irq_set = g_malloc0(argsz);
-    irq_set->argsz = argsz;
-    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
-                     VFIO_IRQ_SET_ACTION_TRIGGER;
-    irq_set->index = VFIO_PCI_ERR_IRQ_INDEX;
-    irq_set->start = 0;
-    irq_set->count = 1;
-    pfd = (int32_t *)&irq_set->data;
-
-    *pfd = event_notifier_get_fd(&vdev->err_notifier);
-    qemu_set_fd_handler(*pfd, vfio_err_notifier_handler, NULL, vdev);
-
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
-    if (ret) {
-        error_report("vfio: Failed to set up error notification");
-        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
-        event_notifier_cleanup(&vdev->err_notifier);
-        vdev->pci_aer = false;
-    }
-    g_free(irq_set);
-}
-
-static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
-{
-    int argsz;
-    struct vfio_irq_set *irq_set;
-    int32_t *pfd;
-    int ret;
-
-    if (!vdev->pci_aer) {
-        return;
-    }
-
-    argsz = sizeof(*irq_set) + sizeof(*pfd);
-
-    irq_set = g_malloc0(argsz);
-    irq_set->argsz = argsz;
-    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
-                     VFIO_IRQ_SET_ACTION_TRIGGER;
-    irq_set->index = VFIO_PCI_ERR_IRQ_INDEX;
-    irq_set->start = 0;
-    irq_set->count = 1;
-    pfd = (int32_t *)&irq_set->data;
-    *pfd = -1;
-
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
-    if (ret) {
-        error_report("vfio: Failed to de-assign error fd: %m");
-    }
-    g_free(irq_set);
-    qemu_set_fd_handler(event_notifier_get_fd(&vdev->err_notifier),
-                        NULL, NULL, vdev);
-    event_notifier_cleanup(&vdev->err_notifier);
-}
-
 static void vfio_req_notifier_handler(void *opaque)
 {
     VFIOPCIDevice *vdev = opaque;
@@ -2716,86 +2725,6 @@ static void vfio_req_notifier_handler(void *opaque)
     }
 }
 
-static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
-{
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
-                                      .index = VFIO_PCI_REQ_IRQ_INDEX };
-    int argsz;
-    struct vfio_irq_set *irq_set;
-    int32_t *pfd;
-
-    if (!(vdev->features & VFIO_FEATURE_ENABLE_REQ)) {
-        return;
-    }
-
-    if (ioctl(vdev->vbasedev.fd,
-              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count < 1) {
-        return;
-    }
-
-    if (event_notifier_init(&vdev->req_notifier, 0)) {
-        error_report("vfio: Unable to init event notifier for device request");
-        return;
-    }
-
-    argsz = sizeof(*irq_set) + sizeof(*pfd);
-
-    irq_set = g_malloc0(argsz);
-    irq_set->argsz = argsz;
-    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
-                     VFIO_IRQ_SET_ACTION_TRIGGER;
-    irq_set->index = VFIO_PCI_REQ_IRQ_INDEX;
-    irq_set->start = 0;
-    irq_set->count = 1;
-    pfd = (int32_t *)&irq_set->data;
-
-    *pfd = event_notifier_get_fd(&vdev->req_notifier);
-    qemu_set_fd_handler(*pfd, vfio_req_notifier_handler, NULL, vdev);
-
-    if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
-        error_report("vfio: Failed to set up device request notification");
-        qemu_set_fd_handler(*pfd, NULL, NULL, vdev);
-        event_notifier_cleanup(&vdev->req_notifier);
-    } else {
-        vdev->req_enabled = true;
-    }
-
-    g_free(irq_set);
-}
-
-static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
-{
-    int argsz;
-    struct vfio_irq_set *irq_set;
-    int32_t *pfd;
-
-    if (!vdev->req_enabled) {
-        return;
-    }
-
-    argsz = sizeof(*irq_set) + sizeof(*pfd);
-
-    irq_set = g_malloc0(argsz);
-    irq_set->argsz = argsz;
-    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
-                     VFIO_IRQ_SET_ACTION_TRIGGER;
-    irq_set->index = VFIO_PCI_REQ_IRQ_INDEX;
-    irq_set->start = 0;
-    irq_set->count = 1;
-    pfd = (int32_t *)&irq_set->data;
-    *pfd = -1;
-
-    if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
-        error_report("vfio: Failed to de-assign device request fd: %m");
-    }
-    g_free(irq_set);
-    qemu_set_fd_handler(event_notifier_get_fd(&vdev->req_notifier),
-                        NULL, NULL, vdev);
-    event_notifier_cleanup(&vdev->req_notifier);
-
-    vdev->req_enabled = false;
-}
-
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev = PCI_VFIO(pdev);
@@ -3069,8 +2998,29 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto out_teardown;
     }
 
-    vfio_register_err_notifier(vdev);
-    vfio_register_req_notifier(vdev);
+    if (vdev->pci_aer) {
+        /*
+         * Registers error notifier for devices supporting error recovery.
+         * If we encounter a failure in this function, we report an error
+         * and continue after disabling error recovery support for the
+         * device.
+         */
+        vdev->pci_aer =
+            !vfio_register_event_notifier(vdev, VFIO_PCI_ERR_IRQ_INDEX, true,
+                                          vfio_err_notifier_handler, &err);
+        if (err) {
+            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+        }
+    }
+
+    if (vdev->features & VFIO_FEATURE_ENABLE_REQ) {
+        vdev->req_enabled =
+            !vfio_register_event_notifier(vdev, VFIO_PCI_REQ_IRQ_INDEX, true,
+                                          vfio_req_notifier_handler, &err);
+        if (err) {
+            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+        }
+    }
     vfio_setup_resetfn_quirk(vdev);
 
     return;
@@ -3106,9 +3056,22 @@ static void vfio_instance_finalize(Object *obj)
 static void vfio_exitfn(PCIDevice *pdev)
 {
     VFIOPCIDevice *vdev = PCI_VFIO(pdev);
+    Error *err = NULL;
 
-    vfio_unregister_req_notifier(vdev);
-    vfio_unregister_err_notifier(vdev);
+    if (vdev->req_enabled) {
+        vfio_register_event_notifier(vdev, VFIO_PCI_REQ_IRQ_INDEX,
+                                     false, NULL, &err);
+        if (err) {
+            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+        }
+    }
+    if (vdev->pci_aer) {
+        vfio_register_event_notifier(vdev, VFIO_PCI_ERR_IRQ_INDEX,
+                                     false, NULL, &err);
+        if (err) {
+            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+        }
+    }
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
     vfio_disable_interrupts(vdev);
     if (vdev->intx.mmap_timer) {
-- 
2.17.2
