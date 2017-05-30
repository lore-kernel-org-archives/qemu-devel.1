Received: from eggs.gnu.org ([2001:4830:134:3::10]:60321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dFd0P-0004HC-BL
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dFd0K-0003qu-Ie
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:59:57 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 30 May 2017 10:59:43 +0200
Message-Id: <20170530085943.18141-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio-serial-bus: Unset hotplug handler when
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, famz@redhat.com, pbonzini@redhat.com, mst@redhat.com

Virtio serial device controls the lifetime of virtio-serial-bus and
virtio-serial-bus links back to the device via its hotplug-handler
property. This extra ref-count prevents the device from getting
finalized, leaving the VirtIODevice memory listener registered and
leading to use-after-free later on.

This patch addresses the same issue as Fam Zheng's
"virtio-scsi: Unset hotplug handler when unrealize"
only for a different virtio device.

Cc: qemu-stable@nongnu.org
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/char/virtio-serial-bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index d797a67..aa9c11a 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1121,6 +1121,9 @@ static void virtio_serial_device_unrealize(DeviceState *dev, Error **errp)
         timer_free(vser->post_load->timer);
         g_free(vser->post_load);
     }
+
+    qbus_set_hotplug_handler(BUS(&vser->bus), NULL, errp);
+
     virtio_cleanup(vdev);
 }
 
-- 
2.9.3
