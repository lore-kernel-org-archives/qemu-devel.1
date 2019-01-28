Received: from eggs.gnu.org ([209.51.188.92]:36956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBEG-000396-Bs
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goB7t-0005XV-HN
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:30 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1goB7t-0005Wt-3U
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:17 -0500
Received: by mail-pl1-x644.google.com with SMTP id u18so8063315plq.7
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:55:16 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Jan 2019 11:54:41 -0600
Message-Id: <20190128175458.27255-3-minyard@acm.org>
In-Reply-To: <20190128175458.27255-1-minyard@acm.org>
References: <20190128175458.27255-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 02/19] i2c: have I2C receive operation
 return uint8_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

It is never supposed to fail and cannot return an error, so just
have it return the proper type.  Have it return 0xff on nothing
available, since that's what would happen on a real bus.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/pxa2xx.c         |  2 +-
 hw/arm/tosa.c           |  4 ++--
 hw/arm/z2.c             |  2 +-
 hw/audio/wm8750.c       |  2 +-
 hw/display/sii9022.c    |  2 +-
 hw/display/ssd0303.c    |  4 ++--
 hw/gpio/max7310.c       |  2 +-
 hw/i2c/core.c           | 32 +++++++++++++-------------------
 hw/i2c/i2c-ddc.c        |  2 +-
 hw/i2c/smbus_slave.c    |  4 ++--
 hw/input/lm832x.c       |  2 +-
 hw/misc/pca9552.c       |  2 +-
 hw/misc/tmp105.c        |  2 +-
 hw/misc/tmp421.c        |  2 +-
 hw/nvram/eeprom_at24c.c |  4 ++--
 hw/timer/ds1338.c       |  2 +-
 hw/timer/m41t80.c       |  2 +-
 hw/timer/twl92230.c     |  2 +-
 include/hw/i2c/i2c.h    |  7 +++----
 19 files changed, 37 insertions(+), 44 deletions(-)

diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index f598a1c053..3d7c88910e 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1286,7 +1286,7 @@ static int pxa2xx_i2c_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
-static int pxa2xx_i2c_rx(I2CSlave *i2c)
+static uint8_t pxa2xx_i2c_rx(I2CSlave *i2c)
 {
     PXA2xxI2CSlaveState *slave = PXA2XX_I2C_SLAVE(i2c);
     PXA2xxI2CState *s = slave->host;
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 7a925fa5e6..eef9d427e7 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -197,10 +197,10 @@ static int tosa_dac_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
-static int tosa_dac_recv(I2CSlave *s)
+static uint8_t tosa_dac_recv(I2CSlave *s)
 {
     printf("%s: recv not supported!!!\n", __func__);
-    return -1;
+    return 0xff;
 }
 
 static void tosa_tg_init(PXA2xxState *cpu)
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 697a822f1e..6f18d924df 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -243,7 +243,7 @@ static int aer915_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
-static int aer915_recv(I2CSlave *slave)
+static uint8_t aer915_recv(I2CSlave *slave)
 {
     AER915State *s = AER915(slave);
     int retval = 0x00;
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index f4aa838f62..169b006ade 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -561,7 +561,7 @@ static int wm8750_tx(I2CSlave *i2c, uint8_t data)
     return 0;
 }
 
-static int wm8750_rx(I2CSlave *i2c)
+static uint8_t wm8750_rx(I2CSlave *i2c)
 {
     return 0x00;
 }
diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
index eaf11a6e7b..9994385c35 100644
--- a/hw/display/sii9022.c
+++ b/hw/display/sii9022.c
@@ -79,7 +79,7 @@ static int sii9022_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
-static int sii9022_rx(I2CSlave *i2c)
+static uint8_t sii9022_rx(I2CSlave *i2c)
 {
     sii9022_state *s = SII9022(i2c);
     uint8_t res = 0x00;
diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
index eb90ba26be..8edf34986c 100644
--- a/hw/display/ssd0303.c
+++ b/hw/display/ssd0303.c
@@ -62,10 +62,10 @@ typedef struct {
     uint8_t framebuffer[132*8];
 } ssd0303_state;
 
-static int ssd0303_recv(I2CSlave *i2c)
+static uint8_t ssd0303_recv(I2CSlave *i2c)
 {
     BADF("Reads not implemented\n");
-    return -1;
+    return 0xff;
 }
 
 static int ssd0303_send(I2CSlave *i2c, uint8_t data)
diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index 1a2478b5a9..c6f686c3eb 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -39,7 +39,7 @@ static void max7310_reset(DeviceState *dev)
     s->command = 0x00;
 }
 
-static int max7310_rx(I2CSlave *i2c)
+static uint8_t max7310_rx(I2CSlave *i2c)
 {
     MAX7310State *s = MAX7310(i2c);
 
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index b54725985a..15237ad073 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -191,23 +191,17 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send)
         }
         return ret ? -1 : 0;
     } else {
-        if ((QLIST_EMPTY(&bus->current_devs)) || (bus->broadcast)) {
-            return -1;
-        }
-
-        sc = I2C_SLAVE_GET_CLASS(QLIST_FIRST(&bus->current_devs)->elt);
-        if (sc->recv) {
-            s = QLIST_FIRST(&bus->current_devs)->elt;
-            ret = sc->recv(s);
-            trace_i2c_recv(s->address, ret);
-            if (ret < 0) {
-                return ret;
-            } else {
-                *data = ret;
-                return 0;
+        ret = 0xff;
+        if (!QLIST_EMPTY(&bus->current_devs) && !bus->broadcast) {
+            sc = I2C_SLAVE_GET_CLASS(QLIST_FIRST(&bus->current_devs)->elt);
+            if (sc->recv) {
+                s = QLIST_FIRST(&bus->current_devs)->elt;
+                ret = sc->recv(s);
+                trace_i2c_recv(s->address, ret);
             }
         }
-        return -1;
+        *data = ret;
+        return 0;
     }
 }
 
@@ -216,12 +210,12 @@ int i2c_send(I2CBus *bus, uint8_t data)
     return i2c_send_recv(bus, &data, true);
 }
 
-int i2c_recv(I2CBus *bus)
+uint8_t i2c_recv(I2CBus *bus)
 {
-    uint8_t data;
-    int ret = i2c_send_recv(bus, &data, false);
+    uint8_t data = 0xff;
 
-    return ret < 0 ? ret : data;
+    i2c_send_recv(bus, &data, false);
+    return data;
 }
 
 void i2c_nack(I2CBus *bus)
diff --git a/hw/i2c/i2c-ddc.c b/hw/i2c/i2c-ddc.c
index 0a0367ff38..7aa8727771 100644
--- a/hw/i2c/i2c-ddc.c
+++ b/hw/i2c/i2c-ddc.c
@@ -51,7 +51,7 @@ static int i2c_ddc_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
-static int i2c_ddc_rx(I2CSlave *i2c)
+static uint8_t i2c_ddc_rx(I2CSlave *i2c)
 {
     I2CDDCState *s = I2CDDC(i2c);
 
diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 463fafe3c5..6e4d542f51 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -156,11 +156,11 @@ static int smbus_i2c_event(I2CSlave *s, enum i2c_event event)
     return 0;
 }
 
