Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A991C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CB020878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CB020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSbLZ-0001SC-0j
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 03:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSbKg-00008T-52
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:36:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:50808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSbKX-0006i0-M4
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:36:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C60FFB1F0;
 Wed, 14 Oct 2020 07:36:07 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC v1 2/2] accel/tcg: split tcg_start_vcpu_thread
Date: Wed, 14 Oct 2020 09:36:05 +0200
Message-Id: <20201014073605.6155-3-cfontana@suse.de>
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

after the initial split into 3 tcg variants, we proceed to also
split tcg_start_vcpu_thread.

We actually split it in 2 this time, since the icount variant
just uses the round robin function.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 accel/tcg/tcg-all.c         |  5 ++++
 accel/tcg/tcg-cpus-icount.c |  2 +-
 accel/tcg/tcg-cpus-mttcg.c  | 26 ++++++++++++++++-
 accel/tcg/tcg-cpus-rr.c     | 37 +++++++++++++++++++++++-
 accel/tcg/tcg-cpus-rr.h     |  3 ++
 accel/tcg/tcg-cpus.c        | 56 -------------------------------------
 6 files changed, 70 insertions(+), 59 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index e42a028043..1ac0b76515 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -105,6 +105,11 @@ static int tcg_init(MachineState *ms)
     tcg_exec_init(s->tb_size * 1024 * 1024);
     mttcg_enabled = s->mttcg_enabled;
 
+    /*
+     * Initialize TCG regions
+     */
+    tcg_region_init();
+
     if (mttcg_enabled) {
         cpus_register_accel(&tcg_cpus_mttcg);
     } else if (icount_enabled()) {
diff --git a/accel/tcg/tcg-cpus-icount.c b/accel/tcg/tcg-cpus-icount.c
index 43505e8f1f..8859e384d7 100644
--- a/accel/tcg/tcg-cpus-icount.c
+++ b/accel/tcg/tcg-cpus-icount.c
@@ -136,7 +136,7 @@ static void icount_handle_interrupt(CPUState *cpu, int mask)
 }
 
 const CpusAccel tcg_cpus_icount = {
-    .create_vcpu_thread = tcg_start_vcpu_thread,
+    .create_vcpu_thread = rr_start_vcpu_thread,
     .kick_vcpu_thread = qemu_cpu_kick_rr_cpus,
 
     .handle_interrupt = icount_handle_interrupt,
diff --git a/accel/tcg/tcg-cpus-mttcg.c b/accel/tcg/tcg-cpus-mttcg.c
index 2f5317d767..1f34bbb625 100644
--- a/accel/tcg/tcg-cpus-mttcg.c
+++ b/accel/tcg/tcg-cpus-mttcg.c
@@ -110,8 +110,32 @@ static void mttcg_kick_vcpu_thread(CPUState *cpu)
     cpu_exit(cpu);
 }
 
+static void mttcg_start_vcpu_thread(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    g_assert(tcg_enabled());
+
+    parallel_cpus = (current_machine->smp.max_cpus > 1);
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+
+    /* create a thread per vCPU with TCG (MTTCG) */
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
+             cpu->cpu_index);
+
+    qemu_thread_create(cpu->thread, thread_name, tcg_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+
+#ifdef _WIN32
+    cpu->hThread = qemu_thread_get_handle(cpu->thread);
+#endif
+}
+
 const CpusAccel tcg_cpus_mttcg = {
-    .create_vcpu_thread = tcg_start_vcpu_thread,
+    .create_vcpu_thread = mttcg_start_vcpu_thread,
     .kick_vcpu_thread = mttcg_kick_vcpu_thread,
 
     .handle_interrupt = tcg_handle_interrupt,
diff --git a/accel/tcg/tcg-cpus-rr.c b/accel/tcg/tcg-cpus-rr.c
index b8fd33d9d3..d3a1d8d626 100644
--- a/accel/tcg/tcg-cpus-rr.c
+++ b/accel/tcg/tcg-cpus-rr.c
@@ -262,8 +262,43 @@ void *tcg_rr_cpu_thread_fn(void *arg)
     return NULL;
 }
 
