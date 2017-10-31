Received: from eggs.gnu.org ([2001:4830:134:3::10]:50897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Ugl-0003rI-Lj
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Ugj-0000N5-JN
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:35 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45292)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9Ugj-0000MM-23
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:26:33 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 14:26:33 +0300
Message-ID: <20171031112633.10516.44062.stgit@pasha-VirtualBox>
In-Reply-To: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 17/26] replay: push replay_mutex_lock up
 the call tree
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

Now instead of using the replay_lock to guard the output of the log we
now use it to protect the whole execution section. This replaces what
the BQL used to do when it was held during TCG execution.

We also introduce some rules for locking order - mainly that you
cannot take the replay_mutex while holding the BQL. This leads to some
slight sophistry during start-up and extending the
replay_mutex_destroy function to unlock the mutex without checking
for the BQL condition so it can be cleanly dropped in the non-replay
case.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

---
 cpus.c                   |   32 ++++++++++++++++++++++++++++++++
 docs/replay.txt          |   19 +++++++++++++++++++
 include/sysemu/replay.h  |    2 ++
 replay/replay-char.c     |   21 ++++++++-------------
 replay/replay-events.c   |   18 +++++-------------
 replay/replay-internal.c |   18 +++++++++++++-----
 replay/replay-time.c     |   10 +++++-----
 replay/replay.c          |   40 ++++++++++++++++++++--------------------
 util/main-loop.c         |   23 ++++++++++++++++++++---
 vl.c                     |    2 ++
 10 files changed, 126 insertions(+), 59 deletions(-)

diff --git a/cpus.c b/cpus.c
index de6dfce..110ce0a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1293,6 +1293,10 @@ static void prepare_icount_for_run(CPUState *cpu)
         insns_left =3D MIN(0xffff, cpu->icount_budget);
         cpu->icount_decr.u16.low =3D insns_left;
         cpu->icount_extra =3D cpu->icount_budget - insns_left;
+
+        if (replay_mode !=3D REPLAY_MODE_NONE) {
+            replay_mutex_lock();
+        }
     }
 }
=20
@@ -1308,6 +1312,10 @@ static void process_icount_data(CPUState *cpu)
         cpu->icount_budget =3D 0;
=20
         replay_account_executed_instructions();
+
+        if (replay_mode !=3D REPLAY_MODE_NONE) {
+            replay_mutex_unlock();
+        }
     }
 }
=20
@@ -1395,6 +1403,10 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
=20
     while (1) {
=20
+        if (replay_mode !=3D REPLAY_MODE_NONE) {
+            replay_mutex_lock();
+        }
+
         qemu_mutex_lock_iothread();
=20
         /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
@@ -1407,6 +1419,10 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
=20
         qemu_mutex_unlock_iothread();
=20
+        if (replay_mode !=3D REPLAY_MODE_NONE) {
+            replay_mutex_unlock();
+        }
+
         if (!cpu) {
             cpu =3D first_cpu;
         }
@@ -1677,12 +1693,28 @@ void pause_all_vcpus(void)
         cpu_stop_current();
     }
=20
+    /* We need to drop the replay_lock so any vCPU threads woken up
+     * can finish their replay tasks
+     */
+    if (replay_mode !=3D REPLAY_MODE_NONE) {
+        g_assert(replay_mutex_locked());
+        qemu_mutex_unlock_iothread();
+        replay_mutex_unlock();
+        qemu_mutex_lock_iothread();
+    }
+
     while (!all_vcpus_paused()) {
         qemu_cond_wait(&qemu_pause_cond, &qemu_global_mutex);
         CPU_FOREACH(cpu) {
             qemu_cpu_kick(cpu);
         }
     }
+
+    if (replay_mode !=3D REPLAY_MODE_NONE) {
+        qemu_mutex_unlock_iothread();
+        replay_mutex_lock();
+        qemu_mutex_lock_iothread();
+    }
 }
=20
 void cpu_resume(CPUState *cpu)
diff --git a/docs/replay.txt b/docs/replay.txt
index c52407f..994153e 100644
--- a/docs/replay.txt
+++ b/docs/replay.txt
@@ -49,6 +49,25 @@ Modifications of qemu include:
  * recording/replaying user input (mouse and keyboard)
  * adding internal checkpoints for cpu and io synchronization
