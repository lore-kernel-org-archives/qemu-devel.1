Received: from eggs.gnu.org ([2001:4830:134:3::10]:47252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duK1D-0005mY-ES
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duK17-0001lD-EA
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:00:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5601)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duK17-0001kV-5b
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:00:53 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 16:56:35 +0200
Message-Id: <20170919145636.9389-38-cohuck@redhat.com>
In-Reply-To: <20170919145636.9389-1-cohuck@redhat.com>
References: <20170919145636.9389-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 37/38] virtio-ccw: Create a virtio gpu device
 for the ccw bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

Wire up the virtio-gpu device for the CCW bus. The virtio-gpu
is a virtio-1 device, so disable revision 0.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <6c53f939cf2d64b66d2a6878b29c9bf3820f3d5b.1505485574.git.alifm@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/virtio-ccw.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h | 10 ++++++++++
 2 files changed, 59 insertions(+)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 2262b0cc9a..ff1bb1534c 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1005,6 +1005,15 @@ static void virtio_ccw_crypto_realize(VirtioCcwDevice *ccw_dev, Error **errp)
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
@@ -1614,6 +1623,45 @@ static const TypeInfo virtio_ccw_crypto = {
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
@@ -1813,6 +1861,7 @@ static void virtio_ccw_register(void)
     type_register_static(&vhost_vsock_ccw_info);
 #endif
     type_register_static(&virtio_ccw_crypto);
+    type_register_static(&virtio_ccw_gpu);
 }
 
 type_init(virtio_ccw_register)
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 41d4010378..541fdd2994 100644
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
2.13.5
