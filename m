Received: from eggs.gnu.org ([2001:4830:134:3::10]:54827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <boqun.feng@gmail.com>) id 1dNYDZ-0002jw-7d
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 01:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <boqun.feng@gmail.com>) id 1dNYDW-0003Tk-2y
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 01:30:17 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <boqun.feng@gmail.com>)
	id 1dNYDV-0003T4-Sc
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 01:30:14 -0400
Received: by mail-pg0-x244.google.com with SMTP id e187so16723976pgc.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 22:30:11 -0700 (PDT)
From: "Boqun Feng (Intel)" <boqun.feng@gmail.com>
Date: Wed, 21 Jun 2017 13:29:34 +0800
Message-Id: <20170621052935.20715-1-boqun.feng@gmail.com>
Subject: [Qemu-devel] [PATCH] target-i386: add Skylake-Server cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Boqun Feng (Intel)" <boqun.feng@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Introduce Skylake-Server cpu mode which inherits the features from
Skylake-Client and supports some additional features that are: AVX512,
CWLB and PGPE1GB.

Signed-off-by: Boqun Feng (Intel) <boqun.feng@gmail.com>
---
 target/i386/cpu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b2b1d20cee51..1bed722ac2fd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1349,6 +1349,48 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .model_id = "Intel Core Processor (Skylake)",
     },
     {
+        .name = "Skylake-Server",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 85,
+        .stepping = 4,
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
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 |
+            CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
+            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
+            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
+            CPUID_7_0_EBX_AVX512VL,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon Processor (Skylake)",
+    },
+    {
         .name = "Opteron_G1",
         .level = 5,
         .vendor = CPUID_VENDOR_AMD,
-- 
2.13.1
