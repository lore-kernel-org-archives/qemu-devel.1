Received: from eggs.gnu.org ([209.51.188.92]:52701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1goDjR-0004ky-R4
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:42:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1goDWZ-0002EM-2g
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:28:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1goDWX-0002C8-5P
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:28:54 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0SKO3fE098104
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 15:28:51 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qa8791paw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 15:28:50 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Mon, 28 Jan 2019 20:28:50 -0000
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Mon, 28 Jan 2019 15:28:37 -0500
Message-Id: <1548707317-21854-1-git-send-email-akrowiak@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2] s390x/vfio-ap: Implement hot plug/unplug of
 vfio-ap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, akrowiak@linux.ibm.com, fiuczy@linux.ibm.com

Introduces hot plug/unplug support for the vfio-ap device. Note that only one
vfio-ap device can be attached to the ap-bus, so a vfio-ap device can only be
hot plugged if the '-device vfio-ap,sysfsdev=$path_to_mdev' option is not
specified on the QEMU command line.

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
Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Pierre Morel<pmorel@linux.ibm.com>
---
 docs/vfio-ap.txt     | 58 +++++++++++++++++++++++++++++++++++++++++++++++-----
 hw/s390x/ap-bridge.c | 12 ++++++++++-
 hw/vfio/ap.c         |  2 +-
 3 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/docs/vfio-ap.txt b/docs/vfio-ap.txt
index 12339684cd52..fae40f218620 100644
--- a/docs/vfio-ap.txt
+++ b/docs/vfio-ap.txt
@@ -440,8 +440,7 @@ unassign_control_domain
    'unassign_domain' file. This may be done multiple times to unassign more than
    one control domain.
 
-Notes: Hot plug/unplug is not currently supported for mediated AP matrix
-devices, so no changes to the AP matrix will be allowed while a guest using
+Notes: No changes to the AP matrix will be allowed while a guest using
 the mediated matrix device is running. Attempts to assign an adapter,
 domain or control domain will be rejected and an error (EBUSY) returned.
 
@@ -562,6 +561,51 @@ facilities:
                      for guest usage, no AP devices can be made accessible to a
                      guest started without APFT installed.
 
+Hot plug a vfio-ap device into a running guest:
+==============================================
+Only one vfio-ap device can be attached to the guest's ap-bus, so a vfio-ap
+device can be hot plugged if and only if the 
+'-device vfio-ap,sysfsdev=$path-to-mdev' option was NOT specified on the QEMU
+command line when the guest was started.
+
+To hot plug a vfio-ap device, use the QEMU device_add command:
+
+    (qemu) device_add vfio-ap,sysfsdev="$path-to-mdev"
+
+    Where the '$path-to-mdev' value specifies the absolute path to a mediated
+    device configured with an AP matrix identifying the AP resources assigned
+    to the guest.
+
+The AP devices will be created in the /sys/bus/ap/devices directory on the
+guest when the AP bus subsequently performs its periodic scan, so there may be
+a short delay before the AP devices are accessible on the guest.
+
+The command will fail if:
+
+* The KVM guest was started with the '-device vfio-ap,sysfs=$path-to-mdev'
+  QEMU command line option.
+
+* The CPU model features for controlling guest access to AP facilities are not
+  enabled (see 'CPU model features' subsection in the previous section).
+
+Hot unplug a vfio-ap device from a running guest:
+================================================
+A vfio-ap device can be unplugged from a running KVM guest if the
+'-device vfio-ap,sysfsdev=$path-to-mdev' option was specified on the QEMU
+command line when the guest was started.
+
+To hot unplug a vfio-ap device, use the QEMU device_del command:
+
+    (qemu) device_del vfio-ap,sysfsdev="$path-to-mdev"
+
+The AP devices will be removed from the /sys/bus/ap/devices directory on the
+guest when the AP bus subsequently performs its periodic scan, so there may be
+a short delay before the AP devices are no longer accessible by the guest.
+
+The command will fail if the $path-to-mdev specified on the device_del command
+does not match the value specified on the '-device vfio-ap,sysfs=$path-to-mdev'
+QEMU command line used to start the guest.
+
 Example: Configure AP Matrixes for Three Linux Guests:
 =====================================================
 Let's now provide an example to illustrate how KVM guests may be given
@@ -819,7 +863,11 @@ Limitations
   assigned lest the host be given access to the private data of the AP queue
   device, such as a private key configured specifically for the guest.
 
-* Dynamically modifying the AP matrix for a running guest (which would amount to
-  hot(un)plug of AP devices for the guest) is currently not supported
+* Dynamically assigning AP resources to or unassigning AP resources from a
+  mediated matrix device - see 'Configuring an AP matrix for a linux guest'
+  section above - while a running guest is using it is currently not supported.
 
-* Live guest migration is not supported for guests using AP devices.
+* Live guest migration is not supported for guests using AP devices. If a guest
+  is using AP devices, the vfio-ap device configured for the guest must be
+  unplugged before migrating the guest (see 'Hot unplug a vfio-ap device from a
+  running guest' section above.
diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
index 3795d30dd7c9..25a03412fcb9 100644
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
+    qbus_set_hotplug_handler(bus, dev, &error_abort);
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
2.7.4
