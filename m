Received: from eggs.gnu.org ([209.51.188.92]:43360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14Fe-0002ce-Qr
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1h14Fc-0000X3-Rj
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1h14Fc-0000Uv-Gx
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:12:32 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue,  5 Mar 2019 15:12:10 +0800
Message-Id: <1551769940-22739-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
References: <1551769940-22739-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL V2 03/13] net: netmap: simplify netmap_receive()
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

Improve code reuse by implementing netmap_receive() with a call
to netmap_receive_iov().

Signed-off-by: Vincenzo Maffione <v.maffione@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/netmap.c | 50 +++++++++++---------------------------------------
 1 file changed, 11 insertions(+), 39 deletions(-)

diff --git a/net/netmap.c b/net/netmap.c
index 71a8122..852106a 100644
--- a/net/netmap.c
+++ b/net/netmap.c
@@ -154,45 +154,6 @@ static void netmap_writable(void *opaque)
     qemu_flush_queued_packets(&s->nc);
 }
 
-static ssize_t netmap_receive(NetClientState *nc,
-      const uint8_t *buf, size_t size)
-{
-    NetmapState *s = DO_UPCAST(NetmapState, nc, nc);
-    struct netmap_ring *ring = s->tx;
-    uint32_t i;
-    uint32_t idx;
-    uint8_t *dst;
-
-    if (unlikely(!ring)) {
-        /* Drop. */
-        return size;
-    }
-
-    if (unlikely(size > ring->nr_buf_size)) {
-        RD(5, "[netmap_receive] drop packet of size %d > %d\n",
-                                    (int)size, ring->nr_buf_size);
-        return size;
-    }
-
-    if (nm_ring_empty(ring)) {
-        /* No available slots in the netmap TX ring. */
-        netmap_write_poll(s, true);
-        return 0;
-    }
-
-    i = ring->cur;
-    idx = ring->slot[i].buf_idx;
-    dst = (uint8_t *)NETMAP_BUF(ring, idx);
-
-    ring->slot[i].len = size;
-    ring->slot[i].flags = 0;
-    pkt_copy(buf, dst, size);
-    ring->cur = ring->head = nm_ring_next(ring, i);
-    ioctl(s->nmd->fd, NIOCTXSYNC, NULL);
-
-    return size;
-}
-
 static ssize_t netmap_receive_iov(NetClientState *nc,
                     const struct iovec *iov, int iovcnt)
 {
@@ -259,6 +220,17 @@ static ssize_t netmap_receive_iov(NetClientState *nc,
     return iov_size(iov, iovcnt);
 }
 
+static ssize_t netmap_receive(NetClientState *nc,
+      const uint8_t *buf, size_t size)
+{
+    struct iovec iov;
+
+    iov.iov_base = (void *)buf;
+    iov.iov_len = size;
+
+    return netmap_receive_iov(nc, &iov, 1);
+}
+
 /* Complete a previous send (backend --> guest) and enable the
    fd_read callback. */
 static void netmap_send_completed(NetClientState *nc, ssize_t len)
-- 
2.5.0
