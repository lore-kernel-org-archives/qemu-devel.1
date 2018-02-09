Received: from eggs.gnu.org ([2001:4830:134:3::10]:33134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ek4VR-0001KT-D3
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ek4VQ-0006Cp-AK
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:58:05 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  9 Feb 2018 05:57:54 -0300
Message-Id: <20180209085755.30414-2-f4bug@amsat.org>
In-Reply-To: <20180209085755.30414-1-f4bug@amsat.org>
References: <20180209085755.30414-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/2] hw/arm/aspeed: directly map the serial
 device to the system address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

(qemu) info mtree
 address-space: cpu-memory-0
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-0000000007ffffff (prio 0, rom): aspeed.boot_rom
     000000001e600000-000000001e7fffff (prio -1, i/o): aspeed_soc.io
-      000000001e784000-000000001e78401f (prio 0, i/o): serial
     000000001e620000-000000001e6200ff (prio 0, i/o): aspeed.smc.ast2500-fmc
     000000001e630000-000000001e6300ff (prio 0, i/o): aspeed.smc.ast2500-spi1
     [...]
     000000001e720000-000000001e728fff (prio 0, ram): aspeed.sram
     000000001e782000-000000001e782fff (prio 0, i/o): aspeed.timer
+    000000001e784000-000000001e78401f (prio 0, i/o): serial
     000000001e785000-000000001e78501f (prio 0, i/o): aspeed.wdt
     000000001e785020-000000001e78503f (prio 0, i/o): aspeed.wdt

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/aspeed_soc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index c83b7e207b..2a5d041b3b 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -257,7 +257,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     /* UART - attach an 8250 to the IO space as our UART5 */
     if (serial_hds[0]) {
         qemu_irq uart5 = qdev_get_gpio_in(DEVICE(&s->vic), uart_irqs[4]);
-        serial_mm_init(&s->iomem, ASPEED_SOC_UART_5_BASE, 2,
+        serial_mm_init(get_system_memory(),
+                       ASPEED_SOC_IOMEM_BASE + ASPEED_SOC_UART_5_BASE, 2,
                        uart5, 38400, serial_hds[0], DEVICE_LITTLE_ENDIAN);
     }
 
-- 
2.16.1
