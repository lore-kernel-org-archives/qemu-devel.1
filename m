Received: from eggs.gnu.org ([2001:4830:134:3::10]:36825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dTGa5-0004tX-Tb
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dTGa1-0000zw-1L
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:53:09 -0400
Received: from mail-bl2nam02on0086.outbound.protection.outlook.com
	([104.47.38.86]:18432
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dTGa0-0000zK-Mw
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 19:53:04 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 6 Jul 2017 16:49:50 -0700
Message-ID: <97215143161151f6351b4f42e2561138ba55217c.1499381754.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1499381754.git.alistair.francis@xilinx.com>
References: <cover.1499381754.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 5/6] error: Implement the warn and free
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
---

 include/qapi/error.h  | 11 +++++++++++
 scripts/checkpatch.pl |  1 +
 util/error.c          | 19 +++++++++++++++++++
 3 files changed, 31 insertions(+)

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
index 1fdd7f624a..d1e7dd92ee 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2533,6 +2533,7 @@ sub process {
 				error_setg_file_open|
 				error_set|
 				error_prepend|
+				warn_reportf_err|
 				error_reportf_err|
 				vreport|
 				error_vreport|
diff --git a/util/error.c b/util/error.c
index 020b86b9f0..373566fb77 100644
--- a/util/error.c
+++ b/util/error.c
@@ -223,6 +223,15 @@ const char *error_get_pretty(const Error *err)
     return err->msg;
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
 void error_report_err(Error *err)
 {
     error_report("%s", error_get_pretty(err));
@@ -232,6 +241,16 @@ void error_report_err(Error *err)
     error_free(err);
 }
 
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
 void error_reportf_err(Error *err, const char *fmt, ...)
 {
     va_list ap;
-- 
2.11.0
