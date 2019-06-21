Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20207C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 07:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E512D2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 07:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E512D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55172 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heDZG-0002Ia-Mn
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 03:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57475)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1heDRO-0006bg-P2
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1heDRM-0002P9-RU
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:54:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:33605)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1heDRM-0001rD-FO
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:54:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Jun 2019 23:54:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,399,1557212400"; d="scan'208";a="335735526"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.104])
 by orsmga005.jf.intel.com with ESMTP; 20 Jun 2019 23:54:09 -0700
From: Tao Xu <tao3.xu@intel.com>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 cohuck@redhat.com, mst@redhat.com, mtosatti@redhat.com
Date: Fri, 21 Jun 2019 14:51:33 +0800
Message-Id: <20190621065134.7392-2-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621065134.7392-1-tao3.xu@intel.com>
References: <20190621065134.7392-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: [Qemu-devel] [PATCH RESEND v3 1/2] x86/cpu: Add support for
 UMONITOR/UMWAIT/TPAUSE
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, xiaoyao.li@linux.intel.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UMONITOR, UMWAIT and TPAUSE are a set of user wait instructions.
This patch adds support for user wait instructions in KVM. Availability
of the user wait instructions is indicated by the presence of the CPUID
feature flag WAITPKG CPUID.0x07.0x0:ECX[5]. User wait instructions may
be executed at any privilege level, and use IA32_UMWAIT_CONTROL MSR to
set the maximum time.

The patch enable the umonitor, umwait and tpause features in KVM.
Because umwait and tpause can put a (psysical) CPU into a power saving
state, by default we dont't expose it to kvm and enable it only when
guest CPUID has it. And use QEMU command-line "-overcommit cpu-pm=on"
(enable_cpu_pm is enabled), a VM can use UMONITOR, UMWAIT and TPAUSE
instructions. If the instruction causes a delay, the amount of time
delayed is called here the physical delay. The physical delay is first
computed by determining the virtual delay (the time to delay relative to
the VM’s timestamp counter). Otherwise, UMONITOR, UMWAIT and TPAUSE cause
an invalid-opcode exception(#UD).

The release document ref below link:
https://software.intel.com/sites/default/files/\
managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf

Co-developed-by: Jingqi Liu <jingqi.liu@intel.com>
Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

changes in v3:
	Simplify the patches, expose user wait instructions when the guest
	has CPUID (Paolo)
	Resend to update the dependcy KVM link:
	https://lkml.org/lkml/2019/6/21/23
---
 target/i386/cpu.c | 3 ++-
 target/i386/cpu.h | 1 +
 target/i386/kvm.c | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fbed2eb804..0fb86c90db 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1060,7 +1060,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, "avx512vbmi", "umip", "pku",
-            NULL /* ospke */, NULL, "avx512vbmi2", NULL,
+            NULL /* ospke */, "waitpkg", "avx512vbmi2", NULL,
             "gfni", "vaes", "vpclmulqdq", "avx512vnni",
             "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
@@ -5222,6 +5222,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
                        &cpu->mwait.ecx, &cpu->mwait.edx);
             env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
+            env->features[FEAT_7_0_ECX] |= CPUID_7_0_ECX_WAITPKG;
         }
     }
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0732e059ec..2f7c57a3c2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -670,6 +670,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_ECX_UMIP     (1U << 2)
 #define CPUID_7_0_ECX_PKU      (1U << 3)
 #define CPUID_7_0_ECX_OSPKE    (1U << 4)
+#define CPUID_7_0_ECX_WAITPKG  (1U << 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
 #define CPUID_7_0_ECX_VBMI2    (1U << 6) /* Additional VBMI Instrs */
 #define CPUID_7_0_ECX_GFNI     (1U << 8)
 #define CPUID_7_0_ECX_VAES     (1U << 9)
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6899061b4e..3efdb90f11 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -388,6 +388,10 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         if (host_tsx_blacklisted()) {
             ret &= ~(CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_HLE);
         }
+    } else if (function == 7 && index == 0 && reg == R_ECX) {
+        if (enable_cpu_pm) {
+            ret |= CPUID_7_0_ECX_WAITPKG;
+        }
     } else if (function == 7 && index == 0 && reg == R_EDX) {
         /*
          * Linux v4.17-v4.20 incorrectly return ARCH_CAPABILITIES on SVM hosts.
-- 
2.20.1


