Received: from eggs.gnu.org ([2001:4830:134:3::10]:41497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eyElZ-0002Si-9i
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eyElT-0001vW-10
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:45:17 -0400
Received: from 2.mo3.mail-out.ovh.net ([46.105.75.36]:45884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eyElS-0001so-Qg
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 06:45:10 -0400
Received: from player758.ha.ovh.net (unknown [10.109.122.178])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 3890C1A6C40
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 11:45:09 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 20 Mar 2018 11:44:56 +0100
Message-ID: <152154269600.31739.7524634810909861801.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3] virtio_net: flush uncompleted TX on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, R Nageswara Sastry <nasastry@in.ibm.com>

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

Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
Buglink: https://github.com/open-power-host-os/qemu/issues/37
Signed-off-by: Greg Kurz <groug@kaod.org>
Tested-by: R. Nageswara Sastry <nasastry@in.ibm.com>
---
v3: - only flush if the device does have a backend (fixes hotplug test)

v2: - make qemu_flush_or_purge_queued_packets() extern and use it
    - reworded reproducer paragraph in changelog
---
 hw/net/virtio-net.c |   11 +++++++++++
 include/net/net.h   |    1 +
 net/net.c           |    1 -
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 188744e17d57..ce7187b26a9e 100644
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
index a943e968a3dc..1f7341e4592b 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -153,6 +153,7 @@ ssize_t qemu_send_packet_async(NetClientState *nc, const uint8_t *buf,
                                int size, NetPacketSent *sent_cb);
 void qemu_purge_queued_packets(NetClientState *nc);
 void qemu_flush_queued_packets(NetClientState *nc);
+void qemu_flush_or_purge_queued_packets(NetClientState *nc, bool purge);
 void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6]);
 bool qemu_has_ufo(NetClientState *nc);
 bool qemu_has_vnet_hdr(NetClientState *nc);
diff --git a/net/net.c b/net/net.c
index 5222e450698c..29f83983e55d 100644
--- a/net/net.c
+++ b/net/net.c
@@ -595,7 +595,6 @@ void qemu_purge_queued_packets(NetClientState *nc)
     qemu_net_queue_purge(nc->peer->incoming_queue, nc);
 }
 
-static
 void qemu_flush_or_purge_queued_packets(NetClientState *nc, bool purge)
 {
     nc->receive_disabled = 0;
