Received: from eggs.gnu.org ([2001:4830:134:3::10]:51285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abenetopoulos@gmail.com>) id 1cqNgg-0000Rz-DR
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abenetopoulos@gmail.com>) id 1cqNgY-0005GU-6q
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:35:14 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <abenetopoulos@gmail.com>)
	id 1cqNgX-0005G8-PU
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:35:06 -0400
Received: by mail-wr0-x244.google.com with SMTP id l37so23430569wrc.3
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 10:35:05 -0700 (PDT)
From: Achilles Benetopoulos <abenetopoulos@gmail.com>
Message-ID: <8408e117-8ab1-150f-c7f9-254b6dd46b23@gmail.com>
Date: Tue, 21 Mar 2017 19:35:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] qemu/thread: Add support for error reporting
 in qemu_thread_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: crosthwaite.peter@gmail.com, armbru@redhat.com, quintela@redhat.com, pbonzini@redhat.com

Failure during thread creation in qemu_thread_create does not force
the program to exit anymore, since that isn't always the desired
behaviour. The caller of qemu_thread_create is responsible for the
error handling.

Signed-off-by: Achilles Benetopoulos <abenetopoulos@gmail.com>
---
 cpus.c                      | 43 +++++++++++++++++++++++++++++++++++--------
 dump.c                      |  8 +++++++-
 hw/misc/edu.c               |  9 ++++++++-
 hw/usb/ccid-card-emulated.c | 13 +++++++++++--
 include/qemu/thread.h       |  2 +-
 io/task.c                   |  7 ++++++-
 iothread.c                  |  9 ++++++++-
 migration/migration.c       | 30 +++++++++++++++++++++++++++---
 migration/postcopy-ram.c    | 10 +++++++++-
 migration/ram.c             | 24 ++++++++++++++++++++++--
 migration/savevm.c          |  7 ++++++-
 net/colo-compare.c          |  9 ++++++++-
 tests/atomic_add-bench.c    |  9 ++++++++-
 tests/iothread.c            |  9 ++++++++-
 tests/qht-bench.c           |  9 ++++++++-
 tests/rcutorture.c          | 11 ++++++++++-
 tests/test-aio.c            |  8 +++++++-
 tests/test-rcu-list.c       |  9 ++++++++-
 ui/vnc-jobs.c               |  8 +++++++-
 util/compatfd.c             | 10 +++++++++-
 util/oslib-posix.c          |  9 ++++++++-
 util/qemu-thread-posix.c    | 15 ++++++++++-----
 util/qemu-thread-win32.c    |  7 +++++--
 util/rcu.c                  |  9 ++++++++-
 util/thread-pool.c          | 11 ++++++++++-
 25 files changed, 254 insertions(+), 41 deletions(-)

diff --git a/cpus.c b/cpus.c
index 167d961..bc741f4 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1599,6 +1599,7 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
     char thread_name[VCPU_THREAD_NAME_SIZE];
     static QemuCond *single_tcg_halt_cond;
     static QemuThread *single_tcg_cpu_thread;
+    Error *local_err = NULL;
 
     if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
         cpu->thread = g_malloc0(sizeof(QemuThread));
@@ -1612,14 +1613,25 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
                  cpu->cpu_index);
 
             qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE);
+                    cpu, QEMU_THREAD_JOINABLE, &local_err);
+
+            if (local_err) {
+                error_report_err(local_err);
+                exit(1);
+            }
 
         } else {
             /* share a single thread for all cpus with TCG */
             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
+
             qemu_thread_create(cpu->thread, thread_name,
-                               qemu_tcg_rr_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE);
+                    qemu_tcg_rr_cpu_thread_fn, cpu, QEMU_THREAD_JOINABLE,
+                    &local_err);
+
+            if (local_err) {
+                error_report_err(local_err);
+                exit(1);
+            }
 
             single_tcg_halt_cond = cpu->halt_cond;
             single_tcg_cpu_thread = cpu->thread;
@@ -1640,6 +1652,7 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
 static void qemu_hax_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
+    Error *local_err = NULL;
 
     cpu->thread = g_malloc0(sizeof(QemuThread));
     cpu->halt_cond = g_malloc0(sizeof(QemuCond));
