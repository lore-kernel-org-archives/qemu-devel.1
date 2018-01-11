Received: from eggs.gnu.org ([2001:4830:134:3::10]:44467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eZTBB-0004z3-By
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eZTB6-00031E-Cm
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41764
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eZTB6-0002zw-0T
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:16 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0B34ExJ088668
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:05:15 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fdy5ah9rd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:05:15 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 10 Jan 2018 20:05:14 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 11 Jan 2018 04:04:57 +0100
In-Reply-To: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
References: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20180111030459.33757-4-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 3/5] vfio/ccw: get irq info and set up
 handler for chp irq
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

vfio-ccw now resorts to the eventfd mechanism to communicate
with userland for channel path related event. To get notification
of the channel path event, userland basically needs to:
1. check the chp irq capability via issuing VFIO_DEVICE_GET_IRQ_INFO
   ioctl with VFIO_CCW_CHP_IRQ_INDEX.
2. register an event notifier to get an eventfd fd.
3. register the eventfd for chp irq to kernel via
   VFIO_DEVICE_SET_IRQS ioctl.

This work introduces vfio_ccw_chp_notifier_handler(), and refactors
vfio_ccw_(un)register_event_notifier() to do the above.

Based on this, future work could read channel path information
out once got the eventfd signal, and do further process.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/vfio/ccw.c | 92 +++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index e673695509..d812cecfe0 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -36,6 +36,8 @@ typedef struct VFIOCCWDevice {
     uint64_t schib_region_size;
     uint64_t schib_region_offset;
     struct ccw_schib_region *schib_region;
+
+    EventNotifier chp_notifier;
 } VFIOCCWDevice;
 
 static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
@@ -172,33 +174,56 @@ read_err:
     css_inject_io_interrupt(sch);
 }
 
-static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
+static void vfio_ccw_chp_notifier_handler(void *opaque)
+{
+    VFIOCCWDevice *vcdev = opaque;
+
+    if (!event_notifier_test_and_clear(&vcdev->chp_notifier)) {
+        return;
+    }
+
+    /* TODO: further process on path informaion. */
+}
+
+static void vfio_ccw_register_event_notifier(VFIOCCWDevice *vcdev, int irq,
+                                             Error **errp)
 {
     VFIODevice *vdev = &vcdev->vdev;
     struct vfio_irq_info *irq_info;
     struct vfio_irq_set *irq_set;
     size_t argsz;
     int32_t *pfd;
-
-    if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
-        error_setg(errp, "vfio: unexpected number of io irqs %u",
-                   vdev->num_irqs);
+    EventNotifier *notifier;
+    IOHandler *fd_read;
+
+    switch (irq) {
+    case VFIO_CCW_IO_IRQ_INDEX:
+        notifier = &vcdev->io_notifier;
+        fd_read = vfio_ccw_io_notifier_handler;
+        break;
+    case VFIO_CCW_CHP_IRQ_INDEX:
+        notifier = &vcdev->chp_notifier;
+        fd_read = vfio_ccw_chp_notifier_handler;
+        break;
+    default:
+        error_setg(errp, "vfio: Unsupported device irq(%d) fd: %m", irq);
         return;
     }
 
     argsz = sizeof(*irq_info);
     irq_info = g_malloc0(argsz);
-    irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
+    irq_info->index = irq;
     irq_info->argsz = argsz;
     if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
               irq_info) < 0 || irq_info->count < 1) {
-        error_setg_errno(errp, errno, "vfio: Error getting irq info");
+        error_setg_errno(errp, errno, "vfio: Error getting irq(%d) info", irq);
         goto out_free_info;
     }
 
-    if (event_notifier_init(&vcdev->io_notifier, 0)) {
+    if (event_notifier_init(notifier, 0)) {
         error_setg_errno(errp, errno,
-                         "vfio: Unable to init event notifier for IO");
+                         "vfio: Unable to init event notifier for irq(%d)",
+                         irq);
         goto out_free_info;
     }
 
@@ -207,17 +232,18 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
     irq_set->argsz = argsz;
     irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
                      VFIO_IRQ_SET_ACTION_TRIGGER;
