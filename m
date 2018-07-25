Received: from eggs.gnu.org ([2001:4830:134:3::10]:40440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiImR-00060V-FT
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fiImN-00026S-RY
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:20:34 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 25 Jul 2018 14:20:15 +0200
Message-Id: <1532521224-27235-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1532521224-27235-1-git-send-email-thuth@redhat.com>
References: <1532521224-27235-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 01/10] hw/s390x/virtio-ccw: Consolidate
 calls to virtio_ccw_unrealize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

Currently, every virtio-ccw device explicitely sets its unrealize
function to virtio_ccw_unrealize() in its class_init function.
We can simplify this by using a common unrealize function, just like
it is already done for the realize functions.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/virtio-ccw.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 7ddb378..7d35c77 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -750,11 +750,16 @@ out_err:
     g_free(sch);
 }
 
-static void virtio_ccw_unrealize(VirtioCcwDevice *dev, Error **errp)
+static void virtio_ccw_device_unrealize(VirtioCcwDevice *dev, Error **errp)
 {
+    VirtIOCCWDeviceClass *dc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
     CcwDevice *ccw_dev = CCW_DEVICE(dev);
     SubchDev *sch = ccw_dev->sch;
 
+    if (dc->unrealize) {
+        dc->unrealize(dev, errp);
+    }
+
     if (sch) {
         css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
         g_free(sch);
@@ -1349,7 +1354,6 @@ static void virtio_ccw_net_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_net_realize;
-    k->unrealize = virtio_ccw_unrealize;
     dc->props = virtio_ccw_net_properties;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
@@ -1376,7 +1380,6 @@ static void virtio_ccw_blk_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_blk_realize;
-    k->unrealize = virtio_ccw_unrealize;
     dc->props = virtio_ccw_blk_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
@@ -1403,7 +1406,6 @@ static void virtio_ccw_serial_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_serial_realize;
-    k->unrealize = virtio_ccw_unrealize;
     dc->props = virtio_ccw_serial_properties;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
@@ -1430,7 +1432,6 @@ static void virtio_ccw_balloon_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_balloon_realize;
-    k->unrealize = virtio_ccw_unrealize;
     dc->props = virtio_ccw_balloon_properties;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
@@ -1457,7 +1458,6 @@ static void virtio_ccw_scsi_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_scsi_realize;
-    k->unrealize = virtio_ccw_unrealize;
     dc->props = virtio_ccw_scsi_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
@@ -1483,7 +1483,6 @@ static void vhost_ccw_scsi_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = vhost_ccw_scsi_realize;
-    k->unrealize = virtio_ccw_unrealize;
     dc->props = vhost_ccw_scsi_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
@@ -1519,7 +1518,6 @@ static void virtio_ccw_rng_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_rng_realize;
-    k->unrealize = virtio_ccw_unrealize;
     dc->props = virtio_ccw_rng_properties;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
@@ -1556,7 +1554,6 @@ static void virtio_ccw_crypto_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_crypto_realize;
-    k->unrealize = virtio_ccw_unrealize;
     dc->props = virtio_ccw_crypto_properties;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
@@ -1593,7 +1590,6 @@ static void virtio_ccw_gpu_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_gpu_realize;
-    k->unrealize = virtio_ccw_unrealize;
     dc->props = virtio_ccw_gpu_properties;
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
@@ -1621,7 +1617,6 @@ static void virtio_ccw_input_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = virtio_ccw_input_realize;
-    k->unrealize = virtio_ccw_unrealize;
     dc->props = virtio_ccw_input_properties;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
@@ -1703,9 +1698,8 @@ static void virtio_ccw_busdev_realize(DeviceState *dev, Error **errp)
 static void virtio_ccw_busdev_unrealize(DeviceState *dev, Error **errp)
 {
     VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
-    VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
 
-    _info->unrealize(_dev, errp);
+    virtio_ccw_device_unrealize(_dev, errp);
 }
 
 static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
@@ -1801,7 +1795,6 @@ static void virtio_ccw_9p_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
-    k->unrealize = virtio_ccw_unrealize;
     k->realize = virtio_ccw_9p_realize;
     dc->props = virtio_ccw_9p_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
@@ -1847,7 +1840,6 @@ static void vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
     VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
 
     k->realize = vhost_vsock_ccw_realize;
-    k->unrealize = virtio_ccw_unrealize;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->props = vhost_vsock_ccw_properties;
 }
-- 
1.8.3.1
