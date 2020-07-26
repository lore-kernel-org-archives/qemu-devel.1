Return-Path: <SRS0=rO5d=BF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1CFC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 15:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9EF920714
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2020 15:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EF920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzijj-0000Bw-Uo
	for qemu-devel@archiver.kernel.org; Sun, 26 Jul 2020 11:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1jzigq-0006ru-OT
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 11:35:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:35244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <like.xu@linux.intel.com>)
 id 1jzign-0003UO-TC
 for qemu-devel@nongnu.org; Sun, 26 Jul 2020 11:35:52 -0400
IronPort-SDR: XqgTA7TpALzinvZ0L6pF8bgsUd9R6Nxf3xoHTvJ1+E2OOr6pKmzrLokMKJdKEWPhjTB9RrRq2N
 gSuwz7bmHf0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="212437193"
X-IronPort-AV: E=Sophos;i="5.75,399,1589266800"; d="scan'208";a="212437193"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2020 08:34:46 -0700
IronPort-SDR: vxspwqeHLJVp8zYHCu9lL8ndMhtakzWTni51jaPdnDq9vBZ7qBOMTekiYhPw7To0chsq4p4TbB
 W9SnT/+3N38g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,399,1589266800"; d="scan'208";a="303177524"
Received: from sqa-gate.sh.intel.com (HELO clx-ap-likexu.tsp.org)
 ([10.239.48.212])
 by orsmga002.jf.intel.com with ESMTP; 26 Jul 2020 08:34:43 -0700
From: Like Xu <like.xu@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>,
 kvm@vger.kernel.org
Subject: [PATCH] target/i386: add -cpu,lbr=true support to enable guest LBR
Date: Sun, 26 Jul 2020 23:32:20 +0800
Message-Id: <20200726153229.27149-3-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200726153229.27149-1-like.xu@linux.intel.com>
References: <20200726153229.27149-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=like.xu@linux.intel.com; helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/26 11:34:47
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Wanpeng Li <wanpengli@tencent.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Like Xu <like.xu@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Joerg Roedel <joro@8bytes.org>, Marcelo Tosatti <mtosatti@redhat.com>,
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The LBR feature would be enabled on the guest if:
- the KVM is enabled and the PMU is enabled and,
- the msr-based-feature IA32_PERF_CAPABILITIES is supporterd and,
- the supported returned value for lbr_fmt from this msr is not zero.

The LBR feature would be disabled on the guest if:
- the msr-based-feature IA32_PERF_CAPABILITIES is unsupporterd OR,
- qemu set the IA32_PERF_CAPABILITIES msr feature without lbr_fmt values OR,
- the requested guest vcpu model doesn't support PDCM.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 hw/i386/pc.c      |  1 +
 target/i386/cpu.c | 24 ++++++++++++++++++++++--
 target/i386/cpu.h |  2 ++
 target/i386/kvm.c |  7 ++++++-
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3d419d5991..857aff75bb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -318,6 +318,7 @@ GlobalProperty pc_compat_1_5[] = {
     { "Nehalem-" TYPE_X86_CPU, "min-level", "2" },
     { "virtio-net-pci", "any_layout", "off" },
     { TYPE_X86_CPU, "pmu", "on" },
+    { TYPE_X86_CPU, "lbr", "on" },
     { "i440FX-pcihost", "short_root_bus", "0" },
     { "q35-pcihost", "short_root_bus", "0" },
 };
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 588f32e136..c803994887 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1142,8 +1142,8 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_PERF_CAPABILITIES] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            "lbr-fmt-bit-0", "lbr-fmt-bit-1", "lbr-fmt-bit-2", "lbr-fmt-bit-3",
+            "lbr-fmt-bit-4", "lbr-fmt-bit-5", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, "full-width-write", NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -4224,6 +4224,12 @@ static bool lmce_supported(void)
     return !!(mce_cap & MCG_LMCE_P);
 }
 
+static inline bool lbr_supported(void)
+{
+    return kvm_enabled() && (kvm_arch_get_supported_msr_feature(kvm_state,
+        MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_LBR_FMT);
+}
+
 #define CPUID_MODEL_ID_SZ 48
 
 /**
@@ -4327,6 +4333,9 @@ static void max_x86_cpu_initfn(Object *obj)
     }
 
     object_property_set_bool(OBJECT(cpu), "pmu", true, &error_abort);
+    if (lbr_supported()) {
+        object_property_set_bool(OBJECT(cpu), "lbr", true, &error_abort);
+    }
 }
 
 static const TypeInfo max_x86_cpu_type_info = {
@@ -5535,6 +5544,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         if (!cpu->enable_pmu) {
             *ecx &= ~CPUID_EXT_PDCM;
+            if (cpu->enable_lbr) {
+                warn_report("LBR is unsupported since guest PMU is disabled.");
+                exit(1);
+            }
         }
         break;
     case 2:
@@ -6553,6 +6566,12 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
+    if (!cpu->max_features && cpu->enable_lbr &&
+        !(env->features[FEAT_1_ECX] & CPUID_EXT_PDCM)) {
+        warn_report("requested vcpu model doesn't support PDCM for LBR.");
+        exit(1);
+    }
+
     if (cpu->ucode_rev == 0) {
         /* The default is the same as KVM's.  */
         if (IS_AMD_CPU(env)) {
@@ -7187,6 +7206,7 @@ static Property x86_cpu_properties[] = {
 #endif
     DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
+    DEFINE_PROP_BOOL("lbr", X86CPU, enable_lbr, false),
 
     DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
                        HYPERV_SPINLOCK_NEVER_RETRY),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e1a5c174dc..a059913e26 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -357,6 +357,7 @@ typedef enum X86Seg {
 #define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
 
 #define MSR_IA32_PERF_CAPABILITIES      0x345
+#define PERF_CAP_LBR_FMT      0x3f
 
 #define MSR_IA32_TSX_CTRL		0x122
 #define MSR_IA32_TSCDEADLINE            0x6e0
@@ -1702,6 +1703,7 @@ struct X86CPU {
      * capabilities) directly to the guest.
      */
     bool enable_pmu;
+    bool enable_lbr;
 
     /* LMCE support can be enabled/disabled via cpu option 'lmce=on/off'. It is
      * disabled by default to avoid breaking migration between QEMU with
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index b8455c89ed..feb33d5472 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -2690,8 +2690,10 @@ static void kvm_msr_entry_add_perf(X86CPU *cpu, FeatureWordArray f)
     uint64_t kvm_perf_cap =
         kvm_arch_get_supported_msr_feature(kvm_state,
                                            MSR_IA32_PERF_CAPABILITIES);
-
     if (kvm_perf_cap) {
+        if (!cpu->enable_lbr) {
+            kvm_perf_cap &= ~PERF_CAP_LBR_FMT;
+        }
         kvm_msr_entry_add(cpu, MSR_IA32_PERF_CAPABILITIES,
                         kvm_perf_cap & f[FEAT_PERF_CAPABILITIES]);
     }
@@ -2731,6 +2733,9 @@ static void kvm_init_msrs(X86CPU *cpu)
 
     if (has_msr_perf_capabs && cpu->enable_pmu) {
         kvm_msr_entry_add_perf(cpu, env->features);
+    } else if (!has_msr_perf_capabs && cpu->enable_lbr) {
+        warn_report("KVM doesn't support MSR_IA32_PERF_CAPABILITIES for LBR.");
+        exit(1);
     }
 
     if (has_msr_ucode_rev) {
-- 
2.21.3


