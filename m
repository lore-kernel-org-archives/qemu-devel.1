Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E29C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35CD206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5kyZBDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35CD206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYf2-0004X0-VS
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLV-0000d2-7q
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLS-0002Fj-9g
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:17 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:39033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYLS-0002FZ-3I
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:14 -0400
Received: by mail-qk1-x741.google.com with SMTP id b62so8198503qkf.6
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iT2+KNOnPvuJu2Lr0qN3HFjDh2VfGcLYrWgRqkL7cdA=;
 b=t5kyZBDAyYApHk+f9QWy94iC4b0jgwrPpFn8a7NQChoMGnby698p5cjk+RSLPTcsMd
 rzlQRzAxOzm/IJO4akRaKP+Bab1D/TKOTL6FIt4olB0akoTW4T6nLqYrb61f9hnKRb/x
 w34NpGL/iU9HWv7p5LePmSbcr772aXZ2Ev1fJygJ5VJjDA+XAq6Mx8yc1ZWI6CQ0yDOC
 jyJj7UKuE2VDCHqL/AvVW/Vw4Z+/l2oT8Zm+5KgUFainwG+U/m8ROvcuPMon4HtLn2ZI
 D/dwhbVw+z8PBPlg8fntBj9H/mwqR2pkEoOtW8/zdQg/9y5mN0QJGTHOdMVjAqWToGaQ
 g7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iT2+KNOnPvuJu2Lr0qN3HFjDh2VfGcLYrWgRqkL7cdA=;
 b=ei8qw2lbH/Ial01nHtfb9yYOEMgnnumfc7ykPteCn8fibcNeANghOFFIcg5k0tX/zx
 XpFeptGiZA7yDY0ncwg0GLQvip7g2Rl4w3s+QZxZLDZPpCrdYGqHM3yjJev8T7pW85Au
 b4LYaee4o6NroOrY3l6i/TuprfC2Kh0YbFJFH1uoYPUhifV2HWvAN+A0gWOMw5Ty8nQV
 5gYk2R/EDExRwHtELYjp+3dTyuPeRnVMcQVf7sHfFHeegvLcfAxe6h7bFqGR9ILbNHj9
 9vr5Iw11n/xL7Djw67sqo2ejYEBXYPCSsfU67r/RG7iseKvDZpOXsa5vXEBk+runAvBb
 7mQA==
X-Gm-Message-State: ANhLgQ2hoyG/AWlbCSQpuxPZ5qjguqPmokFSd6bNhAJ0iS63ZaZm459Q
 4vYX8OL9dMVw+smDkbJ7+PhDyw7BBPajLA==
X-Google-Smtp-Source: ADFU+vvTPlqwBNWO/a+lsDYZQ0GBQFiR0IIhu2LJpX3tYupNr01cBcNpRVwlYZq6Dmq991CzZL44Pg==
X-Received: by 2002:a37:b4c1:: with SMTP id
 d184mr10463385qkf.452.1585251552486; 
 Thu, 26 Mar 2020 12:39:12 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:39:11 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 71/74] cpu: protect CPU state with cpu->lock instead of the
 BQL
Date: Thu, 26 Mar 2020 15:31:53 -0400
Message-Id: <20200326193156.4322-72-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Use the per-CPU locks to protect the CPUs' state, instead of
using the BQL. These locks are uncontended (they are mostly
acquired by the corresponding vCPU thread), so acquiring them
is cheaper than acquiring the BQL, which particularly in
MTTCG can be contended at high core counts.

In this conversion we drop qemu_cpu_cond and qemu_pause_cond,
and use cpu->cond instead.

In qom/cpu.c we can finally remove the ugliness that
results from having to hold both the BQL and the CPU lock;
now we just have to grab the CPU lock.

Removed g_assert(qemu_mutex_iothread_locked())
from qemu_tcg_rr_all_cpu_threads_idle().  There is an existing
case where we call qemu_tcg_rr_all_cpu_threads_idle() without
the BQL held.

