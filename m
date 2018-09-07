Received: from eggs.gnu.org ([2001:4830:134:3::10]:44569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fyGzN-0006LS-TE
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fyGz8-0005k9-SR
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:39:50 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:45049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1fyGz8-0005hr-9p
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:39:42 -0400
From: Fei Li <fli@suse.com>
Date: Fri,  7 Sep 2018 21:39:02 +0800
Message-Id: <20180907133902.28462-5-fli@suse.com>
In-Reply-To: <20180907133902.28462-1-fli@suse.com>
References: <20180907133902.28462-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH v2 4/4] qemu_thread_create: propagate the error
 to callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, armbru@redhat.com, eblake@redhat.com, fli@suse.com

Make qemu_thread_create() return a Boolean to indicate if it succeeds
rather than failing with an error. And add an Error parameter to hold
the error message and let the callers handle it.

Besides, directly return if thread->data is NULL to avoid the
segmentation fault in qemu_thread_join in qemu-thread-win32.c.

Signed-off-by: Fei Li <fli@suse.com>
---
 cpus.c                      | 45 +++++++++++++++++++++++++++--------------
 dump.c                      |  6 ++++--
 hw/misc/edu.c               |  6 ++++--
 hw/ppc/spapr_hcall.c        |  9 +++++++--
 hw/rdma/rdma_backend.c      |  3 ++-
 hw/usb/ccid-card-emulated.c | 13 ++++++++----
 include/qemu/thread.h       |  4 ++--
 io/task.c                   |  3 ++-
 iothread.c                  | 16 ++++++++++-----
 migration/migration.c       | 49 +++++++++++++++++++++++++++++++--------------
 migration/postcopy-ram.c    | 12 +++++++++--
 migration/ram.c             | 40 +++++++++++++++++++++++++++---------
 migration/savevm.c          | 11 +++++++---
 tests/atomic_add-bench.c    |  3 ++-
 tests/iothread.c            |  2 +-
 tests/qht-bench.c           |  3 ++-
 tests/rcutorture.c          |  3 ++-
 tests/test-aio.c            |  2 +-
 tests/test-rcu-list.c       |  3 ++-
 ui/vnc-jobs.c               |  8 ++++++--
 util/compatfd.c             |  7 +++++--
 util/oslib-posix.c          | 12 ++++++++---
 util/qemu-thread-posix.c    | 18 +++++++++++------
 util/qemu-thread-win32.c    | 15 +++++++++-----
 util/rcu.c                  |  3 ++-
 util/thread-pool.c          |  4 +++-
 26 files changed, 210 insertions(+), 90 deletions(-)

diff --git a/cpus.c b/cpus.c
index 1feb308123..40db5c378f 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1928,15 +1928,20 @@ static void qemu_tcg_init_vcpu(CPUState *cpu, Error **errp)
             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
                  cpu->cpu_index);
 
-            qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE);
+            if (!qemu_thread_create(cpu->thread, thread_name,
+                                    qemu_tcg_cpu_thread_fn, cpu,
+                                    QEMU_THREAD_JOINABLE, errp)) {
+                return;
+            }
 
         } else {
             /* share a single thread for all cpus with TCG */
             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
-            qemu_thread_create(cpu->thread, thread_name,
-                               qemu_tcg_rr_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE);
+            if (!qemu_thread_create(cpu->thread, thread_name,
+                                    qemu_tcg_rr_cpu_thread_fn, cpu,
+                                    QEMU_THREAD_JOINABLE, errp)) {
+                return;
+            }
 
             single_tcg_halt_cond = cpu->halt_cond;
             single_tcg_cpu_thread = cpu->thread;
@@ -1964,8 +1969,10 @@ static void qemu_hax_start_vcpu(CPUState *cpu, Error **errp)
 
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HAX",
              cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_hax_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+    if (!qemu_thread_create(cpu->thread, thread_name, qemu_hax_cpu_thread_fn,
+                            cpu, QEMU_THREAD_JOINABLE, errp)) {
+        return;
+    }
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
@@ -1980,8 +1987,10 @@ static void qemu_kvm_start_vcpu(CPUState *cpu, Error **errp)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
              cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_kvm_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+    if (!qemu_thread_create(cpu->thread, thread_name, qemu_kvm_cpu_thread_fn,
+                            cpu, QEMU_THREAD_JOINABLE, errp)) {
+        return;
+    }
 }
 
 static void qemu_hvf_start_vcpu(CPUState *cpu, Error **errp)
