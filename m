Received: from eggs.gnu.org ([209.51.188.92]:54679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0Z-00057i-G0
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0U-0005Fl-NZ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0U-0005DC-CU
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C82E481E1C
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 977C05D707
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 18 Apr 2019 22:51:20 +0200
Message-Id: <20190418205135.6686-22-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-4.1 21/36] trace: Simplify how
 st_print_trace_file_status() prints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

st_print_trace_file_status() takes an fprintf()-like callback and a
FILE * to pass to it.

Its only caller hmp_trace_file() passes monitor_fprintf() and the
current monitor cast to FILE *.  monitor_fprintf() casts it right
back, and is otherwise identical to monitor_printf().  The
type-punning is ugly.

Drop the callback, and call qemu_printf() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190417191805.28198-3-armbru@redhat.com>
---
 monitor.c      | 2 +-
 trace/simple.c | 7 ++++---
 trace/simple.h | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/monitor.c b/monitor.c
index 10be8bdb86..a3e66b7159 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1056,7 +1056,7 @@ static void hmp_trace_file(Monitor *mon, const QDict *qdict)
     const char *arg = qdict_get_try_str(qdict, "arg");
 
     if (!op) {
-        st_print_trace_file_status((FILE *)mon, &monitor_fprintf);
+        st_print_trace_file_status();
     } else if (!strcmp(op, "on")) {
         st_set_trace_file_enabled(true);
     } else if (!strcmp(op, "off")) {
diff --git a/trace/simple.c b/trace/simple.c
index ac904eca91..fc7106ec49 100644
--- a/trace/simple.c
+++ b/trace/simple.c
@@ -16,6 +16,7 @@
 #include "trace/control.h"
 #include "trace/simple.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 
 /** Trace file header event ID, picked to avoid conflict with real event IDs */
 #define HEADER_EVENT_ID (~(uint64_t)0)
@@ -363,10 +364,10 @@ void st_set_trace_file(const char *file)
     st_set_trace_file_enabled(true);
 }
 
-void st_print_trace_file_status(FILE *stream, int (*stream_printf)(FILE *stream, const char *fmt, ...))
+void st_print_trace_file_status(void)
 {
-    stream_printf(stream, "Trace file \"%s\" %s.\n",
-                  trace_file_name, trace_fp ? "on" : "off");
+    qemu_printf("Trace file \"%s\" %s.\n",
+                trace_file_name, trace_fp ? "on" : "off");
 }
 
 void st_flush_trace_buffer(void)
diff --git a/trace/simple.h b/trace/simple.h
index 9931808c05..5771a0634f 100644
--- a/trace/simple.h
+++ b/trace/simple.h
@@ -11,7 +11,7 @@
 #ifndef TRACE_SIMPLE_H
 #define TRACE_SIMPLE_H
 
-void st_print_trace_file_status(FILE *stream, fprintf_function stream_printf);
+void st_print_trace_file_status(void);
 void st_set_trace_file_enabled(bool enable);
 void st_set_trace_file(const char *file);
 bool st_init(void);
-- 
2.17.2
