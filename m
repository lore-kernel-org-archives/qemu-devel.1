Received: from eggs.gnu.org ([2001:4830:134:3::10]:48395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTei-00058b-6m
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fqTeg-0006A5-65
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fqTef-000691-Kc
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 21:34:21 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 16 Aug 2018 22:33:55 -0300
Message-Id: <20180817013400.13353-4-ehabkost@redhat.com>
In-Reply-To: <20180817013400.13353-1-ehabkost@redhat.com>
References: <20180817013400.13353-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 3/8] i386: Add CPUID bit and feature words for
 IA32_ARCH_CAPABILITIES MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>

From: Robert Hoo <robert.hu@linux.intel.com>

Support of IA32_PRED_CMD MSR already be enumerated by same CPUID bit as
SPEC_CTRL.

At present, mark CPUID_7_0_EDX_ARCH_CAPABILITIES unmigratable, per Paolo's
comment.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
Message-Id: <1530781798-183214-3-git-send-email-robert.hu@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 1 +
 target/i386/cpu.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b5c6686fe2..878444755f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -690,6 +690,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
+#define CPUID_7_0_EDX_ARCH_CAPABILITIES (1U << 29)  /*Arch Capabilities*/
 #define CPUID_7_0_EDX_SPEC_CTRL_SSBD  (1U << 31) /* Speculative Store Bypass Disable */
 
 #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 723e02221e..2bf9fcc556 100644
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
-- 
2.18.0.rc1.1.g3f1ff2140
