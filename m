Received: from eggs.gnu.org ([2001:4830:134:3::10]:53843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkAC-0006jM-G3
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkA9-0001Sa-LE
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:32 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:34804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkA8-0001Re-Go
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:29 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 26 Apr 2018 17:53:30 +0100
Message-ID: <1524761612-5307-6-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 5/7] error reporting: Provide
 error_report_errnoval (and error_vreport_errnoval)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ian Jackson <ian.jackson@eu.citrix.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

This will let us replace more open coded calls to error_report and
strerror.

I have chosen to provide all of
   error_report_errno       error_vreport_errno
   error_report_errnoval    error_vreport_errnoval
because the former are much more common, and deserve a short spelling;
whereas there are still at least 30-40 potential callers of the latter.

No callers yet so no functional change.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 include/qemu/error-report.h |  5 +++++
 util/qemu-error.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 2b29678..5178173 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -46,6 +46,11 @@ void error_report_errno(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
+void error_vreport_errnoval(int errnoval,
+                            const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
+void error_report_errnoval(int errnoval,
+                           const char *fmt, ...) GCC_FMT_ATTR(2, 3);
+
 const char *error_get_progname(void);
 extern bool enable_timestamp_msg;
 
diff --git a/util/qemu-error.c b/util/qemu-error.c
index 428c762..8add1f3 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -257,6 +257,18 @@ void error_vreport_errno(const char *fmt, va_list ap)
 }
 
 /*
+ * Print an error message to current monitor if we have one, else to stderr.
+ * Format arguments like vsprintf().  The resulting message should be
+ * a single phrase, with no newline or trailing punctuation.
+ * Prepend the current location and append ": " strerror(errnoval) "\n".
+ * It's wrong to call this in a QMP monitor.  Use error_setg() there.
+ */
+void error_vreport_errnoval(int errnoval, const char *fmt, va_list ap)
+{
+    vreport(REPORT_TYPE_ERROR, errnoval, fmt, ap);
+}
+
+/*
  * Print a warning message to current monitor if we have one, else to stderr.
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
@@ -314,6 +326,22 @@ void error_report_errno(const char *fmt, ...)
 }
 
 /*
+ * Print an error message to current monitor if we have one, else to stderr.
+ * Format arguments like sprintf().  The resulting message should be
+ * a single phrase, with no newline or trailing punctuation.
+ * Prepend the current location and append ": " strerror(errnoval) "\n".
+ * It's wrong to call this in a QMP monitor.  Use error_setg() there.
+ */
+void error_report_errnoval(int errnoval, const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    vreport(REPORT_TYPE_ERROR, errnoval, fmt, ap);
+    va_end(ap);
+}
+
+/*
  * Print a warning message to current monitor if we have one, else to stderr.
  * Format arguments like sprintf(). The resulting message should be a
  * single phrase, with no newline or trailing punctuation.
-- 
2.1.4
