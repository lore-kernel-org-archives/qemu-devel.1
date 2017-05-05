Received: from eggs.gnu.org ([2001:4830:134:3::10]:52547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6acO-0001kK-Oe
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6acM-0006ht-PS
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:48 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6acM-0006hP-Ii
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:37:46 -0400
Received: by mail-wr0-x236.google.com with SMTP id z52so1382916wrc.2
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 03:37:46 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 May 2017 11:38:16 +0100
Message-Id: <20170505103822.20641-4-alex.bennee@linaro.org>
In-Reply-To: <20170505103822.20641-1-alex.bennee@linaro.org>
References: <20170505103822.20641-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v1 3/9] cpus: only take BQL for sleeping
 threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, boost.lists@gmail.com, pavel.dovgaluk@ispras.ru
Cc: cota@braap.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Now the only real need to hold the BQL is for when we sleep on the
cpu->halt conditional. The lock is actually dropped while the thread
sleeps so the actual window for contention is pretty small. This also
means we can remove the special case hack for exclusive work and
simply declare that work no longer has an implicit BQL held. This
isn't a major problem async work is generally only changing things in
the context of its own vCPU. If it needs to work across vCPUs it
should be using the exclusive mechanism or possibly taking the lock
itself.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpus-common.c | 13 +++++--------
 cpus.c        | 10 ++++------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 59f751ecf9..64661c3193 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -310,6 +310,11 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
     queue_work_on_cpu(cpu, wi);
 }
 
+/* Work items run outside of the BQL. This is essential for avoiding a
+ * deadlock for exclusive work but also applies to non-exclusive work.
+ * If the work requires cross-vCPU changes then it should use the
+ * exclusive mechanism.
+ */
 void process_queued_cpu_work(CPUState *cpu)
 {
     struct qemu_work_item *wi;
@@ -327,17 +332,9 @@ void process_queued_cpu_work(CPUState *cpu)
         }
         qemu_mutex_unlock(&cpu->work_mutex);
         if (wi->exclusive) {
-            /* Running work items outside the BQL avoids the following deadlock:
-             * 1) start_exclusive() is called with the BQL taken while another
-             * CPU is running; 2) cpu_exec in the other CPU tries to takes the
-             * BQL, so it goes to sleep; start_exclusive() is sleeping too, so
-             * neither CPU can proceed.
-             */
-            qemu_mutex_unlock_iothread();
             start_exclusive();
             wi->func(cpu, wi->data);
             end_exclusive();
-            qemu_mutex_lock_iothread();
         } else {
             wi->func(cpu, wi->data);
         }
diff --git a/cpus.c b/cpus.c
index 89ae8cb30a..df279dd320 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1069,31 +1069,29 @@ static bool qemu_tcg_should_sleep(CPUState *cpu)
 
 static void qemu_tcg_wait_io_event(CPUState *cpu)
 {
-    qemu_mutex_lock_iothread();
 
     while (qemu_tcg_should_sleep(cpu)) {
+        qemu_mutex_lock_iothread();
         stop_tcg_kick_timer();
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+        qemu_mutex_unlock_iothread();
     }
 
     start_tcg_kick_timer();
 
     qemu_wait_io_event_common(cpu);
-
-    qemu_mutex_unlock_iothread();
 }
 
 static void qemu_kvm_wait_io_event(CPUState *cpu)
 {
-    qemu_mutex_lock_iothread();
 
     while (cpu_thread_is_idle(cpu)) {
+        qemu_mutex_lock_iothread();
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+        qemu_mutex_unlock_iothread();
     }
 
     qemu_wait_io_event_common(cpu);
-
-    qemu_mutex_unlock_iothread();
 }
 
 static void *qemu_kvm_cpu_thread_fn(void *arg)
-- 
2.11.0
