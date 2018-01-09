Received: from eggs.gnu.org ([2001:4830:134:3::10]:43260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYw6J-000395-E5
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYw6I-0003uJ-8x
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:46:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42853)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eYw6I-0003th-0R
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:46:06 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  9 Jan 2018 13:45:18 -0200
Message-Id: <20180109154519.25634-7-ehabkost@redhat.com>
In-Reply-To: <20180109154519.25634-1-ehabkost@redhat.com>
References: <20180109154519.25634-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 6/7] [RFC] i386: Add EPYC-IBPB CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Brijesh Singh <brijesh.singh@amd.com>

RFC NOTE: More info is required to confirm if this is necessary
to mitigate mitigate CVE-2017-5715 on AMD CPUs.

EPYC-IBPB is a copy of the EPYC CPU model with
just CPUID_8000_0008_EBX_IBPB added.

Cc: Jiri Denemark <jdenemar@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eb1bef6aa5..9c36f9bd44 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1964,6 +1964,52 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x8000000A,
         .model_id = "AMD EPYC Processor",
     },
+    {
+        .name = "EPYC-IBPB",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 23,
+        .model = 1,
+        .stepping = 2,
+        .features[FEAT_1_EDX] =
+            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUSH |
+            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
+            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
+            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
+            CPUID_VME | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_AES |  CPUID_EXT_POPCNT |
+            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_CX16 | CPUID_EXT_FMA | CPUID_EXT_SSSE3 |
+            CPUID_EXT_MONITOR | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_IBPB,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
+            CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLUSHOPT |
+            CPUID_7_0_EBX_SHA_NI,
+        /* Missing: XSAVES (not supported by some Linux versions,
+         * including v4.1 to v4.12).
+         * KVM doesn't yet expose any XSAVES state save component.
+         */
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .xlevel = 0x8000000A,
+        .model_id = "AMD EPYC Processor (with IBPB)",
+    },
 };
 
 typedef struct PropValue {
-- 
2.14.3
