Received: from eggs.gnu.org ([2001:4830:134:3::10]:45766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qW-0007oa-M3
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qV-0005dx-Lk
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:16 -0500
Date: Thu, 21 Dec 2017 16:29:13 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-11-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 10/25] virtio_error: don't invoke status
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org, Ilya Maximets <i.maximets@samsung.com>

Backends don't need to know what frontend requested a reset,
and notifying then from virtio_error is messy because
virtio_error itself might be invoked from backend.

Let's just set the status directly.

Cc: qemu-stable@nongnu.org
Reported-by: Ilya Maximets <i.maximets@samsung.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index ad564b0..d6002ee 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2469,7 +2469,7 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
     va_end(ap);
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
+        vdev->status = vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET;
         virtio_notify_config(vdev);
     }
 
-- 
MST