@@ -1998,8 +2007,10 @@ static void qemu_hvf_start_vcpu(CPUState *cpu, Error **errp)
 
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
              cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+    if (!qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
+                            cpu, QEMU_THREAD_JOINABLE, errp)) {
+        return;
+    }
 }
 
 static void qemu_whpx_start_vcpu(CPUState *cpu, Error **errp)
@@ -2011,8 +2022,10 @@ static void qemu_whpx_start_vcpu(CPUState *cpu, Error **errp)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
              cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_whpx_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+    if (!qemu_thread_create(cpu->thread, thread_name, qemu_whpx_cpu_thread_fn,
+                            cpu, QEMU_THREAD_JOINABLE, errp)) {
+        return;
+    }
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
@@ -2027,8 +2040,10 @@ static void qemu_dummy_start_vcpu(CPUState *cpu, Error **errp)
     qemu_cond_init(cpu->halt_cond);
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
              cpu->cpu_index);
-    qemu_thread_create(cpu->thread, thread_name, qemu_dummy_cpu_thread_fn, cpu,
-                       QEMU_THREAD_JOINABLE);
+    if (!qemu_thread_create(cpu->thread, thread_name, qemu_dummy_cpu_thread_fn,
+                           cpu, QEMU_THREAD_JOINABLE, errp)) {
+        return;
+    }
 }
 
 bool qemu_init_vcpu(CPUState *cpu, Error **errp)
diff --git a/dump.c b/dump.c
index 500b554523..4175b95d12 100644
--- a/dump.c
+++ b/dump.c
@@ -2021,8 +2021,10 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     if (detach_p) {
         /* detached dump */
         s->detached = true;
-        qemu_thread_create(&s->dump_thread, "dump_thread", dump_thread,
-                           s, QEMU_THREAD_DETACHED);
+        if (!qemu_thread_create(&s->dump_thread, "dump_thread", dump_thread,
+                                s, QEMU_THREAD_DETACHED, errp)) {
+            return;
+        }
     } else {
         /* sync dump */
         dump_process(s, errp);
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index df26a4d046..2810192b1f 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -354,8 +354,10 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
 
     qemu_mutex_init(&edu->thr_mutex);
     qemu_cond_init(&edu->thr_cond);
-    qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
-                       edu, QEMU_THREAD_JOINABLE);
+    if (!qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
+                            edu, QEMU_THREAD_JOINABLE, errp)) {
+        return;
+    }
 
     memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
                     "edu-mmio", 1 * MiB);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index ae913d070f..86eb22ea55 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -478,6 +478,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     sPAPRPendingHPT *pending = spapr->pending_hpt;
     uint64_t current_ram_size;
     int rc;
+    Error *local_err = NULL;
 
     if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
         return H_AUTHORITY;
@@ -538,8 +539,12 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     pending->shift = shift;
     pending->ret = H_HARDWARE;
 
-    qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
-                       hpt_prepare_thread, pending, QEMU_THREAD_DETACHED);
+    if (!qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
+                            hpt_prepare_thread, pending,
+                            QEMU_THREAD_DETACHED, &local_err)) {
+        error_reportf_err(local_err, "Failed to create hpt_prepare_thread.");
+        return H_RESOURCE;
+    }
 
     spapr->pending_hpt = pending;
 
diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index d7a4bbd91f..e7cbb0c368 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -165,7 +165,8 @@ static void start_comp_thread(RdmaBackendDev *backend_dev)
              ibv_get_device_name(backend_dev->ib_dev));
     backend_dev->comp_thread.run = true;
     qemu_thread_create(&backend_dev->comp_thread.thread, thread_name,
-                       comp_handler_thread, backend_dev, QEMU_THREAD_DETACHED);
+                       comp_handler_thread, backend_dev,
+                       QEMU_THREAD_DETACHED, &error_abort);
 }
 
 void rdma_backend_register_comp_handler(void (*handler)(int status,
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 5c8b3c9907..0d630c27db 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -538,10 +538,15 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
         error_setg(errp, "%s: failed to initialize vcard", TYPE_EMULATED_CCID);
         return;
     }
-    qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
-                       card, QEMU_THREAD_JOINABLE);
-    qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
-                       card, QEMU_THREAD_JOINABLE);
+    if (!qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
+                            card, QEMU_THREAD_JOINABLE, errp)) {
+        return;
+    }
+    if (!qemu_thread_create(&card->apdu_thread_id, "ccid/apdu",
+                            handle_apdu_thread, card,
+                            QEMU_THREAD_JOINABLE, errp)) {
+        return;
+    }
 }
 
 static void emulated_unrealize(CCIDCardState *base, Error **errp)
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index dacebcfff0..1fb84a07d2 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -135,9 +135,9 @@ void qemu_event_reset(QemuEvent *ev);
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
index aff1281257..5b2a1df36d 100644
--- a/iothread.c
+++ b/iothread.c
@@ -161,9 +161,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
                                 &local_error);
     if (local_error) {
         error_propagate(errp, local_error);
-        aio_context_unref(iothread->ctx);
-        iothread->ctx = NULL;
-        return;
+        goto fail;
     }
 
     qemu_mutex_init(&iothread->init_done_lock);
@@ -175,8 +173,12 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
      */
     name = object_get_canonical_path_component(OBJECT(obj));
     thread_name = g_strdup_printf("IO %s", name);
-    qemu_thread_create(&iothread->thread, thread_name, iothread_run,
-                       iothread, QEMU_THREAD_JOINABLE);
+    if (!qemu_thread_create(&iothread->thread, thread_name, iothread_run,
+                            iothread, QEMU_THREAD_JOINABLE, errp)) {
+        g_free(thread_name);
+        g_free(name);
+        goto fail;
+    }
     g_free(thread_name);
     g_free(name);
 
@@ -187,6 +189,10 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
                        &iothread->init_done_lock);
     }
     qemu_mutex_unlock(&iothread->init_done_lock);
+    return;
+fail:
+    aio_context_unref(iothread->ctx);
+    iothread->ctx = NULL;
 }
 
 typedef struct {
diff --git a/migration/migration.c b/migration/migration.c
index 4b316ec343..52e476a8f3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -388,6 +388,7 @@ static void process_incoming_migration_co(void *opaque)
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps;
     int ret;
+    Error *local_err = NULL;
 
     assert(mis->from_src_file);
     mis->migration_incoming_co = qemu_coroutine_self();
@@ -420,8 +421,13 @@ static void process_incoming_migration_co(void *opaque)
 
     /* we get COLO info, and know if we are in COLO mode */
     if (!ret && migration_incoming_enable_colo()) {
-        qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
-             colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
+        if (!qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
+                                colo_process_incoming_thread, mis,
+                                QEMU_THREAD_JOINABLE, &local_err)) {
+            error_reportf_err(local_err, "Failed to create "
+                              "colo_process_incoming_thread.");
+            goto fail;
+        }
         mis->have_colo_incoming_thread = true;
         qemu_coroutine_yield();
 
@@ -430,20 +436,22 @@ static void process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
-        Error *local_err = NULL;
-
-        migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
         error_report("load of migration failed: %s", strerror(-ret));
-        qemu_fclose(mis->from_src_file);
-        if (multifd_load_cleanup(&local_err) != 0) {
-            error_report_err(local_err);
-        }
-        exit(EXIT_FAILURE);
+        goto fail;
     }
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
     qemu_bh_schedule(mis->bh);
     mis->migration_incoming_co = NULL;
+    return;
+fail:
+    local_err = NULL;
+    migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
+                      MIGRATION_STATUS_FAILED);
+    qemu_fclose(mis->from_src_file);
+    if (multifd_load_cleanup(&local_err) != 0) {
+        error_report_err(local_err);
+    }
+    exit(EXIT_FAILURE);
 }
 
 static void migration_incoming_setup(QEMUFile *f)
