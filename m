Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1AFC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EF1206DC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EF1206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYPH-0005GE-28
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kIYIM-000386-N3
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:20:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:47270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kIYI9-0003mf-3R
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:20:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4DC9AB3B6;
 Wed, 16 Sep 2020 14:20:26 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PATCH v8 03/17] cpus: prepare new CpusAccel cpu accelerator interface
Date: Wed, 16 Sep 2020 16:19:50 +0200
Message-Id: <20200916142004.27429-4-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916142004.27429-1-cfontana@suse.de>
References: <20200916142004.27429-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 00:39:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Wenchao Wang <wenchao.wang@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The new interface starts unused, will start being used by the
next patches.

It provides methods for each accelerator to start a vcpu, kick a vcpu,
synchronize state, get cpu virtual clock and elapsed ticks.

In qemu_wait_io_event, make it clear that APC is used only for HAX
on Windows.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/core/cpu.c                  |   1 +
 hw/i386/x86.c                  |   2 +-
 include/sysemu/cpu-timers.h    |   9 +-
 include/sysemu/cpus.h          |  36 ++++++
 include/sysemu/hw_accel.h      |  69 +-----------
 softmmu/cpu-timers.c           |   9 +-
 softmmu/cpus.c                 | 195 ++++++++++++++++++++++++++-------
 stubs/cpu-synchronize-state.c  |   9 ++
 stubs/cpus-get-virtual-clock.c |   8 ++
 stubs/meson.build              |   2 +
 util/qemu-timer.c              |   8 +-
 11 files changed, 225 insertions(+), 123 deletions(-)
 create mode 100644 stubs/cpu-synchronize-state.c
 create mode 100644 stubs/cpus-get-virtual-clock.c

diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 8f65383ffb..b89bf56a57 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -33,6 +33,7 @@
 #include "hw/qdev-properties.h"
 #include "trace/trace-root.h"
 #include "qemu/plugin.h"
+#include "sysemu/hw_accel.h"
 
 CPUInterruptHandler cpu_interrupt_handler;
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 309632c948..72cb42734f 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -240,7 +240,7 @@ static long get_file_size(FILE *f)
 /* TSC handling */
 uint64_t cpu_get_tsc(CPUX86State *env)
 {
-    return cpu_get_ticks();
+    return cpus_get_elapsed_ticks();
 }
 
 /* IRQ handling */
diff --git a/include/sysemu/cpu-timers.h b/include/sysemu/cpu-timers.h
index 7726e005cd..ed6ee5c46c 100644
--- a/include/sysemu/cpu-timers.h
+++ b/include/sysemu/cpu-timers.h
@@ -70,9 +70,8 @@ void cpu_enable_ticks(void);
 void cpu_disable_ticks(void);
 
 /*
- * return the time elapsed in VM between vm_start and vm_stop.  Unless
- * icount is active, cpu_get_ticks() uses units of the host CPU cycle
- * counter.
+ * return the time elapsed in VM between vm_start and vm_stop.
+ * cpu_get_ticks() uses units of the host CPU cycle counter.
  */
 int64_t cpu_get_ticks(void);
 
@@ -84,4 +83,8 @@ int64_t cpu_get_clock(void);
 
 void qemu_timer_notify_cb(void *opaque, QEMUClockType type);
 
+/* get the VIRTUAL clock and VM elapsed ticks via the cpus accel interface */
+int64_t cpus_get_virtual_clock(void);
+int64_t cpus_get_elapsed_ticks(void);
+
 #endif /* SYSEMU_CPU_TIMERS_H */
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 149de000a0..26171697f5 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -4,7 +4,43 @@
 #include "qemu/timer.h"
 
 /* cpus.c */
+
+/* CPU execution threads */
+
+typedef struct CpusAccel {
+    void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY */
+    void (*kick_vcpu_thread)(CPUState *cpu);
+
+    void (*synchronize_post_reset)(CPUState *cpu);
+    void (*synchronize_post_init)(CPUState *cpu);
+    void (*synchronize_state)(CPUState *cpu);
+    void (*synchronize_pre_loadvm)(CPUState *cpu);
+
+    int64_t (*get_virtual_clock)(void);
+    int64_t (*get_elapsed_ticks)(void);
+} CpusAccel;
+
+/* register accel-specific cpus interface implementation */
+void cpus_register_accel(const CpusAccel *i);
+
+/* interface available for cpus accelerator threads */
+
+/* For temporary buffers for forming a name */
+#define VCPU_THREAD_NAME_SIZE 16
+
+void cpus_kick_thread(CPUState *cpu);
+bool cpu_work_list_empty(CPUState *cpu);
+bool cpu_thread_is_idle(CPUState *cpu);
 bool all_cpu_threads_idle(void);
