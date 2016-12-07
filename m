Received: from eggs.gnu.org ([2001:4830:134:3::10]:52005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.gacek@gmail.com>) id 1cEjXp-000510-UA
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 16:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.gacek@gmail.com>) id 1cEjXl-00058z-Vm
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 16:14:29 -0500
MIME-Version: 1.0
From: Andrew Gacek <andrew.gacek@gmail.com>
Date: Wed, 7 Dec 2016 15:12:42 -0600
Message-ID: <CAHgzvFi2wjPtJzU9hXzdaZsbYr085VCbjfsiUeVc5XnUR8arHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH] cadence_uart: Check if receiver timeout
 counter is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

When register Rcvr_timeout_reg0 (R_RTOR in cadence_uart.c) is set to
0, the receiver timeout counter should be disabled. See page 1801 of
"Zynq-7000 AP SoC Technical Reference Manual". This commit adds a
such a check before setting the receive timeout interrupt.

Signed-off-by: Andrew Gacek <andrew.gacek@gmail.com>
---
 hw/char/cadence_uart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 0215d65..54194b1 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -138,7 +138,9 @@ static void fifo_trigger_update(void *opaque)
 {
     CadenceUARTState *s = opaque;

-    s->r[R_CISR] |= UART_INTR_TIMEOUT;
+    if (s->r[R_RTOR]) {
+        s->r[R_CISR] |= UART_INTR_TIMEOUT;
+    }

     uart_update_status(s);
 }
-- 
2.7.4
