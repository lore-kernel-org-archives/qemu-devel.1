Received: from eggs.gnu.org ([2001:4830:134:3::10]:46165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iO-0001zW-Ok
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iN-00008M-Fk
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:48 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:12 -0500
Message-Id: <20180619014319.28272-47-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 046/113] virtio_net: flush uncompleted TX on
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Jason Wang <jasowang@redhat.com>

From: Greg Kurz <groug@kaod.org>

If the backend could not transmit a packet right away for some reason,
the packet is queued for asynchronous sending. The corresponding vq
element is tracked in the async_tx.elem field of the VirtIONetQueue,
for later freeing when the transmission is complete.

If a reset happens before completion, virtio_net_tx_complete() will push
async_tx.elem back to the guest anyway, and we end up with the inuse flag
of the vq being equal to -1. The next call to virtqueue_pop() is then
likely to fail with "Virtqueue size exceeded".

This can be reproduced easily by starting a guest with an hubport backend
that is not connected to a functional network, eg,

 -device virtio-net-pci,netdev=hub0 -netdev hubport,id=hub0,hubid=0

and no other -netdev hubport,hubid=0 on the command line.

The appropriate fix is to ensure that such an asynchronous transmission
cannot survive a device reset. So for all queues, we first try to send
the packet again, and eventually we purge it if the backend still could
not deliver it.

CC: qemu-stable@nongnu.org
Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
Buglink: https://github.com/open-power-host-os/qemu/issues/37
Signed-off-by: Greg Kurz <groug@kaod.org>
Tested-by: R. Nageswara Sastry <nasastry@in.ibm.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 94b52958b77a2a040564cf7ed716d3a9545d94e5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/virtio-net.c | 11 +++++++++++
 include/net/net.h   |  1 +
 net/net.c           |  1 -
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 38674b08aa..6bdef38ceb 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -422,6 +422,7 @@ static RxFilterInfo *virtio_net_query_rxfilter(NetClientState *nc)
 static void virtio_net_reset(VirtIODevice *vdev)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
+    int i;
 
     /* Reset back to compatibility mode */
     n->promisc = 1;
@@ -445,6 +446,16 @@ static void virtio_net_reset(VirtIODevice *vdev)
     memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
     qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
     memset(n->vlans, 0, MAX_VLAN >> 3);
+
+    /* Flush any async TX */
+    for (i = 0;  i < n->max_queues; i++) {
+        NetClientState *nc = qemu_get_subqueue(n->nic, i);
+
+        if (nc->peer) {
+            qemu_flush_or_purge_queued_packets(nc->peer, true);
+            assert(!virtio_net_get_subqueue(nc)->async_tx.elem);
+        }
+    }
 }
 
 static void peer_test_vnet_hdr(VirtIONet *n)
diff --git a/include/net/net.h b/include/net/net.h
index 1c55a93588..ab87d426e1 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -156,6 +156,7 @@ ssize_t qemu_send_packet_async(NetClientState *nc, const uint8_t *buf,
                                int size, NetPacketSent *sent_cb);
 void qemu_purge_queued_packets(NetClientState *nc);
 void qemu_flush_queued_packets(NetClientState *nc);
+void qemu_flush_or_purge_queued_packets(NetClientState *nc, bool purge);
 void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6]);
 bool qemu_has_ufo(NetClientState *nc);
 bool qemu_has_vnet_hdr(NetClientState *nc);
diff --git a/net/net.c b/net/net.c
index 39ef546708..0719358d03 100644
--- a/net/net.c
+++ b/net/net.c
@@ -612,7 +612,6 @@ void qemu_purge_queued_packets(NetClientState *nc)
     qemu_net_queue_purge(nc->peer->incoming_queue, nc);
 }
 
-static
 void qemu_flush_or_purge_queued_packets(NetClientState *nc, bool purge)
 {
     nc->receive_disabled = 0;
-- 
2.11.0
