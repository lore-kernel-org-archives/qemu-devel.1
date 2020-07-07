Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C0CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:00:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 029A42065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029A42065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jso9D-0007i9-4r
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 10:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jso72-0003mt-ID
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 09:58:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:45918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jso6w-0007FU-TT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 09:58:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 05714AD7B;
 Tue,  7 Jul 2020 13:58:14 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC v2 1/6] cpus: extract out TCG-specific code to accel/tcg
Date: Tue,  7 Jul 2020 15:58:03 +0200
Message-Id: <20200707135808.9241-2-cfontana@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200707135808.9241-1-cfontana@suse.de>
References: <20200707135808.9241-1-cfontana@suse.de>
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 23:42:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>,
 Claudio Fontana <cfontana@suse.de>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TCG is the first accelerator to register a "CpusAccel" interface
on initialization, providing functions for starting a vcpu,
kicking a vcpu, and sychronizing state.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 accel/tcg/Makefile.objs       |   1 +
 accel/tcg/tcg-all.c           |  12 +-
 accel/tcg/tcg-cpus.c          | 532 ++++++++++++++++++++++++++++++++++
 accel/tcg/tcg-cpus.h          |  17 ++
 hw/core/cpu.c                 |   1 +
 include/sysemu/cpus.h         |  33 +++
 include/sysemu/hw_accel.h     |  57 +---
 softmmu/cpus.c                | 643 ++++++++----------------------------------
 stubs/Makefile.objs           |   1 +
 stubs/cpu-synchronize-state.c |  15 +
 10 files changed, 732 insertions(+), 580 deletions(-)
 create mode 100644 accel/tcg/tcg-cpus.c
 create mode 100644 accel/tcg/tcg-cpus.h
 create mode 100644 stubs/cpu-synchronize-state.c

diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index a92f2c454b..ecf9aa582e 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -1,5 +1,6 @@
 obj-$(CONFIG_SOFTMMU) += tcg-all.o
 obj-$(CONFIG_SOFTMMU) += cputlb.o
+obj-$(CONFIG_SOFTMMU) += tcg-cpus.o
 obj-y += tcg-runtime.o tcg-runtime-gvec.o
 obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
 obj-y += translator.o
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index e27385d051..3fd4bf2cab 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -24,19 +24,17 @@
  */
 
 #include "qemu/osdep.h"
-#include "sysemu/accel.h"
+#include "qemu-common.h"
 #include "sysemu/tcg.h"
-#include "qom/object.h"
-#include "cpu.h"
-#include "sysemu/cpus.h"
 #include "sysemu/cpu-timers.h"
-#include "qemu/main-loop.h"
 #include "tcg/tcg.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/boards.h"
 #include "qapi/qapi-builtin-visit.h"
 
+#include "tcg-cpus.h"
+
 typedef struct TCGState {
     AccelState parent_obj;
 
@@ -123,6 +121,8 @@ static void tcg_accel_instance_init(Object *obj)
     s->mttcg_enabled = default_mttcg_enabled();
 }
 
+bool mttcg_enabled;
+
 static int tcg_init(MachineState *ms)
 {
     TCGState *s = TCG_STATE(current_accel());
@@ -130,6 +130,8 @@ static int tcg_init(MachineState *ms)
     tcg_exec_init(s->tb_size * 1024 * 1024);
     cpu_interrupt_handler = tcg_handle_interrupt;
     mttcg_enabled = s->mttcg_enabled;
+    cpus_register_accel(&tcg_cpus);
+
     return 0;
 }
 
