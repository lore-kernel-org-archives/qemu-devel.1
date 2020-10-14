Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66E4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350FE20878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350FE20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSbNN-0003Ut-52
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 03:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSbKh-0000BQ-MI
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:36:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:50796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSbKa-0006i8-9l
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:36:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8E9F1ADC5;
 Wed, 14 Oct 2020 07:36:07 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC v1 1/2] accel/tcg: split CpusAccel into three TCG variants
Date: Wed, 14 Oct 2020 09:36:04 +0200
Message-Id: <20201014073605.6155-2-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014073605.6155-1-cfontana@suse.de>
References: <20201014073605.6155-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 01:21:00
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
Cc: Claudio Fontana <cfontana@suse.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

split up the CpusAccel tcg_cpus into three TCG variants:

tcg_cpus_rr (single threaded, round robin cpus)
tcg_cpus_icount (same as rr, but with instruction counting enabled)
tcg_cpus_mttcg (multi-threaded cpus)

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 accel/tcg/meson.build       |   9 +-
 accel/tcg/tcg-all.c         |   8 +-
 accel/tcg/tcg-cpus-icount.c | 145 +++++++++++
 accel/tcg/tcg-cpus-icount.h |  20 ++
 accel/tcg/tcg-cpus-mttcg.c  | 118 +++++++++
 accel/tcg/tcg-cpus-mttcg.h  |  25 ++
 accel/tcg/tcg-cpus-rr.c     | 270 ++++++++++++++++++++
 accel/tcg/tcg-cpus-rr.h     |  23 ++
 accel/tcg/tcg-cpus.c        | 478 ++----------------------------------
 accel/tcg/tcg-cpus.h        |   9 +-
 softmmu/icount.c            |   2 +-
 11 files changed, 647 insertions(+), 460 deletions(-)
 create mode 100644 accel/tcg/tcg-cpus-icount.c
 create mode 100644 accel/tcg/tcg-cpus-icount.h
 create mode 100644 accel/tcg/tcg-cpus-mttcg.c
 create mode 100644 accel/tcg/tcg-cpus-mttcg.h
 create mode 100644 accel/tcg/tcg-cpus-rr.c
 create mode 100644 accel/tcg/tcg-cpus-rr.h

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 19b9343d5b..f39aab0a0c 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -12,4 +12,11 @@ tcg_ss.add(when: 'CONFIG_SOFTMMU', if_false: files('user-exec-stub.c'))
 tcg_ss.add(when: 'CONFIG_PLUGIN', if_true: [files('plugin-gen.c'), libdl])
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
 
-specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TCG'], if_true: files('tcg-all.c', 'cputlb.c', 'tcg-cpus.c'))
+specific_ss.add(when: ['CONFIG_SOFTMMU', 'CONFIG_TCG'], if_true: files(
+  'tcg-all.c',
+  'cputlb.c',
+  'tcg-cpus.c',
+  'tcg-cpus-mttcg.c',
+  'tcg-cpus-icount.c',
+  'tcg-cpus-rr.c'
+))
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index fa1208158f..e42a028043 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -104,8 +104,14 @@ static int tcg_init(MachineState *ms)
 
     tcg_exec_init(s->tb_size * 1024 * 1024);
     mttcg_enabled = s->mttcg_enabled;
-    cpus_register_accel(&tcg_cpus);
 
+    if (mttcg_enabled) {
+        cpus_register_accel(&tcg_cpus_mttcg);
+    } else if (icount_enabled()) {
+        cpus_register_accel(&tcg_cpus_icount);
+    } else {
+        cpus_register_accel(&tcg_cpus_rr);
+    }
     return 0;
 }
 
