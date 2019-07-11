Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B3EC74A45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 05:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D06208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 05:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D06208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlRj3-0002xC-2N
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 01:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54984)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jing2.liu@linux.intel.com>) id 1hlRiZ-0002XB-Ia
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 01:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jing2.liu@linux.intel.com>) id 1hlRiX-0002Oj-HT
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 01:34:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:63403)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
 id 1hlRiX-0001LD-7q
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 01:34:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jul 2019 22:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; d="scan'208";a="317576902"
Received: from liujing-dell.bj.intel.com ([10.238.145.70])
 by orsmga004.jf.intel.com with ESMTP; 10 Jul 2019 22:32:57 -0700
From: Jing Liu <jing2.liu@linux.intel.com>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com
Date: Thu, 11 Jul 2019 13:38:29 +0800
Message-Id: <1562823509-13072-1-git-send-email-jing2.liu@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
Subject: [Qemu-devel] [PATCH v1] x86: Intel AVX512_BF16 feature enabling
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
Cc: Jing Liu <jing2.liu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Intel CooperLake cpu adds AVX512_BF16 instruction, defining as
CPUID.(EAX=7,ECX=1):EAX[bit 05].

The release spec link as follows,
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf

Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 target/i386/cpu.c | 29 ++++++++++++++++++++++++++++-
 target/i386/cpu.h |  3 +++
 target/i386/kvm.c |  3 ++-
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c1ab86d..de3daf5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -767,6 +767,7 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           /* CPUID_7_0_ECX_OSPKE is dynamic */ \
           CPUID_7_0_ECX_LA57)
 #define TCG_7_0_EDX_FEATURES 0
+#define TCG_7_1_EAX_FEATURES 0
 #define TCG_APM_FEATURES 0
 #define TCG_6_EAX_FEATURES CPUID_6_EAX_ARAT
 #define TCG_XSAVE_FEATURES (CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1)
@@ -1092,6 +1093,25 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_7_0_EDX_FEATURES,
     },
+    [FEAT_7_1_EAX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, "avx512-bf16", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 7,
+            .needs_ecx = true, .ecx = 1,
+            .reg = R_EAX,
+        },
+        .tcg_features = TCG_7_1_EAX_FEATURES,
+    },
     [FEAT_8000_0007_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -4344,13 +4364,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     case 7:
         /* Structured Extended Feature Flags Enumeration Leaf */
         if (count == 0) {
-            *eax = 0; /* Maximum ECX value for sub-leaves */
+            /* Maximum ECX value for sub-leaves */
+            *eax = kvm_arch_get_supported_cpuid(cs->kvm_state, 0x7,
+                                                count, R_EAX);
             *ebx = env->features[FEAT_7_0_EBX]; /* Feature flags */
             *ecx = env->features[FEAT_7_0_ECX]; /* Feature flags */
             if ((*ecx & CPUID_7_0_ECX_PKU) && env->cr[4] & CR4_PKE_MASK) {
                 *ecx |= CPUID_7_0_ECX_OSPKE;
             }
             *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
+        } else if (count == 1) {
+            *eax = env->features[FEAT_7_1_EAX];
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
         } else {
             *eax = 0;
             *ebx = 0;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index bd06523..40594a1 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -488,6 +488,7 @@ typedef enum FeatureWord {
     FEAT_7_0_EBX,       /* CPUID[EAX=7,ECX=0].EBX */
     FEAT_7_0_ECX,       /* CPUID[EAX=7,ECX=0].ECX */
     FEAT_7_0_EDX,       /* CPUID[EAX=7,ECX=0].EDX */
+    FEAT_7_1_EAX,       /* CPUID[EAX=7,ECX=1].EAX */
     FEAT_8000_0001_EDX, /* CPUID[8000_0001].EDX */
     FEAT_8000_0001_ECX, /* CPUID[8000_0001].ECX */
     FEAT_8000_0007_EDX, /* CPUID[8000_0007].EDX */
@@ -699,6 +700,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
 
+#define CPUID_7_1_EAX_AVX512_BF16 (1U << 5) /* AVX512 BFloat16 Instruction */
+
 #define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and
                                                                              do not invalidate cache */
 #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 3b29ce5..977aaa5 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1110,6 +1110,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
                 c = &cpuid_data.entries[cpuid_i++];
             }
             break;
+        case 0x7:
         case 0x14: {
             uint32_t times;
 
@@ -1122,7 +1123,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
             for (j = 1; j <= times; ++j) {
                 if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
                     fprintf(stderr, "cpuid_data is full, no space for "
-                                "cpuid(eax:0x14,ecx:0x%x)\n", j);
+                                "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
                     abort();
                 }
                 c = &cpuid_data.entries[cpuid_i++];
-- 
1.8.3.1


