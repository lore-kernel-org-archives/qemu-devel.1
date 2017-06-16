Received: from eggs.gnu.org ([2001:4830:134:3::10]:44272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dLouv-0005kQ-7Z
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dLour-0000Is-NW
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:55:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:42052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dLour-0000Hn-D4
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:55:49 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 16 Jun 2017 18:48:39 +0800
Message-Id: <1497610119-45041-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1497610119-45041-1-git-send-email-wei.w.wang@intel.com>
References: <1497610119-45041-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 2/2] virtio-net: code cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, marcandre.lureau@gmail.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, pbonzini@redhat.com, armbru@redhat.com, jan.scheurich@ericsson.com, Wei Wang <wei.w.wang@intel.com>

Use is_power_of_2(), and remove trailing "." from error_setg().

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/virtio-net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e1a08fd..e4cb5a7 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1919,9 +1919,9 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
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
@@ -1942,7 +1942,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
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