@@ -1648,7 +1661,11 @@ static void qemu_hax_start_vcpu(CPUState *cpu)
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HAX",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, qemu_hax_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+                           cpu, QEMU_THREAD_JOINABLE, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        exit(1);
+    } 
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
@@ -1660,14 +1677,19 @@ static void qemu_hax_start_vcpu(CPUState *cpu)
 static void qemu_kvm_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
+    Error *local_err = NULL;
 
     cpu->thread = g_malloc0(sizeof(QemuThread));
     cpu->halt_cond = g_malloc0(sizeof(QemuCond));
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
              cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_kvm_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+    qemu_thread_create(cpu->thread, thread_name, qemu_kvm_cpu_thread_fn, cpu,
+            QEMU_THREAD_JOINABLE, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        exit(1);
+    }
     while (!cpu->created) {
         qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
     }
@@ -1676,14 +1698,19 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
 static void qemu_dummy_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
+    Error *local_err = NULL;
 
     cpu->thread = g_malloc0(sizeof(QemuThread));
     cpu->halt_cond = g_malloc0(sizeof(QemuCond));
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
              cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_dummy_cpu_thread_fn, cpu,
-                       QEMU_THREAD_JOINABLE);
+    qemu_thread_create(cpu->thread, thread_name, qemu_dummy_cpu_thread_fn,
+                           cpu, QEMU_THREAD_JOINABLE, &local_err); 
+    if (local_err) {
+        error_report_err(local_err);
+        exit(1);
+    }
     while (!cpu->created) {
         qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
     }
diff --git a/dump.c b/dump.c
index f7b80d8..aae6a84 100644
--- a/dump.c
+++ b/dump.c
@@ -1805,7 +1805,13 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     if (detach_p) {
         /* detached dump */
         qemu_thread_create(&s->dump_thread, "dump_thread", dump_thread,
-                           s, QEMU_THREAD_DETACHED);
+                               s, QEMU_THREAD_DETACHED, &local_err);
+
+        if (local_err) {
+            error_propagate(errp, local_err);
+            atomic_set(&s->status, DUMP_STATUS_FAILED);
+            return;
+        }
     } else {
         /* sync dump */
         dump_process(s, errp);
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 401039c..f76932b 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -28,6 +28,7 @@
 #include "qemu/timer.h"
 #include "qemu/main-loop.h" /* iothread mutex */
 #include "qapi/visitor.h"
+#include "qapi/error.h"
 
 #define EDU(obj)        OBJECT_CHECK(EduState, obj, "edu")
 
@@ -342,13 +343,19 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
 {
     EduState *edu = DO_UPCAST(EduState, pdev, pdev);
     uint8_t *pci_conf = pdev->config;
+    Error *local_err = NULL;
 
     timer_init_ms(&edu->dma_timer, QEMU_CLOCK_VIRTUAL, edu_dma_timer, edu);
 
     qemu_mutex_init(&edu->thr_mutex);
     qemu_cond_init(&edu->thr_cond);
     qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
-                       edu, QEMU_THREAD_JOINABLE);
+                       edu, QEMU_THREAD_JOINABLE, &local_err);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     pci_config_set_interrupt_pin(pci_conf, 1);
 
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 9962786..b7f3e61 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -485,6 +485,7 @@ static int emulated_initfn(CCIDCardState *base)
     EmulatedState *card = EMULATED_CCID_CARD(base);
     VCardEmulError ret;
     const EnumTable *ptable;
+    Error *err = NULL, *local_err = NULL;
 
     QSIMPLEQ_INIT(&card->event_list);
     QSIMPLEQ_INIT(&card->guest_apdu_list);
@@ -541,9 +542,17 @@ static int emulated_initfn(CCIDCardState *base)
         return -1;
     }
     qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
-                       card, QEMU_THREAD_JOINABLE);
+                       card, QEMU_THREAD_JOINABLE, &err);
+
     qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
