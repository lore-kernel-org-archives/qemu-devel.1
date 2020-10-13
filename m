Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175A1C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:12:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D2220797
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D2220797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSCbw-0003dI-6R
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 01:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1kSCa4-0001ta-9w
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:10:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:57350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1kSCa1-0006ZJ-Ew
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 01:10:36 -0400
IronPort-SDR: ymT2b6YYZ8Vj3AOb63uDR+7zWywRKT6vcBANDP0cvQATgpxPx5hBQupSraqfJ4i/ccSvIeimvC
 QLUFHhYASzqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="162385620"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="162385620"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 22:10:29 -0700
IronPort-SDR: 2XSUD42TvFGlSQ6SWVE9iIh+Xp6fam72GAeI1dE3HWpMu7crHlzOJQ2nuhwQwP/dQyVAFCrp+Y
 IjVPiYRWVYbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="420427121"
Received: from unknown (HELO local-michael-cet-test.sh.intel.com)
 ([10.239.159.128])
 by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2020 22:10:28 -0700
From: Yang Weijiang <weijiang.yang@intel.com>
To: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, sean.j.christopherson@intel.com, qemu-devel@nongnu.org
Subject: [Qemu-devel][PATCH v6 2/6] x86/cpuid: Enable XSS feature enumeration
 for CPUID
Date: Tue, 13 Oct 2020 13:19:31 +0800
Message-Id: <20201013051935.6052-3-weijiang.yang@intel.com>
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

Currently, CPUID.(EAX=0DH,ECX=01H) doesn't enumerate features in
XSS properly, add the support here. XCR0 bits indicate user-mode XSAVE
components, and XSS bits indicate supervisor-mode XSAVE components.

Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.c | 48 ++++++++++++++++++++++++++++++++++++++++++-----
 target/i386/cpu.h | 12 ++++++++++++
 2 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e2891740f1..38eab02b3d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1069,6 +1069,24 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_XSAVE_FEATURES,
     },
+    [FEAT_XSAVE_XSS_LO] = {
+        .type = CPUID_FEATURE_WORD,
+        .cpuid = {
+            .eax = 0xD,
+            .needs_ecx = true,
+            .ecx = 1,
+            .reg = R_ECX,
+        },
+    },
+    [FEAT_XSAVE_XSS_HI] = {
+        .type = CPUID_FEATURE_WORD,
+        .cpuid = {
+            .eax = 0xD,
+            .needs_ecx = true,
+            .ecx = 1,
+            .reg = R_EDX
+        },
+    },
     [FEAT_6_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -1489,6 +1507,9 @@ static uint32_t xsave_area_size(uint64_t mask)
     for (i = 0; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
         const ExtSaveArea *esa = &x86_ext_save_areas[i];
         if ((mask >> i) & 1) {
+            if (i >= 2 && !esa->offset) {
+                continue;
+            }
             ret = MAX(ret, esa->offset + esa->size);
         }
     }
@@ -1500,12 +1521,18 @@ static inline bool accel_uses_host_cpuid(void)
     return kvm_enabled() || hvf_enabled();
 }
 
-static inline uint64_t x86_cpu_xsave_components(X86CPU *cpu)
+static inline uint64_t x86_cpu_xsave_xcr0_components(X86CPU *cpu)
 {
     return ((uint64_t)cpu->env.features[FEAT_XSAVE_XCR0_HI]) << 32 |
            cpu->env.features[FEAT_XSAVE_XCR0_LO];
 }
 
