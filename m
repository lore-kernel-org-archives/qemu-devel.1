Received: from eggs.gnu.org ([2001:4830:134:3::10]:37470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWb-0002Yx-Ab
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWZ-0004DK-3u
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:05 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cQYWY-00043I-QP
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 06:54:03 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cQYWI-0001Lq-6E
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:53:46 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 11:53:24 +0000
Message-Id: <1483962824-29185-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
References: <1483962824-29185-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/21] i2c: Allow I2C devices to NAK start events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Corey Minyard <cminyard@mvista.com>

Add a return value to the event handler.  Some I2C devices will
NAK if they have no data, so allow them to do this.  This required
the following changes:

Go through all the event handlers and change them to return int
and return 0.

Modify i2c_start_transfer to terminate the transaction on a NAK.

Modify smbus handing to not assert if a NAK occurs on a second
operation, and terminate the transaction and return -1 instead.

Add some information on semantics to I2CSlaveClass.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/i2c/i2c.h | 16 ++++++++++++----
 hw/arm/pxa2xx.c      |  4 +++-
 hw/arm/tosa.c        |  4 +++-
 hw/arm/z2.c          |  4 +++-
 hw/audio/wm8750.c    |  4 +++-
 hw/display/ssd0303.c |  4 +++-
 hw/gpio/max7310.c    |  4 +++-
 hw/i2c/core.c        | 31 +++++++++++++++++++++++++------
 hw/i2c/i2c-ddc.c     |  4 +++-
 hw/i2c/smbus.c       | 13 +++++++++----
 hw/input/lm832x.c    |  4 +++-
 hw/misc/tmp105.c     |  3 ++-
 hw/timer/ds1338.c    |  4 +++-
 hw/timer/twl92230.c  |  4 +++-
 14 files changed, 78 insertions(+), 25 deletions(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index c4085aa..2ce611d 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -32,14 +32,22 @@ typedef struct I2CSlaveClass
     /* Callbacks provided by the device.  */
     int (*init)(I2CSlave *dev);
 
-    /* Master to slave.  */
+    /* Master to slave. Returns non-zero for a NAK, 0 for success. */
     int (*send)(I2CSlave *s, uint8_t data);
 
-    /* Slave to master.  */
+    /*
+     * Slave to master.  This cannot fail, the device should always
+     * return something here.  Negative values probably result in 0xff
+     * and a possible log from the driver, and shouldn't be used.
+     */
     int (*recv)(I2CSlave *s);
 
-    /* Notify the slave of a bus state change.  */
-    void (*event)(I2CSlave *s, enum i2c_event event);
+    /*
+     * Notify the slave of a bus state change.  For start event,
+     * returns non-zero to NAK an operation.  For other events the
+     * return code is not used and should be zero.
+     */
+    int (*event)(I2CSlave *s, enum i2c_event event);
 } I2CSlaveClass;
 
 struct I2CSlave
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index bdcf6bc..d31b457 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1258,7 +1258,7 @@ static void pxa2xx_i2c_update(PXA2xxI2CState *s)
 }
 
 /* These are only stubs now.  */
-static void pxa2xx_i2c_event(I2CSlave *i2c, enum i2c_event event)
+static int pxa2xx_i2c_event(I2CSlave *i2c, enum i2c_event event)
 {
     PXA2xxI2CSlaveState *slave = PXA2XX_I2C_SLAVE(i2c);
     PXA2xxI2CState *s = slave->host;
@@ -1280,6 +1280,8 @@ static void pxa2xx_i2c_event(I2CSlave *i2c, enum i2c_event event)
         break;
     }
     pxa2xx_i2c_update(s);
+
+    return 0;
 }
 
 static int pxa2xx_i2c_rx(I2CSlave *i2c)
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 39d9dbb..c3db996 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -172,7 +172,7 @@ static int tosa_dac_send(I2CSlave *i2c, uint8_t data)
     return 0;
 }
 
-static void tosa_dac_event(I2CSlave *i2c, enum i2c_event event)
+static int tosa_dac_event(I2CSlave *i2c, enum i2c_event event)
 {
     TosaDACState *s = TOSA_DAC(i2c);
 
@@ -194,6 +194,8 @@ static void tosa_dac_event(I2CSlave *i2c, enum i2c_event event)
     default:
         break;
     }
+
+    return 0;
 }
 
 static int tosa_dac_recv(I2CSlave *s)
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index b3a6bbd..1607cbd 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -220,7 +220,7 @@ static int aer915_send(I2CSlave *i2c, uint8_t data)
     return 0;
 }
 
-static void aer915_event(I2CSlave *i2c, enum i2c_event event)
+static int aer915_event(I2CSlave *i2c, enum i2c_event event)
 {
     AER915State *s = AER915(i2c);
 
@@ -238,6 +238,8 @@ static void aer915_event(I2CSlave *i2c, enum i2c_event event)
     default:
         break;
     }
