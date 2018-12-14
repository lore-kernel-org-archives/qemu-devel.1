Received: from eggs.gnu.org ([2001:4830:134:3::10]:40762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gXrJR-0000p7-A3
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1gXrJN-0003SA-8M
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:31:45 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1gXrJM-0003P8-O0
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:31:41 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
	20181214173130euoutp01142082c16c53d9c40562c44332466415~wQ1HAEyOh2686126861euoutp01g
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 17:31:30 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Fri, 14 Dec 2018 20:31:23 +0300
Message-Id: <20181214173123.31223-1-i.maximets@samsung.com>
Content-Type: text/plain; charset="utf-8"
References: <CGME20181214173128eucas1p25789b473622f9506c239c6a02d95e8b6@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH] virtio: add ORDER_PLATFORM feature support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Xiao Wang <xiao.w.wang@intel.com>, Ilya Maximets <i.maximets@samsung.com>

This patch adds new property "order_platform" which is required to
allow VIRTIO_F_ORDER_PLATFORM feature negotiation. Disabled by
default because needed only for HW assited vhost backends.

Enabling of this feature will request guest drivers to use heavier
(platform dependent) techniques for memory ordering if negotiated.

Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
---

Note: Patch to change the name of the feature from VIRTIO_F_IO_BARRIER
      to VIRTIO_F_ORDER_PLATFORM is not merged yet:
      https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg04114.html

Patch for DPDK virtio driver available here:
      http://patches.dpdk.org/patch/48886/

 hw/net/vhost_net.c         |  1 +
 include/hw/virtio/virtio.h | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e037db63a3..71877e46a5 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -78,6 +78,7 @@ static const int user_feature_bits[] = {
     VIRTIO_NET_F_MRG_RXBUF,
     VIRTIO_NET_F_MTU,
     VIRTIO_F_IOMMU_PLATFORM,
+    VIRTIO_F_ORDER_PLATFORM,
 
     /* This bit implies RARP isn't sent by QEMU out of band */
     VIRTIO_NET_F_GUEST_ANNOUNCE,
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 9c1fa07d6d..7e206dadbc 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -29,6 +29,15 @@
                                 (0x1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) | \
                                 (0x1ULL << VIRTIO_F_ANY_LAYOUT))
 
+#ifndef VIRTIO_F_ORDER_PLATFORM
+/*
+ * This feature indicates that memory accesses by the driver and the device
+ * are ordered in a way described by the platform.
+ * Not yet defined in Linux, i.e. not in standard-headers.
+ */
+#define VIRTIO_F_ORDER_PLATFORM 36
+#endif
+
 struct VirtQueue;
 
 static inline hwaddr vring_align(hwaddr addr,
@@ -264,7 +273,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
     DEFINE_PROP_BIT64("any_layout", _state, _field, \
                       VIRTIO_F_ANY_LAYOUT, true), \
     DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
-                      VIRTIO_F_IOMMU_PLATFORM, false)
+                      VIRTIO_F_IOMMU_PLATFORM, false),  \
+    DEFINE_PROP_BIT64("order_platform", _state, _field, \
+                      VIRTIO_F_ORDER_PLATFORM, false)
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
-- 
2.17.1
