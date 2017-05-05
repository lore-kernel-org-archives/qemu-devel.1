Received: from eggs.gnu.org ([2001:4830:134:3::10]:52552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6acO-0001kO-Ph
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6acM-0006hT-1X
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:48 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6acL-0006hE-OE
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:45 -0400
Received: by mail-wm0-x22b.google.com with SMTP id 142so2193782wma.1
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 03:37:45 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 May 2017 11:38:15 +0100
Message-Id: <20170505103822.20641-3-alex.bennee@linaro.org>
In-Reply-To: <20170505103822.20641-1-alex.bennee@linaro.org>
References: <20170505103822.20641-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v1 2/9] cpus: push BQL lock to
 qemu_*_wait_io_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, boost.lists@gmail.com, pavel.dovgaluk@ispras.ru
Cc: cota@braap.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:Overall" <kvm@vger.kernel.org>

We only really need to grab the lock for initial setup (so we don't
race with the thread-spawning thread). After that we can drop the lock
for the whole main loop and only grab it for waiting for IO events.

There is a slight wrinkle for the round-robin TCG thread as we also
expire timers which needs to be done under BQL as they are in the
main-loop.

This is stage one of reducing the lock impact as we can drop the
requirement of implicit BQL for async work and only grab the lock when
we need to sleep on the cpu->halt_cond.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpus.c                | 27 ++++++++++++++++++++-------
 kvm-all.c             |  4 ----
 target/i386/hax-all.c |  2 --
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/cpus.c b/cpus.c
index 740b8dc3f8..89ae8cb30a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1069,6 +1069,8 @@ static bool qemu_tcg_should_sleep(CPUState *cpu)
 
 static void qemu_tcg_wait_io_event(CPUState *cpu)
 {
+    qemu_mutex_lock_iothread();
+
     while (qemu_tcg_should_sleep(cpu)) {
         stop_tcg_kick_timer();
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
@@ -1077,15 +1079,21 @@ static void qemu_tcg_wait_io_event(CPUState *cpu)
     start_tcg_kick_timer();
 
     qemu_wait_io_event_common(cpu);
+
+    qemu_mutex_unlock_iothread();
 }
 
 static void qemu_kvm_wait_io_event(CPUState *cpu)
 {
+    qemu_mutex_lock_iothread();
+
     while (cpu_thread_is_idle(cpu)) {
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
     }
 
     qemu_wait_io_event_common(cpu);
+
+    qemu_mutex_unlock_iothread();
 }
 
 static void *qemu_kvm_cpu_thread_fn(void *arg)
@@ -1111,6 +1119,8 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
 
     /* signal CPU creation */
     cpu->created = true;
+    qemu_mutex_unlock_iothread();
+
     qemu_cond_signal(&qemu_cpu_cond);
 
     do {
@@ -1153,10 +1163,10 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
 
     /* signal CPU creation */
     cpu->created = true;
+    qemu_mutex_unlock_iothread();
     qemu_cond_signal(&qemu_cpu_cond);
 
     while (1) {
-        qemu_mutex_unlock_iothread();
         do {
             int sig;
             r = sigwait(&waitset, &sig);
@@ -1167,6 +1177,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
         }
         qemu_mutex_lock_iothread();
         qemu_wait_io_event_common(cpu);
+        qemu_mutex_unlock_iothread();
     }
 
     return NULL;
@@ -1255,11 +1266,9 @@ static int tcg_cpu_exec(CPUState *cpu)
 #ifdef CONFIG_PROFILER
     ti = profile_getclock();
 #endif
-    qemu_mutex_unlock_iothread();
     cpu_exec_start(cpu);
     ret = cpu_exec(cpu);
     cpu_exec_end(cpu);
-    qemu_mutex_lock_iothread();
 #ifdef CONFIG_PROFILER
     tcg_time += profile_getclock() - ti;
 #endif
@@ -1318,6 +1327,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             qemu_wait_io_event_common(cpu);
         }
     }
+    qemu_mutex_unlock_iothread();
 
     start_tcg_kick_timer();
 
@@ -1327,6 +1337,9 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
     cpu->exit_request = 1;
 
     while (1) {
+
+        qemu_mutex_lock_iothread();
+
         /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
         qemu_account_warp_timer();
 
@@ -1335,6 +1348,8 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
          */
         handle_icount_deadline();
 
+        qemu_mutex_unlock_iothread();
+
         if (!cpu) {
             cpu = first_cpu;
         }
@@ -1360,9 +1375,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
                     cpu_handle_guest_debug(cpu);
                     break;
                 } else if (r == EXCP_ATOMIC) {
-                    qemu_mutex_unlock_iothread();
                     cpu_exec_step_atomic(cpu);
-                    qemu_mutex_lock_iothread();
                     break;
                 }
             } else if (cpu->stop) {
@@ -1403,6 +1416,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
     current_cpu = cpu;
 
     hax_init_vcpu(cpu);
+    qemu_mutex_unlock_iothread();
     qemu_cond_signal(&qemu_cpu_cond);
 
     while (1) {
@@ -1452,6 +1466,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     cpu->created = true;
     cpu->can_do_io = 1;
     current_cpu = cpu;
+    qemu_mutex_unlock_iothread();
     qemu_cond_signal(&qemu_cpu_cond);
 
     /* process any pending work */
@@ -1476,9 +1491,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                 g_assert(cpu->halted);
                 break;
             case EXCP_ATOMIC:
-                qemu_mutex_unlock_iothread();
                 cpu_exec_step_atomic(cpu);
-                qemu_mutex_lock_iothread();
             default:
                 /* Ignore everything else? */
                 break;
diff --git a/kvm-all.c b/kvm-all.c
index 90b8573656..4cb5347205 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1963,8 +1963,6 @@ int kvm_cpu_exec(CPUState *cpu)
         return EXCP_HLT;
     }
 
-    qemu_mutex_unlock_iothread();
-
     do {
         MemTxAttrs attrs;
 
@@ -2093,8 +2091,6 @@ int kvm_cpu_exec(CPUState *cpu)
         }
     } while (ret == 0);
 
-    qemu_mutex_lock_iothread();
-
     if (ret < 0) {
         cpu_dump_state(cpu, stderr, fprintf, CPU_DUMP_CODE);
         vm_stop(RUN_STATE_INTERNAL_ERROR);
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index ef13015215..71f3c01977 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -513,9 +513,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
 
         hax_vcpu_interrupt(env);
 
-        qemu_mutex_unlock_iothread();
         hax_ret = hax_vcpu_run(vcpu);
-        qemu_mutex_lock_iothread();
         current_cpu = cpu;
 
         /* Simply continue the vcpu_run if system call interrupted */
-- 
2.11.0
