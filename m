Received: from eggs.gnu.org ([2001:4830:134:3::10]:50350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fx9DO-0001kX-Ru
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fx9DM-0006WH-Db
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:46 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:42336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1fx9DL-0006Ug-W1
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:09:44 -0400
From: Fei Li <fli@suse.com>
Date: Tue,  4 Sep 2018 19:08:22 +0800
Message-Id: <20180904110822.12863-6-fli@suse.com>
In-Reply-To: <20180904110822.12863-1-fli@suse.com>
References: <20180904110822.12863-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH 5/5] Propagate qemu_thread_create's error to
 all callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fli@suse.com

Let's propagate qemu_thread_create's error to make all callers check
it. For those critical callers, just pass the &error_abort.

Signed-off-by: Fei Li <fli@suse.com>
---
 cpus.c                      | 48 ++++++++++++++++++++++++++++++++++++++-------
 dump.c                      |  6 +++++-
 hw/misc/edu.c               |  8 +++++++-
 hw/ppc/spapr_hcall.c        |  9 ++++++++-
 hw/rdma/rdma_backend.c      |  3 ++-
 hw/usb/ccid-card-emulated.c | 13 ++++++++++--
 io/task.c                   |  3 ++-
 iothread.c                  | 15 +++++++++-----
 migration/migration.c       | 47 ++++++++++++++++++++++++++++++++------------
 migration/postcopy-ram.c    | 11 ++++++++++-
 migration/ram.c             | 32 ++++++++++++++++++++++++++----
 migration/savevm.c          |  8 +++++++-
 tests/atomic_add-bench.c    |  3 ++-
 tests/iothread.c            |  2 +-
 tests/qht-bench.c           |  3 ++-
 tests/rcutorture.c          |  3 ++-
 tests/test-aio.c            |  2 +-
 tests/test-rcu-list.c       |  3 ++-
 ui/vnc-jobs.c               | 11 +++++++++--
 util/compatfd.c             |  8 +++++++-
 util/oslib-posix.c          | 10 +++++++++-
 util/rcu.c                  |  3 ++-
 util/thread-pool.c          |  4 +++-
 23 files changed, 206 insertions(+), 49 deletions(-)

diff --git a/cpus.c b/cpus.c
index 41efddc218..24159af1e6 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1904,6 +1904,7 @@ static void qemu_tcg_init_vcpu(CPUState *cpu, Error **errp)
     static QemuCond *single_tcg_halt_cond;
     static QemuThread *single_tcg_cpu_thread;
     static int tcg_region_inited;
+    Error *local_err = NULL;
 
     assert(tcg_enabled());
     /*
@@ -1929,14 +1930,22 @@ static void qemu_tcg_init_vcpu(CPUState *cpu, Error **errp)
                  cpu->cpu_index);
 
             qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE);
+                               cpu, QEMU_THREAD_JOINABLE, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
 
         } else {
             /* share a single thread for all cpus with TCG */
             snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
             qemu_thread_create(cpu->thread, thread_name,
                                qemu_tcg_rr_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE);
+                               cpu, QEMU_THREAD_JOINABLE, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
 
             single_tcg_halt_cond = cpu->halt_cond;
             single_tcg_cpu_thread = cpu->thread;
@@ -1957,6 +1966,7 @@ static void qemu_tcg_init_vcpu(CPUState *cpu, Error **errp)
 static void qemu_hax_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
+    Error *local_err = NULL;
 
     cpu->thread = g_malloc0(sizeof(QemuThread));
     cpu->halt_cond = g_malloc0(sizeof(QemuCond));
@@ -1965,7 +1975,11 @@ static void qemu_hax_start_vcpu(CPUState *cpu, Error **errp)
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HAX",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, qemu_hax_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+                       cpu, QEMU_THREAD_JOINABLE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
@@ -1974,6 +1988,7 @@ static void qemu_hax_start_vcpu(CPUState *cpu, Error **errp)
 static void qemu_kvm_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
+    Error *local_err = NULL;
 
     cpu->thread = g_malloc0(sizeof(QemuThread));
     cpu->halt_cond = g_malloc0(sizeof(QemuCond));
@@ -1981,12 +1996,17 @@ static void qemu_kvm_start_vcpu(CPUState *cpu, Error **errp)
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/KVM",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, qemu_kvm_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+                       cpu, QEMU_THREAD_JOINABLE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
 
 static void qemu_hvf_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
+    Error *local_err = NULL;
 
     /* HVF currently does not support TCG, and only runs in
      * unrestricted-guest mode. */
@@ -1999,12 +2019,17 @@ static void qemu_hvf_start_vcpu(CPUState *cpu, Error **errp)
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/HVF",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, qemu_hvf_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+                       cpu, QEMU_THREAD_JOINABLE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
 
 static void qemu_whpx_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
