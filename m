Received: from eggs.gnu.org ([2001:4830:134:3::10]:44326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6W-0001fH-Cj
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6V-0003oF-Gq
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:44 -0500
Received: from mail.kernel.org ([198.145.29.136]:51242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6V-0003n9-BI
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:43 -0500
Date: Thu, 2 Mar 2017 08:20:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1488435591-17882-9-git-send-email-mst@redhat.com>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488435591-17882-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 08/15] virtio: check for vring setup in
 virtio_queue_empty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Paolo Bonzini <pbonzini@redhat.com>

If the vring has not been set up, there is nothing in the virtqueue.
virtio_queue_host_notifier_aio_poll calls virtio_queue_empty even in
this case; we have to filter it out just like virtio_queue_notify_aio_vq.

Reported-by: Gerd Hoffmann <kraxel@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/virtio/virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 23483c7..e487e36 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2291,7 +2291,7 @@ static bool virtio_queue_host_notifier_aio_poll(void *opaque)
     VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
     bool progress;
 
-    if (virtio_queue_empty(vq)) {
+    if (!vq->vring.desc || virtio_queue_empty(vq)) {
         return false;
     }
 
-- 
MST
