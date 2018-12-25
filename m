Received: from eggs.gnu.org ([208.118.235.92]:33187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnKu-0001Nu-MF
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1gbnKr-0003oH-Pt
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:32 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:45646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1gbnKr-0003mn-Br
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 09:05:29 -0500
From: Fei Li <fli@suse.com>
Date: Tue, 25 Dec 2018 22:04:39 +0800
Message-Id: <20181225140449.15786-7-fli@suse.com>
In-Reply-To: <20181225140449.15786-1-fli@suse.com>
References: <20181225140449.15786-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH for-4.0 v9 06/16] qemu_thread: Make
 qemu_thread_create() handle errors properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: lifei1214@126.com, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

qemu_thread_create() abort()s on error. Not nice. Give it a return
value and an Error ** argument, so it can return success/failure.

Considering qemu_thread_create() is quite widely used in qemu, split
this into two steps: this patch passes the &error_abort to
qemu_thread_create() everywhere, and the next 9 patches will improve
on &error_abort for callers who need.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
---
 cpus.c                      | 23 +++++++++++++++--------
 dump.c                      |  3 ++-
 hw/misc/edu.c               |  4 +++-
 hw/ppc/spapr_hcall.c        |  4 +++-
 hw/rdma/rdma_backend.c      |  3 ++-
 hw/usb/ccid-card-emulated.c |  5 +++--
 include/qemu/thread.h       |  4 ++--
 io/task.c                   |  3 ++-
 iothread.c                  |  3 ++-
 migration/migration.c       | 11 ++++++++---
 migration/postcopy-ram.c    |  4 +++-
 migration/ram.c             | 12 ++++++++----
 migration/savevm.c          |  3 ++-
 tests/atomic_add-bench.c    |  3 ++-
 tests/iothread.c            |  2 +-
 tests/qht-bench.c           |  3 ++-
 tests/rcutorture.c          |  3 ++-
 tests/test-aio.c            |  2 +-
 tests/test-rcu-list.c       |  3 ++-
 ui/vnc-jobs.c               |  6 ++++--
 util/compatfd.c             |  6 ++++--
 util/oslib-posix.c          |  3 ++-
 util/qemu-thread-posix.c    | 27 ++++++++++++++++++++-------
 util/qemu-thread-win32.c    | 16 ++++++++++++----
 util/rcu.c                  |  3 ++-
 util/thread-pool.c          |  4 +++-
 26 files changed, 112 insertions(+), 51 deletions(-)

diff --git a/cpus.c b/cpus.c
index 0ddeeefc14..25df03326b 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1961,15 +1961,17 @@ static void qemu_tcg_init_vcpu(CPUState *cpu)
             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
                  cpu->cpu_index);
 
+            /* TODO: let the callers handle the error instead of abort() here */
             qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE);
+                               cpu, QEMU_THREAD_JOINABLE, &error_abort);
 
         } else {
             /* share a single thread for all cpus with TCG */
             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
+            /* TODO: let the callers handle the error instead of abort() here */
             qemu_thread_create(cpu->thread, thread_name,
                                qemu_tcg_rr_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE);
+                               cpu, QEMU_THREAD_JOINABLE, &error_abort);
 
             single_tcg_halt_cond = cpu->halt_cond;
             single_tcg_cpu_thread = cpu->thread;
@@ -1997,8 +1999,9 @@ static void qemu_hax_start_vcpu(CPUState *cpu)
 
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HAX",
              cpu->cpu_index);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(cpu->thread, thread_name, qemu_hax_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
@@ -2013,8 +2016,9 @@ static void qemu_kvm_start_vcpu(CPUState *cpu)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
              cpu->cpu_index);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(cpu->thread, thread_name, qemu_kvm_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
 }
 
 static void qemu_hvf_start_vcpu(CPUState *cpu)
@@ -2031,8 +2035,9 @@ static void qemu_hvf_start_vcpu(CPUState *cpu)
 
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
              cpu->cpu_index);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
 }
 
 static void qemu_whpx_start_vcpu(CPUState *cpu)
