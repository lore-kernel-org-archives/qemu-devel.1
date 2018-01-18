Received: from eggs.gnu.org ([2001:4830:134:3::10]:43442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzX1-0002SN-OE
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzX0-00040o-UD
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:02:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ebzX0-00040J-Ld
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:02:18 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Jan 2018 00:01:55 -0200
Message-Id: <20180118020157.25401-7-ehabkost@redhat.com>
In-Reply-To: <20180118020157.25401-1-ehabkost@redhat.com>
References: <20180118020157.25401-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 6/8] i386: Add FEAT_8000_0008_EBX CPUID feature
 word
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

Add the new feature word and the "ibpb" feature flag.

Based on a patch by Paolo Bonzini.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180109154519.25634-5-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h |  3 +++
 target/i386/cpu.c | 19 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d7bae242cd..30cc5628d2 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -472,6 +472,7 @@ typedef enum FeatureWord {
     FEAT_8000_0001_EDX, /* CPUID[8000_0001].EDX */
     FEAT_8000_0001_ECX, /* CPUID[8000_0001].ECX */
     FEAT_8000_0007_EDX, /* CPUID[8000_0007].EDX */
+    FEAT_8000_0008_EBX, /* CPUID[8000_0008].EBX */
     FEAT_C000_0001_EDX, /* CPUID[C000_0001].EDX */
     FEAT_KVM,           /* CPUID[4000_0001].EAX (KVM_CPUID_FEATURES) */
     FEAT_HYPERV_EAX,    /* CPUID[4000_0003].EAX */
@@ -669,6 +670,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
 #define CPUID_7_0_EDX_SPEC_CTRL     (1U << 26) /* Speculation Control */
 
+#define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
+
 #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
 #define CPUID_XSAVE_XGETBV1    (1U << 2)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7f815458a5..6fe14362cc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -483,6 +483,22 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .tcg_features = TCG_APM_FEATURES,
         .unmigratable_flags = CPUID_APM_INVTSC,
     },
+    [FEAT_8000_0008_EBX] = {
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            "ibpb", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid_eax = 0x80000008,
+        .cpuid_reg = R_EBX,
+        .tcg_features = 0,
+        .unmigratable_flags = 0,
+    },
     [FEAT_XSAVE] = {
         .feat_names = {
             "xsaveopt", "xsavec", "xgetbv1", "xsaves",
@@ -3130,7 +3146,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         } else {
             *eax = cpu->phys_bits;
         }
-        *ebx = 0;
+        *ebx = env->features[FEAT_8000_0008_EBX];
         *ecx = 0;
         *edx = 0;
         if (cs->nr_cores * cs->nr_threads > 1) {
@@ -3593,6 +3609,7 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_8000_0008_EBX);
         x86_cpu_adjust_feat_level(cpu, FEAT_C000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_SVM);
         x86_cpu_adjust_feat_level(cpu, FEAT_XSAVE);
-- 
2.14.3