diff --git a/accel/tcg/tcg-cpus.c b/accel/tcg/tcg-cpus.c
new file mode 100644
index 0000000000..ff7a8b5e0b
--- /dev/null
+++ b/accel/tcg/tcg-cpus.c
@@ -0,0 +1,532 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2014 Red Hat Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "sysemu/tcg.h"
+#include "sysemu/replay.h"
+#include "qemu/main-loop.h"
+#include "qemu/guest-random.h"
+#include "exec/exec-all.h"
+
+#include "tcg-cpus.h"
+
+/* Kick all RR vCPUs */
+static void qemu_cpu_kick_rr_cpus(void)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        cpu_exit(cpu);
+    };
+}
+
+static void tcg_kick_vcpu_thread(CPUState *cpu)
+{
+    if (qemu_tcg_mttcg_enabled()) {
+        cpu_exit(cpu);
+    } else {
+        qemu_cpu_kick_rr_cpus();
+    }
+}
+
+/*
+ * TCG vCPU kick timer
+ *
+ * The kick timer is responsible for moving single threaded vCPU
+ * emulation on to the next vCPU. If more than one vCPU is running a
+ * timer event with force a cpu->exit so the next vCPU can get
+ * scheduled.
+ *
+ * The timer is removed if all vCPUs are idle and restarted again once
+ * idleness is complete.
+ */
+
+static QEMUTimer *tcg_kick_vcpu_timer;
+static CPUState *tcg_current_rr_cpu;
+
+#define TCG_KICK_PERIOD (NANOSECONDS_PER_SECOND / 10)
+
+static inline int64_t qemu_tcg_next_kick(void)
+{
+    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
+}
+
+/* Kick the currently round-robin scheduled vCPU to next */
+static void qemu_cpu_kick_rr_next_cpu(void)
+{
+    CPUState *cpu;
+    do {
+        cpu = atomic_mb_read(&tcg_current_rr_cpu);
+        if (cpu) {
+            cpu_exit(cpu);
+        }
+    } while (cpu != atomic_mb_read(&tcg_current_rr_cpu));
+}
+
+static void kick_tcg_thread(void *opaque)
+{
+    timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
+    qemu_cpu_kick_rr_next_cpu();
+}
+
+static void start_tcg_kick_timer(void)
+{
+    assert(!mttcg_enabled);
+    if (!tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
+        tcg_kick_vcpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
+                                           kick_tcg_thread, NULL);
+    }
+    if (tcg_kick_vcpu_timer && !timer_pending(tcg_kick_vcpu_timer)) {
+        timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
+    }
+}
+
+static void stop_tcg_kick_timer(void)
+{
+    assert(!mttcg_enabled);
+    if (tcg_kick_vcpu_timer && timer_pending(tcg_kick_vcpu_timer)) {
+        timer_del(tcg_kick_vcpu_timer);
+    }
+}
+
+static void qemu_tcg_destroy_vcpu(CPUState *cpu)
+{
+}
+
+static void qemu_tcg_rr_wait_io_event(void)
+{
+    CPUState *cpu;
+
+    while (all_cpu_threads_idle()) {
+        stop_tcg_kick_timer();
+        qemu_cond_wait_iothread(first_cpu->halt_cond);
+    }
+
+    start_tcg_kick_timer();
+
+    CPU_FOREACH(cpu) {
+        qemu_wait_io_event_common(cpu);
+    }
+}
+
+static int64_t tcg_get_icount_limit(void)
+{
+    int64_t deadline;
+
+    if (replay_mode != REPLAY_MODE_PLAY) {
+        /*
+         * Include all the timers, because they may need an attention.
+         * Too long CPU execution may create unnecessary delay in UI.
+         */
+        deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                              QEMU_TIMER_ATTR_ALL);
+        /* Check realtime timers, because they help with input processing */
+        deadline = qemu_soonest_timeout(deadline,
+                qemu_clock_deadline_ns_all(QEMU_CLOCK_REALTIME,
+                                           QEMU_TIMER_ATTR_ALL));
+
+        /*
+         * Maintain prior (possibly buggy) behaviour where if no deadline
+         * was set (as there is no QEMU_CLOCK_VIRTUAL timer) or it is more than
+         * INT32_MAX nanoseconds ahead, we still use INT32_MAX
+         * nanoseconds.
+         */
+        if ((deadline < 0) || (deadline > INT32_MAX)) {
+            deadline = INT32_MAX;
+        }
+
+        return icount_round(deadline);
+    } else {
+        return replay_get_instructions();
+    }
+}
+
+static void notify_aio_contexts(void)
+{
+    /* Wake up other AioContexts.  */
+    qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
+    qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
+}
+
+static void handle_icount_deadline(void)
+{
+    assert(qemu_in_vcpu_thread());
+    if (icount_enabled()) {
+        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                                      QEMU_TIMER_ATTR_ALL);
+
+        if (deadline == 0) {
+            notify_aio_contexts();
+        }
+    }
+}
+
+static void prepare_icount_for_run(CPUState *cpu)
+{
+    if (icount_enabled()) {
+        int insns_left;
+
+        /*
+         * These should always be cleared by process_icount_data after
+         * each vCPU execution. However u16.high can be raised
+         * asynchronously by cpu_exit/cpu_interrupt/tcg_handle_interrupt
+         */
+        g_assert(cpu_neg(cpu)->icount_decr.u16.low == 0);
+        g_assert(cpu->icount_extra == 0);
+
+        cpu->icount_budget = tcg_get_icount_limit();
+        insns_left = MIN(0xffff, cpu->icount_budget);
+        cpu_neg(cpu)->icount_decr.u16.low = insns_left;
+        cpu->icount_extra = cpu->icount_budget - insns_left;
+
+        replay_mutex_lock();
+
+        if (cpu->icount_budget == 0 && replay_has_checkpoint()) {
+            notify_aio_contexts();
+        }
+    }
+}
+
+static void process_icount_data(CPUState *cpu)
+{
+    if (icount_enabled()) {
+        /* Account for executed instructions */
+        icount_update(cpu);
+
+        /* Reset the counters */
+        cpu_neg(cpu)->icount_decr.u16.low = 0;
+        cpu->icount_extra = 0;
+        cpu->icount_budget = 0;
+
+        replay_account_executed_instructions();
+
+        replay_mutex_unlock();
+    }
+}
+
+static int tcg_cpu_exec(CPUState *cpu)
+{
+    int ret;
+#ifdef CONFIG_PROFILER
+    int64_t ti;
+#endif
+
+    assert(tcg_enabled());
+#ifdef CONFIG_PROFILER
+    ti = profile_getclock();
+#endif
+    cpu_exec_start(cpu);
+    ret = cpu_exec(cpu);
+    cpu_exec_end(cpu);
+#ifdef CONFIG_PROFILER
+    atomic_set(&tcg_ctx->prof.cpu_exec_time,
+               tcg_ctx->prof.cpu_exec_time + profile_getclock() - ti);
+#endif
+    return ret;
+}
+
+/*
+ * Destroy any remaining vCPUs which have been unplugged and have
+ * finished running
+ */
+static void deal_with_unplugged_cpus(void)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        if (cpu->unplug && !cpu_can_run(cpu)) {
+            qemu_tcg_destroy_vcpu(cpu);
+            cpu_thread_signal_destroyed(cpu);
+            break;
+        }
+    }
+}
+
+/*
+ * Single-threaded TCG
+ *
+ * In the single-threaded case each vCPU is simulated in turn. If
+ * there is more than a single vCPU we create a simple timer to kick
+ * the vCPU and ensure we don't get stuck in a tight loop in one vCPU.
+ * This is done explicitly rather than relying on side-effects
+ * elsewhere.
+ */
+
+static void *tcg_rr_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+
+    assert(tcg_enabled());
+    rcu_register_thread();
+    tcg_register_thread();
+
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+
+    cpu->thread_id = qemu_get_thread_id();
+    cpu->can_do_io = 1;
+    cpu_thread_signal_created(cpu);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
+
+    /* wait for initial kick-off after machine start */
+    while (first_cpu->stopped) {
+        qemu_cond_wait_iothread(first_cpu->halt_cond);
+
+        /* process any pending work */
+        CPU_FOREACH(cpu) {
+            current_cpu = cpu;
+            qemu_wait_io_event_common(cpu);
+        }
+    }
+
+    start_tcg_kick_timer();
+
+    cpu = first_cpu;
+
+    /* process any pending work */
+    cpu->exit_request = 1;
+
+    while (1) {
+        qemu_mutex_unlock_iothread();
+        replay_mutex_lock();
+        qemu_mutex_lock_iothread();
+        /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
+        icount_account_warp_timer();
+
+        /*
+         * Run the timers here.  This is much more efficient than
+         * waking up the I/O thread and waiting for completion.
+         */
+        handle_icount_deadline();
+
+        replay_mutex_unlock();
+
+        if (!cpu) {
+            cpu = first_cpu;
+        }
+
+        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
+
+            atomic_mb_set(&tcg_current_rr_cpu, cpu);
+            current_cpu = cpu;
+
+            qemu_clock_enable(QEMU_CLOCK_VIRTUAL,
+                              (cpu->singlestep_enabled & SSTEP_NOTIMER) == 0);
+
+            if (cpu_can_run(cpu)) {
+                int r;
+
+                qemu_mutex_unlock_iothread();
+                prepare_icount_for_run(cpu);
+
+                r = tcg_cpu_exec(cpu);
+
+                process_icount_data(cpu);
+                qemu_mutex_lock_iothread();
+
+                if (r == EXCP_DEBUG) {
+                    cpu_handle_guest_debug(cpu);
+                    break;
+                } else if (r == EXCP_ATOMIC) {
+                    qemu_mutex_unlock_iothread();
+                    cpu_exec_step_atomic(cpu);
+                    qemu_mutex_lock_iothread();
+                    break;
+                }
+            } else if (cpu->stop) {
+                if (cpu->unplug) {
+                    cpu = CPU_NEXT(cpu);
+                }
+                break;
+            }
+
+            cpu = CPU_NEXT(cpu);
+        } /* while (cpu && !cpu->exit_request).. */
+
+        /* Does not need atomic_mb_set because a spurious wakeup is okay.  */
+        atomic_set(&tcg_current_rr_cpu, NULL);
+
+        if (cpu && cpu->exit_request) {
+            atomic_mb_set(&cpu->exit_request, 0);
+        }
+
+        if (icount_enabled() && all_cpu_threads_idle()) {
+            /*
+             * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
+             * in the main_loop, wake it up in order to start the warp timer.
+             */
+            qemu_notify_event();
+        }
+
+        qemu_tcg_rr_wait_io_event();
+        deal_with_unplugged_cpus();
+    }
+
+    rcu_unregister_thread();
+    return NULL;
+}
+
+/*
+ * Multi-threaded TCG
+ *
+ * In the multi-threaded case each vCPU has its own thread. The TLS
+ * variable current_cpu can be used deep in the code to find the
+ * current CPUState for a given thread.
+ */
+
+static void *tcg_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+
+    assert(tcg_enabled());
+    g_assert(!icount_enabled());
+
+    rcu_register_thread();
+    tcg_register_thread();
+
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+
+    cpu->thread_id = qemu_get_thread_id();
+    cpu->can_do_io = 1;
+    current_cpu = cpu;
+    cpu_thread_signal_created(cpu);
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
+
+    /* process any pending work */
+    cpu->exit_request = 1;
+
+    do {
+        if (cpu_can_run(cpu)) {
+            int r;
+            qemu_mutex_unlock_iothread();
+            r = tcg_cpu_exec(cpu);
+            qemu_mutex_lock_iothread();
+            switch (r) {
+            case EXCP_DEBUG:
+                cpu_handle_guest_debug(cpu);
+                break;
+            case EXCP_HALTED:
+                /*
+                 * during start-up the vCPU is reset and the thread is
+                 * kicked several times. If we don't ensure we go back
+                 * to sleep in the halted state we won't cleanly
+                 * start-up when the vCPU is enabled.
+                 *
+                 * cpu->halted should ensure we sleep in wait_io_event
+                 */
+                g_assert(cpu->halted);
+                break;
+            case EXCP_ATOMIC:
+                qemu_mutex_unlock_iothread();
+                cpu_exec_step_atomic(cpu);
+                qemu_mutex_lock_iothread();
+            default:
+                /* Ignore everything else? */
+                break;
+            }
+        }
+
+        atomic_mb_set(&cpu->exit_request, 0);
+        qemu_wait_io_event(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    qemu_tcg_destroy_vcpu(cpu);
+    cpu_thread_signal_destroyed(cpu);
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
+    return NULL;
+}
+
+static void tcg_start_vcpu_thread(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+    static QemuCond *single_tcg_halt_cond;
+    static QemuThread *single_tcg_cpu_thread;
+    static int tcg_region_inited;
+
+    assert(tcg_enabled());
+    /*
+     * Initialize TCG regions--once. Now is a good time, because:
+     * (1) TCG's init context, prologue and target globals have been set up.
+     * (2) qemu_tcg_mttcg_enabled() works now (TCG init code runs before the
+     *     -accel flag is processed, so the check doesn't work then).
+     */
+    if (!tcg_region_inited) {
+        tcg_region_inited = 1;
+        tcg_region_init();
+    }
+
+    if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
+        cpu->thread = g_malloc0(sizeof(QemuThread));
+        cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+        qemu_cond_init(cpu->halt_cond);
+
+        if (qemu_tcg_mttcg_enabled()) {
+            /* create a thread per vCPU with TCG (MTTCG) */
+            parallel_cpus = true;
+            snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
+                 cpu->cpu_index);
+
+            qemu_thread_create(cpu->thread, thread_name, tcg_cpu_thread_fn,
+                               cpu, QEMU_THREAD_JOINABLE);
+
+        } else {
+            /* share a single thread for all cpus with TCG */
+            snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
+            qemu_thread_create(cpu->thread, thread_name,
+                               tcg_rr_cpu_thread_fn,
+                               cpu, QEMU_THREAD_JOINABLE);
+
+            single_tcg_halt_cond = cpu->halt_cond;
+            single_tcg_cpu_thread = cpu->thread;
+        }
+#ifdef _WIN32
+        cpu->hThread = qemu_thread_get_handle(cpu->thread);
+#endif
+    } else {
+        /* For non-MTTCG cases we share the thread */
+        cpu->thread = single_tcg_cpu_thread;
+        cpu->halt_cond = single_tcg_halt_cond;
+        cpu->thread_id = first_cpu->thread_id;
+        cpu->can_do_io = 1;
+        cpu->created = true;
+    }
+}
+
+static void tcg_cpu_synchronize_noop(CPUState *cpu)
+{
+}
+
+CpusAccel tcg_cpus = {
+    .create_vcpu_thread = tcg_start_vcpu_thread,
+    .kick_vcpu_thread = tcg_kick_vcpu_thread,
+
+    .synchronize_post_reset = tcg_cpu_synchronize_noop,
+    .synchronize_post_init = tcg_cpu_synchronize_noop,
+    .synchronize_state = tcg_cpu_synchronize_noop,
+    .synchronize_pre_loadvm = tcg_cpu_synchronize_noop,
+};
diff --git a/accel/tcg/tcg-cpus.h b/accel/tcg/tcg-cpus.h
new file mode 100644
index 0000000000..af4be6a151
--- /dev/null
+++ b/accel/tcg/tcg-cpus.h
@@ -0,0 +1,17 @@
+/*
+ * Accelerator CPUS Interface
+ *
+ * Copyright 2020 SUSE LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef TCG_CPUS_H
+#define TCG_CPUS_H
+
+#include "sysemu/cpus.h"
+
+extern CpusAccel tcg_cpus;
+
+#endif /* TCG_CPUS_H */
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 0f23409f1d..2e6bb3b4d3 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -33,6 +33,7 @@
 #include "hw/qdev-properties.h"
 #include "trace-root.h"
 #include "qemu/plugin.h"
