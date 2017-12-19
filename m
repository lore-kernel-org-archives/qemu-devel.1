Received: from eggs.gnu.org ([2001:4830:134:3::10]:49094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1eRI1l-0005gs-Fj
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 08:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1eRI1k-0003EK-HV
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 08:33:49 -0500
From: sochin.jiang <sochin.jiang@huawei.com>
Date: Tue, 19 Dec 2017 21:33:03 +0800
Message-ID: <1513690383-27269-1-git-send-email-sochin.jiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH]  virtio-blk: notify guest directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, sochin.jiang@huawei.com, eric.fangyi@huawei.com

From: "sochin.jiang" <sochin.jiang@huawei.com>

 Till now, we've already notify guest as a batch mostly, an
 extra BH won't decrease guest interrupts much, but cause a
 significant notification loss. Generally, we could have 15%
 or so performance lost in single queue IO models, as I tested.

Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
---
 hw/block/dataplane/virtio-blk.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 5556f0e..a261a1d 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -32,7 +32,6 @@ struct VirtIOBlockDataPlane {
 
     VirtIOBlkConf *conf;
     VirtIODevice *vdev;
-    QEMUBH *bh;                     /* bh for guest notification */
     unsigned long *batch_notify_vqs;
 
     /* Note that these EventNotifiers are assigned by value.  This is
@@ -44,14 +43,7 @@ struct VirtIOBlockDataPlane {
     AioContext *ctx;
 };
 
-/* Raise an interrupt to signal guest, if necessary */
-void virtio_blk_data_plane_notify(VirtIOBlockDataPlane *s, VirtQueue *vq)
-{
-    set_bit(virtio_get_queue_index(vq), s->batch_notify_vqs);
-    qemu_bh_schedule(s->bh);
-}
-
-static void notify_guest_bh(void *opaque)
+static void notify_guest(void *opaque)
 {
     VirtIOBlockDataPlane *s = opaque;
     unsigned nvqs = s->conf->num_queues;
@@ -75,7 +67,12 @@ static void notify_guest_bh(void *opaque)
     }
 }
 
-/* Context: QEMU global mutex held */
+/* Raise an interrupt to signal guest, if necessary */
+void virtio_blk_data_plane_notify(VirtIOBlockDataPlane *s, VirtQueue *vq)
+{
+    set_bit(virtio_get_queue_index(vq), s->batch_notify_vqs);
+    notify_guest(s);
+}
 void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
                                   VirtIOBlockDataPlane **dataplane,
                                   Error **errp)
@@ -122,7 +119,6 @@ void virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
     } else {
         s->ctx = qemu_get_aio_context();
     }
-    s->bh = aio_bh_new(s->ctx, notify_guest_bh, s);
     s->batch_notify_vqs = bitmap_new(conf->num_queues);
 
     *dataplane = s;
@@ -140,7 +136,6 @@ void virtio_blk_data_plane_destroy(VirtIOBlockDataPlane *s)
     vblk = VIRTIO_BLK(s->vdev);
     assert(!vblk->dataplane_started);
     g_free(s->batch_notify_vqs);
-    qemu_bh_delete(s->bh);
     if (s->iothread) {
         object_unref(OBJECT(s->iothread));
     }
-- 
1.8.3.1
