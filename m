Received: from eggs.gnu.org ([2001:4830:134:3::10]:40785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIFbM-0000Hj-II
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIFbL-0007WW-DQ
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:41:28 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 14 May 2018 17:41:11 +0200
Message-Id: <20180514154114.2558-4-cohuck@redhat.com>
In-Reply-To: <20180514154114.2558-1-cohuck@redhat.com>
References: <20180514154114.2558-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] virtio-ccw: common reset handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org

All the different virtio ccw devices use the same reset handler,
so let's move setting it into the base virtio ccw device class.

CC: qemu-stable@nongnu.org
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/virtio-ccw.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index e51fbefd23..40a33302a7 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1345,7 +1345,6 @@ static void virtio_ccw_net_class_init(ObjectClass *klass, void *data)
 
     k->realize = virtio_ccw_net_realize;
     k->unrealize = virtio_ccw_unrealize;
-    dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_net_properties;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
 }
@@ -1373,7 +1372,6 @@ static void virtio_ccw_blk_class_init(ObjectClass *klass, void *data)
 
     k->realize = virtio_ccw_blk_realize;
     k->unrealize = virtio_ccw_unrealize;
-    dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_blk_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
@@ -1401,7 +1399,6 @@ static void virtio_ccw_serial_class_init(ObjectClass *klass, void *data)
 
     k->realize = virtio_ccw_serial_realize;
     k->unrealize = virtio_ccw_unrealize;
-    dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_serial_properties;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
@@ -1429,7 +1426,6 @@ static void virtio_ccw_balloon_class_init(ObjectClass *klass, void *data)
 
     k->realize = virtio_ccw_balloon_realize;
     k->unrealize = virtio_ccw_unrealize;
-    dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_balloon_properties;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
@@ -1457,7 +1453,6 @@ static void virtio_ccw_scsi_class_init(ObjectClass *klass, void *data)
 
     k->realize = virtio_ccw_scsi_realize;
     k->unrealize = virtio_ccw_unrealize;
-    dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_scsi_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
@@ -1484,7 +1479,6 @@ static void vhost_ccw_scsi_class_init(ObjectClass *klass, void *data)
 
     k->realize = vhost_ccw_scsi_realize;
     k->unrealize = virtio_ccw_unrealize;
-    dc->reset = virtio_ccw_reset;
     dc->props = vhost_ccw_scsi_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
@@ -1521,7 +1515,6 @@ static void virtio_ccw_rng_class_init(ObjectClass *klass, void *data)
 
     k->realize = virtio_ccw_rng_realize;
     k->unrealize = virtio_ccw_unrealize;
-    dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_rng_properties;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
@@ -1559,7 +1552,6 @@ static void virtio_ccw_crypto_class_init(ObjectClass *klass, void *data)
 
     k->realize = virtio_ccw_crypto_realize;
     k->unrealize = virtio_ccw_unrealize;
-    dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_crypto_properties;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
@@ -1597,7 +1589,6 @@ static void virtio_ccw_gpu_class_init(ObjectClass *klass, void *data)
 
     k->realize = virtio_ccw_gpu_realize;
     k->unrealize = virtio_ccw_unrealize;
-    dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_gpu_properties;
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
@@ -1626,7 +1617,6 @@ static void virtio_ccw_input_class_init(ObjectClass *klass, void *data)
 
     k->realize = virtio_ccw_input_realize;
     k->unrealize = virtio_ccw_unrealize;
-    dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_input_properties;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
@@ -1730,6 +1720,7 @@ static void virtio_ccw_device_class_init(ObjectClass *klass, void *data)
     dc->realize = virtio_ccw_busdev_realize;
     dc->unrealize = virtio_ccw_busdev_unrealize;
     dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
+    dc->reset = virtio_ccw_reset;
 }
 
 static const TypeInfo virtio_ccw_device_info = {
@@ -1806,7 +1797,6 @@ static void virtio_ccw_9p_class_init(ObjectClass *klass, void *data)
 
     k->unrealize = virtio_ccw_unrealize;
     k->realize = virtio_ccw_9p_realize;
-    dc->reset = virtio_ccw_reset;
     dc->props = virtio_ccw_9p_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
@@ -1856,7 +1846,6 @@ static void vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
     k->unrealize = virtio_ccw_unrealize;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->props = vhost_vsock_ccw_properties;
-    dc->reset = virtio_ccw_reset;
 }
 
 static void vhost_vsock_ccw_instance_init(Object *obj)
-- 
2.14.3
