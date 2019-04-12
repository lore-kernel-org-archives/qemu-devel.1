Received: from eggs.gnu.org ([209.51.188.92]:50293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hEvpD-0002tj-DB
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 09:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hEvp7-0003OU-3L
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 09:02:35 -0400
Received: from [110.188.70.11] (port=8949 helo=spam1.hygon.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <puwen@hygon.cn>) id 1hEvp6-0003AK-Bp
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 09:02:29 -0400
Received: from spam1.hygon.cn (localhost [127.0.0.2] (may be forged))
	by spam1.hygon.cn with ESMTP id x3CCcwlB020956
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 20:38:58 +0800 (GMT-8)
	(envelope-from puwen@hygon.cn)
From: Pu Wen <puwen@hygon.cn>
Date: Fri, 12 Apr 2019 20:37:49 +0800
Message-ID: <1555072669-20441-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC] i386: Add new Hygon 'Dhyana' and
 'Dhyana-IBPB' CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, Pu Wen <puwen@hygon.cn>

Add two new base CPU models called 'Dhyana' and 'Dhyana-IBPB' to model
processors from Hygon Dhyana (family 18h), which derived from AMD EPYC
(family 17h). 'Dhyana-IBPB' is a copy of the 'Dhyana' CPU model with
just CPUID_8000_0008_EBX_IBPB added.

The following features bits have been removed compare to AMD EPYC:
aes, pclmulqdq, sha_ni

The Hygon Dhyana support to KVM in Linux is already accepted upstream[1].
So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
CPU models.

Reference:
[1] https://git.kernel.org/tip/fec98069fb72fb656304a3e52265e0c2fc9adf87

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 hw/i386/pc.c      |  6 ++++
 target/i386/cpu.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h |  2 ++
 3 files changed, 106 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f2c15bf..7e59f50 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -128,6 +128,10 @@ GlobalProperty pc_compat_3_1[] = {
     { "EPYC" "-" TYPE_X86_CPU, "nrip-save", "off" },
     { "EPYC-IBPB" "-" TYPE_X86_CPU, "npt", "off" },
     { "EPYC-IBPB" "-" TYPE_X86_CPU, "nrip-save", "off" },
+    { "Dhyana" "-" TYPE_X86_CPU, "npt", "off" },
+    { "Dhyana" "-" TYPE_X86_CPU, "nrip-save", "off" },
+    { "Dhyana-IBPB" "-" TYPE_X86_CPU, "npt", "off" },
+    { "Dhyana-IBPB" "-" TYPE_X86_CPU, "nrip-save", "off" },
     { "Skylake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
     { "Skylake-Client-IBRS" "-" TYPE_X86_CPU, "mpx", "on" },
     { "Skylake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
@@ -152,6 +156,8 @@ GlobalProperty pc_compat_2_12[] = {
     { TYPE_X86_CPU, "topoext", "off" },
     { "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
     { "EPYC-IBPB-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
+    { "Dhyana-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
+    { "Dhyana-IBPB-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
 };
 const size_t pc_compat_2_12_len = G_N_ELEMENTS(pc_compat_2_12);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d6bb57d..9a46401 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2934,6 +2934,104 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "AMD EPYC Processor (with IBPB)",
         .cache_info = &epyc_cache_info,
     },
+    {
+        .name = "Dhyana",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_HYGON,
+        .family = 24,
+        .model = 0,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUSH |
+            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
+            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
+            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
+            CPUID_VME | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_POPCNT |
+            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_CX16 | CPUID_EXT_FMA | CPUID_EXT_SSSE3 |
+            CPUID_EXT_MONITOR | CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
+            CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT,
+        /*
+         * Missing: XSAVES (not supported by some Linux versions,
+         * including v4.1 to v4.12).
+         * KVM doesn't yet expose any XSAVES state save component.
+         */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
+        .xlevel = 0x8000001E,
+        .model_id = "Hygon Dhyana Processor",
+        .cache_info = &epyc_cache_info,
+    },
+    {
+        .name = "Dhyana-IBPB",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_HYGON,
+        .family = 24,
+        .model = 0,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUSH |
+            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
+            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
+            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
+            CPUID_VME | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_POPCNT |
+            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_CX16 | CPUID_EXT_FMA | CPUID_EXT_SSSE3 |
+            CPUID_EXT_MONITOR | CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_IBPB,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
+            CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT,
+        /*
+         * Missing: XSAVES (not supported by some Linux versions,
+         * including v4.1 to v4.12).
+         * KVM doesn't yet expose any XSAVES state save component.
+         */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
+        .xlevel = 0x8000001E,
+        .model_id = "Hygon Dhyana Processor (with IBPB)",
+        .cache_info = &epyc_cache_info,
+    },
 };
 
 typedef struct PropValue {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 83fb522..553dbe7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -726,6 +726,8 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 
 #define CPUID_VENDOR_VIA   "CentaurHauls"
 
+#define CPUID_VENDOR_HYGON    "HygonGenuine"
+
 #define CPUID_MWAIT_IBE     (1U << 1) /* Interrupts can exit capability */
 #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
 
-- 
2.7.4
