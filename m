Received: from eggs.gnu.org ([2001:4830:134:3::10]:35728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPpeJ-0004E3-8T
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gPpeH-0007uC-1u
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:08:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gPpeG-0007oa-RT
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:08:04 -0500
From: wexu@redhat.com
Date: Thu, 22 Nov 2018 09:06:09 -0500
Message-Id: <1542895581-10721-5-git-send-email-wexu@redhat.com>
In-Reply-To: <1542895581-10721-1-git-send-email-wexu@redhat.com>
References: <1542895581-10721-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH v1 04/16] virtio: expand offset calculation for
 packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com

From: Wei Xu <wexu@redhat.com>

Expand 1.0 to 1.1 by adding offset calculation accordingly.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/virtio/virtio.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a8e737c..a41c2d3 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2336,14 +2336,28 @@ hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n)
 
 hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n)
 {
-    return offsetof(VRingAvail, ring) +
-        sizeof(uint16_t) * vdev->vq[n].vring.num;
+    int s;
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return sizeof(struct VRingPackedDescEvent);
+    } else {
+        s = virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
+        return offsetof(VRingAvail, ring) +
+            sizeof(uint16_t) * vdev->vq[n].vring.num + s;
+    }
 }
 
 hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n)
 {
-    return offsetof(VRingUsed, ring) +
-        sizeof(VRingUsedElem) * vdev->vq[n].vring.num;
+    int s;
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+        return sizeof(struct VRingPackedDescEvent);
+    } else {
+        s = virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
+        return offsetof(VRingUsed, ring) +
+            sizeof(VRingUsedElem) * vdev->vq[n].vring.num + s;
+    }
 }
 
 uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
-- 
1.8.3.1
