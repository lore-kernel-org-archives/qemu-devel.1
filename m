Received: from eggs.gnu.org ([2001:4830:134:3::10]:58015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rg-0004NC-RM
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rf-0006Cx-Kq
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:24 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:40482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1fb8rf-0006CH-Cl
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:23 -0400
Received: by mail-pf0-x242.google.com with SMTP id z24-v6so6131448pfe.7
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 11:20:23 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Thu,  5 Jul 2018 11:19:52 -0700
Message-Id: <20180705182001.16537-6-mdavidsaver@gmail.com>
In-Reply-To: <20180705182001.16537-1-mdavidsaver@gmail.com>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 05/14] timer: ds1338 change write handling and
 fix wday_offset handling
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

instead of a read-modify-write, do direct translation
of device registers to struct tm members.

This new ds1338_update() is the reverse of
the existing capture_current_time().

Simplifies later handling of CENTURY bit in
similar Dallas RTC chips.

Correctly handle different real weekday in
guest and host timezones.
Allow guest to use any day as start of week
(day 1).  eg. Monday instead of Sunday.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/timer/ds1338.c | 95 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 48 insertions(+), 47 deletions(-)

diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
index 637a0f4246..0134ffd72a 100644
--- a/hw/timer/ds1338.c
+++ b/hw/timer/ds1338.c
@@ -110,7 +110,10 @@ static void capture_current_time(DS1338State *s)
         /* 24 hour mode. */
         s->nvram[R_HOUR] = to_bcd(now.tm_hour);
     }
-    s->nvram[R_WDAY] = (now.tm_wday + s->wday_offset) % 7 + 1;
+    s->nvram[R_WDAY] = (now.tm_wday + s->wday_offset) % 7;
+    if (s->nvram[R_WDAY] == 0) {
+        s->nvram[R_WDAY] = 7;
+    }
     s->nvram[R_DATE] = to_bcd(now.tm_mday);
     s->nvram[R_MONTH] = to_bcd(now.tm_mon + 1);
     s->nvram[R_YEAR] = to_bcd(now.tm_year - 100);
@@ -161,6 +164,46 @@ static int ds1338_recv(I2CSlave *i2c)
     return res;
 }
 
+/* call after guest writes to current time registers
+ * to re-compute our offset from host time.
+ */
+static void ds1338_update(DS1338State *s)
+{
+
+    struct tm now = {};
+
+    /* TODO: Implement CH (stop) bit?  */
+    now.tm_sec = from_bcd(s->nvram[R_SEC] & 0x7f);
+    now.tm_min = from_bcd(s->nvram[R_MIN] & 0x7f);
+    if (ARRAY_FIELD_EX32(s->nvram, HOUR, SET12)) {
+        /* 12 hour (1-12) */
+        /* read and wrap 1-12 -> 0-11 */
+        now.tm_hour = from_bcd(ARRAY_FIELD_EX32(s->nvram, HOUR, HOUR12)) % 12u;
+        if (ARRAY_FIELD_EX32(s->nvram, HOUR, AMPM)) {
+            now.tm_hour += 12;
+        }
+
+    } else {
+        now.tm_hour = from_bcd(ARRAY_FIELD_EX32(s->nvram, HOUR, HOUR24));
+    }
+    now.tm_wday = from_bcd(s->nvram[R_WDAY]) - 1u;
+    now.tm_mday = from_bcd(s->nvram[R_DATE] & 0x3f);
+    now.tm_mon = from_bcd(s->nvram[R_MONTH] & 0x1f) - 1;
+    now.tm_year = from_bcd(s->nvram[R_YEAR]) + 100;
+    s->offset = qemu_timedate_diff(&now);
+
+    {
+        /* Round trip to get real wday_offset based on time delta and
+         * ref. timezone.
+         * Race if midnight (in ref. timezone) happens here.
+         */
+        int user_wday = now.tm_wday;
+        qemu_get_timedate(&now, s->offset);
+
+        s->wday_offset = (user_wday - now.tm_wday) % 7 + 1;
+    }
+}
+
 static int ds1338_send(I2CSlave *i2c, uint8_t data)
 {
     DS1338State *s = DS1338(i2c);
@@ -170,52 +213,7 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
         s->addr_byte = false;
         return 0;
     }
-    if (s->ptr < 7) {
-        /* Time register. */
-        struct tm now;
-        qemu_get_timedate(&now, s->offset);
-        switch(s->ptr) {
-        case R_SEC:
-            /* TODO: Implement CH (stop) bit.  */
-            now.tm_sec = from_bcd(data & 0x7f);
-            break;
-        case R_MIN:
-            now.tm_min = from_bcd(data & 0x7f);
-            break;
-        case R_HOUR:
-            if (FIELD_EX32(data, HOUR, SET12)) {
-                /* 12 hour (1-12) */
-                /* read and wrap 1-12 -> 0-11 */
-                now.tm_hour = from_bcd(FIELD_EX32(data, HOUR, HOUR12)) % 12u;
-                if (FIELD_EX32(data, HOUR, AMPM)) {
-                    now.tm_hour += 12;
-                }
-
-            } else {
-                now.tm_hour = from_bcd(FIELD_EX32(data, HOUR, HOUR24));
-            }
-            break;
-        case R_WDAY:
-            {
-                /* The day field is supposed to contain a value in
-                   the range 1-7. Otherwise behavior is undefined.
-                 */
-                int user_wday = (data & 7) - 1;
-                s->wday_offset = (user_wday - now.tm_wday + 7) % 7;
-            }
-            break;
-        case R_DATE:
-            now.tm_mday = from_bcd(data & 0x3f);
-            break;
-        case R_MONTH:
-            now.tm_mon = from_bcd(data & 0x1f) - 1;
-            break;
-        case R_YEAR:
-            now.tm_year = from_bcd(data) + 100;
-            break;
-        }
-        s->offset = qemu_timedate_diff(&now);
-    } else if (s->ptr == R_CTRL) {
+    if (s->ptr == R_CTRL) {
         /* Control register. */
 
         /* Ensure bits 2, 3 and 6 will read back as zero. */
@@ -227,6 +225,9 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
 
     }
     s->nvram[s->ptr] = data;
+    if (s->ptr <= R_YEAR) {
+        ds1338_update(s);
+    }
     inc_regptr(s);
     return 0;
 }
-- 
2.11.0