-                       card, QEMU_THREAD_JOINABLE);
+                       card, QEMU_THREAD_JOINABLE, &local_err);
+    error_propagate(&err, local_err);
+
+    if (err) {
+        error_report_err(err);
+        return -1;
+    }
+
     return 0;
 }
 
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 9910f49..8d44ee6 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -55,7 +55,7 @@ void qemu_event_destroy(QemuEvent *ev);
 
 void qemu_thread_create(QemuThread *thread, const char *name,
                         void *(*start_routine)(void *),
-                        void *arg, int mode);
+                        void *arg, int mode, Error **errp);
 void *qemu_thread_join(QemuThread *thread);
 void qemu_thread_get_self(QemuThread *thread);
 bool qemu_thread_is_self(QemuThread *thread);
diff --git a/io/task.c b/io/task.c
index 3ce5560..f0c2d3f 100644
--- a/io/task.c
+++ b/io/task.c
@@ -122,6 +122,7 @@ void qio_task_run_in_thread(QIOTask *task,
 {
     struct QIOTaskThreadData *data = g_new0(struct QIOTaskThreadData, 1);
     QemuThread thread;
+    Error *local_err = NULL;
 
     data->task = task;
     data->worker = worker;
@@ -133,7 +134,11 @@ void qio_task_run_in_thread(QIOTask *task,
                        "io-task-worker",
                        qio_task_thread_worker,
                        data,
-                       QEMU_THREAD_DETACHED);
+                       QEMU_THREAD_DETACHED, &local_err);
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
 }
 
 
diff --git a/iothread.c b/iothread.c
index beeb870..8939838 100644
--- a/iothread.c
+++ b/iothread.c
@@ -132,7 +132,14 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
     name = object_get_canonical_path_component(OBJECT(obj));
     thread_name = g_strdup_printf("IO %s", name);
     qemu_thread_create(&iothread->thread, thread_name, iothread_run,
-                       iothread, QEMU_THREAD_JOINABLE);
+                           iothread, QEMU_THREAD_JOINABLE, &local_error);
+
+    if (local_error) {
+        error_propagate(errp, local_error);
+        aio_context_unref(iothread->ctx);
+        iothread->ctx = NULL;
+        return;
+    }
     g_free(thread_name);
     g_free(name);
 
diff --git a/migration/migration.c b/migration/migration.c
index 54060f7..4ae9964 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -387,6 +387,7 @@ static void process_incoming_migration_co(void *opaque)
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps;
     int ret;
+    Error *local_err = NULL;
 
     mis->from_src_file = f;
     mis->largest_page_size = qemu_ram_pagesize_largest();
@@ -420,7 +421,12 @@ static void process_incoming_migration_co(void *opaque)
     if (!ret && migration_incoming_enable_colo()) {
         mis->migration_incoming_co = qemu_coroutine_self();
         qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
-             colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
+                colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE,
+                &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return;
+        }
         mis->have_colo_incoming_thread = true;
         qemu_coroutine_yield();
 
@@ -1598,6 +1604,7 @@ out:
 
 static int open_return_path_on_source(MigrationState *ms)
 {
+    Error *local_err = NULL;
 
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
     if (!ms->rp_state.from_dst_file) {
@@ -1606,7 +1613,13 @@ static int open_return_path_on_source(MigrationState *ms)
 
     trace_open_return_path_on_source();
     qemu_thread_create(&ms->rp_state.rp_thread, "return path",
-                       source_return_path_thread, ms, QEMU_THREAD_JOINABLE);
+                       source_return_path_thread, ms, QEMU_THREAD_JOINABLE,
+                       &local_err);
+
+    if (local_err) {
+        error_report_err(local_err);
+        return -1;
+    }
 
     trace_open_return_path_on_source_continue();
 
@@ -2068,6 +2081,8 @@ static void *migration_thread(void *opaque)
 
 void migrate_fd_connect(MigrationState *s)
 {
+    Error *local_err = NULL;
+
     s->expected_downtime = s->parameters.downtime_limit;
     s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup, s);
 
@@ -2094,7 +2109,16 @@ void migrate_fd_connect(MigrationState *s)
 
     migrate_compress_threads_create();
     qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &local_err);
