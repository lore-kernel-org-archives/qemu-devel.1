Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290DFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7661220872
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7661220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSCbw-0003eE-Cu
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 01:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1kSCa5-0001tz-Df
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:10:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:57342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1kSCa3-0006YN-EA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:10:37 -0400
IronPort-SDR: ZpIJC5BkhLxARg0SCFv4QgSzPxDAdA0Lwy4UJPAhgcnQ8GzqLmLt24m6PdhArXcOdt2TQmln+J
 IKVxEcAGEwhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="162385623"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="162385623"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 22:10:33 -0700
IronPort-SDR: fauG661PqbAzMbbiuKPR+SkL8WZM2qR0dPZKmFr5qqBQATUSduK9d2O8gMbU9XkIK4t+HgNqsV
 FBg8XlOjO27g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="420427128"
Received: from unknown (HELO local-michael-cet-test.sh.intel.com)
 ([10.239.159.128])
 by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2020 22:10:32 -0700
From: Yang Weijiang <weijiang.yang@intel.com>
To: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, sean.j.christopherson@intel.com, qemu-devel@nongnu.org
Subject: [Qemu-devel][PATCH v6 4/6] x86/cpu: Add user-space MSR access
 interface for CET
Date: Tue, 13 Oct 2020 13:19:33 +0800
Message-Id: <20201013051935.6052-5-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201013051935.6052-1-weijiang.yang@intel.com>
References: <20201013051935.6052-1-weijiang.yang@intel.com>
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=weijiang.yang@intel.com; helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 01:10:25
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yang Weijiang <weijiang.yang@intel.com>, hao.wu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CET states are divided into user-mode and supervisor-mode states,
MSR_KVM_GUEST_SSP stores current SHSTK pointer in use, MSR_IA32_U_CET and
MSR_IA32_PL3_SSP are for user-mode states, others are for supervisor-mode
states. Expose the access according to current CET supported bits in CPUID
and XSS.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.h | 18 ++++++++++++
 target/i386/kvm.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d4563fa0e8..9c0568672e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -484,6 +484,15 @@ typedef enum X86Seg {
 #define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
 #define MSR_IA32_VMX_VMFUNC             0x00000491
 
+#define MSR_IA32_U_CET                  0x6a0
+#define MSR_IA32_S_CET                  0x6a2
+#define MSR_IA32_PL0_SSP                0x6a4
+#define MSR_IA32_PL1_SSP                0x6a5
+#define MSR_IA32_PL2_SSP                0x6a6
+#define MSR_IA32_PL3_SSP                0x6a7
+#define MSR_IA32_SSP_TBL                0x6a8
+#define MSR_KVM_GUEST_SSP               0x4b564d06
+
 #define XSTATE_FP_BIT                   0
 #define XSTATE_SSE_BIT                  1
 #define XSTATE_YMM_BIT                  2
@@ -1583,6 +1592,15 @@ typedef struct CPUX86State {
 
     uintptr_t retaddr;
 
+    uint64_t u_cet;
+    uint64_t s_cet;
+    uint64_t pl0_ssp;
+    uint64_t pl1_ssp;
+    uint64_t pl2_ssp;
+    uint64_t pl3_ssp;
+    uint64_t ssp_tbl;
+    uint64_t guest_ssp;
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6f18d940a5..3315d5dd4f 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3001,6 +3001,31 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         }
     }
 
+    if (((env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) ||
+        (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT)) &&
+        (env->features[FEAT_XSAVE_XSS_LO] & XSTATE_CET_U_MASK)) {
+        kvm_msr_entry_add(cpu, MSR_IA32_U_CET, env->u_cet);
+        kvm_msr_entry_add(cpu, MSR_IA32_PL3_SSP, env->pl3_ssp);
+    }
+
+    if (env->features[FEAT_XSAVE_XSS_LO] & XSTATE_CET_S_MASK) {
+        if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) {
+            kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, env->pl0_ssp);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL1_SSP, env->pl1_ssp);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL2_SSP, env->pl2_ssp);
+            kvm_msr_entry_add(cpu, MSR_IA32_SSP_TBL, env->ssp_tbl);
+        }
+
+        if (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT) {
+            kvm_msr_entry_add(cpu, MSR_IA32_S_CET, env->s_cet);
+        }
+    }
+
+    if ((env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) &&
+        (env->features[FEAT_XSAVE_XSS_LO] & (XSTATE_CET_U_MASK |
+        XSTATE_CET_S_MASK)))
+        kvm_msr_entry_add(cpu, MSR_KVM_GUEST_SSP, env->guest_ssp);
+
     return kvm_buf_set_msrs(cpu);
 }
 
@@ -3317,6 +3342,30 @@ static int kvm_get_msrs(X86CPU *cpu)
         }
     }
 
+    if (((env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) ||
+        (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT)) &&
+        (env->features[FEAT_XSAVE_XSS_LO] & XSTATE_CET_U_MASK)) {
+        kvm_msr_entry_add(cpu, MSR_IA32_U_CET, 0);
+        kvm_msr_entry_add(cpu, MSR_IA32_PL3_SSP, 0);
+    }
+
+    if (env->features[FEAT_XSAVE_XSS_LO] & XSTATE_CET_S_MASK) {
+        if (env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) {
+            kvm_msr_entry_add(cpu, MSR_IA32_PL0_SSP, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL1_SSP, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_PL2_SSP, 0);
+            kvm_msr_entry_add(cpu, MSR_IA32_SSP_TBL, 0);
+        }
+
+        if (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_CET_IBT) {
+            kvm_msr_entry_add(cpu, MSR_IA32_S_CET, 0);
+        }
+    }
+    if ((env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_CET_SHSTK) &&
+        (env->features[FEAT_XSAVE_XSS_LO] & (XSTATE_CET_U_MASK |
+        XSTATE_CET_S_MASK)))
+        kvm_msr_entry_add(cpu, MSR_KVM_GUEST_SSP, 0);
+
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, cpu->kvm_msr_buf);
     if (ret < 0) {
         return ret;
@@ -3600,6 +3649,30 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
             env->msr_rtit_addrs[index - MSR_IA32_RTIT_ADDR0_A] = msrs[i].data;
             break;
+        case MSR_IA32_U_CET:
+            env->u_cet = msrs[i].data;
+            break;
+        case MSR_IA32_S_CET:
+            env->s_cet = msrs[i].data;
+            break;
+        case MSR_IA32_PL0_SSP:
+            env->pl0_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_PL1_SSP:
+            env->pl1_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_PL2_SSP:
+            env->pl2_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_PL3_SSP:
+            env->pl3_ssp = msrs[i].data;
+            break;
+        case MSR_IA32_SSP_TBL:
+            env->ssp_tbl = msrs[i].data;
+            break;
+        case MSR_KVM_GUEST_SSP:
+            env->guest_ssp = msrs[i].data;
+            break;
         }
     }
 
-- 
2.26.2