+bool cpu_can_run(CPUState *cpu);
+void qemu_wait_io_event_common(CPUState *cpu);
+void qemu_wait_io_event(CPUState *cpu);
+void cpu_thread_signal_created(CPUState *cpu);
+void cpu_thread_signal_destroyed(CPUState *cpu);
+void cpu_handle_guest_debug(CPUState *cpu);
+
+/* end interface for cpus accelerator threads */
+
 bool qemu_in_vcpu_thread(void);
 void qemu_init_cpu_loop(void);
 void resume_all_vcpus(void);
diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index e128f8b06b..ffed6192a3 100644
--- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -1,5 +1,5 @@
 /*
- * QEMU Hardware accelertors support
+ * QEMU Hardware accelerators support
  *
  * Copyright 2016 Google, Inc.
  *
@@ -17,68 +17,9 @@
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
 
-static inline void cpu_synchronize_state(CPUState *cpu)
-{
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_state(cpu);
-    }
-    if (hax_enabled()) {
-        hax_cpu_synchronize_state(cpu);
-    }
-    if (hvf_enabled()) {
-        hvf_cpu_synchronize_state(cpu);
-    }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_state(cpu);
-    }
-}
-
-static inline void cpu_synchronize_post_reset(CPUState *cpu)
-{
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_post_reset(cpu);
-    }
-    if (hax_enabled()) {
-        hax_cpu_synchronize_post_reset(cpu);
-    }
-    if (hvf_enabled()) {
-        hvf_cpu_synchronize_post_reset(cpu);
-    }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_post_reset(cpu);
-    }
-}
-
-static inline void cpu_synchronize_post_init(CPUState *cpu)
-{
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_post_init(cpu);
-    }
-    if (hax_enabled()) {
-        hax_cpu_synchronize_post_init(cpu);
-    }
-    if (hvf_enabled()) {
-        hvf_cpu_synchronize_post_init(cpu);
-    }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_post_init(cpu);
-    }
-}
-
-static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
-{
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_pre_loadvm(cpu);
-    }
-    if (hax_enabled()) {
-        hax_cpu_synchronize_pre_loadvm(cpu);
-    }
-    if (hvf_enabled()) {
-        hvf_cpu_synchronize_pre_loadvm(cpu);
-    }
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_pre_loadvm(cpu);
-    }
-}
+void cpu_synchronize_state(CPUState *cpu);
+void cpu_synchronize_post_reset(CPUState *cpu);
+void cpu_synchronize_post_init(CPUState *cpu);
+void cpu_synchronize_pre_loadvm(CPUState *cpu);
 
 #endif /* QEMU_HW_ACCEL_H */
diff --git a/softmmu/cpu-timers.c b/softmmu/cpu-timers.c
index 7efec17fea..1eb7c675c1 100644
--- a/softmmu/cpu-timers.c
+++ b/softmmu/cpu-timers.c
@@ -61,18 +61,13 @@ static int64_t cpu_get_ticks_locked(void)
 }
 
 /*
- * return the time elapsed in VM between vm_start and vm_stop.  Unless
- * icount is active, cpu_get_ticks() uses units of the host CPU cycle
- * counter.
+ * return the time elapsed in VM between vm_start and vm_stop.
+ * cpu_get_ticks() uses units of the host CPU cycle counter.
  */
 int64_t cpu_get_ticks(void)
 {
     int64_t ticks;
 
-    if (icount_enabled()) {
-        return icount_get();
-    }
-
     qemu_spin_lock(&timers_state.vm_clock_lock);
     ticks = cpu_get_ticks_locked();
     qemu_spin_unlock(&timers_state.vm_clock_lock);
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index cf604c55bb..78f8dbb118 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -87,7 +87,7 @@ bool cpu_is_stopped(CPUState *cpu)
     return cpu->stopped || !runstate_is_running();
 }
 
-static inline bool cpu_work_list_empty(CPUState *cpu)
+bool cpu_work_list_empty(CPUState *cpu)
 {
     bool ret;
 
@@ -97,7 +97,7 @@ static inline bool cpu_work_list_empty(CPUState *cpu)
     return ret;
 }
 
