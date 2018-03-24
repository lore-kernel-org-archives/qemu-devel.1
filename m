Received: from eggs.gnu.org ([2001:4830:134:3::10]:40552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezr6C-0001b3-Ow
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezr0C-0005Hr-Fe
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:48:10 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:40226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1ezon5-0005qq-FI
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:25:23 -0400
Received: by mail-pf0-x241.google.com with SMTP id v66so3513525pfv.7
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 12:25:23 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sat, 24 Mar 2018 12:24:52 -0700
Message-Id: <20180324192455.12254-12-mdavidsaver@gmail.com>
In-Reply-To: <20180324192455.12254-1-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 11/14] timer: generalize ds1338
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

Add class level handling for address space size
and control register.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/timer/ds-rtc.c | 63 ++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/hw/timer/ds-rtc.c b/hw/timer/ds-rtc.c
index 28f788dd8e..2df1bce3f8 100644
--- a/hw/timer/ds-rtc.c
+++ b/hw/timer/ds-rtc.c
@@ -21,10 +21,10 @@
  */
 #define NVRAM_SIZE 64
 
-#define CTRL_OSF   0x20
-
-#define TYPE_DSRTC "ds1338"
+#define TYPE_DSRTC "dsrtc"
 #define DSRTC(obj) OBJECT_CHECK(DSRTCState, (obj), TYPE_DSRTC)
+#define DSRTC_CLASS(klass) OBJECT_CLASS_CHECK(DSRTCClass, (klass), TYPE_DSRTC)
+#define DSRTC_GET_CLASS(obj) OBJECT_GET_CLASS(DSRTCClass, (obj), TYPE_DSRTC)
 
 /* values stored in BCD */
 /* 00-59 */
@@ -40,7 +40,7 @@
 /* 0-99 */
 #define R_YEAR  (0x6)
 
-#define R_CTRL  (0x7)
+#define R_DS1338_CTRL (0x7)
 
 /* use 12 hour mode when set */
 FIELD(HOUR, SET12, 6, 1)
@@ -67,6 +67,15 @@ typedef struct DSRTCState {
     bool addr_byte;
 } DSRTCState;
 
+typedef struct DSRTCClass {
+    I2CSlaveClass parent_obj;
+
+    /* actual address space size must be <= NVRAM_SIZE */
+    unsigned addr_size;
+    unsigned ctrl_offset;
+    void (*ctrl_write)(DSRTCState *s, uint8_t);
+} DSRTCClass;
+
 static const VMStateDescription vmstate_dsrtc = {
     .name = "ds1338",
     .version_id = 2,
@@ -119,11 +128,12 @@ static void capture_current_time(DSRTCState *s)
 
 static void inc_regptr(DSRTCState *s)
 {
-    /* The register pointer wraps around after 0x3F; wraparound
+    DSRTCClass *k = DSRTC_GET_CLASS(s);
+    /* The register pointer wraps around after k->addr_size-1; wraparound
      * causes the current time/date to be retransferred into
      * the secondary registers.
      */
-    s->ptr = (s->ptr + 1) & (NVRAM_SIZE - 1);
+    s->ptr = (s->ptr + 1) % k->addr_size;
     if (!s->ptr) {
         capture_current_time(s);
     }
@@ -206,22 +216,15 @@ static void dsrtc_update(DSRTCState *s)
 static int dsrtc_send(I2CSlave *i2c, uint8_t data)
 {
     DSRTCState *s = DSRTC(i2c);
+    DSRTCClass *k = DSRTC_GET_CLASS(s);
 
     if (s->addr_byte) {
-        s->ptr = data & (NVRAM_SIZE - 1);
+        s->ptr = data % k->addr_size;
         s->addr_byte = false;
         return 0;
     }
-    if (s->ptr == R_CTRL) {
-        /* Control register. */
-
-        /* Ensure bits 2, 3 and 6 will read back as zero. */
-        data &= 0xB3;
-
-        /* Attempting to write the OSF flag to logic 1 leaves the
-           value unchanged. */
-        data = (data & ~CTRL_OSF) | (data & s->nvram[s->ptr] & CTRL_OSF);
-
+    if (s->ptr == k->ctrl_offset) {
+        (k->ctrl_write)(s, data);
     }
     s->nvram[s->ptr] = data;
     if (s->ptr <= R_YEAR) {
@@ -256,15 +259,41 @@ static void dsrtc_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo dsrtc_info = {
+    .abstract      = true,
     .name          = TYPE_DSRTC,
     .parent        = TYPE_I2C_SLAVE,
     .instance_size = sizeof(DSRTCState),
     .class_init    = dsrtc_class_init,
 };
 
+static void ds1338_control_write(DSRTCState *s, uint8_t data)
+{
+    /* Control register. */
+
+    /* allow guest to set no-op controls for clock out pin */
+    s->nvram[R_DS1338_CTRL] = data & 0x93;
+}
+
+static void ds1338_class_init(ObjectClass *klass, void *data)
+{
+    DSRTCClass *k = DSRTC_CLASS(klass);
+
+    k->addr_size = 0x40;
+    k->ctrl_offset = R_DS1338_CTRL;
+    k->ctrl_write = ds1338_control_write;
+}
+
+static const TypeInfo ds1338_info = {
+    .name          = "ds1338",
+    .parent        = TYPE_DSRTC,
+    .class_size    = sizeof(DSRTCClass),
+    .class_init    = ds1338_class_init,
+};
+
 static void dsrtc_register_types(void)
 {
     type_register_static(&dsrtc_info);
+    type_register_static(&ds1338_info);
 }
 
 type_init(dsrtc_register_types)
-- 
2.11.0
