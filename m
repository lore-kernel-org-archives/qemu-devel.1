Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5767AC1975A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288C6206F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 03:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288C6206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGDaA-0000aq-Bt
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 23:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiaoyao.li@intel.com>) id 1jGDY5-0005ih-IK
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiaoyao.li@intel.com>) id 1jGDY4-0003gC-90
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:14:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:56660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <xiaoyao.li@intel.com>)
 id 1jGDY3-0003fq-UT
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 23:14:44 -0400
IronPort-SDR: 8xGx7k2Ccaj7baqWqXbHRmzmnf3/2x1kgF6QWfU4WHxLaJiStsYBLXHaTbzWr3r14tXJOmgcL6
 yMFF8T9L0fKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2020 20:14:42 -0700
IronPort-SDR: Gg+QmSZ8XLK3JGiAcInv8v2C/jGZtEXMFOu8gL1rc12E5hYuMeikfstiUIPjnpYrAk6dz6rqwo
 ULjSfFlndTVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,294,1580803200"; d="scan'208";a="292453684"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.161])
 by FMSMGA003.fm.intel.com with ESMTP; 22 Mar 2020 20:14:40 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 2/3] target/i386: Add support for TEST_CTRL MSR
Date: Mon, 23 Mar 2020 10:56:57 +0800
Message-Id: <20200323025658.4540-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323025658.4540-1-xiaoyao.li@intel.com>
References: <20200323025658.4540-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.100
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
Cc: Xiaoyao Li <xiaoyao.li@linux.intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xiaoyao Li <xiaoyao.li@linux.intel.com>

MSR_TEST_CTRL is needed and accessed by feature split lock detection.

Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
---
 target/i386/cpu.h     |  2 ++
 target/i386/kvm.c     | 13 +++++++++++++
 target/i386/machine.c | 20 ++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f6c54412ba5e..177732ad19da 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -343,6 +343,7 @@ typedef enum X86Seg {
 #define MSR_IA32_APICBASE_ENABLE        (1<<11)
 #define MSR_IA32_APICBASE_EXTD          (1 << 10)
 #define MSR_IA32_APICBASE_BASE          (0xfffffU<<12)
+#define MSR_TEST_CTRL                   0x33
 #define MSR_IA32_FEATURE_CONTROL        0x0000003a
 #define MSR_TSC_ADJUST                  0x0000003b
 #define MSR_IA32_SPEC_CTRL              0x48
@@ -1466,6 +1467,7 @@ typedef struct CPUX86State {
 
     uint64_t spec_ctrl;
     uint64_t virt_ssbd;
+    uint64_t msr_test_ctrl;
 
     /* End of state preserved by INIT (dummy marker).  */
     struct {} end_init_save;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6888cb7caeae..411402aa29fa 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -101,6 +101,7 @@ static bool has_msr_umwait;
 static bool has_msr_spec_ctrl;
 static bool has_msr_tsx_ctrl;
 static bool has_msr_virt_ssbd;
+static bool has_msr_test_ctrl;
 static bool has_msr_smi_count;
 static bool has_msr_arch_capabs;
 static bool has_msr_core_capabs;
@@ -2048,6 +2049,9 @@ static int kvm_get_supported_msrs(KVMState *s)
             case MSR_VIRT_SSBD:
                 has_msr_virt_ssbd = true;
                 break;
+            case MSR_TEST_CTRL:
+                has_msr_test_ctrl = true;
+                break;
             case MSR_IA32_ARCH_CAPABILITIES:
                 has_msr_arch_capabs = true;
                 break;
@@ -2766,6 +2770,9 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
     if (has_msr_virt_ssbd) {
         kvm_msr_entry_add(cpu, MSR_VIRT_SSBD, env->virt_ssbd);
     }
+    if (has_msr_test_ctrl) {
+        kvm_msr_entry_add(cpu, MSR_TEST_CTRL, env->msr_test_ctrl);
+    }
 
 #ifdef TARGET_X86_64
     if (lm_capable_kernel) {
@@ -3154,6 +3161,9 @@ static int kvm_get_msrs(X86CPU *cpu)
     if (has_msr_virt_ssbd) {
         kvm_msr_entry_add(cpu, MSR_VIRT_SSBD, 0);
     }
+    if (has_msr_test_ctrl) {
+        kvm_msr_entry_add(cpu, MSR_TEST_CTRL, 0);
+    }
     if (!env->tsc_valid) {
         kvm_msr_entry_add(cpu, MSR_IA32_TSC, 0);
         env->tsc_valid = !runstate_is_running();
@@ -3549,6 +3559,9 @@ static int kvm_get_msrs(X86CPU *cpu)
         case MSR_VIRT_SSBD:
             env->virt_ssbd = msrs[i].data;
             break;
+        case MSR_TEST_CTRL:
+            env->msr_test_ctrl = msrs[i].data;
+            break;
         case MSR_IA32_RTIT_CTL:
             env->msr_rtit_ctrl = msrs[i].data;
             break;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 0c96531a56f0..a23c6687d5ba 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1252,6 +1252,25 @@ static const VMStateDescription vmstate_msr_virt_ssbd = {
     }
 };
 
+static bool msr_test_ctrl_needed(void *opaque)
+{
+    X86CPU *cpu = opaque;
+    CPUX86State *env = &cpu->env;
+
+    return env->msr_test_ctrl != 0;
+}
+
+static const VMStateDescription vmstate_msr_test_ctrl = {
+    .name = "cpu/msr_test_ctrl",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = msr_test_ctrl_needed,
+    .fields = (VMStateField[]){
+        VMSTATE_UINT64(env.msr_test_ctrl, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool svm_npt_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -1439,6 +1458,7 @@ VMStateDescription vmstate_x86_cpu = {
         &vmstate_mcg_ext_ctl,
         &vmstate_msr_intel_pt,
         &vmstate_msr_virt_ssbd,
+        &vmstate_msr_test_ctrl,
         &vmstate_svm_npt,
 #ifndef TARGET_X86_64
         &vmstate_efer32,
-- 
2.20.1


