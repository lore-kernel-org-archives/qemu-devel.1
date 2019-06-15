Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CCCC31E44
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CE32183F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 00:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgGYJCJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CE32183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57892 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbwzm-0001cn-9D
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 20:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60453)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hbwmf-0000WL-Os
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hbwmd-0004Ez-Ms
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:05 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42849)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hbwma-0004A8-Na
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 20:43:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id x17so4195493wrl.9
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 17:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+7Xf4ehPVEjmQK/UU3GOZut7M7AHJc9i0ZuuPNjoMyo=;
 b=vgGYJCJVn25Rv+9xWKwQV8m6sX/bk6i4/Z9xt2pRkEuyQ6fh9HjYB1UUQFcRhr0tmh
 a2VFLq3RnWIFea+q+Kxe1Ov6GpK6SnUanGpAErvLeDUJ9zg17ixUblrSQ+OMmvKlyAYx
 yssvbDU4RAd/hCrj8oarrZjAhpczIQXuNwAgMv13KxISqOuIOUJydtmAQKVXlQ2gezwg
 LUzbMwWrAUW/MBkJqu+sa/Vlt94Hk2P2nVsyLO7EzCLePMq8qqvR8h1rd45PYzruNOYT
 fqbj/likylSael6lrcMjDxuhiI+bRgKU+Q+Xo7ky67TGSGLVhwWTljsURpw8tirUNnnX
 1EaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+7Xf4ehPVEjmQK/UU3GOZut7M7AHJc9i0ZuuPNjoMyo=;
 b=FZE219nXIaKgoKrFGP1FW0WSP+9hZimYae8LeXevoZffz17FiHO03nwiaVz8njn8lK
 8dmp+xdNotDWPj+a5E9rB4FOGtzbZ6sNz0pNq4PLO3YWqsf4D8R4CTIybhuHtWHQk6tk
 /FEXxfZSRNg20TMR2uCqtDbruaPbwSSVran5FsHxZR3JAoAhHJrLB63yOkhqdAhtGw68
 +weOP4mcGMBs7xoG/3Zq4E0wpG5QJvQhLQOZFD+cAklLUiK0evydxYigkbG2L9F5XdhJ
 k1rKzNgB6vDNYhWmuPALAPN5Ko9xtW9e4rf5PYplG+JF8F0UHbJzp2DIk+ifydKnhBXf
 SXhw==
X-Gm-Message-State: APjAAAW55PqsrNRc8/8oTnBKKDICfrdyK2kFn5DOr/XNwyULDhoJndif
 2mBoilhO/cYMQvCBoOViys264TU+
X-Google-Smtp-Source: APXvYqzVnKL3q5aALG22650hjD/Q191mAKAlV/sHYILD9JyVaIqUrFs+M+fsvoHHXQ6tEgX4efJpzg==
X-Received: by 2002:a05:6000:11cc:: with SMTP id
 i12mr7369109wrx.243.1560559378696; 
 Fri, 14 Jun 2019 17:42:58 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:1da0:213e:1763:a1a8])
 by smtp.gmail.com with ESMTPSA id m21sm3774234wmc.1.2019.06.14.17.42.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 17:42:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 02:42:52 +0200
Message-Id: <20190615004256.16367-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190615004256.16367-1-pbonzini@redhat.com>
References: <20190615004256.16367-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 3/7] KVM: i386: Add support for
 KVM_CAP_EXCEPTION_PAYLOAD
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
Cc: liran.alon@oracle.com, nikita.leshchenko@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

Kernel commit c4f55198c7c2 ("kvm: x86: Introduce KVM_CAP_EXCEPTION_PAYLOAD")
introduced a new KVM capability which allows userspace to correctly
distinguish between pending and injected exceptions.

This distinguish is important in case of nested virtualization scenarios
because a L2 pending exception can still be intercepted by the L1 hypervisor
while a L2 injected exception cannot.

Furthermore, when an exception is attempted to be injected by QEMU,
QEMU should specify the exception payload (CR2 in case of #PF or
DR6 in case of #DB) instead of having the payload already delivered in
the respective vCPU register. Because in case exception is injected to
L2 guest and is intercepted by L1 hypervisor, then payload needs to be
reported to L1 intercept (VMExit handler) while still preserving
respective vCPU register unchanged.

This commit adds support for QEMU to properly utilise this new KVM
capability (KVM_CAP_EXCEPTION_PAYLOAD).

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c        | 10 ++---
 target/i386/cpu.h        | 13 +++++-
 target/i386/hvf/hvf.c    | 10 +++--
 target/i386/hvf/x86hvf.c |  4 +-
 target/i386/kvm.c        | 95 +++++++++++++++++++++++++++++++++-------
 target/i386/machine.c    | 61 +++++++++++++++++++++++++-
 6 files changed, 163 insertions(+), 30 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c1ab86d63e..4e19969111 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4777,7 +4777,9 @@ static void x86_cpu_reset(CPUState *s)
     memset(env->mtrr_fixed, 0, sizeof(env->mtrr_fixed));
 
     env->interrupt_injected = -1;
-    env->exception_injected = -1;
+    env->exception_nr = -1;
+    env->exception_pending = 0;
+    env->exception_injected = 0;
     env->nmi_injected = false;
 #if !defined(CONFIG_USER_ONLY)
     /* We hard-wire the BSP to the first CPU. */
@@ -5173,12 +5175,6 @@ static int x86_cpu_filter_features(X86CPU *cpu)
     return rv;
 }
 
