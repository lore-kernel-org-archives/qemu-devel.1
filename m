Received: from eggs.gnu.org ([2001:4830:134:3::10]:52758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2I-00085e-BQ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1emK2H-00052y-DJ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:18 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1emK2H-0004yn-66
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:57:17 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1emK24-0001kU-Jf
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 13:57:04 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 13:56:42 +0000
Message-Id: <20180215135702.1340-2-peter.maydell@linaro.org>
In-Reply-To: <20180215135702.1340-1-peter.maydell@linaro.org>
References: <20180215135702.1340-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/21] hw/arm/aspeed: directly map the serial
 device to the system address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 20180209085755.30414-2-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
