Received: from eggs.gnu.org ([2001:4830:134:3::10]:33122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTb-0005Gk-19
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTZ-0006gt-Lt
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:22 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dKmTZ-0006fN-Eo
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:21 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTU-00014f-2I
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:07:16 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 15:07:01 +0100
Message-Id: <1497362826-21125-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
References: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/17] aspeed: add a temp sensor device on I2C
 bus 3
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

Temperatures can be changed from the monitor with :

	(qemu) qom-set /machine/unattached/device[2] temperature0 12000

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 1496739230-32109-3-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index e824ea8..155eeb2 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -239,10 +239,19 @@ static void aspeed_board_init(MachineState *machine,
 static void palmetto_bmc_i2c_init(AspeedBoardState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
+    DeviceState *dev;
 
     /* The palmetto platform expects a ds3231 RTC but a ds1338 is
      * enough to provide basic RTC features. Alarms will be missing */
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), "ds1338", 0x68);
+
+    /* add a TMP423 temperature sensor */
+    dev = i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2),
+                           "tmp423", 0x4c);
+    object_property_set_int(OBJECT(dev), 31000, "temperature0", &error_abort);
+    object_property_set_int(OBJECT(dev), 28000, "temperature1", &error_abort);
+    object_property_set_int(OBJECT(dev), 20000, "temperature2", &error_abort);
+    object_property_set_int(OBJECT(dev), 110000, "temperature3", &error_abort);
 }
 
 static void palmetto_bmc_init(MachineState *machine)
-- 
2.7.4
