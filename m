Received: from eggs.gnu.org ([2001:4830:134:3::10]:54008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dUu0M-0004l6-NG
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dUu0J-0006P0-Hh
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:11:02 -0400
Received: from mail-sn1nam01on0081.outbound.protection.outlook.com
	([104.47.32.81]:10691
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dUu0J-0006NG-6J
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:10:59 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 11 Jul 2017 05:07:33 -0700
Message-ID: <04209f16a478a286268a56357650f213a8167c8a.1499774331.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1499774331.git.alistair.francis@xilinx.com>
References: <cover.1499774331.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 6/8] error: Implement the warn and free
 Error functions
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

Implement warn_report_err() and warn_reportf_err() functions which
are the same as the error_report_err() and error_reportf_err()
functions except report a warning instead of an error.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---

 include/qapi/error.h  | 11 +++++++++++
 scripts/checkpatch.pl |  1 +
 util/error.c          | 20 ++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 7e532d00e9..af53b34410 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -267,11 +267,22 @@ void error_free(Error *err);
 void error_free_or_abort(Error **errp);
 
 /*
+ * Convenience function to warn_report() and free @err.
+ */
+void warn_report_err(Error *err);
+
+/*
  * Convenience function to error_report() and free @err.
  */
 void error_report_err(Error *err);
 
 /*
+ * Convenience function to error_prepend(), warn_report() and free @err.
+ */
+void warn_reportf_err(Error *err, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
+
+/*
  * Convenience function to error_prepend(), error_report() and free @err.
  */
 void error_reportf_err(Error *err, const char *fmt, ...)
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 60b1f320a1..dba8c84ca5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2533,6 +2533,7 @@ sub process {
 				error_setg_file_open|
 				error_set|
 				error_prepend|
+				warn_reportf_err|
 				error_reportf_err|
 				error_vreport|
 				report_vreport|
diff --git a/util/error.c b/util/error.c
index 020b86b9f0..3efdd69162 100644
--- a/util/error.c
+++ b/util/error.c
@@ -232,6 +232,15 @@ void error_report_err(Error *err)
     error_free(err);
 }
 
+void warn_report_err(Error *err)
+{
+    warn_report("%s", error_get_pretty(err));
+    if (err->hint) {
+        error_printf_unless_qmp("%s", err->hint->str);
+    }
+    error_free(err);
+}
+
 void error_reportf_err(Error *err, const char *fmt, ...)
 {
     va_list ap;
@@ -242,6 +251,17 @@ void error_reportf_err(Error *err, const char *fmt, ...)
     error_report_err(err);
 }
 
+
+void warn_reportf_err(Error *err, const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    error_vprepend(&err, fmt, ap);
+    va_end(ap);
+    warn_report_err(err);
+}
+
 void error_free(Error *err)
 {
     if (err) {
-- 
2.11.0
