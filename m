Received: from eggs.gnu.org ([2001:4830:134:3::10]:54263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1f3hxC-0001GU-El
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1f3hx9-0005eG-1W
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:55:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50834 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1f3hx8-0005dZ-Mr
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:55:50 -0400
From: wexu@redhat.com
Date: Wed,  4 Apr 2018 20:54:01 +0800
Message-Id: <1522846444-31725-6-git-send-email-wexu@redhat.com>
In-Reply-To: <1522846444-31725-1-git-send-email-wexu@redhat.com>
References: <1522846444-31725-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH 5/8] virtio: notification tweak for packed ring
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

Always enable notify and bypass set notification
before supporting driver and device area.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index fdee40f..95a4681 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -425,6 +425,10 @@ void virtio_queue_set_notification(VirtQueue *vq, int enable)
 {
     vq->notification = enable;
 
+    if (virtio_vdev_has_feature(vq->vdev, VIRTIO_F_RING_PACKED)) {
+        return;
+    }
+
     if (!vq->vring.desc) {
         return;
     }
@@ -1801,6 +1805,11 @@ static bool virtio_should_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
     uint16_t old, new;
     bool v;
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return true;
+    }
+
     /* We need to expose used array entries before checking used event. */
     smp_mb();
     /* Always notify when queue is empty (when feature acknowledge) */
-- 
2.7.4