+#include "sysemu/hw_accel.h"
 
 CPUInterruptHandler cpu_interrupt_handler;
 
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 149de000a0..10cc5a2d22 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -4,7 +4,40 @@
 #include "qemu/timer.h"
 
 /* cpus.c */
+
+/* CPU execution threads */
+
+typedef struct CpusAccel {
+    void (*create_vcpu_thread)(CPUState *cpu);
+    void (*kick_vcpu_thread)(CPUState *cpu);
+
+    void (*synchronize_post_reset)(CPUState *cpu);
+    void (*synchronize_post_init)(CPUState *cpu);
+    void (*synchronize_state)(CPUState *cpu);
+    void (*synchronize_pre_loadvm)(CPUState *cpu);
+} CpusAccel;
+
+/* register accel-specific cpus interface implementation */
+void cpus_register_accel(CpusAccel *i);
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
index 0ec2372477..336740e10a 100644
--- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -1,5 +1,5 @@
 /*
- * QEMU Hardware accelertors support
+ * QEMU Hardware accelerators support
  *
  * Copyright 2016 Google, Inc.
  *
@@ -16,56 +16,9 @@
 #include "sysemu/kvm.h"
 #include "sysemu/whpx.h"
 
-static inline void cpu_synchronize_state(CPUState *cpu)
-{
-    if (kvm_enabled()) {
-        kvm_cpu_synchronize_state(cpu);
-    }
-    if (hax_enabled()) {
-        hax_cpu_synchronize_state(cpu);
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
-    if (whpx_enabled()) {
-        whpx_cpu_synchronize_pre_loadvm(cpu);
-    }
-}
+void cpu_synchronize_state(CPUState *cpu);
+void cpu_synchronize_post_reset(CPUState *cpu);
+void cpu_synchronize_post_init(CPUState *cpu);
+void cpu_synchronize_pre_loadvm(CPUState *cpu);
 
 #endif /* QEMU_HW_ACCEL_H */
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index a44960cd70..5fadc8f34c 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -24,27 +24,19 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "qemu/config-file.h"
-#include "qemu/cutils.h"
-#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qmp/qerror.h"
-#include "qemu/error-report.h"
-#include "qemu/qemu-print.h"
 #include "sysemu/tcg.h"
