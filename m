Received: from eggs.gnu.org ([2001:4830:134:3::10]:52106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3z-0007QR-Jm
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3y-0008Vz-MD
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:35 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd3y-0008UD-F8
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:34 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3x-0005fT-6f
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:33 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:38:07 +0000
Message-Id: <1515677902-23436-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/26] imx_fec: Refactor imx_eth_enable_rx()
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

Refactor imx_eth_enable_rx() to have more meaningfull variable name
than 'tmp' and to reduce number of logical negations done.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/imx_fec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 88b4b04..8b2e4b8 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -536,19 +536,19 @@ static void imx_eth_do_tx(IMXFECState *s)
 static void imx_eth_enable_rx(IMXFECState *s)
 {
     IMXFECBufDesc bd;
-    bool tmp;
+    bool rx_ring_full;
 
     imx_fec_read_bd(&bd, s->rx_descriptor);
 
-    tmp = ((bd.flags & ENET_BD_E) != 0);
+    rx_ring_full = !(bd.flags & ENET_BD_E);
 
-    if (!tmp) {
+    if (rx_ring_full) {
         FEC_PRINTF("RX buffer full\n");
     } else if (!s->regs[ENET_RDAR]) {
         qemu_flush_queued_packets(qemu_get_queue(s->nic));
     }
 
-    s->regs[ENET_RDAR] = tmp ? ENET_RDAR_RDAR : 0;
+    s->regs[ENET_RDAR] = rx_ring_full ? 0 : ENET_RDAR_RDAR;
 }
 
 static void imx_eth_reset(DeviceState *d)
-- 
2.7.4