@@ -2044,8 +2049,9 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
              cpu->cpu_index);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(cpu->thread, thread_name, qemu_whpx_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
@@ -2060,8 +2066,9 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
              cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_dummy_cpu_thread_fn, cpu,
-                       QEMU_THREAD_JOINABLE);
+    /* TODO: let the further caller handle the error instead of abort() here */
+    qemu_thread_create(cpu->thread, thread_name, qemu_dummy_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE, &error_abort);
 }
 
 void qemu_init_vcpu(CPUState *cpu)
diff --git a/dump.c b/dump.c
index 4ec94c5e25..c35d6ddd22 100644
--- a/dump.c
+++ b/dump.c
@@ -2020,8 +2020,9 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     if (detach_p) {
         /* detached dump */
         s->detached = true;
+        /* TODO: let the further caller handle the error instead of abort() */
         qemu_thread_create(&s->dump_thread, "dump_thread", dump_thread,
-                           s, QEMU_THREAD_DETACHED);
+                           s, QEMU_THREAD_DETACHED, &error_abort);
     } else {
         /* sync dump */
         dump_process(s, errp);
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index cdcf550dd7..3f4ba7ded3 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -28,6 +28,7 @@
 #include "hw/pci/msi.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h" /* iothread mutex */
+#include "qapi/error.h"
 #include "qapi/visitor.h"
 
 #define TYPE_PCI_EDU_DEVICE "edu"
@@ -355,8 +356,9 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
 
     qemu_mutex_init(&edu->thr_mutex);
     qemu_cond_init(&edu->thr_cond);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
-                       edu, QEMU_THREAD_JOINABLE);
+                       edu, QEMU_THREAD_JOINABLE, &error_abort);
 
     memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
                     "edu-mmio", 1 * MiB);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index ae913d070f..5bc2cf4540 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -538,8 +538,10 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     pending->shift = shift;
     pending->ret = H_HARDWARE;
 
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
-                       hpt_prepare_thread, pending, QEMU_THREAD_DETACHED);
+                       hpt_prepare_thread, pending,
+                       QEMU_THREAD_DETACHED, &error_abort);
 
     spapr->pending_hpt = pending;
 
diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index c28bfbd44d..25e0c7d0f5 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -263,7 +263,8 @@ static void start_comp_thread(RdmaBackendDev *backend_dev)
              ibv_get_device_name(backend_dev->ib_dev));
     backend_dev->comp_thread.run = true;
     qemu_thread_create(&backend_dev->comp_thread.thread, thread_name,
-                       comp_handler_thread, backend_dev, QEMU_THREAD_DETACHED);
+                       comp_handler_thread, backend_dev,
+                       QEMU_THREAD_DETACHED, &error_abort);
 }
 
 void rdma_backend_register_comp_handler(void (*handler)(void *ctx,
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 25976ed84f..f8ff7ff4a3 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -544,10 +544,11 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
         error_setg(errp, "%s: failed to initialize vcard", TYPE_EMULATED_CCID);
         goto out2;
     }
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
-                       card, QEMU_THREAD_JOINABLE);
+                       card, QEMU_THREAD_JOINABLE, &error_abort);
     qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
-                       card, QEMU_THREAD_JOINABLE);
+                       card, QEMU_THREAD_JOINABLE, &error_abort);
 
 out2:
     clean_event_notifier(card);
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 55d83a907c..12291f4ccd 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -152,9 +152,9 @@ void qemu_event_reset(QemuEvent *ev);
 void qemu_event_wait(QemuEvent *ev);
 void qemu_event_destroy(QemuEvent *ev);
 
-void qemu_thread_create(QemuThread *thread, const char *name,
+bool qemu_thread_create(QemuThread *thread, const char *name,
                         void *(*start_routine)(void *),
-                        void *arg, int mode);
+                        void *arg, int mode, Error **errp);
 void *qemu_thread_join(QemuThread *thread);
 void qemu_thread_get_self(QemuThread *thread);
 bool qemu_thread_is_self(QemuThread *thread);