-#include "sysemu/block-backend.h"
 #include "exec/gdbstub.h"
-#include "sysemu/dma.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "sysemu/hax.h"
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
 #include "exec/exec-all.h"
-
 #include "qemu/thread.h"
 #include "qemu/plugin.h"
 #include "sysemu/cpus.h"
@@ -87,7 +79,7 @@ bool cpu_is_stopped(CPUState *cpu)
     return cpu->stopped || !runstate_is_running();
 }
 
-static inline bool cpu_work_list_empty(CPUState *cpu)
+bool cpu_work_list_empty(CPUState *cpu)
 {
     bool ret;
 
@@ -97,7 +89,7 @@ static inline bool cpu_work_list_empty(CPUState *cpu)
     return ret;
 }
 
-static bool cpu_thread_is_idle(CPUState *cpu)
+bool cpu_thread_is_idle(CPUState *cpu)
 {
     if (cpu->stop || !cpu_work_list_empty(cpu)) {
         return false;
@@ -124,79 +116,6 @@ bool all_cpu_threads_idle(void)
     return true;
 }
 
-bool mttcg_enabled;
-
-
-/***********************************************************/
-/* TCG vCPU kick timer
- *
- * The kick timer is responsible for moving single threaded vCPU
- * emulation on to the next vCPU. If more than one vCPU is running a
- * timer event with force a cpu->exit so the next vCPU can get
- * scheduled.
- *
- * The timer is removed if all vCPUs are idle and restarted again once
- * idleness is complete.
- */
-
-static QEMUTimer *tcg_kick_vcpu_timer;
-static CPUState *tcg_current_rr_cpu;
-
-#define TCG_KICK_PERIOD (NANOSECONDS_PER_SECOND / 10)
-
-static inline int64_t qemu_tcg_next_kick(void)
-{
-    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
-}
-
-/* Kick the currently round-robin scheduled vCPU to next */
-static void qemu_cpu_kick_rr_next_cpu(void)
-{
-    CPUState *cpu;
-    do {
-        cpu = atomic_mb_read(&tcg_current_rr_cpu);
-        if (cpu) {
-            cpu_exit(cpu);
-        }
-    } while (cpu != atomic_mb_read(&tcg_current_rr_cpu));
-}
-
-/* Kick all RR vCPUs */
-static void qemu_cpu_kick_rr_cpus(void)
-{
-    CPUState *cpu;
-
-    CPU_FOREACH(cpu) {
-        cpu_exit(cpu);
-    };
-}
-
-static void kick_tcg_thread(void *opaque)
-{
-    timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
-    qemu_cpu_kick_rr_next_cpu();
-}
-
-static void start_tcg_kick_timer(void)
-{
-    assert(!mttcg_enabled);
-    if (!tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
-        tcg_kick_vcpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                           kick_tcg_thread, NULL);
-    }
-    if (tcg_kick_vcpu_timer && !timer_pending(tcg_kick_vcpu_timer)) {
-        timer_mod(tcg_kick_vcpu_timer, qemu_tcg_next_kick());
-    }
-}
-
-static void stop_tcg_kick_timer(void)
-{
-    assert(!mttcg_enabled);
-    if (tcg_kick_vcpu_timer && timer_pending(tcg_kick_vcpu_timer)) {
-        timer_del(tcg_kick_vcpu_timer);
-    }
-}
-
 /***********************************************************/
 void hw_error(const char *fmt, ...)
 {
@@ -215,6 +134,11 @@ void hw_error(const char *fmt, ...)
     abort();
 }
 