-static int smbus_i2c_recv(I2CSlave *s)
+static uint8_t smbus_i2c_recv(I2CSlave *s)
 {
     SMBusDevice *dev = SMBUS_DEVICE(s);
     SMBusDeviceClass *sc = SMBUS_DEVICE_GET_CLASS(dev);
-    int ret;
+    uint8_t ret;
 
     switch (dev->mode) {
     case SMBUS_RECV_BYTE:
diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index cffbf586d4..1fc7b86f19 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -401,7 +401,7 @@ static int lm_i2c_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
-static int lm_i2c_rx(I2CSlave *i2c)
+static uint8_t lm_i2c_rx(I2CSlave *i2c)
 {
     LM823KbdState *s = LM8323(i2c);
 
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 9775d5274a..7325d3f287 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -115,7 +115,7 @@ static void pca9552_autoinc(PCA9552State *s)
     }
 }
 
-static int pca9552_recv(I2CSlave *i2c)
+static uint8_t pca9552_recv(I2CSlave *i2c)
 {
     PCA9552State *s = PCA9552(i2c);
     uint8_t ret;
diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index f6d7163273..0c32f6f8b6 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -147,7 +147,7 @@ static void tmp105_write(TMP105State *s)
     }
 }
 
-static int tmp105_rx(I2CSlave *i2c)
+static uint8_t tmp105_rx(I2CSlave *i2c)
 {
     TMP105State *s = TMP105(i2c);
 
diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index eeb11000f0..ce6d40ac9c 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -249,7 +249,7 @@ static void tmp421_write(TMP421State *s)
     }
 }
 
-static int tmp421_rx(I2CSlave *i2c)
+static uint8_t tmp421_rx(I2CSlave *i2c)
 {
     TMP421State *s = TMP421(i2c);
 
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 27cd01e615..d1456dafbd 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -74,10 +74,10 @@ int at24c_eeprom_event(I2CSlave *s, enum i2c_event event)
 }
 
 static
-int at24c_eeprom_recv(I2CSlave *s)
+uint8_t at24c_eeprom_recv(I2CSlave *s)
 {
     EEPROMState *ee = AT24C_EE(s);
-    int ret;
+    uint8_t ret;
 
     ret = ee->mem[ee->cur];
 
diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
index 3849b74a68..03da75486b 100644
--- a/hw/timer/ds1338.c
+++ b/hw/timer/ds1338.c
@@ -117,7 +117,7 @@ static int ds1338_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
-static int ds1338_recv(I2CSlave *i2c)
+static uint8_t ds1338_recv(I2CSlave *i2c)
 {
     DS1338State *s = DS1338(i2c);
     uint8_t res;
diff --git a/hw/timer/m41t80.c b/hw/timer/m41t80.c
index 734d7d95fc..c45b9297d8 100644
--- a/hw/timer/m41t80.c
+++ b/hw/timer/m41t80.c
@@ -40,7 +40,7 @@ static int m41t80_send(I2CSlave *i2c, uint8_t data)
     return 0;
 }
 
-static int m41t80_recv(I2CSlave *i2c)
+static uint8_t m41t80_recv(I2CSlave *i2c)
 {
     M41t80State *s = M41T80(i2c);
     struct tm now;
diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
index 51ec355f3f..c83d803dd8 100644
--- a/hw/timer/twl92230.c
+++ b/hw/timer/twl92230.c
@@ -737,7 +737,7 @@ static int menelaus_tx(I2CSlave *i2c, uint8_t data)
     return 0;
 }
 
-static int menelaus_rx(I2CSlave *i2c)
+static uint8_t menelaus_rx(I2CSlave *i2c)
 {
     MenelausState *s = TWL92230(i2c);
 
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index cf4c45a98f..8e236f7bb4 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -33,10 +33,9 @@ typedef struct I2CSlaveClass {
 
     /*
      * Slave to master.  This cannot fail, the device should always
-     * return something here.  Negative values probably result in 0xff
-     * and a possible log from the driver, and shouldn't be used.
+     * return something here.
      */
-    int (*recv)(I2CSlave *s);
+    uint8_t (*recv)(I2CSlave *s);
 
     /*
      * Notify the slave of a bus state change.  For start event,
@@ -78,7 +77,7 @@ void i2c_end_transfer(I2CBus *bus);
 void i2c_nack(I2CBus *bus);
 int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send);
 int i2c_send(I2CBus *bus, uint8_t data);
-int i2c_recv(I2CBus *bus);
+uint8_t i2c_recv(I2CBus *bus);
 
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
 
-- 
2.17.1