+    Error *local_err = NULL;
 
     cpu->thread = g_malloc0(sizeof(QemuThread));
     cpu->halt_cond = g_malloc0(sizeof(QemuCond));
@@ -2012,7 +2037,11 @@ static void qemu_whpx_start_vcpu(CPUState *cpu, Error **errp)
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/WHPX",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, qemu_whpx_cpu_thread_fn,
-                       cpu, QEMU_THREAD_JOINABLE);
+                       cpu, QEMU_THREAD_JOINABLE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
@@ -2021,6 +2050,7 @@ static void qemu_whpx_start_vcpu(CPUState *cpu, Error **errp)
 static void qemu_dummy_start_vcpu(CPUState *cpu, Error **errp)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
+    Error *local_err = NULL;
 
     cpu->thread = g_malloc0(sizeof(QemuThread));
     cpu->halt_cond = g_malloc0(sizeof(QemuCond));
@@ -2028,7 +2058,11 @@ static void qemu_dummy_start_vcpu(CPUState *cpu, Error **errp)
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, qemu_dummy_cpu_thread_fn, cpu,
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
 
 void qemu_init_vcpu(CPUState *cpu, Error **errp)
diff --git a/dump.c b/dump.c
index 500b554523..82d343f0e7 100644
--- a/dump.c
+++ b/dump.c
@@ -2022,7 +2022,11 @@ void qmp_dump_guest_memory(bool paging, const char *file,
         /* detached dump */
         s->detached = true;
         qemu_thread_create(&s->dump_thread, "dump_thread", dump_thread,
-                           s, QEMU_THREAD_DETACHED);
+                           s, QEMU_THREAD_DETACHED, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
     } else {
         /* sync dump */
         dump_process(s, errp);
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index df26a4d046..d884ee99ce 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -29,6 +29,7 @@
 #include "qemu/timer.h"
 #include "qemu/main-loop.h" /* iothread mutex */
 #include "qapi/visitor.h"
+#include "qapi/error.h"
 
 #define EDU(obj)        OBJECT_CHECK(EduState, obj, "edu")
 
@@ -343,6 +344,7 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
 {
     EduState *edu = DO_UPCAST(EduState, pdev, pdev);
     uint8_t *pci_conf = pdev->config;
+    Error *local_err = NULL;
 
     pci_config_set_interrupt_pin(pci_conf, 1);
 
@@ -355,7 +357,11 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
     qemu_mutex_init(&edu->thr_mutex);
     qemu_cond_init(&edu->thr_cond);
     qemu_thread_create(&edu->thread, "edu", edu_fact_thread,
-                       edu, QEMU_THREAD_JOINABLE);
+                       edu, QEMU_THREAD_JOINABLE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
                     "edu-mmio", 1 * MiB);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index ae913d070f..07d857410f 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -478,6 +478,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     sPAPRPendingHPT *pending = spapr->pending_hpt;
     uint64_t current_ram_size;
     int rc;
+    Error *local_err = NULL;
 
     if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DISABLED) {
         return H_AUTHORITY;
@@ -539,7 +540,13 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
     pending->ret = H_HARDWARE;
 
     qemu_thread_create(&pending->thread, "sPAPR HPT prepare",
-                       hpt_prepare_thread, pending, QEMU_THREAD_DETACHED);
+                       hpt_prepare_thread, pending,
+                       QEMU_THREAD_DETACHED, &local_err);
+    if (local_err) {
+        error_reportf_err(error_in, "Failed in %s() when calls "
+                          "qemu_thread_create(): \n", __func__);
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
index 5c8b3c9907..8f73f73ca4 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -483,6 +483,7 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
     EmulatedState *card = EMULATED_CCID_CARD(base);
     VCardEmulError ret;
     const EnumTable *ptable;
+    Error *local_err = NULL;
 
     QSIMPLEQ_INIT(&card->event_list);
     QSIMPLEQ_INIT(&card->guest_apdu_list);
@@ -539,9 +540,17 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
         return;
     }
     qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
-                       card, QEMU_THREAD_JOINABLE);
+                       card, QEMU_THREAD_JOINABLE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
-                       card, QEMU_THREAD_JOINABLE);
+                       card, QEMU_THREAD_JOINABLE, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
 
 static void emulated_unrealize(CCIDCardState *base, Error **errp)
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
index aff1281257..b19e548e5b 100644
--- a/iothread.c
+++ b/iothread.c
@@ -160,10 +160,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
                                 iothread->poll_shrink,
                                 &local_error);
     if (local_error) {
-        error_propagate(errp, local_error);
-        aio_context_unref(iothread->ctx);
-        iothread->ctx = NULL;
-        return;
+        goto fail;
     }
 
     qemu_mutex_init(&iothread->init_done_lock);