=20
+Locking and thread synchronisation
+----------------------------------
+
+Previously the synchronisation of the main thread and the vCPU thread
+was ensured by the holding of the BQL. However the trend has been to
+reduce the time the BQL was held across the system including under TCG
+system emulation. As it is important that batches of events are kept
+in sequence (e.g. expiring timers and checkpoints in the main thread
+while instruction checkpoints are written by the vCPU thread) we need
+another lock to keep things in lock-step. This role is now handled by
+the replay_mutex_lock. It used to be held only for each event being
+written but now it is held for a whole execution period. This results
+in a deterministic ping-pong between the two main threads.
+
+As deadlocks are easy to introduce a new rule is introduced that the
+replay_mutex_lock is taken before any BQL locks. Conversely you cannot
+release the replay_lock while the BQL is still held.
+
+
 Non-deterministic events
 ------------------------
=20
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 9973849..d026b28 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -63,6 +63,8 @@ bool replay_mutex_locked(void);
=20
 /* Replay process control functions */
=20
+/*! Enables and take replay locks (even if we don't use it) */
+void replay_init_locks(void);
 /*! Enables recording or saving event log with specified parameters */
 void replay_configure(struct QemuOpts *opts);
 /*! Initializes timers used for snapshotting and enables events recordin=
g */
diff --git a/replay/replay-char.c b/replay/replay-char.c
index cbf7c04..736cc8c 100755
--- a/replay/replay-char.c
+++ b/replay/replay-char.c
@@ -96,25 +96,24 @@ void *replay_event_char_read_load(void)
=20
 void replay_char_write_event_save(int res, int offset)
 {
+    g_assert(replay_mutex_locked());
+
     replay_save_instructions();
-    replay_mutex_lock();
     replay_put_event(EVENT_CHAR_WRITE);
     replay_put_dword(res);
     replay_put_dword(offset);
-    replay_mutex_unlock();
 }
