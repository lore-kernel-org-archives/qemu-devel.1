Received: from eggs.gnu.org ([2001:4830:134:3::10]:52241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAu9p-0002QU-Sp
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAu9k-0004ZC-SG
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:18:09 -0400
Received: from 6.mo3.mail-out.ovh.net ([188.165.43.173]:33647)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAu9k-0004Yn-Mo
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:18:04 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 61EE2D3084
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 10:18:01 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 17 May 2017 10:17:51 +0200
Message-ID: <149500797926.28874.3877030098009500731.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RESEND PATCH] virtio: allow broken device to notify
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
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

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
---
 hw/virtio/virtio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Re-sending this patch with Cornelia's Reviewed-by and Cc'ing qemu-stable
since this is a spec violation, as suggested in:

Message-ID: <20170427183237-mutt-send-email-mst@kernel.org>

Cheers,

--
Greg

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 03592c542a55..890b4d7eb751 100644
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
