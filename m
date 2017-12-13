Received: from eggs.gnu.org ([2001:4830:134:3::10]:59151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ePDFq-0006H2-8d
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ePDFo-00088V-9Q
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:03:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ePDFo-000888-3o
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:03:44 -0500
Date: Wed, 13 Dec 2017 22:03:42 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513195345-9506-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] virtio_error: don't invoke status callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ilya Maximets <i.maximets@samsung.com>

Backends don't need to know what frontend requested a reset,
and notifying then from virtio_error is messy because
virtio_error itself might be invoked from backend.

Let's just set the status directly.

Reported-by: Ilya Maximets <i.maximets@samsung.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Ilya this should fix the crash you are seeing, but
the error itself still shows there's something wrong.
So I'd like to defer applying that patch until we
figure out what corrupted guest index.

If you know pls let me know!


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
