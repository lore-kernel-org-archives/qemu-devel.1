Received: from eggs.gnu.org ([2001:4830:134:3::10]:45012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH08-0000aO-H8
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH07-0007Xo-20
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:32 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 17:40:50 -0300
Message-Id: <20180118204058.5768-7-f4bug@amsat.org>
In-Reply-To: <20180118204058.5768-1-f4bug@amsat.org>
References: <20180118204058.5768-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 06/14] hw/arm/xilinx_zynqmp: implement SDHCI
 Spec v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/xlnx-zynqmp.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 325642058b..c4f6638ab7 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -381,22 +381,40 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0, gic_spi[SATA_INTR]);
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_SDHCI; i++) {
-        char *bus_name;
-
-        object_property_set_bool(OBJECT(&s->sdhci[i]), true,
-                                 "realized", &err);
+        char *bus_name = g_strdup_printf("sd-bus%d", i);
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->sdhci[i]);
+        Object *sdhci = OBJECT(&s->sdhci[i]);
+
+        /* Compatible with:
+         * - SD Host Controller Specification Version 3.00
+         * - SDIO Specification Version 3.0
+         * - eMMC Specification Version 4.51
+         *
+         * Host clock rate variable between 0 and 208 MHz
+         * Transfers the data in SDR104, SDR50, DDR50 modes
+         * (SDR104 mode: up to 832Mbits/s using 4 parallel data lines)
+         * Transfers the data in 1 bit and 4 bit SD modes
+         * UHS speed modes, 1.8V
+         * voltage switch, tuning commands
+         */
+        object_property_set_uint(sdhci, 3, "sd-spec-version", &err);
+        object_property_set_uint(sdhci, 0, "timeout-freq", &err);
+        object_property_set_uint(sdhci, 0, "max-frequency", &err);
+        object_property_set_bool(sdhci, true, "suspend", &err);
+        object_property_set_bool(sdhci, false, "adma1", &err);
+        object_property_set_bool(sdhci, true, "64bit", &err);
+        object_property_set_uint(sdhci, 0b111, "bus-speed", &err);
+        object_property_set_uint(sdhci, 0b111, "driver-strength", &err);
+        object_property_set_bool(sdhci, true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
             return;
         }
-        sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci[i]), 0,
-                        sdhci_addr[i]);
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci[i]), 0,
-                           gic_spi[sdhci_intr[i]]);
+        sysbus_mmio_map(sbd, 0, sdhci_addr[i]);
+        sysbus_connect_irq(sbd, 0, gic_spi[sdhci_intr[i]]);
+
         /* Alias controller SD bus to the SoC itself */
-        bus_name = g_strdup_printf("sd-bus%d", i);
-        object_property_add_alias(OBJECT(s), bus_name,
-                                  OBJECT(&s->sdhci[i]), "sd-bus",
+        object_property_add_alias(OBJECT(s), bus_name, sdhci, "sd-bus",
                                   &error_abort);
         g_free(bus_name);
     }
-- 
2.15.1
