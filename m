Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75C9C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 05:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB0D206BB
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 05:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB0D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Czf-00075r-Rr
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 01:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luwei.kang@intel.com>) id 1i3Cxi-0005fV-1m
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 01:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luwei.kang@intel.com>) id 1i3Cxg-0006cB-2m
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 01:27:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:2709)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luwei.kang@intel.com>)
 id 1i3Cxf-0006aN-QC
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 01:27:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Aug 2019 22:27:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; d="scan'208";a="171783751"
Received: from icl-2s.bj.intel.com ([10.240.193.48])
 by orsmga007.jf.intel.com with ESMTP; 28 Aug 2019 22:27:02 -0700
From: Luwei Kang <luwei.kang@intel.com>
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Date: Thu, 29 Aug 2019 13:22:55 +0800
Message-Id: <1567056175-14275-2-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567056175-14275-1-git-send-email-luwei.kang@intel.com>
References: <1567056175-14275-1-git-send-email-luwei.kang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
Subject: [Qemu-devel] [PATCH 2/2] target/i386: Add support for put/get PEBS
 registers
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
Cc: Luwei Kang <luwei.kang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch add a new feature words for IA32_PERF_CAPABILITIES (RO)
register that serve to expose PEBS output Intel PT feature.
The registers relate with PEBS need to be set/get when PEBS output
Intel PT is supported in guest.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 target/i386/cpu.c | 20 ++++++++++++++++++++
 target/i386/cpu.h |  4 ++++
 target/i386/kvm.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9e0bac3..7fe34c0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1244,6 +1244,26 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             },
         },
     },
+    [FEAT_PERF_CAPABILITIES] = {
+        .type = MSR_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            "pebs-output-pt", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .msr = {
+            .index = MSR_IA32_PERF_CAPABILITIES,
+            .cpuid_dep = {
+                FEAT_1_ECX,
+                CPUID_EXT_PDCM,
+            },
+        },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d7cec36..0904004 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -347,6 +347,7 @@ typedef enum X86Seg {
 #define MSR_IA32_PRED_CMD               0x49
 #define MSR_IA32_CORE_CAPABILITY        0xcf
 #define MSR_IA32_ARCH_CAPABILITIES      0x10a
+#define MSR_IA32_PERF_CAPABILITIES      0x345
 #define MSR_IA32_TSCDEADLINE            0x6e0
 
 #define FEATURE_CONTROL_LOCKED                    (1<<0)
@@ -503,6 +504,7 @@ typedef enum FeatureWord {
     FEAT_XSAVE_COMP_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
     FEAT_ARCH_CAPABILITIES,
     FEAT_CORE_CAPABILITY,
+    FEAT_PERF_CAPABILITIES,
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -754,6 +756,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
 
+#define MSR_PERF_CAP_PEBS_VIA_PT        (1ULL << 16)
+
 /* Supported Hyper-V Enlightenments */
 #define HYPERV_FEAT_RELAXED             0
 #define HYPERV_FEAT_VAPIC               1
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 8023c67..c0dcc13 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2651,6 +2651,20 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
                 kvm_msr_entry_add(cpu, MSR_IA32_RTIT_ADDR0_A + i,
                             env->msr_rtit_addrs[i]);
             }
+
+            if (env->features[FEAT_PERF_CAPABILITIES] &
+                                        MSR_PERF_CAP_PEBS_VIA_PT) {
+                kvm_msr_entry_add(cpu, MSR_IA32_PEBS_ENABLE,
+                                env->msr_pebs_enable);
+                for (i = 0; i < num_architectural_pmu_fixed_counters; i++) {
+                    kvm_msr_entry_add(cpu, MSR_RELOAD_FIXED_CTR0 + i,
+                                env->msr_reload_fixed_ctr[i]);
+                }
+                for (i = 0; i < num_architectural_pmu_gp_counters; i++) {
+                    kvm_msr_entry_add(cpu, MSR_RELOAD_PMC0 + i,
+                                env->msr_reload_pmc[i]);
+                }
+            }
         }
 
         /* Note: MSR_IA32_FEATURE_CONTROL is written separately, see
@@ -2989,6 +3003,16 @@ static int kvm_get_msrs(X86CPU *cpu)
         for (i = 0; i < addr_num; i++) {
             kvm_msr_entry_add(cpu, MSR_IA32_RTIT_ADDR0_A + i, 0);
         }
+
+        if (env->features[FEAT_PERF_CAPABILITIES] & MSR_PERF_CAP_PEBS_VIA_PT) {
+            kvm_msr_entry_add(cpu, MSR_IA32_PEBS_ENABLE, 0);
+            for (i = 0; i < num_architectural_pmu_fixed_counters; i++) {
+                kvm_msr_entry_add(cpu, MSR_RELOAD_FIXED_CTR0 + i, 0);
+            }
+            for (i = 0; i < num_architectural_pmu_gp_counters; i++) {
+                kvm_msr_entry_add(cpu, MSR_RELOAD_PMC0 + i, 0);
+            }
+        }
     }
 
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, cpu->kvm_msr_buf);
@@ -3268,6 +3292,18 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
             env->msr_rtit_addrs[index - MSR_IA32_RTIT_ADDR0_A] = msrs[i].data;
             break;
+        case MSR_IA32_PEBS_ENABLE:
+            env->msr_pebs_enable = msrs[i].data;
+            break;
+        case MSR_RELOAD_FIXED_CTR0 ...
+                                MSR_RELOAD_FIXED_CTR0 + MAX_FIXED_COUNTERS - 1:
+            env->msr_reload_fixed_ctr[index - MSR_RELOAD_FIXED_CTR0] =
+                                                                msrs[i].data;
+            break;
+        case MSR_RELOAD_PMC0 ...
+                                MSR_RELOAD_PMC0 + MAX_GP_COUNTERS - 1:
+            env->msr_reload_fixed_ctr[index - MSR_RELOAD_PMC0] = msrs[i].data;
+            break;
         }
     }
 
-- 
1.8.3.1