-#define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
-                           (env)->cpuid_vendor2 == CPUID_VENDOR_INTEL_2 && \
-                           (env)->cpuid_vendor3 == CPUID_VENDOR_INTEL_3)
-#define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
-                         (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
-                         (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index bd06523a53..bbeb7a9521 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -729,6 +729,13 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_VENDOR_HYGON    "HygonGenuine"
 
+#define IS_INTEL_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 && \
+                           (env)->cpuid_vendor2 == CPUID_VENDOR_INTEL_2 && \
+                           (env)->cpuid_vendor3 == CPUID_VENDOR_INTEL_3)
+#define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
+                         (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
+                         (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
+
 #define CPUID_MWAIT_IBE     (1U << 1) /* Interrupts can exit capability */
 #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
 
@@ -1332,10 +1339,14 @@ typedef struct CPUX86State {
 
     /* For KVM */
     uint32_t mp_state;
-    int32_t exception_injected;
+    int32_t exception_nr;
     int32_t interrupt_injected;
     uint8_t soft_interrupt;
+    uint8_t exception_pending;
+    uint8_t exception_injected;
     uint8_t has_error_code;
+    uint8_t exception_has_payload;
+    uint64_t exception_payload;
     uint32_t ins_len;
     uint32_t sipi_vector;
     bool tsc_valid;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 2751c8125c..dc4bb63536 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -605,7 +605,9 @@ static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_in
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
 
-    env->exception_injected = -1;
+    env->exception_nr = -1;
+    env->exception_pending = 0;
+    env->exception_injected = 0;
     env->interrupt_injected = -1;
     env->nmi_injected = false;
     if (idtvec_info & VMCS_IDT_VEC_VALID) {
@@ -619,7 +621,8 @@ static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_in
             break;
         case VMCS_IDT_VEC_HWEXCEPTION:
         case VMCS_IDT_VEC_SWEXCEPTION:
-            env->exception_injected = idtvec_info & VMCS_IDT_VEC_VECNUM;
+            env->exception_nr = idtvec_info & VMCS_IDT_VEC_VECNUM;
+            env->exception_injected = 1;
             break;
         case VMCS_IDT_VEC_PRIV_SWEXCEPTION:
         default:
@@ -912,7 +915,8 @@ int hvf_vcpu_exec(CPUState *cpu)
             macvm_set_rip(cpu, rip + ins_len);
             break;
         case VMX_REASON_VMCALL:
-            env->exception_injected = EXCP0D_GPF;
+            env->exception_nr = EXCP0D_GPF;
+            env->exception_injected = 1;
             env->has_error_code = true;
             env->error_code = 0;
             break;
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index df8e946fbc..e0ea02d631 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -362,8 +362,8 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
     if (env->interrupt_injected != -1) {
         vector = env->interrupt_injected;
         intr_type = VMCS_INTR_T_SWINTR;
-    } else if (env->exception_injected != -1) {
-        vector = env->exception_injected;
+    } else if (env->exception_nr != -1) {
+        vector = env->exception_nr;
         if (vector == EXCP03_INT3 || vector == EXCP04_INTO) {
             intr_type = VMCS_INTR_T_SWEXCEPTION;
         } else {
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 53f95b02a0..dca76830ec 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -104,6 +104,7 @@ static uint32_t num_architectural_pmu_fixed_counters;
 static int has_xsave;
 static int has_xcrs;
 static int has_pit_state2;
+static int has_exception_payload;
 
 static bool has_msr_mcg_ext_ctl;
 
@@ -584,15 +585,51 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
     /* Hope we are lucky for AO MCE */
 }
 
+static void kvm_reset_exception(CPUX86State *env)
+{
+	env->exception_nr = -1;
+	env->exception_pending = 0;
+	env->exception_injected = 0;
+}
+
+static void kvm_queue_exception(CPUX86State *env,
+                                int32_t exception_nr,
+                                uint8_t exception_has_payload,
+                                uint64_t exception_payload)
+{
+    assert(env->exception_nr == -1);
+    assert(!env->exception_pending);
+    assert(!env->exception_injected);
+
+    env->exception_nr = exception_nr;
+
+    if (has_exception_payload) {
+        env->exception_pending = 1;
+
+        env->exception_has_payload = exception_has_payload;
+        env->exception_payload = exception_payload;
+    } else {
+        env->exception_injected = 1;
+
+        if (exception_has_payload) {
+            if (exception_nr == EXCP01_DB) {
+                env->dr[6] = exception_payload;
+            } else if (exception_nr == EXCP0E_PAGE) {
+                env->cr[2] = exception_payload;
+            }
+        }
+    }
+}
+
 static int kvm_inject_mce_oldstyle(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
 
-    if (!kvm_has_vcpu_events() && env->exception_injected == EXCP12_MCHK) {
+    if (!kvm_has_vcpu_events() && env->exception_nr == EXCP12_MCHK) {
         unsigned int bank, bank_num = env->mcg_cap & 0xff;
         struct kvm_x86_mce mce;
 
-        env->exception_injected = -1;
+	kvm_reset_exception(env);
 
         /*
          * There must be at least one bank in use if an MCE is pending.
@@ -1573,6 +1610,16 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     hv_vpindex_settable = kvm_check_extension(s, KVM_CAP_HYPERV_VP_INDEX);
 
+    has_exception_payload = kvm_check_extension(s, KVM_CAP_EXCEPTION_PAYLOAD);
+    if (has_exception_payload) {
+        ret = kvm_vm_enable_cap(s, KVM_CAP_EXCEPTION_PAYLOAD, 0, true);
+        if (ret < 0) {
+            error_report("kvm: Failed to enable exception payload cap: %s",
+                         strerror(-ret));
+            return ret;
+        }
+    }
+
     ret = kvm_get_supported_msrs(s);
     if (ret < 0) {
         return ret;
@@ -2877,8 +2924,16 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
         return 0;
     }
 
-    events.exception.injected = (env->exception_injected >= 0);
-    events.exception.nr = env->exception_injected;
+    events.flags = 0;
+
+    if (has_exception_payload) {
+        events.flags |= KVM_VCPUEVENT_VALID_PAYLOAD;
+        events.exception.pending = env->exception_pending;
+        events.exception_has_payload = env->exception_has_payload;
+        events.exception_payload = env->exception_payload;
+    }
+    events.exception.nr = env->exception_nr;
+    events.exception.injected = env->exception_injected;
     events.exception.has_error_code = env->has_error_code;
     events.exception.error_code = env->error_code;
 
@@ -2891,7 +2946,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     events.nmi.masked = !!(env->hflags2 & HF2_NMI_MASK);
 
     events.sipi_vector = env->sipi_vector;
-    events.flags = 0;
 
     if (has_msr_smbase) {
         events.smi.smm = !!(env->hflags & HF_SMM_MASK);
@@ -2941,8 +2995,19 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
     if (ret < 0) {
        return ret;
     }
-    env->exception_injected =
-       events.exception.injected ? events.exception.nr : -1;
+
+    if (events.flags & KVM_VCPUEVENT_VALID_PAYLOAD) {
+        env->exception_pending = events.exception.pending;
+        env->exception_has_payload = events.exception_has_payload;
+        env->exception_payload = events.exception_payload;
+    } else {
+        env->exception_pending = 0;
+        env->exception_has_payload = false;
+    }
+    env->exception_injected = events.exception.injected;
+    env->exception_nr =
+        (env->exception_pending || env->exception_injected) ?
+        events.exception.nr : -1;
     env->has_error_code = events.exception.has_error_code;
     env->error_code = events.exception.error_code;
 
@@ -2994,12 +3059,12 @@ static int kvm_guest_debug_workarounds(X86CPU *cpu)
     unsigned long reinject_trap = 0;
 
     if (!kvm_has_vcpu_events()) {
-        if (env->exception_injected == EXCP01_DB) {
+        if (env->exception_nr == EXCP01_DB) {
             reinject_trap = KVM_GUESTDBG_INJECT_DB;
         } else if (env->exception_injected == EXCP03_INT3) {
             reinject_trap = KVM_GUESTDBG_INJECT_BP;
         }
-        env->exception_injected = -1;
+        kvm_reset_exception(env);
     }
 
     /*
@@ -3320,13 +3385,13 @@ int kvm_arch_process_async_events(CPUState *cs)
 
         kvm_cpu_synchronize_state(cs);
 
-        if (env->exception_injected == EXCP08_DBLE) {
+        if (env->exception_nr == EXCP08_DBLE) {
             /* this means triple fault */
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             cs->exit_request = 1;
             return 0;
         }
-        env->exception_injected = EXCP12_MCHK;
+        kvm_queue_exception(env, EXCP12_MCHK, 0, 0);
         env->has_error_code = 0;
 
         cs->halted = 0;
@@ -3541,14 +3606,12 @@ static int kvm_handle_debug(X86CPU *cpu,
     }
     if (ret == 0) {
         cpu_synchronize_state(cs);
-        assert(env->exception_injected == -1);
+        assert(env->exception_nr == -1);
 
         /* pass to guest */
-        env->exception_injected = arch_info->exception;
+        kvm_queue_exception(env, arch_info->exception,
+                            EXCP01_DB, arch_info->dr6);
         env->has_error_code = 0;
-        if (arch_info->exception == EXCP01_DB) {
-            env->dr[6] = arch_info->dr6;
-        }
     }
 
     return ret;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 225b5d433b..41460be54b 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -199,6 +199,21 @@ static const VMStateDescription vmstate_fpreg = {
     }
 };
 
+static bool is_vmx_enabled(CPUX86State *env)
+{
+    return (IS_INTEL_CPU(env) && (env->cr[4] & CR4_VMXE_MASK));
+}
+
+static bool is_svm_enabled(CPUX86State *env)
+{
+    return (IS_AMD_CPU(env) && (env->efer & MSR_EFER_SVME));
+}
+
+static bool is_nested_virt_enabled(CPUX86State *env)
+{
+    return (is_vmx_enabled(env) || is_svm_enabled(env));
+}
+
 static int cpu_pre_save(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -278,6 +293,23 @@ static int cpu_post_load(void *opaque, int version_id)
     env->hflags &= ~HF_CPL_MASK;
     env->hflags |= (env->segs[R_SS].flags >> DESC_DPL_SHIFT) & HF_CPL_MASK;
 
+    /*
+     * There are cases that we can get valid exception_nr with both
+     * exception_pending and exception_clear being cleared. This can happen in
+     * one of the following scenarios:
+     * 1) Source is older QEMU without KVM_CAP_EXCEPTION_PAYLOAD support.
+     * 2) Source is running on kernel without KVM_CAP_EXCEPTION_PAYLOAD support.
+     * 3) "cpu/exception_info" subsection not sent because there is no exception
+     *	  pending or guest wasn't running L2.
+     *
+     * In those cases, we can just deduce that a valid exception_nr means
+     * we can treat the exception as already injected.
+     */
+    if ((env->exception_nr != -1) &&
+        !env->exception_pending && !env->exception_injected) {
+        env->exception_injected = 1;
+    }
+
     env->fpstt = (env->fpus_vmstate >> 11) & 7;
     env->fpus = env->fpus_vmstate & ~0x3800;
     env->fptag_vmstate ^= 0xff;
@@ -323,6 +355,32 @@ static bool steal_time_msr_needed(void *opaque)
     return cpu->env.steal_time_msr != 0;
 }
 
+static bool exception_info_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+
+    /*
+     * Differenting between pending and injected exceptions
+     * is only important when running L2.
+     */
+    return (cpu->env.exception_pending &&
+            is_nested_virt_enabled(&cpu->env));
+}
+
+static const VMStateDescription vmstate_exception_info = {
+    .name = "cpu/exception_info",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = exception_info_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(env.exception_pending, X86CPU),
+        VMSTATE_UINT8(env.exception_injected, X86CPU),
+        VMSTATE_UINT8(env.exception_has_payload, X86CPU),
+        VMSTATE_UINT64(env.exception_payload, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_steal_time_msr = {
     .name = "cpu/steal_time_msr",
     .version_id = 1,
@@ -1035,7 +1093,7 @@ VMStateDescription vmstate_x86_cpu = {
         VMSTATE_INT32(env.interrupt_injected, X86CPU),
         VMSTATE_UINT32(env.mp_state, X86CPU),
         VMSTATE_UINT64(env.tsc, X86CPU),
-        VMSTATE_INT32(env.exception_injected, X86CPU),
+        VMSTATE_INT32(env.exception_nr, X86CPU),
         VMSTATE_UINT8(env.soft_interrupt, X86CPU),
         VMSTATE_UINT8(env.nmi_injected, X86CPU),
         VMSTATE_UINT8(env.nmi_pending, X86CPU),
@@ -1059,6 +1117,7 @@ VMStateDescription vmstate_x86_cpu = {
         /* The above list is not sorted /wrt version numbers, watch out! */
     },
     .subsections = (const VMStateDescription*[]) {
+        &vmstate_exception_info,
         &vmstate_async_pf_msr,
         &vmstate_pv_eoi_msr,
         &vmstate_steal_time_msr,
-- 
2.21.0



