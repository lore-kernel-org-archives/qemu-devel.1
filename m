Received: from eggs.gnu.org ([2001:4830:134:3::10]:40958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIY-0001fU-0P
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIW-0002uc-S5
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:13 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:31 -0500
Message-Id: <20180723201748.25573-23-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 22/99] s390x/ccw: make sure all ccw devices are
 properly reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Cornelia Huck <cohuck@redhat.com>

Thomas reported that the subchannel for a  3270 device that ended up
in a broken state (status pending even though not enabled) did not
get out of that state even after a reboot (which involves a subsytem
reset). The reason for this is that the 3270 device did not define
a reset handler.

Let's fix this by introducing a base reset handler (set up for all
ccw devices) that resets the subchannel and have virtio-ccw call
its virtio-specific reset procedure in addition to that.

CC: qemu-stable@nongnu.org
Reported-by: Thomas Huth <thuth@redhat.com>
Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit 838fb84f83c84f00d15b1bede5e080b495644458)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/s390x/ccw-device.c | 8 ++++++++
 hw/s390x/virtio-ccw.c | 9 ++++++---
 hw/s390x/virtio-ccw.h | 1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index f9bfa154d6..7cd73df4aa 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -40,6 +40,13 @@ static Property ccw_device_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void ccw_device_reset(DeviceState *d)
+{
+    CcwDevice *ccw_dev = CCW_DEVICE(d);
+
+    css_reset_sch(ccw_dev->sch);
+}
+
 static void ccw_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -48,6 +55,7 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
     k->realize = ccw_device_realize;
     k->refill_ids = ccw_device_refill_ids;
     dc->props = ccw_device_properties;
+    dc->reset = ccw_device_reset;
 }
 
 const VMStateDescription vmstate_ccw_dev = {
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 40a33302a7..22df33b509 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1058,10 +1058,12 @@ static void virtio_ccw_reset(DeviceState *d)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
     VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
-    CcwDevice *ccw_dev = CCW_DEVICE(d);
+    VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
 
     virtio_ccw_reset_virtio(dev, vdev);
-    css_reset_sch(ccw_dev->sch);
+    if (vdc->parent_reset) {
+        vdc->parent_reset(d);
+    }
 }
 
 static void virtio_ccw_vmstate_change(DeviceState *d, bool running)
@@ -1715,12 +1717,13 @@ static void virtio_ccw_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     CCWDeviceClass *k = CCW_DEVICE_CLASS(dc);
+    VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->unplug = virtio_ccw_busdev_unplug;
     dc->realize = virtio_ccw_busdev_realize;
     dc->unrealize = virtio_ccw_busdev_unrealize;
     dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
-    dc->reset = virtio_ccw_reset;
+    device_class_set_parent_reset(dc, virtio_ccw_reset, &vdc->parent_reset);
 }
 
 static const TypeInfo virtio_ccw_device_info = {
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 2fc513001e..3453aa1f98 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -77,6 +77,7 @@ typedef struct VirtIOCCWDeviceClass {
     CCWDeviceClass parent_class;
     void (*realize)(VirtioCcwDevice *dev, Error **errp);
     void (*unrealize)(VirtioCcwDevice *dev, Error **errp);
+    void (*parent_reset)(DeviceState *dev);
 } VirtIOCCWDeviceClass;
 
 /* Performance improves when virtqueue kick processing is decoupled from the
-- 
2.17.1
