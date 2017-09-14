Received: from eggs.gnu.org ([2001:4830:134:3::10]:34471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dsWVY-0002nS-Nh
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dsWVT-0007fR-Re
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:56:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57154
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1dsWVT-0007ez-Lk
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:56:47 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8EFtp60120132
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:56:46 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cyuy0u285-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:56:38 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Thu, 14 Sep 2017 09:55:18 -0600
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Thu, 14 Sep 2017 11:55:09 -0400
In-Reply-To: <cover.1505403478.git.alifm@linux.vnet.ibm.com>
References: <cover.1505403478.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <cover.1505403478.git.alifm@linux.vnet.ibm.com>
References: <cover.1505403478.git.alifm@linux.vnet.ibm.com>
Message-Id: <b9b4d8a8c1d17bf3f086b120fdf04c925da0f331.1505403478.git.alifm@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/2] virtio-gpu-ccw: Create a virtio gpu
 device for the ccw bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, thuth@redhat.com, kraxel@redhat.com, cohuck@redhat.com

Wire up the virtio-gpu device for the CCW bus. The virtio-gpu
is a virtio-1 device, so disable revision 0.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/virtio-ccw.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h | 10 ++++++++++
 2 files changed, 59 insertions(+)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index b1976fd..12cacf6 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1007,6 +1007,15 @@ static void virtio_ccw_crypto_realize(VirtioCcwDevice *ccw_dev, Error **errp)
                              NULL);
 }
 
+static void virtio_ccw_gpu_realize(VirtioCcwDevice *ccw_dev, Error **errp)
+{
+    VirtIOGPUCcw *dev = VIRTIO_GPU_CCW(ccw_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
+    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+}
+
 /* DeviceState to VirtioCcwDevice. Note: used on datapath,
  * be careful and test performance if you change this.
  */
@@ -1616,6 +1625,45 @@ static const TypeInfo virtio_ccw_crypto = {
     .class_init    = virtio_ccw_crypto_class_init,
 };
 
+static Property virtio_ccw_gpu_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtioCcwDevice, flags,
+                    VIRTIO_CCW_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("max_revision", VirtioCcwDevice, max_rev,
+                       VIRTIO_CCW_MAX_REV),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void virtio_ccw_gpu_instance_init(Object *obj)
+{
+    VirtIOGPUCcw *dev = VIRTIO_GPU_CCW(obj);
+    VirtioCcwDevice *ccw_dev = VIRTIO_CCW_DEVICE(obj);
+
+    ccw_dev->force_revision_1 = true;
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                                TYPE_VIRTIO_GPU);
+}
+
+static void virtio_ccw_gpu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
+
+    k->realize = virtio_ccw_gpu_realize;
+    k->exit = virtio_ccw_exit;
+    dc->reset = virtio_ccw_reset;
+    dc->props = virtio_ccw_gpu_properties;
+    dc->hotpluggable = false;
+    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
+}
+
+static const TypeInfo virtio_ccw_gpu = {
+    .name          = TYPE_VIRTIO_GPU_CCW,
+    .parent        = TYPE_VIRTIO_CCW_DEVICE,
+    .instance_size = sizeof(VirtIOGPUCcw),
+    .instance_init = virtio_ccw_gpu_instance_init,
+    .class_init    = virtio_ccw_gpu_class_init,
+};
+
 static void virtio_ccw_busdev_realize(DeviceState *dev, Error **errp)
 {
     VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
@@ -1815,6 +1863,7 @@ static void virtio_ccw_register(void)
     type_register_static(&vhost_vsock_ccw_info);
 #endif
     type_register_static(&virtio_ccw_crypto);
+    type_register_static(&virtio_ccw_gpu);
 }
 
 type_init(virtio_ccw_register)
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 41d4010..541fdd2 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -27,6 +27,7 @@
 #ifdef CONFIG_VHOST_VSOCK
 #include "hw/virtio/vhost-vsock.h"
 #endif /* CONFIG_VHOST_VSOCK */
+#include "hw/virtio/virtio-gpu.h"
 
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/css.h"
@@ -223,4 +224,13 @@ typedef struct VHostVSockCCWState {
 
 #endif /* CONFIG_VHOST_VSOCK */
 
+#define TYPE_VIRTIO_GPU_CCW "virtio-gpu-ccw"
+#define VIRTIO_GPU_CCW(obj) \
+        OBJECT_CHECK(VirtIOGPUCcw, (obj), TYPE_VIRTIO_GPU_CCW)
+
+typedef struct VirtIOGPUCcw {
+    VirtioCcwDevice parent_obj;
+    VirtIOGPU vdev;
+} VirtIOGPUCcw;
+
 #endif
-- 
1.9.1
