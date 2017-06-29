Received: from eggs.gnu.org ([2001:4830:134:3::10]:58853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQfNr-0005HE-W0
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dQfNo-0007SB-LM
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:45:48 -0400
Received: from mail-sn1nam02on0052.outbound.protection.outlook.com
	([104.47.36.52]:4077
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dQfNo-0007Rt-BF
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 15:45:44 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 29 Jun 2017 12:42:38 -0700
Message-ID: <0b14290d85eceaa145e0333c26826b14304e23e4.1498761179.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1498761179.git.alistair.francis@xilinx.com>
References: <cover.1498761179.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v2 2/3] qemu-error: Implement a more generic
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com

This patch removes the exisinting error_vreport() function and replaces it
with a more generic vreport() function that takes an enum describing the
information to be reported.

As part of this change a report() function is added as well with the
same capability.

To maintain full compatibility the original error_report() function is
maintained and no changes to the way errors are printed have been made.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 hw/virtio/virtio.c          |  2 +-
 include/qemu/error-report.h | 10 +++++++++-
 scripts/checkpatch.pl       |  3 ++-
 util/qemu-error.c           | 33 ++++++++++++++++++++++++++++++---
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 464947f76d..bd3d26abb7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2448,7 +2448,7 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
     va_list ap;
 
     va_start(ap, fmt);
-    error_vreport(fmt, ap);
+    vreport(ERROR, fmt, ap);
     va_end(ap);
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 3001865896..39b554c3b9 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -21,6 +21,12 @@ typedef struct Location {
     struct Location *prev;
 } Location;
 
+typedef enum {
+    ERROR,
+    WARN,
+    INFO,
+} report_types;
+
 Location *loc_push_restore(Location *loc);
 Location *loc_push_none(Location *loc);
 Location *loc_pop(Location *loc);
@@ -30,12 +36,14 @@ void loc_set_none(void);
 void loc_set_cmdline(char **argv, int idx, int cnt);
 void loc_set_file(const char *fname, int lno);
 
+void vreport(report_types type, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
+void report(report_types type, const char *fmt, ...)  GCC_FMT_ATTR(2, 3);
+
 void error_vprintf(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 void error_printf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void error_vprintf_unless_qmp(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 void error_printf_unless_qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void error_set_progname(const char *argv0);
-void error_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 const char *error_get_progname(void);
 extern bool enable_timestamp_msg;
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 45027b9281..4a3074e758 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2530,7 +2530,8 @@ sub process {
 				error_set|
 				error_prepend|
 				error_reportf_err|
-				error_vreport|
+				vreport|
+				report|
 				error_report}x;
 
 	if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
diff --git a/util/qemu-error.c b/util/qemu-error.c
index 1c5e35ecdb..83206532dd 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -179,17 +179,28 @@ static void print_loc(void)
 
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
+void vreport(report_types type, const char *fmt, va_list ap)
 {
     GTimeVal tv;
     gchar *timestr;
 
+    switch (type) {
+    case ERROR:
+        /* To maintin compatibility we don't add anything here */
+        break;
+    case WARN:
+        error_printf("warning: ");
+        break;
+    case INFO:
+        error_printf("info: ");
+        break;
+    }
     if (enable_timestamp_msg && !cur_mon) {
         g_get_current_time(&tv);
         timestr = g_time_val_to_iso8601(&tv);
@@ -203,6 +214,22 @@ void error_vreport(const char *fmt, va_list ap)
 }
 
 /*
+ * Print a message to current monitor if we have one, else to stderr.
+ * Format arguments like sprintf().  The resulting message should be a
+ * single phrase, with no newline or trailing punctuation.
+ * Prepend the current location and append a newline.
+ * It's wrong to call this in a QMP monitor.  Use error_setg() there.
+ */
+void report(report_types type, const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    vreport(type, fmt, ap);
+    va_end(ap);
+}
+
+/*
  * Print an error message to current monitor if we have one, else to stderr.
  * Format arguments like sprintf().  The resulting message should be a
  * single phrase, with no newline or trailing punctuation.
@@ -214,6 +241,6 @@ void error_report(const char *fmt, ...)
     va_list ap;
 
     va_start(ap, fmt);
-    error_vreport(fmt, ap);
+    vreport(ERROR, fmt, ap);
     va_end(ap);
 }
-- 
2.11.0
