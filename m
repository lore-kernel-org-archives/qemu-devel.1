Received: from eggs.gnu.org ([2001:4830:134:3::10]:40885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cTBYO-0003sk-6A
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cTBYN-0000e5-98
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:58:48 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 17:58:35 +0000
Message-Id: <1484589515-26353-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/char/exynos4210_uart: Drop unused local
 variable frame_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The frame_size local variable in exynos4210_uart_update_parameters()
is calculated but never used (and has been this way since the
device was introduced in commit e5a4914efc7). The qemu_chr_fe_ioctl()
doesn't need this information (if it really wanted it it could
calculate it from the parity/data_bits/stop_bits), so just drop
the variable entirely.

Fixes: https://bugs.launchpad.net/bugs/1655702

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/exynos4210_uart.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 820d1ab..0cd3dd3 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -306,7 +306,7 @@ static void exynos4210_uart_update_irq(Exynos4210UartState *s)
 
 static void exynos4210_uart_update_parameters(Exynos4210UartState *s)
 {
-    int speed, parity, data_bits, stop_bits, frame_size;
+    int speed, parity, data_bits, stop_bits;
     QEMUSerialSetParams ssp;
     uint64_t uclk_rate;
 
@@ -314,9 +314,7 @@ static void exynos4210_uart_update_parameters(Exynos4210UartState *s)
         return;
     }
 
-    frame_size = 1; /* start bit */
     if (s->reg[I_(ULCON)] & 0x20) {
-        frame_size++; /* parity bit */
         if (s->reg[I_(ULCON)] & 0x28) {
             parity = 'E';
         } else {
@@ -334,8 +332,6 @@ static void exynos4210_uart_update_parameters(Exynos4210UartState *s)
 
     data_bits = (s->reg[I_(ULCON)] & 0x3) + 5;
 
-    frame_size += data_bits + stop_bits;
-
     uclk_rate = 24000000;
 
     speed = uclk_rate / ((16 * (s->reg[I_(UBRDIV)]) & 0xffff) +
-- 
2.7.4
