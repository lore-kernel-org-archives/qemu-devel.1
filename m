Received: from eggs.gnu.org ([2001:4830:134:3::10]:33012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gD2V4-0004XQ-8M
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 03:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gD2V1-000072-0H
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 03:13:42 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a]:34828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gD2V0-0008Ud-NQ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 03:13:38 -0400
Received: by mail-lj1-x22a.google.com with SMTP id o14-v6so26722100ljj.2
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 00:13:37 -0700 (PDT)
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Thu, 18 Oct 2018 13:12:54 +0600
Message-Id: <1d963c3e013dfedafa1f6edb9fb219b7e49e39da.1539846575.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539846575.git.artem.k.pisarenko@gmail.com>
References: <cover.1539846575.git.artem.k.pisarenko@gmail.com>
MIME-Version: 1.0
In-Reply-To: <cover.1539846575.git.artem.k.pisarenko@gmail.com>
References: <cover.1539846575.git.artem.k.pisarenko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 3/4] Fixes RTC bug with base datetime shifts
 in clock=vm
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

This makes all current "-rtc" option parameters combinations produce
fixed/unambiguous RTC timedate reference for hardware emulation
frontends.
It restores determinism of guest execution when used with clock=vm and
specified base <datetime> value.

Buglink: https://bugs.launchpad.net/qemu/+bug/1797033
Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
---
 vl.c | 58 +++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/vl.c b/vl.c
index 10c4275..78a8a68 100644
--- a/vl.c
+++ b/vl.c
@@ -152,8 +152,10 @@ static enum {
     RTC_BASE_LOCALTIME,
     RTC_BASE_DATETIME,
 } rtc_base_type = RTC_BASE_UTC;
-static int rtc_host_datetime_offset = -1; /* valid only for host rtc_clock and
-                                             rtc_base_type=RTC_BASE_DATETIME */
+static time_t rtc_ref_start_datetime;
+static int rtc_realtime_clock_offset; /* used only with QEMU_CLOCK_REALTIME */
+static int rtc_host_datetime_offset = -1; /* valid & used only with
+                                             RTC_BASE_DATETIME */
 QEMUClockType rtc_clock;
 int vga_interface_type = VGA_NONE;
 static DisplayOptions dpy;
@@ -785,32 +787,42 @@ void qemu_system_vmstop_request(RunState state)
 }
 
 /***********************************************************/
-/* real time host monotonic timer */
-
-static time_t qemu_timedate(void)
-{
-    return qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
-}
-
-/***********************************************************/
 /* RTC reference time/date access */
+static time_t qemu_ref_timedate(void)
+{
+    time_t value = qemu_clock_get_ms(rtc_clock) / 1000;
+    switch (rtc_clock) {
+    case QEMU_CLOCK_REALTIME:
+        value -= rtc_realtime_clock_offset;
+        /* no break */
+    case QEMU_CLOCK_VIRTUAL:
+        value += rtc_ref_start_datetime;
+        break;
+    case QEMU_CLOCK_HOST:
+        if (rtc_base_type == RTC_BASE_DATETIME) {
+            value -= rtc_host_datetime_offset;
+        }
+        break;
+    default:
+        assert(0);
+    }
+    return value;
+}
+
 void qemu_get_timedate(struct tm *tm, int offset)
 {
-    time_t ti = qemu_timedate();
+    time_t ti = qemu_ref_timedate();
 
     ti += offset;
 
     switch (rtc_base_type) {
+    case RTC_BASE_DATETIME:
     case RTC_BASE_UTC:
         gmtime_r(&ti, tm);
         break;
     case RTC_BASE_LOCALTIME:
         localtime_r(&ti, tm);
         break;
-    case RTC_BASE_DATETIME:
-        ti -= rtc_host_datetime_offset;
-        gmtime_r(&ti, tm);
-        break;
     }
 }
 
@@ -819,6 +831,7 @@ int qemu_timedate_diff(struct tm *tm)
     time_t seconds;
 
     switch (rtc_base_type) {
+    case RTC_BASE_DATETIME:
     case RTC_BASE_UTC:
         seconds = mktimegm(tm);
         break;
@@ -829,9 +842,6 @@ int qemu_timedate_diff(struct tm *tm)
         seconds = mktime(&tmp);
         break;
     }
-    case RTC_BASE_DATETIME:
-        seconds = mktimegm(tm) + rtc_host_datetime_offset;
-        break;
     default:
         /* gcc complains: ‘seconds’ may be used uninitialized */
         g_assert_not_reached();
@@ -839,10 +849,10 @@ int qemu_timedate_diff(struct tm *tm)
         break;
     }
 
-    return seconds - qemu_timedate();
+    return seconds - qemu_ref_timedate();
 }
 
-static void configure_rtc_host_datetime_offset(const char *startdate)
+static void configure_rtc_base_datetime(const char *startdate)
 {
     time_t rtc_start_datetime;
     struct tm tm;
@@ -868,8 +878,8 @@ static void configure_rtc_host_datetime_offset(const char *startdate)
                      "'2006-06-17T16:01:21' or '2006-06-17'\n");
         exit(1);
     }
-    rtc_host_datetime_offset = (qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000)
-                               - rtc_start_datetime;
+    rtc_host_datetime_offset = rtc_ref_start_datetime - rtc_start_datetime;
+    rtc_ref_start_datetime = rtc_start_datetime;
 }
 
 static void configure_rtc(QemuOpts *opts)
@@ -888,7 +898,7 @@ static void configure_rtc(QemuOpts *opts)
             replay_add_blocker(blocker);
         } else {
             rtc_base_type = RTC_BASE_DATETIME;
-            configure_rtc_host_datetime_offset(value);
+            configure_rtc_base_datetime(value);
         }
     }
     value = qemu_opt_get(opts, "clock");
@@ -3039,6 +3049,8 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
     rtc_clock = QEMU_CLOCK_HOST;
+    rtc_ref_start_datetime = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
+    rtc_realtime_clock_offset = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
 
     QLIST_INIT (&vm_change_state_head);
     os_setup_early_signal_handling();
-- 
2.7.4
