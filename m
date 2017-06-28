Received: from eggs.gnu.org ([2001:4830:134:3::10]:36960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dQ61l-0006D1-AW
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 02:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dQ61i-0004Kp-6O
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 02:00:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:7241)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dQ61h-0004KP-Ug
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 02:00:34 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Wed, 28 Jun 2017 13:53:20 +0800
Message-Id: <1498629200-35463-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1] virtio-net: code cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, eblake@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>

Use is_power_of_2(), and remove trailing "." from error_setg().

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/virtio-net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 91eddaf..144169c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1918,9 +1918,9 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
      */
     if (n->net_conf.rx_queue_size < VIRTIO_NET_RX_QUEUE_MIN_SIZE ||
         n->net_conf.rx_queue_size > VIRTQUEUE_MAX_SIZE ||
-        (n->net_conf.rx_queue_size & (n->net_conf.rx_queue_size - 1))) {
+        !is_power_of_2(n->net_conf.rx_queue_size)) {
         error_setg(errp, "Invalid rx_queue_size (= %" PRIu16 "), "
-                   "must be a power of 2 between %d and %d.",
+                   "must be a power of 2 between %d and %d",
                    n->net_conf.rx_queue_size, VIRTIO_NET_RX_QUEUE_MIN_SIZE,
                    VIRTQUEUE_MAX_SIZE);
         virtio_cleanup(vdev);
@@ -1930,7 +1930,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     n->max_queues = MAX(n->nic_conf.peers.queues, 1);
     if (n->max_queues * 2 + 1 > VIRTIO_QUEUE_MAX) {
         error_setg(errp, "Invalid number of queues (= %" PRIu32 "), "
-                   "must be a positive integer less than %d.",
+                   "must be a positive integer less than %d",
                    n->max_queues, (VIRTIO_QUEUE_MAX - 1) / 2);
         virtio_cleanup(vdev);
         return;
-- 
2.7.4
