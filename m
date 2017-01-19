Received: from eggs.gnu.org ([2001:4830:134:3::10]:38691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9I-0007TU-9r
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9H-0007mi-9M
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:20 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cUG9H-0007m6-1O
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:19 -0500
Received: by mail-wm0-x229.google.com with SMTP id c206so2818951wme.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:05:18 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Jan 2017 17:04:47 +0000
Message-Id: <20170119170507.16185-8-alex.bennee@linaro.org>
In-Reply-To: <20170119170507.16185-1-alex.bennee@linaro.org>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 07/27] tcg: rename tcg_current_cpu to
 tcg_current_rr_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

..and make the definition local to cpus. In preparation for MTTCG the
concept of a global tcg_current_cpu will no longer make sense. However
we still need to keep track of it in the single-threaded case to be able
to exit quickly when required.

qemu_cpu_kick_no_halt() moves and becomes qemu_cpu_kick_rr_cpu() to
emphasise its use-case. qemu_cpu_kick now kicks the relevant cpu as
well as qemu_kick_rr_cpu() which will become a no-op in MTTCG.

For the time being the setting of the global exit_request remains.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
v4:
  - keep global exit_request setting for now
  - fix merge conflicts
v5:
  - merge conflicts with kick changes
---
 cpu-exec-common.c       |  1 -
 cpu-exec.c              |  3 ---
 cpus.c                  | 41 ++++++++++++++++++++++-------------------
 include/exec/exec-all.h |  1 -
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/cpu-exec-common.c b/cpu-exec-common.c
index 767d9c6f0c..e2bc053372 100644
--- a/cpu-exec-common.c
+++ b/cpu-exec-common.c
@@ -24,7 +24,6 @@
 #include "exec/memory-internal.h"
 
 bool exit_request;
-CPUState *tcg_current_cpu;
 
 /* exit the current TB, but without causing any exception to be raised */
 void cpu_loop_exit_noexc(CPUState *cpu)
diff --git a/cpu-exec.c b/cpu-exec.c
index 1b8685dc21..f9e836c8dd 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -609,7 +609,6 @@ int cpu_exec(CPUState *cpu)
         return EXCP_HALTED;
     }
 
-    atomic_mb_set(&tcg_current_cpu, cpu);
     rcu_read_lock();
 
     if (unlikely(atomic_mb_read(&exit_request))) {
@@ -668,7 +667,5 @@ int cpu_exec(CPUState *cpu)
     /* fail safe : never use current_cpu outside cpu_exec() */
     current_cpu = NULL;
 
-    /* Does not need atomic_mb_set because a spurious wakeup is okay.  */
-    atomic_set(&tcg_current_cpu, NULL);
     return ret;
 }
diff --git a/cpus.c b/cpus.c
index 8f182dff72..1c76f36d89 100644
--- a/cpus.c
+++ b/cpus.c
@@ -775,8 +775,7 @@ void configure_icount(QemuOpts *opts, Error **errp)
  */
 
 static QEMUTimer *tcg_kick_vcpu_timer;
-
-static void qemu_cpu_kick_no_halt(void);
+static CPUState *tcg_current_rr_cpu;
 
 #define TCG_KICK_PERIOD (NANOSECONDS_PER_SECOND / 10)
 
@@ -785,10 +784,23 @@ static inline int64_t qemu_tcg_next_kick(void)
     return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
 }
 
+/* Kick the currently round-robin scheduled vCPU */
+static void qemu_cpu_kick_rr_cpu(void)
+{
+    CPUState *cpu;
+    atomic_mb_set(&exit_request, 1);
+    do {
+        cpu = atomic_mb_read(&tcg_current_rr_cpu);
+        if (cpu) {
+            cpu_exit(cpu);
+        }
+    } while (cpu != atomic_mb_read(&tcg_current_rr_cpu));
+}
+
 static void kick_tcg_thread(void *opaque)
 {
     timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
-    qemu_cpu_kick_no_halt();
+    qemu_cpu_kick_rr_cpu();
 }
 
 static void start_tcg_kick_timer(void)
@@ -808,7 +820,6 @@ static void stop_tcg_kick_timer(void)
     }
 }
 
-
 /***********************************************************/
 void hw_error(const char *fmt, ...)
 {
@@ -1319,6 +1330,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
         }
 
         for (; cpu != NULL && !exit_request; cpu = CPU_NEXT(cpu)) {
+            atomic_mb_set(&tcg_current_rr_cpu, cpu);
 
             qemu_clock_enable(QEMU_CLOCK_VIRTUAL,
                               (cpu->singlestep_enabled & SSTEP_NOTIMER) == 0);
@@ -1338,6 +1350,8 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
             }
 
         } /* for cpu.. */
+        /* Does not need atomic_mb_set because a spurious wakeup is okay.  */
+        atomic_set(&tcg_current_rr_cpu, NULL);
 
         /* Pairs with smp_wmb in qemu_cpu_kick.  */
         atomic_mb_set(&exit_request, 0);
@@ -1370,24 +1384,13 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
 #endif
 }
 
-static void qemu_cpu_kick_no_halt(void)
-{
-    CPUState *cpu;
-    /* Ensure whatever caused the exit has reached the CPU threads before
-     * writing exit_request.
-     */
-    atomic_mb_set(&exit_request, 1);
-    cpu = atomic_mb_read(&tcg_current_cpu);
-    if (cpu) {
-        cpu_exit(cpu);
-    }
-}
-
 void qemu_cpu_kick(CPUState *cpu)
 {
     qemu_cond_broadcast(cpu->halt_cond);
     if (tcg_enabled()) {
-        qemu_cpu_kick_no_halt();
+        cpu_exit(cpu);
+        /* Also ensure current RR cpu is kicked */
+        qemu_cpu_kick_rr_cpu();
     } else {
         qemu_cpu_kick_thread(cpu);
     }
@@ -1428,7 +1431,7 @@ void qemu_mutex_lock_iothread(void)
         atomic_dec(&iothread_requesting_mutex);
     } else {
         if (qemu_mutex_trylock(&qemu_global_mutex)) {
-            qemu_cpu_kick_no_halt();
+            qemu_cpu_kick_rr_cpu();
             qemu_mutex_lock(&qemu_global_mutex);
         }
         atomic_dec(&iothread_requesting_mutex);
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index bbc9478a50..3cbd359dd7 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -404,7 +404,6 @@ bool memory_region_is_unassigned(MemoryRegion *mr);
 extern int singlestep;
 
 /* cpu-exec.c, accessed with atomic_mb_read/atomic_mb_set */
-extern CPUState *tcg_current_cpu;
 extern bool exit_request;
 
 #endif
-- 
2.11.0
