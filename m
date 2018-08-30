Received: from eggs.gnu.org ([2001:4830:134:3::10]:41440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fvOPt-0004p6-0q
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fvOPi-00014t-8C
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:59:24 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 30 Aug 2018 16:59:02 +0200
Message-Id: <20180830145902.27376-3-cohuck@redhat.com>
In-Reply-To: <20180830145902.27376-1-cohuck@redhat.com>
References: <20180830145902.27376-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] qemu-error: make use of {error,
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

{error,warn}_report_once() are a special case of the new functions
and can simply switch to them.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 include/qemu/error-report.h | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
index e415128ac4..918cb936d8 100644
--- a/include/qemu/error-report.h
+++ b/include/qemu/error-report.h
@@ -53,32 +53,26 @@ bool warn_report_once_cond(bool *printed, const char *fmt, ...)
  * Similar to error_report(), except it prints the message just once.
  * Return true when it prints, false otherwise.
  */
-#define error_report_once(fmt, ...)             \
-    ({                                          \
-        static bool print_once_;                \
-        bool ret_print_once_ = !print_once_;    \
-                                                \
-        if (!print_once_) {                     \
-            print_once_ = true;                 \
-            error_report(fmt, ##__VA_ARGS__);   \
-        }                                       \
-        unlikely(ret_print_once_);              \
+#define error_report_once(fmt, ...)                     \
+    ({                                                  \
+        static bool print_once_;                        \
+        bool ret_print_once_ =                          \
+            error_report_once_cond(&print_once_,        \
+                                   fmt, ##__VA_ARGS__); \
+        unlikely(ret_print_once_);                      \
     })
 
 /*
  * Similar to warn_report(), except it prints the message just once.
  * Return true when it prints, false otherwise.
  */
-#define warn_report_once(fmt, ...)              \
-    ({                                          \
-        static bool print_once_;                \
-        bool ret_print_once_ = !print_once_;    \
-                                                \
-        if (!print_once_) {                     \
-            print_once_ = true;                 \
-            warn_report(fmt, ##__VA_ARGS__);    \
-        }                                       \
-        unlikely(ret_print_once_);              \
+#define warn_report_once(fmt, ...)                      \
+    ({                                                  \
+        static bool print_once_;                        \
+        bool ret_print_once_ =                          \
+            warn_report_once_cond(&print_once_,         \
+                                  fmt, ##__VA_ARGS__);  \
+        unlikely(ret_print_once_);                      \
     })
 
 const char *error_get_progname(void);
-- 
2.14.4
