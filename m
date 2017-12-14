Received: from eggs.gnu.org ([2001:4830:134:3::10]:56158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1ePZHZ-0005O6-Hn
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1ePZHV-00066u-85
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:35:01 -0500
Received: from mx0b-00190b01.pphosted.com ([2620:100:9005:57f::1]:51080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1ePZHV-000668-1q
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:34:57 -0500
From: Jason Baron <jbaron@akamai.com>
Date: Thu, 14 Dec 2017 14:33:53 -0500
Message-Id: <12f0830fe220dc43671f6dbc1a5d81e0276c3a9e.1513278334.git.jbaron@akamai.com>
In-Reply-To: <cover.1513278334.git.jbaron@akamai.com>
References: <cover.1513278334.git.jbaron@akamai.com>
In-Reply-To: <cover.1513278334.git.jbaron@akamai.com>
References: <cover.1513278334.git.jbaron@akamai.com>
Subject: [Qemu-devel] [PATCH net-next 1/2] virtio_net: allow hypervisor to
 indicate linkspeed and duplex setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com

If the hypervisor exports the link and duplex speed, let's use that instead
of the default unknown speed. The user can still overwrite it later if
desired via: 'ethtool -s'. This allows the hypervisor to set the default
link speed and duplex setting without requiring guest changes and is
consistent with how other network drivers operate. We ran into some cases
where the guest software was failing due to a lack of linkspeed and had to
fall back to a fully emulated network device that does export a linkspeed
and duplex setting.

Implement by adding a new VIRTIO_NET_F_SPEED_DUPLEX feature flag, to
indicate that a linkspeed and duplex setting are present.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c        | 11 ++++++++++-
 include/uapi/linux/virtio_net.h |  4 ++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6fb7b65..e7a2ad6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2671,6 +2671,14 @@ static int virtnet_probe(struct virtio_device *vdev)
 	netif_set_real_num_rx_queues(dev, vi->curr_queue_pairs);
 
 	virtnet_init_settings(dev);
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_SPEED_DUPLEX)) {
+		vi->speed = virtio_cread32(vdev,
+					offsetof(struct virtio_net_config,
+					speed));
+		vi->duplex = virtio_cread8(vdev,
+					offsetof(struct virtio_net_config,
+					duplex));
+	}
 
 	err = register_netdev(dev);
 	if (err) {
@@ -2796,7 +2804,8 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
-	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
+	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
+	VIRTIO_NET_F_SPEED_DUPLEX
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index fc353b5..acfcf68 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -36,6 +36,7 @@
 #define VIRTIO_NET_F_GUEST_CSUM	1	/* Guest handles pkts w/ partial csum */
 #define VIRTIO_NET_F_CTRL_GUEST_OFFLOADS 2 /* Dynamic offload configuration. */
 #define VIRTIO_NET_F_MTU	3	/* Initial MTU advice */
+#define VIRTIO_NET_F_SPEED_DUPLEX 4	/* Host set linkspeed and duplex */
 #define VIRTIO_NET_F_MAC	5	/* Host has given MAC address. */
 #define VIRTIO_NET_F_GUEST_TSO4	7	/* Guest can handle TSOv4 in. */
 #define VIRTIO_NET_F_GUEST_TSO6	8	/* Guest can handle TSOv6 in. */
@@ -76,6 +77,9 @@ struct virtio_net_config {
 	__u16 max_virtqueue_pairs;
 	/* Default maximum transmit unit advice */
 	__u16 mtu;
+	/* Host exported linkspeed and duplex */
+	__u32 speed;
+	__u8 duplex;
 } __attribute__((packed));
 
 /*
-- 
2.6.1
