Received: from eggs.gnu.org ([2001:4830:134:3::10]:42904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fRQJM-0005BE-E0
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 18:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fRQJI-0002qF-9x
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 18:56:48 -0400
Received: from mail-bl2nam02on0088.outbound.protection.outlook.com
	([104.47.38.88]:28256
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fRQJI-0002pv-2b
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 18:56:44 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Fri,  8 Jun 2018 18:56:19 -0400
Message-Id: <1528498581-131037-4-git-send-email-babu.moger@amd.com>
In-Reply-To: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
References: <1528498581-131037-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v13 3/5] i386: Enable TOPOEXT feature on AMD
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

TOPOEXT feature is disabled for legacy machines.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d3411ed..4dd9a82 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2574,6 +2574,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x8000000A,
         .model_id = "AMD EPYC Processor",
         .cache_info = &epyc_cache_info,
+        .auto_topoext = 1,
     },
     {
         .name = "EPYC-IBPB",
@@ -2621,6 +2622,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x8000000A,
         .model_id = "AMD EPYC Processor (with IBPB)",
         .cache_info = &epyc_cache_info,
+        .auto_topoext = 1,
     },
 };
 
@@ -4672,6 +4674,11 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
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
