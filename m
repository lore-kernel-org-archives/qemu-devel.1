Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78155C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B3BA2078E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B3BA2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5VHX-0008Ll-Ed
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlmgr@proulx.com>) id 1k5VFQ-0006T2-5m
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:27:28 -0400
Received: from havoc.proulx.com ([96.88.95.61]:47902)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlmgr@proulx.com>) id 1k5VFO-0002tM-9g
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:27:27 -0400
Received: by havoc.proulx.com (Postfix, from userid 1027)
 id EA001645; Tue, 11 Aug 2020 08:27:24 -0600 (MDT)
Resent-From: Mailing List Manager <mlmgr@proulx.com>
Resent-Date: Tue, 11 Aug 2020 08:27:24 -0600
Resent-Message-ID: <20200811142724.t56al7kqje7muulg@havoc.proulx.com>
Resent-To: qemu-devel@nongnu.org
Received: from eggs.gnu.org ([2001:470:142:3::10]:43920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@rugged.localdomain>)
 id 1k5TrT-0005I4-58
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 08:58:39 -0400
Received: from 89-79-191-25.dynamic.chello.pl ([89.79.191.25]:63219
 helo=rugged.localdomain) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kamil@rugged.localdomain>) id 1k5TrP-0000Ia-OT
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 08:58:38 -0400
Received: by rugged.localdomain (Postfix, from userid 1000)
 id 0D7D6970C1; Tue, 11 Aug 2020 12:47:45 +0000 (UTC)
From: Kamil Rytarowski <n54@gmx.com>
To: rth@twiddle.net, ehabkost@redhat.com, slp@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@redhat.com, max@m00nbsd.net,
 jmcneill@invisible.ca
Subject: [PATCH v5 4/4] Add the NVMM acceleration enlightenments
Date: Tue, 11 Aug 2020 14:47:34 +0200
Message-Id: <20200811124734.17222-4-n54@gmx.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200811124734.17222-1-n54@gmx.com>
References: <20200206213232.1918-2-n54@gmx.com>
 <20200811124734.17222-1-n54@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=89.79.191.25;
 envelope-from=kamil@rugged.localdomain; helo=rugged.localdomain
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 08:50:12
X-ACL-Warn: Detected OS   = ???
X-Spam_action: reject
X-Bogosity: Spam, tests=bogofilter, spamicity=1.000000, version=1.2.4
X-CRM114-Status: UNSURE (   0.69  )
Received-SPF: pass client-ip=96.88.95.61; envelope-from=mlmgr@proulx.com;
 helo=havoc.proulx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:23:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 HK_RANDOM_ENVFROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxime Villard <max@m00nbsd.net>

Implements the NVMM accelerator cpu enlightenments to actually use the nvmm-all
accelerator on NetBSD platforms.

Signed-off-by: Maxime Villard <max@m00nbsd.net>
Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Jared McNeill <jmcneill@invisible.ca>
---
 include/sysemu/hw_accel.h | 14 ++++++++++
 softmmu/cpus.c            | 58 +++++++++++++++++++++++++++++++++++++++
 target/i386/helper.c      |  2 +-
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index e128f8b06b..9e19f5794c 100644
--- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -16,6 +16,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
+#include "sysemu/nvmm.h"
 
 static inline void cpu_synchronize_state(CPUState *cpu)
 {
@@ -31,6 +32,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_state(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_state(cpu);
+    }
 }
 
 static inline void cpu_synchronize_post_reset(CPUState *cpu)
@@ -47,6 +51,10 @@ static inline void cpu_synchronize_post_reset(CPUState *cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_post_reset(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_post_reset(cpu);
+    }
+
 }
 
 static inline void cpu_synchronize_post_init(CPUState *cpu)
@@ -63,6 +71,9 @@ static inline void cpu_synchronize_post_init(CPUState *cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_post_init(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_post_init(cpu);
+    }
 }
 
 static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
@@ -79,6 +90,9 @@ static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
     if (whpx_enabled()) {
         whpx_cpu_synchronize_pre_loadvm(cpu);
     }
+    if (nvmm_enabled()) {
+        nvmm_cpu_synchronize_pre_loadvm(cpu);
+    }
 }
 
 #endif /* QEMU_HW_ACCEL_H */
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index a802e899ab..3b44b92830 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -43,6 +43,7 @@
 #include "sysemu/hax.h"
 #include "sysemu/hvf.h"
 #include "sysemu/whpx.h"
+#include "sysemu/nvmm.h"
 #include "exec/exec-all.h"
 
 #include "qemu/thread.h"
@@ -1621,6 +1622,48 @@ static void *qemu_whpx_cpu_thread_fn(void *arg)
     return NULL;
 }
 
+static void *qemu_nvmm_cpu_thread_fn(void *arg)
+{
+    CPUState *cpu = arg;
+    int r;
+
+    assert(nvmm_enabled());
+
+    rcu_register_thread();
+
+    qemu_mutex_lock_iothread();
+    qemu_thread_get_self(cpu->thread);
+    cpu->thread_id = qemu_get_thread_id();
+    current_cpu = cpu;
+
+    r = nvmm_init_vcpu(cpu);
+    if (r < 0) {
+        fprintf(stderr, "nvmm_init_vcpu failed: %s\n", strerror(-r));
+        exit(1);
+    }
+
+    /* signal CPU creation */
+    cpu->created = true;
+    qemu_cond_signal(&qemu_cpu_cond);
+
+    do {
+        if (cpu_can_run(cpu)) {
+            r = nvmm_vcpu_exec(cpu);
+            if (r == EXCP_DEBUG) {
+                cpu_handle_guest_debug(cpu);
+            }
+        }
+        qemu_wait_io_event(cpu);
+    } while (!cpu->unplug || cpu_can_run(cpu));
+
+    nvmm_destroy_vcpu(cpu);
+    cpu->created = false;
+    qemu_cond_signal(&qemu_cpu_cond);
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
+    return NULL;
+}
+
 #ifdef _WIN32
 static void CALLBACK dummy_apc_func(ULONG_PTR unused)
 {
@@ -1998,6 +2041,19 @@ static void qemu_whpx_start_vcpu(CPUState *cpu)
 #endif
 }
 
+static void qemu_nvmm_start_vcpu(CPUState *cpu)
+{
+    char thread_name[VCPU_THREAD_NAME_SIZE];
+
+    cpu->thread = g_malloc0(sizeof(QemuThread));
+    cpu->halt_cond = g_malloc0(sizeof(QemuCond));
+    qemu_cond_init(cpu->halt_cond);
+    snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/NVMM",
+             cpu->cpu_index);
+    qemu_thread_create(cpu->thread, thread_name, qemu_nvmm_cpu_thread_fn,
+                       cpu, QEMU_THREAD_JOINABLE);
+}
+
 static void qemu_dummy_start_vcpu(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
@@ -2038,6 +2094,8 @@ void qemu_init_vcpu(CPUState *cpu)
         qemu_tcg_init_vcpu(cpu);
     } else if (whpx_enabled()) {
         qemu_whpx_start_vcpu(cpu);
+    } else if (nvmm_enabled()) {
+        qemu_nvmm_start_vcpu(cpu);
     } else {
         qemu_dummy_start_vcpu(cpu);
     }
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 70be53e2c3..c2f1aef65c 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -983,7 +983,7 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access)
     X86CPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
 
-    if (kvm_enabled() || whpx_enabled()) {
+    if (kvm_enabled() || whpx_enabled() || nvmm_enabled()) {
         env->tpr_access_type = access;
 
         cpu_interrupt(cs, CPU_INTERRUPT_TPR);
-- 
2.24.1



