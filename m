Received: from eggs.gnu.org ([2001:4830:134:3::10]:57985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8re-0004Ld-U1
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rd-0006BV-VZ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:22 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:41448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1fb8rd-0006B9-Pa
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:21 -0400
Received: by mail-pf0-x242.google.com with SMTP id c21-v6so1515042pfn.8
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 11:20:21 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Thu,  5 Jul 2018 11:19:51 -0700
Message-Id: <20180705182001.16537-5-mdavidsaver@gmail.com>
In-Reply-To: <20180705182001.16537-1-mdavidsaver@gmail.com>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 04/14] timer: ds1338 clarify HOUR handling
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

Simplify and comment the translation between
registers and struct tm.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/timer/ds1338.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
index b56db5852e..637a0f4246 100644
--- a/hw/timer/ds1338.c
+++ b/hw/timer/ds1338.c
@@ -89,9 +89,13 @@ static void capture_current_time(DS1338State *s)
      */
     struct tm now;
     qemu_get_timedate(&now, s->offset);
+
     s->nvram[R_SEC] = to_bcd(now.tm_sec);
     s->nvram[R_MIN] = to_bcd(now.tm_min);
     if (ARRAY_FIELD_EX32(s->nvram, HOUR, SET12)) {
+        /* 12 hour mode.
+         * map 0-23 to 1-12 am/pm
+         */
         int tmp = now.tm_hour;
         if (tmp % 12 == 0) {
             tmp += 12;
@@ -101,7 +105,9 @@ static void capture_current_time(DS1338State *s)
         } else {
             s->nvram[R_HOUR] = R_HOUR_SET12_MASK | R_HOUR_AMPM_MASK | to_bcd(tmp - 12);
         }
+
     } else {
+        /* 24 hour mode. */
         s->nvram[R_HOUR] = to_bcd(now.tm_hour);
     }
     s->nvram[R_WDAY] = (now.tm_wday + s->wday_offset) % 7 + 1;
@@ -178,14 +184,13 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
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
