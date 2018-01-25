Received: from eggs.gnu.org ([2001:4830:134:3::10]:33689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehog-0003Eh-BT
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehof-00038F-39
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:46 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eehoe-00030M-Rw
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:45 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoS-0006px-8z
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:43:32 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 13:43:10 +0000
Message-Id: <1516887809-6265-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
References: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/21] i.MX: Fix FEC/ENET receive funtions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Jean-Christophe Dubois <jcd@tribudubois.net>

The actual imx_eth_enable_rx() function is buggy.

It updates s->regs[ENET_RDAR] after calling qemu_flush_queued_packets().

qemu_flush_queued_packets() is going to call imx_XXX_receive() which itself
is going to call imx_eth_enable_rx().

By updating s->regs[ENET_RDAR] after calling qemu_flush_queued_packets()
we end up updating the register with an outdated value which might
lead to disabling the receive function in the i.MX FEC/ENET device.

This patch change the place where the register update is done so that the
register value stays up to date and the receive function can keep
running.

Reported-by: Fyleo <fyleo45@gmail.com>
Tested-by: Fyleo  <fyleo45@gmail.com>
Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Message-id: 20180113113445.2705-1-jcd@tribudubois.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Tested-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/imx_fec.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 4fb48f6..9506f9b 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -595,19 +595,16 @@ static void imx_eth_do_tx(IMXFECState *s, uint32_t index)
 static void imx_eth_enable_rx(IMXFECState *s, bool flush)
 {
     IMXFECBufDesc bd;
-    bool rx_ring_full;
 
     imx_fec_read_bd(&bd, s->rx_descriptor);
 
-    rx_ring_full = !(bd.flags & ENET_BD_E);
+    s->regs[ENET_RDAR] = (bd.flags & ENET_BD_E) ? ENET_RDAR_RDAR : 0;
 
-    if (rx_ring_full) {
+    if (!s->regs[ENET_RDAR]) {
         FEC_PRINTF("RX buffer full\n");
     } else if (flush) {
         qemu_flush_queued_packets(qemu_get_queue(s->nic));
     }
-
-    s->regs[ENET_RDAR] = rx_ring_full ? 0 : ENET_RDAR_RDAR;
 }
 
 static void imx_eth_reset(DeviceState *d)
@@ -866,7 +863,6 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
     case ENET_RDAR:
         if (s->regs[ENET_ECR] & ENET_ECR_ETHEREN) {
             if (!s->regs[index]) {
-                s->regs[index] = ENET_RDAR_RDAR;
                 imx_eth_enable_rx(s, true);
             }
         } else {
-- 
2.7.4
