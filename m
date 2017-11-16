Received: from eggs.gnu.org ([2001:4830:134:3::10]:39173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eFPE4-00084B-9n
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:49:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eFPE1-0000ig-7k
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:49:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eFPE1-0000hR-1e
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:49:21 -0500
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 16 Nov 2017 19:48:34 +0100
Message-Id: <20171116184835.28556-2-maxime.coquelin@redhat.com>
In-Reply-To: <20171116184835.28556-1-maxime.coquelin@redhat.com>
References: <20171116184835.28556-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] virtio: Add queue interface to restore
 avail index from vring used index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, yuri.benditovich@daynix.com, yvugenfi@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

In case of backend crash, it is not possible to restore internal
avail index from the backend value as vhost_get_vring_base
callback fails.

This patch provides a new interface to restore internal avail index
from the vring used index, as done by some vhost-user backend on
reconnection.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/virtio/virtio.c         | 10 ++++++++++
 include/hw/virtio/virtio.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 5884ce3480..583516c428 100644
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
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 5abada6966..098bdaaea3 100644
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
-- 
2.14.3
