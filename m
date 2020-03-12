Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAAEC2BAEE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 00:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A51F206B1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 00:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJy6zeVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A51F206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCBpc-0005Ip-CF
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 20:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1jCBoX-0003og-92
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 20:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1jCBoV-0003JC-Lx
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 20:35:05 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34933)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1jCBoV-0003GN-FZ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 20:35:03 -0400
Received: by mail-wr1-x444.google.com with SMTP id d5so4806449wrc.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 17:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tdeDTRKwX3/D9Aee9mi3kA2Ii964xdWC/TNwskQf/90=;
 b=YJy6zeVArNChpjR8SxPk7XKanGBW9bbw+I38F+Akl5nsINroVK9rXf6vfEYy55LxqF
 OO4bP4CVzjaAOGV0ppTeqXejchSZ+DfCuXbBGlTbihp/1Wl8Py4cFV2I+wVVsA2f3z6w
 pSS6lJmBjw1gsUp2bajtbsq5xteiy4/k208cvndKMyXmiuhS23fq/DVnlru5W9mvojYz
 9LRsY+nEdrw8zkfDeNZ57qD8cRhnr1T7dHgs1izUw18tvzC0kTKpnu8moPplbS1uCJSV
 wjxZMOhJbswsEYgYWzeJcfYlPIUVHCJ3JI3BjCdkn1s0m3jct53iCFHj74I3bYT0cjpH
 O81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tdeDTRKwX3/D9Aee9mi3kA2Ii964xdWC/TNwskQf/90=;
 b=K75cK8QSUZN0wq1cqSV7LsymInsR7K0gVHABMVY3/aP8Dnq03JuyjK8aZ7SBAN1qPG
 bRCz0qFUjiYypCeO5j1UUUsfPTryXx7hB/qwdCaU+LQhBJd9IsR7sf7uU89OWcAxGBlE
 yc4v4gAo2oZWVn4WqoNTKEAd07W8wRURAc+mVKqrSWhgJodMLBPtxcrgFbDlOy1/WQFn
 zGZZaDojbtxnKwi8EWp0KBi0ZUYBx2Vcu6as4qMeiT2Q6kfeVwZBHXIUv+EKymWbhlsD
 ZlwZLCtGgksEtet5iaT/B53zZ0LK8jOLQJxFLV7ivytQ85y+WJn6TN4Ka6VJ14/JwE5U
 rDfg==
X-Gm-Message-State: ANhLgQ3N+V/A46Bkn4Z144VYdrCf2D7ubsLagDbY/lK6SyoOkQxntbsk
 JhA2+99wZmhQcPG4rowZOGKjpbjTHsw=
X-Google-Smtp-Source: ADFU+vvEkzsSXsxs2TDBrYTxiyDHysOAK9mdDhoXZglUZQBL4NQu/2jWfL6VFZPDtyTe826mlO2D5w==
X-Received: by 2002:a5d:6282:: with SMTP id k2mr3223103wru.401.1583973302083; 
 Wed, 11 Mar 2020 17:35:02 -0700 (PDT)
Received: from moi-limbo-9350.home
 (host86-139-146-66.range86-139.btcentralplus.com. [86.139.146.66])
 by smtp.gmail.com with ESMTPSA id o5sm10909988wmb.8.2020.03.11.17.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 17:35:01 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] target/arm: kvm: Handle DABT with no valid ISS
Date: Thu, 12 Mar 2020 00:34:01 +0000
Message-Id: <20200312003401.29017-3-beata.michalska@linaro.org>
In-Reply-To: <20200312003401.29017-1-beata.michalska@linaro.org>
References: <20200312003401.29017-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, Christoffer.Dall@arm.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On ARMv7 & ARMv8 some load/store instructions might trigger a data abort
exception with no valid ISS info to be decoded. The lack of decode info
makes it at least tricky to emulate those instruction which is one of the
(many) reasons why KVM will not even try to do so.

Add support for handling those by requesting KVM to inject external
dabt into the quest.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
---
 target/arm/cpu.h     |  3 ++
 target/arm/kvm.c     | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm32.c   | 26 +++++++++++++++++
 target/arm/kvm64.c   | 36 +++++++++++++++++++++++
 target/arm/kvm_arm.h | 22 ++++++++++++++
 5 files changed, 168 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4ffd991..45fdd2e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -560,6 +560,9 @@ typedef struct CPUARMState {
         uint64_t esr;
     } serror;
 
