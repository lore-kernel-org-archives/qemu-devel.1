Received: from eggs.gnu.org ([2001:4830:134:3::10]:41365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gAa3h-0006X2-9V
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gAa3c-0007Wg-5H
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:27:15 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a]:43682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gAa3b-0007Ta-QH
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:27:12 -0400
Received: by mail-lf1-x12a.google.com with SMTP id p34-v6so6519274lfg.10
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 05:27:10 -0700 (PDT)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Thu, 11 Oct 2018 18:23:17 +0600
Message-Id: <eb3d1e430d7826c7609d31172008d7e292d96616.1539259394.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539259394.git.artem.k.pisarenko@gmail.com>
References: <cover.1539259394.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539259394.git.artem.k.pisarenko@gmail.com>
References: <cover.1539259394.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH 2/4] vl: refactor -rtc option references
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Improve code readability and prepare for fixing bug #1797033

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
---
 vl.c | 82 +++++++++++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 33 deletions(-)

diff --git a/vl.c b/vl.c
index 4e25c78..3a1346f 100644
--- a/vl.c
+++ b/vl.c
@@ -147,8 +147,13 @@ bool enable_cpu_pm = false;
 int nb_nics;
 NICInfo nd_table[MAX_NICS];
 int autostart;
-static int rtc_utc = 1;
-static int rtc_date_offset = -1; /* -1 means no change */
+static enum {
+    RTC_BASE_UTC,
+    RTC_BASE_LOCALTIME,
+    RTC_BASE_DATETIME,
+} rtc_base_type = RTC_BASE_UTC;
+static int rtc_host_datetime_offset = -1; /* valid only for host rtc_clock and
+                                             rtc_base_type=RTC_BASE_DATETIME */
 QEMUClockType rtc_clock;
 int vga_interface_type = VGA_NONE;
 static DisplayOptions dpy;
@@ -782,26 +787,30 @@ void qemu_system_vmstop_request(RunState state)
 /***********************************************************/
 /* real time host monotonic timer */
 
-static time_t qemu_time(void)
+static time_t qemu_timedate(void)
 {
     return qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
 }
 
 /***********************************************************/
-/* host time/date access */
+/* RTC reference time/date access */
 void qemu_get_timedate(struct tm *tm, int offset)
 {
-    time_t ti = qemu_time();
+    time_t ti = qemu_timedate();
 
     ti += offset;
-    if (rtc_date_offset == -1) {
-        if (rtc_utc)
-            gmtime_r(&ti, tm);
-        else
-            localtime_r(&ti, tm);
-    } else {
-        ti -= rtc_date_offset;
+
+    switch (rtc_base_type) {
+    case RTC_BASE_UTC:
+        gmtime_r(&ti, tm);
+        break;
+    case RTC_BASE_LOCALTIME:
+        localtime_r(&ti, tm);
+        break;
+    case RTC_BASE_DATETIME:
+        ti -= rtc_host_datetime_offset;
         gmtime_r(&ti, tm);
+        break;
     }
 }
 
@@ -809,23 +818,28 @@ int qemu_timedate_diff(struct tm *tm)
 {
     time_t seconds;
 
-    if (rtc_date_offset == -1)
-        if (rtc_utc)
-            seconds = mktimegm(tm);
-        else {
-            struct tm tmp = *tm;
-            tmp.tm_isdst = -1; /* use timezone to figure it out */
-            seconds = mktime(&tmp);
-	}
-    else
-        seconds = mktimegm(tm) + rtc_date_offset;
-
-    return seconds - qemu_time();
+    switch (rtc_base_type) {
+    case RTC_BASE_UTC:
+        seconds = mktimegm(tm);
+        break;
+    case RTC_BASE_LOCALTIME:
+    {
+        struct tm tmp = *tm;
+        tmp.tm_isdst = -1; /* use timezone to figure it out */
+        seconds = mktime(&tmp);
+        break;
+    }
+    case RTC_BASE_DATETIME:
+        seconds = mktimegm(tm) + rtc_host_datetime_offset;
+        break;
+    }
+
+    return seconds - qemu_timedate();
 }
 
-static void configure_rtc_date_offset(const char *startdate)
+static void configure_rtc_host_datetime_offset(const char *startdate)
 {
-    time_t rtc_start_date;
+    time_t rtc_start_datetime;
     struct tm tm;
 
     if (sscanf(startdate, "%d-%d-%dT%d:%d:%d", &tm.tm_year, &tm.tm_mon,
@@ -841,15 +855,16 @@ static void configure_rtc_date_offset(const char *startdate)
     }
     tm.tm_year -= 1900;
     tm.tm_mon--;
-    rtc_start_date = mktimegm(&tm);
-    if (rtc_start_date == -1) {
+    rtc_start_datetime = mktimegm(&tm);
+    if (rtc_start_datetime == -1) {
     date_fail:
-        error_report("invalid date format");
+        error_report("invalid datetime format");
         error_printf("valid formats: "
                      "'2006-06-17T16:01:21' or '2006-06-17'\n");
         exit(1);
     }
-    rtc_date_offset = qemu_time() - rtc_start_date;
+    rtc_host_datetime_offset = (qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000)
+                               - rtc_start_datetime;
 }
 
 static void configure_rtc(QemuOpts *opts)
@@ -859,15 +874,16 @@ static void configure_rtc(QemuOpts *opts)
     value = qemu_opt_get(opts, "base");
     if (value) {
         if (!strcmp(value, "utc")) {
-            rtc_utc = 1;
+            rtc_base_type = RTC_BASE_UTC;
         } else if (!strcmp(value, "localtime")) {
             Error *blocker = NULL;
-            rtc_utc = 0;
+            rtc_base_type = RTC_BASE_LOCALTIME;
             error_setg(&blocker, QERR_REPLAY_NOT_SUPPORTED,
                       "-rtc base=localtime");
             replay_add_blocker(blocker);
         } else {
-            configure_rtc_date_offset(value);
+            rtc_base_type = RTC_BASE_DATETIME;
+            configure_rtc_host_datetime_offset(value);
         }
     }
     value = qemu_opt_get(opts, "clock");
-- 
2.7.4