Also changed qemu_cond_wait() to qemu_cond_timed_wait()
in qemu_tcg_rr_cpu_thread_fn() to fix issue where we might
miss the broadcast wakeup.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
[RF: Adjusted assert and changed to use timed_wait]
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 cpus.c                | 288 +++++++++++++++++++++++++++++++-----------
 hw/core/cpu.c         |  29 +----
 include/hw/core/cpu.h |  20 +--
 3 files changed, 232 insertions(+), 105 deletions(-)

diff --git a/cpus.c b/cpus.c
index 05de56bd53..92cd49439a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -202,24 +202,30 @@ void cpu_mutex_destroy(CPUState *cpu)
     }
 }
 
-bool cpu_is_stopped(CPUState *cpu)
+/* Called with the CPU's lock held */
+static bool cpu_is_stopped_locked(CPUState *cpu)
 {
     return cpu->stopped || !runstate_is_running();
 }
 
-static inline bool cpu_work_list_empty(CPUState *cpu)
+bool cpu_is_stopped(CPUState *cpu)
 {
-    bool ret;
+    if (!cpu_mutex_locked(cpu)) {
+        bool ret;
 
-    cpu_mutex_lock(cpu);
-    ret = QSIMPLEQ_EMPTY(&cpu->work_list);
-    cpu_mutex_unlock(cpu);
-    return ret;
+        cpu_mutex_lock(cpu);
+        ret = cpu_is_stopped_locked(cpu);
+        cpu_mutex_unlock(cpu);
+        return ret;
+    }
+    return cpu_is_stopped_locked(cpu);
 }
 
 static bool cpu_thread_is_idle(CPUState *cpu)
 {
-    if (cpu->stop || !cpu_work_list_empty(cpu)) {
+    g_assert(cpu_mutex_locked(cpu));
+
+    if (cpu->stop || !QSIMPLEQ_EMPTY(&cpu->work_list)) {
         return false;
     }
     if (cpu_is_stopped(cpu)) {
@@ -237,9 +243,16 @@ static bool qemu_tcg_rr_all_cpu_threads_idle(void)
     CPUState *cpu;
 
     g_assert(qemu_is_tcg_rr());
+    g_assert(no_cpu_mutex_locked());
 
     CPU_FOREACH(cpu) {
-        if (!cpu_thread_is_idle(cpu)) {
+        bool is_idle;
+
+        cpu_mutex_lock(cpu);
+        is_idle = cpu_thread_is_idle(cpu);
+        cpu_mutex_unlock(cpu);
+
+        if (!is_idle) {
             return false;
         }
     }
@@ -732,6 +745,8 @@ void qemu_start_warp_timer(void)
 
 static void qemu_account_warp_timer(void)
 {
+    g_assert(qemu_mutex_iothread_locked());
+
     if (!use_icount || !icount_sleep) {
         return;
     }
@@ -1061,6 +1076,7 @@ static void kick_tcg_thread(void *opaque)
 static void start_tcg_kick_timer(void)
 {
     assert(!mttcg_enabled);
+    g_assert(qemu_mutex_iothread_locked());
     if (!tcg_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
         tcg_kick_vcpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                            kick_tcg_thread, NULL);
@@ -1073,6 +1089,7 @@ static void start_tcg_kick_timer(void)
 static void stop_tcg_kick_timer(void)
 {
     assert(!mttcg_enabled);
+    g_assert(qemu_mutex_iothread_locked());
     if (tcg_kick_vcpu_timer && timer_pending(tcg_kick_vcpu_timer)) {
         timer_del(tcg_kick_vcpu_timer);
     }
@@ -1174,6 +1191,8 @@ int vm_shutdown(void)
 
 static bool cpu_can_run(CPUState *cpu)
 {
+    g_assert(cpu_mutex_locked(cpu));
+
     if (cpu->stop) {
         return false;
     }
@@ -1246,16 +1265,9 @@ static void qemu_init_sigbus(void)
 
 static QemuThread io_thread;
 
-/* cpu creation */
-static QemuCond qemu_cpu_cond;
-/* system init */
-static QemuCond qemu_pause_cond;
-
 void qemu_init_cpu_loop(void)
 {
     qemu_init_sigbus();
-    qemu_cond_init(&qemu_cpu_cond);
-    qemu_cond_init(&qemu_pause_cond);
     qemu_mutex_init(&qemu_global_mutex);
 
     qemu_thread_get_self(&io_thread);
@@ -1273,39 +1285,60 @@ static void qemu_tcg_destroy_vcpu(CPUState *cpu)
 {
 }
 
-static void qemu_cpu_stop(CPUState *cpu, bool exit)
+static void qemu_cpu_stop_locked(CPUState *cpu, bool exit)
 {
+    g_assert(cpu_mutex_locked(cpu));
     g_assert(qemu_cpu_is_self(cpu));
     cpu->stop = false;
     cpu->stopped = true;
     if (exit) {
         cpu_exit(cpu);
     }
-    qemu_cond_broadcast(&qemu_pause_cond);
+    qemu_cond_broadcast(&cpu->cond);
+}
+
+static void qemu_cpu_stop(CPUState *cpu, bool exit)
+{
+    cpu_mutex_lock(cpu);
+    qemu_cpu_stop_locked(cpu, exit);
+    cpu_mutex_unlock(cpu);
 }
 
 static void qemu_wait_io_event_common(CPUState *cpu)
 {
+    g_assert(cpu_mutex_locked(cpu));
+
     atomic_mb_set(&cpu->thread_kicked, false);
     if (cpu->stop) {
-        qemu_cpu_stop(cpu, false);
+        qemu_cpu_stop_locked(cpu, false);
     }
+    /*
+     * unlock+lock cpu_mutex, so that other vCPUs have a chance to grab the
+     * lock and queue some work for this vCPU.
+     */
+    cpu_mutex_unlock(cpu);
     process_queued_cpu_work(cpu);
+    cpu_mutex_lock(cpu);
 }
 
 static void qemu_tcg_rr_wait_io_event(void)
 {
     CPUState *cpu;
 
+    g_assert(qemu_mutex_iothread_locked());
+    g_assert(no_cpu_mutex_locked());
+
     while (qemu_tcg_rr_all_cpu_threads_idle()) {
         stop_tcg_kick_timer();
-        qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
+        qemu_cond_wait(first_cpu->halt_cond, first_cpu->lock);
     }
 
     start_tcg_kick_timer();
 
     CPU_FOREACH(cpu) {
+        cpu_mutex_lock(cpu);
         qemu_wait_io_event_common(cpu);
+        cpu_mutex_unlock(cpu);
     }
 }
 
@@ -1313,12 +1346,15 @@ static void qemu_wait_io_event(CPUState *cpu)
 {
     bool slept = false;
 
+    g_assert(cpu_mutex_locked(cpu));
+    g_assert(!qemu_mutex_iothread_locked());
+
     while (cpu_thread_is_idle(cpu)) {
         if (!slept) {
             slept = true;
             qemu_plugin_vcpu_idle_cb(cpu);
         }
-        qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+        qemu_cond_wait(cpu->halt_cond, cpu->lock);
     }
     if (slept) {
         qemu_plugin_vcpu_resume_cb(cpu);
@@ -1341,6 +1377,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     rcu_register_thread();
 
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
     cpu->can_do_io = 1;
@@ -1353,15 +1390,21 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
     }
 
     kvm_init_cpu_signals(cpu);
+    qemu_mutex_unlock_iothread();
 
     /* signal CPU creation */
     cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
         if (cpu_can_run(cpu)) {
+            cpu_mutex_unlock(cpu);
+            qemu_mutex_lock_iothread();
             r = kvm_cpu_exec(cpu);
+            qemu_mutex_unlock_iothread();
+            cpu_mutex_lock(cpu);
+
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
@@ -1369,10 +1412,16 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
+    cpu_mutex_unlock(cpu);
+    qemu_mutex_lock_iothread();
     qemu_kvm_destroy_vcpu(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
     qemu_mutex_unlock_iothread();
+
+    cpu_mutex_lock(cpu);
+    cpu->created = false;
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
+
     rcu_unregister_thread();
     return NULL;
 }
@@ -1389,7 +1438,7 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
 
     rcu_register_thread();
 
-    qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
     cpu->can_do_io = 1;
@@ -1400,11 +1449,11 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
 
     /* signal CPU creation */
     cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
-        qemu_mutex_unlock_iothread();
+        cpu_mutex_unlock(cpu);
         do {
             int sig;
             r = sigwait(&waitset, &sig);
@@ -1413,11 +1462,11 @@ static void *qemu_dummy_cpu_thread_fn(void *arg)
             perror("sigwait");
             exit(1);
         }
-        qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cpu);
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug);
 
-    qemu_mutex_unlock_iothread();
+    cpu_mutex_unlock(cpu);
     rcu_unregister_thread();
     return NULL;
 #endif
@@ -1457,6 +1506,8 @@ static int64_t tcg_get_icount_limit(void)
 static void handle_icount_deadline(void)
 {
     assert(qemu_in_vcpu_thread());
+    g_assert(qemu_mutex_iothread_locked());
+
     if (use_icount) {
         int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
                                                       QEMU_TIMER_ATTR_ALL);
@@ -1537,12 +1588,15 @@ static void deal_with_unplugged_cpus(void)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
+        cpu_mutex_lock(cpu);
         if (cpu->unplug && !cpu_can_run(cpu)) {
             qemu_tcg_destroy_vcpu(cpu);
             cpu->created = false;
-            qemu_cond_signal(&qemu_cpu_cond);
+            qemu_cond_signal(&cpu->cond);
+            cpu_mutex_unlock(cpu);
             break;
         }
+        cpu_mutex_unlock(cpu);
     }
 }
 
@@ -1563,25 +1617,45 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
     rcu_register_thread();
     tcg_register_thread();
 
+    /*
+     * We call cpu_mutex_lock/unlock just to please the assertions in common
+     * code, since here cpu->lock is an alias to the BQL.
+     */
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
-
     cpu->thread_id = qemu_get_thread_id();
     cpu->created = true;
     cpu->can_do_io = 1;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     /* wait for initial kick-off after machine start */
+    cpu_mutex_lock(first_cpu);
     while (first_cpu->stopped) {
-        qemu_cond_wait(first_cpu->halt_cond, &qemu_global_mutex);
+        /*
+         * a timedwait is needed since this gets kicked off
+         * by a cond_broadcast, and it is possible
+         * to not be woken up by the broadcast if we are
+         * not waiting when the broadcast is sent.
+         */
+        qemu_cond_timedwait(first_cpu->halt_cond,
+                            first_cpu->lock,
+                            100);
+        cpu_mutex_unlock(first_cpu);
 
         /* process any pending work */
         CPU_FOREACH(cpu) {
             current_cpu = cpu;
+            cpu_mutex_lock(cpu);
             qemu_wait_io_event_common(cpu);
+            cpu_mutex_unlock(cpu);
         }
+
+        cpu_mutex_lock(first_cpu);
     }
+    cpu_mutex_unlock(first_cpu);
 
     start_tcg_kick_timer();
 
@@ -1608,7 +1682,12 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             cpu = first_cpu;
         }
 
-        while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
+        while (cpu) {
+            cpu_mutex_lock(cpu);
+            if (!QSIMPLEQ_EMPTY(&cpu->work_list) || cpu->exit_request) {
+                cpu_mutex_unlock(cpu);
+                break;
+            }
 
             atomic_mb_set(&tcg_current_rr_cpu, cpu);
             current_cpu = cpu;
@@ -1619,6 +1698,7 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             if (cpu_can_run(cpu)) {
                 int r;
 
+                cpu_mutex_unlock(cpu);
                 qemu_mutex_unlock_iothread();
                 prepare_icount_for_run(cpu);
 
@@ -1626,11 +1706,14 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
 
                 process_icount_data(cpu);
                 qemu_mutex_lock_iothread();
+                cpu_mutex_lock(cpu);
 
                 if (r == EXCP_DEBUG) {
                     cpu_handle_guest_debug(cpu);
+                    cpu_mutex_unlock(cpu);
                     break;
                 } else if (r == EXCP_ATOMIC) {
+                    cpu_mutex_unlock(cpu);
                     qemu_mutex_unlock_iothread();
                     cpu_exec_step_atomic(cpu);
                     qemu_mutex_lock_iothread();
@@ -1640,11 +1723,15 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
                 if (cpu->unplug) {
                     cpu = CPU_NEXT(cpu);
                 }
+                cpu_mutex_unlock(current_cpu);
                 break;
             }
 
+            cpu_mutex_unlock(cpu);
             cpu = CPU_NEXT(cpu);
-        } /* while (cpu && !cpu->exit_request).. */
+        } /* for (;;) .. */
+
+        g_assert(no_cpu_mutex_locked());
 
         /* Does not need atomic_mb_set because a spurious wakeup is okay.  */
         atomic_set(&tcg_current_rr_cpu, NULL);
@@ -1676,6 +1763,7 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
 
     rcu_register_thread();
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
@@ -1683,12 +1771,18 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
     current_cpu = cpu;
 
     hax_init_vcpu(cpu);
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_mutex_unlock_iothread();
+    qemu_cond_signal(&cpu->cond);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
         if (cpu_can_run(cpu)) {
+            cpu_mutex_unlock(cpu);
+            qemu_mutex_lock_iothread();
             r = hax_smp_cpu_exec(cpu);
+            qemu_mutex_unlock_iothread();
+            cpu_mutex_lock(cpu);
+
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
@@ -1696,6 +1790,8 @@ static void *qemu_hax_cpu_thread_fn(void *arg)
 
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
+
+    cpu_mutex_unlock(cpu);
     rcu_unregister_thread();
     return NULL;
 }
@@ -1713,6 +1809,7 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     rcu_register_thread();
 
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
@@ -1720,15 +1817,21 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
     current_cpu = cpu;
 
     hvf_init_vcpu(cpu);
+    qemu_mutex_unlock_iothread();
 
     /* signal CPU creation */
     cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
         if (cpu_can_run(cpu)) {
+            cpu_mutex_unlock(cpu);
+            qemu_mutex_lock_iothread();
             r = hvf_vcpu_exec(cpu);
+            qemu_mutex_unlock_iothread();
+            cpu_mutex_lock(cpu);
+
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
@@ -1736,10 +1839,16 @@ static void *qemu_hvf_cpu_thread_fn(void *arg)
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
+    cpu_mutex_unlock(cpu);
+    qemu_mutex_lock_iothread();
     hvf_vcpu_destroy(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
     qemu_mutex_unlock_iothread();
+
+    cpu_mutex_lock(cpu);
+    cpu->created = false;
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
+
     rcu_unregister_thread();
     return NULL;
 }
@@ -1752,6 +1861,7 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
     rcu_register_thread();
 
     qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
     current_cpu = cpu;
@@ -1761,29 +1871,41 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
         fprintf(stderr, "whpx_init_vcpu failed: %s\n", strerror(-r));
         exit(1);
     }
+    qemu_mutex_unlock_iothread();
 
     /* signal CPU creation */
     cpu->created = true;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     do {
         if (cpu_can_run(cpu)) {
+            cpu_mutex_unlock(cpu);
+            qemu_mutex_lock_iothread();
             r = whpx_vcpu_exec(cpu);
+            qemu_mutex_unlock_iothread();
+            cpu_mutex_lock(cpu);
+
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
         }
         while (cpu_thread_is_idle(cpu)) {
-            qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
+            qemu_cond_wait(cpu->halt_cond, cpu->lock);
         }
         qemu_wait_io_event_common(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
+    cpu_mutex_unlock(cpu);
+    qemu_mutex_lock_iothread();
     whpx_destroy_vcpu(cpu);
-    cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
     qemu_mutex_unlock_iothread();
+
+    cpu_mutex_lock(cpu);
+    cpu->created = false;
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
+
     rcu_unregister_thread();
     return NULL;
 }
@@ -1811,14 +1933,14 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     rcu_register_thread();
     tcg_register_thread();
 
-    qemu_mutex_lock_iothread();
+    cpu_mutex_lock(cpu);
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
     cpu->created = true;
     cpu->can_do_io = 1;
     current_cpu = cpu;
-    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_cond_signal(&cpu->cond);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     /* process any pending work */
@@ -1827,9 +1949,9 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     do {
         if (cpu_can_run(cpu)) {
             int r;
-            qemu_mutex_unlock_iothread();
+            cpu_mutex_unlock(cpu);
             r = tcg_cpu_exec(cpu);
-            qemu_mutex_lock_iothread();
+            cpu_mutex_lock(cpu);
             switch (r) {
             case EXCP_DEBUG:
                 cpu_handle_guest_debug(cpu);
@@ -1845,9 +1967,9 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
                 g_assert(cpu_halted(cpu));
                 break;
             case EXCP_ATOMIC:
-                qemu_mutex_unlock_iothread();
+                cpu_mutex_unlock(cpu);
                 cpu_exec_step_atomic(cpu);
-                qemu_mutex_lock_iothread();
+                cpu_mutex_lock(cpu);
             default:
                 /* Ignore everything else? */
                 break;
@@ -1860,8 +1982,8 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
 
     qemu_tcg_destroy_vcpu(cpu);
     cpu->created = false;
-    qemu_cond_signal(&qemu_cpu_cond);
-    qemu_mutex_unlock_iothread();
+    qemu_cond_signal(&cpu->cond);
+    cpu_mutex_unlock(cpu);
     rcu_unregister_thread();
     return NULL;
 }
@@ -1968,54 +2090,69 @@ void qemu_cond_wait_iothread(QemuCond *cond)
     qemu_cond_wait(cond, &qemu_global_mutex);
 }
 
-static bool all_vcpus_paused(void)
-{
-    CPUState *cpu;
-
-    CPU_FOREACH(cpu) {
-        if (!cpu->stopped) {
-            return false;
-        }
-    }
-
-    return true;
-}
-
 void pause_all_vcpus(void)
 {
     CPUState *cpu;
 
+    g_assert(no_cpu_mutex_locked());
+
     qemu_clock_enable(QEMU_CLOCK_VIRTUAL, false);
     CPU_FOREACH(cpu) {
+        cpu_mutex_lock(cpu);
         if (qemu_cpu_is_self(cpu)) {
             qemu_cpu_stop(cpu, true);
         } else {
             cpu->stop = true;
             qemu_cpu_kick(cpu);
         }
+        cpu_mutex_unlock(cpu);
     }
 
+ drop_locks_and_stop_all_vcpus:
     /* We need to drop the replay_lock so any vCPU threads woken up
      * can finish their replay tasks
      */
     replay_mutex_unlock();
+    qemu_mutex_unlock_iothread();
 
-    while (!all_vcpus_paused()) {
-        qemu_cond_wait(&qemu_pause_cond, &qemu_global_mutex);
-        CPU_FOREACH(cpu) {
+    CPU_FOREACH(cpu) {
+        cpu_mutex_lock(cpu);
+        if (!cpu->stopped) {
+            cpu->stop = true;
             qemu_cpu_kick(cpu);
+            qemu_cond_wait(&cpu->cond, cpu->lock);
         }
+        cpu_mutex_unlock(cpu);
     }
 
-    qemu_mutex_unlock_iothread();
     replay_mutex_lock();
     qemu_mutex_lock_iothread();
+
+    /* a CPU might have been hot-plugged while we weren't holding the BQL */
+    CPU_FOREACH(cpu) {
+        bool stopped;
+
+        cpu_mutex_lock(cpu);
+        stopped = cpu->stopped;
+        cpu_mutex_unlock(cpu);
+
+        if (!stopped) {
+            goto drop_locks_and_stop_all_vcpus;
+        }
+    }
 }
 
 void cpu_resume(CPUState *cpu)
 {
-    cpu->stop = false;
-    cpu->stopped = false;
+    if (cpu_mutex_locked(cpu)) {
+        cpu->stop = false;
+        cpu->stopped = false;
+    } else {
+        cpu_mutex_lock(cpu);
+        cpu->stop = false;
+        cpu->stopped = false;
+        cpu_mutex_unlock(cpu);
+    }
     qemu_cpu_kick(cpu);
 }
 
@@ -2035,8 +2172,11 @@ void resume_all_vcpus(void)
 
 void cpu_remove_sync(CPUState *cpu)
 {
+    cpu_mutex_lock(cpu);
     cpu->stop = true;
     cpu->unplug = true;
+    cpu_mutex_unlock(cpu);
+
     qemu_cpu_kick(cpu);
     qemu_mutex_unlock_iothread();
     qemu_thread_join(cpu->thread);
@@ -2220,9 +2360,15 @@ void qemu_init_vcpu(CPUState *cpu)
         qemu_dummy_start_vcpu(cpu);
     }
 
+    qemu_mutex_unlock_iothread();
+
+    cpu_mutex_lock(cpu);
     while (!cpu->created) {
-        qemu_cond_wait(&qemu_cpu_cond, &qemu_global_mutex);
+        qemu_cond_wait(&cpu->cond, cpu->lock);
     }
+    cpu_mutex_unlock(cpu);
+
+    qemu_mutex_lock_iothread();
 }
 
 void cpu_stop_current(void)
diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 16caa6c589..df31fc8123 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -95,32 +95,13 @@ static void cpu_common_get_memory_mapping(CPUState *cpu,
     error_setg(errp, "Obtaining memory mappings is unsupported on this CPU.");
 }
 
-/* Resetting the IRQ comes from across the code base so we take the
- * BQL here if we need to.  cpu_interrupt assumes it is held.*/
 void cpu_reset_interrupt(CPUState *cpu, int mask)
 {
-    bool has_bql = qemu_mutex_iothread_locked();
-    bool has_cpu_lock = cpu_mutex_locked(cpu);
-
-    if (has_bql) {
-        if (has_cpu_lock) {
-            atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
-        } else {
-            cpu_mutex_lock(cpu);
-            atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
-            cpu_mutex_unlock(cpu);
-        }
-        return;
-    }
-
-    if (has_cpu_lock) {
-        cpu_mutex_unlock(cpu);
-    }
-    qemu_mutex_lock_iothread();
-    cpu_mutex_lock(cpu);
-    atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
-    qemu_mutex_unlock_iothread();
-    if (!has_cpu_lock) {
+    if (cpu_mutex_locked(cpu)) {
+        atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
+    } else {
+        cpu_mutex_lock(cpu);
+        atomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);
         cpu_mutex_unlock(cpu);
     }
 }
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e3527b6194..8f70249f45 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -312,10 +312,6 @@ struct qemu_work_item;
  * valid under cpu_list_lock.
  * @created: Indicates whether the CPU thread has been successfully created.
  * @interrupt_request: Indicates a pending interrupt request.
- * @halted: Nonzero if the CPU is in suspended state.
- * @stop: Indicates a pending stop request.
- * @stopped: Indicates the CPU has been artificially stopped.
- * @unplug: Indicates a pending CPU unplug request.
  * @crash_occurred: Indicates the OS reported a crash (panic) for this CPU
  * @singlestep_enabled: Flags for single-stepping.
  * @icount_extra: Instructions until next timer event.
@@ -340,6 +336,10 @@ struct qemu_work_item;
  *        after the BQL.
  * @cond: Condition variable for per-CPU events.
  * @work_list: List of pending asynchronous work.
+ * @halted: Nonzero if the CPU is in suspended state.
+ * @stop: Indicates a pending stop request.
+ * @stopped: Indicates the CPU has been artificially stopped.
+ * @unplug: Indicates a pending CPU unplug request.
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
  *                        to @trace_dstate).
  * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask).
@@ -364,12 +364,7 @@ struct CPUState {
 #endif
     int thread_id;
     bool running, has_waiter;
-    struct QemuCond *halt_cond;
     bool thread_kicked;
-    bool created;
-    bool stop;
-    bool stopped;
-    bool unplug;
     bool crash_occurred;
     bool exit_request;
     bool in_exclusive_context;
@@ -385,7 +380,13 @@ struct CPUState {
     QemuMutex *lock;
     /* fields below protected by @lock */
     QemuCond cond;
+    QemuCond *halt_cond;
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
+    uint32_t halted;
+    bool created;
+    bool stop;
+    bool stopped;
+    bool unplug;
 
     CPUAddressSpace *cpu_ases;
     int num_ases;
@@ -431,7 +432,6 @@ struct CPUState {
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
     int cluster_index;
-    uint32_t halted;
     uint32_t can_do_io;
     int32_t exception_index;
 
-- 
2.17.1