=20
 void replay_char_write_event_load(int *res, int *offset)
 {
+    g_assert(replay_mutex_locked());
+
     replay_account_executed_instructions();
-    replay_mutex_lock();
     if (replay_next_event_is(EVENT_CHAR_WRITE)) {
         *res =3D replay_get_dword();
         *offset =3D replay_get_dword();
         replay_finish_event();
-        replay_mutex_unlock();
     } else {
-        replay_mutex_unlock();
         error_report("Missing character write event in the replay log");
         exit(1);
     }
@@ -122,23 +121,21 @@ void replay_char_write_event_load(int *res, int *of=
fset)
=20
 int replay_char_read_all_load(uint8_t *buf)
 {
-    replay_mutex_lock();
+    g_assert(replay_mutex_locked());
+
     if (replay_next_event_is(EVENT_CHAR_READ_ALL)) {
         size_t size;
         int res;
         replay_get_array(buf, &size);
         replay_finish_event();
-        replay_mutex_unlock();
         res =3D (int)size;
         assert(res >=3D 0);
         return res;
     } else if (replay_next_event_is(EVENT_CHAR_READ_ALL_ERROR)) {
         int res =3D replay_get_dword();
         replay_finish_event();
-        replay_mutex_unlock();
         return res;
     } else {
-        replay_mutex_unlock();
         error_report("Missing character read all event in the replay log=
");
         exit(1);
     }
@@ -146,19 +143,17 @@ int replay_char_read_all_load(uint8_t *buf)
=20
 void replay_char_read_all_save_error(int res)
 {
+    g_assert(replay_mutex_locked());
     assert(res < 0);
     replay_save_instructions();
-    replay_mutex_lock();
     replay_put_event(EVENT_CHAR_READ_ALL_ERROR);
     replay_put_dword(res);
-    replay_mutex_unlock();
 }
=20
 void replay_char_read_all_save_buf(uint8_t *buf, int offset)
 {
+    g_assert(replay_mutex_locked());
     replay_save_instructions();
-    replay_mutex_lock();
     replay_put_event(EVENT_CHAR_READ_ALL);
     replay_put_array(buf, offset);
-    replay_mutex_unlock();
 }
diff --git a/replay/replay-events.c b/replay/replay-events.c
index e858254..a941efb 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -79,16 +79,14 @@ bool replay_has_events(void)
=20
 void replay_flush_events(void)
 {
-    replay_mutex_lock();
+    g_assert(replay_mutex_locked());
+
     while (!QTAILQ_EMPTY(&events_list)) {
         Event *event =3D QTAILQ_FIRST(&events_list);
-        replay_mutex_unlock();
         replay_run_event(event);
-        replay_mutex_lock();
         QTAILQ_REMOVE(&events_list, event, events);
         g_free(event);
     }
-    replay_mutex_unlock();
 }
=20
 void replay_disable_events(void)
@@ -102,14 +100,14 @@ void replay_disable_events(void)
=20
 void replay_clear_events(void)
 {
-    replay_mutex_lock();
+    g_assert(replay_mutex_locked());
+
     while (!QTAILQ_EMPTY(&events_list)) {
         Event *event =3D QTAILQ_FIRST(&events_list);
         QTAILQ_REMOVE(&events_list, event, events);
=20
         g_free(event);
     }
-    replay_mutex_unlock();
 }
=20
 /*! Adds specified async event to the queue */
@@ -136,9 +134,8 @@ void replay_add_event(ReplayAsyncEventKind event_kind=
,
     event->opaque2 =3D opaque2;
     event->id =3D id;
=20
-    replay_mutex_lock();
+    g_assert(replay_mutex_locked());
     QTAILQ_INSERT_TAIL(&events_list, event, events);
-    replay_mutex_unlock();
 }
=20
 void replay_bh_schedule_event(QEMUBH *bh)
@@ -210,10 +207,7 @@ void replay_save_events(int checkpoint)
     while (!QTAILQ_EMPTY(&events_list)) {
         Event *event =3D QTAILQ_FIRST(&events_list);
         replay_save_event(event, checkpoint);
-
-        replay_mutex_unlock();
         replay_run_event(event);
-        replay_mutex_lock();
         QTAILQ_REMOVE(&events_list, event, events);
         g_free(event);
     }
@@ -299,9 +293,7 @@ void replay_read_events(int checkpoint)
         }
         replay_finish_event();
         read_event_kind =3D -1;
-        replay_mutex_unlock();
         replay_run_event(event);
-        replay_mutex_lock();
=20
         g_free(event);
     }
diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index e6b2fdb..d036a02 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -174,11 +174,6 @@ void replay_mutex_init(void)
     qemu_mutex_init(&lock);
 }
=20
-void replay_mutex_destroy(void)
-{
-    qemu_mutex_destroy(&lock);
-}
-
 static __thread bool replay_locked;
=20
 bool replay_mutex_locked(void)
@@ -186,15 +181,28 @@ bool replay_mutex_locked(void)
     return replay_locked;
 }
=20
+void replay_mutex_destroy(void)
+{
+    if (replay_mutex_locked()) {
+        qemu_mutex_unlock(&lock);
+    }
+    qemu_mutex_destroy(&lock);
+}
+
+
+/* Ordering constraints, replay_lock must be taken before BQL */
 void replay_mutex_lock(void)
 {
+    g_assert(!qemu_mutex_iothread_locked());
     g_assert(!replay_mutex_locked());
     qemu_mutex_lock(&lock);
     replay_locked =3D true;
 }
