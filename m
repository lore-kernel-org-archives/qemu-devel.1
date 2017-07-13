Received: from eggs.gnu.org ([2001:4830:134:3::10]:40225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVbtT-0005iE-2Z
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dVbtP-0001Gf-Pd
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:02:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dVbtP-0001FK-GR
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 07:02:47 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 13 Jul 2017 13:02:30 +0200
Message-Id: <20170713110237.6712-2-lprosek@redhat.com>
In-Reply-To: <20170713110237.6712-1-lprosek@redhat.com>
References: <20170713110237.6712-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/8] qemu-error: introduce error_report_nolf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com, stefanha@redhat.com

Callers of error_report may want to compose the error message out of multiple
separate format strings. To save them from always having to combine their
strings into one (a process that would likely involve memory allocation which
is good to avoid on error paths), new "nolf" variants of error_report and
error_vreport are introduced.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 hw/virtio/virtio.c          |  3 ++-
 include/qemu/error-report.h |  3 ++-
 util/qemu-error.c           | 32 ++++++++++++++++++++++++++------
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 464947f..0e76a73 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2448,8 +2448,9 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
     va_list ap;
 
     va_start(ap, fmt);
-    error_vreport(fmt, ap);
+    error_vreport_nolf(fmt, ap);
     va_end(ap);
+    error_printf("\n");
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 3001865..cdee84f 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -35,7 +35,8 @@ void error_printf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void error_vprintf_unless_qmp(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 void error_printf_unless_qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void error_set_progname(const char *argv0);
-void error_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
+void error_vreport_nolf(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
+void error_report_nolf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 const char *error_get_progname(void);
 extern bool enable_timestamp_msg;
diff --git a/util/qemu-error.c b/util/qemu-error.c
index b331f8f..c7fd127 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -181,11 +181,13 @@ bool enable_timestamp_msg;
 /*
  * Print an error message to current monitor if we have one, else to stderr.
  * Format arguments like vsprintf().  The resulting message should be
- * a single phrase, with no newline or trailing punctuation.
- * Prepend the current location and append a newline.
+ * a single phrase, with no trailing punctuation.  The no-LF version allows
+ * additional text to be appended with error_printf() or error_vprintf().
+ * Make sure to always close with a newline after all text is printed.
+ * Prepends the current location.
  * It's wrong to call this in a QMP monitor.  Use error_setg() there.
  */
-void error_vreport(const char *fmt, va_list ap)
+void error_vreport_nolf(const char *fmt, va_list ap)
 {
     GTimeVal tv;
     gchar *timestr;
@@ -199,14 +201,31 @@ void error_vreport(const char *fmt, va_list ap)
 
     error_print_loc();
     error_vprintf(fmt, ap);
-    error_printf("\n");
+}
+
+/*
+ * Print an error message to current monitor if we have one, else to stderr.
+ * Format arguments like sprintf().  The resulting message should be a
+ * single phrase, with no trailing punctuation.  The no-LF version allows
+ * additional text to be appended with error_printf() or error_vprintf().
+ * Make sure to always close with a newline after all text is printed.
+ * Prepends the current location.
+ * It's wrong to call this in a QMP monitor.  Use error_setg() there.
+ */
+void error_report_nolf(const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    error_vreport_nolf(fmt, ap);
+    va_end(ap);
 }
 
 /*
  * Print an error message to current monitor if we have one, else to stderr.
  * Format arguments like sprintf().  The resulting message should be a
  * single phrase, with no newline or trailing punctuation.
- * Prepend the current location and append a newline.
+ * Prepends the current location and appends a newline.
  * It's wrong to call this in a QMP monitor.  Use error_setg() there.
  */
 void error_report(const char *fmt, ...)
@@ -214,6 +233,7 @@ void error_report(const char *fmt, ...)
     va_list ap;
 
     va_start(ap, fmt);
-    error_vreport(fmt, ap);
+    error_vreport_nolf(fmt, ap);
     va_end(ap);
+    error_printf("\n");
 }
-- 
2.9.3
