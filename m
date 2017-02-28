Received: from eggs.gnu.org ([2001:4830:134:3::10]:49850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cihil-0003OJ-1K
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cihih-0004Js-1v
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:21:38 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 Feb 2017 14:21:32 +0100
Message-Id: <20170228132132.20231-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio: always use handle_aio_output if
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
Cc: mst@redhat.com, kraxel@redhat.com, qemu-stable@nongnu.org

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
---
 hw/virtio/virtio.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 23483c7..1206f6c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1458,7 +1458,18 @@ static void virtio_queue_notify_vq(VirtQueue *vq)
 
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
2.9.3