diff --git a/accel/tcg/tcg-cpus-icount.c b/accel/tcg/tcg-cpus-icount.c
new file mode 100644
index 0000000000..43505e8f1f
--- /dev/null
+++ b/accel/tcg/tcg-cpus-icount.c
@@ -0,0 +1,145 @@
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
+#include "hw/boards.h"
+
+#include "tcg-cpus.h"
+
+int64_t tcg_get_icount_limit(void)
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
+void handle_icount_deadline(void)
+{
+    assert(qemu_in_vcpu_thread());
+    int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                                  QEMU_TIMER_ATTR_ALL);
+
+    if (deadline == 0) {
+        notify_aio_contexts();
+    }
+}
+
+void prepare_icount_for_run(CPUState *cpu)
+{
+    int insns_left;
+
+    /*
+     * These should always be cleared by process_icount_data after
+     * each vCPU execution. However u16.high can be raised
+     * asynchronously by cpu_exit/cpu_interrupt/tcg_handle_interrupt
+     */
+    g_assert(cpu_neg(cpu)->icount_decr.u16.low == 0);
+    g_assert(cpu->icount_extra == 0);
+
+    cpu->icount_budget = tcg_get_icount_limit();
+    insns_left = MIN(0xffff, cpu->icount_budget);
+    cpu_neg(cpu)->icount_decr.u16.low = insns_left;
+    cpu->icount_extra = cpu->icount_budget - insns_left;
+
+    replay_mutex_lock();
+
+    if (cpu->icount_budget == 0 && replay_has_checkpoint()) {
+        notify_aio_contexts();
+    }
+}
+
+void process_icount_data(CPUState *cpu)
+{
+    /* Account for executed instructions */
+    icount_update(cpu);
+
+    /* Reset the counters */
+    cpu_neg(cpu)->icount_decr.u16.low = 0;
+    cpu->icount_extra = 0;
+    cpu->icount_budget = 0;
+
+    replay_account_executed_instructions();
+
+    replay_mutex_unlock();
+}
+
+static void icount_handle_interrupt(CPUState *cpu, int mask)
+{
+    int old_mask = cpu->interrupt_request;
+
+    tcg_handle_interrupt(cpu, mask);
+    if (qemu_cpu_is_self(cpu) &&
+        !cpu->can_do_io
+        && (mask & ~old_mask) != 0) {
+        cpu_abort(cpu, "Raised interrupt while not in I/O function");
+    }
+}
+
+const CpusAccel tcg_cpus_icount = {
+    .create_vcpu_thread = tcg_start_vcpu_thread,
+    .kick_vcpu_thread = qemu_cpu_kick_rr_cpus,
+
+    .handle_interrupt = icount_handle_interrupt,
+    .get_virtual_clock = icount_get,
+    .get_elapsed_ticks = icount_get,
+};
diff --git a/accel/tcg/tcg-cpus-icount.h b/accel/tcg/tcg-cpus-icount.h
new file mode 100644
index 0000000000..e2e25674c2
--- /dev/null
+++ b/accel/tcg/tcg-cpus-icount.h
@@ -0,0 +1,20 @@
+/*
+ * Accelerator CPUS Interface
+ *
+ * Copyright 2020 SUSE LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef TCG_CPUS_ICOUNT_H
+#define TCG_CPUS_ICOUNT_H
+
+extern const CpusAccel tcg_cpus_icount;
+
+int64_t tcg_get_icount_limit(void);
+void handle_icount_deadline(void);
+void prepare_icount_for_run(CPUState *cpu);
+void process_icount_data(CPUState *cpu);
+
+#endif /* TCG_CPUS_ICOUNT_H */
diff --git a/accel/tcg/tcg-cpus-mttcg.c b/accel/tcg/tcg-cpus-mttcg.c
new file mode 100644
index 0000000000..2f5317d767
--- /dev/null
+++ b/accel/tcg/tcg-cpus-mttcg.c
@@ -0,0 +1,118 @@
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
+#include "hw/boards.h"
+
+#include "tcg-cpus.h"
+
+/*
+ * Multi-threaded TCG
+ *
+ * In the multi-threaded case each vCPU has its own thread. The TLS
+ * variable current_cpu can be used deep in the code to find the
+ * current CPUState for a given thread.
+ */
+
+void *tcg_cpu_thread_fn(void *arg)
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
+        qatomic_mb_set(&cpu->exit_request, 0);
+        qemu_wait_io_event(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    qemu_tcg_destroy_vcpu(cpu);
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
+    return NULL;
+}
+
+static void mttcg_kick_vcpu_thread(CPUState *cpu)
+{
+    cpu_exit(cpu);
+}
+
+const CpusAccel tcg_cpus_mttcg = {
+    .create_vcpu_thread = tcg_start_vcpu_thread,
+    .kick_vcpu_thread = mttcg_kick_vcpu_thread,
+
+    .handle_interrupt = tcg_handle_interrupt,
+};
diff --git a/accel/tcg/tcg-cpus-mttcg.h b/accel/tcg/tcg-cpus-mttcg.h
new file mode 100644
index 0000000000..c8966b2f8a
--- /dev/null
+++ b/accel/tcg/tcg-cpus-mttcg.h
@@ -0,0 +1,25 @@
+/*
+ * Accelerator CPUS Interface
+ *
+ * Copyright 2020 SUSE LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef TCG_CPUS_MTTCG_H
+#define TCG_CPUS_MTTCG_H
+
+extern const CpusAccel tcg_cpus_mttcg;
+
+/*
+ * Multi-threaded TCG
+ *
+ * In the multi-threaded case each vCPU has its own thread. The TLS
+ * variable current_cpu can be used deep in the code to find the
+ * current CPUState for a given thread.
+ */
+
+void *tcg_cpu_thread_fn(void *arg);
+
+#endif /* TCG_CPUS_MTTCG_H */
diff --git a/accel/tcg/tcg-cpus-rr.c b/accel/tcg/tcg-cpus-rr.c
new file mode 100644
index 0000000000..b8fd33d9d3
--- /dev/null
+++ b/accel/tcg/tcg-cpus-rr.c
@@ -0,0 +1,270 @@
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
+#include "hw/boards.h"
+
+#include "tcg-cpus.h"
+
+/* Kick all RR vCPUs */
+void qemu_cpu_kick_rr_cpus(CPUState *unused)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        cpu_exit(cpu);
+    };
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
+        cpu = qatomic_mb_read(&tcg_current_rr_cpu);
+        if (cpu) {
+            cpu_exit(cpu);
+        }
+    } while (cpu != qatomic_mb_read(&tcg_current_rr_cpu));
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
+    if (tcg_kick_vcpu_timer && timer_pending(tcg_kick_vcpu_timer)) {
+        timer_del(tcg_kick_vcpu_timer);
+    }
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
+void *tcg_rr_cpu_thread_fn(void *arg)
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
+
+        if (icount_enabled()) {
+            /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
+            icount_account_warp_timer();
+            /*
+             * Run the timers here.  This is much more efficient than
+             * waking up the I/O thread and waiting for completion.
+             */
+            handle_icount_deadline();
+        }
+
+        replay_mutex_unlock();
+
+        if (!cpu) {
+            cpu = first_cpu;
+        }
+
+        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
+
+            qatomic_mb_set(&tcg_current_rr_cpu, cpu);
+            current_cpu = cpu;
+
+            qemu_clock_enable(QEMU_CLOCK_VIRTUAL,
+                              (cpu->singlestep_enabled & SSTEP_NOTIMER) == 0);
+
+            if (cpu_can_run(cpu)) {
+                int r;
+
+                qemu_mutex_unlock_iothread();
+                if (icount_enabled()) {
+                    prepare_icount_for_run(cpu);
+                }
+                r = tcg_cpu_exec(cpu);
+                if (icount_enabled()) {
+                    process_icount_data(cpu);
+                }
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
+        /* Does not need qatomic_mb_set because a spurious wakeup is okay.  */
+        qatomic_set(&tcg_current_rr_cpu, NULL);
+
+        if (cpu && cpu->exit_request) {
+            qatomic_mb_set(&cpu->exit_request, 0);
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
+const CpusAccel tcg_cpus_rr = {
+    .create_vcpu_thread = tcg_start_vcpu_thread,
+    .kick_vcpu_thread = qemu_cpu_kick_rr_cpus,
+
+    .handle_interrupt = tcg_handle_interrupt,
+};
diff --git a/accel/tcg/tcg-cpus-rr.h b/accel/tcg/tcg-cpus-rr.h
new file mode 100644
index 0000000000..155510cfd4
--- /dev/null
+++ b/accel/tcg/tcg-cpus-rr.h
@@ -0,0 +1,23 @@
+/*
+ * Accelerator CPUS Interface
+ *
+ * Copyright 2020 SUSE LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef TCG_CPUS_RR_H
+#define TCG_CPUS_RR_H
+
+extern const CpusAccel tcg_cpus_rr;
+
+#define TCG_KICK_PERIOD (NANOSECONDS_PER_SECOND / 10)
+
+/* Kick all RR vCPUs. */
+void qemu_cpu_kick_rr_cpus(CPUState *unused);
+
+/* Single-threaded TCG */
+void *tcg_rr_cpu_thread_fn(void *arg);
+
+#endif /* TCG_CPUS_RR_H */
diff --git a/accel/tcg/tcg-cpus.c b/accel/tcg/tcg-cpus.c
index da1c63d8f6..e518cc7ed4 100644
--- a/accel/tcg/tcg-cpus.c
+++ b/accel/tcg/tcg-cpus.c
@@ -34,435 +34,9 @@
 
 #include "tcg-cpus.h"
 
-/* Kick all RR vCPUs */
-static void qemu_cpu_kick_rr_cpus(void)
-{
-    CPUState *cpu;
+/* common functionality among all TCG variants */
 
-    CPU_FOREACH(cpu) {
-        cpu_exit(cpu);
-    };
-}
-
-static void tcg_kick_vcpu_thread(CPUState *cpu)
-{
-    if (qemu_tcg_mttcg_enabled()) {
-        cpu_exit(cpu);
-    } else {
-        qemu_cpu_kick_rr_cpus();
-    }
-}
-
-/*
- * TCG vCPU kick timer
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
-        cpu = qatomic_mb_read(&tcg_current_rr_cpu);
-        if (cpu) {
-            cpu_exit(cpu);
-        }
-    } while (cpu != qatomic_mb_read(&tcg_current_rr_cpu));
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
-static void qemu_tcg_destroy_vcpu(CPUState *cpu)
-{
-}
-
-static void qemu_tcg_rr_wait_io_event(void)
-{
-    CPUState *cpu;
-
-    while (all_cpu_threads_idle()) {
-        stop_tcg_kick_timer();
-        qemu_cond_wait_iothread(first_cpu->halt_cond);
-    }
-
-    start_tcg_kick_timer();
-
-    CPU_FOREACH(cpu) {
-        qemu_wait_io_event_common(cpu);
-    }
-}
-
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
-        /*
-         * Maintain prior (possibly buggy) behaviour where if no deadline
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
-        /*
-         * These should always be cleared by process_icount_data after
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
-    qatomic_set(&tcg_ctx->prof.cpu_exec_time,
-                tcg_ctx->prof.cpu_exec_time + profile_getclock() - ti);
-#endif
-    return ret;
-}
-
-/*
- * Destroy any remaining vCPUs which have been unplugged and have
- * finished running
- */
-static void deal_with_unplugged_cpus(void)
-{
-    CPUState *cpu;
-
-    CPU_FOREACH(cpu) {
-        if (cpu->unplug && !cpu_can_run(cpu)) {
-            qemu_tcg_destroy_vcpu(cpu);
-            cpu_thread_signal_destroyed(cpu);
-            break;
-        }
-    }
-}
-
-/*
- * Single-threaded TCG
- *
- * In the single-threaded case each vCPU is simulated in turn. If
- * there is more than a single vCPU we create a simple timer to kick
- * the vCPU and ensure we don't get stuck in a tight loop in one vCPU.
- * This is done explicitly rather than relying on side-effects
- * elsewhere.
- */
-
-static void *tcg_rr_cpu_thread_fn(void *arg)
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
-    cpu->can_do_io = 1;
-    cpu_thread_signal_created(cpu);
-    qemu_guest_random_seed_thread_part2(cpu->random_seed);
-
-    /* wait for initial kick-off after machine start */
-    while (first_cpu->stopped) {
-        qemu_cond_wait_iothread(first_cpu->halt_cond);
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
-        /*
-         * Run the timers here.  This is much more efficient than
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
-            qatomic_mb_set(&tcg_current_rr_cpu, cpu);
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
-        /* Does not need qatomic_mb_set because a spurious wakeup is okay.  */
-        qatomic_set(&tcg_current_rr_cpu, NULL);
-
-        if (cpu && cpu->exit_request) {
-            qatomic_mb_set(&cpu->exit_request, 0);
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
-/*
- * Multi-threaded TCG
- *
- * In the multi-threaded case each vCPU has its own thread. The TLS
- * variable current_cpu can be used deep in the code to find the
- * current CPUState for a given thread.
- */
-
-static void *tcg_cpu_thread_fn(void *arg)
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
-    cpu->can_do_io = 1;
-    current_cpu = cpu;
-    cpu_thread_signal_created(cpu);
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
-                /*
-                 * during start-up the vCPU is reset and the thread is
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
-        qatomic_mb_set(&cpu->exit_request, 0);
-        qemu_wait_io_event(cpu);
-    } while (!cpu->unplug || cpu_can_run(cpu));
-
-    qemu_tcg_destroy_vcpu(cpu);
-    cpu_thread_signal_destroyed(cpu);
-    qemu_mutex_unlock_iothread();
-    rcu_unregister_thread();
-    return NULL;
-}
-
-static void tcg_start_vcpu_thread(CPUState *cpu)
+void tcg_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
     static QemuCond *single_tcg_halt_cond;
@@ -518,29 +92,36 @@ static void tcg_start_vcpu_thread(CPUState *cpu)
     }
 }
 
-static int64_t tcg_get_virtual_clock(void)
+void qemu_tcg_destroy_vcpu(CPUState *cpu)
 {
-    if (icount_enabled()) {
-        return icount_get();
-    }
-    return cpu_get_clock();
+    cpu_thread_signal_destroyed(cpu);
 }
 
-static int64_t tcg_get_elapsed_ticks(void)
+int tcg_cpu_exec(CPUState *cpu)
 {
-    if (icount_enabled()) {
-        return icount_get();
-    }
-    return cpu_get_ticks();
+    int ret;
+#ifdef CONFIG_PROFILER
+    int64_t ti;
+#endif
+    assert(tcg_enabled());
+#ifdef CONFIG_PROFILER
+    ti = profile_getclock();
+#endif
+    cpu_exec_start(cpu);
+    ret = cpu_exec(cpu);
+    cpu_exec_end(cpu);
+#ifdef CONFIG_PROFILER
+    qatomic_set(&tcg_ctx->prof.cpu_exec_time,
+                tcg_ctx->prof.cpu_exec_time + profile_getclock() - ti);
+#endif
+    return ret;
 }
 
 /* mask must never be zero, except for A20 change call */
-static void tcg_handle_interrupt(CPUState *cpu, int mask)
+void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
-    int old_mask;
     g_assert(qemu_mutex_iothread_locked());
 
-    old_mask = cpu->interrupt_request;
     cpu->interrupt_request |= mask;
 
     /*
@@ -551,20 +132,5 @@ static void tcg_handle_interrupt(CPUState *cpu, int mask)
         qemu_cpu_kick(cpu);
     } else {
         qatomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
-        if (icount_enabled() &&
-            !cpu->can_do_io
-            && (mask & ~old_mask) != 0) {
-            cpu_abort(cpu, "Raised interrupt while not in I/O function");
-        }
     }
 }
-
-const CpusAccel tcg_cpus = {
-    .create_vcpu_thread = tcg_start_vcpu_thread,
-    .kick_vcpu_thread = tcg_kick_vcpu_thread,
-
-    .handle_interrupt = tcg_handle_interrupt,
-
-    .get_virtual_clock = tcg_get_virtual_clock,
-    .get_elapsed_ticks = tcg_get_elapsed_ticks,
-};
diff --git a/accel/tcg/tcg-cpus.h b/accel/tcg/tcg-cpus.h
index 8b1d9d2abc..871e58507d 100644
--- a/accel/tcg/tcg-cpus.h
+++ b/accel/tcg/tcg-cpus.h
@@ -12,6 +12,13 @@
 
 #include "sysemu/cpus.h"
 
-extern const CpusAccel tcg_cpus;
+#include "tcg-cpus-rr.h"
+#include "tcg-cpus-icount.h"
+#include "tcg-cpus-mttcg.h"
+
+void tcg_start_vcpu_thread(CPUState *cpu);
+void qemu_tcg_destroy_vcpu(CPUState *cpu);
+int tcg_cpu_exec(CPUState *cpu);
+void tcg_handle_interrupt(CPUState *cpu, int mask);
 
 #endif /* TCG_CPUS_H */
diff --git a/softmmu/icount.c b/softmmu/icount.c
index 020a201a01..dbcd8c3594 100644
--- a/softmmu/icount.c
+++ b/softmmu/icount.c
@@ -396,7 +396,7 @@ void icount_start_warp_timer(void)
 
 void icount_account_warp_timer(void)
 {
-    if (!icount_enabled() || !icount_sleep) {
+    if (!icount_sleep) {
         return;
     }
 
-- 
2.26.2


