Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8F0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D9A20772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="rH3a77O5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D9A20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqy52-00046z-O3
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqy4M-0003Zo-A3
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:11:59 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:58872 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqy4J-0007yO-M3
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:11:57 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id B49B34C8BA;
 Thu,  2 Jul 2020 12:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-transfer-encoding:content-type:content-type:mime-version
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received:received; s=mta-01; t=1593691912; x=
 1595506313; bh=QJGG3Mova4p9pA0I2cdvpCgyiFNW6vjsFYBqOxu+XRA=; b=r
 H3a77O53Kmf0uz0cWLu8ZAafPtLmQN2XNzdS+yVYRFGE7gJN/FSlVt4NWC41tNEl
 Hq8S9aj4wXSZ91fn4hW0oZK5JznzYQh9q7tf39q2MDR1mrNvWneGeU1b5R3ScyK6
 9rzb7v6JpRuWULUepTP+p+iIlJmgFVOkAJ1n+jxOek=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fDMJUIAW0BQq; Thu,  2 Jul 2020 15:11:52 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 826EB4C8B8;
 Thu,  2 Jul 2020 15:11:49 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 2 Jul
 2020 15:11:49 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v3] i386: hvf: Implement CPU kick
Date: Thu, 2 Jul 2020 13:57:23 +0300
Message-ID: <20200702105721.75333-1-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 08:11:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Claudio Fontana <cfontana@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

HVF doesn't have a CPU kick and without it it's not possible to perform
an action on CPU thread until a VMEXIT happens. The kick is also needed
for timely interrupt delivery.

Existing implementation of CPU kick sends SIG_IPI (aka SIGUSR1) to vCPU
thread, but it's different from what hv_vcpu_interrupt does. The latter
one results in invocation of mp_cpus_kick() in XNU kernel [1].

mp_cpus_kick() sends an IPI through the host LAPIC to the HVF vCPU.
And the kick interrupt leads to VM exit because "external-interrupt
exiting” VM-execution control is enabled for HVF.

hv_vcpu_interrupt() would have no effect if it's delivered when vCPU is
outside of a guest, therefore to avoid kick loss it's complemented with
a SIG_IPI handler and zero VMX-preemption timer. If the kick happens
outside of hv_vcpu_run(), the signal handler will re-queue the kick by
enabling zero VMX-preemption timer for the next hv_vcpu_run().

There's still a small chance of kick loss, on user-to-kernel border
between atomic_mb_set's just before the entry to hv_vcpu_run and just
after it.

Also correct type of hvf_fd to the type of hv_vcpuid_t to avoid
compilation warnings.

1. https://opensource.apple.com/source/xnu/xnu-6153.81.5/osfmk/i386/mp.c

Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---

This is a rework of a kick patch in v2 of the series
(https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09899.html)
based on the comments from Paolo. Unfortunately the race is still there,
may be the race window is just a bit smaller.

Changes since v2:
 - Reworked workaround to minimize kick loss race. Use signals to
   interrupt vCPU thread outside of hv_vcpu_run() and turn-on/turn-off
   VMX-preemeption timer, while timer value is always zero. v3 also
   assumes that VMX-preemption timer control is always available on the
   hardware that supports HVF.

Changes since v1:
 - Reduced kick loss race (Paolo) and removed SIG_IPI blocking

 cpus.c                 | 13 +++++++----
 include/hw/core/cpu.h  |  2 +-
 include/sysemu/hvf.h   |  1 +
 target/i386/cpu.h      |  1 +
 target/i386/hvf/hvf.c  | 53 ++++++++++++++++++++++++++++++++++++++++--
 target/i386/hvf/vmcs.h |  1 +
 6 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/cpus.c b/cpus.c
index d94456ed29..6be42ff734 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1792,10 +1792,15 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
         return;
     }
     cpu->thread_kicked = true;
