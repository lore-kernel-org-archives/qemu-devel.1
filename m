Received: from eggs.gnu.org ([2001:4830:134:3::10]:35033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cFjc7-0000VJ-Qn
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 10:31:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cFjc7-0007Pa-1c
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 10:31:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1cFjc6-0007PT-SX
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 10:31:02 -0500
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Sat, 10 Dec 2016 16:30:37 +0100
Message-Id: <20161210153038.9184-3-maxime.coquelin@redhat.com>
In-Reply-To: <20161210153038.9184-1-maxime.coquelin@redhat.com>
References: <20161210153038.9184-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/3] vhost-net: Notify the backend about the
 host MTU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, aconole@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, jasowang@redhat.com, yuanhan.liu@linux.intel.com
Cc: fbl@redhat.com, berrange@redhat.com, mlureau@redhat.com, ktraynor@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>

This patch provides a way for virtio-net to notify the
backend about the host MTU set by the user.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Aaron Conole <aconole@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/net/vhost_net.c      | 18 ++++++++++++++++++
 include/net/vhost_net.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index f2d49ad..6280422 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -51,6 +51,7 @@ static const int kernel_feature_bits[] = {
     VIRTIO_RING_F_EVENT_IDX,
     VIRTIO_NET_F_MRG_RXBUF,
     VIRTIO_F_VERSION_1,
+    VIRTIO_NET_F_MTU,
     VHOST_INVALID_FEATURE_BIT
 };
 
@@ -74,6 +75,7 @@ static const int user_feature_bits[] = {
     VIRTIO_NET_F_HOST_ECN,
     VIRTIO_NET_F_HOST_UFO,
     VIRTIO_NET_F_MRG_RXBUF,
+    VIRTIO_NET_F_MTU,
 
     /* This bit implies RARP isn't sent by QEMU out of band */
     VIRTIO_NET_F_GUEST_ANNOUNCE,
@@ -435,6 +437,17 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
     return 0;
 }
 
+int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
+{
+    const VhostOps *vhost_ops = net->dev.vhost_ops;
+
+    if (!vhost_ops->vhost_net_set_mtu) {
+        return 0;
+    }
+
+    return vhost_ops->vhost_net_set_mtu(&net->dev, mtu);
+}
+
 #else
 uint64_t vhost_net_get_max_queues(VHostNetState *net)
 {
@@ -501,4 +514,9 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
 {
     return 0;
 }
+
+int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
+{
+    return 0;
+}
 #endif
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index 5a08eff..afc1499 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -35,4 +35,6 @@ int vhost_set_vring_enable(NetClientState * nc, int enable);
 
 uint64_t vhost_net_get_acked_features(VHostNetState *net);
 
+int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
+
 #endif
-- 
2.9.3
