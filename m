Received: from eggs.gnu.org ([2001:4830:134:3::10]:45342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvl-0002AF-EK
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvk-0006vi-69
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:45 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gOlvj-0006rE-Uf
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:57:44 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gOlvf-00065N-8T
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 15:57:39 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Nov 2018 15:57:26 +0000
Message-Id: <20181119155730.11758-7-peter.maydell@linaro.org>
In-Reply-To: <20181119155730.11758-1-peter.maydell@linaro.org>
References: <20181119155730.11758-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/10] hw/arm/stm32f205: Fix the UART and Timer
 region size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Seth Kintigh <skintigh@gmail.com>

The UART and timer devices for the stm32f205 were being created
with memory regions that were too large. Use the size specified
in the chip datasheet.

The old sizes were so large that the devices would overlap with
each other in the SoC memory map, so this fixes a bug that
caused odd behavior and/or crashes when trying to set up multiple
UARTs.

Signed-off-by: Seth Kintigh <skintigh@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: rephrased commit message to follow our usual standard]
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/stm32f2xx_usart.c  | 2 +-
 hw/timer/stm32f2xx_timer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 032b5fda135..f3363a2952d 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -202,7 +202,7 @@ static void stm32f2xx_usart_init(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
 
     memory_region_init_io(&s->mmio, obj, &stm32f2xx_usart_ops, s,
-                          TYPE_STM32F2XX_USART, 0x2000);
+                          TYPE_STM32F2XX_USART, 0x400);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 58fc7b1188e..ae744d16425 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -308,7 +308,7 @@ static void stm32f2xx_timer_init(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
 
     memory_region_init_io(&s->iomem, obj, &stm32f2xx_timer_ops, s,
-                          "stm32f2xx_timer", 0x4000);
+                          "stm32f2xx_timer", 0x400);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
 
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, stm32f2xx_timer_interrupt, s);
-- 
2.19.1
