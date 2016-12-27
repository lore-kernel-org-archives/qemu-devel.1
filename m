Received: from eggs.gnu.org ([2001:4830:134:3::10]:35669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaZ-0002ry-0M
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaX-0001Tm-Q8
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:55 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtaX-0001TX-Io
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:53 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaW-0003yY-O3
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:22:52 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:16 +0000
Message-Id: <1482852077-19397-25-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 24/25] hw/i2c: Add a NULL check for i2c slave
 init callbacks
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

Add a NULL check for i2c slave init callbacks, so that we no longer
need to implement empty init functions.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Message-id: 20161202054617.6749-4-alastair@au1.ibm.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: squashed in later tweak from Alistair to if() phrasing]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/pxa2xx.c   | 7 -------
 hw/arm/tosa.c     | 7 -------
 hw/arm/z2.c       | 7 -------
 hw/i2c/core.c     | 6 +++++-
 hw/timer/ds1338.c | 6 ------
 5 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 8aa0f8a..bdcf6bc 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1449,17 +1449,10 @@ static const VMStateDescription vmstate_pxa2xx_i2c = {
     }
 };
 
-static int pxa2xx_i2c_slave_init(I2CSlave *i2c)
-{
-    /* Nothing to do.  */
-    return 0;
-}
-
 static void pxa2xx_i2c_slave_class_init(ObjectClass *klass, void *data)
 {
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
-    k->init = pxa2xx_i2c_slave_init;
     k->event = pxa2xx_i2c_event;
     k->recv = pxa2xx_i2c_rx;
     k->send = pxa2xx_i2c_tx;
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 1ee12f4..39d9dbb 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -202,12 +202,6 @@ static int tosa_dac_recv(I2CSlave *s)
     return -1;
 }
 
-static int tosa_dac_init(I2CSlave *i2c)
-{
-    /* Nothing to do.  */
-    return 0;
-}
-
 static void tosa_tg_init(PXA2xxState *cpu)
 {
     I2CBus *bus = pxa2xx_i2c_bus(cpu->i2c[0]);
@@ -275,7 +269,6 @@ static void tosa_dac_class_init(ObjectClass *klass, void *data)
 {
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
-    k->init = tosa_dac_init;
     k->event = tosa_dac_event;
     k->recv = tosa_dac_recv;
     k->send = tosa_dac_send;
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 68a92f3..b3a6bbd 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -263,12 +263,6 @@ static int aer915_recv(I2CSlave *slave)
     return retval;
 }
 
-static int aer915_init(I2CSlave *i2c)
-{
-    /* Nothing to do.  */
-    return 0;
-}
-
 static VMStateDescription vmstate_aer915_state = {
     .name = "aer915",
     .version_id = 1,
@@ -285,7 +279,6 @@ static void aer915_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
-    k->init = aer915_init;
     k->event = aer915_event;
     k->recv = aer915_recv;
     k->send = aer915_send;
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index abd4c4c..e40781e 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -260,7 +260,11 @@ static int i2c_slave_qdev_init(DeviceState *dev)
     I2CSlave *s = I2C_SLAVE(dev);
     I2CSlaveClass *sc = I2C_SLAVE_GET_CLASS(s);
 
-    return sc->init(s);
+    if (sc->init) {
+        return sc->init(s);
+    }
+
+    return 0;
 }
 
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
index 0112949..f5d04dd 100644
--- a/hw/timer/ds1338.c
+++ b/hw/timer/ds1338.c
@@ -198,11 +198,6 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
     return 0;
 }
 
-static int ds1338_init(I2CSlave *i2c)
-{
-    return 0;
-}
-
 static void ds1338_reset(DeviceState *dev)
 {
     DS1338State *s = DS1338(dev);
@@ -220,7 +215,6 @@ static void ds1338_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
-    k->init = ds1338_init;
     k->event = ds1338_event;
     k->recv = ds1338_recv;
     k->send = ds1338_send;
-- 
2.7.4
