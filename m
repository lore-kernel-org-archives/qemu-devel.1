Received: from eggs.gnu.org ([2001:4830:134:3::10]:41371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fvOPf-0004f2-Sf
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fvOPe-00013e-Up
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:59:11 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 30 Aug 2018 16:59:01 +0200
Message-Id: <20180830145902.27376-2-cohuck@redhat.com>
In-Reply-To: <20180830145902.27376-1-cohuck@redhat.com>
References: <20180830145902.27376-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] qemu-error: add {error,
 warn}_report_once_cond
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>

Add two functions to print an error/warning report once depending
on a passed-in condition variable and flip it if printed. This is
useful if you want to print a message not once-globally, but e.g.
once-per-device.

Inspired by warn_once() in hw/vfio/ccw.c, which has been replaced
with warn_report_once_cond().

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ccw.c               | 18 +++--------------
 include/qemu/error-report.h |  5 +++++
 util/qemu-error.c           | 48 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index e96bbdc78b..9246729a75 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -37,24 +37,12 @@ typedef struct VFIOCCWDevice {
     bool warned_orb_pfch;
 } VFIOCCWDevice;
 
-static inline void warn_once(bool *warned, const char *fmt, ...)
-{
-    va_list ap;
-
-    if (!warned || *warned) {
-        return;
-    }
-    *warned = true;
-    va_start(ap, fmt);
-    warn_vreport(fmt, ap);
-    va_end(ap);
-}
-
 static inline void warn_once_pfch(VFIOCCWDevice *vcdev, SubchDev *sch,
                                   const char *msg)
 {
-    warn_once(&vcdev->warned_orb_pfch, "vfio-ccw (devno %x.%x.%04x): %s",
-              sch->cssid, sch->ssid, sch->devno, msg);
+    warn_report_once_cond(&vcdev->warned_orb_pfch,
+                          "vfio-ccw (devno %x.%x.%04x): %s",
+                          sch->cssid, sch->ssid, sch->devno, msg);
 }
 
 static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index 72fab2b031..e415128ac4 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -44,6 +44,11 @@ void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void warn_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 void info_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
+bool error_report_once_cond(bool *printed, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
+bool warn_report_once_cond(bool *printed, const char *fmt, ...)
+    GCC_FMT_ATTR(2, 3);
+
 /*
  * Similar to error_report(), except it prints the message just once.
  * Return true when it prints, false otherwise.
diff --git a/util/qemu-error.c b/util/qemu-error.c
index a25d3b94c6..b77e0bac4c 100644
--- a/util/qemu-error.c
+++ b/util/qemu-error.c
@@ -310,3 +310,51 @@ void info_report(const char *fmt, ...)
     vreport(REPORT_TYPE_INFO, fmt, ap);
     va_end(ap);
 }
+
+/*
+ * If *printed is false, print an error message to current monitor if we
+ * have one, else to stderr, and flip *printed to true.
+ * Returns false if message was not printed, else true.
+ * Format arguments like sprintf().  The resulting message should be
+ * a single phrase, with no newline or trailing punctuation.
+ * Prepend the current location and append a newline.
+ * It's wrong to call this in a QMP monitor.  Use error_setg() there.
+ */
+bool error_report_once_cond(bool *printed, const char *fmt, ...)
+{
+    va_list ap;
+
+    assert(printed);
+    if (*printed) {
+        return false;
+    }
+    *printed = true;
+    va_start(ap, fmt);
+    vreport(REPORT_TYPE_ERROR, fmt, ap);
+    va_end(ap);
+    return true;
+}
+
+/*
+ * If *printed is false, print a warning message to current monitor if we
+ * have one, else to stderr, and flip *printed to true.
+ * Returns false if message was not printed, else true.
+ * Format arguments like sprintf().  The resulting message should be
+ * a single phrase, with no newline or trailing punctuation.
+ * Prepend the current location and append a newline.
+ * It's wrong to call this in a QMP monitor.  Use error_setg() there.
+ */
+bool warn_report_once_cond(bool *printed, const char *fmt, ...)
+{
+    va_list ap;
+
+    assert(printed);
+    if (*printed) {
+        return false;
+    }
+    *printed = true;
+    va_start(ap, fmt);
+    vreport(REPORT_TYPE_WARNING, fmt, ap);
+    va_end(ap);
+    return true;
+}
-- 
2.14.4
