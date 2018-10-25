Received: from eggs.gnu.org ([2001:4830:134:3::10]:60234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFh5G-00045Y-5t
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFgvP-0008Q2-MP
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:53 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53065)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFgvP-0008Bz-Ay
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:47:51 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 10:46:44 -0400
Message-Id: <20181025144644.15464-71-cota@braap.org>
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
References: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 71/71] cpus-common: wait on the CPU lock for
 exclusive work completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

The current implementation of exclusive work can suffer from high
contention when the number of guest CPUs is large (> 16 or so). The
reason is that all CPUs end up waiting on the same condvar/mutex pair,
which unnecessarily slows them down to wake up.

Fix it by having them wait on their "local" cpu->lock. This shifts
the burden of waking up threads to the exclusive thread, but this
is preferable to the existing solution because it induces a lot
less contention.

Some perf numbers when compiling a linux kernel with `make tinyconfig'
in an aarch64 guest:

- Host: 32-core Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz
- Workload: Linux kernel compilation with `make -j $n' in a VM with $n vCPUs

                             [ Y axis: speedup over $n=1 ]
         8 +----------------------------------------------------------------+
           |      +    +      +      +     #D############+      +      +    |
           |                             ##*B*********   D#############D    |
         7 |-+                         ##**XXXXXXXXXX ***                 +-|
           |                         ##**X               B**********        |
           |                       ##**                             ***     |
         6 |-+                  X##*                                   B  +-|
           |                  X##*                                          |
           |                 XD*                                            |
         5 |-+              X#                                            +-|
           |               X#                                               |
           |              *#                                                |
         4 |-+           *#                                               +-|
           |            *#                                                  |
           |          XB#                                                   |
           |          XD                                                    |
         3 |-+       X#                                                   +-|
           |         ##                                                     |
           |        ##                                                      |
         2 |-+      #                                                     +-|
           |       #                                                        |
           |       #                                                        |
         1 |-+    D                                                       +-|
           |                                                    after ##D## |
           |      +    +      +      +      +     +      +     before **B** |
         0 +----------------------------------------------------------------+
                  1    4      8      12     16    20     24     28     32
                                      Guest vCPUs
  png: https://imgur.com/jskOcxR

With this change we can't obtain an additional speedup, although we mitigate
the performance collapse. This is due to the heavy-duty nature of async
safe work, and the frequency at which it is run.

