Received: from eggs.gnu.org ([2001:4830:134:3::10]:42009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dOEVi-0005ZF-4o
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 22:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dOEVe-0008Pn-5x
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 22:39:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:46340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dOEVd-0008Kq-Sb
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 22:39:46 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 23 Jun 2017 10:32:34 +0800
Message-Id: <1498185154-29015-2-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1498185154-29015-1-git-send-email-wei.w.wang@intel.com>
References: <1498185154-29015-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v3 2/2] virtio-net: code cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, jasowang@redhat.com, eblake@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, jan.scheurich@ericsson.com, marcandre.lureau@gmail.com, stefanha@gmail.com, Wei Wang <wei.w.wang@intel.com>

Use is_power_of_2(), and remove trailing "." from error_setg().

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/net/virtio-net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d13ca60..b42423c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1924,9 +1924,9 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
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
@@ -1947,7 +1947,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
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
