Received: from eggs.gnu.org ([2001:4830:134:3::10]:48306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dB6lC-00012Y-Qr
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dB6lB-0005S3-V8
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:45:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dB6lB-0005Ro-PF
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:45:33 -0400
Date: Thu, 18 May 2017 00:45:29 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1495057396-13387-12-git-send-email-mst@redhat.com>
References: <1495057396-13387-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495057396-13387-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 11/13] virtio: allow broken device to notify
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Greg Kurz <groug@kaod.org>

According to section 2.1.2 of the virtio-1 specification:

"The device SHOULD set DEVICE_NEEDS_RESET when it enters an error state that
a reset is needed. If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET,
the device MUST send a device configuration change notification to the
driver."

Commit "f5ed36635d8f virtio: stop virtqueue processing if device is broken"
introduced a virtio_error() call that just does that:

- internally mark the device as broken
- set the DEVICE_NEEDS_RESET bit in the status
- send a configuration change notification

Unfortunately, virtio_notify_vector(), called by virtio_notify_config(),
returns right away when the device is marked as broken and the notification
isn't sent in this case.

The spec doesn't say whether a broken device can send notifications
in other situations or not. But since the driver isn't supposed to do
anything but to reset the device, it makes sense to keep the check in
virtio_notify_config().

Marking the device as broken AFTER the configuration change notification was
sent is enough to fix the issue.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 03592c5..890b4d7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2451,12 +2451,12 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
     error_vreport(fmt, ap);
     va_end(ap);
 
-    vdev->broken = true;
-
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
         virtio_notify_config(vdev);
     }
+
+    vdev->broken = true;
 }
 
 static void virtio_memory_listener_commit(MemoryListener *listener)
-- 
MST