=20
+/* BQL can't be held when releasing the replay_lock */
 void replay_mutex_unlock(void)
 {
+    g_assert(!qemu_mutex_iothread_locked());
     g_assert(replay_mutex_locked());
     replay_locked =3D false;
     qemu_mutex_unlock(&lock);
diff --git a/replay/replay-time.c b/replay/replay-time.c
index f70382a..6a7565e 100644
--- a/replay/replay-time.c
+++ b/replay/replay-time.c
@@ -17,13 +17,13 @@
=20
 int64_t replay_save_clock(ReplayClockKind kind, int64_t clock)
 {
-    replay_save_instructions();
=20
     if (replay_file) {
-        replay_mutex_lock();
+        g_assert(replay_mutex_locked());
+
+        replay_save_instructions();
         replay_put_event(EVENT_CLOCK + kind);
         replay_put_qword(clock);
-        replay_mutex_unlock();
     }
=20
     return clock;
@@ -46,16 +46,16 @@ void replay_read_next_clock(ReplayClockKind kind)
 /*! Reads next clock event from the input. */
 int64_t replay_read_clock(ReplayClockKind kind)
 {
+    g_assert(replay_file && replay_mutex_locked());
+
     replay_account_executed_instructions();
=20
     if (replay_file) {
         int64_t ret;
-        replay_mutex_lock();
         if (replay_next_event_is(EVENT_CLOCK + kind)) {
             replay_read_next_clock(kind);
         }
         ret =3D replay_state.cached_clock[kind];
-        replay_mutex_unlock();
=20
         return ret;
     }
diff --git a/replay/replay.c b/replay/replay.c
index 4f24498..7fc50ea 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -80,8 +80,9 @@ int replay_get_instructions(void)
=20
 void replay_account_executed_instructions(void)
 {
+    g_assert(replay_mutex_locked());
+
     if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
-        replay_mutex_lock();
         if (replay_state.instructions_count > 0) {
             int count =3D (int)(replay_get_current_step()
                               - replay_state.current_step);
@@ -100,24 +101,22 @@ void replay_account_executed_instructions(void)
                 qemu_notify_event();
             }
         }
-        replay_mutex_unlock();
     }
 }
=20
 bool replay_exception(void)
 {
+
     if (replay_mode =3D=3D REPLAY_MODE_RECORD) {
+        g_assert(replay_mutex_locked());
         replay_save_instructions();
-        replay_mutex_lock();
         replay_put_event(EVENT_EXCEPTION);
-        replay_mutex_unlock();
         return true;
     } else if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
+        g_assert(replay_mutex_locked());
         bool res =3D replay_has_exception();
         if (res) {
-            replay_mutex_lock();
             replay_finish_event();
-            replay_mutex_unlock();
         }
         return res;
     }
@@ -129,10 +128,9 @@ bool replay_has_exception(void)
 {
     bool res =3D false;
     if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
+        g_assert(replay_mutex_locked());
         replay_account_executed_instructions();
-        replay_mutex_lock();
         res =3D replay_next_event_is(EVENT_EXCEPTION);
-        replay_mutex_unlock();
     }
=20
     return res;
@@ -141,17 +139,15 @@ bool replay_has_exception(void)
 bool replay_interrupt(void)
 {
     if (replay_mode =3D=3D REPLAY_MODE_RECORD) {
+        g_assert(replay_mutex_locked());
         replay_save_instructions();
-        replay_mutex_lock();
         replay_put_event(EVENT_INTERRUPT);
-        replay_mutex_unlock();
         return true;
     } else if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
+        g_assert(replay_mutex_locked());
         bool res =3D replay_has_interrupt();
         if (res) {
-            replay_mutex_lock();
             replay_finish_event();
-            replay_mutex_unlock();
         }
         return res;
     }
@@ -163,10 +159,9 @@ bool replay_has_interrupt(void)
 {
     bool res =3D false;
     if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
+        g_assert(replay_mutex_locked());
         replay_account_executed_instructions();
-        replay_mutex_lock();
         res =3D replay_next_event_is(EVENT_INTERRUPT);
-        replay_mutex_unlock();
     }
     return res;
 }
@@ -174,9 +169,8 @@ bool replay_has_interrupt(void)
 void replay_shutdown_request(ShutdownCause cause)
 {
     if (replay_mode =3D=3D REPLAY_MODE_RECORD) {
-        replay_mutex_lock();
+        g_assert(replay_mutex_locked());
         replay_put_event(EVENT_SHUTDOWN + cause);
-        replay_mutex_unlock();
     }
 }
=20
@@ -190,9 +184,9 @@ bool replay_checkpoint(ReplayCheckpoint checkpoint)
         return true;
     }
=20
-    replay_mutex_lock();
=20
     if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
