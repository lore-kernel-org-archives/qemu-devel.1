Received: from eggs.gnu.org ([2001:4830:134:3::10]:35179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezq63-0000yq-GN
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 16:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezq4z-00086s-Hl
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 16:49:03 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:39686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1ezomz-0005mc-0E
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:25:17 -0400
Received: by mail-pg0-x244.google.com with SMTP id a19so5796002pgw.6
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 12:25:16 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sat, 24 Mar 2018 12:24:48 -0700
Message-Id: <20180324192455.12254-8-mdavidsaver@gmail.com>
In-Reply-To: <20180324192455.12254-1-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 07/14] timer: ds1338 fix wday_offset handling
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

Correctly handle different real weekday in
guest and host timezones.
Allow guest to use any day as start of week
(day 1).  eg. Monday instead of Sunday.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/timer/ds1338.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
index 071c031563..a969b5c8ba 100644
--- a/hw/timer/ds1338.c
+++ b/hw/timer/ds1338.c
@@ -108,7 +108,10 @@ static void capture_current_time(DS1338State *s)
     } else {
         ARRAY_FIELD_DP32(s->nvram, HOUR, HOUR24, to_bcd(now.tm_hour));
     }
-    s->nvram[R_WDAY] = (now.tm_wday + s->wday_offset) % 7 + 1;
+    s->nvram[R_WDAY] = (now.tm_wday + s->wday_offset) % 7;
+    if (s->nvram[R_WDAY] == 0) {
+        s->nvram[R_WDAY] = 7;
+    }
     s->nvram[R_DATE] = to_bcd(now.tm_mday);
     s->nvram[R_MONTH] = to_bcd(now.tm_mon + 1);
     s->nvram[R_YEAR] = to_bcd(now.tm_year - 100);
@@ -182,17 +185,22 @@ static void ds1338_update(DS1338State *s)
     } else {
         now.tm_hour = from_bcd(ARRAY_FIELD_EX32(s->nvram, HOUR, HOUR24));
     }
-    {
-        /* The day field is supposed to contain a value in
-               the range 1-7. Otherwise behavior is undefined.
-             */
-        int user_wday = (s->nvram[R_WDAY] & 7) - 1;
-        s->wday_offset = (user_wday - now.tm_wday + 7) % 7;
-    }
+    now.tm_wday = from_bcd(s->nvram[R_WDAY]) - 1u;
     now.tm_mday = from_bcd(s->nvram[R_DATE] & 0x3f);
     now.tm_mon = from_bcd(s->nvram[R_MONTH] & 0x1f) - 1;
     now.tm_year = from_bcd(s->nvram[R_YEAR]) + 100;
     s->offset = qemu_timedate_diff(&now);
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
 }
 
 static int ds1338_send(I2CSlave *i2c, uint8_t data)
-- 
2.11.0
