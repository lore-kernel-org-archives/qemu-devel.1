Received: from eggs.gnu.org ([2001:4830:134:3::10]:37453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eaK5p-0001ul-1L
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 06:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eaK5o-0006ve-4U
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 06:35:21 -0500
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Sat, 13 Jan 2018 12:34:45 +0100
Message-Id: <20180113113445.2705-1-jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH v2] i.MX: Fix FEC/ENET receive funtions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-devel@nongnu.org, fyleo45@gmail.com, qemu-arm@nongnu.org, peter.maydell@linaro.org, peter.chubb@nicta.com.au

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
---
Change since v1:
1. Rebase the patch on the updated master branch

 hw/net/imx_fec.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 4fb48f62ba..9506f9b69f 100644
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
2.14.1
