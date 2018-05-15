Received: from eggs.gnu.org ([2001:4830:134:3::10]:35564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIhuj-0008LD-Vy
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIhui-00010b-L7
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fIhui-00010O-7n
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:20 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 15 May 2018 18:54:30 -0300
Message-Id: <20180515215436.6457-2-ehabkost@redhat.com>
In-Reply-To: <20180515215436.6457-1-ehabkost@redhat.com>
References: <20180515215436.6457-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] i386: add KnightsMill cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Boqun Feng <boqun.feng@intel.com>

From: Boqun Feng <boqun.feng@intel.com>

A new cpu model called "KnightsMill" is added to model Knights Mill
processors.  Compared to "Skylake-Server" cpu model, the following
features are added:

	avx512_4vnniw avx512_4fmaps avx512pf avx512er avx512_vpopcntdq

and the following features are removed:

	pcid invpcid clflushopt avx512dq avx512bw clwb smap rtm mpx
	xsavec xgetbv1 hle

Signed-off-by: Boqun Feng <boqun.feng@intel.com>
Message-Id: <20180320000821.8337-1-boqun.feng@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b0a1c629a3..52fd35b6a1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1839,6 +1839,48 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x80000008,
         .model_id = "Intel Xeon Processor (Skylake, IBRS)",
     },
+    {
+        .name = "KnightsMill",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 6,
+        .model = 133,
+        .stepping = 0,
+        .features[FEAT_1_EDX] =
+            CPUID_VME | CPUID_SS | CPUID_SSE2 | CPUID_SSE | CPUID_FXSR |
+            CPUID_MMX | CPUID_CLFLUSH | CPUID_PSE36 | CPUID_PAT | CPUID_CMOV |
+            CPUID_MCA | CPUID_PGE | CPUID_MTRR | CPUID_SEP | CPUID_APIC |
+            CPUID_CX8 | CPUID_MCE | CPUID_PAE | CPUID_MSR | CPUID_TSC |
+            CPUID_PSE | CPUID_DE | CPUID_FP87,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_AVX | CPUID_EXT_XSAVE | CPUID_EXT_AES |
+            CPUID_EXT_POPCNT | CPUID_EXT_X2APIC | CPUID_EXT_SSE42 |
+            CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_SSSE3 |
+            CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3 |
+            CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_FMA | CPUID_EXT_MOVBE |
+            CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_RDTSCP |
+            CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_ABM | CPUID_EXT3_LAHF_LM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS |
+            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_AVX512F |
+            CPUID_7_0_EBX_AVX512CD | CPUID_7_0_EBX_AVX512PF |
+            CPUID_7_0_EBX_AVX512ER,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_AVX512_VPOPCNTDQ,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_AVX512_4VNNIW | CPUID_7_0_EDX_AVX512_4FMAPS,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon Phi Processor (Knights Mill)",
+    },
     {
         .name = "Opteron_G1",
         .level = 5,
-- 
2.14.3
