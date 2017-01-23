Received: from eggs.gnu.org ([2001:4830:134:3::10]:38141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo1o-0003DF-KV
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo1n-0005x6-Fa
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cVo1n-0005wo-7G
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:27:59 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jan 2017 21:27:27 -0200
Message-Id: <20170123232738.20796-3-ehabkost@redhat.com>
In-Reply-To: <20170123232738.20796-1-ehabkost@redhat.com>
References: <20170123232738.20796-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 02/13] i386: Remove AMD feature flag aliases
 from Opteron models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

When CPU vendor is set to AMD, the AMD feature alias bits on
CPUID[0x80000001].EDX are already automatically copied from CPUID[1].EDX
on x86_cpu_realizefn(). When CPU vendor is Intel, those bits are
reserved and should be zero. On either case, those bits shouldn't be set
in the CPU model table.

Commit 726a8ff68677d8d5fba17eb0ffb85076bfb598dc removed those
bits from most CPU models, but the Opteron_* entries still have
them. Remove the alias bits from Opteron_* too.

Add an assert() to x86_register_cpudef_type() to ensure we don't
make the same mistake again.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170113190057.6327-1-ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 46 ++++++++++++----------------------------------
 1 file changed, 12 insertions(+), 34 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b6c8c5d65b..0e5ecb3a0f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1339,12 +1339,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_ECX] =
             CPUID_EXT_SSE3,
         .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_FXSR | CPUID_EXT2_MMX |
-            CPUID_EXT2_NX | CPUID_EXT2_PSE36 | CPUID_EXT2_PAT |
-            CPUID_EXT2_CMOV | CPUID_EXT2_MCA | CPUID_EXT2_PGE |
-            CPUID_EXT2_MTRR | CPUID_EXT2_SYSCALL | CPUID_EXT2_APIC |
-            CPUID_EXT2_CX8 | CPUID_EXT2_MCE | CPUID_EXT2_PAE | CPUID_EXT2_MSR |
-            CPUID_EXT2_TSC | CPUID_EXT2_PSE | CPUID_EXT2_DE | CPUID_EXT2_FPU,
+            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
         .xlevel = 0x80000008,
         .model_id = "AMD Opteron 240 (Gen 1 Class Opteron)",
     },
@@ -1365,13 +1360,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_CX16 | CPUID_EXT_SSE3,
         /* Missing: CPUID_EXT2_RDTSCP */
         .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_FXSR |
-            CPUID_EXT2_MMX | CPUID_EXT2_NX | CPUID_EXT2_PSE36 |
-            CPUID_EXT2_PAT | CPUID_EXT2_CMOV | CPUID_EXT2_MCA |
-            CPUID_EXT2_PGE | CPUID_EXT2_MTRR | CPUID_EXT2_SYSCALL |
-            CPUID_EXT2_APIC | CPUID_EXT2_CX8 | CPUID_EXT2_MCE |
-            CPUID_EXT2_PAE | CPUID_EXT2_MSR | CPUID_EXT2_TSC | CPUID_EXT2_PSE |
-            CPUID_EXT2_DE | CPUID_EXT2_FPU,
+            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
         .xlevel = 0x80000008,
@@ -1395,13 +1384,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_SSE3,
         /* Missing: CPUID_EXT2_RDTSCP */
         .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_FXSR |
-            CPUID_EXT2_MMX | CPUID_EXT2_NX | CPUID_EXT2_PSE36 |
-            CPUID_EXT2_PAT | CPUID_EXT2_CMOV | CPUID_EXT2_MCA |
-            CPUID_EXT2_PGE | CPUID_EXT2_MTRR | CPUID_EXT2_SYSCALL |
-            CPUID_EXT2_APIC | CPUID_EXT2_CX8 | CPUID_EXT2_MCE |
-            CPUID_EXT2_PAE | CPUID_EXT2_MSR | CPUID_EXT2_TSC | CPUID_EXT2_PSE |
-            CPUID_EXT2_DE | CPUID_EXT2_FPU,
+            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A |
             CPUID_EXT3_ABM | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
@@ -1428,13 +1411,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_SSE3,
         /* Missing: CPUID_EXT2_RDTSCP */
         .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM |
-            CPUID_EXT2_PDPE1GB | CPUID_EXT2_FXSR | CPUID_EXT2_MMX |
-            CPUID_EXT2_NX | CPUID_EXT2_PSE36 | CPUID_EXT2_PAT |
-            CPUID_EXT2_CMOV | CPUID_EXT2_MCA | CPUID_EXT2_PGE |
-            CPUID_EXT2_MTRR | CPUID_EXT2_SYSCALL | CPUID_EXT2_APIC |
-            CPUID_EXT2_CX8 | CPUID_EXT2_MCE | CPUID_EXT2_PAE | CPUID_EXT2_MSR |
-            CPUID_EXT2_TSC | CPUID_EXT2_PSE | CPUID_EXT2_DE | CPUID_EXT2_FPU,
+            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_FMA4 | CPUID_EXT3_XOP |
             CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
@@ -1464,13 +1442,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
         /* Missing: CPUID_EXT2_RDTSCP */
         .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM |
-            CPUID_EXT2_PDPE1GB | CPUID_EXT2_FXSR | CPUID_EXT2_MMX |
-            CPUID_EXT2_NX | CPUID_EXT2_PSE36 | CPUID_EXT2_PAT |
-            CPUID_EXT2_CMOV | CPUID_EXT2_MCA | CPUID_EXT2_PGE |
-            CPUID_EXT2_MTRR | CPUID_EXT2_SYSCALL | CPUID_EXT2_APIC |
-            CPUID_EXT2_CX8 | CPUID_EXT2_MCE | CPUID_EXT2_PAE | CPUID_EXT2_MSR |
-            CPUID_EXT2_TSC | CPUID_EXT2_PSE | CPUID_EXT2_DE | CPUID_EXT2_FPU,
+            CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_TBM | CPUID_EXT3_FMA4 | CPUID_EXT3_XOP |
             CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
@@ -2395,6 +2368,11 @@ static void x86_register_cpudef_type(X86CPUDefinition *def)
         .class_data = def,
     };
 
+    /* AMD aliases are handled at runtime based on CPUID vendor, so
+     * they shouldn't be set on the CPU model table.
+     */
+    assert(!(def->features[FEAT_8000_0001_EDX] & CPUID_EXT2_AMD_ALIASES));
+
     type_register(&ti);
     g_free(typename);
 }
-- 
2.11.0.259.g40922b1
