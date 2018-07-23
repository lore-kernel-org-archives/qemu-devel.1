Received: from eggs.gnu.org ([2001:4830:134:3::10]:40906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIW-0001dN-28
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIU-0002oi-KE
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:12 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:30 -0500
Message-Id: <20180723201748.25573-22-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 21/99] virtio-ccw: common reset handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: Cornelia Huck <cohuck@redhat.com>

All the different virtio ccw devices use the same reset handler,
so let's move setting it into the base virtio ccw device class.

CC: qemu-stable@nongnu.org
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit 0c53057adb04d254bc09511880670c92ab185fc6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.17.1