@@ -2288,6 +2296,7 @@ out:
 static int open_return_path_on_source(MigrationState *ms,
                                       bool create_thread)
 {
+    Error *local_err = NULL;
 
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
     if (!ms->rp_state.from_dst_file) {
@@ -2301,8 +2310,13 @@ static int open_return_path_on_source(MigrationState *ms,
         return 0;
     }
 
-    qemu_thread_create(&ms->rp_state.rp_thread, "return path",
-                       source_return_path_thread, ms, QEMU_THREAD_JOINABLE);
+    if (!qemu_thread_create(&ms->rp_state.rp_thread, "return path",
+                            source_return_path_thread, ms,
+                            QEMU_THREAD_JOINABLE, &local_err)) {
+        error_reportf_err(local_err,
+                          "Failed to create source_return_path_thread.");
+        return -1;
+    }
 
     trace_open_return_path_on_source_continue();
 
@@ -3127,8 +3141,13 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         migrate_fd_cleanup(s);
         return;
     }
-    qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
-                       QEMU_THREAD_JOINABLE);
+    if (!qemu_thread_create(&s->thread, "live_migration", migration_thread,
+                            s, QEMU_THREAD_JOINABLE, &error_in)) {
+        error_reportf_err(error_in, "Failed to create migration_thread.");
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        migrate_fd_cleanup(s);
+        return;
+    }
     s->migration_thread_running = true;
 }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 853d8b32ca..ebc6213c5e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1082,6 +1082,8 @@ retry:
 
 int postcopy_ram_enable_notify(MigrationIncomingState *mis)
 {
+    Error *local_err = NULL;
+
     /* Open the fd for the kernel to give us userfaults */
     mis->userfault_fd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
     if (mis->userfault_fd == -1) {
@@ -1108,8 +1110,14 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
     }
 
     qemu_sem_init(&mis->fault_thread_sem, 0);
-    qemu_thread_create(&mis->fault_thread, "postcopy/fault",
-                       postcopy_ram_fault_thread, mis, QEMU_THREAD_JOINABLE);
+    if (!qemu_thread_create(&mis->fault_thread, "postcopy/fault",
+                            postcopy_ram_fault_thread, mis,
+                            QEMU_THREAD_JOINABLE, &local_err)) {
+        error_reportf_err(local_err,
+                          "Failed to create postcopy_ram_fault_thread.");
+        qemu_sem_destroy(&mis->fault_thread_sem);
+        return -1;
+    }
     qemu_sem_wait(&mis->fault_thread_sem);
     qemu_sem_destroy(&mis->fault_thread_sem);
     mis->have_fault_thread = true;
diff --git a/migration/ram.c b/migration/ram.c
index 79c89425a3..7bf7901d9c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -470,6 +470,7 @@ static void compress_threads_save_cleanup(void)
 static int compress_threads_save_setup(void)
 {
     int i, thread_count;
+    Error *local_err = NULL;
 
     if (!migrate_use_compression()) {
         return 0;
@@ -499,9 +500,12 @@ static int compress_threads_save_setup(void)
         comp_param[i].quit = false;
         qemu_mutex_init(&comp_param[i].mutex);
         qemu_cond_init(&comp_param[i].cond);
-        qemu_thread_create(compress_threads + i, "compress",
-                           do_data_compress, comp_param + i,
-                           QEMU_THREAD_JOINABLE);
+        if (!qemu_thread_create(compress_threads + i, "compress",
+                                do_data_compress, comp_param + i,
+                                QEMU_THREAD_JOINABLE, &local_err)) {
+            error_reportf_err(local_err, "Failed to create do_data_compress.");
+            goto exit;
+        }
     }
     return 0;
 
@@ -1075,8 +1079,15 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
         p->c = QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
         p->running = true;
-        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                           QEMU_THREAD_JOINABLE);
+        if (!qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
+                                QEMU_THREAD_JOINABLE, &local_err)) {
+            error_reportf_err(local_err,
+                              "Failed to create multifd_send_thread.");
+            if (multifd_save_cleanup(&local_err) != 0) {
+                migrate_set_error(migrate_get_current(), local_err);
+            }
+            return;
+        }
 
         atomic_inc(&multifd_send_state->count);
     }
