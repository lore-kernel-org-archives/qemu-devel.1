Received: from eggs.gnu.org ([2001:4830:134:3::10]:51964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuIuS-00082s-0W
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuIuQ-0001rQ-Sa
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:54:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37652 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fuIuQ-0001rH-Mb
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 10:54:26 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 27 Aug 2018 16:54:11 +0200
Message-Id: <1535381652-19870-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1535381652-19870-1-git-send-email-thuth@redhat.com>
References: <1535381652-19870-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] Remove the deprecated options -startdate,
 -localtime and -rtc-td-hack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, libvir-list@redhat.com, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

Deprecated since two releases, nobody complained, thus it's time to
remove them now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-deprecated.texi | 13 ---------
 qemu-options.hx      |  7 -----
 vl.c                 | 76 +++++++++++++++-------------------------------------
 3 files changed, 22 insertions(+), 74 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 19c8ae2..ca52e83 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -96,19 +96,6 @@ The @code{--no-frame} argument works with SDL 1.2 only. The other user
 interfaces never implemented this in the first place. So this will be
 removed together with SDL 1.2 support.
 
-@subsection -rtc-td-hack (since 2.12.0)
-
-The @code{-rtc-td-hack} option has been replaced by
-@code{-rtc driftfix=slew}.
-
-@subsection -localtime (since 2.12.0)
-
-The @code{-localtime} option has been replaced by @code{-rtc base=localtime}.
-
-@subsection -startdate (since 2.12.0)
-
-The @code{-startdate} option has been replaced by @code{-rtc base=@var{date}}.
-
 @subsection -virtioconsole (since 3.0.0)
 
 Option @option{-virtioconsole} has been replaced by
diff --git a/qemu-options.hx b/qemu-options.hx
index d9be20b..7ca539a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1711,9 +1711,6 @@ Windows 2000 is installed, you no longer need this option (this option
 slows down the IDE transfers).
 ETEXI
 
-HXCOMM Deprecated by -rtc
-DEF("rtc-td-hack", 0, QEMU_OPTION_rtc_td_hack, "", QEMU_ARCH_I386)
-
 DEF("no-fd-bootchk", 0, QEMU_OPTION_no_fd_bootchk,
     "-no-fd-bootchk  disable boot signature checking for floppy disks\n",
     QEMU_ARCH_I386)
@@ -3471,10 +3468,6 @@ ETEXI
 HXCOMM Silently ignored for compatibility
 DEF("clock", HAS_ARG, QEMU_OPTION_clock, "", QEMU_ARCH_ALL)
 
-HXCOMM Options deprecated by -rtc
-DEF("localtime", 0, QEMU_OPTION_localtime, "", QEMU_ARCH_ALL)
-DEF("startdate", HAS_ARG, QEMU_OPTION_startdate, "", QEMU_ARCH_ALL)
-
 DEF("rtc", HAS_ARG, QEMU_OPTION_rtc, \
     "-rtc [base=utc|localtime|date][,clock=host|rt|vm][,driftfix=none|slew]\n" \
     "                set the RTC base and clock, enable drift fix for clock ticks (x86 only)\n",
diff --git a/vl.c b/vl.c
index 386c71d..cfeee0d 100644
--- a/vl.c
+++ b/vl.c
@@ -823,44 +823,33 @@ int qemu_timedate_diff(struct tm *tm)
     return seconds - qemu_time();
 }
 
-static void configure_rtc_date_offset(const char *startdate, int legacy)
+static void configure_rtc_date_offset(const char *startdate)
 {
     time_t rtc_start_date;
     struct tm tm;
 
-    if (!strcmp(startdate, "now") && legacy) {
-        rtc_date_offset = -1;
+    if (sscanf(startdate, "%d-%d-%dT%d:%d:%d", &tm.tm_year, &tm.tm_mon,
+               &tm.tm_mday, &tm.tm_hour, &tm.tm_min, &tm.tm_sec) == 6) {
+        /* OK */
+    } else if (sscanf(startdate, "%d-%d-%d",
+                      &tm.tm_year, &tm.tm_mon, &tm.tm_mday) == 3) {
+        tm.tm_hour = 0;
+        tm.tm_min = 0;
+        tm.tm_sec = 0;
     } else {
-        if (sscanf(startdate, "%d-%d-%dT%d:%d:%d",
-                   &tm.tm_year,
-                   &tm.tm_mon,
-                   &tm.tm_mday,
-                   &tm.tm_hour,
-                   &tm.tm_min,
-                   &tm.tm_sec) == 6) {
-            /* OK */
-        } else if (sscanf(startdate, "%d-%d-%d",
-                          &tm.tm_year,
-                          &tm.tm_mon,
-                          &tm.tm_mday) == 3) {
-            tm.tm_hour = 0;
-            tm.tm_min = 0;
-            tm.tm_sec = 0;
-        } else {
-            goto date_fail;
-        }
-        tm.tm_year -= 1900;
-        tm.tm_mon--;
-        rtc_start_date = mktimegm(&tm);
-        if (rtc_start_date == -1) {
-        date_fail:
-            error_report("invalid date format");
-            error_printf("valid formats: "
-                         "'2006-06-17T16:01:21' or '2006-06-17'\n");
-            exit(1);
-        }
-        rtc_date_offset = qemu_time() - rtc_start_date;
+        goto date_fail;
+    }
+    tm.tm_year -= 1900;
+    tm.tm_mon--;
+    rtc_start_date = mktimegm(&tm);
+    if (rtc_start_date == -1) {
+    date_fail:
+        error_report("invalid date format");
+        error_printf("valid formats: "
+                     "'2006-06-17T16:01:21' or '2006-06-17'\n");
+        exit(1);
     }
+    rtc_date_offset = qemu_time() - rtc_start_date;
 }
 
 static void configure_rtc(QemuOpts *opts)
@@ -878,7 +867,7 @@ static void configure_rtc(QemuOpts *opts)
                       "-rtc base=localtime");
             replay_add_blocker(blocker);
         } else {
-            configure_rtc_date_offset(value, 0);
+            configure_rtc_date_offset(value);
         }
     }
     value = qemu_opt_get(opts, "clock");
@@ -3269,11 +3258,6 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_k:
                 keyboard_layout = optarg;
                 break;
-            case QEMU_OPTION_localtime:
-                rtc_utc = 0;
-                warn_report("This option is deprecated, "
-                            "use '-rtc base=localtime' instead.");
-                break;
             case QEMU_OPTION_vga:
                 vga_model = optarg;
                 default_vga = 0;
@@ -3526,18 +3510,6 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_win2k_hack:
                 win2k_install_hack = 1;
                 break;
-            case QEMU_OPTION_rtc_td_hack: {
-                static GlobalProperty slew_lost_ticks = {
-                    .driver   = "mc146818rtc",
-                    .property = "lost_tick_policy",
-                    .value    = "slew",
-                };
-
-                qdev_prop_register_global(&slew_lost_ticks);
-                warn_report("This option is deprecated, "
-                            "use '-rtc driftfix=slew' instead.");
-                break;
-            }
             case QEMU_OPTION_acpitable:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("acpi"),
                                                optarg, true);
@@ -3723,10 +3695,6 @@ int main(int argc, char **argv, char **envp)
                  */
                 warn_report("This option is ignored and will be removed soon");
                 break;
-            case QEMU_OPTION_startdate:
-                warn_report("This option is deprecated, use '-rtc base=' instead.");
-                configure_rtc_date_offset(optarg, 1);
-                break;
             case QEMU_OPTION_rtc:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("rtc"), optarg,
                                                false);
-- 
1.8.3.1
