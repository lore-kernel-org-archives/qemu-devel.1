Received: from eggs.gnu.org ([209.51.188.92]:47560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paul.c.lai@intel.com>) id 1hLWUr-0002xI-AS
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paul.c.lai@intel.com>) id 1hLWUp-0002KH-AU
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:24:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:64486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <paul.c.lai@intel.com>)
	id 1hLWUo-0002G2-K4
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:24:47 -0400
From: Paul Lai <paul.c.lai@intel.com>
Date: Tue, 30 Apr 2019 10:22:36 -0700
Message-Id: <20190430172236.14325-1-paul.c.lai@intel.com>
Subject: [Qemu-devel] [PATCH] Introduce SnowRidge CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wei.w.wang@intel.com, tao3.xu@intel.com, luwei.kang@intel.com, paul.c.lai@intel.com

SnowRidge CPU supports Accelerator Infrastrcture Architecture (MOVDIRI,
MOVDIR64B), CLDEMOTE and SPLIT_LOCK_DISABLE.

MOVDIRI, MOVDIR64B, and CLDEMOTE are found via CPUID.
The availability of SPLIT_LOCK_DISABLE is check via msr access

References can be found in either:
 https://software.intel.com/en-us/articles/intel-sdm
 https://software.intel.com/en-us/download/intel-architecture-instruction-set-extensions-and-future-features-programming-reference

Signed-off-by: Paul Lai <paul.c.lai@intel.com>
Tested-by: Tao3 Xu <tao3.xu@intel.com>
---
 target/i386/cpu.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d6bb57d210..e81da09709 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2663,6 +2663,72 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Icelake)",
     },
+    {
+        .name = "SnowRidge",
+        .level = 27,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 134,
+        .stepping = 1,
+        .features[FEAT_1_EDX] =
+	    /* missing: CPUID_PN CPUID_IA64 */
+            /* missing: CPUID_DTS, CPUID_HT, CPUID_TM, CPUID_PBE */
+            CPUID_FP87 | CPUID_VME | CPUID_DE| CPUID_PSE |
+            CPUID_TSC | CPUID_MSR | CPUID_PAE | CPUID_MCE |
+            CPUID_CX8 | CPUID_APIC | CPUID_SEP |
+            CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+            CPUID_PAT | CPUID_PSE36 | /* CPUID_PN | */ CPUID_CLFLUSH |
+            CPUID_MMX |
+            CPUID_FXSR | CPUID_SSE | CPUID_SSE2,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_MONITOR |
+            CPUID_EXT_VMX |
+            CPUID_EXT_SSSE3 |
+            CPUID_EXT_CX16 |
+            CPUID_EXT_SSE41 |
+            CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE | CPUID_EXT_POPCNT |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_AES | CPUID_EXT_XSAVE |
+            CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_SYSCALL |
+            CPUID_EXT2_NX |
+            CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
+            CPUID_EXT2_LM,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE |
+            CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_ERMS |
+            CPUID_7_0_EBX_MPX |  /* missing bits 13, 15 */
+            CPUID_7_0_EBX_RDSEED |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT |
+            CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_SHA_NI,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_UMIP |
+            /* missing bit 5 */
+            CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_MOVDIRI | CPUID_7_0_ECX_CLDEMOTE |
+            CPUID_7_0_ECX_MOVDIR64B,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_SPEC_CTRL |
+            CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL_SSBD, /* missing bit 30 */
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
+        .model_id = "Intel Atom Processor (SnowRidge)",
+    },
     {
         .name = "KnightsMill",
         .level = 0xd,
-- 
2.17.2
