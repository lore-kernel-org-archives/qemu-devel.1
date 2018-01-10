Received: from eggs.gnu.org ([2001:4830:134:3::10]:38632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eZN95-00082m-90
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1eZN94-00054b-BO
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:38:47 -0500
From: Jean-Christophe Dubois <jcd@tribudubois.net>
Date: Wed, 10 Jan 2018 21:38:23 +0100
Message-Id: <20180110203823.22292-1-jcd@tribudubois.net>
Subject: [Qemu-devel] [PATCH] i.MX: Fix FEC/ENET receive funtions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-devel@nongnu.org, fyleo45@gmail.com, qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>, Jason Wang <jasowang@redhat.com>

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
Tested-by: Fyleo <fyleo45@gmail.com>
Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 hw/net/imx_fec.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 90e6ee35ba..04a5cf12f1 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -536,19 +536,16 @@ static void imx_eth_do_tx(IMXFECState *s)
 static void imx_eth_enable_rx(IMXFECState *s)
 {
     IMXFECBufDesc bd;
-    bool tmp;
 
     imx_fec_read_bd(&bd, s->rx_descriptor);
 
-    tmp = ((bd.flags & ENET_BD_E) != 0);
+    s->regs[ENET_RDAR] = (bd.flags & ENET_BD_E) ? ENET_RDAR_RDAR : 0;
 
-    if (!tmp) {
+    if (!s->regs[ENET_RDAR]) {
         FEC_PRINTF("RX buffer full\n");
-    } else if (!s->regs[ENET_RDAR]) {
+    } else {
         qemu_flush_queued_packets(qemu_get_queue(s->nic));
     }
-
-    s->regs[ENET_RDAR] = tmp ? ENET_RDAR_RDAR : 0;
 }
 
 static void imx_eth_reset(DeviceState *d)
@@ -806,7 +803,6 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
     case ENET_RDAR:
         if (s->regs[ENET_ECR] & ENET_ECR_ETHEREN) {
             if (!s->regs[index]) {
-                s->regs[index] = ENET_RDAR_RDAR;
                 imx_eth_enable_rx(s);
             }
         } else {
-- 
2.14.1