diff --git a/io/task.c b/io/task.c
index 2886a2c1bc..6d3a18ab80 100644
--- a/io/task.c
+++ b/io/task.c
@@ -149,7 +149,8 @@ void qio_task_run_in_thread(QIOTask *task,
                        "io-task-worker",
                        qio_task_thread_worker,
                        data,
-                       QEMU_THREAD_DETACHED);
+                       QEMU_THREAD_DETACHED,
+                       &error_abort);
 }
 
 
diff --git a/iothread.c b/iothread.c
index 2fb1cdf55d..8e8aa01999 100644
--- a/iothread.c
+++ b/iothread.c
@@ -178,8 +178,9 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
      */
     name = object_get_canonical_path_component(OBJECT(obj));
     thread_name = g_strdup_printf("IO %s", name);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&iothread->thread, thread_name, iothread_run,
-                       iothread, QEMU_THREAD_JOINABLE);
+                       iothread, QEMU_THREAD_JOINABLE, &error_abort);
     g_free(thread_name);
     g_free(name);
 
diff --git a/migration/migration.c b/migration/migration.c
index ded151b1bf..ea5839ff0d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -447,8 +447,10 @@ static void process_incoming_migration_co(void *opaque)
             goto fail;
         }
 
+        /* TODO: let the further caller handle the error instead of abort() */
         qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
-             colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
+                           colo_process_incoming_thread, mis,
+                           QEMU_THREAD_JOINABLE, &error_abort);
         mis->have_colo_incoming_thread = true;
         qemu_coroutine_yield();
 
@@ -2358,8 +2360,10 @@ static int open_return_path_on_source(MigrationState *ms,
         return 0;
     }
 
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&ms->rp_state.rp_thread, "return path",
-                       source_return_path_thread, ms, QEMU_THREAD_JOINABLE);
+                       source_return_path_thread, ms,
+                       QEMU_THREAD_JOINABLE, &error_abort);
 
     trace_open_return_path_on_source_continue();
 
@@ -3189,8 +3193,9 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         migrate_fd_cleanup(s);
         return;
     }
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &error_abort);
     s->migration_thread_running = true;
 }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index fa09dba534..221ea24919 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1109,8 +1109,10 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
     }
 
     qemu_sem_init(&mis->fault_thread_sem, 0);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&mis->fault_thread, "postcopy/fault",
-                       postcopy_ram_fault_thread, mis, QEMU_THREAD_JOINABLE);
+                       postcopy_ram_fault_thread, mis,
+                       QEMU_THREAD_JOINABLE, &error_abort);
     qemu_sem_wait(&mis->fault_thread_sem);
     qemu_sem_destroy(&mis->fault_thread_sem);
     mis->have_fault_thread = true;
diff --git a/migration/ram.c b/migration/ram.c
index 435a8d2946..eed1daf302 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -502,9 +502,10 @@ static int compress_threads_save_setup(void)
         comp_param[i].quit = false;
         qemu_mutex_init(&comp_param[i].mutex);
         qemu_cond_init(&comp_param[i].cond);
+        /* TODO: let the further caller handle the error instead of abort() */
         qemu_thread_create(compress_threads + i, "compress",
                            do_data_compress, comp_param + i,
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &error_abort);
     }
     return 0;
 
@@ -1075,8 +1076,9 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
         p->c = QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
         p->running = true;
+        /* TODO: let the further caller handle the error instead of abort() */
         qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &error_abort);
 
         atomic_inc(&multifd_send_state->count);
     }
@@ -1355,8 +1357,9 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     p->num_packets = 1;
 
     p->running = true;
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &error_abort);
     atomic_inc(&multifd_recv_state->count);
     return atomic_read(&multifd_recv_state->count) ==
            migrate_multifd_channels();
