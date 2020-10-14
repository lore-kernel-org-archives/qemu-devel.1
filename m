Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70436C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:10:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDC020848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDC020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfcD-0003DK-KU
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kSfaR-0001m1-23
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:08:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:19469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luwei.kang@intel.com>)
 id 1kSfaO-0002rN-92
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 08:08:54 -0400
IronPort-SDR: gs1aoHkZQp6Q1vB0Ieav/X2EOFS+5df1/VROJ2vRzHuq+kWL8J09EeJ3mOnR0C3D+nctRAast8
 ZlMnx921PSjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="153033348"
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="153033348"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 05:08:48 -0700
IronPort-SDR: BsVcugjobaVBNfYBNqtEbpEdcTxBHJEifFKBszrwvPYIVblFbcAtiGhTJgECFJfaTSwIzMBzZA
 dWOwlMg1C3iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="463865092"
Received: from snr.bj.intel.com ([10.240.192.237])
 by orsmga004.jf.intel.com with ESMTP; 14 Oct 2020 05:08:46 -0700
From: Luwei Kang <luwei.kang@intel.com>
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Subject: [PATCH 1/2] i386/cpu: Add the Intel PT capabilities checking before
 extend the CPUID level
Date: Wed, 14 Oct 2020 16:04:42 +0800
Message-Id: <20201014080443.23751-1-luwei.kang@intel.com>
X-Mailer: git-send-email 2.18.4
Received-SPF: pass client-ip=134.134.136.20; envelope-from=luwei.kang@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 08:08:48
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Luwei Kang <luwei.kang@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current implementation will extend the CPUID level to 0x14 if
Intel PT is enabled in the guest(in x86_cpu_expand_features()) and
the Intel PT will be disabled if it can't pass the capabilities
checking later(in x86_cpu_filter_features()). In this case, the
level of CPUID will be still 0x14 and the CPUID values from leaf
0xe to 0x14 are all zero.

This patch moves the capabilities checking before setting the
level of the CPUID.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 target/i386/cpu.c | 63 ++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9eafbe3690..24644abfd4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6401,12 +6401,40 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 
         /* Intel Processor Trace requires CPUID[0x14] */
         if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
-            if (cpu->intel_pt_auto_level) {
-                x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
-            } else if (cpu->env.cpuid_min_level < 0x14) {
+            uint32_t eax_0, ebx_0, ecx_0, eax_1, ebx_1;
+
+            eax_0 = kvm_arch_get_supported_cpuid(kvm_state, 0x14, 0, R_EAX);
+            ebx_0 = kvm_arch_get_supported_cpuid(kvm_state, 0x14, 0, R_EBX);
+            ecx_0 = kvm_arch_get_supported_cpuid(kvm_state, 0x14, 0, R_ECX);
+            eax_1 = kvm_arch_get_supported_cpuid(kvm_state, 0x14, 1, R_EAX);
+            ebx_1 = kvm_arch_get_supported_cpuid(kvm_state, 0x14, 1, R_EBX);
+
+            if (eax_0 &&
+               ((ebx_0 & INTEL_PT_MINIMAL_EBX) == INTEL_PT_MINIMAL_EBX) &&
+               ((ecx_0 & INTEL_PT_MINIMAL_ECX) == INTEL_PT_MINIMAL_ECX) &&
+               ((eax_1 & INTEL_PT_MTC_BITMAP) == INTEL_PT_MTC_BITMAP) &&
+               ((eax_1 & INTEL_PT_ADDR_RANGES_NUM_MASK) >=
+                                           INTEL_PT_ADDR_RANGES_NUM) &&
+               ((ebx_1 & (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) ==
+                    (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) &&
+               !(ecx_0 & INTEL_PT_IP_LIP)) {
+                if (cpu->intel_pt_auto_level) {
+                    x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
+                } else if (cpu->env.cpuid_min_level < 0x14) {
+                    mark_unavailable_features(cpu, FEAT_7_0_EBX,
+                        CPUID_7_0_EBX_INTEL_PT,
+                        "Intel PT need CPUID leaf 0x14, please set by \"-cpu ...,+intel-pt,min-level=0x14\"");
+                }
+            } else {
+               /*
+                * Processor Trace capabilities aren't configurable, so if the
+                * host can't emulate the capabilities we report on
+                * cpu_x86_cpuid(), intel-pt can't be enabled on the current
+                * host.
+                */
                 mark_unavailable_features(cpu, FEAT_7_0_EBX,
                     CPUID_7_0_EBX_INTEL_PT,
-                    "Intel PT need CPUID leaf 0x14, please set by \"-cpu ...,+intel-pt,min-level=0x14\"");
+                    "host Intel PT features doesn't satisfy the guest request.");
             }
         }
 
@@ -6466,33 +6494,6 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
         uint64_t unavailable_features = requested_features & ~host_feat;
         mark_unavailable_features(cpu, w, unavailable_features, prefix);
     }
-
-    if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
-        kvm_enabled()) {
-        KVMState *s = CPU(cpu)->kvm_state;
-        uint32_t eax_0 = kvm_arch_get_supported_cpuid(s, 0x14, 0, R_EAX);
-        uint32_t ebx_0 = kvm_arch_get_supported_cpuid(s, 0x14, 0, R_EBX);
-        uint32_t ecx_0 = kvm_arch_get_supported_cpuid(s, 0x14, 0, R_ECX);
-        uint32_t eax_1 = kvm_arch_get_supported_cpuid(s, 0x14, 1, R_EAX);
-        uint32_t ebx_1 = kvm_arch_get_supported_cpuid(s, 0x14, 1, R_EBX);
-
-        if (!eax_0 ||
-           ((ebx_0 & INTEL_PT_MINIMAL_EBX) != INTEL_PT_MINIMAL_EBX) ||
-           ((ecx_0 & INTEL_PT_MINIMAL_ECX) != INTEL_PT_MINIMAL_ECX) ||
-           ((eax_1 & INTEL_PT_MTC_BITMAP) != INTEL_PT_MTC_BITMAP) ||
-           ((eax_1 & INTEL_PT_ADDR_RANGES_NUM_MASK) <
-                                           INTEL_PT_ADDR_RANGES_NUM) ||
-           ((ebx_1 & (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) !=
-                (INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP)) ||
-           (ecx_0 & INTEL_PT_IP_LIP)) {
-            /*
-             * Processor Trace capabilities aren't configurable, so if the
-             * host can't emulate the capabilities we report on
-             * cpu_x86_cpuid(), intel-pt can't be enabled on the current host.
-             */
-            mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT, prefix);
-        }
-    }
 }
 
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.18.4


