Received: from eggs.gnu.org ([2001:4830:134:3::10]:58514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fIGYM-0006tx-Lo
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fIGYJ-0005jG-Jq
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:42:26 -0400
Received: from mail-cys01nam02on0061.outbound.protection.outlook.com
	([104.47.37.61]:63568
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fIGYJ-0005if-CB
	for qemu-devel@nongnu.org; Mon, 14 May 2018 12:42:23 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Mon, 14 May 2018 11:41:55 -0500
Message-Id: <20180514164156.27034-7-babu.moger@amd.com>
In-Reply-To: <20180514164156.27034-1-babu.moger@amd.com>
References: <20180514164156.27034-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 6/7] i386: Enable TOPOEXT feature on AMD
 EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, geoff@hostfission.com, kash@tripleback.net, babu.moger@amd.com

Enable TOPOEXT feature on EPYC CPU. This is required to support
hyperthreading on VM guests. Also extend xlevel to 0x8000001E.

Disable TOPOEXT feature for legacy (2.12 or older) machine types.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h |  4 ++++
 target/i386/cpu.c    | 11 +++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index df15deefca..c01adc92ba 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -310,6 +310,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = TYPE_X86_CPU,\
         .property = "legacy-cache",\
         .value    = "on",\
+    },{\
+        .driver   = "EPYC-" TYPE_X86_CPU,\
+        .property = "topoext",\
+        .value    = "off",\
     },
 
 #define PC_COMPAT_2_11 \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 18a7872b7d..de2749ae81 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2424,7 +2424,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
-            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT,
         .features[FEAT_7_0_EBX] =
             CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
             CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
@@ -2469,7 +2470,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
-            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT,
         .features[FEAT_8000_0008_EBX] =
             CPUID_8000_0008_EBX_IBPB,
         .features[FEAT_7_0_EBX] =
@@ -4540,6 +4542,11 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
             x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
         }
 
+        /* TOPOEXT feature requires 0x8000001E */
+        if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001E);
+        }
+
         /* SEV requires CPUID[0x8000001F] */
         if (sev_enabled()) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000001F);
-- 
2.17.0
