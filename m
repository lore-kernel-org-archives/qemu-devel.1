Received: from eggs.gnu.org ([2001:4830:134:3::10]:59316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUsS6-0007e2-Tk
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dUsS3-0006FG-M6
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:31:34 -0400
Received: from orth.archaic.org.uk ([81.2.115.148]:48421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dUsS3-000683-De
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:31:31 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dUsPq-0002xq-0s
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:29:14 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 11:29:10 +0100
Message-Id: <1499768952-24990-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1499768952-24990-1-git-send-email-peter.maydell@linaro.org>
References: <1499768952-24990-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/4] aspeed: Register all watchdogs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Joel Stanley <joel@jms.id.au>

The ast2400 contains two and the ast2500 contains three watchdogs.
Add this information to the AspeedSoCInfo and realise the correct number
of watchdogs for that each SoC type.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  4 +++-
 hw/arm/aspeed_soc.c         | 25 +++++++++++++++++--------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 4c5fc66..0b88baa 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -23,6 +23,7 @@
 #include "hw/net/ftgmac100.h"
 
 #define ASPEED_SPIS_NUM  2
+#define ASPEED_WDTS_NUM  3
 
 typedef struct AspeedSoCState {
     /*< private >*/
@@ -39,7 +40,7 @@ typedef struct AspeedSoCState {
     AspeedSMCState fmc;
     AspeedSMCState spi[ASPEED_SPIS_NUM];
     AspeedSDMCState sdmc;
-    AspeedWDTState wdt;
+    AspeedWDTState wdt[ASPEED_WDTS_NUM];
     FTGMAC100State ftgmac100;
 } AspeedSoCState;
 
@@ -56,6 +57,7 @@ typedef struct AspeedSoCInfo {
     const hwaddr *spi_bases;
     const char *fmc_typename;
     const char **spi_typename;
+    int wdts_num;
 } AspeedSoCInfo;
 
 typedef struct AspeedSoCClass {
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 4937e2b..3034849 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -62,6 +62,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .spi_bases    = aspeed_soc_ast2400_spi_bases,
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
+        .wdts_num     = 2,
     }, {
         .name         = "ast2400-a1",
         .cpu_model    = "arm926",
@@ -72,6 +73,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .spi_bases    = aspeed_soc_ast2400_spi_bases,
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
+        .wdts_num     = 2,
     }, {
         .name         = "ast2400",
         .cpu_model    = "arm926",
@@ -82,6 +84,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .spi_bases    = aspeed_soc_ast2400_spi_bases,
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
+        .wdts_num     = 2,
     }, {
         .name         = "ast2500-a1",
         .cpu_model    = "arm1176",
@@ -92,6 +95,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .spi_bases    = aspeed_soc_ast2500_spi_bases,
         .fmc_typename = "aspeed.smc.ast2500-fmc",
         .spi_typename = aspeed_soc_ast2500_typenames,
+        .wdts_num     = 3,
     },
 };
 
@@ -175,9 +179,11 @@ static void aspeed_soc_init(Object *obj)
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
                               "ram-size", &error_abort);
 
-    object_initialize(&s->wdt, sizeof(s->wdt), TYPE_ASPEED_WDT);
-    object_property_add_child(obj, "wdt", OBJECT(&s->wdt), NULL);
-    qdev_set_parent_bus(DEVICE(&s->wdt), sysbus_get_default());
+    for (i = 0; i < sc->info->wdts_num; i++) {
+        object_initialize(&s->wdt[i], sizeof(s->wdt[i]), TYPE_ASPEED_WDT);
+        object_property_add_child(obj, "wdt[*]", OBJECT(&s->wdt[i]), NULL);
+        qdev_set_parent_bus(DEVICE(&s->wdt[i]), sysbus_get_default());
+    }
 
     object_initialize(&s->ftgmac100, sizeof(s->ftgmac100), TYPE_FTGMAC100);
     object_property_add_child(obj, "ftgmac100", OBJECT(&s->ftgmac100), NULL);
@@ -300,12 +306,15 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, ASPEED_SOC_SDMC_BASE);
 
     /* Watch dog */
-    object_property_set_bool(OBJECT(&s->wdt), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
+    for (i = 0; i < sc->info->wdts_num; i++) {
+        object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
+                        ASPEED_SOC_WDT_BASE + i * 0x20);
     }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, ASPEED_SOC_WDT_BASE);
 
     /* Net */
     qdev_set_nic_properties(DEVICE(&s->ftgmac100), &nd_table[0]);
-- 
2.7.4
