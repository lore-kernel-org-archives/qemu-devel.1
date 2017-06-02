Received: from eggs.gnu.org ([2001:4830:134:3::10]:34408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpX2-0007rU-Ai
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpX1-0006Gd-FD
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:36 -0400
Date: Fri, 2 Jun 2017 19:34:29 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496421247-857-2-git-send-email-mst@redhat.com>
References: <1496421247-857-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496421247-857-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/8] virtio-serial-bus: Unset hotplug handler
 when unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ladi Prosek <lprosek@redhat.com>, qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Amit Shah <amit@kernel.org>

From: Ladi Prosek <lprosek@redhat.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
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
MST
