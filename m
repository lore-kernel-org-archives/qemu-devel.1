Received: from eggs.gnu.org ([2001:4830:134:3::10]:50456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGln-000337-Hb
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlm-0004F2-D0
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:31 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlm-00046X-5S
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:30 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGle-0003d5-Sg
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:22 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:44:52 +0100
Message-Id: <20180608124517.29475-7-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/31] aspeed: Add EEPROM I2C devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

The Aspeed boards have at least one EEPROM to hold the Vital Product
Data (VPD).

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 20180530064049.27976-6-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 73b482226ff..5d0ed3391e0 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -17,6 +17,7 @@
 #include "hw/arm/arm.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/boards.h"
+#include "hw/i2c/smbus.h"
 #include "qemu/log.h"
 #include "sysemu/block-backend.h"
 #include "hw/loader.h"
@@ -263,11 +264,15 @@ static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
     DeviceState *dev;
+    uint8_t *eeprom_buf = g_malloc0(32 * 1024);
 
     /* The palmetto platform expects a ds3231 RTC but a ds1338 is
      * enough to provide basic RTC features. Alarms will be missing */
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), "ds1338", 0x68);
 
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), 0x50,
+                          eeprom_buf);
+
     /* add a TMP423 temperature sensor */
     dev = i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2),
                            "tmp423", 0x4c);
@@ -304,6 +309,10 @@ static const TypeInfo palmetto_bmc_type = {
 static void ast2500_evb_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
+    uint8_t *eeprom_buf = g_malloc0(8 * 1024);
+
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), 0x50,
+                          eeprom_buf);
 
     /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "tmp105", 0x4d);
@@ -373,6 +382,7 @@ static const TypeInfo romulus_bmc_type = {
 static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
+    uint8_t *eeprom_buf = g_malloc0(8 * 1024);
 
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423", 0x4c);
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423", 0x4c);
@@ -383,6 +393,9 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
     /* The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
      * good enough */
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
+
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), 0x51,
+                          eeprom_buf);
 }
 
 static void witherspoon_bmc_init(MachineState *machine)
-- 
2.17.1