-    irq_set->index = VFIO_CCW_IO_IRQ_INDEX;
+    irq_set->index = irq;
     irq_set->start = 0;
     irq_set->count = 1;
     pfd = (int32_t *) &irq_set->data;
 
-    *pfd = event_notifier_get_fd(&vcdev->io_notifier);
-    qemu_set_fd_handler(*pfd, vfio_ccw_io_notifier_handler, NULL, vcdev);
+    *pfd = event_notifier_get_fd(notifier);
+    qemu_set_fd_handler(*pfd, fd_read, NULL, vcdev);
     if (ioctl(vdev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
-        error_setg(errp, "vfio: Failed to set up io notification");
+        error_setg(errp, "vfio: Failed to set up notification for irq(%d)",
+                   irq);
         qemu_set_fd_handler(*pfd, NULL, NULL, vcdev);
-        event_notifier_cleanup(&vcdev->io_notifier);
+        event_notifier_cleanup(notifier);
     }
 
     g_free(irq_set);
@@ -226,30 +252,42 @@ out_free_info:
     g_free(irq_info);
 }
 
-static void vfio_ccw_unregister_io_notifier(VFIOCCWDevice *vcdev)
+static void vfio_ccw_unregister_event_notifier(VFIOCCWDevice *vcdev, int irq)
 {
     struct vfio_irq_set *irq_set;
     size_t argsz;
     int32_t *pfd;
+    EventNotifier *notifier;
+
+    switch (irq) {
+    case VFIO_CCW_IO_IRQ_INDEX:
+        notifier = &vcdev->io_notifier;
+        break;
+    case VFIO_CCW_CHP_IRQ_INDEX:
+        notifier = &vcdev->chp_notifier;
+        break;
+    default:
+        error_report("vfio: Unsupported device irq(%d) fd: %m", irq);
+        return;
+    }
 
     argsz = sizeof(*irq_set) + sizeof(*pfd);
     irq_set = g_malloc0(argsz);
     irq_set->argsz = argsz;
     irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
                      VFIO_IRQ_SET_ACTION_TRIGGER;
-    irq_set->index = VFIO_CCW_IO_IRQ_INDEX;
+    irq_set->index = irq;
     irq_set->start = 0;
     irq_set->count = 1;
     pfd = (int32_t *) &irq_set->data;
     *pfd = -1;
 
     if (ioctl(vcdev->vdev.fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
-        error_report("vfio: Failed to de-assign device io fd: %m");
+        error_report("vfio: Failed to de-assign device irq(%d) fd: %m", irq);
     }
 
-    qemu_set_fd_handler(event_notifier_get_fd(&vcdev->io_notifier),
-                        NULL, NULL, vcdev);
-    event_notifier_cleanup(&vcdev->io_notifier);
+    qemu_set_fd_handler(event_notifier_get_fd(notifier), NULL, NULL, vcdev);
+    event_notifier_cleanup(notifier);
 
     g_free(irq_set);
 }
@@ -272,6 +310,11 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         return;
     }
 
+    if (vdev->num_irqs < VFIO_CCW_IO_IRQ_INDEX + 1) {
+        error_setg(errp, "vfio: Unexpected number of irqs %u", vdev->num_irqs);
+        return;
+    }
+
     /* Get I/O region info. */
     ret = vfio_get_region_info(vdev, VFIO_CCW_CONFIG_REGION_INDEX, &info);
     if (ret) {
@@ -392,7 +435,11 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_region_err;
     }
 
-    vfio_ccw_register_io_notifier(vcdev, &err);
+    vfio_ccw_register_event_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX, &err);
+    if (err) {
+        goto out_notifier_err;
+    }
+    vfio_ccw_register_event_notifier(vcdev, VFIO_CCW_CHP_IRQ_INDEX, &err);
     if (err) {
         goto out_notifier_err;
     }
@@ -421,7 +468,8 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
     VFIOGroup *group = vcdev->vdev.group;
 
-    vfio_ccw_unregister_io_notifier(vcdev);
+    vfio_ccw_unregister_event_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
+    vfio_ccw_unregister_event_notifier(vcdev, VFIO_CCW_CHP_IRQ_INDEX);
     vfio_ccw_put_region(vcdev);
     vfio_put_device(vcdev);
     vfio_put_group(group);
-- 
2.13.5
