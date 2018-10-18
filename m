Received: from eggs.gnu.org ([2001:4830:134:3::10]:48167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyK-0007Kw-S0
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyG-0006KO-9K
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:35103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyF-0006Ig-IY
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id o17-v6so900454wmh.0
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:38 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:45 +0200
Message-Id: <1539894735-14232-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/48] Fixes RTC bug with base datetime shifts
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
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>

From: Artem Pisarenko <artem.k.pisarenko@gmail.com>

This makes all current "-rtc" option parameters combinations produce
fixed/unambiguous RTC timedate reference for hardware emulation
frontends.
It restores determinism of guest execution when used with clock=vm and
specified base <datetime> value.

Buglink: https://bugs.launchpad.net/qemu/+bug/1797033
Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Message-Id: <1d963c3e013dfedafa1f6edb9fb219b7e49e39da.1539846575.git.artem.k.pisarenko@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 62 +++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/vl.c b/vl.c
index d15e086..5bb53f7 100644
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
@@ -247,6 +249,7 @@ static struct {
 static QemuOptsList qemu_rtc_opts = {
     .name = "rtc",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_rtc_opts.head),
+    .merge_lists = true,
     .desc = {
         {
             .name = "base",
@@ -785,32 +788,42 @@ void qemu_system_vmstop_request(RunState state)
 }
 
 /***********************************************************/
-/* real time host monotonic timer */
-
-static time_t qemu_timedate(void)
+/* RTC reference time/date access */
+static time_t qemu_ref_timedate(void)
 {
-    return qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
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
 }
 
-/***********************************************************/
-/* RTC reference time/date access */
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
 
@@ -819,6 +832,7 @@ int qemu_timedate_diff(struct tm *tm)
     time_t seconds;
 
     switch (rtc_base_type) {
+    case RTC_BASE_DATETIME:
     case RTC_BASE_UTC:
         seconds = mktimegm(tm);
         break;
@@ -829,17 +843,14 @@ int qemu_timedate_diff(struct tm *tm)
         seconds = mktime(&tmp);
         break;
     }
-    case RTC_BASE_DATETIME:
-        seconds = mktimegm(tm) + rtc_host_datetime_offset;
-        break;
     default:
         abort();
     }
 
-    return seconds - qemu_timedate();
+    return seconds - qemu_ref_timedate();
 }
 
-static void configure_rtc_host_datetime_offset(const char *startdate)
+static void configure_rtc_base_datetime(const char *startdate)
 {
     time_t rtc_start_datetime;
     struct tm tm;
@@ -865,14 +876,19 @@ static void configure_rtc_host_datetime_offset(const char *startdate)
                      "'2006-06-17T16:01:21' or '2006-06-17'\n");
         exit(1);
     }
-    rtc_host_datetime_offset = (qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000)
-                               - rtc_start_datetime;
+    rtc_host_datetime_offset = rtc_ref_start_datetime - rtc_start_datetime;
+    rtc_ref_start_datetime = rtc_start_datetime;
 }
 
 static void configure_rtc(QemuOpts *opts)
 {
     const char *value;
 
+    /* Set defaults */
+    rtc_clock = QEMU_CLOCK_HOST;
+    rtc_ref_start_datetime = qemu_clock_get_ms(QEMU_CLOCK_HOST) / 1000;
+    rtc_realtime_clock_offset = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) / 1000;
+
     value = qemu_opt_get(opts, "base");
     if (value) {
         if (!strcmp(value, "utc")) {
@@ -885,7 +901,7 @@ static void configure_rtc(QemuOpts *opts)
             replay_add_blocker(blocker);
         } else {
             rtc_base_type = RTC_BASE_DATETIME;
-            configure_rtc_host_datetime_offset(value);
+            configure_rtc_base_datetime(value);
         }
     }
     value = qemu_opt_get(opts, "clock");
@@ -3035,7 +3051,6 @@ int main(int argc, char **argv, char **envp)
         error_reportf_err(err, "cannot initialize crypto: ");
         exit(1);
     }
-    rtc_clock = QEMU_CLOCK_HOST;
 
     QLIST_INIT (&vm_change_state_head);
     os_setup_early_signal_handling();
@@ -3755,7 +3770,6 @@ int main(int argc, char **argv, char **envp)
                 if (!opts) {
                     exit(1);
                 }
-                configure_rtc(opts);
                 break;
             case QEMU_OPTION_tb_size:
 #ifndef CONFIG_TCG
@@ -3973,6 +3987,8 @@ int main(int argc, char **argv, char **envp)
         exit(EXIT_FAILURE);
     }
 
+    configure_rtc(qemu_find_opts_singleton("rtc"));
+
     machine_class = select_machine();
 
     set_memory_options(&ram_slots, &maxram_size, machine_class);
-- 
1.8.3.1
