Received: from eggs.gnu.org ([2001:4830:134:3::10]:40589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuU-0005c8-Ov
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etzuT-0006Cj-K6
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:04:58 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  8 Mar 2018 19:04:23 +0100
Message-Id: <20180308180423.941-12-cohuck@redhat.com>
In-Reply-To: <20180308180423.941-1-cohuck@redhat.com>
References: <20180308180423.941-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 11/11] s390x/virtio: Convert virtio-ccw from
 *_exit to *_unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Nia Alarie <nia.alarie@gmail.com>, Cornelia Huck <cohuck@redhat.com>

From: Nia Alarie <nia.alarie@gmail.com>

Signed-off-by: Nia Alarie <nia.alarie@gmail.com>
Message-Id: <20180307162958.11232-1-nia.alarie@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/virtio-ccw.c | 34 +++++++++++++++++-----------------
 hw/s390x/virtio-ccw.h |  2 +-
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 8f7fbc2ab7..e51fbefd23 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -752,7 +752,7 @@ out_err:
     g_free(sch);
 }
 
-static int virtio_ccw_exit(VirtioCcwDevice *dev)
+static void virtio_ccw_unrealize(VirtioCcwDevice *dev, Error **errp)
 {
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
     SubchDev *sch = ccw_dev->sch;
@@ -760,12 +760,12 @@ static int virtio_ccw_exit(VirtioCcwDevice *dev)
     if (sch) {
         css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
         g_free(sch);
+        ccw_dev->sch = NULL;
     }
     if (dev->indicators) {
         release_indicator(&dev->routes.adapter, dev->indicators);
         dev->indicators = NULL;
     }
-    return 0;
 }
 
 static void virtio_ccw_net_realize(VirtioCcwDevice *ccw_dev, Error **errp)
@@ -1344,7 +1344,7 @@ static void virtio_ccw_net_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_net_realize;
-    k->exit = virtio_ccw_exit;
+    k->unrealize = virtio_ccw_unrealize;
     dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_net_properties;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
@@ -1372,7 +1372,7 @@ static void virtio_ccw_blk_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_blk_realize;
-    k->exit = virtio_ccw_exit;
+    k->unrealize = virtio_ccw_unrealize;
     dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_blk_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
@@ -1400,7 +1400,7 @@ static void virtio_ccw_serial_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_serial_realize;
-    k->exit = virtio_ccw_exit;
+    k->unrealize = virtio_ccw_unrealize;
     dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_serial_properties;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
@@ -1428,7 +1428,7 @@ static void virtio_ccw_balloon_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_balloon_realize;
-    k->exit = virtio_ccw_exit;
+    k->unrealize = virtio_ccw_unrealize;
     dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_balloon_properties;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
@@ -1456,7 +1456,7 @@ static void virtio_ccw_scsi_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_scsi_realize;
-    k->exit = virtio_ccw_exit;
+    k->unrealize = virtio_ccw_unrealize;
     dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_scsi_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
@@ -1483,7 +1483,7 @@ static void vhost_ccw_scsi_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = vhost_ccw_scsi_realize;
-    k->exit = virtio_ccw_exit;
+    k->unrealize = virtio_ccw_unrealize;
     dc->reset = virtio_ccw_reset;
     dc->props = vhost_ccw_scsi_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
@@ -1520,7 +1520,7 @@ static void virtio_ccw_rng_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_rng_realize;
-    k->exit = virtio_ccw_exit;
+    k->unrealize = virtio_ccw_unrealize;
     dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_rng_properties;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
@@ -1558,7 +1558,7 @@ static void virtio_ccw_crypto_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_crypto_realize;
-    k->exit = virtio_ccw_exit;
+    k->unrealize = virtio_ccw_unrealize;
     dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_crypto_properties;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
@@ -1596,7 +1596,7 @@ static void virtio_ccw_gpu_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_gpu_realize;
-    k->exit = virtio_ccw_exit;
+    k->unrealize = virtio_ccw_unrealize;
     dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_gpu_properties;
     dc->hotpluggable = false;
@@ -1625,7 +1625,7 @@ static void virtio_ccw_input_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_input_realize;
-    k->exit = virtio_ccw_exit;
+    k->unrealize = virtio_ccw_unrealize;
     dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_input_properties;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
@@ -1705,12 +1705,12 @@ static void virtio_ccw_busdev_realize(DeviceState *dev, Error **errp)
     virtio_ccw_device_realize(_dev, errp);
 }
 
-static int virtio_ccw_busdev_exit(DeviceState *dev)
+static void virtio_ccw_busdev_unrealize(DeviceState *dev, Error **errp)
 {
     VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
     VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
 
-    return _info->exit(_dev);
+    _info->unrealize(_dev, errp);
 }
 
 static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
@@ -1728,7 +1728,7 @@ static void virtio_ccw_device_class_init(ObjectClass *klass, void *data)
 
     k->unplug = virtio_ccw_busdev_unplug;
     dc->realize = virtio_ccw_busdev_realize;
-    dc->exit = virtio_ccw_busdev_exit;
+    dc->unrealize = virtio_ccw_busdev_unrealize;
     dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
 }
 
@@ -1804,7 +1804,7 @@ static void virtio_ccw_9p_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
-    k->exit = virtio_ccw_exit;
+    k->unrealize = virtio_ccw_unrealize;
     k->realize = virtio_ccw_9p_realize;
     dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_9p_properties;
@@ -1853,7 +1853,7 @@ static void vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = vhost_vsock_ccw_realize;
-    k->exit = virtio_ccw_exit;
+    k->unrealize = virtio_ccw_unrealize;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->props = vhost_vsock_ccw_properties;
     dc->reset = virtio_ccw_reset;
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 3905f3a3d6..2fc513001e 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -76,7 +76,7 @@ typedef struct VirtioCcwDevice VirtioCcwDevice;
 typedef struct VirtIOCCWDeviceClass {
     CCWDeviceClass parent_class;
     void (*realize)(VirtioCcwDevice *dev, Error **errp);
-    int (*exit)(VirtioCcwDevice *dev);
+    void (*unrealize)(VirtioCcwDevice *dev, Error **errp);
 } VirtIOCCWDeviceClass;
 
 /* Performance improves when virtqueue kick processing is decoupled from the
-- 
2.13.6
