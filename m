Received: from eggs.gnu.org ([209.51.188.92]:48213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEbZs-0005Yk-Nt
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEbZr-0006Us-FG
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:25:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hEbZr-0006TR-2l
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:25:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4FB21307AD19
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 15:25:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 11 Apr 2019 17:25:06 +0200
Message-Id: <20190411152520.10061-4-armbru@redhat.com>
In-Reply-To: <20190411152520.10061-1-armbru@redhat.com>
References: <20190411152520.10061-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 03/17] tcg: Simplify how dump_opcount_info()
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

dump_opcount_info() takes an fprintf()-like callback and a FILE * to
pass to it.

Its only caller hmp_info_opcount() passes monitor_fprintf() and the
current monitor cast to FILE *.  monitor_fprintf() casts it right
back, and is otherwise identical to monitor_printf().  The
type-punning is ugly.

Drop the callback, and call qemu_printf() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 accel/tcg/translate-all.c | 4 ++--
 include/exec/cpu-all.h    | 2 +-
 monitor.c                 | 2 +-
 tcg/tcg.c                 | 9 +++++----
 tcg/tcg.h                 | 2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 8f593b926f..85e80a1fad 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2333,9 +2333,9 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
     tcg_dump_info(f, cpu_fprintf);
 }
 
-void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf)
+void dump_opcount_info(void)
 {
-    tcg_dump_op_count(f, cpu_fprintf);
+    tcg_dump_op_count();
 }
 
 #else /* CONFIG_USER_ONLY */
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index b16c9ec513..40f5edf4dc 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -363,7 +363,7 @@ static inline bool tlb_hit(target_ulong tlb_addr, target_ulong addr)
 }
 
 void dump_exec_info(FILE *f, fprintf_function cpu_fprintf);
-void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf);
+void dump_opcount_info(void);
 #endif /* !CONFIG_USER_ONLY */
 
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
diff --git a/monitor.c b/monitor.c
index a3e66b7159..30a7ffe32b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1324,7 +1324,7 @@ static void hmp_info_jit(Monitor *mon, const QDict *qdict)
 
 static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
 {
-    dump_opcount_info((FILE *)mon, monitor_fprintf);
+    dump_opcount_info();
 }
 #endif
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 9b2bf7f439..cc5f4e2a03 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -33,6 +33,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "qemu/host-utils.h"
+#include "qemu/qemu-print.h"
 #include "qemu/timer.h"
 
 /* Note: the long term plan is to reduce the dependencies on the QEMU
@@ -3768,14 +3769,14 @@ static void tcg_profile_snapshot_table(TCGProfile *prof)
     tcg_profile_snapshot(prof, false, true);
 }
 
-void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf)
+void tcg_dump_op_count(void)
 {
     TCGProfile prof = {};
     int i;
 
     tcg_profile_snapshot_table(&prof);
     for (i = 0; i < NB_OPS; i++) {
-        cpu_fprintf(f, "%s %" PRId64 "\n", tcg_op_defs[i].name,
+        qemu_printf("%s %" PRId64 "\n", tcg_op_defs[i].name,
                     prof.table_op_count[i]);
     }
 }
@@ -3795,9 +3796,9 @@ int64_t tcg_cpu_exec_time(void)
     return ret;
 }
 #else
-void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf)
+void tcg_dump_op_count(void)
 {
-    cpu_fprintf(f, "[TCG profiler not compiled]\n");
+    qemu_printf("[TCG profiler not compiled]\n");
 }
 
 int64_t tcg_cpu_exec_time(void)
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 32b7cf3489..9f2b03f119 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -1018,7 +1018,7 @@ int tcg_check_temp_count(void);
 
 int64_t tcg_cpu_exec_time(void);
 void tcg_dump_info(FILE *f, fprintf_function cpu_fprintf);
-void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf);
+void tcg_dump_op_count(void);
 
 #define TCG_CT_ALIAS  0x80
 #define TCG_CT_IALIAS 0x40
-- 
2.17.2
