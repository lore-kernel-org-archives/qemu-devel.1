Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9743C47255
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 01:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 805E9208DB
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 01:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805E9208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXaz6-0005oe-Mh
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 21:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1jXay8-0003oU-Tv
 for qemu-devel@nongnu.org; Sat, 09 May 2020 21:41:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:59849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weijiang.yang@intel.com>)
 id 1jXay8-0006cQ-0a
 for qemu-devel@nongnu.org; Sat, 09 May 2020 21:41:28 -0400
IronPort-SDR: F7JXl7uP9UfrxvJ3ggL4alHLKEMoW71ULGQYWaphKKjkg0TEdlrW2ka9AKPcr/YB7oEMXSO+8y
 rYCFsRir9Ifg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2020 18:41:21 -0700
IronPort-SDR: cinDRlfI2mB7SBOmzz/Lwzu/cfAxMoVQzslMMWibGFDHzmAhquNfGzh6xGbN4m/JkBAjKU8Z0E
 ORf6DHVvYc8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,373,1583222400"; d="scan'208";a="264783135"
Received: from unknown (HELO local-michael-cet-test.sh.intel.com)
 ([10.239.159.128])
 by orsmga006.jf.intel.com with ESMTP; 09 May 2020 18:41:20 -0700
From: Yang Weijiang <weijiang.yang@intel.com>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com
Subject: [Qemu-devel][PATCH v5 3/4] x86/cpuid: Add support for XSAVES
 dependent feature enumeration
Date: Sun, 10 May 2020 09:42:49 +0800
Message-Id: <20200510014250.28111-4-weijiang.yang@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200510014250.28111-1-weijiang.yang@intel.com>
References: <20200510014250.28111-1-weijiang.yang@intel.com>
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=weijiang.yang@intel.com; helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 21:41:17
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Yang Weijiang <weijiang.yang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently XSAVES dependent features are not supported in CPUID enumeration,
update CPUID(0xD,n>=1) to enable it.

CET XSAVES related enumeration includes:
CPUID(0xD,1):ECX[bit 11]: user mode CET state, controls bit 11 in XSS.
CPUID(0xD,1):ECX[bit 12]: supervisor mode CET state, controls bit 12 in XSS.
CPUID(0xD,11): user mode CET state sub-leaf, reports the state size.
CPUID(0xD,12): supervisor mode CE state sub-leaf, reports the state size.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3174e05482..881c84a3b3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1513,6 +1513,12 @@ static inline uint64_t x86_cpu_xsave_components(X86CPU *cpu)
            cpu->env.features[FEAT_XSAVE_COMP_LO];
 }
 
+static inline uint64_t x86_cpu_xsave_sv_components(X86CPU *cpu)
+{
+    return ((uint64_t)cpu->env.features[FEAT_XSAVES_HI]) << 32 |
+           cpu->env.features[FEAT_XSAVES_LO];
+}
+
 const char *get_register_name_32(unsigned int reg)
 {
     if (reg >= CPU_NB_REGS32) {
@@ -5722,13 +5728,22 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              */
             *ebx = kvm_enabled() ? *ecx : xsave_area_size(env->xcr0);
         } else if (count == 1) {
+            /* ebx is updated in kvm.*/
             *eax = env->features[FEAT_XSAVE];
+            *ecx = env->features[FEAT_XSAVES_LO];
+            *edx = env->features[FEAT_XSAVES_HI];
         } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
             if ((x86_cpu_xsave_components(cpu) >> count) & 1) {
                 const ExtSaveArea *esa = &x86_ext_save_areas[count];
                 *eax = esa->size;
                 *ebx = esa->offset;
             }
+            if ((x86_cpu_xsave_sv_components(cpu) >> count) & 1) {
+                const ExtSaveArea *esa_sv = &x86_ext_save_areas[count];
+                *eax = esa_sv->size;
+                *ebx = 0;
+                *ecx = 1;
+            }
         }
         break;
     }
@@ -6280,8 +6295,10 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
         }
     }
 
-    env->features[FEAT_XSAVE_COMP_LO] = mask;
+    env->features[FEAT_XSAVE_COMP_LO] = mask & CPUID_XSTATE_USER_MASK;
     env->features[FEAT_XSAVE_COMP_HI] = mask >> 32;
+    env->features[FEAT_XSAVES_LO] = mask & CPUID_XSTATE_KERNEL_MASK;
+    env->features[FEAT_XSAVES_HI] = mask >> 32;
 }
 
 /***** Steps involved on loading and filtering CPUID data
-- 
2.17.2


