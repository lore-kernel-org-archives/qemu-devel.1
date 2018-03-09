Received: from eggs.gnu.org ([2001:4830:134:3::10]:45465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1euHwb-0001Gm-PE
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1euHwZ-0007d8-IS
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:20:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  9 Mar 2018 13:19:47 +0000
Message-Id: <20180309131949.18640-6-stefanha@redhat.com>
In-Reply-To: <20180309131949.18640-1-stefanha@redhat.com>
References: <20180309131949.18640-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] virtio-blk: fix race between
 .ioeventfd_stop() and vq handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>

If the main loop thread invokes .ioeventfd_stop() just as the vq handler
function begins in the IOThread then the handler may lose the race for
the AioContext lock.  By the time the vq handler is able to acquire the
AioContext lock the ioeventfd has already been removed and the handler
isn't supposed to run anymore!

Use the new aio_wait_bh_oneshot() function to perform ioeventfd removal
from within the IOThread.  This way no races with the vq handler are
possible.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20180307144205.20619-3-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/dataplane/virtio-blk.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index c46253a924..101f32cf66 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -240,6 +240,22 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
     return -ENOSYS;
 }
 
+/* Stop notifications for new requests from guest.
+ *
+ * Context: BH in IOThread
+ */
+static void virtio_blk_data_plane_stop_bh(void *opaque)
+{
+    VirtIOBlockDataPlane *s = opaque;
+    unsigned i;
+
+    for (i = 0; i < s->conf->num_queues; i++) {
+        VirtQueue *vq = virtio_get_queue(s->vdev, i);
+
+        virtio_queue_aio_set_host_notifier_handler(vq, s->ctx, NULL);
+    }
+}
+
 /* Context: QEMU global mutex held */
 void virtio_blk_data_plane_stop(VirtIODevice *vdev)
 {
@@ -264,13 +280,7 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
     trace_virtio_blk_data_plane_stop(s);
 
     aio_context_acquire(s->ctx);
-
-    /* Stop notifications for new requests from guest */
-    for (i = 0; i < nvqs; i++) {
-        VirtQueue *vq = virtio_get_queue(s->vdev, i);
-
-        virtio_queue_aio_set_host_notifier_handler(vq, s->ctx, NULL);
-    }
+    aio_wait_bh_oneshot(s->ctx, virtio_blk_data_plane_stop_bh, s);
 
     /* Drain and switch bs back to the QEMU main loop */
     blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context());
-- 
2.14.3