+    uint8_t ext_dabt_pending:1; /* Request for injecting ext DABT */
+    uint8_t ext_dabt_raised:1; /* Tracking/verifying injection of ext DABT */
+
     /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
     uint32_t irq_line_state;
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 85860e6..8b7b708 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -39,6 +39,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
 
 static bool cap_has_mp_state;
 static bool cap_has_inject_serror_esr;
+static bool cap_has_inject_ext_dabt;
 
 static ARMHostCPUFeatures arm_host_cpu_features;
 
@@ -244,6 +245,16 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         ret = -EINVAL;
     }
 
+    if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
+        if (kvm_vm_enable_cap(s, KVM_CAP_ARM_NISV_TO_USER, 0)) {
+            warn_report("Failed to enable DABT NISV cap");
+        } else {
+            /* Set status for supporting the external dabt injection */
+            cap_has_inject_ext_dabt = kvm_check_extension(s,
+                                    KVM_CAP_ARM_INJECT_EXT_DABT);
+        }
+    }
+
     return ret;
 }
 
@@ -703,9 +714,20 @@ int kvm_put_vcpu_events(ARMCPU *cpu)
         events.exception.serror_esr = env->serror.esr;
     }
 
+    if (cap_has_inject_ext_dabt) {
+        events.exception.ext_dabt_pending = env->ext_dabt_pending;
+    }
+
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
     if (ret) {
         error_report("failed to put vcpu events");
+    } else if (env->ext_dabt_pending) {
+        /*
+         * Mark that the external DABT has been injected,
+         * if one has been requested
+         */
+        env->ext_dabt_raised = env->ext_dabt_pending;
+        env->ext_dabt_pending = 0;
     }
 
     return ret;
@@ -737,6 +759,30 @@ int kvm_get_vcpu_events(ARMCPU *cpu)
 
 void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    if (unlikely(env->ext_dabt_raised)) {
+        /*
+         * Verifying that the ext DABT has been properly injected,
+         * otherwise risking indefinitely re-running the faulting instruction
+         * Covering a very narrow case for kernels 5.5..5.5.4
+         * when injected abort was misconfigured to be
+         * an IMPLEMENTATION DEFINED exception (for 32-bit EL1)
+         */
+        if (!arm_feature(env, ARM_FEATURE_AARCH64) &&
+            unlikely(kvm_arm_verify_ext_dabt_pending(cs))) {
+
+            error_report("Data abort exception with no valid ISS generated by "
+                   "guest memory access. KVM unable to emulate faulting "
+                   "instruction. Failed to inject an external data abort "
+                   "into the guest.");
+            abort();
+       }
+       /* Clear the status */
+       env->ext_dabt_raised = 0;
+    }
+
 }
 
 MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
@@ -819,6 +865,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
             ret = EXCP_DEBUG;
         } /* otherwise return to guest */
         break;
+    case KVM_EXIT_ARM_NISV:
+        /* External DABT with no valid iss to decode */
+        ret = kvm_arm_handle_dabt_nisv(cs, run->arm_nisv.esr_iss,
+                                       run->arm_nisv.fault_ipa);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
@@ -953,3 +1004,33 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 {
     return (data - 32) & 0xffff;
 }
+
+int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
+                             uint64_t fault_ipa)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+   /*
+    * ISS [23:14] is invalid so there is a limited info
+    * on what has just happened so the only *useful* thing that can
+    * be retrieved from ISS is WnR & DFSC (though in some cases WnR
+    * might be less of a value as well)
+    */
+
+    /*
+     * Set pending ext dabt and trigger SET_EVENTS so that
+     * KVM can inject the abort
+     */
+    if (cap_has_inject_ext_dabt) {
+        kvm_cpu_synchronize_state(cs);
+        env->ext_dabt_pending = 1;
+    } else {
+        error_report("Data abort exception triggered by guest memory access "
+                     "at physical address: 0x"  TARGET_FMT_lx,
+                     (target_ulong)fault_ipa);
+        error_printf("KVM unable to emulate faulting instruction.\n");
+    }
+
+    return cap_has_inject_ext_dabt ? 0 : -1;
+}
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index f271181..4795a7d 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -564,3 +564,29 @@ void kvm_arm_pmu_init(CPUState *cs)
 {
     qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
 }