+
+    if (local_err) {
+        error_report_err(local_err);
+        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
+                MIGRATION_STATUS_FAILED);
+        migrate_fd_cleanup(s);
+        return;
+    }
+
     s->migration_thread_running = true;
 }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index dc80dbb..e641021 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -503,6 +503,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
 
 int postcopy_ram_enable_notify(MigrationIncomingState *mis)
 {
+    Error *local_err = NULL;
     /* Open the fd for the kernel to give us userfaults */
     mis->userfault_fd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
     if (mis->userfault_fd == -1) {
@@ -530,7 +531,14 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
 
     qemu_sem_init(&mis->fault_thread_sem, 0);
     qemu_thread_create(&mis->fault_thread, "postcopy/fault",
-                       postcopy_ram_fault_thread, mis, QEMU_THREAD_JOINABLE);
+                       postcopy_ram_fault_thread, mis, QEMU_THREAD_JOINABLE,
+                       &local_err);
+
+    if (local_err) {
+        error_report_err(local_err);
+        return -1;
+    }
+
     qemu_sem_wait(&mis->fault_thread_sem);
     qemu_sem_destroy(&mis->fault_thread_sem);
     mis->have_fault_thread = true;
diff --git a/migration/ram.c b/migration/ram.c
index de1e0a3..3822940 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -357,6 +357,7 @@ void migrate_compress_threads_join(void)
 void migrate_compress_threads_create(void)
 {
     int i, thread_count;
+    Error *err = NULL, *local_err = NULL;
 
     if (!migrate_use_compression()) {
         return;
@@ -378,7 +379,16 @@ void migrate_compress_threads_create(void)
         qemu_cond_init(&comp_param[i].cond);
         qemu_thread_create(compress_threads + i, "compress",
                            do_data_compress, comp_param + i,
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &local_err);
+
+        if (local_err) {
+            error_propagate(&err, local_err);
+            local_err = NULL;
+        }
+    }
+
+    if (err) {
+        error_report_err(err);
     }
 }
 
@@ -2303,6 +2313,7 @@ static void wait_for_decompress_done(void)
 void migrate_decompress_threads_create(void)
 {
     int i, thread_count;
+    Error *err = NULL, *local_err = NULL;
 
     thread_count = migrate_decompress_threads();
     decompress_threads = g_new0(QemuThread, thread_count);
@@ -2317,7 +2328,16 @@ void migrate_decompress_threads_create(void)
         decomp_param[i].quit = false;
         qemu_thread_create(decompress_threads + i, "decompress",
                            do_data_decompress, decomp_param + i,
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &local_err);
+
+        if (local_err) {
+            error_propagate(&err, local_err);
+            local_err = NULL;
+        }
+    }
+
+    if (err) {
+        error_report_err(err);
     }
 }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 3b19a4a..ca9f82f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1561,6 +1561,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
 static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
 {
     PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_LISTENING);
+    Error *local_err = NULL;
     trace_loadvm_postcopy_handle_listen();
     if (ps != POSTCOPY_INCOMING_ADVISE && ps != POSTCOPY_INCOMING_DISCARD) {
         error_report("CMD_POSTCOPY_LISTEN in wrong postcopy state (%d)", ps);
@@ -1593,7 +1594,11 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     qemu_sem_init(&mis->listen_thread_sem, 0);
     qemu_thread_create(&mis->listen_thread, "postcopy/listen",
                        postcopy_ram_listen_thread, mis->from_src_file,
-                       QEMU_THREAD_DETACHED);
+                       QEMU_THREAD_DETACHED, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return -1;
+    }
     qemu_sem_wait(&mis->listen_thread_sem);
     qemu_sem_destroy(&mis->listen_thread_sem);
 
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 54e6d40..c1656e1 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -670,6 +670,7 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
     Chardev *chr;
     char thread_name[64];
     static int compare_id;
