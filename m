Received: from eggs.gnu.org ([2001:4830:134:3::10]:53092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etaGx-0002oA-UE
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1etaGw-0005AH-VX
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 09:42:27 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  7 Mar 2018 14:42:03 +0000
Message-Id: <20180307144205.20619-3-stefanha@redhat.com>
In-Reply-To: <20180307144205.20619-1-stefanha@redhat.com>
References: <20180307144205.20619-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/4] virtio-blk: fix race between
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
Cc: Fam Zheng <famz@redhat.com>, Richard Henderson <rth@twiddle.net>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>

If the main loop thread invokes .ioeventfd_stop() just as the vq handler
function begins in the IOThread then the handler may lose the race for
the AioContext lock.  By the time the vq handler is able to acquire the
AioContext lock the ioeventfd has already been removed and the handler
isn't supposed to run anymore!

Use the new aio_wait_bh_oneshot() function to perform ioeventfd removal
from within the IOThread.  This way no races with the vq handler are
possible.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/dataplane/virtio-blk.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 2cb990997e..d3bb09bc4e 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -229,6 +229,22 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
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
@@ -253,13 +269,7 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
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