+
+    return 0;
 }
 
 static int aer915_recv(I2CSlave *slave)
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index 0c6500e..f8b5beb 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -303,7 +303,7 @@ static void wm8750_reset(I2CSlave *i2c)
     s->i2c_len = 0;
 }
 
-static void wm8750_event(I2CSlave *i2c, enum i2c_event event)
+static int wm8750_event(I2CSlave *i2c, enum i2c_event event)
 {
     WM8750State *s = WM8750(i2c);
 
@@ -321,6 +321,8 @@ static void wm8750_event(I2CSlave *i2c, enum i2c_event event)
     default:
         break;
     }
+
+    return 0;
 }
 
 #define WM8750_LINVOL	0x00
diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
index d301756..68a80b9 100644
--- a/hw/display/ssd0303.c
+++ b/hw/display/ssd0303.c
@@ -179,7 +179,7 @@ static int ssd0303_send(I2CSlave *i2c, uint8_t data)
     return 0;
 }
 
-static void ssd0303_event(I2CSlave *i2c, enum i2c_event event)
+static int ssd0303_event(I2CSlave *i2c, enum i2c_event event)
 {
     ssd0303_state *s = SSD0303(i2c);
 
@@ -193,6 +193,8 @@ static void ssd0303_event(I2CSlave *i2c, enum i2c_event event)
         /* Nothing to do.  */
         break;
     }
+
+    return 0;
 }
 
 static void ssd0303_update_display(void *opaque)
diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index 1bd5eaf..f82e3e6 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -129,7 +129,7 @@ static int max7310_tx(I2CSlave *i2c, uint8_t data)
     return 0;
 }
 
-static void max7310_event(I2CSlave *i2c, enum i2c_event event)
+static int max7310_event(I2CSlave *i2c, enum i2c_event event)
 {
     MAX7310State *s = MAX7310(i2c);
     s->len = 0;
@@ -147,6 +147,8 @@ static void max7310_event(I2CSlave *i2c, enum i2c_event event)
     default:
         break;
     }
+
+    return 0;
 }
 
 static const VMStateDescription vmstate_max7310 = {
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index e40781e..2c1234c 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -88,18 +88,26 @@ int i2c_bus_busy(I2CBus *bus)
     return !QLIST_EMPTY(&bus->current_devs);
 }
 
+/* TODO: Make this handle multiple masters.  */
 /*
- * Returns non-zero if the address is not valid.  If this is called
- * again without an intervening i2c_end_transfer(), like in the SMBus
- * case where the operation is switched from write to read, this
- * function will not rescan the bus and thus cannot fail.
+ * Start or continue an i2c transaction.  When this is called for the
+ * first time or after an i2c_end_transfer(), if it returns an error
+ * the bus transaction is terminated (or really never started).  If
+ * this is called after another i2c_start_transfer() without an
+ * intervening i2c_end_transfer(), and it returns an error, the
+ * transaction will not be terminated.  The caller must do it.
+ *
+ * This corresponds with the way real hardware works.  The SMBus
+ * protocol uses a start transfer to switch from write to read mode
+ * without releasing the bus.  If that fails, the bus is still
+ * in a transaction.
  */
-/* TODO: Make this handle multiple masters.  */
 int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv)
 {
     BusChild *kid;
     I2CSlaveClass *sc;
     I2CNode *node;
+    bool bus_scanned = false;
 
     if (address == I2C_BROADCAST) {
         /*
@@ -130,6 +138,7 @@ int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv)
                 }
             }
         }
+        bus_scanned = true;
     }
 
     if (QLIST_EMPTY(&bus->current_devs)) {
@@ -137,11 +146,21 @@ int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv)
     }
 
     QLIST_FOREACH(node, &bus->current_devs, next) {
+        int rv;
+
         sc = I2C_SLAVE_GET_CLASS(node->elt);
         /* If the bus is already busy, assume this is a repeated
            start condition.  */
+
         if (sc->event) {
-            sc->event(node->elt, recv ? I2C_START_RECV : I2C_START_SEND);
+            rv = sc->event(node->elt, recv ? I2C_START_RECV : I2C_START_SEND);
+            if (rv && !bus->broadcast) {
+                if (bus_scanned) {
+                    /* First call, terminate the transfer. */
+                    i2c_end_transfer(bus);
+                }
+                return rv;
+            }
         }
     }
     return 0;
diff --git a/hw/i2c/i2c-ddc.c b/hw/i2c/i2c-ddc.c
index 1227212..66899d7 100644
--- a/hw/i2c/i2c-ddc.c
+++ b/hw/i2c/i2c-ddc.c
@@ -230,13 +230,15 @@ static void i2c_ddc_reset(DeviceState *ds)
     s->reg = 0;
 }
 