@@ -176,9 +173,12 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
     name = object_get_canonical_path_component(OBJECT(obj));
     thread_name = g_strdup_printf("IO %s", name);
     qemu_thread_create(&iothread->thread, thread_name, iothread_run,
-                       iothread, QEMU_THREAD_JOINABLE);
+                       iothread, QEMU_THREAD_JOINABLE, &local_error);
     g_free(thread_name);
     g_free(name);
+    if (local_error) {
+        goto fail;
+    }
 
     /* Wait for initialization to complete */
     qemu_mutex_lock(&iothread->init_done_lock);
@@ -187,6 +187,11 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
                        &iothread->init_done_lock);
     }
     qemu_mutex_unlock(&iothread->init_done_lock);
+    return;
+fail:
+    error_propagate(errp, local_error);
+    aio_context_unref(iothread->ctx);
+    iothread->ctx = NULL;
 }
 
 typedef struct {
diff --git a/migration/migration.c b/migration/migration.c
index 4b316ec343..34af7b82b9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -388,6 +388,7 @@ static void process_incoming_migration_co(void *opaque)
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyState ps;
     int ret;
+    Error *local_err = NULL;
 
     assert(mis->from_src_file);
     mis->migration_incoming_co = qemu_coroutine_self();
@@ -421,7 +422,13 @@ static void process_incoming_migration_co(void *opaque)
     /* we get COLO info, and know if we are in COLO mode */
     if (!ret && migration_incoming_enable_colo()) {
         qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
-             colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
+                           colo_process_incoming_thread, mis,
+                           QEMU_THREAD_JOINABLE, &local_err);
+        if (local_err) {
+            error_reportf_err(local_err, "Failed in %s() when calls "
+                              "qemu_thread_create(): \n", __func__);
+            goto fail;
+        }
         mis->have_colo_incoming_thread = true;
         qemu_coroutine_yield();
 
@@ -430,20 +437,22 @@ static void process_incoming_migration_co(void *opaque)
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
@@ -2288,6 +2297,7 @@ out:
 static int open_return_path_on_source(MigrationState *ms,
                                       bool create_thread)
 {
+    Error *local_err = NULL;
 
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
     if (!ms->rp_state.from_dst_file) {
@@ -2302,7 +2312,13 @@ static int open_return_path_on_source(MigrationState *ms,
     }
 
     qemu_thread_create(&ms->rp_state.rp_thread, "return path",
-                       source_return_path_thread, ms, QEMU_THREAD_JOINABLE);
+                       source_return_path_thread, ms,
+                       QEMU_THREAD_JOINABLE, &local_err);
+    if (local_err) {
+        error_reportf_err(local_err, "Failed in %s() when calls "
+                          "qemu_thread_create(): \n", __func__);
+        return -1;
+    }
 
     trace_open_return_path_on_source_continue();
 
@@ -3128,7 +3144,14 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         return;
     }
     qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &error_in);
+    if (error_in) {
+        error_reportf_err(error_in, "Failed in %s() when calls "
+                          "qemu_thread_create(): \n", __func__);
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        migrate_fd_cleanup(s);
+        return;
+    }
     s->migration_thread_running = true;
 }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 853d8b32ca..85d9114bd1 100644
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
@@ -1109,7 +1111,14 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
 
     qemu_sem_init(&mis->fault_thread_sem, 0);
     qemu_thread_create(&mis->fault_thread, "postcopy/fault",
-                       postcopy_ram_fault_thread, mis, QEMU_THREAD_JOINABLE);
+                       postcopy_ram_fault_thread, mis,
+                       QEMU_THREAD_JOINABLE, &local_err);
+    if (local_err) {
+        error_reportf_err(local_err, "Failed in %s() when calls "
+                          "qemu_thread_create(): \n", __func__);
+        qemu_sem_destroy(&mis->fault_thread_sem);
+        return -1;
+    }
     qemu_sem_wait(&mis->fault_thread_sem);
     qemu_sem_destroy(&mis->fault_thread_sem);
     mis->have_fault_thread = true;
diff --git a/migration/ram.c b/migration/ram.c
index 79c89425a3..ebbd21f8c2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -470,6 +470,7 @@ static void compress_threads_save_cleanup(void)
 static int compress_threads_save_setup(void)
 {
     int i, thread_count;
+    Error *local_err = NULL;
 
     if (!migrate_use_compression()) {
         return 0;
@@ -501,7 +502,12 @@ static int compress_threads_save_setup(void)
         qemu_cond_init(&comp_param[i].cond);
         qemu_thread_create(compress_threads + i, "compress",
                            do_data_compress, comp_param + i,
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &local_err);
+        if (local_err) {
+            error_reportf_err(local_err, "Failed in %s() when calls "
+                              "qemu_thread_create(): \n", __func__);
+            goto exit;
+        }
     }
     return 0;
 
@@ -1076,7 +1082,13 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
         qio_channel_set_delay(p->c, false);
         p->running = true;
         qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &local_err);
