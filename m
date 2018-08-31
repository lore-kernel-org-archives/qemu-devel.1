Received: from eggs.gnu.org ([2001:4830:134:3::10]:46252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvgpw-0003G7-65
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fvgps-0002Em-Sr
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:39:32 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:40876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fvgps-0002DZ-LD
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:39:28 -0400
Received: from player168.ha.ovh.net (unknown [10.109.159.68])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 327EB156B23
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 12:39:27 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Fri, 31 Aug 2018 12:38:14 +0200
Message-Id: <20180831103816.13479-8-clg@kaod.org>
In-Reply-To: <20180831103816.13479-1-clg@kaod.org>
References: <20180831103816.13479-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/11] aspeed/smc: add a 'sdram_base' and
 'max-ram-size' properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The setting of the DRAM address of the DMA transaction depends on the
DRAM base address and the maximun DRAM size of the SoC. Let's add a
couple of properties to give this information to the SMC controller
model.

Also, move the SDRAM Memory controller realization before the other
controllers which need it.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ssi/aspeed_smc.h |  4 ++++
 hw/arm/aspeed_soc.c         | 28 +++++++++++++++++++---------
 hw/ssi/aspeed_smc.c         |  2 ++
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 1f557313fa93..d7090bb5e9b7 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -97,6 +97,10 @@ typedef struct AspeedSMCState {
     uint8_t r_timings;
     uint8_t conf_enable_w0;
=20
+    /* for DMA support */
+    uint64_t sdram_base;
+    uint64_t max_ram_size;
+
     AspeedSMCFlash *flashes;
 } AspeedSMCState;
=20
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 2cbacb4430bb..bbc05d172fe1 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -209,6 +209,14 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, ASPEED_SOC_SCU_BASE);
=20
+    /* SDMC - SDRAM Memory Controller */
+    object_property_set_bool(OBJECT(&s->sdmc), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, ASPEED_SOC_SDMC_BASE);
+
     /* VIC */
     object_property_set_bool(OBJECT(&s->vic), true, "realized", &err);
     if (err) {
@@ -252,7 +260,17 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
                        qdev_get_gpio_in(DEVICE(&s->vic), 12));
=20
     /* FMC, The number of CS is set at the board level */
-    object_property_set_bool(OBJECT(&s->fmc), true, "realized", &err);
+    object_property_set_int(OBJECT(&s->fmc), sc->info->sdram_base, "sdra=
m-base",
+                            &err);
+    object_property_set_int(OBJECT(&s->fmc), s->sdmc.max_ram_size,
+                            "max-ram-size", &local_err);
+    error_propagate(&err, local_err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_bool(OBJECT(&s->fmc), true, "realized", &local_e=
rr);
+    error_propagate(&err, local_err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -278,14 +296,6 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
                         s->spi[i].ctrl->flash_window_base);
     }
=20
-    /* SDMC - SDRAM Memory Controller */
-    object_property_set_bool(OBJECT(&s->sdmc), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, ASPEED_SOC_SDMC_BASE);
-
     /* Watch dog */
     for (i =3D 0; i < sc->info->wdts_num; i++) {
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &=
err);
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 6045ca11b969..500de6d16d09 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -800,6 +800,8 @@ static const VMStateDescription vmstate_aspeed_smc =3D=
 {
=20
 static Property aspeed_smc_properties[] =3D {
     DEFINE_PROP_UINT32("num-cs", AspeedSMCState, num_cs, 1),
+    DEFINE_PROP_UINT64("sdram-base", AspeedSMCState, sdram_base, 0),
+    DEFINE_PROP_UINT64("max-ram-size", AspeedSMCState, max_ram_size, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.17.1