A proper fix would reduce the overhead of safe async work.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qom/cpu.h |   4 +-
 cpus-common.c     | 146 ++++++++++++++++++----------------------------
 2 files changed, 61 insertions(+), 89 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 0e90d9d093..204bc94056 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -345,7 +345,6 @@ struct CPUState {
     HANDLE hThread;
 #endif
     int thread_id;
-    bool running, has_waiter;
     bool thread_kicked;
     bool crash_occurred;
     bool exit_request;
@@ -367,6 +366,9 @@ struct CPUState {
     bool stop;
     bool stopped;
     bool unplug;
+    bool running;
+    bool exclusive_waiter;
+    bool exclusive_ongoing;
 
     CPUAddressSpace *cpu_ases;
     int num_ases;
diff --git a/cpus-common.c b/cpus-common.c
index ad8a8ef535..cffb2b71ac 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -24,22 +24,22 @@
 #include "sysemu/cpus.h"
 
 static QemuMutex qemu_cpu_list_lock;
-static QemuCond exclusive_cond;
 static QemuCond exclusive_resume;
 
 /* >= 1 if a thread is inside start_exclusive/end_exclusive.  Written
  * under qemu_cpu_list_lock, read with atomic operations.
  */
 static int pending_cpus;
+static bool exclusive_work_ongoing;
 
 void qemu_init_cpu_list(void)
 {
     /* This is needed because qemu_init_cpu_list is also called by the
      * child process in a fork.  */
     pending_cpus = 0;
+    exclusive_work_ongoing = false;
 
     qemu_mutex_init(&qemu_cpu_list_lock);
-    qemu_cond_init(&exclusive_cond);
     qemu_cond_init(&exclusive_resume);
 }
 
@@ -77,7 +77,7 @@ static void finish_safe_work(CPUState *cpu)
    must be held.  */
 static inline void exclusive_idle(void)
 {
-    while (pending_cpus) {
+    while (exclusive_work_ongoing) {
         qemu_cond_wait(&exclusive_resume, &qemu_cpu_list_lock);
     }
 }
@@ -91,6 +91,10 @@ void cpu_list_add(CPUState *cpu)
     } else {
         assert(!cpu_index_auto_assigned);
     }
+
+    /* make sure no exclusive jobs are running before touching the list */
+    exclusive_idle();
+
     QTAILQ_INSERT_TAIL_RCU(&cpus, cpu, node);
     qemu_mutex_unlock(&qemu_cpu_list_lock);
 
@@ -108,6 +112,9 @@ void cpu_list_remove(CPUState *cpu)
 
     assert(!(cpu_index_auto_assigned && cpu != QTAILQ_LAST(&cpus, CPUTailQ)));
 
+    /* make sure no exclusive jobs are running before touching the list */
+    exclusive_idle();
+
     QTAILQ_REMOVE_RCU(&cpus, cpu, node);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     qemu_mutex_unlock(&qemu_cpu_list_lock);
@@ -214,120 +221,83 @@ void async_run_on_cpu_no_bql(CPUState *cpu, run_on_cpu_func func,
 void start_exclusive(void)
 {
     CPUState *other_cpu;
-    int running_cpus;
 
     qemu_mutex_lock(&qemu_cpu_list_lock);
     exclusive_idle();
+    exclusive_work_ongoing = true;
+    qemu_mutex_unlock(&qemu_cpu_list_lock);
 
     /* Make all other cpus stop executing.  */
-    atomic_set(&pending_cpus, 1);
-
-    /* Write pending_cpus before reading other_cpu->running.  */
-    smp_mb();
-    running_cpus = 0;
     CPU_FOREACH(other_cpu) {
-        if (atomic_read(&other_cpu->running)) {
-            other_cpu->has_waiter = true;
-            running_cpus++;
+        cpu_mutex_lock(other_cpu);
+        if (other_cpu->running) {
+            g_assert(!other_cpu->exclusive_waiter);
+            other_cpu->exclusive_waiter = true;
             qemu_cpu_kick(other_cpu);
         }
+        other_cpu->exclusive_ongoing = true;
+        cpu_mutex_unlock(other_cpu);
     }
 
-    atomic_set(&pending_cpus, running_cpus + 1);
-    while (pending_cpus > 1) {
-        qemu_cond_wait(&exclusive_cond, &qemu_cpu_list_lock);
+    /* wait for CPUs that were running to clear us */
+    CPU_FOREACH(other_cpu) {
+        cpu_mutex_lock(other_cpu);
+        while (other_cpu->exclusive_waiter) {
+            qemu_cond_wait(&other_cpu->cond, &other_cpu->lock);
+        }
+        cpu_mutex_unlock(other_cpu);
     }
-
-    /* Can release mutex, no one will enter another exclusive
-     * section until end_exclusive resets pending_cpus to 0.
-     */
-    qemu_mutex_unlock(&qemu_cpu_list_lock);
 }
 
 /* Finish an exclusive operation.  */
 void end_exclusive(void)
 {
+    CPUState *other_cpu;
+
+    CPU_FOREACH(other_cpu) {
+        cpu_mutex_lock(other_cpu);
+        g_assert(!other_cpu->exclusive_waiter);
+        g_assert(other_cpu->exclusive_ongoing);
+        other_cpu->exclusive_ongoing = false;
+        qemu_cond_signal(&other_cpu->cond);
+        cpu_mutex_unlock(other_cpu);
+    }
+
     qemu_mutex_lock(&qemu_cpu_list_lock);
-    atomic_set(&pending_cpus, 0);
+    exclusive_work_ongoing = false;
     qemu_cond_broadcast(&exclusive_resume);
     qemu_mutex_unlock(&qemu_cpu_list_lock);
 }
 
+static void cpu_exec_exclusive_locked(CPUState *cpu)
+{
+    g_assert(cpu_mutex_locked(cpu));
+
+    if (cpu->exclusive_waiter) {
+        cpu->exclusive_waiter = false;
+        qemu_cond_signal(&cpu->cond);
+    }
+    while (cpu->exclusive_ongoing) {
+        qemu_cond_wait(&cpu->cond, &cpu->lock);
+    }
+}
+
 /* Wait for exclusive ops to finish, and begin cpu execution.  */
 void cpu_exec_start(CPUState *cpu)
 {
-    atomic_set(&cpu->running, true);
-
-    /* Write cpu->running before reading pending_cpus.  */
-    smp_mb();
-
-    /* 1. start_exclusive saw cpu->running == true and pending_cpus >= 1.
-     * After taking the lock we'll see cpu->has_waiter == true and run---not
-     * for long because start_exclusive kicked us.  cpu_exec_end will
-     * decrement pending_cpus and signal the waiter.
-     *
-     * 2. start_exclusive saw cpu->running == false but pending_cpus >= 1.
-     * This includes the case when an exclusive item is running now.
-     * Then we'll see cpu->has_waiter == false and wait for the item to
-     * complete.
-     *
-     * 3. pending_cpus == 0.  Then start_exclusive is definitely going to
-     * see cpu->running == true, and it will kick the CPU.
-     */
-    if (unlikely(atomic_read(&pending_cpus))) {
-        qemu_mutex_lock(&qemu_cpu_list_lock);
-        if (!cpu->has_waiter) {
-            /* Not counted in pending_cpus, let the exclusive item
-             * run.  Since we have the lock, just set cpu->running to true
-             * while holding it; no need to check pending_cpus again.
-             */
-            atomic_set(&cpu->running, false);
-            exclusive_idle();
-            /* Now pending_cpus is zero.  */
-            atomic_set(&cpu->running, true);
-        } else {
-            /* Counted in pending_cpus, go ahead and release the
-             * waiter at cpu_exec_end.
-             */
-        }
-        qemu_mutex_unlock(&qemu_cpu_list_lock);
-    }
+    cpu_mutex_lock(cpu);
+    cpu_exec_exclusive_locked(cpu);
+    cpu->running = true;
+    cpu_mutex_unlock(cpu);
 }
 
 /* Mark cpu as not executing, and release pending exclusive ops.  */
 void cpu_exec_end(CPUState *cpu)
 {
-    atomic_set(&cpu->running, false);
-
-    /* Write cpu->running before reading pending_cpus.  */
-    smp_mb();
-
-    /* 1. start_exclusive saw cpu->running == true.  Then it will increment
-     * pending_cpus and wait for exclusive_cond.  After taking the lock
-     * we'll see cpu->has_waiter == true.
-     *
-     * 2. start_exclusive saw cpu->running == false but here pending_cpus >= 1.
-     * This includes the case when an exclusive item started after setting
-     * cpu->running to false and before we read pending_cpus.  Then we'll see
-     * cpu->has_waiter == false and not touch pending_cpus.  The next call to
-     * cpu_exec_start will run exclusive_idle if still necessary, thus waiting
-     * for the item to complete.
-     *
-     * 3. pending_cpus == 0.  Then start_exclusive is definitely going to
-     * see cpu->running == false, and it can ignore this CPU until the
-     * next cpu_exec_start.
-     */
-    if (unlikely(atomic_read(&pending_cpus))) {
-        qemu_mutex_lock(&qemu_cpu_list_lock);
-        if (cpu->has_waiter) {
-            cpu->has_waiter = false;
-            atomic_set(&pending_cpus, pending_cpus - 1);
-            if (pending_cpus == 1) {
-                qemu_cond_signal(&exclusive_cond);
-            }
-        }
-        qemu_mutex_unlock(&qemu_cpu_list_lock);
-    }
+    cpu_mutex_lock(cpu);
+    cpu->running = false;
+    cpu_exec_exclusive_locked(cpu);
+    cpu_mutex_unlock(cpu);
 }
 
 void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
-- 
2.17.1
