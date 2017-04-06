Received: from eggs.gnu.org ([2001:4830:134:3::10]:43318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw5PW-0004Ta-Q1
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cw5PS-0001d0-Di
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:17:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cw5PS-0001ca-3v
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:17:02 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v36BDvlw038947
	for <qemu-devel@nongnu.org>; Thu, 6 Apr 2017 07:17:01 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29nm639vd2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 07:17:00 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 6 Apr 2017 12:16:58 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu,  6 Apr 2017 13:16:42 +0200
In-Reply-To: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
References: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
Message-Id: <20170406111646.12624-7-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.10 06/10] s390x/css: consolidate the
 devno property for ccw devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

'devno' should rather be a property of the ccw device, instead of a
property of a specific virtio-ccw device. Let's consolidate it.

While we are at here, also rename CcwDevice.bus_id to CcwDevice.devno to
make things clearer.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/ccw-device.c |  1 +
 hw/s390x/ccw-device.h |  2 +-
 hw/s390x/virtio-ccw.c | 14 ++------------
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index 8fe3cf49ef..fb8d640a7e 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -34,6 +34,7 @@ static void ccw_device_realize(CcwDevice *dev, Error **errp)
 }
 
 static Property ccw_device_properties[] = {
+    DEFINE_PROP_CSS_DEV_ID("devno", CcwDevice, devno),
     DEFINE_PROP_CSS_DEV_ID_RO("dev_id", CcwDevice, dev_id),
     DEFINE_PROP_CSS_DEV_ID_RO("subch_id", CcwDevice, subch_id),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
index 48700fe23a..89c8e5dff7 100644
--- a/hw/s390x/ccw-device.h
+++ b/hw/s390x/ccw-device.h
@@ -20,7 +20,7 @@ typedef struct CcwDevice {
     SubchDev *sch;
     /* <cssid>.<ssid>.<device number> */
     /* The user-set busid of the virtual ccw device. */
-    CssDevId bus_id;
+    CssDevId devno;
     /* The actual busid of the virtual ccw device. */
     CssDevId dev_id;
     /* The actual busid of the virtual subchannel. */
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 4e59e34d74..a81e27f7fd 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -681,7 +681,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
     CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
-    SubchDev *sch = css_create_virtual_sch(ccw_dev->bus_id, errp);
+    SubchDev *sch = css_create_virtual_sch(ccw_dev->devno, errp);
     Error *err = NULL;
 
     if (!sch) {
@@ -705,7 +705,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
 
     trace_virtio_ccw_new_device(
         sch->cssid, sch->ssid, sch->schid, sch->devno,
-        ccw_dev->bus_id.valid ? "user-configured" : "auto-configured");
+        ccw_dev->devno.valid ? "user-configured" : "auto-configured");
 
     if (!kvm_eventfds_enabled()) {
         dev->flags &= ~VIRTIO_CCW_FLAG_USE_IOEVENTFD;
@@ -1370,7 +1370,6 @@ static void virtio_ccw_device_unplugged(DeviceState *d)
 /**************** Virtio-ccw Bus Device Descriptions *******************/
 
 static Property virtio_ccw_net_properties[] = {
-    DEFINE_PROP_CSS_DEV_ID("devno", VirtioCcwDevice, parent_obj.bus_id),
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
@@ -1399,7 +1398,6 @@ static const TypeInfo virtio_ccw_net = {
 };
 
 static Property virtio_ccw_blk_properties[] = {
-    DEFINE_PROP_CSS_DEV_ID("devno", VirtioCcwDevice, parent_obj.bus_id),
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
@@ -1428,7 +1426,6 @@ static const TypeInfo virtio_ccw_blk = {
 };
 
 static Property virtio_ccw_serial_properties[] = {
-    DEFINE_PROP_CSS_DEV_ID("devno", VirtioCcwDevice, parent_obj.bus_id),
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
@@ -1457,7 +1454,6 @@ static const TypeInfo virtio_ccw_serial = {
 };
 
 static Property virtio_ccw_balloon_properties[] = {
-    DEFINE_PROP_CSS_DEV_ID("devno", VirtioCcwDevice, parent_obj.bus_id),
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
@@ -1486,7 +1482,6 @@ static const TypeInfo virtio_ccw_balloon = {
 };
 
 static Property virtio_ccw_scsi_properties[] = {
-    DEFINE_PROP_CSS_DEV_ID("devno", VirtioCcwDevice, parent_obj.bus_id),
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
@@ -1516,7 +1511,6 @@ static const TypeInfo virtio_ccw_scsi = {
 
 #ifdef CONFIG_VHOST_SCSI
 static Property vhost_ccw_scsi_properties[] = {
-    DEFINE_PROP_CSS_DEV_ID("devno", VirtioCcwDevice, parent_obj.bus_id),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
     DEFINE_PROP_END_OF_LIST(),
@@ -1554,7 +1548,6 @@ static void virtio_ccw_rng_instance_init(Object *obj)
 }
 
 static Property virtio_ccw_rng_properties[] = {
-    DEFINE_PROP_CSS_DEV_ID("devno", VirtioCcwDevice, parent_obj.bus_id),
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
@@ -1583,7 +1576,6 @@ static const TypeInfo virtio_ccw_rng = {
 };
 
 static Property virtio_ccw_crypto_properties[] = {
-    DEFINE_PROP_CSS_DEV_ID("devno", VirtioCcwDevice, parent_obj.bus_id),
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
                     VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
@@ -1710,7 +1702,6 @@ static const TypeInfo virtio_ccw_bus_info = {
 
 #ifdef CONFIG_VIRTFS
 static Property virtio_ccw_9p_properties[] = {
-    DEFINE_PROP_CSS_DEV_ID("devno", VirtioCcwDevice, parent_obj.bus_id),
     DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
             VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
@@ -1759,7 +1750,6 @@ static const TypeInfo virtio_ccw_9p_info = {
 #ifdef CONFIG_VHOST_VSOCK
 
 static Property vhost_vsock_ccw_properties[] = {
-    DEFINE_PROP_CSS_DEV_ID("devno", VirtioCcwDevice, parent_obj.bus_id),
     DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
                        VIRTIO_CCW_MAX_REV),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.11.0
