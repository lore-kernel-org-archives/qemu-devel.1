Received: from eggs.gnu.org ([2001:4830:134:3::10]:46646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYBs-0000aW-KU
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYBo-0001K4-JF
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:26:24 -0500
Received: from mail.ispras.ru ([83.149.199.45]:41772)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eZYBo-0001JW-72
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 03:26:20 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 11 Jan 2018 11:26:21 +0300
Message-ID: <20180111082621.27295.81834.stgit@pasha-VirtualBox>
In-Reply-To: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v3 15/30] cpus: push BQL lock to
 qemu_*_wait_io_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

From: Alex Benn=C3=A9e <alex.bennee@linaro.org>

We only really need to grab the lock for initial setup (so we don't
race with the thread-spawning thread). After that we can drop the lock
for the whole main loop and only grab it for waiting for IO events.

There is a slight wrinkle for the round-robin TCG thread as we also
expire timers which needs to be done under BQL as they are in the
main-loop.

This is stage one of reducing the lock impact as we can drop the
requirement of implicit BQL for async work and only grab the lock when
we need to sleep on the cpu->halt_cond.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 accel/kvm/kvm-all.c   |    4 ----
 cpus.c                |   27 ++++++++++++++++++++-------
 target/i386/hax-all.c |    2 --
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f290f48..8d1d2c4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1857,9 +1857,7 @@ int kvm_cpu_exec(CPUState *cpu)
         return EXCP_HLT;
     }
=20
-    qemu_mutex_unlock_iothread();
     cpu_exec_start(cpu);
-
     do {
         MemTxAttrs attrs;
=20
@@ -1989,8 +1987,6 @@ int kvm_cpu_exec(CPUState *cpu)
     } while (ret =3D=3D 0);
=20
     cpu_exec_end(cpu);
-    qemu_mutex_lock_iothread();
-
     if (ret < 0) {
         cpu_dump_state(cpu, stderr, fprintf, CPU_DUMP_CODE);
         vm_stop(RUN_STATE_INTERNAL_ERROR);
diff --git a/cpus.c b/cpus.c
index b4146a8..82dcbf8 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1149,6 +1149,8 @@ static bool qemu_tcg_should_sleep(CPUState *cpu)
=20
 static void qemu_tcg_wait_io_event(CPUState *cpu)
 {
+    qemu_mutex_lock_iothread();
+
     while (qemu_tcg_should_sleep(cpu)) {
         stop_tcg_kick_timer();
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
@@ -1157,15 +1159,21 @@ static void qemu_tcg_wait_io_event(CPUState *cpu)
     start_tcg_kick_timer();
=20
     qemu_wait_io_event_common(cpu);
+
+    qemu_mutex_unlock_iothread();
 }
=20
 static void qemu_kvm_wait_io_event(CPUState *cpu)
 {
+    qemu_mutex_lock_iothread();
+
     while (cpu_thread_is_idle(cpu)) {
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
     }
=20
     qemu_wait_io_event_common(cpu);
+
+    qemu_mutex_unlock_iothread();
 }
=20
 static void qemu_hvf_wait_io_event(CPUState *cpu)
@@ -1199,6 +1207,8 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
=20
     /* signal CPU creation */
     cpu->created =3D true;
+    qemu_mutex_unlock_iothread();
+
     qemu_cond_signal(&qemu_cpu_cond);
=20
     do {
@@ -1241,10 +1251,10 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
=20
     /* signal CPU creation */
     cpu->created =3D true;
+    qemu_mutex_unlock_iothread();
     qemu_cond_signal(&qemu_cpu_cond);
=20
     while (1) {
-        qemu_mutex_unlock_iothread();
         do {
             int sig;
             r =3D sigwait(&waitset, &sig);
@@ -1255,6 +1265,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
         }
         qemu_mutex_lock_iothread();
         qemu_wait_io_event_common(cpu);
+        qemu_mutex_unlock_iothread();
     }
=20
     return NULL;
@@ -1343,11 +1354,9 @@ static int tcg_cpu_exec(CPUState *cpu)
 #ifdef CONFIG_PROFILER
     ti =3D profile_getclock();
 #endif
-    qemu_mutex_unlock_iothread();
     cpu_exec_start(cpu);
     ret =3D cpu_exec(cpu);
     cpu_exec_end(cpu);
-    qemu_mutex_lock_iothread();
 #ifdef CONFIG_PROFILER
     tcg_time +=3D profile_getclock() - ti;
 #endif
@@ -1407,6 +1416,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             qemu_wait_io_event_common(cpu);
         }
     }
+    qemu_mutex_unlock_iothread();
=20
     start_tcg_kick_timer();
=20
@@ -1416,6 +1426,9 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
     cpu->exit_request =3D 1;
=20
     while (1) {
+
+        qemu_mutex_lock_iothread();
+
         /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
         qemu_account_warp_timer();
=20
@@ -1424,6 +1437,8 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
          */
         handle_icount_deadline();
=20
+        qemu_mutex_unlock_iothread();
+
         if (!cpu) {
             cpu =3D first_cpu;
         }
@@ -1449,9 +1464,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
                     cpu_handle_guest_debug(cpu);
                     break;
                 } else if (r =3D=3D EXCP_ATOMIC) {
-                    qemu_mutex_unlock_iothread();
                     cpu_exec_step_atomic(cpu);
-                    qemu_mutex_lock_iothread();
                     break;
                 }
             } else if (cpu->stop) {
@@ -1492,6 +1505,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
     current_cpu =3D cpu;
=20
     hax_init_vcpu(cpu);
+    qemu_mutex_unlock_iothread();
     qemu_cond_signal(&qemu_cpu_cond);
=20
     while (1) {
@@ -1584,6 +1598,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     cpu->created =3D true;
     cpu->can_do_io =3D 1;
     current_cpu =3D cpu;
+    qemu_mutex_unlock_iothread();
     qemu_cond_signal(&qemu_cpu_cond);
=20
     /* process any pending work */
@@ -1608,9 +1623,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                 g_assert(cpu->halted);
                 break;
             case EXCP_ATOMIC:
-                qemu_mutex_unlock_iothread();
                 cpu_exec_step_atomic(cpu);
-                qemu_mutex_lock_iothread();
             default:
                 /* Ignore everything else? */
                 break;
diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 3ce6950..9fd60d9 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -513,11 +513,9 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
=20
         hax_vcpu_interrupt(env);
=20
-        qemu_mutex_unlock_iothread();
         cpu_exec_start(cpu);
         hax_ret =3D hax_vcpu_run(vcpu);
         cpu_exec_end(cpu);
-        qemu_mutex_lock_iothread();
=20
         /* Simply continue the vcpu_run if system call interrupted */
         if (hax_ret =3D=3D -EINTR || hax_ret =3D=3D -EAGAIN) {