@@ -1345,8 +1356,12 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
     p->num_packets = 1;
 
     p->running = true;
-    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
-                       QEMU_THREAD_JOINABLE);
+    if (!qemu_thread_create(&p->thread, p->name, multifd_recv_thread,
+                            p, QEMU_THREAD_JOINABLE, &local_err)) {
+        error_reportf_err(local_err, "Failed to create multifd_recv_thread.");
+        multifd_recv_terminate_threads(local_err);
+        return false;
+    }
     atomic_inc(&multifd_recv_state->count);
     return multifd_recv_state->count == migrate_multifd_channels();
 }
@@ -3542,6 +3557,7 @@ static void compress_threads_load_cleanup(void)
 static int compress_threads_load_setup(QEMUFile *f)
 {
     int i, thread_count;
+    Error *local_err = NULL;
 
     if (!migrate_use_compression()) {
         return 0;
@@ -3563,9 +3579,13 @@ static int compress_threads_load_setup(QEMUFile *f)
         qemu_cond_init(&decomp_param[i].cond);
         decomp_param[i].done = true;
         decomp_param[i].quit = false;
-        qemu_thread_create(decompress_threads + i, "decompress",
-                           do_data_decompress, decomp_param + i,
-                           QEMU_THREAD_JOINABLE);
+        if (!qemu_thread_create(decompress_threads + i, "decompress",
+                                do_data_decompress, decomp_param + i,
+                                QEMU_THREAD_JOINABLE, &local_err)) {
+            error_reportf_err(local_err,
+                              "Failed to create do_data_decompress.");
+            goto exit;
+        }
     }
     return 0;
 exit:
diff --git a/migration/savevm.c b/migration/savevm.c
index 13e51f0e34..f35a1c5f01 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1727,9 +1727,14 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     mis->have_listen_thread = true;
     /* Start up the listening thread and wait for it to signal ready */
     qemu_sem_init(&mis->listen_thread_sem, 0);
-    qemu_thread_create(&mis->listen_thread, "postcopy/listen",
-                       postcopy_ram_listen_thread, NULL,
-                       QEMU_THREAD_DETACHED);
+    if (!qemu_thread_create(&mis->listen_thread, "postcopy/listen",
+                            postcopy_ram_listen_thread, NULL,
+                            QEMU_THREAD_DETACHED, &local_err)) {
+        error_reportf_err(local_err,
+                          "Failed to create postcopy_ram_listen_thread.");
+        qemu_sem_destroy(&mis->listen_thread_sem);
+        return -1;
+    }
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
index f492b3a20a..20a4101a17 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -9,6 +9,7 @@
 #include "qemu/atomic.h"
 #include "qemu/qht.h"
 #include "qemu/rcu.h"
+#include "qapi/error.h"
 #include "exec/tb-hash-xx.h"
 
 struct thread_stats {
@@ -239,7 +240,7 @@ th_create_n(QemuThread **threads, struct thread_info **infos, const char *name,
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
index 192bfbf02e..9ea35a3dad 100644
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
index 8807d7217c..35a652d1fd 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -31,6 +31,7 @@
 #include "vnc-jobs.h"
 #include "qemu/sockets.h"
 #include "qemu/main-loop.h"
+#include "qapi/error.h"
 #include "block/aio.h"
 
 /*
@@ -340,8 +341,11 @@ bool vnc_start_worker_thread(Error **errp)
     }
 
     q = vnc_queue_init();
-    qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread, q,
-                       QEMU_THREAD_DETACHED);
+    if (!qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread,
+                            q, QEMU_THREAD_DETACHED, errp)) {
+        vnc_queue_clear(q);
+        return false;
+    }
     queue = q; /* Set global queue */
 out:
     return true;
diff --git a/util/compatfd.c b/util/compatfd.c
index d3ed890405..2532fa4d4d 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -91,8 +91,11 @@ static int qemu_signalfd_compat(const sigset_t *mask, Error **errp)
     memcpy(&info->mask, mask, sizeof(*mask));
     info->fd = fds[1];
 
-    qemu_thread_create(&thread, "signalfd_compat", sigwait_compat, info,
-                       QEMU_THREAD_DETACHED);
+    if (!qemu_thread_create(&thread, "signalfd_compat", sigwait_compat,
+                            info, QEMU_THREAD_DETACHED, errp)) {
+        free(info);
+        return -1;
+    }
 
     return fds[0];
 }
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 13b6f8d776..f34ba7ac9a 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -364,6 +364,7 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
     size_t size_per_thread;
     char *addr = area;
     int i = 0;
+    Error *local_err = NULL;
 
     memset_thread_failed = false;
     memset_num_threads = get_memset_num_threads(smp_cpus);
@@ -375,15 +376,20 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
         memset_thread[i].numpages = (i == (memset_num_threads - 1)) ?
                                     numpages : numpages_per_thread;
         memset_thread[i].hpagesize = hpagesize;
-        qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
-                           do_touch_pages, &memset_thread[i],
-                           QEMU_THREAD_JOINABLE);
+        if (!qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
+                                do_touch_pages, &memset_thread[i],
+                                QEMU_THREAD_JOINABLE, &local_err)) {
+            error_reportf_err(local_err, "Failed to create do_touch_pages.");
+            memset_thread_failed = true;
+            goto out;
+        }
         addr += size_per_thread;
         numpages -= numpages_per_thread;
     }
     for (i = 0; i < memset_num_threads; i++) {
         qemu_thread_join(&memset_thread[i].pgthread);
     }