@@ -3643,9 +3646,10 @@ static int compress_threads_load_setup(QEMUFile *f)
         qemu_cond_init(&decomp_param[i].cond);
         decomp_param[i].done = true;
         decomp_param[i].quit = false;
+        /* TODO: let the further caller handle the error instead of abort() */
         qemu_thread_create(decompress_threads + i, "decompress",
                            do_data_decompress, decomp_param + i,
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &error_abort);
     }
     return 0;
 exit:
diff --git a/migration/savevm.c b/migration/savevm.c
index d784e8aa40..46ce7af239 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1747,9 +1747,10 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     mis->have_listen_thread = true;
     /* Start up the listening thread and wait for it to signal ready */
     qemu_sem_init(&mis->listen_thread_sem, 0);
+    /* TODO: let the further caller handle the error instead of abort() here */
     qemu_thread_create(&mis->listen_thread, "postcopy/listen",
                        postcopy_ram_listen_thread, NULL,
-                       QEMU_THREAD_DETACHED);
+                       QEMU_THREAD_DETACHED, &error_abort);
     qemu_sem_wait(&mis->listen_thread_sem);
     qemu_sem_destroy(&mis->listen_thread_sem);
 
diff --git a/tests/atomic_add-bench.c b/tests/atomic_add-bench.c
index 2f6c72f63a..338b9563e3 100644
--- a/tests/atomic_add-bench.c
+++ b/tests/atomic_add-bench.c
@@ -2,6 +2,7 @@
 #include "qemu/thread.h"
 #include "qemu/host-utils.h"
 #include "qemu/processor.h"
+#include "qapi/error.h"
 
 struct thread_info {
     uint64_t r;
@@ -110,7 +111,7 @@ static void create_threads(void)
 
         info->r = (i + 1) ^ time(NULL);
         qemu_thread_create(&threads[i], NULL, thread_func, info,
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &error_abort);
     }
 }
 
diff --git a/tests/iothread.c b/tests/iothread.c
index 777d9eea46..f4ad992e61 100644
--- a/tests/iothread.c
+++ b/tests/iothread.c
@@ -73,7 +73,7 @@ IOThread *iothread_new(void)
     qemu_mutex_init(&iothread->init_done_lock);
     qemu_cond_init(&iothread->init_done_cond);
     qemu_thread_create(&iothread->thread, NULL, iothread_run,
-                       iothread, QEMU_THREAD_JOINABLE);
+                       iothread, QEMU_THREAD_JOINABLE, &error_abort);
 
     /* Wait for initialization to complete */
     qemu_mutex_lock(&iothread->init_done_lock);
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index ab4e708180..85e1af2f84 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -10,6 +10,7 @@
 #include "qemu/qht.h"
 #include "qemu/rcu.h"
 #include "qemu/xxhash.h"
+#include "qapi/error.h"
 
 struct thread_stats {
     size_t rd;
@@ -248,7 +249,7 @@ th_create_n(QemuThread **threads, struct thread_info **infos, const char *name,
         prepare_thread_info(&info[i], offset + i);
         info[i].func = func;
         qemu_thread_create(&th[i], name, thread_func, &info[i],
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &error_abort);
     }
 }
 
diff --git a/tests/rcutorture.c b/tests/rcutorture.c
index 49311c82ea..0e799ff256 100644
--- a/tests/rcutorture.c
+++ b/tests/rcutorture.c
@@ -64,6 +64,7 @@
 #include "qemu/atomic.h"
 #include "qemu/rcu.h"
 #include "qemu/thread.h"
+#include "qapi/error.h"
 
 long long n_reads = 0LL;
 long n_updates = 0L;
@@ -90,7 +91,7 @@ static void create_thread(void *(*func)(void *))
         exit(-1);
     }
     qemu_thread_create(&threads[n_threads], "test", func, &data[n_threads],
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &error_abort);
     n_threads++;
 }
 
