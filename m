Received: from eggs.gnu.org ([2001:4830:134:3::10]:52385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fLsPD-00071S-VG
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fLsPC-00026i-22
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:43:56 -0400
Received: from mail-bl2nam02on0040.outbound.protection.outlook.com
	([104.47.38.40]:18880
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fLsPB-00026T-Sz
	for qemu-devel@nongnu.org; Thu, 24 May 2018 11:43:54 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Thu, 24 May 2018 11:43:33 -0400
Message-Id: <1527176614-26271-5-git-send-email-babu.moger@amd.com>
In-Reply-To: <1527176614-26271-1-git-send-email-babu.moger@amd.com>
References: <1527176614-26271-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v11 4/5] i386: Enable TOPOEXT feature on AMD
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, babu.moger@amd.com, kash@tripleback.net, geoff@hostfission.com

Enable TOPOEXT feature on EPYC CPU. This is required to support
hyperthreading on VM guests. Also extend xlevel to 0x8000001E.

Disable TOPOEXT feature for legacy machines and also disable
TOPOEXT feature if the config cannot be supported.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 include/hw/i386/pc.h |  4 ++++
 target/i386/cpu.c    | 37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a0c269f..9c8db3d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -302,6 +302,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
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
index 9f8bad9..0b62356 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -486,6 +486,20 @@ static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
 }
 
 /*
+ * Check if we can support this topology
+ * Fail if number of cores are beyond the supported config
+ * or nr_threads is more than 2
+ */
+static int verify_topology(int nr_cores, int nr_threads)
+{
+    if ((nr_cores > (MAX_CORES_IN_NODE * MAX_NODES_PER_SOCKET)) ||
+        (nr_threads > 2)) {
+        return 0;
+    }
+    return 1;
+}
+
+/*
  * Definitions of the hardcoded cache entries we expose:
  * These are legacy cache values. If there is a need to change any
  * of these values please use builtin_x86_defs
@@ -2531,7 +2545,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
-            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT,
         .features[FEAT_7_0_EBX] =
             CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
             CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
@@ -2576,7 +2591,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
-            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT,
         .features[FEAT_8000_0008_EBX] =
             CPUID_8000_0008_EBX_IBPB,
         .features[FEAT_7_0_EBX] =
@@ -4156,6 +4172,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x8000001D:
         *eax = 0;
+        /* Check if we can support this topology */
+        if (!verify_topology(cs->nr_cores, cs->nr_threads)) {
+            /* Disable topology extention */
+            env->features[FEAT_8000_0001_ECX] &= !CPUID_EXT3_TOPOEXT;
+            break;
+        }
         switch (count) {
         case 0: /* L1 dcache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, cs,
@@ -4180,6 +4202,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x8000001E:
         assert(cpu->core_id <= 255);
+        /* Check if we can support this topology */
+        if (!verify_topology(cs->nr_cores, cs->nr_threads)) {
+            /* Disable topology extention */
+            env->features[FEAT_8000_0001_ECX] &= !CPUID_EXT3_TOPOEXT;
+            break;
+        }
         encode_topo_cpuid8000001e(cs, cpu,
                                   eax, ebx, ecx, edx);
         break;
@@ -4644,6 +4672,11 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
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
1.8.3.1
