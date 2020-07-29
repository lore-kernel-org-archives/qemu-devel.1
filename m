Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EB4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F150820809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 13:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="tz/HM3Tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F150820809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0lpH-0007Sg-9H
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 09:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k0loX-0006p4-QR
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:08:09 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:52016 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k0loU-0006fG-El
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 09:08:09 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 7453F4C882;
 Wed, 29 Jul 2020 13:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-transfer-encoding:content-type:content-type:mime-version
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received:received; s=mta-01; t=1596028082; x=
 1597842483; bh=4jM/3ccj1S6S9IMSxlZn6RWZDumXXIlvvhLmlF2keo0=; b=t
 z/HM3TqWevtTWt0lImiQ/MTFvIMZXUCl8PslyZ6EmWl5J8Bqx6RgV/AIBHbwQI/4
 ovgIpBwA5fY8IuLry1EZvDTQboCUaeOlhxYEHv27kh9uEuUhWDJXYg4EMgDyc2rk
 fdAs1aH9Plmr+g3ze3l8M1makJ/P6f2BhjitnUABxU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bvg0YQFbaOfB; Wed, 29 Jul 2020 16:08:02 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 544D845F5F;
 Wed, 29 Jul 2020 16:08:02 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jul 2020 16:08:02 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v4] i386: hvf: Implement CPU kick
Date: Wed, 29 Jul 2020 15:48:34 +0300
Message-ID: <20200729124832.79375-1-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 08:33:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

hv_vcpu_interrupt() has no effect if it's delivered when vCPU is outside
of a guest, therefore to avoid kick loss it's complemented with a
SIG_IPI handler and zero VMX-preemption timer. If the kick happens
outside of hv_vcpu_run(), the signal handler will re-queue the kick by
setting exit_request. exit_request is cleared when the request is
satisifed, i.e. when vCPU thread returns with EXCP_INTERRUPT.

So we get the following scenarios time/location-wise for the kick:

1) vCPU thread is far away before hv_vcpu_run(), then exit_request is
   scheduled. As soon as vCPU thread approaches hv_vcpu_run(), the
   exit request is satasified.

2) vCPU thread is about to enter the guest, then VMX-preemption timer is
   enabled to expedite immediate VM-exit. The VMX-preemption timer is
   then cleared in VM-exit handler, exit from vCPU thread is performed.

3) The guest is running, then hv_vcpu_run() is interrupted by
   hv_vcpu_interrupt() and vCPU thread quits.

4) vCPU thread has just made VM-exit, then exit_request is recorded and
   VMX-preemption timer is enabled but the exit request won't be
   satisfied until the next iteration of vCPU thread, no kick loss
   happens.

5) vCPU thread is far after hv_vcpu_run(), then exit_request is recorded
   and VMX-preemption timer is not enabled. The exit request will be
   satasfied on the next iteration of vCPU thread, like in 4). The kick
   is not lost.

6) If some external interupt happens we can satisify exit request and can
   clear VMX-preemption timer, i.e. kicks are coalesced with interrupts.

While at it, correct type of hvf_fd to the type of hv_vcpuid_t to avoid
compilation warnings.

1. https://opensource.apple.com/source/xnu/xnu-6153.81.5/osfmk/i386/mp.c

Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---

Hi,

The version is just for review. There's an issue where interrupts
(x86_gsi_interrupt) don't reach HVF (i.e. no interrupts are loaded into
VMCS interruption info field). I've been triaging the issue for a while
and dtrace patches are byproduct of the triage efforts. Once I figure
out where interrupts are lost/suppressed (which won't happen until the
end of the next week due to vacation), I'll send v5 with kick patch and
the interrupt delivery fix.

Thanks,
Roman

Changes since v3:
 - Replaced TLS pthread_key_t with current_cpu (Paolo)
 - Eliminated race condition by signalling through atomic variables (Paolo)

Changes since v2:
 - Reworked workaround to minimize kick loss race. Use signals to
   interrupt vCPU thread outside of hv_vcpu_run() and turn-on/turn-off
   VMX-preemeption timer, while timer value is always zero. v3 also
   assumes that VMX-preemption timer control is always available on the
   hardware that supports HVF.

