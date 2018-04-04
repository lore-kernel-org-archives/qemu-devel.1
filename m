Received: from eggs.gnu.org ([2001:4830:134:3::10]:54226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1f3hx9-0001Dc-4k
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1f3hx6-0005ck-PN
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:55:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1f3hx6-0005c1-7O
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:55:48 -0400
From: wexu@redhat.com
Date: Wed,  4 Apr 2018 20:54:00 +0800
Message-Id: <1522846444-31725-5-git-send-email-wexu@redhat.com>
In-Reply-To: <1522846444-31725-1-git-send-email-wexu@redhat.com>
References: <1522846444-31725-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH 4/8] virtio: add detach element for packed
 ring(1.1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, jasowang@redhat.com, mst@redhat.com, tiwei.bie@intel.com, jfreimann@redhat.com, qemu-devel@nongnu.org

From: Wei Xu <wexu@redhat.com>

helper for packed ring

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 478df3d..fdee40f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -561,6 +561,20 @@ static void virtqueue_unmap_sg(VirtQueue *vq, const VirtQueueElement *elem,
                          elem->out_sg[i].iov_len);
 }
 
+static void virtqueue_detach_element_split(VirtQueue *vq,
+                            const VirtQueueElement *elem, unsigned int len)
+{
+    vq->inuse--;
+    virtqueue_unmap_sg(vq, elem, len);
+}
+
+static void virtqueue_detach_element_packed(VirtQueue *vq,
+                            const VirtQueueElement *elem, unsigned int len)
+{
+    vq->inuse -= elem->count;
+    virtqueue_unmap_sg(vq, elem, len);
+}
+
 /* virtqueue_detach_element:
  * @vq: The #VirtQueue
  * @elem: The #VirtQueueElement
@@ -573,8 +587,11 @@ static void virtqueue_unmap_sg(VirtQueue *vq, const VirtQueueElement *elem,
 void virtqueue_detach_element(VirtQueue *vq, const VirtQueueElement *elem,
                               unsigned int len)
 {
-    vq->inuse--;
-    virtqueue_unmap_sg(vq, elem, len);
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        virtqueue_detach_element_packed(vq, elem, len);
+    } else {
+        virtqueue_detach_element_split(vq, elem, len);
+    }
 }
 
 /* virtqueue_unpop:
-- 
2.7.4
