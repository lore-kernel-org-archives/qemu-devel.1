Received: from eggs.gnu.org ([2001:4830:134:3::10]:54477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1evUZI-0001Xx-A6
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1evUZE-0007X9-8I
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:01:16 -0400
Received: from mail-bn3nam01on0051.outbound.protection.outlook.com
	([104.47.33.51]:26992
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1evUZE-0007X0-1Q
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:01:12 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Mon, 12 Mar 2018 17:00:48 -0400
Message-Id: <1520888449-4352-5-git-send-email-babu.moger@amd.com>
In-Reply-To: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
References: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 4/5] target/i386: Enable TOPOEXT feature on
 AMD EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, rkrcmar@redhat.com
Cc: mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, Gary.Hook@amd.com, Thomas.Lendacky@amd.com, brijesh.singh@amd.com, babu.moger@amd.com, kash@tripleback.net

Enable TOPOEXT feature on EPYC CPU. This is required to support
hyperthreading on VM guests. Also extend xlevel to 0x8000001E.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ba63d0c..ade272e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1955,7 +1955,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
-            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT,
         .features[FEAT_7_0_EBX] =
             CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
             CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
@@ -1999,7 +2000,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
-            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT,
         .features[FEAT_8000_0008_EBX] =
             CPUID_8000_0008_EBX_IBPB,
         .features[FEAT_7_0_EBX] =
@@ -4113,6 +4115,11 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
         }
+
+        /* TOPOEXT feature requires 0x8000001E */
+        if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001E);
+        }
     }
 
     /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set */
-- 
1.8.3.1