-static bool cpu_thread_is_idle(CPUState *cpu)
+bool cpu_thread_is_idle(CPUState *cpu)
 {
     if (cpu->stop || !cpu_work_list_empty(cpu)) {
         return false;
@@ -215,6 +215,11 @@ void hw_error(const char *fmt, ...)
     abort();
 }
 
+/*
+ * The chosen accelerator is supposed to register this.
+ */
+static const CpusAccel *cpus_accel;
+
 void cpu_synchronize_all_states(void)
 {
     CPUState *cpu;
@@ -251,6 +256,102 @@ void cpu_synchronize_all_pre_loadvm(void)
     }
 }
 
+void cpu_synchronize_state(CPUState *cpu)
+{
+    if (cpus_accel && cpus_accel->synchronize_state) {
+        cpus_accel->synchronize_state(cpu);
+    }
+    if (kvm_enabled()) {
+        kvm_cpu_synchronize_state(cpu);
+    }
+    if (hax_enabled()) {
+        hax_cpu_synchronize_state(cpu);
+    }
+    if (whpx_enabled()) {
+        whpx_cpu_synchronize_state(cpu);
+    }
+}
+
+void cpu_synchronize_post_reset(CPUState *cpu)
+{
+    if (cpus_accel && cpus_accel->synchronize_post_reset) {
+        cpus_accel->synchronize_post_reset(cpu);
+    }
+    if (kvm_enabled()) {
+        kvm_cpu_synchronize_post_reset(cpu);
+    }
+    if (hax_enabled()) {
+        hax_cpu_synchronize_post_reset(cpu);
+    }
+    if (whpx_enabled()) {
+        whpx_cpu_synchronize_post_reset(cpu);
+    }
+}
+
+void cpu_synchronize_post_init(CPUState *cpu)
+{
+    if (cpus_accel && cpus_accel->synchronize_post_init) {
+        cpus_accel->synchronize_post_init(cpu);
+    }
+    if (kvm_enabled()) {
+        kvm_cpu_synchronize_post_init(cpu);
+    }
+    if (hax_enabled()) {
+        hax_cpu_synchronize_post_init(cpu);
+    }
+    if (whpx_enabled()) {
+        whpx_cpu_synchronize_post_init(cpu);
+    }
+}
+
+void cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+    if (cpus_accel && cpus_accel->synchronize_pre_loadvm) {
+        cpus_accel->synchronize_pre_loadvm(cpu);
+    }
+    if (kvm_enabled()) {
+        kvm_cpu_synchronize_pre_loadvm(cpu);
+    }
+    if (hax_enabled()) {
+        hax_cpu_synchronize_pre_loadvm(cpu);
+    }
+    if (hvf_enabled()) {
+        hvf_cpu_synchronize_pre_loadvm(cpu);
+    }
+    if (whpx_enabled()) {
+        whpx_cpu_synchronize_pre_loadvm(cpu);
+    }
+}
+
+int64_t cpus_get_virtual_clock(void)
+{
+    if (cpus_accel && cpus_accel->get_virtual_clock) {
+        return cpus_accel->get_virtual_clock();
+    }
+    if (icount_enabled()) {
+        return icount_get();
+    } else if (qtest_enabled()) { /* for qtest_clock_warp */
+        return qtest_get_virtual_clock();
+    }
+    return cpu_get_clock();
+}
+
+/*
+ * return the time elapsed in VM between vm_start and vm_stop.  Unless
+ * icount is active, cpus_get_elapsed_ticks() uses units of the host CPU cycle
+ * counter.
+ */
+int64_t cpus_get_elapsed_ticks(void)
+{
+    if (cpus_accel && cpus_accel->get_elapsed_ticks) {
+        return cpus_accel->get_elapsed_ticks();
+    }
+    if (icount_enabled()) {
+        return icount_get();
+    }
+    return cpu_get_ticks();
+}
+
 static int do_vm_stop(RunState state, bool send_stop)
 {
     int ret = 0;
@@ -279,7 +380,7 @@ int vm_shutdown(void)
     return do_vm_stop(RUN_STATE_SHUTDOWN, false);
 }
 