diff --git a/tests/test-aio.c b/tests/test-aio.c
index 86fb73b3d5..b3ac261724 100644
--- a/tests/test-aio.c
+++ b/tests/test-aio.c
@@ -154,7 +154,7 @@ static void test_acquire(void)
 
     qemu_thread_create(&thread, "test_acquire_thread",
                        test_acquire_thread,
-                       &data, QEMU_THREAD_JOINABLE);
+                       &data, QEMU_THREAD_JOINABLE, &error_abort);
 
     /* Block in aio_poll(), let other thread kick us and acquire context */
     aio_context_acquire(ctx);
diff --git a/tests/test-rcu-list.c b/tests/test-rcu-list.c
index 2e6f70bd59..0f7da81291 100644
--- a/tests/test-rcu-list.c
+++ b/tests/test-rcu-list.c
@@ -25,6 +25,7 @@
 #include "qemu/rcu.h"
 #include "qemu/thread.h"
 #include "qemu/rcu_queue.h"
+#include "qapi/error.h"
 
 /*
  * Test variables.
@@ -68,7 +69,7 @@ static void create_thread(void *(*func)(void *))
         exit(-1);
     }
     qemu_thread_create(&threads[n_threads], "test", func, &data[n_threads],
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &error_abort);
     n_threads++;
 }
 
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 929391f85d..5712f1f501 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -31,6 +31,7 @@
 #include "vnc-jobs.h"
 #include "qemu/sockets.h"
 #include "qemu/main-loop.h"
+#include "qapi/error.h"
 #include "block/aio.h"
 
 /*
@@ -339,7 +340,8 @@ void vnc_start_worker_thread(void)
         return ;
 
     q = vnc_queue_init();
-    qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread, q,
-                       QEMU_THREAD_DETACHED);
+    /* TODO: let the further caller handle the error instead of abort() here */
+    qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread,
+                       q, QEMU_THREAD_DETACHED, &error_abort);
     queue = q; /* Set global queue */
 }
diff --git a/util/compatfd.c b/util/compatfd.c
index 980bd33e52..c3d8448264 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/thread.h"
+#include "qapi/error.h"
 
 #include <sys/syscall.h>
 
@@ -88,8 +89,9 @@ static int qemu_signalfd_compat(const sigset_t *mask)
     memcpy(&info->mask, mask, sizeof(*mask));
     info->fd = fds[1];
 
-    qemu_thread_create(&thread, "signalfd_compat", sigwait_compat, info,
-                       QEMU_THREAD_DETACHED);
+    /* TODO: let the further caller handle the error instead of abort() here */
+    qemu_thread_create(&thread, "signalfd_compat", sigwait_compat,
+                       info, QEMU_THREAD_DETACHED, &error_abort);
 
     return fds[0];
 }
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index c1bee2a581..251e2f1aea 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -448,9 +448,10 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
         memset_thread[i].numpages = (i == (memset_num_threads - 1)) ?
                                     numpages : numpages_per_thread;
         memset_thread[i].hpagesize = hpagesize;
+        /* TODO: let the callers handle the error instead of abort() here */
         qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
                            do_touch_pages, &memset_thread[i],
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &error_abort);
         addr += size_per_thread;
         numpages -= numpages_per_thread;
     }
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 865e476df5..39834b0551 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -15,6 +15,7 @@
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
 #include "qemu-thread-common.h"
+#include "qapi/error.h"
 
 static bool name_threads;
 
@@ -500,9 +501,13 @@ static void *qemu_thread_start(void *args)
     return r;
 }
 
