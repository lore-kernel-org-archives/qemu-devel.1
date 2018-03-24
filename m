Received: from eggs.gnu.org ([208.118.235.92]:43738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezoqV-0000zg-Hd
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezon2-0005pE-NX
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:28:55 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:41707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1ezon2-0005oo-4x
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:25:20 -0400
Received: by mail-pg0-x241.google.com with SMTP id m24so5789662pgv.8
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 12:25:20 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sat, 24 Mar 2018 12:24:50 -0700
Message-Id: <20180324192455.12254-10-mdavidsaver@gmail.com>
In-Reply-To: <20180324192455.12254-1-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 09/14] timer: rename ds1338 -> dsrtc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Prepare to generalize with a more generic
name.

Keep device name and vmstate name "ds1338"
for compatibility.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/timer/ds1338.c | 74 +++++++++++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
index a969b5c8ba..28f788dd8e 100644
--- a/hw/timer/ds1338.c
+++ b/hw/timer/ds1338.c
@@ -1,5 +1,5 @@
 /*
- * MAXIM DS1338 I2C RTC+NVRAM
+ * MAXIM DSRTC I2C RTC+NVRAM
  *
  * Copyright (c) 2009 CodeSourcery.
  * Written by Paul Brook
@@ -23,8 +23,8 @@
 
 #define CTRL_OSF   0x20
 
-#define TYPE_DS1338 "ds1338"
-#define DS1338(obj) OBJECT_CHECK(DS1338State, (obj), TYPE_DS1338)
+#define TYPE_DSRTC "ds1338"
+#define DSRTC(obj) OBJECT_CHECK(DSRTCState, (obj), TYPE_DSRTC)
 
 /* values stored in BCD */
 /* 00-59 */
@@ -57,7 +57,7 @@ FIELD(MONTH, CENTURY, 7, 1)
 
 FIELD(CTRL, OSF, 5, 1)
 
-typedef struct DS1338State {
+typedef struct DSRTCState {
     I2CSlave parent_obj;
 
     int64_t offset;
@@ -65,24 +65,24 @@ typedef struct DS1338State {
     uint8_t nvram[NVRAM_SIZE];
     int32_t ptr;
     bool addr_byte;
-} DS1338State;
+} DSRTCState;
 
-static const VMStateDescription vmstate_ds1338 = {
+static const VMStateDescription vmstate_dsrtc = {
     .name = "ds1338",
     .version_id = 2,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_I2C_SLAVE(parent_obj, DS1338State),
-        VMSTATE_INT64(offset, DS1338State),
-        VMSTATE_UINT8_V(wday_offset, DS1338State, 2),
-        VMSTATE_UINT8_ARRAY(nvram, DS1338State, NVRAM_SIZE),
-        VMSTATE_INT32(ptr, DS1338State),
-        VMSTATE_BOOL(addr_byte, DS1338State),
+        VMSTATE_I2C_SLAVE(parent_obj, DSRTCState),
+        VMSTATE_INT64(offset, DSRTCState),
+        VMSTATE_UINT8_V(wday_offset, DSRTCState, 2),
+        VMSTATE_UINT8_ARRAY(nvram, DSRTCState, NVRAM_SIZE),
+        VMSTATE_INT32(ptr, DSRTCState),
+        VMSTATE_BOOL(addr_byte, DSRTCState),
         VMSTATE_END_OF_LIST()
     }
 };
 
-static void capture_current_time(DS1338State *s)
+static void capture_current_time(DSRTCState *s)
 {
     /* Capture the current time into the secondary registers
      * which will be actually read by the data transfer operation.
@@ -117,7 +117,7 @@ static void capture_current_time(DS1338State *s)
     s->nvram[R_YEAR] = to_bcd(now.tm_year - 100);
 }
 
-static void inc_regptr(DS1338State *s)
+static void inc_regptr(DSRTCState *s)
 {
     /* The register pointer wraps around after 0x3F; wraparound
      * causes the current time/date to be retransferred into
@@ -129,9 +129,9 @@ static void inc_regptr(DS1338State *s)
     }
 }
 
-static int ds1338_event(I2CSlave *i2c, enum i2c_event event)
+static int dsrtc_event(I2CSlave *i2c, enum i2c_event event)
 {
-    DS1338State *s = DS1338(i2c);
+    DSRTCState *s = DSRTC(i2c);
 
     switch (event) {
     case I2C_START_RECV:
@@ -152,9 +152,9 @@ static int ds1338_event(I2CSlave *i2c, enum i2c_event event)
     return 0;
 }
 
-static int ds1338_recv(I2CSlave *i2c)
+static int dsrtc_recv(I2CSlave *i2c)
 {
-    DS1338State *s = DS1338(i2c);
+    DSRTCState *s = DSRTC(i2c);
     uint8_t res;
 
     res  = s->nvram[s->ptr];
@@ -165,7 +165,7 @@ static int ds1338_recv(I2CSlave *i2c)
 /* call after guest writes to current time registers
  * to re-compute our offset from host time.
  */
-static void ds1338_update(DS1338State *s)
+static void dsrtc_update(DSRTCState *s)
 {
 
     struct tm now;
@@ -203,9 +203,9 @@ static void ds1338_update(DS1338State *s)
     }
 }
 
-static int ds1338_send(I2CSlave *i2c, uint8_t data)
+static int dsrtc_send(I2CSlave *i2c, uint8_t data)
 {
-    DS1338State *s = DS1338(i2c);
+    DSRTCState *s = DSRTC(i2c);
 
     if (s->addr_byte) {
         s->ptr = data & (NVRAM_SIZE - 1);
@@ -225,15 +225,15 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
     }
     s->nvram[s->ptr] = data;
     if (s->ptr <= R_YEAR) {
-        ds1338_update(s);
+        dsrtc_update(s);
     }
     inc_regptr(s);
     return 0;
 }
 
-static void ds1338_reset(DeviceState *dev)
+static void dsrtc_reset(DeviceState *dev)
 {
-    DS1338State *s = DS1338(dev);
+    DSRTCState *s = DSRTC(dev);
 
     /* The clock is running and synchronized with the host */
     s->offset = 0;
@@ -243,28 +243,28 @@ static void ds1338_reset(DeviceState *dev)
     s->addr_byte = false;
 }
 
-static void ds1338_class_init(ObjectClass *klass, void *data)
+static void dsrtc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
 
-    k->event = ds1338_event;
-    k->recv = ds1338_recv;
-    k->send = ds1338_send;
-    dc->reset = ds1338_reset;
-    dc->vmsd = &vmstate_ds1338;
+    k->event = dsrtc_event;
+    k->recv = dsrtc_recv;
+    k->send = dsrtc_send;
+    dc->reset = dsrtc_reset;
+    dc->vmsd = &vmstate_dsrtc;
 }
 
-static const TypeInfo ds1338_info = {
-    .name          = TYPE_DS1338,
+static const TypeInfo dsrtc_info = {
+    .name          = TYPE_DSRTC,
     .parent        = TYPE_I2C_SLAVE,
-    .instance_size = sizeof(DS1338State),
-    .class_init    = ds1338_class_init,
+    .instance_size = sizeof(DSRTCState),
+    .class_init    = dsrtc_class_init,
 };
 
-static void ds1338_register_types(void)
+static void dsrtc_register_types(void)
 {
-    type_register_static(&ds1338_info);
+    type_register_static(&dsrtc_info);
 }
 
-type_init(ds1338_register_types)
+type_init(dsrtc_register_types)
-- 
2.11.0
