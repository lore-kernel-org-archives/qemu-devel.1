Received: from eggs.gnu.org ([2001:4830:134:3::10]:43617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7X-0006We-4U
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:21:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elv7W-0007Ft-38
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:21:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57182 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1elv7V-0007FR-Tp
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 06:21:02 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Feb 2018 12:20:32 +0100
Message-Id: <1518607234-17739-17-git-send-email-thuth@redhat.com>
In-Reply-To: <1518607234-17739-1-git-send-email-thuth@redhat.com>
References: <1518607234-17739-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 16/18] tests/m48t59: Make the test independent
 of global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

Stop using the functions that require global_qtest here and pass
around the QTestState instead (global_qtest should finally get
removed since this causes problems with tests running in parallel).

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/m48t59-test.c | 60 ++++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/tests/m48t59-test.c b/tests/m48t59-test.c
index a85f84d..8c25467 100644
--- a/tests/m48t59-test.c
+++ b/tests/m48t59-test.c
@@ -30,45 +30,45 @@ static uint16_t reg_base = 0x1ff0; /* 0x7f0 for m48t02 */
 static int base_year;
 static bool use_mmio;
 
-static uint8_t cmos_read_mmio(uint8_t reg)
+static uint8_t cmos_read_mmio(QTestState *s, uint8_t reg)
 {
-    return readb(base + (uint32_t)reg_base + (uint32_t)reg);
+    return qtest_readb(s, base + (uint32_t)reg_base + (uint32_t)reg);
 }
 
-static void cmos_write_mmio(uint8_t reg, uint8_t val)
+static void cmos_write_mmio(QTestState *s, uint8_t reg, uint8_t val)
 {
     uint8_t data = val;
 
-    writeb(base + (uint32_t)reg_base + (uint32_t)reg, data);
+    qtest_writeb(s, base + (uint32_t)reg_base + (uint32_t)reg, data);
 }
 
-static uint8_t cmos_read_ioio(uint8_t reg)
+static uint8_t cmos_read_ioio(QTestState *s, uint8_t reg)
 {
-    outw(base + 0, reg_base + (uint16_t)reg);
-    return inb(base + 3);
+    qtest_outw(s, base + 0, reg_base + (uint16_t)reg);
+    return qtest_inb(s, base + 3);
 }
 
-static void cmos_write_ioio(uint8_t reg, uint8_t val)
+static void cmos_write_ioio(QTestState *s, uint8_t reg, uint8_t val)
 {
-    outw(base + 0, reg_base + (uint16_t)reg);
-    outb(base + 3, val);
+    qtest_outw(s, base + 0, reg_base + (uint16_t)reg);
+    qtest_outb(s, base + 3, val);
 }
 
-static uint8_t cmos_read(uint8_t reg)
+static uint8_t cmos_read(QTestState *s, uint8_t reg)
 {
     if (use_mmio) {
-        return cmos_read_mmio(reg);
+        return cmos_read_mmio(s, reg);
     } else {
-        return cmos_read_ioio(reg);
+        return cmos_read_ioio(s, reg);
     }
 }
 
-static void cmos_write(uint8_t reg, uint8_t val)
+static void cmos_write(QTestState *s, uint8_t reg, uint8_t val)
 {
     if (use_mmio) {
-        cmos_write_mmio(reg, val);
+        cmos_write_mmio(s, reg, val);
     } else {
-        cmos_write_ioio(reg, val);
+        cmos_write_ioio(s, reg, val);
     }
 }
 
@@ -106,18 +106,18 @@ static void print_tm(struct tm *tm)
 }
 #endif
 
-static void cmos_get_date_time(struct tm *date)
+static void cmos_get_date_time(QTestState *s, struct tm *date)
 {
     int sec, min, hour, mday, mon, year;
     time_t ts;
     struct tm dummy;
 
-    sec = cmos_read(RTC_SECONDS);
-    min = cmos_read(RTC_MINUTES);
-    hour = cmos_read(RTC_HOURS);
-    mday = cmos_read(RTC_DAY_OF_MONTH);
-    mon = cmos_read(RTC_MONTH);
-    year = cmos_read(RTC_YEAR);
+    sec = cmos_read(s, RTC_SECONDS);
+    min = cmos_read(s, RTC_MINUTES);
+    hour = cmos_read(s, RTC_HOURS);
+    mday = cmos_read(s, RTC_DAY_OF_MONTH);
+    mon = cmos_read(s, RTC_MONTH);
+    year = cmos_read(s, RTC_YEAR);
 
     sec = bcd2dec(sec);
     min = bcd2dec(min);
@@ -145,7 +145,7 @@ static void cmos_get_date_time(struct tm *date)
 
 static QTestState *m48t59_qtest_start(void)
 {
-    return qtest_start("-rtc clock=vm");
+    return qtest_init("-rtc clock=vm");
 }
 
 static void bcd_check_time(void)
@@ -172,10 +172,10 @@ static void bcd_check_time(void)
     ts = time(NULL);
     gmtime_r(&ts, &start);
 
-    cmos_get_date_time(&date[0]);
-    cmos_get_date_time(&date[1]);
-    cmos_get_date_time(&date[2]);
-    cmos_get_date_time(&date[3]);
+    cmos_get_date_time(s, &date[0]);
+    cmos_get_date_time(s, &date[1]);
+    cmos_get_date_time(s, &date[2]);
+    cmos_get_date_time(s, &date[3]);
 
     ts = time(NULL);
     gmtime_r(&ts, &end);
@@ -226,8 +226,8 @@ static void fuzz_registers(void)
             continue;
         }
 
-        cmos_write(reg, val);
-        cmos_read(reg);
+        cmos_write(s, reg, val);
+        cmos_read(s, reg);
     }
 
     qtest_quit(s);
-- 
1.8.3.1
