Received: from eggs.gnu.org ([2001:4830:134:3::10]:52171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd41-0007Rp-JT
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd40-00006B-77
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd3z-0008Ve-VS
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:36 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3y-0005gH-Kv
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:34 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:09 +0000
Message-Id: <1515677902-23436-14-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/26] imx_fec: Move Tx frame buffer away from
 the stack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Make Tx frame assembly buffer to be a paort of IMXFECState structure
to avoid a concern about having large data buffer on the stack.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/imx_fec.h |  3 +++
 hw/net/imx_fec.c         | 22 +++++++++++-----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index 62ad473..6799387 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -252,6 +252,9 @@ typedef struct IMXFECState {
     uint32_t phy_int_mask;
 
     bool is_fec;
+
+    /* Buffer used to assemble a Tx frame */
+    uint8_t frame[ENET_MAX_FRAME_SIZE];
 } IMXFECState;
 
 #endif
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index eb034ff..56cb722 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -405,8 +405,7 @@ static void imx_eth_update(IMXFECState *s)
 static void imx_fec_do_tx(IMXFECState *s)
 {
     int frame_size = 0, descnt = 0;
-    uint8_t frame[ENET_MAX_FRAME_SIZE];
-    uint8_t *ptr = frame;
+    uint8_t *ptr = s->frame;
     uint32_t addr = s->tx_descriptor;
 
     while (descnt++ < IMX_MAX_DESC) {
@@ -431,8 +430,8 @@ static void imx_fec_do_tx(IMXFECState *s)
         frame_size += len;
         if (bd.flags & ENET_BD_L) {
             /* Last buffer in frame.  */
-            qemu_send_packet(qemu_get_queue(s->nic), frame, frame_size);
-            ptr = frame;
+            qemu_send_packet(qemu_get_queue(s->nic), s->frame, frame_size);
+            ptr = s->frame;
             frame_size = 0;
             s->regs[ENET_EIR] |= ENET_INT_TXF;
         }
@@ -456,8 +455,7 @@ static void imx_fec_do_tx(IMXFECState *s)
 static void imx_enet_do_tx(IMXFECState *s)
 {
     int frame_size = 0, descnt = 0;
-    uint8_t frame[ENET_MAX_FRAME_SIZE];
-    uint8_t *ptr = frame;
+    uint8_t *ptr = s->frame;
     uint32_t addr = s->tx_descriptor;
 
     while (descnt++ < IMX_MAX_DESC) {
@@ -482,13 +480,13 @@ static void imx_enet_do_tx(IMXFECState *s)
         frame_size += len;
         if (bd.flags & ENET_BD_L) {
             if (bd.option & ENET_BD_PINS) {
-                struct ip_header *ip_hd = PKT_GET_IP_HDR(frame);
+                struct ip_header *ip_hd = PKT_GET_IP_HDR(s->frame);
                 if (IP_HEADER_VERSION(ip_hd) == 4) {
-                    net_checksum_calculate(frame, frame_size);
+                    net_checksum_calculate(s->frame, frame_size);
                 }
             }
             if (bd.option & ENET_BD_IINS) {
-                struct ip_header *ip_hd = PKT_GET_IP_HDR(frame);
+                struct ip_header *ip_hd = PKT_GET_IP_HDR(s->frame);
                 /* We compute checksum only for IPv4 frames */
                 if (IP_HEADER_VERSION(ip_hd) == 4) {
                     uint16_t csum;
@@ -498,8 +496,10 @@ static void imx_enet_do_tx(IMXFECState *s)
                 }
             }
             /* Last buffer in frame.  */
-            qemu_send_packet(qemu_get_queue(s->nic), frame, len);
-            ptr = frame;
+
+            qemu_send_packet(qemu_get_queue(s->nic), s->frame, len);
+            ptr = s->frame;
+
             frame_size = 0;
             if (bd.option & ENET_BD_TX_INT) {
                 s->regs[ENET_EIR] |= ENET_INT_TXF;
-- 
2.7.4
