Received: from eggs.gnu.org ([209.51.188.92]:52845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gtujg-0004Ad-1N
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:38:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gtuje-0006Z5-2k
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:37:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gtujc-0006Gl-1O
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:37:57 -0500
From: wexu@redhat.com
Date: Wed, 13 Feb 2019 08:25:46 -0500
Message-Id: <1550064346-17012-12-git-send-email-wexu@redhat.com>
In-Reply-To: <1550064346-17012-1-git-send-email-wexu@redhat.com>
References: <1550064346-17012-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [PATCH 11/11] virtio: CLI and provide packed ring
 feature bit by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wexu@redhat.com, jasowang@redhat.com, mst@redhat.com, jfreiman@redhat.com, maxime.coquelin@redhat.com, tiwei.bie@intel.com

From: Wei Xu <wexu@redhat.com>

Add userspace and vhost kernel/user support.

Add CLI "ring_packed=true/false" to enable/disable packed ring provision.
Usage:
    -device virtio-net-pci,netdev=xx,mac=xx:xx:xx:xx:xx:xx,ring_packed=false

By default it is provided.

Signed-off-by: Wei Xu <wexu@redhat.com>
---
 hw/net/vhost_net.c         | 2 ++
 include/hw/virtio/virtio.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

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
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 9c1fa07..2eb27d2 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -264,7 +264,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
     DEFINE_PROP_BIT64("any_layout", _state, _field, \
                       VIRTIO_F_ANY_LAYOUT, true), \
     DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
-                      VIRTIO_F_IOMMU_PLATFORM, false)
+                      VIRTIO_F_IOMMU_PLATFORM, false), \
+    DEFINE_PROP_BIT64("ring_packed", _state, _field, \
+                      VIRTIO_F_RING_PACKED, true)
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
-- 
1.8.3.1
