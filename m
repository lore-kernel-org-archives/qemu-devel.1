Received: from eggs.gnu.org ([2001:4830:134:3::10]:52538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOliH-0007vT-9u
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOliG-0000rY-H5
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30265)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOliG-0000rE-BG
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:44 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Jan 2017 13:34:12 +0000
Message-Id: <20170104133414.6524-13-stefanha@redhat.com>
In-Reply-To: <20170104133414.6524-1-stefanha@redhat.com>
References: <20170104133414.6524-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 12/14] virtio: disable virtqueue notifications
 during polling
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

This is a performance optimization to eliminate vmexits during polling.
It also avoids spurious ioeventfd processing after polling ends.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20161201192652.9509-12-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 79b5c36..d40711a 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2053,6 +2053,13 @@ static void virtio_queue_host_notifier_aio_read(EventNotifier *n)
     }
 }
 
+static void virtio_queue_host_notifier_aio_poll_begin(EventNotifier *n)
+{
+    VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
+
+    virtio_queue_set_notification(vq, 0);
+}
+
 static bool virtio_queue_host_notifier_aio_poll(void *opaque)
 {
     EventNotifier *n = opaque;
@@ -2066,6 +2073,14 @@ static bool virtio_queue_host_notifier_aio_poll(void *opaque)
     return true;
 }
 
+static void virtio_queue_host_notifier_aio_poll_end(EventNotifier *n)
+{
+    VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
+
+    /* Caller polls once more after this to catch requests that race with us */
+    virtio_queue_set_notification(vq, 1);
+}
+
 void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
                                                 VirtIOHandleOutput handle_output)
 {
@@ -2074,6 +2089,9 @@ void virtio_queue_aio_set_host_notifier_handler(VirtQueue *vq, AioContext *ctx,
         aio_set_event_notifier(ctx, &vq->host_notifier, true,
                                virtio_queue_host_notifier_aio_read,
                                virtio_queue_host_notifier_aio_poll);
+        aio_set_event_notifier_poll(ctx, &vq->host_notifier,
+                                    virtio_queue_host_notifier_aio_poll_begin,
+                                    virtio_queue_host_notifier_aio_poll_end);
     } else {
         aio_set_event_notifier(ctx, &vq->host_notifier, true, NULL, NULL);
         /* Test and clear notifier before after disabling event,
-- 
2.9.3
