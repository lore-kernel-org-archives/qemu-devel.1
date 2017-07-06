Received: from eggs.gnu.org ([2001:4830:134:3::10]:36708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dTGZv-0004kO-MW
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dTGZr-0000ty-14
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:52:59 -0400
Received: from mail-by2nam01on0074.outbound.protection.outlook.com
	([104.47.34.74]:10464
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dTGZq-0000st-JQ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:52:54 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 6 Jul 2017 16:49:40 -0700
Message-ID: <d336619e0669e403eda360879c135db873a5867f.1499381754.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1499381754.git.alistair.francis@xilinx.com>
References: <cover.1499381754.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 2/6] error: Functions to report warnings and
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
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com

Add warn_report(), warn_vreport() for reporting warnings, and
info_report(), info_vreport() for informational messages.

These are implemented them with a helper function factored out of
error_vreport(), suitably generalized. As we don't regard error
messages as a stable API the original error messages now have an
'error: ' prefix.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---
v1:
 - Don't expose the generic report and vreport() functions
 - Prefix error messages
 - Use vreport instead of qmsg_vreport()
RFC V3:
 - Change the function and enum names to be more descriptive
 - Add wrapper functions for *_report() and *_vreport()

 include/qemu/error-report.h |  7 ++++
 scripts/checkpatch.pl       |  7 +++-
 util/qemu-error.c           | 78 +++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 3001865896..e1c8ae1a52 100644
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
index 73efc927a9..1fdd7f624a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2534,8 +2534,13 @@ sub process {
 				error_set|
 				error_prepend|
 				error_reportf_err|
+				vreport|
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
index 1c5e35ecdb..f2fc9d5a1e 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -14,6 +14,12 @@
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 
+typedef enum {
+    REPORT_TYPE_ERROR,
+    REPORT_TYPE_WARNING,
+    REPORT_TYPE_INFO,
+} report_type;
+
 void error_printf(const char *fmt, ...)
 {
     va_list ap;
@@ -179,17 +185,29 @@ static void print_loc(void)
 
 bool enable_timestamp_msg;
 /*
- * Print an error message to current monitor if we have one, else to stderr.
+ * Print a message to current monitor if we have one, else to stderr.
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
+        error_printf("error: ");
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
@@ -204,16 +222,62 @@ void error_vreport(const char *fmt, va_list ap)
 
 /*
  * Print an error message to current monitor if we have one, else to stderr.
- * Format arguments like sprintf().  The resulting message should be a
- * single phrase, with no newline or trailing punctuation.
- * Prepend the current location and append a newline.
- * It's wrong to call this in a QMP monitor.  Use error_setg() there.
+ */
+void error_vreport(const char *fmt, va_list ap)
+{
+    vreport(REPORT_TYPE_ERROR, fmt, ap);
+}
+
+/*
+ * Print a warning message to current monitor if we have one, else to stderr.
+ */
+void warn_vreport(const char *fmt, va_list ap)
+{
+    vreport(REPORT_TYPE_WARNING, fmt, ap);
+}
+
+/*
+ * Print an information message to current monitor if we have one, else to
+ * stderr.
+ */
+void info_vreport(const char *fmt, va_list ap)
+{
+    vreport(REPORT_TYPE_INFO, fmt, ap);
+}
+
+/*
+ * Print an error message to current monitor if we have one, else to stderr.
  */
 void error_report(const char *fmt, ...)
 {
     va_list ap;
 
     va_start(ap, fmt);
-    error_vreport(fmt, ap);
+    vreport(REPORT_TYPE_ERROR, fmt, ap);
+    va_end(ap);
+}
+
+/*
+ * Print a warning message to current monitor if we have one, else to stderr.
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
2.11.0
