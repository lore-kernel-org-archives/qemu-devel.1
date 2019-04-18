Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED28FC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B272620869
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B272620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHE8N-00030b-TX
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 16:59:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0U-00056Q-WB
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0S-0005CY-KJ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0S-0005Am-8N
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8379289C4C
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DE9019C79;
	Thu, 18 Apr 2019 20:51:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 6F5FF11327DB; Thu, 18 Apr 2019 22:51:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 22:51:13 +0200
Message-Id: <20190418205135.6686-15-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 18 Apr 2019 20:51:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 14/36] monitor error: Make printf()-like
 functions return a value
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418205113.zyKWjDejxK69bu6Phm-vCWnOtxrU531Q59KP3BR_Bng@z>

printf() & friends return the number of characters written on success,
negative value on error.

monitor_printf(), monitor_vfprintf(), monitor_vprintf(),
error_printf(), error_printf_unless_qmp(), error_vprintf(), and
error_vprintf_unless_qmp() return void.  Some of them carry a TODO
comment asking for int instead.

Improve them to return int like printf() does.

This makes our use of monitor_printf() as fprintf_function slightly
less dirty: the function cast no longer adds a return value that isn't
there.  It still changes a parameter's pointer type.  That will be
addressed in a future commit.

monitor_vfprintf() always returns zero.  Improve it to return the
proper value.

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190417190641.26814-11-armbru@redhat.com>
---
 include/monitor/monitor.h   |  8 ++---
 include/qemu/error-report.h |  8 ++---
 monitor.c                   | 61 ++++++++++++++++++++-----------------
 stubs/error-printf.c        | 13 +++++---
 util/qemu-error.c           | 12 +++++---
 5 files changed, 57 insertions(+), 45 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index c1b40a9cac..e4c3717454 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -28,9 +28,9 @@ void monitor_resume(Monitor *mon);
 int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp);
 int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp);
 
-void monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
+int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
     GCC_FMT_ATTR(2, 0);