+        g_assert(replay_mutex_locked());
         if (replay_next_event_is(EVENT_CHECKPOINT + checkpoint)) {
             replay_finish_event();
         } else if (replay_state.data_kind !=3D EVENT_ASYNC) {
@@ -205,15 +199,21 @@ bool replay_checkpoint(ReplayCheckpoint checkpoint)
            checkpoint were processed */
         res =3D replay_state.data_kind !=3D EVENT_ASYNC;
     } else if (replay_mode =3D=3D REPLAY_MODE_RECORD) {
+        g_assert(replay_mutex_locked());
         replay_put_event(EVENT_CHECKPOINT + checkpoint);
         replay_save_events(checkpoint);
         res =3D true;
     }
 out:
-    replay_mutex_unlock();
     return res;
 }
=20
+void replay_init_locks(void)
+{
+    replay_mutex_init();
+    replay_mutex_lock(); /* Hold while we start-up */
+}
+
 static void replay_enable(const char *fname, int mode)
 {
     const char *fmode =3D NULL;
@@ -233,8 +233,6 @@ static void replay_enable(const char *fname, int mode=
)
=20
     atexit(replay_finish);
=20
-    replay_mutex_init();
-
     replay_file =3D fopen(fname, fmode);
     if (replay_file =3D=3D NULL) {
         fprintf(stderr, "Replay: open %s: %s\n", fname, strerror(errno))=
;
@@ -274,6 +272,8 @@ void replay_configure(QemuOpts *opts)
     Location loc;
=20
     if (!opts) {
+        /* we no longer need this lock */
+        replay_mutex_destroy();
         return;
     }
=20
diff --git a/util/main-loop.c b/util/main-loop.c
index 7558eb5..7c5b163 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -29,6 +29,7 @@
 #include "qemu/sockets.h"	// struct in_addr needed for libslirp.h
 #include "sysemu/qtest.h"
 #include "sysemu/cpus.h"
+#include "sysemu/replay.h"
 #include "slirp/libslirp.h"
 #include "qemu/main-loop.h"
 #include "block/aio.h"
@@ -245,19 +246,26 @@ static int os_host_main_loop_wait(int64_t timeout)
         timeout =3D SCALE_MS;
     }
=20
+
     if (timeout) {
         spin_counter =3D 0;
-        qemu_mutex_unlock_iothread();
     } else {
         spin_counter++;
     }
+    qemu_mutex_unlock_iothread();
+
+    if (replay_mode !=3D REPLAY_MODE_NONE) {
+        replay_mutex_unlock();
+    }
=20
     ret =3D qemu_poll_ns((GPollFD *)gpollfds->data, gpollfds->len, timeo=
ut);
=20
-    if (timeout) {
-        qemu_mutex_lock_iothread();
+    if (replay_mode !=3D REPLAY_MODE_NONE) {
+        replay_mutex_lock();
     }
=20
+    qemu_mutex_lock_iothread();
+
     glib_pollfds_poll();
=20
     g_main_context_release(context);
@@ -463,8 +471,17 @@ static int os_host_main_loop_wait(int64_t timeout)
     poll_timeout_ns =3D qemu_soonest_timeout(poll_timeout_ns, timeout);
=20
     qemu_mutex_unlock_iothread();
+
+    if (replay_mode !=3D REPLAY_MODE_NONE) {
+        replay_mutex_unlock();
+    }
+
     g_poll_ret =3D qemu_poll_ns(poll_fds, n_poll_fds + w->num, poll_time=
out_ns);
=20
+    if (replay_mode !=3D REPLAY_MODE_NONE) {
+        replay_mutex_lock();
+    }
+
     qemu_mutex_lock_iothread();
     if (g_poll_ret > 0) {
         for (i =3D 0; i < w->num; i++) {
diff --git a/vl.c b/vl.c
index a8e0d03..77fc1ef 100644
--- a/vl.c
+++ b/vl.c
@@ -3137,6 +3137,8 @@ int main(int argc, char **argv, char **envp)
=20
     qemu_init_cpu_list();
     qemu_init_cpu_loop();
+
+    replay_init_locks();
     qemu_mutex_lock_iothread();
=20
     atexit(qemu_run_exit_notifiers);
