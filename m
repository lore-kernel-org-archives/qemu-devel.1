Received: from eggs.gnu.org ([2001:4830:134:3::10]:42495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJX-0001xa-No
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fQHJW-0002yc-An
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46848 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1fQHJW-0002yA-3f
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 15:08:14 -0400
From: wexu@redhat.com
Date: Tue,  5 Jun 2018 15:07:56 -0400
Message-Id: <1528225683-11413-2-git-send-email-wexu@redhat.com>
In-Reply-To: <1528225683-11413-1-git-send-email-wexu@redhat.com>
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [RFC v2 1/8] virtio: feature bit, data structure,
 init for 1.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, tiwei.bie@intel.com, mst@redhat.com, wexu@redhat.com, jfreimann@redhat.com

From: Wei Xu <wexu@redhat.com>

New feature bit and members for packed ring.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/net/vhost_net.c                             |  2 ++
 hw/virtio/virtio.c                             | 27 ++++++++++++++++++++++++--
 include/hw/virtio/virtio.h                     |  4 +++-
 include/standard-headers/linux/virtio_config.h |  2 ++
 4 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e037db6..f593086 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -53,6 +53,7 @@ static const int kernel_feature_bits[] = {
     VIRTIO_F_VERSION_1,
     VIRTIO_NET_F_MTU,
     VIRTIO_F_IOMMU_PLATFORM,
+    VIRTIO_F_RING_PACKED,
     VHOST_INVALID_FEATURE_BIT
 };
 
@@ -78,6 +79,7 @@ static const int user_feature_bits[] = {
     VIRTIO_NET_F_MRG_RXBUF,
     VIRTIO_NET_F_MTU,
     VIRTIO_F_IOMMU_PLATFORM,
+    VIRTIO_F_RING_PACKED,
 
     /* This bit implies RARP isn't sent by QEMU out of band */
     VIRTIO_NET_F_GUEST_ANNOUNCE,
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 006d3d1..e192a9a 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -39,6 +39,13 @@ typedef struct VRingDesc
     uint16_t next;
 } VRingDesc;
 
+typedef struct VRingDescPacked {
+    uint64_t addr;
+    uint32_t len;
+    uint16_t id;
+    uint16_t flags;
+} VRingDescPacked;
+
 typedef struct VRingAvail
 {
     uint16_t flags;
@@ -62,8 +69,14 @@ typedef struct VRingUsed
 typedef struct VRingMemoryRegionCaches {
     struct rcu_head rcu;
     MemoryRegionCache desc;
-    MemoryRegionCache avail;
-    MemoryRegionCache used;
+    union {
+        MemoryRegionCache avail;
+        MemoryRegionCache driver;
+    };
+    union {
+        MemoryRegionCache used;
+        MemoryRegionCache device;
+    };
 } VRingMemoryRegionCaches;
 
 typedef struct VRing
@@ -77,6 +90,11 @@ typedef struct VRing
     VRingMemoryRegionCaches *caches;
 } VRing;
 
+typedef struct VRingPackedDescEvent {
+    uint16_t off_wrap;
+    uint16_t flags;
+} VRingPackedDescEvent ;
+
 struct VirtQueue
 {
     VRing vring;
@@ -89,6 +107,9 @@ struct VirtQueue
 
     uint16_t used_idx;
 
+    bool avail_wrap_counter;
+    bool used_wrap_counter;
+
     /* Last used index value we have signalled on */
     uint16_t signalled_used;
 
@@ -1213,6 +1234,8 @@ void virtio_reset(void *opaque)
         vdev->vq[i].last_avail_idx = 0;
         vdev->vq[i].shadow_avail_idx = 0;
         vdev->vq[i].used_idx = 0;
+        vdev->vq[i].avail_wrap_counter = true;
+        vdev->vq[i].used_wrap_counter = true;
         virtio_queue_set_vector(vdev, i, VIRTIO_NO_VECTOR);
         vdev->vq[i].signalled_used = 0;
         vdev->vq[i].signalled_used_valid = false;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 098bdaa..4a7fb21 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -262,7 +262,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
     DEFINE_PROP_BIT64("any_layout", _state, _field, \
                       VIRTIO_F_ANY_LAYOUT, true), \
     DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
-                      VIRTIO_F_IOMMU_PLATFORM, false)
+                      VIRTIO_F_IOMMU_PLATFORM, false), \
+    DEFINE_PROP_BIT64("ring_packed", _state, _field, \
+                      VIRTIO_F_RING_PACKED, false)
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
index b777069..6ee5529 100644
--- a/include/standard-headers/linux/virtio_config.h
+++ b/include/standard-headers/linux/virtio_config.h
@@ -71,4 +71,6 @@
  * this is for compatibility with legacy systems.
  */
 #define VIRTIO_F_IOMMU_PLATFORM		33
+
+#define VIRTIO_F_RING_PACKED		34
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
1.8.3.1
