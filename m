Received: from eggs.gnu.org ([2001:4830:134:3::10]:50909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1eqyA8-0001lP-CN
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:36:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1eqyA5-0000Zp-8O
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:36:36 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:38542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hejianet@gmail.com>) id 1eqyA5-0000ZO-2r
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:36:33 -0500
Received: by mail-pg0-x243.google.com with SMTP id l24so738669pgc.5
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 01:36:32 -0800 (PST)
From: Jia He <hejianet@gmail.com>
Date: Wed, 28 Feb 2018 01:35:28 -0800
Message-Id: <1519810529-4034-1-git-send-email-hejianet@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] vhost: avoid to start/stop virtqueue which
 is not ready
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jia He <hejianet@gmail.com>, Jia He <jia.he@hxt-semitech.com>

In our Armv8a server, we try to configure the vhost scsi but fail
to boot up the guest (-machine virt-2.10). The guest's boot failure
is very early, even earlier than grub.

There are 3 virtqueues (ctrl, event and cmd) for virtio scsi device,
but ovmf and seabios will only set the physical address for the 3rd
one (cmd). Then in vhost_virtqueue_start(), virtio_queue_get_desc_addr
will be 0 for ctrl and event vq when qemu negotiates with ovmf. So
vhost_memory_map fails with ENOMEM.

This patch just fixs it by early quitting the virtqueue start/stop
when virtio_queue_get_desc_addr is 0.

Btw, after guest kernel starts, all the 3 queues will be initialized
and set address correctly.

Already tested on Arm64 and X86_64 qemu.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 hw/virtio/vhost.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4a44e6e..00f2512 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -345,6 +345,10 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
     for (i = 0; i < dev->nvqs; ++i) {
         struct vhost_virtqueue *vq = dev->vqs + i;
 
+        if (vq->desc_phys == 0) {
+            continue;
+        }
+
         j = 0;
         r = vhost_verify_ring_part_mapping(
                 vq->desc, vq->desc_phys, vq->desc_size,
@@ -881,6 +885,11 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
     };
     struct VirtQueue *vvq = virtio_get_queue(vdev, idx);
 
+    a = virtio_queue_get_desc_addr(vdev, idx);
+    if (a == 0) {
+        /* Queue might not be ready for start */
+        return 0;
+    }
 
     vq->num = state.num = virtio_queue_get_num(vdev, idx);
     r = dev->vhost_ops->vhost_set_vring_num(dev, &state);
@@ -906,7 +915,7 @@ static int vhost_virtqueue_start(struct vhost_dev *dev,
     }
 
     vq->desc_size = s = l = virtio_queue_get_desc_size(vdev, idx);
-    vq->desc_phys = a = virtio_queue_get_desc_addr(vdev, idx);
+    vq->desc_phys = a;
     vq->desc = vhost_memory_map(dev, a, &l, 0);
     if (!vq->desc || l != s) {
         r = -ENOMEM;
@@ -989,6 +998,13 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
         .index = vhost_vq_index,
     };
     int r;
+    int a;
+
+    a = virtio_queue_get_desc_addr(vdev, idx);
+    if (a == 0) {
+        /* Don't stop the virtqueue which might have not been started */
+        return;
+    }
 
     r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
     if (r < 0) {
-- 
2.7.4
