Received: from eggs.gnu.org ([209.51.188.92]:46262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mIs-0008SG-Gh
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mIk-0008Qb-Eo
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:02:40 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  4 Mar 2019 13:01:47 +0100
Message-Id: <20190304120210.31500-5-cohuck@redhat.com>
In-Reply-To: <20190304120210.31500-1-cohuck@redhat.com>
References: <20190304120210.31500-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 04/27] s390x/vfio-ap: Implement hot plug/unplug
 of vfio-ap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Tony Krowiak <akrowiak@linux.ibm.com>

Introduces hot plug/unplug support for the vfio-ap device.

To hot plug a vfio-ap device using the QEMU device_add command:

	(qemu) device_add vfio-ap,sysfsdev=$path-to-mdev

	Where $path-to-mdev is the absolute path to the mediated matrix device
	to which AP resources to be used by the guest have been assigned.

A vfio-ap device can be hot plugged only if:

1. A vfio-ap device has not been attached to the virtual machine's ap-bus
   via the QEMU command line or a prior hot plug action.

2. The guest was started with the CPU model feature for AP enabled
   (e.g., -cpu host,ap=on)

To hot unplug a vfio-ap device using the QEMU device_del command:

	(qemu) device_del vfio-ap,sysfsdev=$path-to-mdev

	Where $path-to-mdev is the absolute path to the mediated matrix device
	specified when the vfio-ap device was attached to the virtual machine's
	ap-bus.

A vfio-ap device can be hot unplugged only if:

1. A vfio-ap device has been attached to the virtual machine's ap-bus
   via the QEMU command line or a prior hot plug action.

2. The guest was started with the CPU model feature for AP enabled
   (e.g., -cpu host,ap=on)

Please note that a hot plug handler is not necessary for the vfio-ap device
because the AP matrix configuration for the guest is performed by the
kernel device driver when the vfio-ap device is realized. The vfio-ap device
represents a VFIO mediated device created in the host sysfs for use by a guest.
The mdev device is configured with an AP matrix (i.e., adapters and domains) via
its sysfs attribute interfaces prior to starting the guest or plugging a vfio-ap
device in. When the device is realized, a file descriptor is opened on the mdev
device which results in a callback to the vfio_ap kernel device driver. The
device driver then configures the AP matrix in the guest's SIE state description
from the AP matrix assigned via the mdev device's sysfs interfaces. The AP
devices will be created for the guest when the AP bus running on the guest
subsequently performs its periodic scan for AP devices.

The qdev_simple_device_unplug_cb() callback function is used for the same
reaons; namely, the vfio_ap kernel device driver will perform the AP resource
de-configuration for the guest when the vfio-ap device is unplugged. When the
vfio-ap device is unrealized, the mdev device file descriptor is closed which
results in a callback to the vfio_ap kernel device driver. The device driver
then clears the AP matrix configuration in the guest's SIE state description
and resets all of the affected queues. The AP devices created for the guest
will be removed when the AP bus running on the guest subsequently performs
its periodic scan and finds there are no longer any AP resources assigned to the
guest.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Pierre Morel <pmorel@linux.ibm.com>
Message-Id: <1550519397-25359-2-git-send-email-akrowiak@linux.ibm.com>
[CH: adapt to changed qbus_set_hotplug_handler() signature]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ap-bridge.c | 12 +++++++++++-
 hw/vfio/ap.c         |  2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
index 3795d30dd7c9..75ad0a66b9e2 100644
--- a/hw/s390x/ap-bridge.c
+++ b/hw/s390x/ap-bridge.c
@@ -39,6 +39,7 @@ static const TypeInfo ap_bus_info = {
 void s390_init_ap(void)
 {
     DeviceState *dev;
+    BusState *bus;
 
     /* If no AP instructions then no need for AP bridge */
     if (!s390_has_feat(S390_FEAT_AP)) {
@@ -52,13 +53,18 @@ void s390_init_ap(void)
     qdev_init_nofail(dev);
 
     /* Create bus on bridge device */
-    qbus_create(TYPE_AP_BUS, dev, TYPE_AP_BUS);
+    bus = qbus_create(TYPE_AP_BUS, dev, TYPE_AP_BUS);
+
+    /* Enable hotplugging */
+    qbus_set_hotplug_handler(bus, OBJECT(dev), &error_abort);
  }
 
 static void ap_bridge_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
+    hc->unplug = qdev_simple_device_unplug_cb;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
@@ -67,6 +73,10 @@ static const TypeInfo ap_bridge_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = 0,
     .class_init    = ap_bridge_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_HOTPLUG_HANDLER },
+        { }
+    }
 };
 
 static void ap_register(void)
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 6166ccd47a4a..d8b79ebe53ae 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -169,7 +169,7 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->realize = vfio_ap_realize;
     dc->unrealize = vfio_ap_unrealize;
-    dc->hotpluggable = false;
+    dc->hotpluggable = true;
     dc->reset = vfio_ap_reset;
     dc->bus_type = TYPE_AP_BUS;
 }
-- 
2.17.2
