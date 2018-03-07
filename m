Received: from eggs.gnu.org ([2001:4830:134:3::10]:56847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eteGE-0003RS-UE
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eteGC-0003Ac-7v
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:57:58 -0500
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:53434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eteGB-00037b-Vb
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:57:56 -0500
Received: from player728.ha.ovh.net (unknown [10.109.120.1])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 7574514505F
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 19:57:47 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 07 Mar 2018 19:57:37 +0100
Message-ID: <152044905701.22965.8924520463227226351.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] virtio_net: flush uncompleted TX on reset
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

This can be reproduced easily by starting a guest without a net backend,
doing a system reset when it is booted, and finally snapshotting it.

The appropriate fix is to ensure that such an asynchronous transmission
cannot survive a device reset. So for all queues, we first try to send
the packet again, and eventually we purge it if the backend still could
not deliver it.

Reported-by: R. Nageswara Sastry <nasastry@in.ibm.com>
Buglink: https://github.com/open-power-host-os/qemu/issues/37
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/net/virtio-net.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 188744e17d57..eea3cdb2c700 100644
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
+        if (!qemu_net_queue_flush(nc->peer->incoming_queue)) {
+            qemu_net_queue_purge(nc->peer->incoming_queue, nc);
+        }
+        assert(!virtio_net_get_subqueue(nc)->async_tx.elem);
+    }
 }
 
 static void peer_test_vnet_hdr(VirtIONet *n)