+    Error *local_err = NULL;
 
     if (!s->pri_indev || !s->sec_indev || !s->outdev) {
         error_setg(errp, "colo compare needs 'primary_in' ,"
@@ -711,7 +712,13 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
     sprintf(thread_name, "colo-compare %d", compare_id);
     qemu_thread_create(&s->thread, thread_name,
                        colo_compare_thread, s,
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &local_err);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     compare_id++;
 
     return;
diff --git a/tests/atomic_add-bench.c b/tests/atomic_add-bench.c
index caa1e8e..ffba4dc 100644
--- a/tests/atomic_add-bench.c
+++ b/tests/atomic_add-bench.c
@@ -2,6 +2,7 @@
 #include "qemu/thread.h"
 #include "qemu/host-utils.h"
 #include "qemu/processor.h"
+#include "qapi/error.h"
 
 struct thread_info {
     uint64_t r;
@@ -86,6 +87,7 @@ static void run_test(void)
 static void create_threads(void)
 {
     unsigned int i;
+    Error *local_err = NULL;
 
     threads = g_new(QemuThread, n_threads);
     th_info = g_new(struct thread_info, n_threads);
@@ -97,7 +99,12 @@ static void create_threads(void)
 
         info->r = (i + 1) ^ time(NULL);
         qemu_thread_create(&threads[i], NULL, thread_func, info,
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &local_err);
+
+        if (local_err) {
+            error_report_err(local_err);
+            exit(1);
+        }
     }
 }
 
diff --git a/tests/iothread.c b/tests/iothread.c
index 777d9ee..5a4c6a1 100644
--- a/tests/iothread.c
+++ b/tests/iothread.c
@@ -69,11 +69,18 @@ void iothread_join(IOThread *iothread)
 IOThread *iothread_new(void)
 {
     IOThread *iothread = g_new0(IOThread, 1);
+    Error *local_err = NULL;
 
     qemu_mutex_init(&iothread->init_done_lock);
     qemu_cond_init(&iothread->init_done_cond);
     qemu_thread_create(&iothread->thread, NULL, iothread_run,
-                       iothread, QEMU_THREAD_JOINABLE);
+                       iothread, QEMU_THREAD_JOINABLE, &local_err);
+
+    if (local_err) {
+        error_report_err(local_err);
+        /*what makes sense here as a return value?*/
+        return NULL;
+    }
 
     /* Wait for initialization to complete */
     qemu_mutex_lock(&iothread->init_done_lock);
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index 2afa09d..609492c 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -10,6 +10,7 @@
 #include "qemu/qht.h"
 #include "qemu/rcu.h"
 #include "exec/tb-hash-xx.h"
+#include "qapi/error.h"
 
 struct thread_stats {
     size_t rd;
@@ -228,6 +229,7 @@ th_create_n(QemuThread **threads, struct thread_info **infos, const char *name,
     struct thread_info *info;
     QemuThread *th;
     int i;
+    Error *local_err = NULL;
 
     th = g_malloc(sizeof(*th) * n);
     *threads = th;
@@ -239,7 +241,12 @@ th_create_n(QemuThread **threads, struct thread_info **infos, const char *name,
         prepare_thread_info(&info[i], offset + i);
         info[i].func = func;
         qemu_thread_create(&th[i], name, thread_func, &info[i],
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &local_err);
+
+        if (local_err) {
+            error_report_err(local_err);
+            exit(1);
+        }
     }
 }
 
diff --git a/tests/rcutorture.c b/tests/rcutorture.c
index 4002ecf..63c4d84 100644
--- a/tests/rcutorture.c
+++ b/tests/rcutorture.c
@@ -64,6 +64,7 @@
 #include "qemu/atomic.h"
 #include "qemu/rcu.h"
 #include "qemu/thread.h"
+#include "qapi/error.h"
 
 long long n_reads = 0LL;
 long n_updates = 0L;
@@ -85,12 +86,20 @@ static int n_threads;
 
 static void create_thread(void *(*func)(void *))
 {
+    Error *local_err = NULL;
+
     if (n_threads >= NR_THREADS) {
         fprintf(stderr, "Thread limit of %d exceeded!\n", NR_THREADS);
         exit(-1);
     }
     qemu_thread_create(&threads[n_threads], "test", func, &data[n_threads],
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &local_err);
+
+    if (local_err) {
+        error_report_err(local_err);
+        exit(1);
+    }
+
     n_threads++;
 }
 
diff --git a/tests/test-aio.c b/tests/test-aio.c
index 54e20d6..ab9482c 100644
--- a/tests/test-aio.c
+++ b/tests/test-aio.c
@@ -140,6 +140,7 @@ static void test_acquire(void)
 {
     QemuThread thread;
     AcquireTestData data;
+    Error *local_err = NULL;
 
     /* Dummy event notifier ensures aio_poll() will block */
     event_notifier_init(&data.notifier, false);
@@ -152,7 +153,12 @@ static void test_acquire(void)
 
     qemu_thread_create(&thread, "test_acquire_thread",
                        test_acquire_thread,
-                       &data, QEMU_THREAD_JOINABLE);
+                       &data, QEMU_THREAD_JOINABLE, &local_err);
+
+    if (local_err) {
+        error_report_err(local_err);
+        return;
+    }
 
     /* Block in aio_poll(), let other thread kick us and acquire context */
     aio_context_acquire(ctx);
diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
index 1514d7e..82d7b7a 100644
--- a/tests/test-rcu-list.c
+++ b/tests/test-rcu-list.c
@@ -25,6 +25,7 @@
 #include "qemu/rcu.h"
 #include "qemu/thread.h"
 #include "qemu/rcu_queue.h"
+#include "qapi/error.h"
 
 /*
  * Test variables.
@@ -63,12 +64,18 @@ static int select_random_el(int max)
 
 static void create_thread(void *(*func)(void *))
 {
+    Error *local_err = NULL;
     if (n_threads >= NR_THREADS) {
         fprintf(stderr, "Thread limit of %d exceeded!\n", NR_THREADS);
         exit(-1);
     }
     qemu_thread_create(&threads[n_threads], "test", func, &data[n_threads],
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &local_err);
+
+    if (local_err) {
+        error_report_err(local_err);
+        exit(1);
+    }
     n_threads++;
 }
 
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index f786777..6ac43ed 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -322,12 +322,18 @@ static bool vnc_worker_thread_running(void)
 void vnc_start_worker_thread(void)
 {
     VncJobQueue *q;
+    Error *local_err = NULL;
 
     if (vnc_worker_thread_running())
         return ;
 
     q = vnc_queue_init();
     qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread, q,
-                       QEMU_THREAD_DETACHED);
+                       QEMU_THREAD_DETACHED, &local_err);
+
+    if (local_err) {
+        error_report_err(local_err);
+        return;
+    }
     queue = q; /* Set global queue */
 }
diff --git a/util/compatfd.c b/util/compatfd.c
index 980bd33..2561c8c 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -18,6 +18,7 @@
 #include "qemu/thread.h"
 
 #include <sys/syscall.h>
+#include "qapi/error.h"
 
 struct sigfd_compat_info
 {
@@ -70,6 +71,7 @@ static int qemu_signalfd_compat(const sigset_t *mask)
     struct sigfd_compat_info *info;
     QemuThread thread;
     int fds[2];
+    Error *local_err = NULL;
 
     info = malloc(sizeof(*info));
     if (info == NULL) {
@@ -89,7 +91,13 @@ static int qemu_signalfd_compat(const sigset_t *mask)
     info->fd = fds[1];
 
     qemu_thread_create(&thread, "signalfd_compat", sigwait_compat, info,
-                       QEMU_THREAD_DETACHED);
+                       QEMU_THREAD_DETACHED, &local_err);
+
+    if (local_err) {
+        free(info);
+        error_report_err(local_err);
+        return -1;
+    }
 
     return fds[0];
 }
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 3fe6089..81b8a92 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -387,6 +387,7 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
     uint64_t numpages_per_thread, size_per_thread;
     char *addr = area;
     int i = 0;
+    Error *local_err = NULL;
 
     memset_thread_failed = false;
     memset_num_threads = MIN(smp_cpus, MAX_MEM_PREALLOC_THREAD_COUNT);
@@ -400,7 +401,13 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
         memset_thread[i].hpagesize = hpagesize;
         qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
                            do_touch_pages, &memset_thread[i],
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &local_err);
+
+        if (local_err) {
+            error_report_err(local_err);
+            return true;
+        }
+
         addr += size_per_thread;
         numpages -= numpages_per_thread;
     }
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 73e3a0e..8756ee7 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -14,6 +14,7 @@
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
+#include "qapi/error.h"
 
 static bool name_threads;
 