+void rr_start_vcpu_thread(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+    static QemuCond *single_tcg_halt_cond;
+    static QemuThread *single_tcg_cpu_thread;
+
+    g_assert(tcg_enabled());
+    parallel_cpus = false;
+
+    if (!single_tcg_cpu_thread) {
+        cpu->thread = g_malloc0(sizeof(QemuThread));
+        cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+        qemu_cond_init(cpu->halt_cond);
+
+        /* share a single thread for all cpus with TCG */
+        snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
+        qemu_thread_create(cpu->thread, thread_name,
+                           tcg_rr_cpu_thread_fn,
+                           cpu, QEMU_THREAD_JOINABLE);
+
+        single_tcg_halt_cond = cpu->halt_cond;
+        single_tcg_cpu_thread = cpu->thread;
+#ifdef _WIN32
+        cpu->hThread = qemu_thread_get_handle(cpu->thread);
+#endif
+    } else {
+        /* we share the thread */
+        cpu->thread = single_tcg_cpu_thread;
+        cpu->halt_cond = single_tcg_halt_cond;
+        cpu->thread_id = first_cpu->thread_id;
+        cpu->can_do_io = 1;
+        cpu->created = true;
+    }
+}
+
 const CpusAccel tcg_cpus_rr = {
-    .create_vcpu_thread = tcg_start_vcpu_thread,
+    .create_vcpu_thread = rr_start_vcpu_thread,
     .kick_vcpu_thread = qemu_cpu_kick_rr_cpus,
 
     .handle_interrupt = tcg_handle_interrupt,
diff --git a/accel/tcg/tcg-cpus-rr.h b/accel/tcg/tcg-cpus-rr.h
index 155510cfd4..94dc85c1c5 100644
--- a/accel/tcg/tcg-cpus-rr.h
+++ b/accel/tcg/tcg-cpus-rr.h
@@ -17,6 +17,9 @@ extern const CpusAccel tcg_cpus_rr;
 /* Kick all RR vCPUs. */
 void qemu_cpu_kick_rr_cpus(CPUState *unused);
 
+/* start the round robin vcpu thread */
+void rr_start_vcpu_thread(CPUState *cpu);
+
 /* Single-threaded TCG */
 void *tcg_rr_cpu_thread_fn(void *arg);
 
diff --git a/accel/tcg/tcg-cpus.c b/accel/tcg/tcg-cpus.c
index e518cc7ed4..3d2bb7a76a 100644
--- a/accel/tcg/tcg-cpus.c
+++ b/accel/tcg/tcg-cpus.c
@@ -36,62 +36,6 @@
 
 /* common functionality among all TCG variants */
 
-void tcg_start_vcpu_thread(CPUState *cpu)
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
-        parallel_cpus = qemu_tcg_mttcg_enabled() && current_machine->smp.max_cpus > 1;
-    }
-
-    if (qemu_tcg_mttcg_enabled() || !single_tcg_cpu_thread) {
-        cpu->thread = g_malloc0(sizeof(QemuThread));
-        cpu->halt_cond = g_malloc0(sizeof(QemuCond));
-        qemu_cond_init(cpu->halt_cond);
-
-        if (qemu_tcg_mttcg_enabled()) {
-            /* create a thread per vCPU with TCG (MTTCG) */
-            snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/TCG",
-                 cpu->cpu_index);
-
-            qemu_thread_create(cpu->thread, thread_name, tcg_cpu_thread_fn,
-                               cpu, QEMU_THREAD_JOINABLE);
-
-        } else {
-            /* share a single thread for all cpus with TCG */
-            snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "ALL CPUs/TCG");
-            qemu_thread_create(cpu->thread, thread_name,
-                               tcg_rr_cpu_thread_fn,
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
 void qemu_tcg_destroy_vcpu(CPUState *cpu)
 {
     cpu_thread_signal_destroyed(cpu);
-- 
2.26.2


