Received: from eggs.gnu.org ([2001:4830:134:3::10]:38772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9M-0007Yw-QQ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9L-0007qR-2r
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:24 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cUG9K-0007pp-Qi
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:23 -0500
Received: by mail-wm0-x22c.google.com with SMTP id r144so2717041wme.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:05:22 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Jan 2017 17:04:49 +0000
Message-Id: <20170119170507.16185-10-alex.bennee@linaro.org>
In-Reply-To: <20170119170507.16185-1-alex.bennee@linaro.org>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 09/27] tcg: remove global exit_request
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

There are now only two uses of the global exit_request left.

The first ensures we exit the run_loop when we first start to process
pending work and in the kick handler. This is just as easily done by
setting the first_cpu->exit_request flag.

The second use is in the round robin kick routine. The global
exit_request ensured every vCPU would set its local exit_request and
cause a full exit of the loop. Now the iothread isn't being held while
running we can just rely on the kick handler to push us out as intended.

We lightly re-factor the main vCPU thread to ensure cpu->exit_requests
cause us to exit the main loop and process any IO requests that might
come along.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
v5
  - minor merge conflict with kick patch
v4
  - moved to after iothread unlocking patch
  - needed to remove kick exit_request as well.
  - remove extraneous cpu->exit_request check
  - remove stray exit_request setting
  - remove needless atomic operation
---
 cpu-exec-common.c       |  2 --
 cpu-exec.c              |  9 ++-------
 cpus.c                  | 18 ++++++++++--------
 include/exec/exec-all.h |  3 ---
 4 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/cpu-exec-common.c b/cpu-exec-common.c
index e2bc053372..0504a9457b 100644
--- a/cpu-exec-common.c
+++ b/cpu-exec-common.c
@@ -23,8 +23,6 @@
 #include "exec/exec-all.h"
 #include "exec/memory-internal.h"
 
-bool exit_request;
-
 /* exit the current TB, but without causing any exception to be raised */
 void cpu_loop_exit_noexc(CPUState *cpu)
 {
diff --git a/cpu-exec.c b/cpu-exec.c
index f42a128bdf..cc09c1fc37 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -565,9 +565,8 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
         /* Something asked us to stop executing
          * chained TBs; just continue round the main
          * loop. Whatever requested the exit will also
-         * have set something else (eg exit_request or
-         * interrupt_request) which we will handle
-         * next time around the loop.  But we need to
+         * have set something else (eg interrupt_request) which we
+         * will handle next time around the loop.  But we need to
          * ensure the tcg_exit_req read in generated code
          * comes before the next read of cpu->exit_request
          * or cpu->interrupt_request.
@@ -623,10 +622,6 @@ int cpu_exec(CPUState *cpu)
 
     rcu_read_lock();
 
-    if (unlikely(atomic_mb_read(&exit_request))) {
-        cpu->exit_request = 1;
-    }
-
     cc->cpu_exec_enter(cpu);
 
     /* Calculate difference between guest clock and host clock.
diff --git a/cpus.c b/cpus.c
index b78c093550..7f2c6226d8 100644
--- a/cpus.c
+++ b/cpus.c
@@ -788,7 +788,6 @@ static inline int64_t qemu_tcg_next_kick(void)
 static void qemu_cpu_kick_rr_cpu(void)
 {
     CPUState *cpu;
-    atomic_mb_set(&exit_request, 1);
     do {
         cpu = atomic_mb_read(&tcg_current_rr_cpu);
         if (cpu) {
@@ -1311,11 +1310,11 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
 
     start_tcg_kick_timer();
 
-    /* process any pending work */
-    atomic_mb_set(&exit_request, 1);
-
     cpu = first_cpu;
 
+    /* process any pending work */
+    cpu->exit_request = 1;
+
     while (1) {
         /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
         qemu_account_warp_timer();
@@ -1324,7 +1323,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
             cpu = first_cpu;
         }
 
-        for (; cpu != NULL && !exit_request; cpu = CPU_NEXT(cpu)) {
+        while (cpu && !cpu->exit_request) {
             atomic_mb_set(&tcg_current_rr_cpu, cpu);
 
             qemu_clock_enable(QEMU_CLOCK_VIRTUAL,
@@ -1344,12 +1343,15 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                 break;
             }
 
-        } /* for cpu.. */
+            cpu = CPU_NEXT(cpu);
+        } /* while (cpu && !cpu->exit_request).. */
+
         /* Does not need atomic_mb_set because a spurious wakeup is okay.  */
         atomic_set(&tcg_current_rr_cpu, NULL);
 
-        /* Pairs with smp_wmb in qemu_cpu_kick.  */
-        atomic_mb_set(&exit_request, 0);
+        if (cpu && cpu->exit_request) {
+            atomic_mb_set(&cpu->exit_request, 0);
+        }
 
         handle_icount_deadline();
 
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 3cbd359dd7..bd4622ac5d 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -403,7 +403,4 @@ bool memory_region_is_unassigned(MemoryRegion *mr);
 /* vl.c */
 extern int singlestep;
 
-/* cpu-exec.c, accessed with atomic_mb_read/atomic_mb_set */
-extern bool exit_request;
-
 #endif
-- 
2.11.0
