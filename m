Received: from eggs.gnu.org ([2001:4830:134:3::10]:53370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9H5k-0002ZP-AW
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9H5i-0007ro-RK
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:27:44 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:45000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9H5i-0007rb-LX
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:27:42 -0400
Received: by mail-qk0-x243.google.com with SMTP id h200so6325788qke.11
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:27:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 19 Apr 2018 18:27:25 -0300
Message-Id: <20180419212727.26095-3-f4bug@amsat.org>
In-Reply-To: <20180419212727.26095-1-f4bug@amsat.org>
References: <20180419212727.26095-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 2/4] hw/i2c: Use DeviceClass::realize
 instead of I2CSlaveClass::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

I2CSlaveClass::init is no more used, remove it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i2c/i2c.h    |  3 ---
 hw/audio/wm8750.c       |  8 +++-----
 hw/display/ssd0303.c    |  9 ++++-----
 hw/gpio/max7310.c       |  9 ++++-----
 hw/i2c/core.c           | 13 -------------
 hw/input/lm832x.c       |  9 ++++-----
 hw/misc/tmp105.c        |  7 +++----
 hw/misc/tmp421.c        |  8 +++-----
 hw/nvram/eeprom_at24c.c | 24 +++++++++++-------------
 hw/timer/twl92230.c     | 11 ++++-------
 10 files changed, 36 insertions(+), 65 deletions(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index d727379b48..5dc166158b 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -28,9 +28,6 @@ typedef struct I2CSlave I2CSlave;
 typedef struct I2CSlaveClass {
     DeviceClass parent_class;
 
-    /* Callbacks provided by the device.  */
-    int (*init)(I2CSlave *dev);
-
     /* Master to slave. Returns non-zero for a NAK, 0 for success. */
     int (*send)(I2CSlave *s, uint8_t data);
 
diff --git a/hw/audio/wm8750.c b/hw/audio/wm8750.c
index 416a78e869..f4aa838f62 100644
--- a/hw/audio/wm8750.c
+++ b/hw/audio/wm8750.c
@@ -617,14 +617,12 @@ static const VMStateDescription vmstate_wm8750 = {
     }
 };
 
-static int wm8750_init(I2CSlave *i2c)
+static void wm8750_realize(DeviceState *dev, Error **errp)
 {
-    WM8750State *s = WM8750(i2c);
+    WM8750State *s = WM8750(dev);
 
     AUD_register_card(CODEC, &s->card);
     wm8750_reset(I2C_SLAVE(s));
-
-    return 0;
 }
 
 #if 0
@@ -707,7 +705,7 @@ static void wm8750_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
 
-    sc->init = wm8750_init;
+    dc->realize = wm8750_realize;
     sc->event = wm8750_event;
     sc->recv = wm8750_rx;
     sc->send = wm8750_tx;
diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
index 68a80b9d64..eb90ba26be 100644
--- a/hw/display/ssd0303.c
+++ b/hw/display/ssd0303.c
@@ -297,13 +297,12 @@ static const GraphicHwOps ssd0303_ops = {
     .gfx_update  = ssd0303_update_display,
 };
 
-static int ssd0303_init(I2CSlave *i2c)
+static void ssd0303_realize(DeviceState *dev, Error **errp)
 {
-    ssd0303_state *s = SSD0303(i2c);
+    ssd0303_state *s = SSD0303(dev);
 
-    s->con = graphic_console_init(DEVICE(i2c), 0, &ssd0303_ops, s);
+    s->con = graphic_console_init(dev, 0, &ssd0303_ops, s);
     qemu_console_resize(s->con, 96 * MAGNIFY, 16 * MAGNIFY);
-    return 0;
 }
 
 static void ssd0303_class_init(ObjectClass *klass, void *data)
@@ -311,7 +310,7 @@ static void ssd0303_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
-    k->init = ssd0303_init;
+    dc->realize = ssd0303_realize;
     k->event = ssd0303_event;
     k->recv = ssd0303_recv;
     k->send = ssd0303_send;
diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index 4c203ef5c6..a560e3afd2 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -182,14 +182,13 @@ static void max7310_gpio_set(void *opaque, int line, int level)
 
 /* MAX7310 is SMBus-compatible (can be used with only SMBus protocols),
  * but also accepts sequences that are not SMBus so return an I2C device.  */
-static int max7310_init(I2CSlave *i2c)
+static void max7310_realize(DeviceState *dev, Error **errp)
 {
-    MAX7310State *s = MAX7310(i2c);
+    I2CSlave *i2c = I2C_SLAVE(dev);
+    MAX7310State *s = MAX7310(dev);
 
     qdev_init_gpio_in(&i2c->qdev, max7310_gpio_set, 8);
     qdev_init_gpio_out(&i2c->qdev, s->handler, 8);
-
-    return 0;
 }
 
 static void max7310_class_init(ObjectClass *klass, void *data)
@@ -197,7 +196,7 @@ static void max7310_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
-    k->init = max7310_init;
+    dc->realize = max7310_realize;
     k->event = max7310_event;
     k->recv = max7310_rx;
     k->send = max7310_tx;
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index cfccefca3d..ab72d5bf2b 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -258,18 +258,6 @@ const VMStateDescription vmstate_i2c_slave = {
     }
 };
 
