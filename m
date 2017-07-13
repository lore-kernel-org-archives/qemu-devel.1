Received: from eggs.gnu.org ([2001:4830:134:3::10]:59101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVeA0-0008V9-J2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVe9x-0001Kz-3y
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVe9w-0001KB-Q7
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:28:01 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 13 Jul 2017 15:27:55 +0200
Message-Id: <1499952476-3454-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1499952476-3454-1-git-send-email-armbru@redhat.com>
References: <1499952476-3454-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 8/9] error: Implement the warn and free Error
 functions
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

Implement warn_report_err() and warn_reportf_err() functions which
are the same as the error_report_err() and error_reportf_err()
functions except report a warning instead of an error.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <276ff93eadc0b01b8243cc61ffc331f77922c0d0.1499866456.git.alistair.francis@xilinx.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/error.h  | 11 +++++++++++
 scripts/checkpatch.pl |  1 +
 util/error.c          | 20 ++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 7e532d0..af53b34 100644
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
index 9287cc5..4e91122 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2533,6 +2533,7 @@ sub process {
 				error_setg_file_open|
 				error_set|
 				error_prepend|
+				warn_reportf_err|
 				error_reportf_err|
 				error_vreport|
 				warn_vreport|
diff --git a/util/error.c b/util/error.c
index 020b86b..3efdd69 100644
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
2.7.5
