Received: from eggs.gnu.org ([2001:4830:134:3::10]:52454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOli5-0007kS-Tt
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOli1-0000kW-1o
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOli0-0000k9-Sh
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:28 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Jan 2017 13:34:05 +0000
Message-Id: <20170104133414.6524-6-stefanha@redhat.com>
In-Reply-To: <20170104133414.6524-1-stefanha@redhat.com>
References: <20170104133414.6524-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 05/14] virtio: poll virtqueues for new buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Add an AioContext poll handler to detect new virtqueue buffers without
waiting for a guest->host notification.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161201192652.9509-5-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 6f8ca25..3870411 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2047,13 +2047,27 @@ static void virtio_queue_host_notifier_aio_read(EventNotifier *n)
     }
 }
 
+static bool virtio_queue_host_notifier_aio_poll(void *opaque)
+{
+    EventNotifier *n = opaque;
+    VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
+
+    if (virtio_queue_empty(vq)) {
+        return false;
+    }
+
+    virtio_queue_notify_aio_vq(vq);
+    return true;
+}
+
 void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
                                                 VirtIOHandleOutput handle_output)
 {
     if (handle_output) {
         vq->handle_aio_output = handle_output;
         aio_set_event_notifier(ctx, &vq->host_notifier, true,
-                               virtio_queue_host_notifier_aio_read, NULL);
+                               virtio_queue_host_notifier_aio_read,
+                               virtio_queue_host_notifier_aio_poll);
     } else {
         aio_set_event_notifier(ctx, &vq->host_notifier, true, NULL, NULL);
         /* Test and clear notifier before after disabling event,
-- 
2.9.3
