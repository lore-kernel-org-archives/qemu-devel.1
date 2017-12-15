Received: from eggs.gnu.org ([2001:4830:134:3::10]:43308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw7-00062j-Np
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ePuw6-0006uP-MC
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:19 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60830
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ePuw6-0006bb-G2
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:42:18 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 15 Dec 2017 18:41:47 +0000
Message-Id: <20171215184155.2543-6-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
References: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv3 05/13] sunhme: switch sunhme over to use
 net_crc32_le()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

Instead of sunhme_crc32_le() using its own implementation, we can simply call
net_crc32_le() directly and apply the bit shift inline.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/sunhme.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index b1efa1b88d..7558fca8f9 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -698,29 +698,6 @@ static inline void sunhme_set_rx_ring_nr(SunHMEState *s, int i)
     s->erxregs[HME_ERXI_RING >> 2] = ring;
 }
 
-#define POLYNOMIAL_LE 0xedb88320
-static uint32_t sunhme_crc32_le(const uint8_t *p, int len)
-{
-    uint32_t crc;
-    int carry, i, j;
-    uint8_t b;
-
-    crc = 0xffffffff;
-    for (i = 0; i < len; i++) {
-        b = *p++;
-        for (j = 0; j < 8; j++) {
-            carry = (crc & 0x1) ^ (b & 0x01);
-            crc >>= 1;
-            b >>= 1;
-            if (carry) {
-                crc = crc ^ POLYNOMIAL_LE;
-            }
-        }
-    }
-
-    return crc;
-}
-
 #define MIN_BUF_SIZE 60
 
 static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
@@ -761,7 +738,7 @@ static ssize_t sunhme_receive(NetClientState *nc, const uint8_t *buf,
             trace_sunhme_rx_filter_bcast_match();
         } else if (s->macregs[HME_MACI_RXCFG >> 2] & HME_MAC_RXCFG_HENABLE) {
             /* Didn't match local address, check hash filter */
-            int mcast_idx = sunhme_crc32_le(buf, 6) >> 26;
+            int mcast_idx = net_crc32_le(buf, ETH_ALEN) >> 26;
             if (!(s->macregs[(HME_MACI_HASHTAB0 >> 2) - (mcast_idx >> 4)] &
                     (1 << (mcast_idx & 0xf)))) {
                 /* Didn't match hash filter */
-- 
2.11.0
