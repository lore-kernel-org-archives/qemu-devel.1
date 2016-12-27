Received: from eggs.gnu.org ([2001:4830:134:3::10]:35216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZJ-0001bo-13
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZI-00019n-8L
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtZI-00019j-1Y
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:21:36 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtZH-0003qO-71
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:21:35 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:20:54 +0000
Message-Id: <1482852077-19397-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/25] cadence_uart: Check if receiver timeout
 counter is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrew Gacek <andrew.gacek@gmail.com>

When register Rcvr_timeout_reg0 (R_RTOR in cadence_uart.c) is set to
0, the receiver timeout counter should be disabled. See page 1801 of
"Zynq-7000 AP SoC Technical Reference Manual". This commit adds a
such a check before setting the receive timeout interrupt.

Signed-off-by: Andrew Gacek <andrew.gacek@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/cadence_uart.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index dba1c53..4dcee57 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -138,9 +138,10 @@ static void fifo_trigger_update(void *opaque)
 {
     CadenceUARTState *s = opaque;
 
-    s->r[R_CISR] |= UART_INTR_TIMEOUT;
-
-    uart_update_status(s);
+    if (s->r[R_RTOR]) {
+        s->r[R_CISR] |= UART_INTR_TIMEOUT;
+        uart_update_status(s);
+    }
 }
 
 static void uart_rx_reset(CadenceUARTState *s)
-- 
2.7.4
