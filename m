Received: from eggs.gnu.org ([2001:4830:134:3::10]:35904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fZsNN-0000It-W2
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fZsNJ-0006zx-WD
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:31:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fZsNJ-0006yE-RP
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:31:49 -0400
From: Pankaj Gupta <pagupta@redhat.com>
Date: Mon,  2 Jul 2018 12:01:39 +0530
Message-Id: <20180702063139.7935-1-pagupta@redhat.com>
Subject: [Qemu-devel] [PATCH v3] virtio-rng: process pending requests when
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

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
v2->v3: Add comment to explain virtio-rng early status update (Stefan)
v1->v2: Update new status value early only for virtio-rng (Stefan)

 hw/virtio/virtio-rng.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 289bbcac03..0b586bd750 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -156,6 +156,24 @@ static void check_rate_limit(void *opaque)
     vrng->activate_timer = true;
 }
 
+static void virtio_rng_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VirtIORNG *vrng = VIRTIO_RNG(vdev);
+
+    if (!vdev->vm_running) {
+        return;
+    }
+    /* Set device status in VirtIODevice object. Its used in 'is_guest_ready'
+     * function to check if guest is ready and process the pending requests.
+     * Other virtio devices might be dependent on old value of status, so
+     * update status early only for virtio-rng.
+     */
+    vdev->status = status;
+
+    /* Something changed, try to process buffers */
+    virtio_rng_process(vrng);
+}
+
 static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -261,6 +279,7 @@ static void virtio_rng_class_init(ObjectClass *klass, void *data)
     vdc->realize = virtio_rng_device_realize;
     vdc->unrealize = virtio_rng_device_unrealize;
     vdc->get_features = get_features;
+    vdc->set_status = virtio_rng_set_status;
 }
 
 static const TypeInfo virtio_rng_info = {
-- 
2.14.3
