Received: from eggs.gnu.org ([2001:4830:134:3::10]:44790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cedum-0003O4-7A
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1ceduh-0000mm-Rp
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:29:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57148
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1ceduh-0000lc-KH
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:29:11 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1H8T98T067066
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 03:29:10 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28ngt931xp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 03:29:10 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Fri, 17 Feb 2017 01:29:01 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri, 17 Feb 2017 09:28:37 +0100
In-Reply-To: <20170217082844.89466-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170217082844.89466-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170217082844.89466-5-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v3 04/11] s390x/css: realize css_create_sch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

The S390 virtual css support already has a mechanism to create a
virtual subchannel and provide it to the guest. However, to
pass-through subchannels to a guest, we need to introduce a new
mechanism to create the subchannel according to the real device
information. Thus we reconstruct css_create_virtual_sch to a new
css_create_sch function to handl all these cases and do allocation
and initialization of the subchannel according to the device type
and machine configuration.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 hw/s390x/css-bridge.c         |  2 ++
 hw/s390x/css.c                | 45 ++++++++++++++++++++++++++++++++++++-------
 hw/s390x/s390-virtio-ccw.c    | 12 +++++++++---
 hw/s390x/virtio-ccw.c         |  6 +++++-
 include/hw/s390x/css-bridge.h |  1 +
 include/hw/s390x/css.h        | 25 ++++++++++++++++--------
 6 files changed, 72 insertions(+), 19 deletions(-)

diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 9a7f7ee..14d3af4 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -17,6 +17,7 @@
 #include "hw/s390x/css.h"
 #include "ccw-device.h"
 #include "hw/s390x/css-bridge.h"
+#include "cpu.h"
 
 /*
  * Invoke device-specific unplug handler, disable the subchannel
@@ -103,6 +104,7 @@ VirtualCssBus *virtual_css_bus_init(void)
     /* Create bus on bridge device */
     bus = qbus_create(TYPE_VIRTUAL_CSS_BUS, dev, "virtual-css");
     cbus = VIRTUAL_CSS_BUS(bus);
+    cbus->squash_mcss = s390_get_squash_mcss();
 
     /* Enable hotplugging */
     qbus_set_hotplug_handler(bus, dev, &error_abort);
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 09038a2..25efbee 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1878,28 +1878,59 @@ PropertyInfo css_devid_propinfo = {
     .set = set_css_devid,
 };
 
