Received: from eggs.gnu.org ([2001:4830:134:3::10]:52443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eIIoW-0004Xe-7C
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 13:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eIIoU-0005uN-W2
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 13:35:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eIIoU-0005tE-Pc
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 13:34:58 -0500
From: P J P <ppandit@redhat.com>
Date: Sat, 25 Nov 2017 00:04:45 +0530
Message-Id: <20171124183446.7308-2-ppandit@redhat.com>
In-Reply-To: <20171124183446.7308-1-ppandit@redhat.com>
References: <20171124183446.7308-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] virtio: check VirtQueue Vring object is
 set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

An user could attempt to use an uninitialised VirtQueue object
or unset Vring.align leading to a arithmetic exception. Add check
to avoid it.

Reported-by: Zhangboxian <zhangboxian@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/virtio/virtio.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 5884ce3480..c01eac87a5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -182,7 +182,7 @@ void virtio_queue_update_rings(VirtIODevice *vdev, int n)
 {
     VRing *vring = &vdev->vq[n].vring;
 
-    if (!vring->desc) {
+    if (!vdev->vq[n].vring.num || !vring->desc || !vring->align) {
         /* not yet setup -> nothing to do */
         return;
     }
@@ -1414,6 +1414,9 @@ void virtio_config_modern_writel(VirtIODevice *vdev,
 
 void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
 {
+    if (!vdev->vq[n].vring.num) {
+        return;
+    }
     vdev->vq[n].vring.desc = addr;
     virtio_queue_update_rings(vdev, n);
 }
@@ -1426,6 +1429,9 @@ hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n)
 void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
                             hwaddr avail, hwaddr used)
 {
+    if (!vdev->vq[n].vring.num || !desc || !vdev->vq[n].vring.align) {
+        return;
+    }
     vdev->vq[n].vring.desc = desc;
     vdev->vq[n].vring.avail = avail;
     vdev->vq[n].vring.used = used;
@@ -1494,8 +1500,10 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
      */
     assert(k->has_variable_vring_alignment);
 
-    vdev->vq[n].vring.align = align;
-    virtio_queue_update_rings(vdev, n);
+    if (align) {
+        vdev->vq[n].vring.align = align;
+        virtio_queue_update_rings(vdev, n);
+    }
 }
 
 static bool virtio_queue_notify_aio_vq(VirtQueue *vq)
-- 
2.13.6
