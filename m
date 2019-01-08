Received: from eggs.gnu.org ([209.51.188.92]:40641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1ggtpU-0002js-Gx
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1ggtpQ-0006UJ-Lr
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:02:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56800
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1ggtpQ-0006A7-Fi
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:02:08 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x08FxF2f048176
	for <qemu-devel@nongnu.org>; Tue, 8 Jan 2019 11:01:59 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pvv87a08c-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 11:01:58 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Tue, 8 Jan 2019 16:01:58 -0000
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Tue,  8 Jan 2019 11:01:50 -0500
Message-Id: <1546963310-17024-1-git-send-email-akrowiak@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] s390x/vfio-ap: Implement hot plug/unplug of
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
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.vnet.ibm.com, alex.williamson@redhat.com, peter.maydell@linaro.org, rth@twiddle.net, akrowiak@linux.ibm.com, fiuczy@linux.ibm.com

Introduces hot plug/unplug support for the vfio-ap device. Note that only one
vfio-ap device can be attached to the ap-bus, so a vfio-ap device can only be
hot plugged if the '-device vfio-ap,sysfsdev=$path_to_mdev' option is not
specified on the QEMU command line.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
Tested-by: Pierre Morel<pmorel@linux.ibm.com>
---
 hw/s390x/ap-bridge.c | 12 +++++++++++-
 hw/vfio/ap.c         |  2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

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