-void qemu_thread_create(QemuThread *thread, const char *name,
-                       void *(*start_routine)(void*),
-                       void *arg, int mode)
+/*
+ * Return a boolean: true/false to indicate whether it succeeds.
+ * If fails, propagate the error to Error **errp and set the errno.
+ */
+bool qemu_thread_create(QemuThread *thread, const char *name,
+                        void *(*start_routine)(void *),
+                        void *arg, int mode, Error **errp)
 {
     sigset_t set, oldset;
     int err;
@@ -511,7 +516,9 @@ void qemu_thread_create(QemuThread *thread, const char *name,
 
     err = pthread_attr_init(&attr);
     if (err) {
-        error_exit(err, __func__);
+        errno = err;
+        error_setg_errno(errp, errno, "pthread_attr_init failed");
+        return false;
     }
 
     if (mode == QEMU_THREAD_DETACHED) {
@@ -529,13 +536,19 @@ void qemu_thread_create(QemuThread *thread, const char *name,
 
     err = pthread_create(&thread->thread, &attr,
                          qemu_thread_start, qemu_thread_args);
-
-    if (err)
-        error_exit(err, __func__);
+    if (err) {
+        errno = err;
+        error_setg_errno(errp, errno, "pthread_create failed");
+        pthread_attr_destroy(&attr);
+        g_free(qemu_thread_args->name);
+        g_free(qemu_thread_args);
+        return false;
+    }
 
     pthread_sigmask(SIG_SETMASK, &oldset, NULL);
 
     pthread_attr_destroy(&attr);
+    return true;
 }
 
 void qemu_thread_get_self(QemuThread *thread)
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 4a363ca675..57b1143e97 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -20,6 +20,7 @@
 #include "qemu/thread.h"
 #include "qemu/notify.h"
 #include "qemu-thread-common.h"
+#include "qapi/error.h"
 #include <process.h>
 
 static bool name_threads;
@@ -388,9 +389,9 @@ void *qemu_thread_join(QemuThread *thread)
     return ret;
 }
 
-void qemu_thread_create(QemuThread *thread, const char *name,
-                       void *(*start_routine)(void *),
-                       void *arg, int mode)
+bool qemu_thread_create(QemuThread *thread, const char *name,
+                        void *(*start_routine)(void *),
+                        void *arg, int mode, Error **errp)
 {
     HANDLE hThread;
     struct QemuThreadData *data;
@@ -409,10 +410,17 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     hThread = (HANDLE) _beginthreadex(NULL, 0, win32_start_routine,
                                       data, 0, &thread->tid);
     if (!hThread) {
-        error_exit(GetLastError(), __func__);
+        if (data->mode != QEMU_THREAD_DETACHED) {
+            DeleteCriticalSection(&data->cs);
+        }
+        error_setg_errno(errp, errno,
+                         "failed to create win32_start_routine");
+        g_free(data);
+        return false;
     }
     CloseHandle(hThread);
     thread->data = data;
+    return true;
 }
 
 void qemu_thread_get_self(QemuThread *thread)
diff --git a/util/rcu.c b/util/rcu.c
index 5676c22bd1..145dcdb0c6 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -32,6 +32,7 @@
 #include "qemu/atomic.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#include "qapi/error.h"
 #if defined(CONFIG_MALLOC_TRIM)
 #include <malloc.h>
 #endif
@@ -325,7 +326,7 @@ static void rcu_init_complete(void)
      * must have been quiescent even after forking, just recreate it.
      */
     qemu_thread_create(&thread, "call_rcu", call_rcu_thread,
-                       NULL, QEMU_THREAD_DETACHED);
+                       NULL, QEMU_THREAD_DETACHED, &error_abort);
 
     rcu_register_thread();
 }
diff --git a/util/thread-pool.c b/util/thread-pool.c
index 610646d131..ad0f980783 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -22,6 +22,7 @@
 #include "trace.h"
 #include "block/thread-pool.h"
 #include "qemu/main-loop.h"
+#include "qapi/error.h"
 
 static void do_spawn_thread(ThreadPool *pool);
 
@@ -132,7 +133,8 @@ static void do_spawn_thread(ThreadPool *pool)
     pool->new_threads--;
     pool->pending_threads++;
 
-    qemu_thread_create(&t, "worker", worker_thread, pool, QEMU_THREAD_DETACHED);
+    qemu_thread_create(&t, "worker", worker_thread, pool,
+                       QEMU_THREAD_DETACHED, &error_abort);
 }
 
 static void spawn_thread_bh_fn(void *opaque)
-- 
2.13.7