-void monitor_printf(Monitor *mon, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
+int monitor_printf(Monitor *mon, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 int monitor_fprintf(FILE *stream, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 void monitor_flush(Monitor *mon);
 int monitor_set_cpu(int cpu_index);
@@ -48,7 +48,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
 void monitor_fdset_dup_fd_remove(int dup_fd);
 int monitor_fdset_dup_fd_find(int dup_fd);
 
-void monitor_vfprintf(FILE *stream,
-                      const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
+int monitor_vfprintf(FILE *stream,
+                     const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
 
 #endif /* MONITOR_H */
diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index ce43c02314..00d069b20f 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -30,10 +30,10 @@ void loc_set_none(void);
 void loc_set_cmdline(char **argv, int idx, int cnt);
 void loc_set_file(const char *fname, int lno);
 
-void error_vprintf(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
-void error_printf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
-void error_vprintf_unless_qmp(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
-void error_printf_unless_qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
+int error_vprintf(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
+int error_printf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
+int error_vprintf_unless_qmp(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
+int error_printf_unless_qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
 void error_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 void warn_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
diff --git a/monitor.c b/monitor.c
index 4807bbe811..7b4a78d798 100644
--- a/monitor.c
+++ b/monitor.c
@@ -430,15 +430,14 @@ void monitor_flush(Monitor *mon)
 }
 
 /* flush at every end of line */
-static void monitor_puts(Monitor *mon, const char *str)
+static int monitor_puts(Monitor *mon, const char *str)
 {
+    int i;
     char c;
 
     qemu_mutex_lock(&mon->mon_lock);
-    for(;;) {
-        c = *str++;
-        if (c == '\0')
-            break;
+    for (i = 0; str[i]; i++) {
+        c = str[i];
         if (c == '\n') {
             qstring_append_chr(mon->outbuf, '\r');
         }
@@ -448,39 +447,48 @@ static void monitor_puts(Monitor *mon, const char *str)
         }
     }
     qemu_mutex_unlock(&mon->mon_lock);
+
+    return i;
 }
 
-void monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
+int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 {
     char *buf;
+    int n;
 
     if (!mon)
-        return;
+        return -1;
 
     if (monitor_is_qmp(mon)) {
-        return;
+        return -1;
     }
 
     buf = g_strdup_vprintf(fmt, ap);
-    monitor_puts(mon, buf);
+    n = monitor_puts(mon, buf);
     g_free(buf);
+    return n;
 }
 
-void monitor_printf(Monitor *mon, const char *fmt, ...)
+int monitor_printf(Monitor *mon, const char *fmt, ...)
 {
+    int ret;
+
     va_list ap;
     va_start(ap, fmt);
-    monitor_vprintf(mon, fmt, ap);
+    ret = monitor_vprintf(mon, fmt, ap);
     va_end(ap);
+    return ret;
 }
 
 int monitor_fprintf(FILE *stream, const char *fmt, ...)
 {
+    int ret;
+
     va_list ap;
     va_start(ap, fmt);
-    monitor_vprintf((Monitor *)stream, fmt, ap);
+    ret = monitor_vprintf((Monitor *)stream, fmt, ap);
     va_end(ap);
-    return 0;
+    return ret;
 }
 
 static void qmp_send_response(Monitor *mon, const QDict *rsp)
@@ -4535,35 +4543,32 @@ static void monitor_readline_flush(void *opaque)
 
 /*
  * Print to current monitor if we have one, else to stream.
- * TODO should return int, so callers can calculate width, but that
- * requires surgery to monitor_vprintf().  Left for another day.
  */
-void monitor_vfprintf(FILE *stream, const char *fmt, va_list ap)
+int monitor_vfprintf(FILE *stream, const char *fmt, va_list ap)
 {
     if (cur_mon && !monitor_cur_is_qmp()) {
-        monitor_vprintf(cur_mon, fmt, ap);
-    } else {
-        vfprintf(stream, fmt, ap);
+        return monitor_vprintf(cur_mon, fmt, ap);
     }
+    return vfprintf(stream, fmt, ap);
 }
 
 /*
  * Print to current monitor if we have one, else to stderr.
- * TODO should return int, so callers can calculate width, but that
- * requires surgery to monitor_vprintf().  Left for another day.
  */
-void error_vprintf(const char *fmt, va_list ap)
+int error_vprintf(const char *fmt, va_list ap)
 {
-    monitor_vfprintf(stderr, fmt, ap);
+    return monitor_vfprintf(stderr, fmt, ap);
 }
 
-void error_vprintf_unless_qmp(const char *fmt, va_list ap)
+int error_vprintf_unless_qmp(const char *fmt, va_list ap)
 {
-    if (cur_mon && !monitor_cur_is_qmp()) {
-        monitor_vprintf(cur_mon, fmt, ap);
-    } else if (!cur_mon) {
-        vfprintf(stderr, fmt, ap);
+    if (!cur_mon) {
+        return vfprintf(stderr, fmt, ap);
     }
+    if (!monitor_cur_is_qmp()) {
+        return monitor_vprintf(cur_mon, fmt, ap);
+    }
+    return -1;
 }
 
 static void monitor_list_append(Monitor *mon)
diff --git a/stubs/error-printf.c b/stubs/error-printf.c
index 99c6406668..1f9d3b3714 100644
--- a/stubs/error-printf.c
+++ b/stubs/error-printf.c
@@ -2,19 +2,22 @@
 #include "qemu-common.h"
 #include "qemu/error-report.h"
 
-void error_vprintf(const char *fmt, va_list ap)
+int error_vprintf(const char *fmt, va_list ap)
 {
+    int ret;
+
     if (g_test_initialized() && !g_test_subprocess() &&
         getenv("QTEST_SILENT_ERRORS")) {
         char *msg = g_strdup_vprintf(fmt, ap);
         g_test_message("%s", msg);
+        ret = strlen(msg);
         g_free(msg);
-    } else {
-        vfprintf(stderr, fmt, ap);
+        return ret;
     }
+    return vfprintf(stderr, fmt, ap);
 }
 
-void error_vprintf_unless_qmp(const char *fmt, va_list ap)
+int error_vprintf_unless_qmp(const char *fmt, va_list ap)
 {
-    error_vprintf(fmt, ap);
+    return error_vprintf(fmt, ap);
 }
diff --git a/util/qemu-error.c b/util/qemu-error.c
index d08139d9ac..f373f3b3b0 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -24,22 +24,26 @@ typedef enum {
     REPORT_TYPE_INFO,
 } report_type;
 
-void error_printf(const char *fmt, ...)
+int error_printf(const char *fmt, ...)
 {
     va_list ap;
+    int ret;
 
     va_start(ap, fmt);
-    error_vprintf(fmt, ap);
+    ret = error_vprintf(fmt, ap);
     va_end(ap);
+    return ret;
 }
 
-void error_printf_unless_qmp(const char *fmt, ...)
+int error_printf_unless_qmp(const char *fmt, ...)
 {
     va_list ap;
+    int ret;
 
     va_start(ap, fmt);
-    error_vprintf_unless_qmp(fmt, ap);
+    ret = error_vprintf_unless_qmp(fmt, ap);
     va_end(ap);
+    return ret;
 }
 
 static Location std_loc = {
-- 
2.17.2