+out:
     g_free(memset_thread);
     memset_thread = NULL;
 
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index dfa66ff2fb..8e493bd653 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -15,6 +15,7 @@
 #include "qemu/atomic.h"
 #include "qemu/notify.h"
 #include "qemu-thread-common.h"
+#include "qapi/error.h"
 
 static bool name_threads;
 
@@ -504,9 +505,9 @@ static void *qemu_thread_start(void *args)
     return start_routine(arg);
 }
 
-void qemu_thread_create(QemuThread *thread, const char *name,
-                       void *(*start_routine)(void*),
-                       void *arg, int mode)
+bool qemu_thread_create(QemuThread *thread, const char *name,
+                        void *(*start_routine)(void *),
+                        void *arg, int mode, Error **errp)
 {
     sigset_t set, oldset;
     int err;
@@ -515,7 +516,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
 
     err = pthread_attr_init(&attr);
     if (err) {
-        error_exit(err, __func__);
+        goto fail;
     }
 
     if (mode == QEMU_THREAD_DETACHED) {
@@ -534,12 +535,17 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     err = pthread_create(&thread->thread, &attr,
                          qemu_thread_start, qemu_thread_args);
 
-    if (err)
-        error_exit(err, __func__);
+    if (err) {
+        goto fail;
+    }
 
     pthread_sigmask(SIG_SETMASK, &oldset, NULL);
 
     pthread_attr_destroy(&attr);
+    return true;
+fail:
+    error_setg(errp, "qemu_thread_create failed: %s", strerror(err));
+    return false;
 }
 
 void qemu_thread_get_self(QemuThread *thread)
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 4a363ca675..178a69ed40 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -20,6 +20,7 @@
 #include "qemu/thread.h"
 #include "qemu/notify.h"
 #include "qemu-thread-common.h"
+#include "qapi/error.h"
 #include <process.h>
 
 static bool name_threads;
@@ -366,7 +367,7 @@ void *qemu_thread_join(QemuThread *thread)
     HANDLE handle;
 
     data = thread->data;
-    if (data->mode == QEMU_THREAD_DETACHED) {
+    if (data == NULL || data->mode == QEMU_THREAD_DETACHED) {
         return NULL;
     }
 
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
@@ -409,10 +410,14 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     hThread = (HANDLE) _beginthreadex(NULL, 0, win32_start_routine,
                                       data, 0, &thread->tid);
     if (!hThread) {
-        error_exit(GetLastError(), __func__);
+        g_free(data);
+        error_setg_win32(errp, GetLastError(),
+                         "failed to creat win32_start_routine");
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
