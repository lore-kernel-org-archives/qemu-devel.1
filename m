Received: from eggs.gnu.org ([2001:4830:134:3::10]:58917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gAFnU-0002nv-MH
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gAFnP-0004bc-Mk
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:49:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57409)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gAFnP-0004ah-F1
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:49:07 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 10 Oct 2018 10:48:53 -0400
Message-Id: <20181010144853.13005-5-cota@braap.org>
In-Reply-To: <20181010144853.13005-1-cota@braap.org>
References: <20181010144853.13005-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 4/4] tcg: distribute tcg_time into TCG contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

When we implemented per-vCPU TCG contexts, we forgot to also
distribute the tcg_time counter, which has remained as a global
accessed without any serialization, leading to potentially missed
counts.

Fix it by distributing the field over the TCG contexts, embedding
it into TCGProfile with a field called "cpu_exec_time", which is more
descriptive than "tcg_time". Add a function to query this value
directly, and for completeness, fill in the field in
tcg_profile_snapshot, even though its callers do not use it.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/timer.h |  1 -
 tcg/tcg.h            |  2 ++
 cpus.c               |  3 ++-
 monitor.c            | 13 ++++++++++---
 tcg/tcg.c            | 23 +++++++++++++++++++++++
 5 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index a005ed2692..dfecd03e28 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -1046,7 +1046,6 @@ static inline int64_t profile_getclock(void)
     return get_clock();
 }
 
-extern int64_t tcg_time;
 extern int64_t dev_time;
 #endif
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index d80ef2a883..c59f254e27 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -629,6 +629,7 @@ typedef struct TCGOp {
 QEMU_BUILD_BUG_ON(NB_OPS > (1 << 8));
 
 typedef struct TCGProfile {
+    int64_t cpu_exec_time;
     int64_t tb_count1;
     int64_t tb_count;
     int64_t op_count; /* total insn count */
@@ -1002,6 +1003,7 @@ int tcg_check_temp_count(void);
 #define tcg_check_temp_count() 0
 #endif
 
+int64_t tcg_cpu_exec_time(void);
 void tcg_dump_info(FILE *f, fprintf_function cpu_fprintf);
 void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf);
 
diff --git a/cpus.c b/cpus.c
index 361678e459..cce64874e6 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1425,7 +1425,8 @@ static int tcg_cpu_exec(CPUState *cpu)
     ret = cpu_exec(cpu);
     cpu_exec_end(cpu);
 #ifdef CONFIG_PROFILER
-    tcg_time += profile_getclock() - ti;
+    atomic_set(&tcg_ctx->prof.cpu_exec_time,
+               tcg_ctx->prof.cpu_exec_time + profile_getclock() - ti);
 #endif
     return ret;
 }
diff --git a/monitor.c b/monitor.c
index b9258a7438..823b5a1099 100644
--- a/monitor.c
+++ b/monitor.c
@@ -83,6 +83,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/iothread.h"
 #include "qemu/cutils.h"
+#include "tcg/tcg.h"
 
 #if defined(TARGET_S390X)
 #include "hw/s390x/storage-keys.h"
@@ -1966,16 +1967,22 @@ static void hmp_info_numa(Monitor *mon, const QDict *qdict)
 
 #ifdef CONFIG_PROFILER
 
-int64_t tcg_time;
 int64_t dev_time;
 
 static void hmp_info_profile(Monitor *mon, const QDict *qdict)
 {
+    static int64_t last_cpu_exec_time;
+    int64_t cpu_exec_time;
+    int64_t delta;
+
+    cpu_exec_time = tcg_cpu_exec_time();
+    delta = cpu_exec_time - last_cpu_exec_time;
+
     monitor_printf(mon, "async time  %" PRId64 " (%0.3f)\n",
                    dev_time, dev_time / (double)NANOSECONDS_PER_SECOND);
     monitor_printf(mon, "qemu time   %" PRId64 " (%0.3f)\n",
-                   tcg_time, tcg_time / (double)NANOSECONDS_PER_SECOND);
-    tcg_time = 0;
+                   delta, delta / (double)NANOSECONDS_PER_SECOND);
+    last_cpu_exec_time = cpu_exec_time;
     dev_time = 0;
 }
 #else
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8f26916b99..e85133ef05 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -30,6 +30,7 @@
 /* Define to jump the ELF file used to communicate with GDB.  */
 #undef DEBUG_JIT
 
+#include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "qemu/host-utils.h"
 #include "qemu/timer.h"
@@ -3361,6 +3362,7 @@ void tcg_profile_snapshot(TCGProfile *prof, bool counters, bool table)
         const TCGProfile *orig = &s->prof;
 
         if (counters) {
+            PROF_ADD(prof, orig, cpu_exec_time);
             PROF_ADD(prof, orig, tb_count1);
             PROF_ADD(prof, orig, tb_count);
             PROF_ADD(prof, orig, op_count);
@@ -3412,11 +3414,32 @@ void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf)
                     prof.table_op_count[i]);
     }
 }
+
+int64_t tcg_cpu_exec_time(void)
+{
+    unsigned int n_ctxs = atomic_read(&n_tcg_ctxs);
+    unsigned int i;
+    int64_t ret = 0;
+
+    for (i = 0; i < n_ctxs; i++) {
+        const TCGContext *s = atomic_read(&tcg_ctxs[i]);
+        const TCGProfile *prof = &s->prof;
+
+        ret += atomic_read(&prof->cpu_exec_time);
+    }
+    return ret;
+}
 #else
 void tcg_dump_op_count(FILE *f, fprintf_function cpu_fprintf)
 {
     cpu_fprintf(f, "[TCG profiler not compiled]\n");
 }
+
+int64_t tcg_cpu_exec_time(void)
+{
+    error_report("%s: TCG profiler not compiled", __func__);
+    exit(EXIT_FAILURE);
+}
 #endif
 
 
-- 
2.17.1
