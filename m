Received: from eggs.gnu.org ([209.51.188.92]:34764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGq4U-0008R0-Jn
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGq4R-0008Rk-BX
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGq4P-0008Nd-En
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B306A3078ABD
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 19:18:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 17 Apr 2019 21:17:53 +0200
Message-Id: <20190417191805.28198-6-armbru@redhat.com>
In-Reply-To: <20190417191805.28198-1-armbru@redhat.com>
References: <20190417191805.28198-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/17] tcg: Simplify how dump_drift_info()
 prints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

dump_drift_info() takes an fprintf()-like callback and a FILE * to pass
to it.

Its only caller hmp_info_jit() passes monitor_fprintf() and a Monitor
* cast to FILE *.  monitor_fprintf() casts it right back, and is
otherwise identical to monitor_printf().  The type-punning is ugly.

Drop the callback, and call qemu_printf() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 cpus.c                | 15 +++++++++------
 include/sysemu/cpus.h |  2 +-
 monitor.c             |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/cpus.c b/cpus.c
index e83f72b48b..684aa9679a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -31,6 +31,7 @@
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
 #include "exec/gdbstub.h"
@@ -2454,19 +2455,21 @@ void qmp_inject_nmi(Error **errp)
     nmi_monitor_handle(monitor_get_cpu_index(), errp);
 }
 
-void dump_drift_info(FILE *f, fprintf_function cpu_fprintf)
+void dump_drift_info(void)
 {
     if (!use_icount) {
         return;
     }
 
-    cpu_fprintf(f, "Host - Guest clock  %"PRIi64" ms\n",
+    qemu_printf("Host - Guest clock  %"PRIi64" ms\n",
                 (cpu_get_clock() - cpu_get_icount())/SCALE_MS);
     if (icount_align_option) {
-        cpu_fprintf(f, "Max guest delay     %"PRIi64" ms\n", -max_delay/SCALE_MS);
-        cpu_fprintf(f, "Max guest advance   %"PRIi64" ms\n", max_advance/SCALE_MS);
+        qemu_printf("Max guest delay     %"PRIi64" ms\n",
+                    -max_delay / SCALE_MS);
+        qemu_printf("Max guest advance   %"PRIi64" ms\n",
+                    max_advance / SCALE_MS);
     } else {
-        cpu_fprintf(f, "Max guest delay     NA\n");
-        cpu_fprintf(f, "Max guest advance   NA\n");
+        qemu_printf("Max guest delay     NA\n");
+        qemu_printf("Max guest advance   NA\n");
     }
 }
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index eea0010b53..ef13a120cc 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -19,7 +19,7 @@ extern int icount_align_option;
 /* drift information for info jit command */
 extern int64_t max_delay;
 extern int64_t max_advance;
-void dump_drift_info(FILE *f, fprintf_function cpu_fprintf);
+void dump_drift_info(void);
 
 /* Unblock cpu */
 void qemu_cpu_kick_self(void);
diff --git a/monitor.c b/monitor.c
index 24e4d49d11..7573689585 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1319,7 +1319,7 @@ static void hmp_info_jit(Monitor *mon, const QDict *qdict)
     }
 
     dump_exec_info();
-    dump_drift_info((FILE *)mon, monitor_fprintf);
+    dump_drift_info();
 }
 
 static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
-- 
2.17.2