-static int i2c_slave_qdev_init(DeviceState *dev)
-{
-    I2CSlave *s = I2C_SLAVE(dev);
-    I2CSlaveClass *sc = I2C_SLAVE_GET_CLASS(s);
-
-    if (sc->init) {
-        return sc->init(s);
-    }
-
-    return 0;
-}
-
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
 {
     DeviceState *dev;
@@ -283,7 +271,6 @@ DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
 static void i2c_slave_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
-    k->init = i2c_slave_qdev_init;
     set_bit(DEVICE_CATEGORY_MISC, k->categories);
     k->bus_type = TYPE_I2C_BUS;
     k->props = i2c_props;
diff --git a/hw/input/lm832x.c b/hw/input/lm832x.c
index d39953126b..74da30d9ca 100644
--- a/hw/input/lm832x.c
+++ b/hw/input/lm832x.c
@@ -464,20 +464,19 @@ static const VMStateDescription vmstate_lm_kbd = {
 };
 
 
-static int lm8323_init(I2CSlave *i2c)
+static void lm8323_realize(DeviceState *dev, Error **errp)
 {
-    LM823KbdState *s = LM8323(i2c);
+    LM823KbdState *s = LM8323(dev);
 
     s->model = 0x8323;
     s->pwm.tm[0] = timer_new_ns(QEMU_CLOCK_VIRTUAL, lm_kbd_pwm0_tick, s);
     s->pwm.tm[1] = timer_new_ns(QEMU_CLOCK_VIRTUAL, lm_kbd_pwm1_tick, s);
     s->pwm.tm[2] = timer_new_ns(QEMU_CLOCK_VIRTUAL, lm_kbd_pwm2_tick, s);
-    qdev_init_gpio_out(DEVICE(i2c), &s->nirq, 1);
+    qdev_init_gpio_out(dev, &s->nirq, 1);
 
     lm_kbd_reset(s);
 
     qemu_register_reset((void *) lm_kbd_reset, s);
-    return 0;
 }
 
 void lm832x_key_event(DeviceState *dev, int key, int state)
@@ -505,7 +504,7 @@ static void lm8323_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
-    k->init = lm8323_init;
+    dc->realize = lm8323_realize;
     k->event = lm_i2c_event;
     k->recv = lm_i2c_rx;
     k->send = lm_i2c_tx;
diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index 9e22d64e36..0918f3a6ea 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -229,15 +229,14 @@ static void tmp105_reset(I2CSlave *i2c)
     tmp105_interrupt_update(s);
 }
 
-static int tmp105_init(I2CSlave *i2c)
+static void tmp105_realize(DeviceState *dev, Error **errp)
 {
+    I2CSlave *i2c = I2C_SLAVE(dev);
     TMP105State *s = TMP105(i2c);
 
     qdev_init_gpio_out(&i2c->qdev, &s->pin, 1);
 
     tmp105_reset(&s->i2c);
-
-    return 0;
 }
 
 static void tmp105_initfn(Object *obj)
@@ -252,7 +251,7 @@ static void tmp105_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
-    k->init = tmp105_init;
+    dc->realize = tmp105_realize;
     k->event = tmp105_event;
     k->recv = tmp105_rx;
     k->send = tmp105_tx;
diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index 4a505abbce..c234044305 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -335,13 +335,11 @@ static void tmp421_reset(I2CSlave *i2c)
     s->status = 0;
 }
 
-static int tmp421_init(I2CSlave *i2c)
+static void tmp421_realize(DeviceState *dev, Error **errp)
 {
-    TMP421State *s = TMP421(i2c);
+    TMP421State *s = TMP421(dev);
 
     tmp421_reset(&s->i2c);
-
-    return 0;
 }
 
 static void tmp421_initfn(Object *obj)
@@ -366,7 +364,7 @@ static void tmp421_class_init(ObjectClass *klass, void *data)
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
     TMP421Class *sc = TMP421_CLASS(klass);
 
-    k->init = tmp421_init;
+    dc->realize = tmp421_realize;
     k->event = tmp421_event;
     k->recv = tmp421_rx;
     k->send = tmp421_tx;
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 22183f5360..27cd01e615 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -116,31 +116,29 @@ int at24c_eeprom_send(I2CSlave *s, uint8_t data)
     return 0;
 }
 
-static
-int at24c_eeprom_init(I2CSlave *i2c)
+static void at24c_eeprom_realize(DeviceState *dev, Error **errp)
 {
-    EEPROMState *ee = AT24C_EE(i2c);
-
-    ee->mem = g_malloc0(ee->rsize);
+    EEPROMState *ee = AT24C_EE(dev);
 
     if (ee->blk) {
         int64_t len = blk_getlength(ee->blk);
 
         if (len != ee->rsize) {
-            ERR(TYPE_AT24C_EE " : Backing file size %lu != %u\n",
-                    (unsigned long)len, (unsigned)ee->rsize);
-            exit(1);
+            error_setg(errp, "%s: Backing file size %" PRId64 " != %u",
+                       TYPE_AT24C_EE, len, ee->rsize);
+            return;
         }
 
         if (blk_set_perm(ee->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
                          BLK_PERM_ALL, &error_fatal) < 0)
         {
-            ERR(TYPE_AT24C_EE
-                    " : Backing file incorrect permission\n");
-            exit(1);
+            error_setg(errp, "%s: Backing file incorrect permission",
+                       TYPE_AT24C_EE);
+            return;
         }
     }
-    return 0;
+
+    ee->mem = g_malloc0(ee->rsize);
 }
 
 static
@@ -178,7 +176,7 @@ void at24c_eeprom_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
-    k->init = &at24c_eeprom_init;
+    dc->realize = &at24c_eeprom_realize;
     k->event = &at24c_eeprom_event;
     k->recv = &at24c_eeprom_recv;
     k->send = &at24c_eeprom_send;
diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
index ef116c636c..3b43b46199 100644
--- a/hw/timer/twl92230.c
+++ b/hw/timer/twl92230.c
@@ -853,10 +853,9 @@ static const VMStateDescription vmstate_menelaus = {
     }
 };
 
-static int twl92230_init(I2CSlave *i2c)
+static void twl92230_realize(DeviceState *dev, Error **errp)
 {
-    DeviceState *dev = DEVICE(i2c);
-    MenelausState *s = TWL92230(i2c);
+    MenelausState *s = TWL92230(dev);
 
     s->rtc.hz_tm = timer_new_ms(rtc_clock, menelaus_rtc_hz, s);
     /* Three output pins plus one interrupt pin.  */
@@ -865,9 +864,7 @@ static int twl92230_init(I2CSlave *i2c)
     /* Three input pins plus one power-button pin.  */
     qdev_init_gpio_in(dev, menelaus_gpio_set, 4);
 
-    menelaus_reset(i2c);
-
-    return 0;
+    menelaus_reset(I2C_SLAVE(dev));
 }
 
 static void twl92230_class_init(ObjectClass *klass, void *data)
@@ -875,7 +872,7 @@ static void twl92230_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
 
-    sc->init = twl92230_init;
+    dc->realize = twl92230_realize;
     sc->event = menelaus_event;
     sc->recv = menelaus_rx;
     sc->send = menelaus_tx;
-- 
2.17.0