+static inline uint64_t x86_cpu_xsave_xss_components(X86CPU *cpu)
+{
+    return ((uint64_t)cpu->env.features[FEAT_XSAVE_XSS_HI]) << 32 |
+           cpu->env.features[FEAT_XSAVE_XSS_LO];
+}
+
 const char *get_register_name_32(unsigned int reg)
 {
     if (reg >= CPU_NB_REGS32) {
@@ -5735,7 +5762,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
 
         if (count == 0) {
-            *ecx = xsave_area_size(x86_cpu_xsave_components(cpu));
+            *ecx = xsave_area_size(x86_cpu_xsave_xcr0_components(cpu));
             *eax = env->features[FEAT_XSAVE_XCR0_LO];
             *edx = env->features[FEAT_XSAVE_XCR0_HI];
             /*
@@ -5747,11 +5774,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ebx = kvm_enabled() ? *ecx : xsave_area_size(env->xcr0);
         } else if (count == 1) {
             *eax = env->features[FEAT_XSAVE_INSTRUCTION];
+            *ecx = env->features[FEAT_XSAVE_XSS_LO];
+            *edx = env->features[FEAT_XSAVE_XSS_HI];
         } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
-            if ((x86_cpu_xsave_components(cpu) >> count) & 1) {
-                const ExtSaveArea *esa = &x86_ext_save_areas[count];
+            const ExtSaveArea *esa = &x86_ext_save_areas[count];
+            if ((x86_cpu_xsave_xcr0_components(cpu) >> count) & 1) {
                 *eax = esa->size;
                 *ebx = esa->offset;
+            } else if ((x86_cpu_xsave_xss_components(cpu) >> count) & 1) {
+                *eax = esa->size;
+                *ebx = 0;
+                *ecx = 1;
             }
         }
         break;
@@ -6073,6 +6106,9 @@ static void x86_cpu_reset(DeviceState *dev)
     }
     for (i = 2; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
         const ExtSaveArea *esa = &x86_ext_save_areas[i];
+        if (!esa->offset) {
+            continue;
+        }
         if (env->features[esa->feature] & esa->bits) {
             xcr0 |= 1ull << i;
         }
@@ -6307,8 +6343,10 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
         }
     }
 
-    env->features[FEAT_XSAVE_XCR0_LO] = mask;
+    env->features[FEAT_XSAVE_XCR0_LO] = mask & CPUID_XSTATE_XCR0_MASK;
     env->features[FEAT_XSAVE_XCR0_HI] = mask >> 32;
+    env->features[FEAT_XSAVE_XSS_LO] = mask & CPUID_XSTATE_XSS_MASK;
+    env->features[FEAT_XSAVE_XSS_HI] = mask >> 32;
 }
 
 /***** Steps involved on loading and filtering CPUID data
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b86eb8dba0..10bf4d8b51 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -504,6 +504,16 @@ typedef enum X86Seg {
 #define XSTATE_Hi16_ZMM_MASK            (1ULL << XSTATE_Hi16_ZMM_BIT)
 #define XSTATE_PKRU_MASK                (1ULL << XSTATE_PKRU_BIT)
 
+/* CPUID feature bits available in XCR0 */
+#define CPUID_XSTATE_XCR0_MASK  (XSTATE_FP_MASK | XSTATE_SSE_MASK | \
+                                 XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | \
+                                 XSTATE_BNDCSR_MASK | XSTATE_OPMASK_MASK | \
+                                 XSTATE_ZMM_Hi256_MASK | \
+                                 XSTATE_Hi16_ZMM_MASK | XSTATE_PKRU_MASK)
+
+/* CPUID feature bits available in XSS */
+#define CPUID_XSTATE_XSS_MASK    0
+
 /* CPUID feature words */
 typedef enum FeatureWord {
     FEAT_1_EDX,         /* CPUID[1].EDX */
@@ -541,6 +551,8 @@ typedef enum FeatureWord {
     FEAT_VMX_EPT_VPID_CAPS,
     FEAT_VMX_BASIC,
     FEAT_VMX_VMFUNC,
+    FEAT_XSAVE_XSS_LO,     /* CPUID[EAX=0xd,ECX=1].ECX */
+    FEAT_XSAVE_XSS_HI,     /* CPUID[EAX=0xd,ECX=1].EDX */
     FEATURE_WORDS,
 } FeatureWord;
 
-- 
2.26.2


