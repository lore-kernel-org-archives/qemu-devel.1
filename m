Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB7BC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB07D206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLvAr/BL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB07D206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGLLP-0003RM-Vt
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1jGLK4-0001RY-MO
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1jGLK3-0006wf-7S
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:32:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1jGLK3-0006vp-0C
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:32:47 -0400
Received: by mail-wm1-x344.google.com with SMTP id c187so14236016wme.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 04:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=scdgVshz7sU0Fzpv5iTWYPRCzh314P+7l5wAJHlPMsk=;
 b=JLvAr/BLfGkIUYDk0CdrGwqORp808GVmj/9LS6QzDIqOCdntGOzADShWL7NqnBoHmE
 y9D0qohsyh6Lh+QOYcEnJP3JfSmaRTaN3SaQKQ8JC/gzGza3aRvQFHayw+VQFVUNG8Be
 DEA2UA5WtVgEpMM8/pbvYq7H6tbTUwceliW4g4yGuPWddc/m1NfJ+GR8ih8Nl+Ff044y
 d1SANkvsxWEmBCPwcKwe4BFeDppIKLTOkzKtFtOvibWEscR7KVZmBNCuIfci0XYwK+9A
 WP32f6nfoIvNoxsxfhdYSqelcnl9nPhH/cHbCUPNCn2vLRCMdvRREZQF5JcW6FvhhVUa
 071Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=scdgVshz7sU0Fzpv5iTWYPRCzh314P+7l5wAJHlPMsk=;
 b=D3jLwVTk3WcivgIypD1Hl/+gcctliOC8FEoSSFzUl5dcsjPUZTwirZ3otIfyn0AnHn
 Wk5SAB84i3u4JD0joDsJyzVV/4mfd+QNQVCQQSe8KhdfTRDbT+RQpUGfLyp62tFK6aP3
 EAGVsAp25ZgAZZDk4mYj9LBdNmCrZscVIC109nhHlaMDdVlZNDQ41ZL/eo/pKpV3z2lu
 VOd8evWFSC+3pz167xx2CFLik3qRwh8JAZLtnS2MFqecIZKB358PCJ4Hz4ontTNWwNyo
 xh3i3aRJaZ5p9uzq03cU9u8POvmNG52gzf42u8J8SqYIefVNPppQRX2TtNjcbybaVOHw
 gRxA==
X-Gm-Message-State: ANhLgQ3uBhqd0drusuopd/1gXuDEs+FVrmS4KDpjVyA+TV/HzUcJga1c
 oASA+NEmq5qVmk6kJmnXp6s1H2COko2C9g==
X-Google-Smtp-Source: ADFU+vsS9oZSnx9C/9TqsxjLEO4sPwqD3pfhBeIFf+NsvEqUlgQJTeuJrLKEcxfz5pHB78qSJmSu2w==
X-Received: by 2002:a05:600c:1405:: with SMTP id
 g5mr12270544wmi.90.1584963165596; 
 Mon, 23 Mar 2020 04:32:45 -0700 (PDT)
Received: from moi-limbo-9350.home
 (host86-177-220-180.range86-177.btcentralplus.com. [86.177.220.180])
 by smtp.gmail.com with ESMTPSA id 98sm23288473wrk.52.2020.03.23.04.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 04:32:45 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] target/arm: kvm: Handle DABT with no valid ISS
Date: Mon, 23 Mar 2020 11:32:26 +0000
Message-Id: <20200323113227.3169-2-beata.michalska@linaro.org>
In-Reply-To: <20200323113227.3169-1-beata.michalska@linaro.org>
References: <20200323113227.3169-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 target/arm/cpu.h     |  2 ++
 target/arm/kvm.c     | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h | 11 +++++++++++
 3 files changed, 67 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4ffd991..4f834c1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -560,6 +560,8 @@ typedef struct CPUARMState {
         uint64_t esr;
     } serror;
 
+    uint8_t ext_dabt_pending; /* Request for injecting ext DABT */
+
     /* State of our input IRQ/FIQ/VIRQ/VFIQ lines */
     uint32_t irq_line_state;
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 85860e6..c088589 100644
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
 
@@ -703,9 +714,16 @@ int kvm_put_vcpu_events(ARMCPU *cpu)
         events.exception.serror_esr = env->serror.esr;
     }
 
+    if (cap_has_inject_ext_dabt) {
+        events.exception.ext_dabt_pending = env->ext_dabt_pending;
+    }
+
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_VCPU_EVENTS, &events);
     if (ret) {
         error_report("failed to put vcpu events");
+    } else {
+        /* Clear instantly if the call was successful */
+        env->ext_dabt_pending = 0;
     }
 
     return ret;
@@ -819,6 +837,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
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
@@ -953,3 +976,34 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
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
+        return -1;
+    }
+
+    return 0;
+}
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index ae9e075..39472d5 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -450,6 +450,17 @@ struct kvm_guest_debug_arch;
 void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
 
 /**
+ * kvm_arm_handle_dabt_nisv:
+ * @cs: CPUState
+ * @esr_iss: ISS encoding (limited) for the exception from Data Abort
+ *           ISV bit set to '0b0' -> no valid instruction syndrome
+ * @fault_ipa: faulting address for the synch data abort
+ *
+ * Returns: 0 if the exception has been handled, < 0 otherwise
+ */
+int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
+                             uint64_t fault_ipa);
+/**
  * its_class_name:
  *
  * Return the ITS class name to use depending on whether KVM acceleration
-- 
2.7.4


