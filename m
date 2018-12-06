Received: from eggs.gnu.org ([2001:4830:134:3::10]:52329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1gUx1v-0003mc-C9
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1gUx1e-0006t6-ST
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:01:35 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <v.maffione@gmail.com>)
	id 1gUx1e-0006kp-99
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:01:22 -0500
Received: by mail-wr1-x443.google.com with SMTP id j2so1243119wrw.1
	for <qemu-devel@nongnu.org>; Thu, 06 Dec 2018 09:01:12 -0800 (PST)
From: Vincenzo Maffione <v.maffione@gmail.com>
Date: Thu,  6 Dec 2018 17:59:07 +0100
Message-Id: <20181206165907.23465-4-v.maffione@gmail.com>
In-Reply-To: <20181206165907.23465-1-v.maffione@gmail.com>
References: <20181206165907.23465-1-v.maffione@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 3/3] net: netmap: improve
 netmap_receive_iov()
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

Changes:
  - Save CPU cycles by computing the return value while scanning the
    input iovec, rather than calling iov_size() at the end.
  - Remove check for s->tx != NULL, because it cannot happen.
  - Cache ring->tail in a local variable and use it to check for
    space in the TX ring. The use of nm_ring_empty() was invalid,
    because nobody is updating ring->cur and ring->head at that point.
  - In case we run out of netmap slots in the middle of a packet,
    move the wake-up point by advancing ring->cur, but do not
    expose the incomplete packet (i.e., by updating also ring->head).

Signed-off-by: Vincenzo Maffione <v.maffione@gmail.com>
---
 net/netmap.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/netmap.c b/net/netmap.c
index 852106af29..0cc8f545c5 100644
--- a/net/netmap.c
+++ b/net/netmap.c
@@ -159,21 +159,22 @@ static ssize_t netmap_receive_iov(NetClientState *nc,
 {
     NetmapState *s = DO_UPCAST(NetmapState, nc, nc);
     struct netmap_ring *ring = s->tx;
+    unsigned int tail = ring->tail;
+    ssize_t totlen = 0;
     uint32_t last;
     uint32_t idx;
     uint8_t *dst;
     int j;
     uint32_t i;
 
-    if (unlikely(!ring)) {
-        /* Drop the packet. */
-        return iov_size(iov, iovcnt);
-    }
-
-    last = i = ring->cur;
+    last = i = ring->head;
 
     if (nm_ring_space(ring) < iovcnt) {
-        /* Not enough netmap slots. */
+        /* Not enough netmap slots. Tell the kernel that we have seen the new
+         * available slots (so that it notifies us again when it has more
+         * ones), but without publishing any new slots to be processed
+         * (e.g., we don't advance ring->head). */
+        ring->cur = tail;
         netmap_write_poll(s, true);
         return 0;
     }
@@ -183,14 +184,17 @@ static ssize_t netmap_receive_iov(NetClientState *nc,
         int offset = 0;
         int nm_frag_size;
 
+        totlen += iov_frag_size;
+
         /* Split each iovec fragment over more netmap slots, if
            necessary. */
         while (iov_frag_size) {
             nm_frag_size = MIN(iov_frag_size, ring->nr_buf_size);
 
-            if (unlikely(nm_ring_empty(ring))) {
-                /* We run out of netmap slots while splitting the
+            if (unlikely(i == tail)) {
+                /* We ran out of netmap slots while splitting the
                    iovec fragments. */
+                ring->cur = tail;
                 netmap_write_poll(s, true);
                 return 0;
             }
@@ -212,12 +216,13 @@ static ssize_t netmap_receive_iov(NetClientState *nc,
     /* The last slot must not have NS_MOREFRAG set. */
     ring->slot[last].flags &= ~NS_MOREFRAG;
 
-    /* Now update ring->cur and ring->head. */
-    ring->cur = ring->head = i;
+    /* Now update ring->head and ring->cur to publish the new slots and
+     * the new wakeup point. */
+    ring->head = ring->cur = i;
 
     ioctl(s->nmd->fd, NIOCTXSYNC, NULL);
 
-    return iov_size(iov, iovcnt);
+    return totlen;
 }
 
 static ssize_t netmap_receive(NetClientState *nc,
-- 
2.19.2