+
+
+#define ARM_REG_DFSR  ARM_CP15_REG32(0, 5, 0, 0)
+#define ARM_REG_TTBCR ARM_CP15_REG32(0, 2, 0, 2)
+
+#define DFSR_FSC(v)   (((v) >> 6 | (v)) & 0x1F)
+#define DFSC_EXTABT(lpae) (lpae) ? 0x10 : 0x08
+
+int kvm_arm_verify_ext_dabt_pending(CPUState *cs)
+{
+    uint32_t dfsr_val;
+
+    if (!kvm_get_one_reg(cs, ARM_REG_DFSR, &dfsr_val)) {
+
+        ARMCPU *cpu = ARM_CPU(cs);
+        CPUARMState *env = &cpu->env;
+        uint32_t ttbcr;
+        int lpae = 0;
+
+        if (!kvm_get_one_reg(cs, ARM_REG_TTBCR, &ttbcr)) {
+            lpae = arm_feature(env, ARM_FEATURE_LPAE) && (ttbcr & TTBCR_EAE);
+        }
+        return DFSR_FSC(dfsr_val) != DFSC_EXTABT(lpae);
+    }
+    return 1;
+}
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index be5b31c..2f8ffc6 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1430,3 +1430,39 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
 
     return false;
 }
+
+
+#define ARM64_REG_ESR_EL1 ARM64_SYS_REG(3, 0, 5, 2, 0)
+#define ARM64_REG_TCR_EL1 ARM64_SYS_REG(3, 0, 2, 0, 2)
+
+#define ESR_DFSC(aarch64, v)    \
+    ((aarch64) ? ((v) & 0x3F)   \
+               : (((v) >> 6 | (v)) & 0x1F))
+
+#define ESR_DFSC_EXTABT(aarch64, lpae) \
+    ((aarch64) ? 0x10 : (lpae) ? 0x10 : 0x8)
+
+int kvm_arm_verify_ext_dabt_pending(CPUState *cs)
+{
+    uint64_t dfsr_val;
+
+    if (!kvm_get_one_reg(cs, ARM64_REG_ESR_EL1, &dfsr_val)) {
+        ARMCPU *cpu = ARM_CPU(cs);
+        CPUARMState *env = &cpu->env;
+        int aarch64_mode = arm_feature(env, ARM_FEATURE_AARCH64);
+        int lpae = 0;
+
+        if (!aarch64_mode) {
+
+            uint64_t ttbcr;
+
+            if (!kvm_get_one_reg(cs, ARM64_REG_TCR_EL1, &ttbcr)) {
+                lpae = arm_feature(env, ARM_FEATURE_LPAE)
+                        && (ttbcr & TTBCR_EAE);
+            }
+        }
+        return ESR_DFSC(aarch64_mode, dfsr_val) !=
+                ESR_DFSC_EXTABT(aarch64_mode, lpae) ;
+    }
+    return 1;
+}
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index ae9e075..777c9bf 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -450,6 +450,28 @@ struct kvm_guest_debug_arch;
 void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
 
 /**
+ * kvm_arm_handle_dabt_nisv
+ * @cs: CPUState
+ * @esr_iss: ISS encoding (limited) for the exception from Data Abort
+ *           ISV bit set to '0b0' -> no valid instruction syndrome
+ * @fault_ipa: faulting address for the synch data abort
+ *
+ * Returns: 0 if the exception has been handled
+ */
+int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
+                             uint64_t fault_ipa);
+
+/**
+ * kvm_arm_verify_ext_dabt_pending
+ * @cs: CPUState
+ *
+ * Verify the fault status code wrt the Ext DABT injection
+ *
+ * Returns: 0 if the fault status code is as expected, non-zero otherwise
+ */
+int kvm_arm_verify_ext_dabt_pending(CPUState *cs);
+
+/**
  * its_class_name:
  *
  * Return the ITS class name to use depending on whether KVM acceleration
-- 
2.7.4