-static void i2c_ddc_event(I2CSlave *i2c, enum i2c_event event)
+static int i2c_ddc_event(I2CSlave *i2c, enum i2c_event event)
 {
     I2CDDCState *s = I2CDDC(i2c);
 
     if (event == I2C_START_SEND) {
         s->firstbyte = true;
     }
+
+    return 0;
 }
 
 static int i2c_ddc_rx(I2CSlave *i2c)
diff --git a/hw/i2c/smbus.c b/hw/i2c/smbus.c
index 5b4dd3e..2d1b79a 100644
--- a/hw/i2c/smbus.c
+++ b/hw/i2c/smbus.c
@@ -67,7 +67,7 @@ static void smbus_do_write(SMBusDevice *dev)
     }
 }
 
-static void smbus_i2c_event(I2CSlave *s, enum i2c_event event)
+static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
 {
     SMBusDevice *dev = SMBUS_DEVICE(s);
 
@@ -148,6 +148,8 @@ static void smbus_i2c_event(I2CSlave *s, enum i2c_event event)
             break;
         }
     }
+
+    return 0;
 }
 
 static int smbus_i2c_recv(I2CSlave *s)
@@ -249,7 +251,8 @@ int smbus_read_byte(I2CBus *bus, uint8_t addr, uint8_t command)
     }
     i2c_send(bus, command);
     if (i2c_start_transfer(bus, addr, 1)) {
-        assert(0);
+        i2c_end_transfer(bus);
+        return -1;
     }
     data = i2c_recv(bus);
     i2c_nack(bus);
@@ -276,7 +279,8 @@ int smbus_read_word(I2CBus *bus, uint8_t addr, uint8_t command)
     }
     i2c_send(bus, command);
     if (i2c_start_transfer(bus, addr, 1)) {
-        assert(0);
+        i2c_end_transfer(bus);
+        return -1;
     }
     data = i2c_recv(bus);
     data |= i2c_recv(bus) << 8;
@@ -307,7 +311,8 @@ int smbus_read_block(I2CBus *bus, uint8_t addr, uint8_t command, uint8_t *data)
     }
     i2c_send(bus, command);
     if (i2c_start_transfer(bus, addr, 1)) {
-        assert(0);
+        i2c_end_transfer(bus);
+        return -1;
     }
     len = i2c_recv(bus);
     if (len > 32) {
diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index 539682c..2340523 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -383,7 +383,7 @@ static void lm_kbd_write(LM823KbdState *s, int reg, int byte, uint8_t value)
     }
 }
 
-static void lm_i2c_event(I2CSlave *i2c, enum i2c_event event)
+static int lm_i2c_event(I2CSlave *i2c, enum i2c_event event)
 {
     LM823KbdState *s = LM8323(i2c);
 
@@ -397,6 +397,8 @@ static void lm_i2c_event(I2CSlave *i2c, enum i2c_event event)
     default:
         break;
     }
+
+    return 0;
 }
 
 static int lm_i2c_rx(I2CSlave *i2c)
diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index f5c2472..04e8378 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -176,7 +176,7 @@ static int tmp105_tx(I2CSlave *i2c, uint8_t data)
     return 0;
 }
 
-static void tmp105_event(I2CSlave *i2c, enum i2c_event event)
+static int tmp105_event(I2CSlave *i2c, enum i2c_event event)
 {
     TMP105State *s = TMP105(i2c);
 
@@ -185,6 +185,7 @@ static void tmp105_event(I2CSlave *i2c, enum i2c_event event)
     }
 
     s->len = 0;
+    return 0;
 }
 
 static int tmp105_post_load(void *opaque, int version_id)
diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
index f5d04dd..3849b74 100644
--- a/hw/timer/ds1338.c
+++ b/hw/timer/ds1338.c
@@ -94,7 +94,7 @@ static void inc_regptr(DS1338State *s)
     }
 }
 
-static void ds1338_event(I2CSlave *i2c, enum i2c_event event)
+static int ds1338_event(I2CSlave *i2c, enum i2c_event event)
 {
     DS1338State *s = DS1338(i2c);
 
@@ -113,6 +113,8 @@ static void ds1338_event(I2CSlave *i2c, enum i2c_event event)
     default:
         break;
     }
+
+    return 0;
 }
 
 static int ds1338_recv(I2CSlave *i2c)
diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
index 7ba4e9a..b8d914e 100644
--- a/hw/timer/twl92230.c
+++ b/hw/timer/twl92230.c
@@ -713,12 +713,14 @@ static void menelaus_write(void *opaque, uint8_t addr, uint8_t value)
     }
 }
 
-static void menelaus_event(I2CSlave *i2c, enum i2c_event event)
+static int menelaus_event(I2CSlave *i2c, enum i2c_event event)
 {
     MenelausState *s = TWL92230(i2c);
 
     if (event == I2C_START_SEND)
         s->firstbyte = 1;
+
+    return 0;
 }
 
 static int menelaus_tx(I2CSlave *i2c, uint8_t data)
-- 
2.7.4
