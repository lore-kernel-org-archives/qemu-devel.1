Received: from eggs.gnu.org ([2001:4830:134:3::10]:36629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fXIMJ-0001mJ-IP
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 23:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fXIMG-0007t1-2E
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 23:40:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:25151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fXIMF-0007qo-Pv
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 23:40:03 -0400
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Mon, 25 Jun 2018 11:39:21 +0800
Message-Id: <1529897961-134132-6-git-send-email-robert.hu@linux.intel.com>
In-Reply-To: <1529897961-134132-1-git-send-email-robert.hu@linux.intel.com>
References: <1529897961-134132-1-git-send-email-robert.hu@linux.intel.com>
Subject: [Qemu-devel] [PATCH 5/5] i386: Add new CPU model Icelake-{Server,
 Client}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: robert.hu@intel.com, Robert Hoo <robert.hu@linux.intel.com>

New CPU models mostly inherit features from ancestor Skylake, while addin new
features: UMIP, New Instructions ( PCONIFIG (server only), WBNOINVD,
AVX512_VBMI2, GFNI, AVX512_VNNI, VPCLMULQDQ, VAES, AVX512_BITALG),
Intel PT and 5-level paging (Server only). As well as
IA32_PRED_CMD and IA32_ARCH_CAPABILITIES MSRs, SSBD support for speculative execution
side channel mitigations.

Note: For 5-level paging, Guest physical address width can be configured, with
parameter "phys-bits". Unless explicitly specified, we still use its default
value, even for Icelake-Server cpu model.

Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
---
 target/i386/cpu.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 821b7bd..2613e1a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2276,6 +2276,122 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "Intel Xeon Processor (Skylake, IBRS)",
     },
     {
+        .name = "Icelake-Client",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 126,
+        .stepping = 0,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
+            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
+            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
+            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
+            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_WBNOINVD,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
+            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
+            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_INTEL_PT,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
+            CPUID_7_0_ECX_OSPKE | CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
+            CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
+            CPUID_7_0_ECX_AVX512_VPOPCNTDQ,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_ARCH_CAPABILITIES |
+            CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+        /* Missing: XSAVES (not supported by some Linux versions,
+                * including v4.1 to v4.12).
+                * KVM doesn't yet expose any XSAVES state save component,
+                * and the only one defined in Skylake (processor tracing)
+                * probably will block migration anyway.
+                */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Core Processor (Icelake)",
+    },
+    {
+        .name = "Icelake-Server",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 134,
+        .stepping = 0,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX |
+            CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA |
+            CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 |
+            CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE |
+            CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
+            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
+            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
+            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
+            CPUID_EXT_PCID | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
+            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_WBNOINVD,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
+            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
+            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
+            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
+            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT |
+            CPUID_7_0_EBX_INTEL_PT,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
+            CPUID_7_0_ECX_OSPKE | CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
+            CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
+            CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_PCONFIG | CPUID_7_0_EDX_SPEC_CTRL |
+            CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+        /* Missing: XSAVES (not supported by some Linux versions,
+                * including v4.1 to v4.12).
+                * KVM doesn't yet expose any XSAVES state save component,
+                * and the only one defined in Skylake (processor tracing)
+                * probably will block migration anyway.
+                */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon Processor (Icelake)",
+    },
+    {
         .name = "KnightsMill",
         .level = 0xd,
         .vendor = CPUID_VENDOR_INTEL,
-- 
1.8.3.1
