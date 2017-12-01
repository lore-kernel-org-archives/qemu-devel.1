Received: from eggs.gnu.org ([2001:4830:134:3::10]:54941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKooA-0000xN-Aq
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKoo9-0007AF-Bd
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:09:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eKoo9-00079c-4v
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:09:01 -0500
Date: Fri, 1 Dec 2017 19:08:53 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1512148088-28733-7-git-send-email-mst@redhat.com>
References: <1512148088-28733-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512148088-28733-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] virtio: check VirtQueue Vring object is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Prasad J Pandit <pjp@fedoraproject.org>, Zhangboxian <zhangboxian@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: Prasad J Pandit <pjp@fedoraproject.org>

A guest could attempt to use an uninitialised VirtQueue object
or unset Vring.align leading to a arithmetic exception. Add check
to avoid it.

Reported-by: Zhangboxian <zhangboxian@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/virtio/virtio.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 703e672..ad564b0 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -182,7 +182,7 @@ void virtio_queue_update_rings(VirtIODevice *vdev, int n)
 {
     VRing *vring = &vdev->vq[n].vring;
 
-    if (!vring->desc) {
+    if (!vring->num || !vring->desc || !vring->align) {
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
+    if (!vdev->vq[n].vring.num) {
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
MST
