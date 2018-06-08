Received: from eggs.gnu.org ([2001:4830:134:3::10]:50372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlk-0002zp-4d
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlj-0004DB-CE
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:28 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlj-00046X-4A
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:27 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlh-0003es-QA
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:25 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:44:56 +0100
Message-Id: <20180608124517.29475-11-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/31] ftgmac100: add IEEE 802.1Q VLAN support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

The ftgmac100 NIC supports VLAN tag insertion and the MAC engine also
has a control to remove VLAN tags from received packets.

The VLAN control bits and VLAN tag information are contained in the
second word of the transmit and receive descriptors. The Insert VLAN
bit and the VLAN Tag available bit are only valid in the first segment
of the packet.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180530061711.23673-3-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/ftgmac100.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 425ac36cff8..abf80655f28 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -443,6 +443,22 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
             break;
         }
 
+        /* Check for VLAN */
+        if (bd.des0 & FTGMAC100_TXDES0_FTS &&
+            bd.des1 & FTGMAC100_TXDES1_INS_VLANTAG &&
+            be16_to_cpu(PKT_GET_ETH_HDR(ptr)->h_proto) != ETH_P_VLAN) {
+            if (frame_size + len + 4 > sizeof(s->frame)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too big : %d bytes\n",
+                              __func__, len);
+                s->isr |= FTGMAC100_INT_XPKT_LOST;
+                len =  sizeof(s->frame) - frame_size - 4;
+            }
+            memmove(ptr + 16, ptr + 12, len - 12);
+            stw_be_p(ptr + 12, ETH_P_VLAN);
+            stw_be_p(ptr + 14, bd.des1);
+            len += 4;
+        }
+
         ptr += len;
         frame_size += len;
         if (bd.des0 & FTGMAC100_TXDES0_LTS) {
@@ -864,7 +880,20 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
             buf_len += size - 4;
         }
         buf_addr = bd.des3;
-        dma_memory_write(&address_space_memory, buf_addr, buf, buf_len);
+        if (first && proto == ETH_P_VLAN && buf_len >= 18) {
+            bd.des1 = lduw_be_p(buf + 14) | FTGMAC100_RXDES1_VLANTAG_AVAIL;
+
+            if (s->maccr & FTGMAC100_MACCR_RM_VLAN) {
+                dma_memory_write(&address_space_memory, buf_addr, buf, 12);
+                dma_memory_write(&address_space_memory, buf_addr + 12, buf + 16,
+                                 buf_len - 16);
+            } else {
+                dma_memory_write(&address_space_memory, buf_addr, buf, buf_len);
+            }
+        } else {
+            bd.des1 = 0;
+            dma_memory_write(&address_space_memory, buf_addr, buf, buf_len);
+        }
         buf += buf_len;
         if (size < 4) {
             dma_memory_write(&address_space_memory, buf_addr + buf_len,
-- 
2.17.1
