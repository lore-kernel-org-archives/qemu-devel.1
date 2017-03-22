Received: from eggs.gnu.org ([2001:4830:134:3::10]:35166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=0SF/=27=redhat.com=mst@kernel.org>)
	id 1cqihv-00032Q-OJ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=0SF/=27=redhat.com=mst@kernel.org>)
	id 1cqihn-0007De-CF
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:01:51 -0400
Date: Wed, 22 Mar 2017 18:01:37 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1490198476-12244-3-git-send-email-mst@redhat.com>
References: <1490198476-12244-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490198476-12244-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 2/4] virtio: always use handle_aio_output if
 registered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Commit ad07cd6 ("virtio-scsi: always use dataplane path if ioeventfd is
active", 2016-10-30) and 9ffe337 ("virtio-blk: always use dataplane
path if ioeventfd is active", 2016-10-30) broke the virtio 1.0
indirect access registers.

The indirect access registers bypass the ioeventfd, so that virtio-blk
and virtio-scsi now repeatedly try to initialize dataplane instead of
triggering the guest->host EventNotifier.  Detect the situation by
checking vq->handle_aio_output; if it is not NULL, trigger the
EventNotifier, which is how the device expects to get notifications
and in fact the only thread-safe manner to deliver them.

Fixes: ad07cd6
Fixes: 9ffe337
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 82b6060..03592c5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1528,7 +1528,18 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
 
 void virtio_queue_notify(VirtIODevice *vdev, int n)
 {
-    virtio_queue_notify_vq(&vdev->vq[n]);
+    VirtQueue *vq = &vdev->vq[n];
+
+    if (unlikely(!vq->vring.desc || vdev->broken)) {
+        return;
+    }
+
+    trace_virtio_queue_notify(vdev, vq - vdev->vq, vq);
+    if (vq->handle_aio_output) {
+        event_notifier_set(&vq->host_notifier);
+    } else if (vq->handle_output) {
+        vq->handle_output(vdev, vq);
+    }
 }
 
 uint16_t virtio_queue_vector(VirtIODevice *vdev, int n)
-- 
MST
