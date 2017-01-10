Received: from eggs.gnu.org ([2001:4830:134:3::10]:33901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAp-0008Dl-DJ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAm-0005w5-6Q
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:43 -0500
Received: from mail.kernel.org ([198.145.29.136]:48422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQpAl-0005vU-VR
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:40:40 -0500
Date: Tue, 10 Jan 2017 07:40:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-31-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 30/41] vhost-net: Notify the backend about the
 host MTU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Aaron Conole <aconole@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

This patch provides a way for virtio-net to notify the
backend about the host MTU set by the user.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Aaron Conole <aconole@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/net/vhost_net.h |  2 ++
 hw/net/vhost_net.c      | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index 5a08eff..afc1499 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -35,4 +35,6 @@ int vhost_set_vring_enable(NetClientState * nc, int enable);
 
 uint64_t vhost_net_get_acked_features(VHostNetState *net);
 
+int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
+
 #endif
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
-- 
MST