-static bool cpu_can_run(CPUState *cpu)
+bool cpu_can_run(CPUState *cpu)
 {
     if (cpu->stop) {
         return false;
@@ -290,7 +391,7 @@ static bool cpu_can_run(CPUState *cpu)
     return true;
 }
 
-static void cpu_handle_guest_debug(CPUState *cpu)
+void cpu_handle_guest_debug(CPUState *cpu)
 {
     gdb_set_stop_cpu(cpu);
     qemu_system_debug_request();
@@ -396,7 +497,7 @@ static void qemu_cpu_stop(CPUState *cpu, bool exit)
     qemu_cond_broadcast(&qemu_pause_cond);
 }
 
-static void qemu_wait_io_event_common(CPUState *cpu)
+void qemu_wait_io_event_common(CPUState *cpu)
 {
     atomic_mb_set(&cpu->thread_kicked, false);
     if (cpu->stop) {
@@ -421,7 +522,7 @@ static void qemu_tcg_rr_wait_io_event(void)
     }
 }
 
-static void qemu_wait_io_event(CPUState *cpu)
+void qemu_wait_io_event(CPUState *cpu)
 {
     bool slept = false;
 
@@ -437,8 +538,8 @@ static void qemu_wait_io_event(CPUState *cpu)
     }
 
 #ifdef _WIN32
-    /* Eat dummy APC queued by qemu_cpu_kick_thread.  */
-    if (!tcg_enabled()) {
+    /* Eat dummy APC queued by cpus_kick_thread. */
+    if (hax_enabled()) {
         SleepEx(0, TRUE);
     }
 #endif
@@ -467,8 +568,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     kvm_init_cpu_signals(cpu);
 
     /* signal CPU creation */
-    cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
@@ -482,8 +582,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     qemu_kvm_destroy_vcpu(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_destroyed(cpu);
     qemu_mutex_unlock_iothread();
     rcu_unregister_thread();
     return NULL;
@@ -511,8 +610,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
     sigaddset(&waitset, SIG_IPI);
 
     /* signal CPU creation */
-    cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
@@ -660,8 +758,7 @@ static void deal_with_unplugged_cpus(void)
     CPU_FOREACH(cpu) {
         if (cpu->unplug && !cpu_can_run(cpu)) {
             qemu_tcg_destroy_vcpu(cpu);
-            cpu->created = false;
-            qemu_cond_signal(&qemu_cpu_cond);
+            cpu_thread_signal_destroyed(cpu);
             break;
         }
     }
@@ -688,9 +785,8 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->created = true;
     cpu->can_do_io = 1;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     /* wait for initial kick-off after machine start */
@@ -800,11 +896,9 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->created = true;
     current_cpu = cpu;
-
     hax_init_vcpu(cpu);
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
@@ -843,8 +937,7 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     hvf_init_vcpu(cpu);
 
     /* signal CPU creation */
-    cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
@@ -858,8 +951,7 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     hvf_vcpu_destroy(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_destroyed(cpu);
     qemu_mutex_unlock_iothread();
     rcu_unregister_thread();
     return NULL;
@@ -884,8 +976,7 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
     }
 
     /* signal CPU creation */
-    cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
@@ -902,8 +993,7 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     whpx_destroy_vcpu(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_destroyed(cpu);
     qemu_mutex_unlock_iothread();
     rcu_unregister_thread();
     return NULL;
@@ -936,10 +1026,9 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->created = true;
     cpu->can_do_io = 1;
     current_cpu = cpu;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     /* process any pending work */
@@ -980,14 +1069,13 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     qemu_tcg_destroy_vcpu(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_destroyed(cpu);
     qemu_mutex_unlock_iothread();
     rcu_unregister_thread();
     return NULL;
 }
 
-static void qemu_cpu_kick_thread(CPUState *cpu)
+void cpus_kick_thread(CPUState *cpu)
 {
 #ifndef _WIN32
     int err;
@@ -1017,7 +1105,10 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
 void qemu_cpu_kick(CPUState *cpu)
 {
     qemu_cond_broadcast(cpu->halt_cond);
-    if (tcg_enabled()) {
+
+    if (cpus_accel && cpus_accel->kick_vcpu_thread) {
+        cpus_accel->kick_vcpu_thread(cpu);
+    } else if (tcg_enabled()) {
         if (qemu_tcg_mttcg_enabled()) {
             cpu_exit(cpu);
         } else {
@@ -1031,14 +1122,14 @@ void qemu_cpu_kick(CPUState *cpu)
              */
             cpu->exit_request = 1;
         }
-        qemu_cpu_kick_thread(cpu);
+        cpus_kick_thread(cpu);
     }
 }
 
 void qemu_cpu_kick_self(void)
 {
     assert(current_cpu);
-    qemu_cpu_kick_thread(current_cpu);
+    cpus_kick_thread(current_cpu);
 }
 
 bool qemu_cpu_is_self(CPUState *cpu)
@@ -1088,6 +1179,21 @@ void qemu_cond_timedwait_iothread(QemuCond *cond, int ms)
     qemu_cond_timedwait(cond, &qemu_global_mutex, ms);
 }
 
+/* signal CPU creation */
+void cpu_thread_signal_created(CPUState *cpu)
+{
+    cpu->created = true;
+    qemu_cond_signal(&qemu_cpu_cond);
+}
+
+/* signal CPU destruction */
+void cpu_thread_signal_destroyed(CPUState *cpu)
+{
+    cpu->created = false;
+    qemu_cond_signal(&qemu_cpu_cond);
+}
+
+
 static bool all_vcpus_paused(void)
 {
     CPUState *cpu;
@@ -1163,9 +1269,6 @@ void cpu_remove_sync(CPUState *cpu)
     qemu_mutex_lock_iothread();
 }
 
-/* For temporary buffers for forming a name */
-#define VCPU_THREAD_NAME_SIZE 16
-
 static void qemu_tcg_init_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
@@ -1295,6 +1398,13 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
 #endif
 }
 
+void cpus_register_accel(const CpusAccel *ca)
+{
+    assert(ca != NULL);
+    assert(ca->create_vcpu_thread != NULL); /* mandatory */
+    cpus_accel = ca;
+}
+
 static void qemu_dummy_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
@@ -1325,7 +1435,10 @@ void qemu_init_vcpu(CPUState *cpu)
         cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
 
-    if (kvm_enabled()) {
+    if (cpus_accel) {
+        /* accelerator already implements the CpusAccel interface */
+        cpus_accel->create_vcpu_thread(cpu);
+    } else if (kvm_enabled()) {
         qemu_kvm_start_vcpu(cpu);
     } else if (hax_enabled()) {
         qemu_hax_start_vcpu(cpu);
diff --git a/stubs/cpu-synchronize-state.c b/stubs/cpu-synchronize-state.c
new file mode 100644
index 0000000000..d9211da66c
--- /dev/null
+++ b/stubs/cpu-synchronize-state.c
@@ -0,0 +1,9 @@
+#include "qemu/osdep.h"
+#include "sysemu/hw_accel.h"
+
+void cpu_synchronize_state(CPUState *cpu)
+{
+}
+void cpu_synchronize_post_init(CPUState *cpu)
+{
+}
diff --git a/stubs/cpus-get-virtual-clock.c b/stubs/cpus-get-virtual-clock.c
new file mode 100644
index 0000000000..fd447d53f3
--- /dev/null
+++ b/stubs/cpus-get-virtual-clock.c
@@ -0,0 +1,8 @@
+#include "qemu/osdep.h"
+#include "sysemu/cpu-timers.h"
+#include "qemu/main-loop.h"
+
+int64_t cpus_get_virtual_clock(void)
+{
+    return cpu_get_clock();
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index e64ce02ea2..056c01aeae 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -5,6 +5,7 @@ stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
 stub_ss.add(files('change-state-handler.c'))
 stub_ss.add(files('cmos.c'))
 stub_ss.add(files('cpu-get-clock.c'))
+stub_ss.add(files('cpus-get-virtual-clock.c'))
 stub_ss.add(files('qemu-timer-notify-cb.c'))
 stub_ss.add(files('icount.c'))
 stub_ss.add(files('dump.c'))
@@ -44,6 +45,7 @@ stub_ss.add(files('vmgenid.c'))
 stub_ss.add(files('vmstate.c'))
 stub_ss.add(files('vm-stop.c'))
 stub_ss.add(files('win32-kbd-hook.c'))
+stub_ss.add(files('cpu-synchronize-state.c'))
 if have_system
   stub_ss.add(files('semihost.c'))
 endif
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 9a0e3bacaa..2f05e52046 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -635,13 +635,7 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
         return get_clock();
     default:
     case QEMU_CLOCK_VIRTUAL:
-        if (icount_enabled()) {
-            return icount_get();
-        } else if (qtest_enabled()) { /* for qtest_clock_warp */
-            return qtest_get_virtual_clock();
-        } else {
-            return cpu_get_clock();
-        }
+        return cpus_get_virtual_clock();
     case QEMU_CLOCK_HOST:
         return REPLAY_CLOCK(REPLAY_CLOCK_HOST, get_clock_realtime());
     case QEMU_CLOCK_VIRTUAL_RT:
-- 
2.26.2