-SubchDev *css_create_virtual_sch(CssDevId bus_id, Error **errp)
+SubchDev *css_create_sch(CssDevId bus_id, bool is_virtio, bool squash_mcss,
+                         Error **errp)
 {
     uint16_t schid = 0;
     SubchDev *sch;
 
     if (bus_id.valid) {
-        /* Enforce use of virtual cssid. */
-        if (bus_id.cssid != VIRTUAL_CSSID) {
-            error_setg(errp, "cssid %hhx not valid for virtual devices",
-                       bus_id.cssid);
+        if (is_virtio != (bus_id.cssid == VIRTUAL_CSSID)) {
+            error_setg(errp, "cssid %hhx not valid for %s devices",
+                       bus_id.cssid,
+                       (is_virtio ? "virtio" : "non-virtio"));
             return NULL;
         }
+    }
+
+    if (bus_id.valid) {
+        if (squash_mcss) {
+            bus_id.cssid = channel_subsys.default_cssid;
+        } else if (!channel_subsys.css[bus_id.cssid]) {
+            css_create_css_image(bus_id.cssid, false);
+        }
+
         if (!css_find_free_subch_for_devno(bus_id.cssid, bus_id.ssid,
                                            bus_id.devid, &schid, errp)) {
             return NULL;
         }
-    } else {
-        bus_id.cssid = VIRTUAL_CSSID;
+    } else if (squash_mcss || is_virtio) {
+        bus_id.cssid = channel_subsys.default_cssid;
+
         if (!css_find_free_subch_and_devno(bus_id.cssid, &bus_id.ssid,
                                            &bus_id.devid, &schid, errp)) {
             return NULL;
         }
+    } else {
+        for (bus_id.cssid = 0; bus_id.cssid < MAX_CSSID; ++bus_id.cssid) {
+            if (bus_id.cssid == VIRTUAL_CSSID) {
+                continue;
+            }
+
+            if (!channel_subsys.css[bus_id.cssid]) {
+                css_create_css_image(bus_id.cssid, false);
+            }
+
+            if   (css_find_free_subch_and_devno(bus_id.cssid, &bus_id.ssid,
+                                                &bus_id.devid, &schid,
+                                                NULL)) {
+                break  ;
+            }
+            if (bus_id.cssid == MAX_CSSID) {
+                error_setg(errp, "Virtual channel subsystem is full!");
+                return NULL;
+            }
+        }
     }
 
     sch = g_malloc0(sizeof(*sch));
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d1dcb24..9aaf730 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -134,10 +134,16 @@ static void ccw_init(MachineState *machine)
         kvm_s390_enable_css_support(s390_cpu_addr2state(0));
     }
     /*
-     * Create virtual css and set it as default so that non mcss-e
-     * enabled guests only see virtio devices.
+     * Non mcss-e enabled guests only see the devices from the default
+     * css, which is determined by the value of the squash_mcss property.
+     * Note: we must not squash non virtio devices to css 0xFE, since
+     * it's reserved for virtio devices only.
      */
-    ret = css_create_css_image(VIRTUAL_CSSID, true);
+    if (css_bus->squash_mcss) {
+        ret = css_create_css_image(0, true);
+    } else {
+        ret = css_create_css_image(VIRTUAL_CSSID, true);
+    }
     assert(ret == 0);
 
     /* Create VirtIO network adapters */
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 63c4637..6c1bb0e 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -663,9 +663,13 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
 {
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
-    SubchDev *sch = css_create_virtual_sch(ccw_dev->bus_id, errp);
+    DeviceState *parent = DEVICE(ccw_dev);
+    BusState *qbus = qdev_get_parent_bus(parent);
+    VirtualCssBus *cbus = VIRTUAL_CSS_BUS(qbus);
+    SubchDev *sch;
     Error *err = NULL;
 
+    sch = css_create_sch(ccw_dev->bus_id, true, cbus->squash_mcss, errp);
     if (!sch) {
         return;
     }
diff --git a/include/hw/s390x/css-bridge.h b/include/hw/s390x/css-bridge.h
index 5a0203b..cf08604 100644
--- a/include/hw/s390x/css-bridge.h
+++ b/include/hw/s390x/css-bridge.h
@@ -28,6 +28,7 @@ typedef struct VirtualCssBridge {
 /* virtual css bus type */
 typedef struct VirtualCssBus {
     BusState parent_obj;
+    bool squash_mcss;
 } VirtualCssBus;
 
 #define TYPE_VIRTUAL_CSS_BUS "virtual-css-bus"
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 648ea2f..2170d11 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -177,16 +177,25 @@ bool css_present(uint8_t cssid);
 /**
  * Create a subchannel for the given bus id.
  *
- * If @p bus_id is valid, verify that it uses the virtual channel
- * subsystem id and is not already in use, and find a free subchannel
- * id for it. If @p bus_id is not valid, find a free subchannel id and
- * device number across all subchannel sets. If either of the former
- * actions succeed, allocate a subchannel structure, initialise it
- * with the bus id, subchannel id and device number, register it with
- * the CSS and return it. Otherwise return NULL.
+ * If @p bus_id is valid, and @p squash_mcss is true, verify that it is
+ * not already in use in the default css, and find a free devno from the
+ * default css image for it.
+ * If @p bus_id is valid, and @p squash_mcss is false, verify that it is
+ * not already in use, and find a free devno for it.
+ * If @p bus_id is not valid, and if either @p squash_mcss or @p is_virtio
+ * is true, find a free subchannel id and device number across all
+ * subchannel sets from the default css image.
+ * If @p bus_id is not valid, and if both @p squash_mcss and @p is_virtio
+ * are false, find a non-full css image and find a free subchannel id and
+ * device number across all subchannel sets from it.
+ *
+ * If either of the former actions succeed, allocate a subchannel structure,
+ * initialise it with the bus id, subchannel id and device number, register
+ * it with the CSS and return it. Otherwise return NULL.
  *
  * The caller becomes owner of the returned subchannel structure and
  * is responsible for unregistering and freeing it.
  */
-SubchDev *css_create_virtual_sch(CssDevId bus_id, Error **errp);
+SubchDev *css_create_sch(CssDevId bus_id, bool is_virtio, bool squash_mcss,
+                         Error **errp);
 #endif
-- 
2.8.4
