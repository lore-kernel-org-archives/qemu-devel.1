Received: from eggs.gnu.org ([2001:4830:134:3::10]:54759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKonw-0000mS-1O
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eKonv-00074T-4B
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eKonu-00074I-Tj
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:08:47 -0500
Date: Fri, 1 Dec 2017 19:08:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1512148088-28733-3-git-send-email-mst@redhat.com>
References: <1512148088-28733-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512148088-28733-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] virtio: Add queue interface to restore
 avail index from vring used index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Maxime Coquelin <maxime.coquelin@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

In case of backend crash, it is not possible to restore internal
avail index from the backend value as vhost_get_vring_base
callback fails.

This patch provides a new interface to restore internal avail index
from the vring used index, as done by some vhost-user backend on
reconnection.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h |  1 +
 hw/virtio/virtio.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 5abada6..098bdaa 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -272,6 +272,7 @@ hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n);
 uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n);
 void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx);
+void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n);
 void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n);
 void virtio_queue_update_used_idx(VirtIODevice *vdev, int n);
 VirtQueue *virtio_get_queue(VirtIODevice *vdev, int n);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index ea532dc..703e672 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2310,6 +2310,16 @@ void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx)
     vdev->vq[n].shadow_avail_idx = idx;
 }
 
+void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
+{
+    rcu_read_lock();
+    if (vdev->vq[n].vring.desc) {
+        vdev->vq[n].last_avail_idx = vring_used_idx(&vdev->vq[n]);
+        vdev->vq[n].shadow_avail_idx = vdev->vq[n].last_avail_idx;
+    }
+    rcu_read_unlock();
+}
+
 void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
 {
     rcu_read_lock();
-- 
MST
