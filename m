Received: from eggs.gnu.org ([2001:4830:134:3::10]:40560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eduLW-0001iJ-UE
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:54:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eduLV-0008Ux-Ix
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:54:23 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57202)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eduLV-0008Ul-69
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:54:21 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 23 Jan 2018 11:54:21 +0300
Message-ID: <20180123085421.3419.45127.stgit@pasha-VirtualBox>
In-Reply-To: <20180123085319.3419.97865.stgit@pasha-VirtualBox>
References: <20180123085319.3419.97865.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v5 11/24] cpus: push BQL lock to
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
Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 accel/kvm/kvm-all.c |    1 -
 cpus.c              |   29 +++++++++++++++++------------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 071f4f5..9628512 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1863,7 +1863,6 @@ int kvm_cpu_exec(CPUState *cpu)
=20
     qemu_mutex_unlock_iothread();
     cpu_exec_start(cpu);
-
     do {
         MemTxAttrs attrs;
=20
diff --git a/cpus.c b/cpus.c
index 2cb0af9..577c764 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1141,6 +1141,7 @@ static void qemu_wait_io_event_common(CPUState *cpu=
)
=20
 static void qemu_tcg_rr_wait_io_event(CPUState *cpu)
 {
+    qemu_mutex_lock_iothread();
     while (all_cpu_threads_idle()) {
         stop_tcg_kick_timer();
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
@@ -1149,10 +1150,13 @@ static void qemu_tcg_rr_wait_io_event(CPUState *c=
pu)
     start_tcg_kick_timer();
=20
     qemu_wait_io_event_common(cpu);
+    qemu_mutex_unlock_iothread();
 }
=20
 static void qemu_wait_io_event(CPUState *cpu)
 {
+    qemu_mutex_lock_iothread();
+
     while (cpu_thread_is_idle(cpu)) {
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
     }
@@ -1164,6 +1168,7 @@ static void qemu_wait_io_event(CPUState *cpu)
     }
 #endif
     qemu_wait_io_event_common(cpu);
+    qemu_mutex_unlock_iothread();
 }
=20
 static void *qemu_kvm_cpu_thread_fn(void *arg)
@@ -1189,6 +1194,8 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
=20
     /* signal CPU creation */
     cpu->created =3D true;
+    qemu_mutex_unlock_iothread();
+
     qemu_cond_signal(&qemu_cpu_cond);
=20
     do {
@@ -1204,7 +1211,6 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     qemu_kvm_destroy_vcpu(cpu);
     cpu->created =3D false;
     qemu_cond_signal(&qemu_cpu_cond);
-    qemu_mutex_unlock_iothread();
     return NULL;
 }
=20
@@ -1231,10 +1237,10 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
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
@@ -1243,7 +1249,6 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
             perror("sigwait");
             exit(1);
         }
-        qemu_mutex_lock_iothread();
         qemu_wait_io_event(cpu);
     }
=20
@@ -1333,11 +1338,9 @@ static int tcg_cpu_exec(CPUState *cpu)
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
@@ -1397,6 +1400,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             qemu_wait_io_event_common(cpu);
         }
     }
+    qemu_mutex_unlock_iothread();
=20
     start_tcg_kick_timer();
=20
@@ -1406,6 +1410,8 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
     cpu->exit_request =3D 1;
=20
     while (1) {
+        qemu_mutex_lock_iothread();
+
         /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
         qemu_account_warp_timer();
=20
@@ -1414,6 +1420,8 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
          */
         handle_icount_deadline();
=20
+        qemu_mutex_unlock_iothread();
+
         if (!cpu) {
             cpu =3D first_cpu;
         }
@@ -1439,9 +1447,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
                     cpu_handle_guest_debug(cpu);
                     break;
                 } else if (r =3D=3D EXCP_ATOMIC) {
-                    qemu_mutex_unlock_iothread();
                     cpu_exec_step_atomic(cpu);
-                    qemu_mutex_lock_iothread();
                     break;
                 }
             } else if (cpu->stop) {
@@ -1482,6 +1488,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
     current_cpu =3D cpu;
=20
     hax_init_vcpu(cpu);
+    qemu_mutex_unlock_iothread();
     qemu_cond_signal(&qemu_cpu_cond);
=20
     while (1) {
@@ -1518,8 +1525,9 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
=20
     hvf_init_vcpu(cpu);
=20
-    /* signal CPU creation */
     cpu->created =3D true;
+    qemu_mutex_unlock_iothread();
+    /* signal CPU creation */
     qemu_cond_signal(&qemu_cpu_cond);
=20
     do {
@@ -1535,7 +1543,6 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     hvf_vcpu_destroy(cpu);
     cpu->created =3D false;
     qemu_cond_signal(&qemu_cpu_cond);
-    qemu_mutex_unlock_iothread();
     return NULL;
 }
=20
@@ -1568,6 +1575,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     cpu->created =3D true;
     cpu->can_do_io =3D 1;
     current_cpu =3D cpu;
+    qemu_mutex_unlock_iothread();
     qemu_cond_signal(&qemu_cpu_cond);
=20
     /* process any pending work */
@@ -1592,9 +1600,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                 g_assert(cpu->halted);
                 break;
             case EXCP_ATOMIC:
-                qemu_mutex_unlock_iothread();
                 cpu_exec_step_atomic(cpu);
-                qemu_mutex_lock_iothread();
             default:
                 /* Ignore everything else? */
                 break;
@@ -1603,7 +1609,6 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
             qemu_tcg_destroy_vcpu(cpu);
             cpu->created =3D false;
             qemu_cond_signal(&qemu_cpu_cond);
-            qemu_mutex_unlock_iothread();
             return NULL;
         }
=20