-    err = pthread_kill(cpu->thread->thread, SIG_IPI);
-    if (err && err != ESRCH) {
-        fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
-        exit(1);
+
+    if (hvf_enabled()) {
+        hvf_vcpu_kick(cpu);
+    } else {
+        err = pthread_kill(cpu->thread->thread, SIG_IPI);
+        if (err && err != ESRCH) {
+            fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
+            exit(1);
+        }
     }
 #else /* _WIN32 */
     if (!qemu_cpu_is_self(cpu)) {
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b3f4b79318..288a2bd57e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -438,7 +438,7 @@ struct CPUState {
 
     struct hax_vcpu_state *hax_vcpu;
 
-    int hvf_fd;
+    unsigned hvf_fd;
 
     /* track IOMMUs whose translations we've cached in the TCG TLB */
     GArray *iommu_notifiers;
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 6d3ee4fdb7..a1ab61403f 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -25,6 +25,7 @@ extern bool hvf_allowed;
 
 int hvf_init_vcpu(CPUState *);
 int hvf_vcpu_exec(CPUState *);
+void hvf_vcpu_kick(CPUState *);
 void hvf_cpu_synchronize_state(CPUState *);
 void hvf_cpu_synchronize_post_reset(CPUState *);
 void hvf_cpu_synchronize_post_init(CPUState *);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7d77efd9e4..727c550c82 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1602,6 +1602,7 @@ typedef struct CPUX86State {
     struct kvm_nested_state *nested_state;
 #endif
 #if defined(CONFIG_HVF)
+    bool hvf_in_guest;
     HVFX86LazyFlags hvf_lflags;
     void *hvf_mmio_buf;
 #endif
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index d81f569aed..6e9b212f37 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -73,6 +73,7 @@
 #include "target/i386/cpu.h"
 
 HVFState *hvf_state;
+pthread_key_t hvf_cpu;
 
 static void assert_hvf_ok(hv_return_t ret)
 {
@@ -458,8 +459,17 @@ void hvf_vcpu_destroy(CPUState *cpu)
     assert_hvf_ok(ret);
 }
 
-static void dummy_signal(int sig)
+static void hvf_handle_ipi(int sig)
 {
+    CPUState *cpu = pthread_getspecific(hvf_cpu);
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    if (!atomic_xchg(&env->hvf_in_guest, false)) {
+        wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
+              rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
+                | VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
+    }
 }
 
 int hvf_init_vcpu(CPUState *cpu)
@@ -474,16 +484,24 @@ int hvf_init_vcpu(CPUState *cpu)
     struct sigaction sigact;
 
     memset(&sigact, 0, sizeof(sigact));
-    sigact.sa_handler = dummy_signal;
+    sigact.sa_handler = hvf_handle_ipi;
     sigaction(SIG_IPI, &sigact, NULL);
 
+    r = pthread_setspecific(hvf_cpu, cpu);
+    if (r) {
+        fprintf(stderr, "qemu:%s: %s", __func__, strerror(r));
+        exit(1);
+    }
+
     pthread_sigmask(SIG_BLOCK, NULL, &set);
     sigdelset(&set, SIG_IPI);
+    pthread_sigmask(SIG_SETMASK, &set, NULL);
 
     init_emu();
     init_decoder();
 
     hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
+    env->hvf_in_guest = false;
     env->hvf_mmio_buf = g_new(char, 4096);
 
     r = hv_vcpu_create((hv_vcpuid_t *)&cpu->hvf_fd, HV_VCPU_DEFAULT);
@@ -529,6 +547,7 @@ int hvf_init_vcpu(CPUState *cpu)
     wvmcs(cpu->hvf_fd, VMCS_EXCEPTION_BITMAP, 0); /* Double fault */
 
     wvmcs(cpu->hvf_fd, VMCS_TPR_THRESHOLD, 0);
+    wvmcs(cpu->hvf_fd, VMCS_PREEMPTION_TIMER_VALUE, 0);
 
     x86cpu = X86_CPU(cpu);
     x86cpu->env.xsave_buf = qemu_memalign(4096, 4096);
@@ -631,7 +650,9 @@ int hvf_vcpu_exec(CPUState *cpu)
             return EXCP_HLT;
         }
 
+        atomic_mb_set(&env->hvf_in_guest, true);
         hv_return_t r  = hv_vcpu_run(cpu->hvf_fd);
+        atomic_mb_set(&env->hvf_in_guest, false);
         assert_hvf_ok(r);
 
         /* handle VMEXIT */
@@ -774,6 +795,10 @@ int hvf_vcpu_exec(CPUState *cpu)
             vmx_clear_nmi_window_exiting(cpu);
             ret = EXCP_INTERRUPT;
             break;
+        case EXIT_REASON_VMX_PREEMPT:
+            wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
+                  rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
+                    & ~VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
         case EXIT_REASON_EXT_INTR:
             /* force exit and allow io handling */
             ret = EXCP_INTERRUPT;
@@ -872,6 +897,22 @@ int hvf_vcpu_exec(CPUState *cpu)
     return ret;
 }
 
+void hvf_vcpu_kick(CPUState *cpu)
+{
+    hv_return_t err;
+
+    err = pthread_kill(cpu->thread->thread, SIG_IPI);
+    if (err) {
+        fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
+        exit(1);
+    }
+    err = hv_vcpu_interrupt(&cpu->hvf_fd, 1);
+    if (err) {
+        fprintf(stderr, "qemu:%s error %#x\n", __func__, err);
+        exit(1);
+    }
+}
+
 bool hvf_allowed;
 
 static int hvf_accel_init(MachineState *ms)
@@ -880,6 +921,14 @@ static int hvf_accel_init(MachineState *ms)
     hv_return_t ret;
     HVFState *s;
 
+    /* TODO add pthread_key_delete() */
+    ret = pthread_key_create(&hvf_cpu, NULL);
+    if (ret) {
+        fprintf(stderr, "qemu:%s: %s", __func__, strerror(ret));
+        exit(1);
+    }
+
+    /* TODO add hv_vm_unmap() and hv_vm_destroy() */
     ret = hv_vm_create(HV_VM_DEFAULT);
     assert_hvf_ok(ret);
 
diff --git a/target/i386/hvf/vmcs.h b/target/i386/hvf/vmcs.h
index 42de7ebc3a..6615365023 100644
--- a/target/i386/hvf/vmcs.h
+++ b/target/i386/hvf/vmcs.h
@@ -349,6 +349,7 @@
 #define VMCS_PIN_BASED_CTLS_EXTINT            (1 << 0)
 #define VMCS_PIN_BASED_CTLS_NMI               (1 << 3)
 #define VMCS_PIN_BASED_CTLS_VNMI              (1 << 5)
+#define VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER (1 << 6)
 
 #define VMCS_PRI_PROC_BASED_CTLS_INT_WINDOW_EXITING (1 << 2)
 #define VMCS_PRI_PROC_BASED_CTLS_TSC_OFFSET (1 << 3)
-- 
2.26.1


