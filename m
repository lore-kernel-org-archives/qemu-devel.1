Received: from eggs.gnu.org ([2001:4830:134:3::10]:43626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhLN-0004Xm-7v
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhLM-0005jl-9i
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:22:09 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:44 -0500
Message-Id: <20180723201748.25573-96-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 95/99] virtio-rng: process pending requests on
 DRIVER_OK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Pankaj Gupta <pagupta@redhat.com>

virtio-rng device causes old guest kernels(2.6.32) to hang on latest qemu.
The driver attempts to read from the virtio-rng device too early in it's
initialization. Qemu detects guest is not ready and returns, resulting in
hang.

To fix handle pending requests when guest is running and driver status is
set to 'VIRTIO_CONFIG_S_DRIVER_OK'.

CC: qemu-stable@nongnu.org
Reported-by: Sergio lopez <slopezpa@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 5d9c9ea22ab4f3b3ee497523e34b6f4d3281f62d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-rng.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 289bbcac03..855f1b41d1 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -156,6 +156,19 @@ static void check_rate_limit(void *opaque)
     vrng->activate_timer = true;
 }
 
+static void virtio_rng_set_status(VirtIODevice *vdev, uint8_t status)
+{
+    VirtIORNG *vrng = VIRTIO_RNG(vdev);
+
+    if (!vdev->vm_running) {
+        return;
+    }
+    vdev->status = status;
+
+    /* Something changed, try to process buffers */
+    virtio_rng_process(vrng);
+}
+
 static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -261,6 +274,7 @@ static void virtio_rng_class_init(ObjectClass *klass, void *data)
     vdc->realize = virtio_rng_device_realize;
     vdc->unrealize = virtio_rng_device_unrealize;
     vdc->get_features = get_features;
+    vdc->set_status = virtio_rng_set_status;
 }
 
 static const TypeInfo virtio_rng_info = {
-- 
2.17.1