@@ -448,7 +449,7 @@ static void qemu_thread_set_name(QemuThread *thread, const char *name)
 
 void qemu_thread_create(QemuThread *thread, const char *name,
                        void *(*start_routine)(void*),
-                       void *arg, int mode)
+                       void *arg, int mode, Error **errp)
 {
     sigset_t set, oldset;
     int err;
@@ -456,15 +457,18 @@ void qemu_thread_create(QemuThread *thread, const char *name,
 
     err = pthread_attr_init(&attr);
     if (err) {
-        error_exit(err, __func__);
+        error_setg_errno(errp, errno, "Could not initialize thread attributes");
+        return;
     }
 
     /* Leave signal handling to the iothread.  */
     sigfillset(&set);
     pthread_sigmask(SIG_SETMASK, &set, &oldset);
     err = pthread_create(&thread->thread, &attr, start_routine, arg);
-    if (err)
-        error_exit(err, __func__);
+    if (err) {
+        error_setg_errno(errp, errno, "Could not create thread");
+        return;
+    }
 
     if (name_threads) {
         qemu_thread_set_name(thread, name);
@@ -473,7 +477,8 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     if (mode == QEMU_THREAD_DETACHED) {
         err = pthread_detach(thread->thread);
         if (err) {
-            error_exit(err, __func__);
+            error_setg_errno(errp, errno, "Could not detach thread");
+            return;
         }
     }
     pthread_sigmask(SIG_SETMASK, &oldset, NULL);
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 29c3e4d..5208ce4 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -14,6 +14,7 @@
 #include "qemu-common.h"
 #include "qemu/thread.h"
 #include "qemu/notify.h"
+#include "qapi/error.h"
 #include <process.h>
 
 static bool name_threads;
@@ -454,7 +455,7 @@ void *qemu_thread_join(QemuThread *thread)
 
 void qemu_thread_create(QemuThread *thread, const char *name,
                        void *(*start_routine)(void *),
-                       void *arg, int mode)
+                       void *arg, int mode, Error **errp)
 {
     HANDLE hThread;
     struct QemuThreadData *data;
@@ -473,8 +474,10 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     hThread = (HANDLE) _beginthreadex(NULL, 0, win32_start_routine,
                                       data, 0, &thread->tid);
     if (!hThread) {
-        error_exit(GetLastError(), __func__);
+        error_setg_errno(errp, errno, "_beginthreadex failed");
+        return;
     }
+
     CloseHandle(hThread);
     thread->data = data;
 }
diff --git a/util/rcu.c b/util/rcu.c
index 9adc5e4..910d912 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -32,6 +32,7 @@
 #include "qemu/atomic.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#include "qapi/error.h"
 
 /*
  * Global grace period counter.  Bit 0 is always one in rcu_gp_ctr.
@@ -302,6 +303,7 @@ void rcu_unregister_thread(void)
 static void rcu_init_complete(void)
 {
     QemuThread thread;
+    Error *local_err = NULL;
 
     qemu_mutex_init(&rcu_registry_lock);
     qemu_mutex_init(&rcu_sync_lock);
@@ -313,7 +315,12 @@ static void rcu_init_complete(void)
      * must have been quiescent even after forking, just recreate it.
      */
     qemu_thread_create(&thread, "call_rcu", call_rcu_thread,
-                       NULL, QEMU_THREAD_DETACHED);
+                       NULL, QEMU_THREAD_DETACHED, &local_err);
+
+    if (local_err) {
+        error_report_err(local_err);
+        return;
+    }
 
     rcu_register_thread();
 }
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 610646d..e1e8edf 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -22,6 +22,7 @@
 #include "trace.h"
 #include "block/thread-pool.h"
 #include "qemu/main-loop.h"
+#include "qapi/error.h"
 
 static void do_spawn_thread(ThreadPool *pool);
 
@@ -123,16 +124,24 @@ static void *worker_thread(void *opaque)
 static void do_spawn_thread(ThreadPool *pool)
 {
     QemuThread t;
+    Error *local_err = NULL;
 
     /* Runs with lock taken.  */
     if (!pool->new_threads) {
         return;
     }
 
+    qemu_thread_create(&t, "worker", worker_thread, pool, QEMU_THREAD_DETACHED,
+            &local_err);
+
+    if (local_err) {
+        error_report_err(local_err);
+        return;
+    }
+
     pool->new_threads--;
     pool->pending_threads++;
 
-    qemu_thread_create(&t, "worker", worker_thread, pool, QEMU_THREAD_DETACHED);
 }
 
 static void spawn_thread_bh_fn(void *opaque)
-- 
2.3.2 (Apple Git-55)
