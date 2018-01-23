Received: from eggs.gnu.org ([2001:4830:134:3::10]:60153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edovO-0000o4-CO
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edovN-0004nl-C5
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:07:02 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Jan 2018 00:06:23 -0300
Message-Id: <20180123030630.26613-8-f4bug@amsat.org>
In-Reply-To: <20180123030630.26613-1-f4bug@amsat.org>
References: <20180123030630.26613-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 07/14] hw/arm/bcm2835_peripherals: implement
 SDHCI Spec. v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 12e0dd11af..0570cc4ad3 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -254,14 +254,19 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
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
+     * For the exact details please refer to the Arasan documentation:
+     *   SD3.0_Host_AHB_eMMC4.4_Usersguide_ver5.9_jan11_10.pdf   ¯\_(ツ)_/¯
+     */
+    object_property_set_uint(OBJECT(&s->sdhci), 3, "sd-spec-version", &err);
+    object_property_set_uint(OBJECT(&s->sdhci), BCM2835_SDHC_CAPAREG, "capareg",
+                             &err);
     object_property_set_bool(OBJECT(&s->sdhci), true, "pending-insert-quirk",
                              &err);
     if (err) {
-- 
2.15.1
