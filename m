Received: from eggs.gnu.org ([208.118.235.92]:43246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezoxd-0000Bv-Bd
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezomu-0005lC-KO
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:28:50 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1ezomu-0005ku-E2
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:25:12 -0400
Received: by mail-pf0-x243.google.com with SMTP id f15so243982pfn.0
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 12:25:12 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sat, 24 Mar 2018 12:24:45 -0700
Message-Id: <20180324192455.12254-5-mdavidsaver@gmail.com>
In-Reply-To: <20180324192455.12254-1-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 04/14] timer: ds1338 clarify HOUR handling
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

Simplify and comment the translation between
registers and struct tm.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/timer/ds1338.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
index 72a4692d60..9bcda26e51 100644
--- a/hw/timer/ds1338.c
+++ b/hw/timer/ds1338.c
@@ -88,23 +88,23 @@ static void capture_current_time(DS1338State *s)
      * which will be actually read by the data transfer operation.
      */
     struct tm now;
+    bool mode12 = ARRAY_FIELD_EX32(s->nvram, HOUR, SET12);
     qemu_get_timedate(&now, s->offset);
+
     s->nvram[R_SEC] = to_bcd(now.tm_sec);
     s->nvram[R_MIN] = to_bcd(now.tm_min);
-    if (ARRAY_FIELD_EX32(s->nvram, HOUR, SET12)) {
-        int tmp = now.tm_hour;
-        if (tmp % 12 == 0) {
-            tmp += 12;
-        }
-        s->nvram[R_HOUR] = 0;
+    s->nvram[R_HOUR] = 0;
+    if (mode12) {
+        /* map 0-23 to 1-12 am/pm */
         ARRAY_FIELD_DP32(s->nvram, HOUR, SET12, 1);
-        if (tmp <= 12) {
-            ARRAY_FIELD_DP32(s->nvram, HOUR, AMPM, 0);
-            ARRAY_FIELD_DP32(s->nvram, HOUR, HOUR12, to_bcd(tmp));
-        } else {
-            ARRAY_FIELD_DP32(s->nvram, HOUR, AMPM, 1);
-            ARRAY_FIELD_DP32(s->nvram, HOUR, HOUR12, to_bcd(tmp - 12));
+        ARRAY_FIELD_DP32(s->nvram, HOUR, AMPM, now.tm_hour >= 12u);
+        now.tm_hour %= 12u; /* wrap 0-23 to 0-11 */
+        if (now.tm_hour == 0u) {
+            /* midnight/noon stored as 12 */
+            now.tm_hour = 12u;
         }
+        ARRAY_FIELD_DP32(s->nvram, HOUR, HOUR12, to_bcd(now.tm_hour));
+
     } else {
         ARRAY_FIELD_DP32(s->nvram, HOUR, HOUR24, to_bcd(now.tm_hour));
     }
@@ -182,14 +182,13 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
             break;
         case R_HOUR:
             if (FIELD_EX32(data, HOUR, SET12)) {
-                int tmp = from_bcd(FIELD_EX32(data, HOUR, HOUR12));
+                /* 12 hour (1-12) */
+                /* read and wrap 1-12 -> 0-11 */
+                now.tm_hour = from_bcd(FIELD_EX32(data, HOUR, HOUR12)) % 12u;
                 if (FIELD_EX32(data, HOUR, AMPM)) {
-                    tmp += 12;
+                    now.tm_hour += 12;
                 }
-                if (tmp % 12 == 0) {
-                    tmp -= 12;
-                }
-                now.tm_hour = tmp;
+
             } else {
                 now.tm_hour = from_bcd(FIELD_EX32(data, HOUR, HOUR24));
             }
-- 
2.11.0
