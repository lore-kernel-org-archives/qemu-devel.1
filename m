Received: from eggs.gnu.org ([2001:4830:134:3::10]:47893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCO-0001Aj-DT
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCM-0005PD-FM
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCM-0005Ok-79
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:06 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0ECLT041673
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:05 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmsrsj1hu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:05 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:03 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:08 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-34-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 33/79] virtio: allow broken device to notify
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
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, "Michael S . Tsirkin" <mst@redhat.com>

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
(cherry picked from commit 66453cff9e5e75344c601cd7674c8ef5fefee8a6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.7.4
