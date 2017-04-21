Received: from eggs.gnu.org ([2001:4830:134:3::10]:40702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBZ-00012b-GS
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d1TBW-0000eX-Cp
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44155
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d1TBW-0000eK-6n
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 03:40:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3L7cY1D008201
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:40:53 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29xucaxkkb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 03:40:53 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 21 Apr 2017 08:40:51 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 21 Apr 2017 09:40:32 +0200
In-Reply-To: <20170421074038.774-1-cornelia.huck@de.ibm.com>
References: <20170421074038.774-1-cornelia.huck@de.ibm.com>
Message-Id: <20170421074038.774-6-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 05/11] s390x/css: provide introspection for
 virtual subchannel and device busid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

Expose the busids of the virtual I/O subchannel and the virtual CCW
device to ease debugging. This is needed because:
1. subchannel id are assigned dynamically, and cannot be set from
   outside.
2. device busid could possibly be auto generated.

An example of using HMP to retrieve the property values of a
virtio-balloon-ccw device looks like:

[root@localhost ~]# lscss -d 0.0.0004
Device   Subchan.  DevType CU Type Use  PIM PAM POM  CHPIDs
----------------------------------------------------------------------
0.0.0004 0.0.0003  0000/00 3832/05 yes  80  80  ff   00000000 00000000

(qemu) info qtree
... ...
      dev: virtio-balloon-ccw, id "balloon0"
        devno = "<unset>"
        ioeventfd = true
        max_revision = 2 (0x2)
        dev_id = "fe.0.0004"
        subch_id = "fe.0.0003"
... ...

After migration, if we have the same device that shows up on a
different subchannel, we must re-fill the subch_id of the ccw
device with the new schid, or the subch_id will have an old wrong
schid value. So this also re-fills the subch_id after migration.

While we are at it, also neaten the related error handling a bit.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/ccw-device.c | 39 +++++++++++++++++++++++++++++++++++++++
 hw/s390x/ccw-device.h |  7 +++++++
 hw/s390x/virtio-ccw.c | 27 +++++++++++++++++++++------
 3 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 28ea20440e..8fe3cf49ef 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -11,11 +11,50 @@
 #include "qemu/osdep.h"
 #include "ccw-device.h"
 
+static void ccw_device_refill_ids(CcwDevice *dev)
+{
+    SubchDev *sch = dev->sch;
+
+    assert(sch);
+
+    dev->dev_id.cssid = sch->cssid;
+    dev->dev_id.ssid = sch->ssid;
+    dev->dev_id.devid = sch->devno;
+    dev->dev_id.valid = true;
+
+    dev->subch_id.cssid = sch->cssid;
+    dev->subch_id.ssid = sch->ssid;
+    dev->subch_id.devid = sch->schid;
+    dev->subch_id.valid = true;
+}
+
+static void ccw_device_realize(CcwDevice *dev, Error **errp)
+{
+    ccw_device_refill_ids(dev);
+}
+
+static Property ccw_device_properties[] = {
+    DEFINE_PROP_CSS_DEV_ID_RO("dev_id", CcwDevice, dev_id),
+    DEFINE_PROP_CSS_DEV_ID_RO("subch_id", CcwDevice, subch_id),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ccw_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    CCWDeviceClass *k = CCW_DEVICE_CLASS(klass);
+
+    k->realize = ccw_device_realize;
+    k->refill_ids = ccw_device_refill_ids;
+    dc->props = ccw_device_properties;
+}
+
 static const TypeInfo ccw_device_info = {
     .name = TYPE_CCW_DEVICE,
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(CcwDevice),
     .class_size = sizeof(CCWDeviceClass),
+    .class_init = ccw_device_class_init,
     .abstract = true,
 };
 
diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
index 59ba01b6c5..48700fe23a 100644
--- a/hw/s390x/ccw-device.h
+++ b/hw/s390x/ccw-device.h
@@ -19,12 +19,19 @@ typedef struct CcwDevice {
     DeviceState parent_obj;
     SubchDev *sch;
     /* <cssid>.<ssid>.<device number> */
+    /* The user-set busid of the virtual ccw device. */
     CssDevId bus_id;
+    /* The actual busid of the virtual ccw device. */
+    CssDevId dev_id;
+    /* The actual busid of the virtual subchannel. */
+    CssDevId subch_id;
 } CcwDevice;
 
 typedef struct CCWDeviceClass {
     DeviceClass parent_class;
     void (*unplug)(HotplugHandler *, DeviceState *, Error **);
+    void (*realize)(CcwDevice *, Error **);
+    void (*refill_ids)(CcwDevice *);
 } CCWDeviceClass;
 
 static inline CcwDevice *to_ccw_dev_fast(DeviceState *d)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 00b3bde4e9..b71ea94118 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -680,6 +680,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
 {
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
+    CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
     SubchDev *sch = css_create_virtual_sch(ccw_dev->bus_id, errp);
     Error *err = NULL;
 
@@ -689,8 +690,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
     if (!virtio_ccw_rev_max(dev) && dev->force_revision_1) {
         error_setg(&err, "Invalid value of property max_rev "
                    "(is %d expected >= 1)", virtio_ccw_rev_max(dev));
-        error_propagate(errp, err);
-        return;
+        goto out_err;
     }
 
     sch->driver_data = dev;
@@ -713,13 +713,23 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
 
     if (k->realize) {
         k->realize(dev, &err);
+        if (err) {
+            goto out_err;
+        }
     }
+
+    ck->realize(ccw_dev, &err);
     if (err) {
-        error_propagate(errp, err);
-        css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
-        ccw_dev->sch = NULL;
-        g_free(sch);
+        goto out_err;
     }
+
+    return;
+
+out_err:
+    error_propagate(errp, err);
+    css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
+    ccw_dev->sch = NULL;
+    g_free(sch);
 }
 
 static int virtio_ccw_exit(VirtioCcwDevice *dev)
@@ -1261,12 +1271,17 @@ static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
 {
     VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
     CcwDevice *ccw_dev = CCW_DEVICE(d);
+    CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
     SubchDev *s = ccw_dev->sch;
     VirtIODevice *vdev = virtio_ccw_get_vdev(s);
     int len;
 
     s->driver_data = dev;
     subch_device_load(s, f);
+    /* Re-fill subch_id after loading the subchannel states.*/
+    if (ck->refill_ids) {
+        ck->refill_ids(ccw_dev);
+    }
     len = qemu_get_be32(f);
     if (len != 0) {
         dev->indicators = get_indicator(qemu_get_be64(f), len);
-- 
2.11.0
