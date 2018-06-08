Received: from eggs.gnu.org ([2001:4830:134:3::10]:50403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGll-00030v-D5
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlk-0004Dl-CF
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:29 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlk-00046X-3c
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:28 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlh-0003eQ-3i
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:25 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:44:55 +0100
Message-Id: <20180608124517.29475-10-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/31] ftgmac100: compute maximum frame size
 depending on the protocol
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

The maximum frame size includes the CRC and depends if a VLAN tag is
inserted or not. Adjust the frame size limit in the transmit handler
using on the FTGMAC100State buffer size and in the receive handler use
the packet protocol.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180530061711.23673-2-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/ftgmac100.h |  7 ++++++-
 hw/net/ftgmac100.c         | 23 ++++++++++++-----------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
index d9bc589fbf7..94cfe053329 100644
--- a/include/hw/net/ftgmac100.h
+++ b/include/hw/net/ftgmac100.h
@@ -16,6 +16,11 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 
+/*
+ * Max frame size for the receiving buffer
+ */
+#define FTGMAC100_MAX_FRAME_SIZE    9220
+
 typedef struct FTGMAC100State {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -26,7 +31,7 @@ typedef struct FTGMAC100State {
     qemu_irq irq;
     MemoryRegion iomem;
 
-    uint8_t *frame;
+    uint8_t frame[FTGMAC100_MAX_FRAME_SIZE];
 
     uint32_t irq_state;
     uint32_t isr;
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 3300e8ef4a8..425ac36cff8 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -207,16 +207,18 @@ typedef struct {
 /*
  * Max frame size for the receiving buffer
  */
-#define FTGMAC100_MAX_FRAME_SIZE    10240
+#define FTGMAC100_MAX_FRAME_SIZE    9220
 
 /* Limits depending on the type of the frame
  *
  *   9216 for Jumbo frames (+ 4 for VLAN)
  *   1518 for other frames (+ 4 for VLAN)
  */
-static int ftgmac100_max_frame_size(FTGMAC100State *s)
+static int ftgmac100_max_frame_size(FTGMAC100State *s, uint16_t proto)
 {
-    return (s->maccr & FTGMAC100_MACCR_JUMBO_LF ? 9216 : 1518) + 4;
+    int max = (s->maccr & FTGMAC100_MACCR_JUMBO_LF ? 9216 : 1518);
+
+    return max + (proto == ETH_P_VLAN ? 4 : 0);
 }
 
 static void ftgmac100_update_irq(FTGMAC100State *s)
@@ -408,7 +410,6 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
     uint8_t *ptr = s->frame;
     uint32_t addr = tx_descriptor;
     uint32_t flags = 0;
-    int max_frame_size = ftgmac100_max_frame_size(s);
 
     while (1) {
         FTGMAC100Desc bd;
@@ -427,11 +428,12 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
             flags = bd.des1;
         }
 
-        len = bd.des0 & 0x3FFF;
-        if (frame_size + len > max_frame_size) {
+        len = FTGMAC100_TXDES0_TXBUF_SIZE(bd.des0);
+        if (frame_size + len > sizeof(s->frame)) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too big : %d bytes\n",
                           __func__, len);
-            len = max_frame_size - frame_size;
+            s->isr |= FTGMAC100_INT_XPKT_LOST;
+            len =  sizeof(s->frame) - frame_size;
         }
 
         if (dma_memory_read(&address_space_memory, bd.des3, ptr, len)) {
@@ -788,7 +790,8 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
     uint32_t buf_len;
     size_t size = len;
     uint32_t first = FTGMAC100_RXDES0_FRS;
-    int max_frame_size = ftgmac100_max_frame_size(s);
+    uint16_t proto = be16_to_cpu(PKT_GET_ETH_HDR(buf)->h_proto);
+    int max_frame_size = ftgmac100_max_frame_size(s, proto);
 
     if ((s->maccr & (FTGMAC100_MACCR_RXDMA_EN | FTGMAC100_MACCR_RXMAC_EN))
          != (FTGMAC100_MACCR_RXDMA_EN | FTGMAC100_MACCR_RXMAC_EN)) {
@@ -820,9 +823,9 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
 
     /* Huge frames are truncated.  */
     if (size > max_frame_size) {
-        size = max_frame_size;
         qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too big : %zd bytes\n",
                       __func__, size);
+        size = max_frame_size;
         flags |= FTGMAC100_RXDES0_FTL;
     }
 
@@ -940,8 +943,6 @@ static void ftgmac100_realize(DeviceState *dev, Error **errp)
                           object_get_typename(OBJECT(dev)), DEVICE(dev)->id,
                           s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
-
-    s->frame = g_malloc(FTGMAC100_MAX_FRAME_SIZE);
 }
 
 static const VMStateDescription vmstate_ftgmac100 = {
-- 
2.17.1
