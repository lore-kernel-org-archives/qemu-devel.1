Received: from eggs.gnu.org ([2001:4830:134:3::10]:50675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UgO-0003VI-4E
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UgM-0008Iz-W4
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:12 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45180)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UgM-0008Hf-KD
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:10 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 14:26:10 +0300
Message-ID: <20171031112610.10516.78685.stgit@pasha-VirtualBox>
In-Reply-To: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 13/26] cpus: only take BQL for sleeping
 threads
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

Now the only real need to hold the BQL is for when we sleep on the
cpu->halt conditional. The lock is actually dropped while the thread
sleeps so the actual window for contention is pretty small. This also
means we can remove the special case hack for exclusive work and
simply declare that work no longer has an implicit BQL held. This
isn't a major problem async work is generally only changing things in
the context of its own vCPU. If it needs to work across vCPUs it
should be using the exclusive mechanism or possibly taking the lock
itself.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

---
 cpus-common.c |   13 +++++--------
 cpus.c        |   10 ++++------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/cpus-common.c b/cpus-common.c
index 59f751e..64661c3 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -310,6 +310,11 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu=
_func func,
     queue_work_on_cpu(cpu, wi);
 }
=20
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
-            /* Running work items outside the BQL avoids the following d=
eadlock:
-             * 1) start_exclusive() is called with the BQL taken while a=
nother
-             * CPU is running; 2) cpu_exec in the other CPU tries to tak=
es the
-             * BQL, so it goes to sleep; start_exclusive() is sleeping t=
oo, so
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
index efde5c1..de6dfce 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1127,31 +1127,29 @@ static bool qemu_tcg_should_sleep(CPUState *cpu)
=20
 static void qemu_tcg_wait_io_event(CPUState *cpu)
 {
-    qemu_mutex_lock_iothread();
=20
     while (qemu_tcg_should_sleep(cpu)) {
+        qemu_mutex_lock_iothread();
         stop_tcg_kick_timer();
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+        qemu_mutex_unlock_iothread();
     }
=20
     start_tcg_kick_timer();
=20
     qemu_wait_io_event_common(cpu);
-
-    qemu_mutex_unlock_iothread();
 }
=20
 static void qemu_kvm_wait_io_event(CPUState *cpu)
 {
-    qemu_mutex_lock_iothread();
=20
     while (cpu_thread_is_idle(cpu)) {
+        qemu_mutex_lock_iothread();
         qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+        qemu_mutex_unlock_iothread();
     }
=20
     qemu_wait_io_event_common(cpu);
-
-    qemu_mutex_unlock_iothread();
 }
=20
 static void *qemu_kvm_cpu_thread_fn(void *arg)
