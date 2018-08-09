Received: from eggs.gnu.org ([2001:4830:134:3::10]:33564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1fnoCH-0007aq-3t
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1fnoCE-000675-06
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:54:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1fnoCD-00063r-Gq
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:53:57 -0400
From: Ilya Maximets <i.maximets@samsung.com>
Date: Thu, 09 Aug 2018 19:54:37 +0300
Message-id: <1533833677-27512-1-git-send-email-i.maximets@samsung.com>
References: <CGME20180809165352eucas1p2359a46f1beb147fdcbd035c28bbd48d9@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH] virtio: add support for in-order feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Ilya Maximets <i.maximets@samsung.com>

New feature bit for in-order feature of the upcoming
virtio 1.1. It's already supported by DPDK vhost-user
and virtio implementations. These changes required to
allow feature negotiation.

Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
---

I just wanted to test this new feature in DPDK but failed
to found required patch for QEMU side. So, I implemented it.
At least it will be helpful for someone like me, who wants
to evaluate VIRTIO_F_IN_ORDER with DPDK.

 hw/net/vhost_net.c                             |  1 +
 include/hw/virtio/virtio.h                     | 12 +++++++-----
 include/standard-headers/linux/virtio_config.h |  7 +++++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e037db6..86879c5 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -78,6 +78,7 @@ static const int user_feature_bits[] = {
     VIRTIO_NET_F_MRG_RXBUF,
     VIRTIO_NET_F_MTU,
     VIRTIO_F_IOMMU_PLATFORM,
+    VIRTIO_F_IN_ORDER,
 
     /* This bit implies RARP isn't sent by QEMU out of band */
     VIRTIO_NET_F_GUEST_ANNOUNCE,
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 9c1fa07..a422025 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -254,16 +254,18 @@ typedef struct virtio_input_conf virtio_input_conf;
 typedef struct VirtIOSCSIConf VirtIOSCSIConf;
 typedef struct VirtIORNGConf VirtIORNGConf;
 
-#define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field) \
+#define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field)     \
     DEFINE_PROP_BIT64("indirect_desc", _state, _field,    \
                       VIRTIO_RING_F_INDIRECT_DESC, true), \
     DEFINE_PROP_BIT64("event_idx", _state, _field,        \
                       VIRTIO_RING_F_EVENT_IDX, true),     \
     DEFINE_PROP_BIT64("notify_on_empty", _state, _field,  \
-                      VIRTIO_F_NOTIFY_ON_EMPTY, true), \
-    DEFINE_PROP_BIT64("any_layout", _state, _field, \
-                      VIRTIO_F_ANY_LAYOUT, true), \
-    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
+                      VIRTIO_F_NOTIFY_ON_EMPTY, true),    \
+    DEFINE_PROP_BIT64("any_layout", _state, _field,       \
+                      VIRTIO_F_ANY_LAYOUT, true),         \
+    DEFINE_PROP_BIT64("in_order", _state, _field,         \
+                      VIRTIO_F_IN_ORDER, true),           \
+    DEFINE_PROP_BIT64("iommu_platform", _state, _field,   \
                       VIRTIO_F_IOMMU_PLATFORM, false)
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
index b777069..d20398c 100644
--- a/include/standard-headers/linux/virtio_config.h
+++ b/include/standard-headers/linux/virtio_config.h
@@ -71,4 +71,11 @@
  * this is for compatibility with legacy systems.
  */
 #define VIRTIO_F_IOMMU_PLATFORM		33
+
+/*
+ * Inorder feature indicates that all buffers are used by the device
+ * in the same order in which they have been made available.
+ */
+#define VIRTIO_F_IN_ORDER 35
+
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
2.7.4
