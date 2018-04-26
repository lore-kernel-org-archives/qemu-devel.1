Received: from eggs.gnu.org ([2001:4830:134:3::10]:53844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkAC-0006jN-Gg
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkA8-0001SN-Mz
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:32 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:34814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkA8-0001Rn-DX
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:28 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 26 Apr 2018 17:53:27 +0100
Message-ID: <1524761612-5307-3-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 2/7] error reporting: Provide
 error_report_errno (and error_vreport_errno)
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

This will let us replace a lot of open coded calls to perror,
strerror, etc.

No callers yet so no functional change.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 include/qemu/error-report.h |  2 ++
 util/qemu-error.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index e1c8ae1..2b29678 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -37,10 +37,12 @@ void error_printf_unless_qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void error_set_progname(const char *argv0);
 
 void error_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
+void error_vreport_errno(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 void warn_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 void info_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 
 void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
+void error_report_errno(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
diff --git a/util/qemu-error.c b/util/qemu-error.c
index 9acc4b5..428c762 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -245,6 +245,18 @@ void error_vreport(const char *fmt, va_list ap)
 }
 
 /*
+ * Print an error message to current monitor if we have one, else to stderr.
+ * Format arguments like vsprintf().  The resulting message should be
+ * a single phrase, with no newline or trailing punctuation.
+ * Prepend the current location and append ": " strerror(errno) "\n".
+ * It's wrong to call this in a QMP monitor.  Use error_setg() there.
+ */
+void error_vreport_errno(const char *fmt, va_list ap)
+{
+    vreport(REPORT_TYPE_ERROR, errno, fmt, ap);
+}
+
+/*
  * Print a warning message to current monitor if we have one, else to stderr.
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
@@ -286,6 +298,22 @@ void error_report(const char *fmt, ...)
 }
 
 /*
+ * Print an error message to current monitor if we have one, else to stderr.
+ * Format arguments like sprintf().  The resulting message should be
+ * a single phrase, with no newline or trailing punctuation.
+ * Prepend the current location and append ": " strerror(errno) "\n".
+ * It's wrong to call this in a QMP monitor.  Use error_setg() there.
+ */
+void error_report_errno(const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    vreport(REPORT_TYPE_ERROR, errno, fmt, ap);
+    va_end(ap);
+}
+
+/*
  * Print a warning message to current monitor if we have one, else to stderr.
  * Format arguments like sprintf(). The resulting message should be a
  * single phrase, with no newline or trailing punctuation.
-- 
2.1.4
