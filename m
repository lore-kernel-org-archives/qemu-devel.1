Received: from eggs.gnu.org ([2001:4830:134:3::10]:59682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrh-0004XU-BE
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrg-0007LX-Bd
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:49 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dcZrg-0007LD-2S
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:48 -0400
Received: by mail-wm0-x244.google.com with SMTP id r77so3776511wmd.2
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 09:17:48 -0700 (PDT)
Received: from 640k.lan (94-39-192-75.adsl-ull.clienti.tiscali.it.
	[94.39.192.75]) by smtp.gmail.com with ESMTPSA id
	u187sm1724160wmd.26.2017.08.01.09.17.45 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 01 Aug 2017 09:17:46 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  1 Aug 2017 18:17:22 +0200
Message-Id: <1501604245-33460-15-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/17] rtc-test: cleanup register_b_set_flag test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Introduce set_datetime_bcd/assert_datetime_bcd, and handle
UIP correctly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/rtc-test.c | 76 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index e78f701..798cf5e 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -17,6 +17,8 @@
 #include "qemu/timer.h"
 #include "hw/timer/mc146818rtc_regs.h"
 
+#define UIP_HOLD_LENGTH           (8 * NANOSECONDS_PER_SECOND / 32768)
+
 static uint8_t base = 0x70;
 
 static int bcd2dec(int value)
@@ -297,16 +299,30 @@ static void alarm_time(void)
     g_assert(cmos_read(RTC_REG_C) == 0);
 }
 
+static void set_time_regs(int h, int m, int s)
+{
+    cmos_write(RTC_HOURS, h);
+    cmos_write(RTC_MINUTES, m);
+    cmos_write(RTC_SECONDS, s);
+}
+
 static void set_time(int mode, int h, int m, int s)
 {
-    /* set BCD 12 hour mode */
     cmos_write(RTC_REG_B, mode);
-
     cmos_write(RTC_REG_A, 0x76);
+    set_time_regs(h, m, s);
+    cmos_write(RTC_REG_A, 0x26);
+}
+
+static void set_datetime_bcd(int h, int min, int s, int d, int m, int y)
+{
     cmos_write(RTC_HOURS, h);
-    cmos_write(RTC_MINUTES, m);
+    cmos_write(RTC_MINUTES, min);
     cmos_write(RTC_SECONDS, s);
-    cmos_write(RTC_REG_A, 0x26);
+    cmos_write(RTC_YEAR, y & 0xFF);
+    cmos_write(RTC_CENTURY, y >> 8);
+    cmos_write(RTC_MONTH, m);
+    cmos_write(RTC_DAY_OF_MONTH, d);
 }
 
 #define assert_time(h, m, s) \
@@ -316,6 +332,17 @@ static void set_time(int mode, int h, int m, int s)
         g_assert_cmpint(cmos_read(RTC_SECONDS), ==, s); \
     } while(0)
 
+#define assert_datetime_bcd(h, min, s, d, m, y) \
+    do { \
+        g_assert_cmpint(cmos_read(RTC_HOURS), ==, h); \
+        g_assert_cmpint(cmos_read(RTC_MINUTES), ==, min); \
+        g_assert_cmpint(cmos_read(RTC_SECONDS), ==, s); \
+        g_assert_cmpint(cmos_read(RTC_DAY_OF_MONTH), ==, d); \
+        g_assert_cmpint(cmos_read(RTC_MONTH), ==, m); \
+        g_assert_cmpint(cmos_read(RTC_YEAR), ==, (y & 0xFF)); \
+        g_assert_cmpint(cmos_read(RTC_CENTURY), ==, (y >> 8)); \
+    } while(0)
+
 static void basic_12h_bcd(void)
 {
     /* set BCD 12 hour mode */
@@ -506,41 +533,30 @@ static void fuzz_registers(void)
 
 static void register_b_set_flag(void)
 {
+    if (cmos_read(RTC_REG_A) & REG_A_UIP) {
+        clock_step(UIP_HOLD_LENGTH + NANOSECONDS_PER_SECOND / 5);
+    }
+    g_assert_cmpint(cmos_read(RTC_REG_A) & REG_A_UIP, ==, 0);
+
     /* Enable binary-coded decimal (BCD) mode and SET flag in Register B*/
     cmos_write(RTC_REG_B, REG_B_24H | REG_B_SET);
 
-    cmos_write(RTC_REG_A, 0x76);
-    cmos_write(RTC_YEAR, 0x11);
-    cmos_write(RTC_CENTURY, 0x20);
-    cmos_write(RTC_MONTH, 0x02);
-    cmos_write(RTC_DAY_OF_MONTH, 0x02);
-    cmos_write(RTC_HOURS, 0x02);
-    cmos_write(RTC_MINUTES, 0x04);
-    cmos_write(RTC_SECONDS, 0x58);
-    cmos_write(RTC_REG_A, 0x26);
+    set_datetime_bcd(0x02, 0x04, 0x58, 0x02, 0x02, 0x2011);
 
-    /* Since SET flag is still enabled, these are equality checks. */
-    g_assert_cmpint(cmos_read(RTC_HOURS), ==, 0x02);
-    g_assert_cmpint(cmos_read(RTC_MINUTES), ==, 0x04);
-    g_assert_cmpint(cmos_read(RTC_SECONDS), ==, 0x58);
-    g_assert_cmpint(cmos_read(RTC_DAY_OF_MONTH), ==, 0x02);
-    g_assert_cmpint(cmos_read(RTC_MONTH), ==, 0x02);
-    g_assert_cmpint(cmos_read(RTC_YEAR), ==, 0x11);
-    g_assert_cmpint(cmos_read(RTC_CENTURY), ==, 0x20);
+    assert_datetime_bcd(0x02, 0x04, 0x58, 0x02, 0x02, 0x2011);
+
+    /* Since SET flag is still enabled, time does not advance. */
+    clock_step(1000000000LL);
+    assert_datetime_bcd(0x02, 0x04, 0x58, 0x02, 0x02, 0x2011);
 
     /* Disable SET flag in Register B */
     cmos_write(RTC_REG_B, cmos_read(RTC_REG_B) & ~REG_B_SET);
 
-    g_assert_cmpint(cmos_read(RTC_HOURS), ==, 0x02);
-    g_assert_cmpint(cmos_read(RTC_MINUTES), ==, 0x04);
+    assert_datetime_bcd(0x02, 0x04, 0x58, 0x02, 0x02, 0x2011);
 
-    /* Since SET flag is disabled, this is an inequality check.
-     * We (reasonably) assume that no (sexagesimal) overflow occurs. */
-    g_assert_cmpint(cmos_read(RTC_SECONDS), >=, 0x58);
-    g_assert_cmpint(cmos_read(RTC_DAY_OF_MONTH), ==, 0x02);
-    g_assert_cmpint(cmos_read(RTC_MONTH), ==, 0x02);
-    g_assert_cmpint(cmos_read(RTC_YEAR), ==, 0x11);
-    g_assert_cmpint(cmos_read(RTC_CENTURY), ==, 0x20);
+    /* Since SET flag is disabled, the clock now advances.  */
+    clock_step(1000000000LL);
+    assert_datetime_bcd(0x02, 0x04, 0x59, 0x02, 0x02, 0x2011);
 }
 
 #define RTC_PERIOD_CODE1    13   /* 8 Hz */
-- 
1.8.3.1
