Received: from eggs.gnu.org ([2001:4830:134:3::10]:57936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rc-0004Jx-Sy
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8ra-00069s-T3
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:20 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1fb8ra-00069g-Kg
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:18 -0400
Received: by mail-pf0-x244.google.com with SMTP id u16-v6so6121804pfh.3
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 11:20:18 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Thu,  5 Jul 2018 11:19:49 -0700
Message-Id: <20180705182001.16537-3-mdavidsaver@gmail.com>
In-Reply-To: <20180705182001.16537-1-mdavidsaver@gmail.com>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 02/14] timer: ds1338 use registerfields.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Use names for registers and bits except
for R_CTRL which will be dealt with later,
and isn't modeled anyway.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/ds1338.c | 80 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 26 deletions(-)

diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
index 3849b74a68..7298c5af43 100644
--- a/hw/timer/ds1338.c
+++ b/hw/timer/ds1338.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "hw/i2c/i2c.h"
+#include "hw/registerfields.h"
 #include "qemu/bcd.h"
 
 /* Size of NVRAM including both the user-accessible area and the
@@ -20,15 +21,42 @@
  */
 #define NVRAM_SIZE 64
 
-/* Flags definitions */
-#define SECONDS_CH 0x80
-#define HOURS_12   0x40
-#define HOURS_PM   0x20
 #define CTRL_OSF   0x20
 
 #define TYPE_DS1338 "ds1338"
 #define DS1338(obj) OBJECT_CHECK(DS1338State, (obj), TYPE_DS1338)
 
+/* values stored in BCD */
+/* 00-59 */
+#define R_SEC   (0x0)
+/* 00-59 */
+#define R_MIN   (0x1)
+#define R_HOUR  (0x2)
+/* 1-7 */
+#define R_WDAY  (0x3)
+/* 0-31 */
+#define R_DATE  (0x4)
+#define R_MONTH (0x5)
+/* 0-99 */
+#define R_YEAR  (0x6)
+
+#define R_CTRL  (0x7)
+
+/* use 12 hour mode when set */
+FIELD(HOUR, SET12, 6, 1)
+/* 00-23 */
+FIELD(HOUR, HOUR24, 0, 6)
+/* PM when set */
+FIELD(HOUR, AMPM, 5, 1)
+/* 1-12 (not 0-11!) */
+FIELD(HOUR, HOUR12, 0, 5)
+
+/* 1-12 */
+FIELD(MONTH, MONTH, 0, 5)
+FIELD(MONTH, CENTURY, 7, 1)
+
+FIELD(CTRL, OSF, 5, 1)
+
 typedef struct DS1338State {
     I2CSlave parent_obj;
 
@@ -61,25 +89,25 @@ static void capture_current_time(DS1338State *s)
      */
     struct tm now;
     qemu_get_timedate(&now, s->offset);
-    s->nvram[0] = to_bcd(now.tm_sec);
-    s->nvram[1] = to_bcd(now.tm_min);
-    if (s->nvram[2] & HOURS_12) {
+    s->nvram[R_SEC] = to_bcd(now.tm_sec);
+    s->nvram[R_MIN] = to_bcd(now.tm_min);
+    if (ARRAY_FIELD_EX32(s->nvram, HOUR, SET12)) {
         int tmp = now.tm_hour;
         if (tmp % 12 == 0) {
             tmp += 12;
         }
         if (tmp <= 12) {
-            s->nvram[2] = HOURS_12 | to_bcd(tmp);
+            s->nvram[R_HOUR] = R_HOUR_SET12_MASK | to_bcd(tmp);
         } else {
-            s->nvram[2] = HOURS_12 | HOURS_PM | to_bcd(tmp - 12);
+            s->nvram[R_HOUR] = R_HOUR_SET12_MASK | R_HOUR_AMPM_MASK | to_bcd(tmp - 12);
         }
     } else {
-        s->nvram[2] = to_bcd(now.tm_hour);
+        s->nvram[R_HOUR] = to_bcd(now.tm_hour);
     }
-    s->nvram[3] = (now.tm_wday + s->wday_offset) % 7 + 1;
-    s->nvram[4] = to_bcd(now.tm_mday);
-    s->nvram[5] = to_bcd(now.tm_mon + 1);
-    s->nvram[6] = to_bcd(now.tm_year - 100);
+    s->nvram[R_WDAY] = (now.tm_wday + s->wday_offset) % 7 + 1;
+    s->nvram[R_DATE] = to_bcd(now.tm_mday);
+    s->nvram[R_MONTH] = to_bcd(now.tm_mon + 1);
+    s->nvram[R_YEAR] = to_bcd(now.tm_year - 100);
 }
 
 static void inc_regptr(DS1338State *s)
@@ -141,17 +169,17 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
         struct tm now;
         qemu_get_timedate(&now, s->offset);
         switch(s->ptr) {
-        case 0:
+        case R_SEC:
             /* TODO: Implement CH (stop) bit.  */
             now.tm_sec = from_bcd(data & 0x7f);
             break;
-        case 1:
+        case R_MIN:
             now.tm_min = from_bcd(data & 0x7f);
             break;
-        case 2:
-            if (data & HOURS_12) {
-                int tmp = from_bcd(data & (HOURS_PM - 1));
-                if (data & HOURS_PM) {
+        case R_HOUR:
+            if (FIELD_EX32(data, HOUR, SET12)) {
+                int tmp = from_bcd(FIELD_EX32(data, HOUR, HOUR12));
+                if (FIELD_EX32(data, HOUR, AMPM)) {
                     tmp += 12;
                 }
                 if (tmp % 12 == 0) {
@@ -159,10 +187,10 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
                 }
                 now.tm_hour = tmp;
             } else {
-                now.tm_hour = from_bcd(data & (HOURS_12 - 1));
+                now.tm_hour = from_bcd(FIELD_EX32(data, HOUR, HOUR24));
             }
             break;
-        case 3:
+        case R_WDAY:
             {
                 /* The day field is supposed to contain a value in
                    the range 1-7. Otherwise behavior is undefined.
@@ -171,18 +199,18 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
                 s->wday_offset = (user_wday - now.tm_wday + 7) % 7;
             }
             break;
-        case 4:
+        case R_DATE:
             now.tm_mday = from_bcd(data & 0x3f);
             break;
-        case 5:
+        case R_MONTH:
             now.tm_mon = from_bcd(data & 0x1f) - 1;
             break;
-        case 6:
+        case R_YEAR:
             now.tm_year = from_bcd(data) + 100;
             break;
         }
         s->offset = qemu_timedate_diff(&now);
-    } else if (s->ptr == 7) {
+    } else if (s->ptr == R_CTRL) {
         /* Control register. */
 
         /* Ensure bits 2, 3 and 6 will read back as zero. */
-- 
2.11.0
