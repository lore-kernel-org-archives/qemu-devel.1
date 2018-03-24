Received: from eggs.gnu.org ([208.118.235.92]:42626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezooB-0007s8-A4
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezon7-0005ua-AS
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:26:31 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:39685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1ezon7-0005sr-0d
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:25:25 -0400
Received: by mail-pg0-x242.google.com with SMTP id a19so5796060pgw.6
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 12:25:24 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sat, 24 Mar 2018 12:24:53 -0700
Message-Id: <20180324192455.12254-13-mdavidsaver@gmail.com>
In-Reply-To: <20180324192455.12254-1-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 12/14] timer: ds-rtc handle CENTURY bit
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

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/timer/ds-rtc.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/hw/timer/ds-rtc.c b/hw/timer/ds-rtc.c
index 2df1bce3f8..5a4df1b115 100644
--- a/hw/timer/ds-rtc.c
+++ b/hw/timer/ds-rtc.c
@@ -70,6 +70,7 @@ typedef struct DSRTCState {
 typedef struct DSRTCClass {
     I2CSlaveClass parent_obj;
 
+    bool has_century;
     /* actual address space size must be <= NVRAM_SIZE */
     unsigned addr_size;
     unsigned ctrl_offset;
@@ -91,7 +92,7 @@ static const VMStateDescription vmstate_dsrtc = {
     }
 };
 
-static void capture_current_time(DSRTCState *s)
+static void capture_current_time(DSRTCState *s, DSRTCClass *k)
 {
     /* Capture the current time into the secondary registers
      * which will be actually read by the data transfer operation.
@@ -123,25 +124,28 @@ static void capture_current_time(DSRTCState *s)
     }
     s->nvram[R_DATE] = to_bcd(now.tm_mday);
     s->nvram[R_MONTH] = to_bcd(now.tm_mon + 1);
-    s->nvram[R_YEAR] = to_bcd(now.tm_year - 100);
+    s->nvram[R_YEAR] = to_bcd(now.tm_year % 100u);
+
+    ARRAY_FIELD_DP32(s->nvram, MONTH, CENTURY,
+                     k->has_century && now.tm_year >= 100)
 }
 
-static void inc_regptr(DSRTCState *s)
+static void inc_regptr(DSRTCState *s, DSRTCClass *k)
 {
-    DSRTCClass *k = DSRTC_GET_CLASS(s);
     /* The register pointer wraps around after k->addr_size-1; wraparound
      * causes the current time/date to be retransferred into
      * the secondary registers.
      */
     s->ptr = (s->ptr + 1) % k->addr_size;
     if (!s->ptr) {
-        capture_current_time(s);
+        capture_current_time(s, k);
     }
 }
 
 static int dsrtc_event(I2CSlave *i2c, enum i2c_event event)
 {
     DSRTCState *s = DSRTC(i2c);
+    DSRTCClass *k = DSRTC_GET_CLASS(s);
 
     switch (event) {
     case I2C_START_RECV:
@@ -150,7 +154,7 @@ static int dsrtc_event(I2CSlave *i2c, enum i2c_event event)
          * START_SEND, because the guest can't get at that data
          * without going through a START_RECV which would overwrite it.
          */
-        capture_current_time(s);
+        capture_current_time(s, k);
         break;
     case I2C_START_SEND:
         s->addr_byte = true;
@@ -165,10 +169,11 @@ static int dsrtc_event(I2CSlave *i2c, enum i2c_event event)
 static int dsrtc_recv(I2CSlave *i2c)
 {
     DSRTCState *s = DSRTC(i2c);
+    DSRTCClass *k = DSRTC_GET_CLASS(s);
     uint8_t res;
 
     res  = s->nvram[s->ptr];
-    inc_regptr(s);
+    inc_regptr(s, k);
     return res;
 }
 
@@ -230,7 +235,7 @@ static int dsrtc_send(I2CSlave *i2c, uint8_t data)
     if (s->ptr <= R_YEAR) {
         dsrtc_update(s);
     }
-    inc_regptr(s);
+    inc_regptr(s, k);
     return 0;
 }
 
@@ -278,6 +283,7 @@ static void ds1338_class_init(ObjectClass *klass, void *data)
 {
     DSRTCClass *k = DSRTC_CLASS(klass);
 
+    k->has_century = false;
     k->addr_size = 0x40;
     k->ctrl_offset = R_DS1338_CTRL;
     k->ctrl_write = ds1338_control_write;
-- 
2.11.0
