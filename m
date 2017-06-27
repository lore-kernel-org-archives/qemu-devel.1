Received: from eggs.gnu.org ([2001:4830:134:3::10]:34573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dPxPy-0002Er-Lz
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dPxPv-000390-KT
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:49:02 -0400
Received: from mail-sn1nam02on0079.outbound.protection.outlook.com
	([104.47.36.79]:45824
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dPxPv-00038J-9e
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:48:59 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 27 Jun 2017 13:45:45 -0700
Message-ID: <4e1eded5cda7b182a8a4cb133b40b2915817b7d1.1498596157.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1498596157.git.alistair.francis@xilinx.com>
References: <cover.1498596157.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 2/3] util/qemu-error: Add a warning_report()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com

Add a functino which can be used similarly to error_report() execpt to
inform the users about warnings instead of errors.

The warning print does not include the timestamp and instead will
preface the messages with a 'warning: '.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

 include/qemu/error-report.h |  2 ++
 util/qemu-error.c           | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 3001865896..c2600d2298 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -36,7 +36,9 @@ void error_vprintf_unless_qmp(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 void error_printf_unless_qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void error_set_progname(const char *argv0);
 void error_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
+void warning_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
+void warning_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 const char *error_get_progname(void);
 extern bool enable_timestamp_msg;
 
diff --git a/util/qemu-error.c b/util/qemu-error.c
index 1c5e35ecdb..2edd752fec 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -203,6 +203,23 @@ void error_vreport(const char *fmt, va_list ap)
 }
 
 /*
+ * Print a warning message ot the current monitor if we have one, else to
+ * stderr. This follows similar formating and use cases as error_vreport()
+ * except for these two differentce:
+ *     - It prefixes the message with 'warning: ' to indicate it is only a
+ *       warning.
+ *     - It does not print the timestamp.
+ */
+void warning_vreport(const char *fmt, va_list ap)
+{
+    error_vprintf("warning: ", ap);
+
+    print_loc();
+    error_vprintf(fmt, ap);
+    error_printf("\n");
+}
+
+/*
  * Print an error message to current monitor if we have one, else to stderr.
  * Format arguments like sprintf().  The resulting message should be a
  * single phrase, with no newline or trailing punctuation.
@@ -217,3 +234,18 @@ void error_report(const char *fmt, ...)
     error_vreport(fmt, ap);
     va_end(ap);
 }
+
+/*
+ * Print an warning message to current monitor if we have one, else to stderr.
+ * This follows the same formating and use cases as error_report()
+ * except it prefixes the message with 'warning: ' to indicate it is only a
+ * warning.
+ */
+void warning_report(const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    warning_vreport(fmt, ap);
+    va_end(ap);
+}
-- 
2.11.0