+/*
+ * The chosen accelerator is supposed to register this.
+ */
+static CpusAccel *cpus_accel;
+
 void cpu_synchronize_all_states(void)
 {
     CPUState *cpu;
@@ -263,6 +187,74 @@ void cpu_synchronize_all_pre_loadvm(void)
     }
 }
 
+void cpu_synchronize_state(CPUState *cpu)
+{
+    if (cpus_accel) {
+        /* accelerator already implements the CpusAccel interface */
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
+    if (cpus_accel) {
+        /* accelerator already implements the CpusAccel interface */
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
+    if (cpus_accel) {
+        /* accelerator already implements the CpusAccel interface */
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
+    if (cpus_accel) {
+        /* accelerator already implements the CpusAccel interface */
+        cpus_accel->synchronize_pre_loadvm(cpu);
+    }
+    if (kvm_enabled()) {
+        kvm_cpu_synchronize_pre_loadvm(cpu);
+    }
+    if (hax_enabled()) {
+        hax_cpu_synchronize_pre_loadvm(cpu);
+    }
+    if (whpx_enabled()) {
+        whpx_cpu_synchronize_pre_loadvm(cpu);
+    }
+}
+
 static int do_vm_stop(RunState state, bool send_stop)
 {
     int ret = 0;
@@ -291,7 +283,7 @@ int vm_shutdown(void)
     return do_vm_stop(RUN_STATE_SHUTDOWN, false);
 }
 
-static bool cpu_can_run(CPUState *cpu)
+bool cpu_can_run(CPUState *cpu)
 {
     if (cpu->stop) {
         return false;
@@ -302,7 +294,7 @@ static bool cpu_can_run(CPUState *cpu)
     return true;
 }
 
-static void cpu_handle_guest_debug(CPUState *cpu)
+void cpu_handle_guest_debug(CPUState *cpu)
 {
     gdb_set_stop_cpu(cpu);
     qemu_system_debug_request();
@@ -393,10 +385,6 @@ static void qemu_kvm_destroy_vcpu(CPUState *cpu)
     }
 }
 
-static void qemu_tcg_destroy_vcpu(CPUState *cpu)
-{
-}
-
 static void qemu_cpu_stop(CPUState *cpu, bool exit)
 {
     g_assert(qemu_cpu_is_self(cpu));
@@ -408,7 +396,7 @@ static void qemu_cpu_stop(CPUState *cpu, bool exit)
     qemu_cond_broadcast(&qemu_pause_cond);
 }
 
-static void qemu_wait_io_event_common(CPUState *cpu)
+void qemu_wait_io_event_common(CPUState *cpu)
 {
     atomic_mb_set(&cpu->thread_kicked, false);
     if (cpu->stop) {
@@ -417,23 +405,7 @@ static void qemu_wait_io_event_common(CPUState *cpu)
     process_queued_cpu_work(cpu);
 }
 
-static void qemu_tcg_rr_wait_io_event(void)
-{
-    CPUState *cpu;
-
-    while (all_cpu_threads_idle()) {
-        stop_tcg_kick_timer();
-        qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
-    }
-
-    start_tcg_kick_timer();
-
-    CPU_FOREACH(cpu) {
-        qemu_wait_io_event_common(cpu);
-    }
-}
-
-static void qemu_wait_io_event(CPUState *cpu)
+void qemu_wait_io_event(CPUState *cpu)
 {
     bool slept = false;
 
@@ -449,7 +421,8 @@ static void qemu_wait_io_event(CPUState *cpu)
     }
 
 #ifdef _WIN32
-    /* Eat dummy APC queued by qemu_cpu_kick_thread.  */
+    /* Eat dummy APC queued by hax_kick_vcpu_thread */
+    /* NB!!! Should not this be if (hax_enabled)? Is this wrong for whpx? */
     if (!tcg_enabled()) {
         SleepEx(0, TRUE);
     }
@@ -479,8 +452,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     kvm_init_cpu_signals(cpu);
 
     /* signal CPU creation */
-    cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
@@ -494,8 +466,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     qemu_kvm_destroy_vcpu(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_destroyed(cpu);
     qemu_mutex_unlock_iothread();
     rcu_unregister_thread();
     return NULL;
@@ -523,8 +494,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
     sigaddset(&waitset, SIG_IPI);
 
     /* signal CPU creation */
-    cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
@@ -547,261 +517,6 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
 #endif
 }
 
-static int64_t tcg_get_icount_limit(void)
-{
-    int64_t deadline;
-
-    if (replay_mode != REPLAY_MODE_PLAY) {
-        /*
-         * Include all the timers, because they may need an attention.
-         * Too long CPU execution may create unnecessary delay in UI.
-         */
-        deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
-                                              QEMU_TIMER_ATTR_ALL);
-        /* Check realtime timers, because they help with input processing */
-        deadline = qemu_soonest_timeout(deadline,
-                qemu_clock_deadline_ns_all(QEMU_CLOCK_REALTIME,
-                                           QEMU_TIMER_ATTR_ALL));
-
-        /* Maintain prior (possibly buggy) behaviour where if no deadline
-         * was set (as there is no QEMU_CLOCK_VIRTUAL timer) or it is more than
-         * INT32_MAX nanoseconds ahead, we still use INT32_MAX
-         * nanoseconds.
-         */
-        if ((deadline < 0) || (deadline > INT32_MAX)) {
-            deadline = INT32_MAX;
-        }
-
-        return icount_round(deadline);
-    } else {
-        return replay_get_instructions();
-    }
-}
-
-static void notify_aio_contexts(void)
-{
-    /* Wake up other AioContexts.  */
-    qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
-    qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
-}
-
-static void handle_icount_deadline(void)
-{
-    assert(qemu_in_vcpu_thread());
-    if (icount_enabled()) {
-        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
-                                                      QEMU_TIMER_ATTR_ALL);
-
-        if (deadline == 0) {
-            notify_aio_contexts();
-        }
-    }
-}
-
-static void prepare_icount_for_run(CPUState *cpu)
-{
-    if (icount_enabled()) {
-        int insns_left;
-
-        /* These should always be cleared by process_icount_data after
-         * each vCPU execution. However u16.high can be raised
-         * asynchronously by cpu_exit/cpu_interrupt/tcg_handle_interrupt
-         */
-        g_assert(cpu_neg(cpu)->icount_decr.u16.low == 0);
-        g_assert(cpu->icount_extra == 0);
-
-        cpu->icount_budget = tcg_get_icount_limit();
-        insns_left = MIN(0xffff, cpu->icount_budget);
-        cpu_neg(cpu)->icount_decr.u16.low = insns_left;
-        cpu->icount_extra = cpu->icount_budget - insns_left;
-
-        replay_mutex_lock();
-
-        if (cpu->icount_budget == 0 && replay_has_checkpoint()) {
-            notify_aio_contexts();
-        }
-    }
-}
-
-static void process_icount_data(CPUState *cpu)
-{
-    if (icount_enabled()) {
-        /* Account for executed instructions */
-        icount_update(cpu);
-
-        /* Reset the counters */
-        cpu_neg(cpu)->icount_decr.u16.low = 0;
-        cpu->icount_extra = 0;
-        cpu->icount_budget = 0;
-
-        replay_account_executed_instructions();
-
-        replay_mutex_unlock();
-    }
-}
-
-
-static int tcg_cpu_exec(CPUState *cpu)
-{
-    int ret;
-#ifdef CONFIG_PROFILER
-    int64_t ti;
-#endif
-
-    assert(tcg_enabled());
-#ifdef CONFIG_PROFILER
-    ti = profile_getclock();
-#endif
-    cpu_exec_start(cpu);
-    ret = cpu_exec(cpu);
-    cpu_exec_end(cpu);
-#ifdef CONFIG_PROFILER
-    atomic_set(&tcg_ctx->prof.cpu_exec_time,
-               tcg_ctx->prof.cpu_exec_time + profile_getclock() - ti);
-#endif
-    return ret;
-}
-
-/* Destroy any remaining vCPUs which have been unplugged and have
- * finished running
- */
-static void deal_with_unplugged_cpus(void)
-{
-    CPUState *cpu;
-
-    CPU_FOREACH(cpu) {
-        if (cpu->unplug && !cpu_can_run(cpu)) {
-            qemu_tcg_destroy_vcpu(cpu);
-            cpu->created = false;
-            qemu_cond_signal(&qemu_cpu_cond);
-            break;
-        }
-    }
-}
-
-/* Single-threaded TCG
- *
- * In the single-threaded case each vCPU is simulated in turn. If
- * there is more than a single vCPU we create a simple timer to kick
- * the vCPU and ensure we don't get stuck in a tight loop in one vCPU.
- * This is done explicitly rather than relying on side-effects
- * elsewhere.
- */
-
-static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
-{
-    CPUState *cpu = arg;
-
-    assert(tcg_enabled());
-    rcu_register_thread();
-    tcg_register_thread();
-
-    qemu_mutex_lock_iothread();
-    qemu_thread_get_self(cpu->thread);
-
-    cpu->thread_id = qemu_get_thread_id();
-    cpu->created = true;
-    cpu->can_do_io = 1;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_guest_random_seed_thread_part2(cpu->random_seed);
-
-    /* wait for initial kick-off after machine start */
-    while (first_cpu->stopped) {
-        qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
-
-        /* process any pending work */
-        CPU_FOREACH(cpu) {
-            current_cpu = cpu;
-            qemu_wait_io_event_common(cpu);
-        }
-    }
-
-    start_tcg_kick_timer();
-
-    cpu = first_cpu;
-
-    /* process any pending work */
-    cpu->exit_request = 1;
-
-    while (1) {
-        qemu_mutex_unlock_iothread();
-        replay_mutex_lock();
-        qemu_mutex_lock_iothread();
-        /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
-        icount_account_warp_timer();
-
-        /* Run the timers here.  This is much more efficient than
-         * waking up the I/O thread and waiting for completion.
-         */
-        handle_icount_deadline();
-
-        replay_mutex_unlock();
-
-        if (!cpu) {
-            cpu = first_cpu;
-        }
-
-        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
-
-            atomic_mb_set(&tcg_current_rr_cpu, cpu);
-            current_cpu = cpu;
-
-            qemu_clock_enable(QEMU_CLOCK_VIRTUAL,
-                              (cpu->singlestep_enabled & SSTEP_NOTIMER) == 0);
-
-            if (cpu_can_run(cpu)) {
-                int r;
-
-                qemu_mutex_unlock_iothread();
-                prepare_icount_for_run(cpu);
-
-                r = tcg_cpu_exec(cpu);
-
-                process_icount_data(cpu);
-                qemu_mutex_lock_iothread();
-
-                if (r == EXCP_DEBUG) {
-                    cpu_handle_guest_debug(cpu);
-                    break;
-                } else if (r == EXCP_ATOMIC) {
-                    qemu_mutex_unlock_iothread();
-                    cpu_exec_step_atomic(cpu);
-                    qemu_mutex_lock_iothread();
-                    break;
-                }
-            } else if (cpu->stop) {
-                if (cpu->unplug) {
-                    cpu = CPU_NEXT(cpu);
-                }
-                break;
-            }
-
-            cpu = CPU_NEXT(cpu);
-        } /* while (cpu && !cpu->exit_request).. */
-
-        /* Does not need atomic_mb_set because a spurious wakeup is okay.  */
-        atomic_set(&tcg_current_rr_cpu, NULL);
-
-        if (cpu && cpu->exit_request) {
-            atomic_mb_set(&cpu->exit_request, 0);
-        }
-
-        if (icount_enabled() && all_cpu_threads_idle()) {
-            /*
-             * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
-             * in the main_loop, wake it up in order to start the warp timer.
-             */
-            qemu_notify_event();
-        }
-
-        qemu_tcg_rr_wait_io_event();
-        deal_with_unplugged_cpus();
-    }
-
-    rcu_unregister_thread();
-    return NULL;
-}
-
 static void *qemu_hax_cpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
@@ -812,11 +527,9 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
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
@@ -855,8 +568,7 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     hvf_init_vcpu(cpu);
 
     /* signal CPU creation */
-    cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
@@ -870,8 +582,7 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     hvf_vcpu_destroy(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_destroyed(cpu);
     qemu_mutex_unlock_iothread();
     rcu_unregister_thread();
     return NULL;
@@ -896,8 +607,7 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
     }
 
     /* signal CPU creation */
-    cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
@@ -914,8 +624,7 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     whpx_destroy_vcpu(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
+    cpu_thread_signal_destroyed(cpu);
     qemu_mutex_unlock_iothread();
     rcu_unregister_thread();
     return NULL;
@@ -927,79 +636,7 @@ static void CALLBACK dummy_apc_func(ULONG_PTR unused)
 }
 #endif
 
-/* Multi-threaded TCG
- *
- * In the multi-threaded case each vCPU has its own thread. The TLS
- * variable current_cpu can be used deep in the code to find the
- * current CPUState for a given thread.
- */
-
-static void *qemu_tcg_cpu_thread_fn(void *arg)
-{
-    CPUState *cpu = arg;
-
-    assert(tcg_enabled());
-    g_assert(!icount_enabled());
-
-    rcu_register_thread();
-    tcg_register_thread();
-
-    qemu_mutex_lock_iothread();
-    qemu_thread_get_self(cpu->thread);
-
-    cpu->thread_id = qemu_get_thread_id();
-    cpu->created = true;
-    cpu->can_do_io = 1;
-    current_cpu = cpu;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_guest_random_seed_thread_part2(cpu->random_seed);
-
-    /* process any pending work */
-    cpu->exit_request = 1;
-
-    do {
-        if (cpu_can_run(cpu)) {
-            int r;
-            qemu_mutex_unlock_iothread();
-            r = tcg_cpu_exec(cpu);
-            qemu_mutex_lock_iothread();
-            switch (r) {
-            case EXCP_DEBUG:
-                cpu_handle_guest_debug(cpu);
-                break;
-            case EXCP_HALTED:
-                /* during start-up the vCPU is reset and the thread is
-                 * kicked several times. If we don't ensure we go back
-                 * to sleep in the halted state we won't cleanly
-                 * start-up when the vCPU is enabled.
-                 *
-                 * cpu->halted should ensure we sleep in wait_io_event
-                 */
-                g_assert(cpu->halted);
-                break;
-            case EXCP_ATOMIC:
-                qemu_mutex_unlock_iothread();
-                cpu_exec_step_atomic(cpu);
-                qemu_mutex_lock_iothread();
-            default:
-                /* Ignore everything else? */
-                break;
-            }
-        }
-
-        atomic_mb_set(&cpu->exit_request, 0);
-        qemu_wait_io_event(cpu);
-    } while (!cpu->unplug || cpu_can_run(cpu));
-
-    qemu_tcg_destroy_vcpu(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_mutex_unlock_iothread();
-    rcu_unregister_thread();
-    return NULL;
-}
-
-static void qemu_cpu_kick_thread(CPUState *cpu)
+void cpus_kick_thread(CPUState *cpu)
 {
 #ifndef _WIN32
     int err;
@@ -1029,12 +666,9 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
 void qemu_cpu_kick(CPUState *cpu)
 {
     qemu_cond_broadcast(cpu->halt_cond);
-    if (tcg_enabled()) {
-        if (qemu_tcg_mttcg_enabled()) {
-            cpu_exit(cpu);
-        } else {
-            qemu_cpu_kick_rr_cpus();
-        }
+    if (cpus_accel) {
+        /* accelerator already implements the CpusAccel interface */
+        cpus_accel->kick_vcpu_thread(cpu);
     } else {
         if (hax_enabled()) {
             /*
@@ -1043,14 +677,14 @@ void qemu_cpu_kick(CPUState *cpu)
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
@@ -1100,6 +734,21 @@ void qemu_cond_timedwait_iothread(QemuCond *cond, int ms)
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
@@ -1175,65 +824,6 @@ void cpu_remove_sync(CPUState *cpu)
     qemu_mutex_lock_iothread();
 }
 
-/* For temporary buffers for forming a name */
-#define VCPU_THREAD_NAME_SIZE 16
-
-static void qemu_tcg_init_vcpu(CPUState *cpu)
-{
-    char thread_name[VCPU_THREAD_NAME_SIZE];
-    static QemuCond *single_tcg_halt_cond;
-    static QemuThread *single_tcg_cpu_thread;
-    static int tcg_region_inited;
-
-    assert(tcg_enabled());
-    /*
-     * Initialize TCG regions--once. Now is a good time, because:
-     * (1) TCG's init context, prologue and target globals have been set up.
-     * (2) qemu_tcg_mttcg_enabled() works now (TCG init code runs before the
-     *     -accel flag is processed, so the check doesn't work then).
-     */
-    if (!tcg_region_inited) {
-        tcg_region_inited = 1;
-        tcg_region_init();
-    }
-
-    if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
-        cpu->thread = g_malloc0(sizeof(QemuThread));
-        cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-        qemu_cond_init(cpu->halt_cond);
-
-        if (qemu_tcg_mttcg_enabled()) {
-            /* create a thread per vCPU with TCG (MTTCG) */
-            parallel_cpus = true;
-            snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
-                 cpu->cpu_index);
-
-            qemu_thread_create(cpu->thread, thread_name, qemu_tcg_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE);
-
-        } else {
-            /* share a single thread for all cpus with TCG */
-            snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
-            qemu_thread_create(cpu->thread, thread_name,
-                               qemu_tcg_rr_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE);
-
-            single_tcg_halt_cond = cpu->halt_cond;
-            single_tcg_cpu_thread = cpu->thread;
-        }
-#ifdef _WIN32
-        cpu->hThread = qemu_thread_get_handle(cpu->thread);
-#endif
-    } else {
-        /* For non-MTTCG cases we share the thread */
-        cpu->thread = single_tcg_cpu_thread;
-        cpu->halt_cond = single_tcg_halt_cond;
-        cpu->thread_id = first_cpu->thread_id;
-        cpu->can_do_io = 1;
-        cpu->created = true;
-    }
-}
-
 static void qemu_hax_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
@@ -1298,6 +888,12 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
 #endif
 }
 
+void cpus_register_accel(CpusAccel *ca)
+{
+    assert(ca != NULL);
+    cpus_accel = ca;
+}
+
 static void qemu_dummy_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
@@ -1328,14 +924,15 @@ void qemu_init_vcpu(CPUState *cpu)
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
     } else if (hvf_enabled()) {
         qemu_hvf_start_vcpu(cpu);
-    } else if (tcg_enabled()) {
-        qemu_tcg_init_vcpu(cpu);
     } else if (whpx_enabled()) {
         qemu_whpx_start_vcpu(cpu);
     } else {
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 42d4f459e6..276123e245 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -26,6 +26,7 @@ stub-obj-y += tpm.o
 stub-obj-y += trace-control.o
 stub-obj-y += vmstate.o
 stub-obj-$(CONFIG_SOFTMMU) += win32-kbd-hook.o
+stub-obj-y += cpu-synchronize-state.o
 
 #######################################################################
 # code used by both qemu system emulation and qemu-img
diff --git a/stubs/cpu-synchronize-state.c b/stubs/cpu-synchronize-state.c
new file mode 100644
index 0000000000..3112fe439d
--- /dev/null
+++ b/stubs/cpu-synchronize-state.c
@@ -0,0 +1,15 @@
+#include "qemu/osdep.h"
+#include "sysemu/hw_accel.h"
+
+void cpu_synchronize_state(CPUState *cpu)
+{
+}
+void cpu_synchronize_post_reset(CPUState *cpu)
+{
+}
+void cpu_synchronize_post_init(CPUState *cpu)
+{
+}
+void cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+}
-- 
2.16.4