+        if (local_err) {
+            error_reportf_err(local_err, "Failed in %s() when calls "
+                              "qemu_thread_create(): \n", __func__);
+            migrate_set_error(migrate_get_current(), local_err);
+            return;
+        }
 
         atomic_inc(&multifd_send_state->count);
     }
@@ -1346,7 +1358,13 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
 
     p->running = true;
     qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
-                       QEMU_THREAD_JOINABLE);
+                       QEMU_THREAD_JOINABLE, &local_err);
+    if (local_err) {
+        error_reportf_err(local_err, "Failed in %s() when calls "
+                          "qemu_thread_create(): \n", __func__);
+        multifd_recv_terminate_threads(local_err);
+        return false;
+    }
     atomic_inc(&multifd_recv_state->count);
     return multifd_recv_state->count == migrate_multifd_channels();
 }
@@ -3542,6 +3560,7 @@ static void compress_threads_load_cleanup(void)
 static int compress_threads_load_setup(QEMUFile *f)
 {
     int i, thread_count;
+    Error *local_err = NULL;
 
     if (!migrate_use_compression()) {
         return 0;
@@ -3565,7 +3584,12 @@ static int compress_threads_load_setup(QEMUFile *f)
         decomp_param[i].quit = false;
         qemu_thread_create(decompress_threads + i, "decompress",
                            do_data_decompress, decomp_param + i,
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &local_err);
+        if (local_err) {
+            error_reportf_err(local_err, "Failed in %s() when calls "
+                              "qemu_thread_create(): \n", __func__);
+            goto exit;
+        }
     }
     return 0;
 exit:
diff --git a/migration/savevm.c b/migration/savevm.c
index 13e51f0e34..31973312cf 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1729,7 +1729,13 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     qemu_sem_init(&mis->listen_thread_sem, 0);
     qemu_thread_create(&mis->listen_thread, "postcopy/listen",
                        postcopy_ram_listen_thread, NULL,
-                       QEMU_THREAD_DETACHED);
+                       QEMU_THREAD_DETACHED, &local_err);
+    if (local_err) {
+        error_reportf_err(local_err, "Failed in %s() when calls "
+                          "qemu_thread_create(): \n", __func__);
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
index 7c05a1e6df..60d5ceb6a8 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -31,6 +31,7 @@
 #include "vnc-jobs.h"
 #include "qemu/sockets.h"
 #include "qemu/main-loop.h"
+#include "qapi/error.h"
 #include "block/aio.h"
 
 /*
@@ -333,13 +334,19 @@ static bool vnc_worker_thread_running(void)
 
 void vnc_start_worker_thread(Error **errp)
 {
+    Error *local_err = NULL;
+
     VncJobQueue *q;
 
     if (vnc_worker_thread_running())
-        return ;
+        return;
 
     q = vnc_queue_init();
     qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread, q,
-                       QEMU_THREAD_DETACHED);
+                       QEMU_THREAD_DETACHED, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
     queue = q; /* Set global queue */
 }
diff --git a/util/compatfd.c b/util/compatfd.c
index 65501de622..b3d3c82266 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -71,6 +71,7 @@ static int qemu_signalfd_compat(const sigset_t *mask, Error **errp)
     struct sigfd_compat_info *info;
     QemuThread thread;
     int fds[2];
+    Error *local_err = NULL;
 
     info = malloc(sizeof(*info));
     if (info == NULL) {
@@ -92,7 +93,12 @@ static int qemu_signalfd_compat(const sigset_t *mask, Error **errp)
     info->fd = fds[1];
 
     qemu_thread_create(&thread, "signalfd_compat", sigwait_compat, info,
-                       QEMU_THREAD_DETACHED);
+                       QEMU_THREAD_DETACHED, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        free(info);
+        return -1;
+    }
 
     return fds[0];
 }
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 13b6f8d776..91a7921a57 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -364,6 +364,7 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
     size_t size_per_thread;
     char *addr = area;
     int i = 0;
+    Error *local_err = NULL;
 
     memset_thread_failed = false;
     memset_num_threads = get_memset_num_threads(smp_cpus);
@@ -377,13 +378,20 @@ static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
         memset_thread[i].hpagesize = hpagesize;
         qemu_thread_create(&memset_thread[i].pgthread, "touch_pages",
                            do_touch_pages, &memset_thread[i],
-                           QEMU_THREAD_JOINABLE);
+                           QEMU_THREAD_JOINABLE, &local_err);
+        if (local_err) {
+            error_reportf_err(local_err, "Failed in %s() when calls "
+                              "qemu_thread_create(): \n", __func__);
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
