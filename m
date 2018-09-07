Received: from eggs.gnu.org ([2001:4830:134:3::10]:60775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fyOey-000054-VF
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fyOex-0005pZ-VK
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:51:24 -0400
Date: Fri, 7 Sep 2018 17:51:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180907215109.146867-3-mst@redhat.com>
References: <20180907215109.146867-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907215109.146867-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] virtio: update MemoryRegionCaches when
 guest negotiates features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-stable@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

Because the cache is sized to include the rings and the event indices,
negotiating the VIRTIO_RING_F_EVENT_IDX feature will result in the size
of the cache changing.  And because MemoryRegionCache accesses are
range-checked, if we skip this we end up with an assertion failure.
This happens with OpenBSD 6.3.

Reported-by: Fam Zheng <famz@redhat.com>
Fixes: 97cd965c070152bc626c7507df9fb356bbe1cd81
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
