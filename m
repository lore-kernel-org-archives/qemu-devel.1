Received: from eggs.gnu.org ([209.51.188.92]:34995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gxCHH-0000VB-42
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gxCF6-0007fa-A2
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:56:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gxCF5-0007Ck-SK
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:56:00 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Feb 2019 22:55:18 +0800
Message-Id: <1550847320-25110-12-git-send-email-jasowang@redhat.com>
In-Reply-To: <1550847320-25110-1-git-send-email-jasowang@redhat.com>
References: <1550847320-25110-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 11/13] net: netmap: small improvements
 netmap_send()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Vincenzo Maffione <v.maffione@gmail.com>, Jason Wang <jasowang@redhat.com>

From: Vincenzo Maffione <v.maffione@gmail.com>

This change improves the handling of incomplete multi-slot packets
(e.g. with the NS_MOREFRAG set), by advancing ring->head only on
complete packets. The ring->cur pointer is advanced in any case in
order to acknowledge the kernel and move the wake-up point (thus
avoiding repeated wake-ups).
Also don't be verbose when incomplete packets are found.

Signed-off-by: Vincenzo Maffione <v.maffione@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/netmap.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/net/netmap.c b/net/netmap.c
index 2d11a8f..71a8122 100644
--- a/net/netmap.c
+++ b/net/netmap.c
@@ -272,39 +272,46 @@ static void netmap_send(void *opaque)
 {
     NetmapState *s = opaque;
     struct netmap_ring *ring = s->rx;
+    unsigned int tail = ring->tail;
 
-    /* Keep sending while there are available packets into the netmap
+    /* Keep sending while there are available slots in the netmap
        RX ring and the forwarding path towards the peer is open. */
-    while (!nm_ring_empty(ring)) {
-        uint32_t i;
+    while (ring->head != tail) {
+        uint32_t i = ring->head;
         uint32_t idx;
         bool morefrag;
         int iovcnt = 0;
         int iovsize;
 
+        /* Get a (possibly multi-slot) packet. */
         do {
-            i = ring->cur;
             idx = ring->slot[i].buf_idx;
             morefrag = (ring->slot[i].flags & NS_MOREFRAG);
-            s->iov[iovcnt].iov_base = (u_char *)NETMAP_BUF(ring, idx);
+            s->iov[iovcnt].iov_base = (void *)NETMAP_BUF(ring, idx);
             s->iov[iovcnt].iov_len = ring->slot[i].len;
             iovcnt++;
+            i = nm_ring_next(ring, i);
+        } while (i != tail && morefrag);
 
-            ring->cur = ring->head = nm_ring_next(ring, i);
-        } while (!nm_ring_empty(ring) && morefrag);
+        /* Advance ring->cur to tell the kernel that we have seen the slots. */
+        ring->cur = i;
 
-        if (unlikely(nm_ring_empty(ring) && morefrag)) {
-            RD(5, "[netmap_send] ran out of slots, with a pending"
-                   "incomplete packet\n");
+        if (unlikely(morefrag)) {
+            /* This is a truncated packet, so we can stop without releasing the
+             * incomplete slots by updating ring->head. We will hopefully
+             * re-read the complete packet the next time we are called. */
+            break;
         }
 
         iovsize = qemu_sendv_packet_async(&s->nc, s->iov, iovcnt,
                                             netmap_send_completed);
 
+        /* Release the slots to the kernel. */
+        ring->head = i;
+
         if (iovsize == 0) {
             /* The peer does not receive anymore. Packet is queued, stop
-             * reading from the backend until netmap_send_completed()
-             */
+             * reading from the backend until netmap_send_completed(). */
             netmap_read_poll(s, false);
             break;
         }
-- 
2.5.0
