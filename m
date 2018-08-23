Received: from eggs.gnu.org ([2001:4830:134:3::10]:51072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fsocH-0004cr-Lx
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 08:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fsocE-0008Bq-GD
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 08:21:33 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Aug 2018 14:21:23 +0200
Message-Id: <20180823122123.18278-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio: update MemoryRegionCaches when guest
 negotiates features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-stable@nongnu.org

Because the cache is sized to include the rings and the event indices,
negotiating the VIRTIO_RING_F_EVENT_IDX feature will result in the size
of the cache changing.  And because MemoryRegionCache accesses are
range-checked, if we skip this we end up with an assertion failure.
This happens with OpenBSD 6.3.

Reported-by: Fam Zheng <famz@redhat.com>
Fixes: 97cd965c070152bc626c7507df9fb356bbe1cd81
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/virtio.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d4e4d98b59..f6a588ab57 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2006,14 +2006,25 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
 
 int virtio_set_features(VirtIODevice *vdev, uint64_t val)
 {
-   /*
+    int ret;
+    /*
      * The driver must not attempt to set features after feature negotiation
      * has finished.
      */
     if (vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) {
         return -EINVAL;
     }
-    return virtio_set_features_nocheck(vdev, val);
+    ret = virtio_set_features_nocheck(vdev, val);
+    if (!ret && virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
+        /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
+        int i;
+        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+            if (vdev->vq[i].vring.num != 0) {
+                virtio_init_region_cache(vdev, i);
+            }
+        }
+    }
+    return ret;
 }
 
 int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
-- 
2.17.1
