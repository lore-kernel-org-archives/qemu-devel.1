Received: from eggs.gnu.org ([2001:4830:134:3::10]:34056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsh-0003bJ-0d
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsg-0007j9-0v
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:35:15 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 15:34:09 -0300
Message-Id: <20180103183418.23730-17-f4bug@amsat.org>
In-Reply-To: <20180103183418.23730-1-f4bug@amsat.org>
References: <20180103183418.23730-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 16/25] hw/arm/bcm2835_peripherals: implement
 SDHCI Spec v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, =?UTF-8?q?Gr=C3=A9gory=20Estrade=20gregory=20=2E=20estrade=20=40=20gmail=20=2E=20com=20Clement=20Deschamps?= <clement.deschamps@antfield.fr>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Ashok kumar <ashoks@broadcom.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 12e0dd11af..b1a7bc1617 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -18,9 +18,6 @@
 /* Peripheral base address on the VC (GPU) system bus */
 #define BCM2835_VC_PERI_BASE 0x7e000000
 
-/* Capabilities for SD controller: no DMA, high-speed, default clocks etc. */
-#define BCM2835_SDHC_CAPAREG 0x52034b4
-
 static void bcm2835_peripherals_init(Object *obj)
 {
     BCM2835PeripheralState *s = BCM2835_PERIPHERALS(obj);
@@ -254,14 +251,30 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->peri_mr, RNG_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng), 0));
 
-    /* Extended Mass Media Controller */
-    object_property_set_int(OBJECT(&s->sdhci), BCM2835_SDHC_CAPAREG, "capareg",
-                            &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-
+    /* Extended Mass Media Controller
+     *
+     * Compatible with:
+     * - SD Host Controller Specification Version 3.0 Draft 1.0
+     * - SDIO Specification Version 3.0
+     * - MMC Specification Version 4.4
+     *
+     * - 32-bit access only
+     * - default clocks
+     * - no DMA
+     * - SD high-speed (SDHS) card
+     * - maximum block size: 1kB
+     *
+     * For the exact details please refer to the Arasan documentation:
+     *   SD3.0_Host_AHB_eMMC4.4_Usersguide_ver5.9_jan11_10.pdf   ¯\_(ツ)_/¯
+     */
+    object_property_set_uint(OBJECT(&s->sdhci), 3, "sd-spec-version", &err);
+    object_property_set_uint(OBJECT(&s->sdhci), 52, "timeout-freq", &err);
+    object_property_set_uint(OBJECT(&s->sdhci), 52, "clock-freq", &err);
+    object_property_set_bool(OBJECT(&s->sdhci), false, "dma", &err);
+    object_property_set_bool(OBJECT(&s->sdhci), true, "1v8", &err);
+    /* FIXME verify/validate with someone from Broadcom?
+    object_property_set_uint(OBJECT(&s->sdhci), 1024, "max-block-length", &err);
+    */
     object_property_set_bool(OBJECT(&s->sdhci), true, "pending-insert-quirk",
                              &err);
     if (err) {
-- 
2.15.1
