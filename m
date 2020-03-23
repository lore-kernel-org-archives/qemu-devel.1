Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91968C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DEA206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pp5Wxvr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DEA206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGLLI-0003Do-FM
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1jGLK7-0001W0-HR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1jGLK5-0006xk-NQ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:32:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1jGLK5-0006xO-Gz
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:32:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id f3so16577494wrw.7
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GaQ4g7QDEtdpn1PcCIastdRRg2zyGK27S8LR99mMZas=;
 b=pp5Wxvr4Du/WTB/gu8fud7xlb9//dvkQWp56p0gUIaU5tZLc8OcBvoOQZW2tT618lJ
 VYTZUsBnWGv2YeqaOBHyh7+diBDCDd/DrDaRXWZu+XRDRpY/ALv9XhMzxY8DFwmwNyRj
 3Dx0FxRVGn3K6aGDjGViEaeAge2/JyCvMyZ2uPpXiVn9RysWkSSvtescOI38GR+1sFnm
 BgSotaIfWdIuFSd5YRdKr1LcB1VKVzAoBwGYhvv7ucGwZEliPojAKD/coHiEEHyqIzB9
 XYTjxg2VMK0cr/JObPhajaaP9R+HlR9eXbllhI+wrVb8kC953+FPM4LNxwLNzOQmUwq7
 /Wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GaQ4g7QDEtdpn1PcCIastdRRg2zyGK27S8LR99mMZas=;
 b=FSzmrfsGy+ocwlwN5YEcvVuYqCmi4fvuQPv3SEUGJVTAL+wVWJ90IROIZUIIhA8HGb
 ttiT43RqmY0r5U8ID7KYRsVv05Q1rSvsBAm5fY+Pq4FAW+MqQgsmZnietA1p0kbpOwCo
 /BERoAF8/aqalhGW3D6NLTBtKBFJ6szRBk/i+OUvhiFBioCZwe880D96fR8O4s8c5keJ
 /d78oS1SoEK4Nn+XbAUiN1vAyE1+bIyPgSYts//YKyXMfDnf9d4fgwKjy326fqTn74N9
 TGXEcKdwe5Q7yO4QfbKF9AvqH86IYzS+Iz5oKz+P3++K1/tlG19OksWlEgty3+/wTu3e
 6CNQ==
X-Gm-Message-State: ANhLgQ17o50ldI4sOQgKK5Z6ZPwAIQPkLMU3juBNbrvNUDEL8+gWvqRd
 5DBsI1IhMqAd7dChMMG4u32zxYkqdrj02A==
X-Google-Smtp-Source: ADFU+vsOcGT8FPzB3DYWs/C49iFKAqnkMZEt6BDxCCOqDkEUbZ28pNBMWV27aakJoJ5VSFa9o4lvuw==
X-Received: by 2002:adf:b60d:: with SMTP id f13mr1183897wre.12.1584963168016; 
 Mon, 23 Mar 2020 04:32:48 -0700 (PDT)
Received: from moi-limbo-9350.home
 (host86-177-220-180.range86-177.btcentralplus.com. [86.177.220.180])
 by smtp.gmail.com with ESMTPSA id 98sm23288473wrk.52.2020.03.23.04.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 04:32:47 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/2] target/arm: kvm: Handle potential issue with dabt
 injection
Date: Mon, 23 Mar 2020 11:32:27 +0000
Message-Id: <20200323113227.3169-3-beata.michalska@linaro.org>
In-Reply-To: <20200323113227.3169-1-beata.michalska@linaro.org>
References: <20200323113227.3169-1-beata.michalska@linaro.org>
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

Injecting external data abort through KVM might trigger
an issue on kernels that do not get updated to include the KVM fix.
For those and aarch32 guests, the injected abort gets misconfigured
to be an implementation defined exception. This leads to the guest
repeatedly re-running the faulting instruction.

