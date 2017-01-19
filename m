Received: from eggs.gnu.org ([2001:4830:134:3::10]:47642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPv-00012J-EP
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPt-0005Fw-1s
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:19 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPs-00055o-Qi
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:16 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPY-00033a-IL
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:09:56 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:20 +0000
Message-Id: <1484834995-26826-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/36] arm: Uniquely name imx25 I2C buses.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alastair D'Silva <alastair@d-silva.org>

The imx25 chip provides 3 i2c buses, but they have all been named
"i2c", which makes it difficult to predict which bus a device will
be connected to when specified on the command line.

This patch addresses the issue by naming the buses uniquely:
  i2c-bus.0 i2c-bus.1 i2c-bus.2

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Message-id: 20170105043430.3176-2-alastair@au1.ibm.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/imx25_pdk.c | 2 +-
 hw/i2c/imx_i2c.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 025b608..44e741f 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -139,7 +139,7 @@ static void imx25_pdk_init(MachineState *machine)
          * of simple qtest. See "make check" for details.
          */
         i2c_create_slave((I2CBus *)qdev_get_child_bus(DEVICE(&s->soc.i2c[0]),
-                                                      "i2c"),
+                                                      "i2c-bus.0"),
                          "ds1338", 0x68);
     }
 }
diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index 37e5a62..6c81b98 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -310,7 +310,7 @@ static void imx_i2c_realize(DeviceState *dev, Error **errp)
                           IMX_I2C_MEM_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
-    s->bus = i2c_init_bus(DEVICE(dev), "i2c");
+    s->bus = i2c_init_bus(DEVICE(dev), NULL);
 }
 
 static void imx_i2c_class_init(ObjectClass *klass, void *data)
-- 
2.7.4