Changes since v1:
 - Reduced kick loss race (Paolo) and removed SIG_IPI blocking

 include/hw/core/cpu.h  |  2 +-
 include/sysemu/hvf.h   |  1 +
 softmmu/cpus.c         | 13 ++++++---
 target/i386/cpu.h      |  1 +
 target/i386/hvf/hvf.c  | 60 ++++++++++++++++++++++++++++++++++++++++--
 target/i386/hvf/vmcs.h |  1 +
 6 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 8f145733ce..deaf9fe7ca 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -454,7 +454,7 @@ struct CPUState {
 
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
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index a802e899ab..a2c3ed93fe 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -1708,10 +1708,15 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
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
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e1a5c174dc..ef7dbcb8dc 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1608,6 +1608,7 @@ typedef struct CPUX86State {
     struct kvm_nested_state *nested_state;
 #endif
 #if defined(CONFIG_HVF)
+    bool hvf_in_guest;
     HVFX86LazyFlags hvf_lflags;
     void *hvf_mmio_buf;
 #endif
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index d81f569aed..1d77245bca 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -458,8 +458,27 @@ void hvf_vcpu_destroy(CPUState *cpu)
     assert_hvf_ok(ret);
 }
 
-static void dummy_signal(int sig)
+static void hvf_handle_ipi(int sig)
 {
+    if (!current_cpu) {
+        return;
+    }
+
+    /*
+     * skip object type check to avoid a deadlock in
+     * qemu_log/vfprintf/flockfile.
+     */
+    X86CPU *x86_cpu = (X86CPU *)current_cpu;
+    CPUX86State *env = &x86_cpu->env;
+
+    atomic_set(&current_cpu->exit_request, true);
+    /* Write cpu->exit_request before reading env->hvf_in_guest */
+    smp_mb();
+    if (atomic_read(&env->hvf_in_guest)) {
+        wvmcs(current_cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
+              rvmcs(current_cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
+                | VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
+    }
 }
 
 int hvf_init_vcpu(CPUState *cpu)
@@ -474,16 +493,18 @@ int hvf_init_vcpu(CPUState *cpu)
     struct sigaction sigact;
 
     memset(&sigact, 0, sizeof(sigact));
-    sigact.sa_handler = dummy_signal;
+    sigact.sa_handler = hvf_handle_ipi;
     sigaction(SIG_IPI, &sigact, NULL);
 
     pthread_sigmask(SIG_BLOCK, NULL, &set);
     sigdelset(&set, SIG_IPI);
+    pthread_sigmask(SIG_SETMASK, &set, NULL);
 
     init_emu();
     init_decoder();
 
     hvf_state->hvf_caps = g_new0(struct hvf_vcpu_caps, 1);
+    env->hvf_in_guest = false;
     env->hvf_mmio_buf = g_new(char, 4096);
 
     r = hv_vcpu_create((hv_vcpuid_t *)&cpu->hvf_fd, HV_VCPU_DEFAULT);
@@ -529,6 +550,7 @@ int hvf_init_vcpu(CPUState *cpu)
     wvmcs(cpu->hvf_fd, VMCS_EXCEPTION_BITMAP, 0); /* Double fault */
 
     wvmcs(cpu->hvf_fd, VMCS_TPR_THRESHOLD, 0);
+    wvmcs(cpu->hvf_fd, VMCS_PREEMPTION_TIMER_VALUE, 0);
 
     x86cpu = X86_CPU(cpu);
     x86cpu->env.xsave_buf = qemu_memalign(4096, 4096);
@@ -631,7 +653,20 @@ int hvf_vcpu_exec(CPUState *cpu)
             return EXCP_HLT;
         }
 
+        atomic_set(&env->hvf_in_guest, true);
+        /* Read cpu->exit_request after writing env->hvf_in_guest */
+        smp_mb();
+        if (atomic_read(&cpu->exit_request)) {
+            atomic_set(&env->hvf_in_guest, false);
+            qemu_mutex_lock_iothread();
+            wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
+                  rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
+                    & ~VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
+            atomic_set(&cpu->exit_request, false);
+            return EXCP_INTERRUPT;
+        }
         hv_return_t r  = hv_vcpu_run(cpu->hvf_fd);
+        atomic_store_release(&env->hvf_in_guest, false);
         assert_hvf_ok(r);
 
         /* handle VMEXIT */
@@ -774,7 +809,12 @@ int hvf_vcpu_exec(CPUState *cpu)
             vmx_clear_nmi_window_exiting(cpu);
             ret = EXCP_INTERRUPT;
             break;
+        case EXIT_REASON_VMX_PREEMPT:
         case EXIT_REASON_EXT_INTR:
+            wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
+                  rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
+                    & ~VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
+            atomic_set(&cpu->exit_request, false);
             /* force exit and allow io handling */
             ret = EXCP_INTERRUPT;
             break;
@@ -872,6 +912,22 @@ int hvf_vcpu_exec(CPUState *cpu)
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


