Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24845C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED16022CF4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED16022CF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyWd-0003PX-3d
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8z-0005zv-PD
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8x-0003pU-Mu
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45966)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8u-0003jl-Tv
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 978B0A38183;
 Tue, 20 Aug 2019 07:01:18 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 935BF60BE2;
 Tue, 20 Aug 2019 07:01:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:55 +0200
Message-Id: <1566284395-30287-37-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 20 Aug 2019 07:01:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 36/36] x86: Intel AVX512_BF16 feature enabling
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

From: Jing Liu <jing2.liu@linux.intel.com>

Intel CooperLake cpu adds AVX512_BF16 instruction, defining as
CPUID.(EAX=7,ECX=1):EAX[bit 05].

The patch adds a property for setting the subleaf of CPUID leaf 7 in
case that people would like to specify it.

The release spec link as follows,
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf

Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 39 ++++++++++++++++++++++++++++++++++++++-
 target/i386/cpu.h |  7 +++++++
 target/i386/kvm.c |  3 ++-
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b07bc06..0011831 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -770,6 +770,7 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           /* CPUID_7_0_ECX_OSPKE is dynamic */ \
           CPUID_7_0_ECX_LA57)
 #define TCG_7_0_EDX_FEATURES 0
+#define TCG_7_1_EAX_FEATURES 0
 #define TCG_APM_FEATURES 0
 #define TCG_6_EAX_FEATURES CPUID_6_EAX_ARAT
 #define TCG_XSAVE_FEATURES (CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1)
@@ -1095,6 +1096,25 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -4292,13 +4312,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     case 7:
         /* Structured Extended Feature Flags Enumeration Leaf */
         if (count == 0) {
-            *eax = 0; /* Maximum ECX value for sub-leaves */
+            /* Maximum ECX value for sub-leaves */
+            *eax = env->cpuid_level_func7;
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
@@ -4948,6 +4974,11 @@ static void x86_cpu_adjust_feat_level(X86CPU *cpu, FeatureWord w)
         x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel2, eax);
     break;
     }
+
+    if (eax == 7) {
+        x86_cpu_adjust_level(cpu, &env->cpuid_min_level_func7,
+                             fi->cpuid.ecx);
+    }
 }
 
 /* Calculate XSAVE components based on the configured CPU feature flags */
@@ -5066,6 +5097,7 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_1_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_6_EAX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);
@@ -5097,6 +5129,9 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     }
 
     /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set */
+    if (env->cpuid_level_func7 == UINT32_MAX) {
+        env->cpuid_level_func7 = env->cpuid_min_level_func7;
+    }
     if (env->cpuid_level == UINT32_MAX) {
         env->cpuid_level = env->cpuid_min_level;
     }
@@ -5870,6 +5905,8 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("host-phys-bits", X86CPU, host_phys_bits, false),
     DEFINE_PROP_UINT8("host-phys-bits-limit", X86CPU, host_phys_bits_limit, 0),
     DEFINE_PROP_BOOL("fill-mtrr-mask", X86CPU, fill_mtrr_mask, true),
+    DEFINE_PROP_UINT32("level-func7", X86CPU, env.cpuid_level_func7,
+                       UINT32_MAX),
     DEFINE_PROP_UINT32("level", X86CPU, env.cpuid_level, UINT32_MAX),
     DEFINE_PROP_UINT32("xlevel", X86CPU, env.cpuid_xlevel, UINT32_MAX),
     DEFINE_PROP_UINT32("xlevel2", X86CPU, env.cpuid_xlevel2, UINT32_MAX),
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 44e42f5..e4472e7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -479,6 +479,7 @@ typedef enum FeatureWord {
     FEAT_7_0_EBX,       /* CPUID[EAX=7,ECX=0].EBX */
     FEAT_7_0_ECX,       /* CPUID[EAX=7,ECX=0].ECX */
     FEAT_7_0_EDX,       /* CPUID[EAX=7,ECX=0].EDX */
+    FEAT_7_1_EAX,       /* CPUID[EAX=7,ECX=1].EAX */
     FEAT_8000_0001_EDX, /* CPUID[8000_0001].EDX */
     FEAT_8000_0001_ECX, /* CPUID[8000_0001].ECX */
     FEAT_8000_0007_EDX, /* CPUID[8000_0007].EDX */
@@ -692,6 +693,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_CORE_CAPABILITY   (1U << 30)  /*Core Capability*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
 
+#define CPUID_7_1_EAX_AVX512_BF16 (1U << 5) /* AVX512 BFloat16 Instruction */
+
 #define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and
                                                                              do not invalidate cache */
 #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
@@ -1323,6 +1326,10 @@ typedef struct CPUX86State {
     /* Fields after this point are preserved across CPU reset. */
 
     /* processor features (e.g. for CPUID insn) */
+    /* Minimum cpuid leaf 7 value */
+    uint32_t cpuid_level_func7;
+    /* Actual cpuid leaf 7 value */
+    uint32_t cpuid_min_level_func7;
     /* Minimum level/xlevel/xlevel2, based on CPU model + features */
     uint32_t cpuid_min_level, cpuid_min_xlevel, cpuid_min_xlevel2;
     /* Maximum level/xlevel/xlevel2 value for auto-assignment: */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ce3f1c3..6ecdcb7 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1498,6 +1498,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
                 c = &cpuid_data.entries[cpuid_i++];
             }
             break;
+        case 0x7:
         case 0x14: {
             uint32_t times;
 
@@ -1510,7 +1511,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
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


