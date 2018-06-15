Received: from eggs.gnu.org ([2001:4830:134:3::10]:53274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTsKT-0006G3-26
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fTsKP-0007Sh-8h
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:16:05 -0400
Received: from mail-eopbgr730053.outbound.protection.outlook.com
	([40.107.73.53]:16992
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fTsKP-0007R7-3E
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 13:16:01 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Fri, 15 Jun 2018 13:15:46 -0400
Message-Id: <1529082947-60001-3-git-send-email-babu.moger@amd.com>
In-Reply-To: <1529082947-60001-1-git-send-email-babu.moger@amd.com>
References: <1529082947-60001-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v15 2/3] i386: Enable TOPOEXT feature on AMD
 EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, mtosatti@redhat.com, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com, babu.moger@amd.com

Enable TOPOEXT feature on EPYC CPU. This is required to support
hyperthreading on VM guests. Also extend xlevel to 0x8000001E.

Disable topoext on PC_COMPAT_2_12 and keep xlevel 0x8000000a.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 include/hw/i386/pc.h |  8 ++++++++
 target/i386/cpu.c    | 10 ++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index fc8dedc..d0ebeb9 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -303,6 +303,14 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = TYPE_X86_CPU,\
         .property = "legacy-cache",\
         .value    = "on",\
+    },{\
+        .driver   = TYPE_X86_CPU,\
+        .property = "topoext",\
+        .value    = "off",\
+    },{\
+        .driver   = "EPYC-" TYPE_X86_CPU,\
+        .property = "xlevel",\
+        .value    = stringify(0x8000000a),\
     },
 
 #define PC_COMPAT_2_11 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5246be4..2f839ec 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2576,7 +2576,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
-            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT,
         .features[FEAT_7_0_EBX] =
             CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
             CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
@@ -2591,7 +2592,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
-        .xlevel = 0x8000000A,
+        .xlevel = 0x8000001E,
         .model_id = "AMD EPYC Processor",
         .cache_info = &epyc_cache_info,
     },
@@ -2621,7 +2622,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
-            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT,
         .features[FEAT_8000_0008_EBX] =
             CPUID_8000_0008_EBX_IBPB,
         .features[FEAT_7_0_EBX] =
@@ -2638,7 +2640,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_XSAVE_XGETBV1,
         .features[FEAT_6_EAX] =
             CPUID_6_EAX_ARAT,
-        .xlevel = 0x8000000A,
+        .xlevel = 0x8000001E,
         .model_id = "AMD EPYC Processor (with IBPB)",
         .cache_info = &epyc_cache_info,
     },
-- 
1.8.3.1
