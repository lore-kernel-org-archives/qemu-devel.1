Received: from eggs.gnu.org ([2001:4830:134:3::10]:34616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fY5j8-00021D-7Z
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fY5j5-0002Lr-8N
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:22:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42876 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fY5j5-0002Jr-44
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:22:55 -0400
From: Pankaj Gupta <pagupta@redhat.com>
Date: Wed, 27 Jun 2018 13:52:47 +0530
Message-Id: <20180627082248.14921-2-pagupta@redhat.com>
In-Reply-To: <20180627082248.14921-1-pagupta@redhat.com>
References: <20180627082248.14921-1-pagupta@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] virtio-rng: process pending requests when
 driver is ready
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, amit@kernel.org, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, slopezpa@redhat.com

 virtio-rng device causing old guest kernels(2.6.32) to hang on latest qemu.
 The driver attempts to read from the virtio-rng device too early in it's
 initialization. Qemu detects guest is not ready and returns, resulting in
 hang.

 Fix is to handle pending request when guest is running and driver status is 
 set to 'VIRTIO_CONFIG_S_DRIVER_OK'.

Reported-by: Sergio lopez <slopezpa@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio-rng.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 289bbcac03..49e2d0c10a 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -156,6 +156,18 @@ static void check_rate_limit(void *opaque)
     vrng->activate_timer = true;
 }
 
+static void virtio_rng_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VirtIORNG *vrng = VIRTIO_RNG(vdev);
+
+    if (!vdev->vm_running) {
+        return;
+    }
+
+    /* Something changed, try to process buffers */
+    virtio_rng_process(vrng);
+}
+
 static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -261,6 +273,7 @@ static void virtio_rng_class_init(ObjectClass *klass, void *data)
     vdc->realize = virtio_rng_device_realize;
     vdc->unrealize = virtio_rng_device_unrealize;
     vdc->get_features = get_features;
+    vdc->set_status = virtio_rng_set_status;
 }
 
 static const TypeInfo virtio_rng_info = {
-- 
2.14.3
