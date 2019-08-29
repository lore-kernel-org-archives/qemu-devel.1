Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1642C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 05:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8508A206BB
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 05:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8508A206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Cyc-000679-LJ
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 01:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luwei.kang@intel.com>) id 1i3Cxi-0005fU-1c
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 01:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luwei.kang@intel.com>) id 1i3Cxg-0006cG-36
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 01:27:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:2696)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luwei.kang@intel.com>)
 id 1i3Cxf-0006Ye-PU
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 01:27:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Aug 2019 22:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,442,1559545200"; d="scan'208";a="171783713"
Received: from icl-2s.bj.intel.com ([10.240.193.48])
 by orsmga007.jf.intel.com with ESMTP; 28 Aug 2019 22:26:57 -0700
From: Luwei Kang <luwei.kang@intel.com>
To: pbonzini@redhat.com,
	rth@twiddle.net,
	ehabkost@redhat.com
Date: Thu, 29 Aug 2019 13:22:54 +0800
Message-Id: <1567056175-14275-1-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.88
Subject: [Qemu-devel] [PATCH 1/2] target/i386: Add support for save PEBS
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

Intel processor introduce some hardware extensions that output PEBS record
to Intel PT buffer instead of DS area, so PEBS can be enabled in KVM guest
by PEBS output Intel PT. This patch adds a section for PEBS which use for
saves PEBS registers when the value is no-zero.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 target/i386/cpu.h     |  8 ++++++++
 target/i386/machine.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5f6e3a0..d7cec36 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -409,6 +409,10 @@ typedef enum X86Seg {
 #define MSR_CORE_PERF_GLOBAL_CTRL       0x38f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL   0x390
 
+#define MSR_IA32_PEBS_ENABLE            0x3f1
+#define MSR_RELOAD_FIXED_CTR0           0x1309
+#define MSR_RELOAD_PMC0                 0x14c1
+
 #define MSR_MC0_CTL                     0x400
 #define MSR_MC0_STATUS                  0x401
 #define MSR_MC0_ADDR                    0x402
@@ -1291,6 +1295,10 @@ typedef struct CPUX86State {
     uint64_t msr_rtit_cr3_match;
     uint64_t msr_rtit_addrs[MAX_RTIT_ADDRS];
 
+    uint64_t msr_pebs_enable;
+    uint64_t msr_reload_fixed_ctr[MAX_FIXED_COUNTERS];
+    uint64_t msr_reload_pmc[MAX_GP_COUNTERS];
+
     /* exception/interrupt handling */
     int error_code;
     int exception_is_int;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 2767b30..334d703 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1274,6 +1274,46 @@ static const VMStateDescription vmstate_efer32 = {
 };
 #endif
 
+static bool pebs_enable_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+    int i;
+
+    if (env->msr_pebs_enable) {
+        return true;
+    }
+
+    for (i = 0; i < MAX_FIXED_COUNTERS; i++) {
+        if (env->msr_reload_fixed_ctr[i]) {
+            return true;
+        }
+    }
+
+    for (i = 0; i < MAX_GP_COUNTERS; i++) {
+        if (env->msr_reload_pmc[i]) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static const VMStateDescription vmstate_msr_pebs = {
+    .name = "cpu/pebs",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = pebs_enable_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(env.msr_pebs_enable, X86CPU),
+        VMSTATE_UINT64_ARRAY(env.msr_reload_fixed_ctr, X86CPU,
+                                MAX_FIXED_COUNTERS),
+        VMSTATE_UINT64_ARRAY(env.msr_reload_pmc, X86CPU,
+                                MAX_GP_COUNTERS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 VMStateDescription vmstate_x86_cpu = {
     .name = "cpu",
     .version_id = 12,
@@ -1407,6 +1447,7 @@ VMStateDescription vmstate_x86_cpu = {
 #ifdef CONFIG_KVM
         &vmstate_nested_state,
 #endif
+        &vmstate_msr_pebs,
         NULL
     }
 };
-- 
1.8.3.1


