Received: from eggs.gnu.org ([2001:4830:134:3::10]:45410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8W-00011x-SD
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d6h8V-0005Ih-Ri
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d6h8V-0005ID-Il
	for qemu-devel@nongnu.org; Fri, 05 May 2017 13:35:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45HXwkp123420
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 13:35:22 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8k777faj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 13:35:22 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 5 May 2017 18:35:19 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 19:35:01 +0200
In-Reply-To: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170505173507.74077-5-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 04/10] s390x/css: add vmstate macro for
 CcwDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

As a preparation for switching to a vmstate based migration let us
introduce a vmstate macro for CcwDevice.

No changes in behavior, we just added some dead code -- which should
rise to life soon.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Guenther Hutzl <hutzl@linux.vnet.ibm.com>
---
 hw/s390x/ccw-device.c | 10 ++++++++++
 hw/s390x/ccw-device.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/hw/s390x/ccw-device.c b/hw/s390x/ccw-device.c
index fb8d640..f9bfa15 100644
--- a/hw/s390x/ccw-device.c
+++ b/hw/s390x/ccw-device.c
@@ -50,6 +50,16 @@ static void ccw_device_class_init(ObjectClass *klass, void *data)
     dc->props = ccw_device_properties;
 }
 
+const VMStateDescription vmstate_ccw_dev = {
+    .name = "s390_ccw_dev",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_STRUCT_POINTER(sch, CcwDevice, vmstate_subch_dev, SubchDev),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const TypeInfo ccw_device_info = {
     .name = TYPE_CCW_DEVICE,
     .parent = TYPE_DEVICE,
diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
index 89c8e5d..4e6af28 100644
--- a/hw/s390x/ccw-device.h
+++ b/hw/s390x/ccw-device.h
@@ -27,6 +27,10 @@ typedef struct CcwDevice {
     CssDevId subch_id;
 } CcwDevice;
 
+extern const VMStateDescription vmstate_ccw_dev;
+#define VMSTATE_CCW_DEVICE(_field, _state)                     \
+    VMSTATE_STRUCT(_field, _state, 1, vmstate_ccw_dev, CcwDevice)
+
 typedef struct CCWDeviceClass {
     DeviceClass parent_class;
     void (*unplug)(HotplugHandler *, DeviceState *, Error **);
-- 
2.10.2
