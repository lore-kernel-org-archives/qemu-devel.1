Received: from eggs.gnu.org ([2001:4830:134:3::10]:42456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fb0HB-0000rk-9D
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fb0H7-00074k-4v
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:10:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:23698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fb0H6-0006vV-Ol
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:10:05 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Thu,  5 Jul 2018 17:09:55 +0800
Message-Id: <1530781798-183214-3-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1530781798-183214-1-git-send-email-robert.hu@linux.intel.com>
References: <1530781798-183214-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v4 2/5] i386: Add CPUID bit and feature words
 for IA32_ARCH_CAPABILITIES MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: robert.hu@intel.com, wei.w.wang@intel.com, jingqi.liu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

Support of IA32_PRED_CMD MSR already be enumerated by same CPUID bit as
SPEC_CTRL.

At present, mark CPUID_7_0_EDX_ARCH_CAPABILITIES unmigratable, per Paolo's
comment.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 target/i386/cpu.c | 3 ++-
 target/i386/cpu.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b0b87c3..878b1ce 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1000,12 +1000,13 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", NULL,
-            NULL, NULL, NULL, "ssbd",
+            NULL, "arch-capabilities", NULL, "ssbd",
         },
         .cpuid_eax = 7,
         .cpuid_needs_ecx = true, .cpuid_ecx = 0,
         .cpuid_reg = R_EDX,
         .tcg_features = TCG_7_0_EDX_FEATURES,
+        .unmigratable_flags = CPUID_7_0_EDX_ARCH_CAPABILITIES,
     },
     [FEAT_8000_0007_EDX] = {
         .feat_names = {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ae97005..c2b297b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -690,6 +690,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
+#define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
 
 #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
-- 
1.8.3.1
