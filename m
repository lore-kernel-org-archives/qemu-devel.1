Received: from eggs.gnu.org ([2001:4830:134:3::10]:57272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRfLE-0002T0-Gc
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRfL9-00064y-Ey
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:22:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRfL9-00064h-6U
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:22:51 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 12 Jan 2017 11:46:10 +0000
Message-Id: <20170112114612.14520-2-stefanha@redhat.com>
In-Reply-To: <20170112114612.14520-1-stefanha@redhat.com>
References: <20170112114612.14520-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] Revert "virtio: turn vq->notification into
 a nested counter"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Doug Goldstein <cardoe@cardoe.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This reverts commit aff8fd18f1786fc5af259a9bc0077727222f51ca.

Both virtio-net and virtio-crypto do not balance
virtio_queue_set_notification() enable and disable calls.  This makes
the notifications_disabled counter unreliable and Doug Goldstein
reported the following assertion failure:

  #3  0x00007ffff44d1c62 in __GI___assert_fail (
      assertion=assertion@entry=0x555555ae8e8a "vq->notification_disabled > 0",
      file=file@entry=0x555555ae89c0 "/home/doug/work/qemu/hw/virtio/virtio.c",
      line=line@entry=215,
      function=function@entry=0x555555ae9630 <__PRETTY_FUNCTION__.43707>
      "virtio_queue_set_notification") at assert.c:101
  #4  0x00005555557f25d6 in virtio_queue_set_notification (vq=0x55555666aa90,
      enable=enable@entry=1) at /home/doug/work/qemu/hw/virtio/virtio.c:215
  #5  0x00005555557dc311 in virtio_net_has_buffers (q=<optimized out>,
      q=<optimized out>, bufsize=102)
      at /home/doug/work/qemu/hw/net/virtio-net.c:1008
  #6  virtio_net_receive (nc=<optimized out>, buf=0x555557386b88 "", size=102)
      at /home/doug/work/qemu/hw/net/virtio-net.c:1148
  #7  0x00005555559cad33 in nc_sendv_compat (flags=<optimized out>, iovcnt=1,
      iov=0x7fffead746d0, nc=0x55555788b340) at net/net.c:705
  #8  qemu_deliver_packet_iov (sender=<optimized out>, flags=<optimized out>,
      iov=0x7fffead746d0, iovcnt=1, opaque=0x55555788b340) at net/net.c:732
  #9  0x00005555559cd929 in qemu_net_queue_deliver (size=<optimized out>,
      data=<optimized out>, flags=<optimized out>, sender=<optimized out>,
      queue=0x55555788b550) at net/queue.c:164
  #10 qemu_net_queue_flush (queue=0x55555788b550) at net/queue.c:261

This patch is safe to revert since it's just an optimization for
virtqueue polling.  The next patch will improve the situation again
without resorting to nesting.

Reported-by: Doug Goldstein <cardoe@cardoe.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index aa4f38f..f04ab7a 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -88,8 +88,8 @@ struct VirtQueue
     /* Last used index value we have signalled on */
     bool signalled_used_valid;
 
-    /* Nested host->guest notification disabled counter */
-    unsigned int notification_disabled;
+    /* Notification enabled? */
+    bool notification;
 
     uint16_t queue_index;
 
@@ -202,7 +202,7 @@ static inline void vring_used_flags_unset_bit(VirtQueue *vq, int mask)
 static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
 {
     hwaddr pa;
-    if (vq->notification_disabled) {
+    if (!vq->notification) {
         return;
     }
     pa = vq->vring.used + offsetof(VRingUsed, ring[vq->vring.num]);
@@ -211,13 +211,7 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
 
 void virtio_queue_set_notification(VirtQueue *vq, int enable)
 {
-    if (enable) {
-        assert(vq->notification_disabled > 0);
-        vq->notification_disabled--;
-    } else {
-        vq->notification_disabled++;
-    }
-
+    vq->notification = enable;
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         vring_set_avail_event(vq, vring_avail_idx(vq));
     } else if (enable) {
@@ -1020,7 +1014,7 @@ void virtio_reset(void *opaque)
         virtio_queue_set_vector(vdev, i, VIRTIO_NO_VECTOR);
         vdev->vq[i].signalled_used = 0;
         vdev->vq[i].signalled_used_valid = false;
-        vdev->vq[i].notification_disabled = 0;
+        vdev->vq[i].notification = true;
         vdev->vq[i].vring.num = vdev->vq[i].vring.num_default;
         vdev->vq[i].inuse = 0;
     }
@@ -1831,7 +1825,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
         vdev->vq[i].vring.desc = qemu_get_be64(f);
         qemu_get_be16s(f, &vdev->vq[i].last_avail_idx);
         vdev->vq[i].signalled_used_valid = false;
-        vdev->vq[i].notification_disabled = 0;
+        vdev->vq[i].notification = true;
 
         if (vdev->vq[i].vring.desc) {
             /* XXX virtio-1 devices */
-- 
2.9.3
