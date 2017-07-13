Received: from eggs.gnu.org ([2001:4830:134:3::10]:59095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVeA0-0008V7-Hl
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVe9x-0001L7-6d
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVe9w-0001KM-UC
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Jul 2017 15:27:52 +0200
Message-Id: <1499952476-3454-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1499952476-3454-1-git-send-email-armbru@redhat.com>
References: <1499952476-3454-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] error: Functions to report warnings and
 informational messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>

From: Alistair Francis <alistair.francis@xilinx.com>

Add warn_report(), warn_vreport() for reporting warnings, and
info_report(), info_vreport() for informational messages.

These are implemented them with a helper function factored out of
error_vreport(), suitably generalized. This patch makes no changes
to the output of the original error_report() function.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <c89e9980019f296ec9aa38d7689ac4d5c369296d.1499866456.git.alistair.francis@xilinx.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/error-report.h |   7 +++
 scripts/checkpatch.pl       |   6 ++-
 util/qemu-error.c           | 102 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 3001865..e1c8ae1 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -35,8 +35,15 @@ void error_printf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void error_vprintf_unless_qmp(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 void error_printf_unless_qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void error_set_progname(const char *argv0);
+
 void error_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
+void warn_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
+void info_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
+
 void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
+void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
+void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
+
 const char *error_get_progname(void);
 extern bool enable_timestamp_msg;
 
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 73efc92..9287cc5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2535,7 +2535,11 @@ sub process {
 				error_prepend|
 				error_reportf_err|
 				error_vreport|
-				error_report}x;
+				warn_vreport|
+				info_vreport|
+				error_report|
+				warn_report|
+				info_report}x;
 
 	if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
 		ERROR("Error messages should not contain newlines\n" . $herecurr);
diff --git a/util/qemu-error.c b/util/qemu-error.c
index 1c5e35e..c557c6a 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -14,6 +14,16 @@
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 
+/*
+ * @report_type is the type of message: error, warning or
+ * informational.
+ */
+typedef enum {
+    REPORT_TYPE_ERROR,
+    REPORT_TYPE_WARNING,
+    REPORT_TYPE_INFO,
+} report_type;
+
 void error_printf(const char *fmt, ...)
 {
     va_list ap;
@@ -179,17 +189,29 @@ static void print_loc(void)
 
 bool enable_timestamp_msg;
 /*
- * Print an error message to current monitor if we have one, else to stderr.
+ * Print a message to current monitor if we have one, else to stderr.
+ * @report_type is the type of message: error, warning or informational.
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
  * It's wrong to call this in a QMP monitor.  Use error_setg() there.
  */
-void error_vreport(const char *fmt, va_list ap)
+static void vreport(report_type type, const char *fmt, va_list ap)
 {
     GTimeVal tv;
     gchar *timestr;
 
+    switch (type) {
+    case REPORT_TYPE_ERROR:
+        break;
+    case REPORT_TYPE_WARNING:
+        error_printf("warning: ");
+        break;
+    case REPORT_TYPE_INFO:
+        error_printf("info: ");
+        break;
+    }
+
     if (enable_timestamp_msg && !cur_mon) {
         g_get_current_time(&tv);
         timestr = g_time_val_to_iso8601(&tv);
@@ -204,8 +226,45 @@ void error_vreport(const char *fmt, va_list ap)
 
 /*
  * Print an error message to current monitor if we have one, else to stderr.
- * Format arguments like sprintf().  The resulting message should be a
- * single phrase, with no newline or trailing punctuation.
+ * Format arguments like vsprintf().  The resulting message should be
+ * a single phrase, with no newline or trailing punctuation.
+ * Prepend the current location and append a newline.
+ * It's wrong to call this in a QMP monitor.  Use error_setg() there.
+ */
+void error_vreport(const char *fmt, va_list ap)
+{
+    vreport(REPORT_TYPE_ERROR, fmt, ap);
+}
+
+/*
+ * Print a warning message to current monitor if we have one, else to stderr.
+ * Format arguments like vsprintf().  The resulting message should be
+ * a single phrase, with no newline or trailing punctuation.
+ * Prepend the current location and append a newline.
+ * It's wrong to call this in a QMP monitor.  Use error_setg() there.
+ */
+void warn_vreport(const char *fmt, va_list ap)
+{
+    vreport(REPORT_TYPE_WARNING, fmt, ap);
+}
+
+/*
+ * Print an information message to current monitor if we have one, else to
+ * stderr.
+ * Format arguments like vsprintf().  The resulting message should be
+ * a single phrase, with no newline or trailing punctuation.
+ * Prepend the current location and append a newline.
+ * It's wrong to call this in a QMP monitor.  Use error_setg() there.
+ */
+void info_vreport(const char *fmt, va_list ap)
+{
+    vreport(REPORT_TYPE_INFO, fmt, ap);
+}
+
+/*
+ * Print an error message to current monitor if we have one, else to stderr.
+ * Format arguments like sprintf().  The resulting message should be
+ * a single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
  * It's wrong to call this in a QMP monitor.  Use error_setg() there.
  */
@@ -214,6 +273,39 @@ void error_report(const char *fmt, ...)
     va_list ap;
 
     va_start(ap, fmt);
-    error_vreport(fmt, ap);
+    vreport(REPORT_TYPE_ERROR, fmt, ap);
+    va_end(ap);
+}
+
+/*
+ * Print a warning message to current monitor if we have one, else to stderr.
+ * Format arguments like sprintf(). The resulting message should be a
+ * single phrase, with no newline or trailing punctuation.
+ * Prepend the current location and append a newline.
+ * It's wrong to call this in a QMP monitor.  Use error_setg() there.
+ */
+void warn_report(const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    vreport(REPORT_TYPE_WARNING, fmt, ap);
+    va_end(ap);
+}
+
+/*
+ * Print an information message to current monitor if we have one, else to
+ * stderr.
+ * Format arguments like sprintf(). The resulting message should be a
+ * single phrase, with no newline or trailing punctuation.
+ * Prepend the current location and append a newline.
+ * It's wrong to call this in a QMP monitor.  Use error_setg() there.
+ */
+void info_report(const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    vreport(REPORT_TYPE_INFO, fmt, ap);
     va_end(ap);
 }
-- 
2.7.5
