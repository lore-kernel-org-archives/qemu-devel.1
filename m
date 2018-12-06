Received: from eggs.gnu.org ([2001:4830:134:3::10]:52261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1gUx1e-0003Zn-CB
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1gUx1Z-0006of-18
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:01:21 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <v.maffione@gmail.com>)
	id 1gUx1U-0006k0-Ie
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:01:15 -0500
Received: by mail-wr1-x444.google.com with SMTP id p4so1203196wrt.7
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 09:01:11 -0800 (PST)
From: Vincenzo Maffione <v.maffione@gmail.com>
Date: Thu,  6 Dec 2018 17:59:06 +0100
Message-Id: <20181206165907.23465-3-v.maffione@gmail.com>
In-Reply-To: <20181206165907.23465-1-v.maffione@gmail.com>
References: <20181206165907.23465-1-v.maffione@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 2/3] net: netmap: simplify netmap_receive()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: g.lettieri@iet.unipi.it, jasowang@redhat.com, Vincenzo Maffione <v.maffione@gmail.com>

Improve code reuse by implementing netmap_receive() with a call
to netmap_receive_iov().

Signed-off-by: Vincenzo Maffione <v.maffione@gmail.com>
---
 net/netmap.c | 50 +++++++++++---------------------------------------
 1 file changed, 11 insertions(+), 39 deletions(-)

diff --git a/net/netmap.c b/net/netmap.c
index 71a8122bdd..852106af29 100644
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
2.19.2
