Received: from eggs.gnu.org ([2001:4830:134:3::10]:53842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkAC-0006jL-Fz
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkA8-0001S9-1M
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:32 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:34804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=647a3a28a=Ian.Jackson@citrix.com>)
	id 1fBkA7-0001Re-Ol
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:54:27 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 26 Apr 2018 17:53:26 +0100
Message-ID: <1524761612-5307-2-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1524761612-5307-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 1/7] error reporting: Introduce errnoval
 parameter to vreport
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

This will allow new callers of vreport to specify that an errno value
should be printed too.  Update all existing callers.

We use strerror rather than strerror_r because strerror_r presents
portability difficulties.  Replacing strerror with strerror_r (or
something else) is left to the future.

No functional change yet.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 util/qemu-error.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/util/qemu-error.c b/util/qemu-error.c
index a25d3b9..9acc4b5 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -191,12 +191,14 @@ bool enable_timestamp_msg;
 /*
  * Print a message to current monitor if we have one, else to stderr.
  * @report_type is the type of message: error, warning or informational.
+ * If @errnoval is nonnegative it is fed to strerror and printed too.
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
  * It's wrong to call this in a QMP monitor.  Use error_setg() there.
  */
-static void vreport(report_type type, const char *fmt, va_list ap)
+static void vreport(report_type type, int errnoval,
+                    const char *fmt, va_list ap)
 {
     GTimeVal tv;
     gchar *timestr;
@@ -222,6 +224,11 @@ static void vreport(report_type type, const char *fmt, va_list ap)
     }
 
     error_vprintf(fmt, ap);
+
+    if (errnoval >= 0) {
+        error_printf(": %s", strerror(errnoval));
+    }
+
     error_printf("\n");
 }
 
@@ -234,7 +241,7 @@ static void vreport(report_type type, const char *fmt, va_list ap)
  */
 void error_vreport(const char *fmt, va_list ap)
 {
-    vreport(REPORT_TYPE_ERROR, fmt, ap);
+    vreport(REPORT_TYPE_ERROR, -1, fmt, ap);
 }
 
 /*
@@ -246,7 +253,7 @@ void error_vreport(const char *fmt, va_list ap)
  */
 void warn_vreport(const char *fmt, va_list ap)
 {
-    vreport(REPORT_TYPE_WARNING, fmt, ap);
+    vreport(REPORT_TYPE_WARNING, -1, fmt, ap);
 }
 
 /*
@@ -259,7 +266,7 @@ void warn_vreport(const char *fmt, va_list ap)
  */
 void info_vreport(const char *fmt, va_list ap)
 {
-    vreport(REPORT_TYPE_INFO, fmt, ap);
+    vreport(REPORT_TYPE_INFO, -1, fmt, ap);
 }
 
 /*
@@ -274,7 +281,7 @@ void error_report(const char *fmt, ...)
     va_list ap;
 
     va_start(ap, fmt);
-    vreport(REPORT_TYPE_ERROR, fmt, ap);
+    vreport(REPORT_TYPE_ERROR, -1, fmt, ap);
     va_end(ap);
 }
 
@@ -290,7 +297,7 @@ void warn_report(const char *fmt, ...)
     va_list ap;
 
     va_start(ap, fmt);
-    vreport(REPORT_TYPE_WARNING, fmt, ap);
+    vreport(REPORT_TYPE_WARNING, -1, fmt, ap);
     va_end(ap);
 }
 
@@ -307,6 +314,6 @@ void info_report(const char *fmt, ...)
     va_list ap;
 
     va_start(ap, fmt);
-    vreport(REPORT_TYPE_INFO, fmt, ap);
+    vreport(REPORT_TYPE_INFO, -1, fmt, ap);
     va_end(ap);
 }
-- 
2.1.4
