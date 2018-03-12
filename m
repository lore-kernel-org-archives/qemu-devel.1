Received: from eggs.gnu.org ([208.118.235.92]:51015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evPsD-0004uN-OE
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1evPs9-0000fr-EL
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55024 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1evPs9-0000fR-7b
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:00:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 12 Mar 2018 16:00:10 +0000
Message-Id: <20180312160014.6804-2-stefanha@redhat.com>
In-Reply-To: <20180312160014.6804-1-stefanha@redhat.com>
References: <20180312160014.6804-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] log-for-trace.h: Split out parts of log.h
 used by trace.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

From: Peter Maydell <peter.maydell@linaro.org>

A persistent build problem we see is where a source file
accidentally omits the #include of log.h. This slips through
local developer testing because if you configure with the
default (log) trace backend trace.h will pull in log.h for you.
Compilation fails only if some other backend is selected.

To make this error cause a compile failure regardless of
the configured trace backend, split out the parts of log.h
that trace.h requires into a new log-for-trace.h header.
Since almost all manual uses of the log.h functions will
use constants or functions which aren't in log-for-trace.h,
this will let us catch missing #include "qemu/log.h" more
consistently.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180213140029.8308-1-peter.maydell@linaro.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/qemu/log-for-trace.h     | 35 +++++++++++++++++++++++++++++++++++
 include/qemu/log.h               | 18 ++++--------------
 scripts/tracetool/backend/log.py | 13 ++++++-------
 3 files changed, 45 insertions(+), 21 deletions(-)
 create mode 100644 include/qemu/log-for-trace.h

diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
new file mode 100644
index 0000000000..2f0a5b080e
--- /dev/null
+++ b/include/qemu/log-for-trace.h
@@ -0,0 +1,35 @@
+/* log-for-trace.h: logging basics required by the trace.h generated
+ * by the log trace backend.
+ *
+ * This should not be included directly by any .c file: if you
+ * need to use the logging functions include "qemu/log.h".
+ *
+ * The purpose of splitting these parts out into their own header
+ * is to catch the easy mistake where a .c file includes trace.h
+ * but forgets to include qemu/log.h. Without this split, that
+ * would result in the .c file compiling fine when the default
+ * trace backend is in use but failing to compile with any other
+ * backend.
+ *
+ * This code is licensed under the GNU General Public License,
+ * version 2 or (at your option) any later version.
+ */
+
+#ifndef QEMU_LOG_FOR_TRACE_H
+#define QEMU_LOG_FOR_TRACE_H
+
+/* Private global variable, don't use */
+extern int qemu_loglevel;
+
+#define LOG_TRACE          (1 << 15)
+
+/* Returns true if a bit is set in the current loglevel mask */
+static inline bool qemu_loglevel_mask(int mask)
+{
+    return (qemu_loglevel & mask) != 0;
+}
+
+/* main logging function */
+int GCC_FMT_ATTR(1, 2) qemu_log(const char *fmt, ...);
+
+#endif
diff --git a/include/qemu/log.h b/include/qemu/log.h
index a50e994c21..ff92a8b86a 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -1,10 +1,11 @@
 #ifndef QEMU_LOG_H
 #define QEMU_LOG_H
 
+/* A small part of this API is split into its own header */
+#include "qemu/log-for-trace.h"
 
-/* Private global variables, don't use */
+/* Private global variable, don't use */
 extern FILE *qemu_logfile;
-extern int qemu_loglevel;
 
 /* 
  * The new API:
@@ -41,16 +42,9 @@ static inline bool qemu_log_separate(void)
 #define CPU_LOG_MMU        (1 << 12)
 #define CPU_LOG_TB_NOCHAIN (1 << 13)
 #define CPU_LOG_PAGE       (1 << 14)
-#define LOG_TRACE          (1 << 15)
+/* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
 #define CPU_LOG_TB_OP_IND  (1 << 16)
 
-/* Returns true if a bit is set in the current loglevel mask
- */
-static inline bool qemu_loglevel_mask(int mask)
-{
-    return (qemu_loglevel & mask) != 0;
-}
-
 /* Lock output for a series of related logs.  Since this is not needed
  * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
  * assume that qemu_loglevel_mask has already been tested, and that
@@ -69,10 +63,6 @@ static inline void qemu_log_unlock(void)
 
 /* Logging functions: */
 
-/* main logging function
- */
-int GCC_FMT_ATTR(1, 2) qemu_log(const char *fmt, ...);
-
 /* vfprintf-like logging function
  */
 static inline void GCC_FMT_ATTR(1, 0)
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index da86f6b882..78933d03ad 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -20,7 +20,7 @@ PUBLIC = True
 
 
 def generate_h_begin(events, group):
-    out('#include "qemu/log.h"',
+    out('#include "qemu/log-for-trace.h"',
         '')
 
 
@@ -35,14 +35,13 @@ def generate_h(event, group):
     else:
         cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
 
-    out('    if (%(cond)s) {',
+    out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
         '        struct timeval _now;',
         '        gettimeofday(&_now, NULL);',
-        '        qemu_log_mask(LOG_TRACE,',
-        '                      "%%d@%%zd.%%06zd:%(name)s " %(fmt)s "\\n",',
-        '                      getpid(),',
-        '                      (size_t)_now.tv_sec, (size_t)_now.tv_usec',
-        '                      %(argnames)s);',
+        '        qemu_log("%%d@%%zd.%%06zd:%(name)s " %(fmt)s "\\n",',
+        '                 getpid(),',
+        '                 (size_t)_now.tv_sec, (size_t)_now.tv_usec',
+        '                 %(argnames)s);',
         '    }',
         cond=cond,
         name=event.name,
-- 
2.14.3
