Received: from eggs.gnu.org ([2001:4830:134:3::10]:46047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1er6Kb-00085f-D0
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:19:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1er6Ka-0000jn-8o
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:19:57 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 28 Feb 2018 18:19:45 +0000
Message-Id: <20180228181946.22958-4-stefanha@redhat.com>
In-Reply-To: <20180228181946.22958-1-stefanha@redhat.com>
References: <20180228181946.22958-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] virtio-scsi: fix race between
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
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

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
 hw/scsi/virtio-scsi-dataplane.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 1c33322ba6..912e5005d8 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -107,9 +107,10 @@ static int virtio_scsi_vring_init(VirtIOSCSI *s, VirtQueue *vq, int n,
     return 0;
 }
 
-/* assumes s->ctx held */
-static void virtio_scsi_clear_aio(VirtIOSCSI *s)
+/* Context: BH in IOThread */
+static void virtio_scsi_dataplane_stop_bh(void *opaque)
 {
+    VirtIOSCSI *s = opaque;
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
     int i;
 
@@ -171,7 +172,7 @@ int virtio_scsi_dataplane_start(VirtIODevice *vdev)
     return 0;
 
 fail_vrings:
-    virtio_scsi_clear_aio(s);
+    aio_wait_bh_oneshot(s->ctx, virtio_scsi_dataplane_stop_bh, s);
     aio_context_release(s->ctx);
     for (i = 0; i < vs->conf.num_queues + 2; i++) {
         virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
@@ -207,7 +208,7 @@ void virtio_scsi_dataplane_stop(VirtIODevice *vdev)
     s->dataplane_stopping = true;
 
     aio_context_acquire(s->ctx);
-    virtio_scsi_clear_aio(s);
+    aio_wait_bh_oneshot(s->ctx, virtio_scsi_dataplane_stop_bh, s);
     aio_context_release(s->ctx);
 
     blk_drain_all(); /* ensure there are no in-flight requests */
-- 
2.14.3