Add support for handling that case.
[
  Fixed-by: 018f22f95e8a
	('KVM: arm: Fix DFSR setting for non-LPAE aarch32 guests')
  Fixed-by: 21aecdbd7f3a
	('KVM: arm: Make inject_abt32() inject an external abort instead')
]

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
---
 target/arm/cpu.h     |  1 +
 target/arm/kvm.c     | 30 +++++++++++++++++++++++++++++-
 target/arm/kvm32.c   | 25 +++++++++++++++++++++++++
 target/arm/kvm64.c   | 34 ++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h | 10 ++++++++++
 5 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4f834c1..868afc6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -561,6 +561,7 @@ typedef struct CPUARMState {
     } serror;
 
     uint8_t ext_dabt_pending; /* Request for injecting ext DABT */
+    uint8_t ext_dabt_raised; /* Tracking/verifying injection of ext DABT */
 
     /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
     uint32_t irq_line_state;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c088589..58ad734 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -721,7 +721,12 @@ int kvm_put_vcpu_events(ARMCPU *cpu)
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
     if (ret) {
         error_report("failed to put vcpu events");
-    } else {
+    } else if (env->ext_dabt_pending) {
+        /*
+         * Mark that the external DABT has been injected,
+         * if one has been requested
+         */
+        env->ext_dabt_raised = env->ext_dabt_pending;
         /* Clear instantly if the call was successful */
         env->ext_dabt_pending = 0;
     }
@@ -755,6 +760,29 @@ int kvm_get_vcpu_events(ARMCPU *cpu)
 
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
+            unlikely(!kvm_arm_verify_ext_dabt_pending(cs))) {
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
 }
 
 MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index f271181..86c4fe7 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -564,3 +564,28 @@ void kvm_arm_pmu_init(CPUState *cs)
 {
     qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
 }
+
+#define ARM_REG_DFSR  ARM_CP15_REG32(0, 5, 0, 0)
+#define ARM_REG_TTBCR ARM_CP15_REG32(0, 2, 0, 2)
+
+#define DFSR_FSC(v)   (((v) >> 6 | (v)) & 0x1F)
+#define DFSC_EXTABT(lpae) (lpae) ? 0x10 : 0x08
+
+bool kvm_arm_verify_ext_dabt_pending(CPUState *cs)
+{
+    uint32_t dfsr_val;
+
+    if (!kvm_get_one_reg(cs, ARM_REG_DFSR, &dfsr_val)) {
+        ARMCPU *cpu = ARM_CPU(cs);
+        CPUARMState *env = &cpu->env;
+        uint32_t ttbcr;
+        int lpae = 0;
+
+        if (!kvm_get_one_reg(cs, ARM_REG_TTBCR, &ttbcr)) {
+            lpae = arm_feature(env, ARM_FEATURE_LPAE) && (ttbcr & TTBCR_EAE);
+        }
+        return !(DFSR_FSC(dfsr_val) != DFSC_EXTABT(lpae));
+    }
+    return false;
+}
+
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index be5b31c..18594e9 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1430,3 +1430,37 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
 
     return false;
 }
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
+bool kvm_arm_verify_ext_dabt_pending(CPUState *cs)
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
+            uint64_t ttbcr;
+
+            if (!kvm_get_one_reg(cs, ARM64_REG_TCR_EL1, &ttbcr)) {
+                lpae = arm_feature(env, ARM_FEATURE_LPAE)
+                        && (ttbcr & TTBCR_EAE);
+            }
+        }
+        return !(ESR_DFSC(aarch64_mode, dfsr_val) !=
+                ESR_DFSC_EXTABT(aarch64_mode, lpae));
+    }
+    return false;
+}
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 39472d5..f2dc6a2 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -461,6 +461,16 @@ void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
 int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
                              uint64_t fault_ipa);
 /**
+ * kvm_arm_verify_ext_dabt_pending:
+ * @cs: CPUState
+ *
+ * Verify the fault status code wrt the Ext DABT injection
+ *
+ * Returns: true if the fault status code is as expected, false otherwise
+ */
+bool kvm_arm_verify_ext_dabt_pending(CPUState *cs);
+
+/**
  * its_class_name:
  *
  * Return the ITS class name to use depending on whether KVM acceleration
-- 
2.7.4


