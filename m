Received: from eggs.gnu.org ([2001:4830:134:3::10]:57148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fGsOB-0005PZ-84
	for qemu-devel@nongnu.org; Thu, 10 May 2018 16:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fGsO8-0004X2-2v
	for qemu-devel@nongnu.org; Thu, 10 May 2018 16:42:11 -0400
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com
	([104.47.32.41]:36736
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fGsO7-0004Vg-UC
	for qemu-devel@nongnu.org; Thu, 10 May 2018 16:42:08 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Thu, 10 May 2018 15:41:44 -0500
Message-Id: <20180510204148.11687-5-babu.moger@amd.com>
In-Reply-To: <20180510204148.11687-1-babu.moger@amd.com>
References: <20180510204148.11687-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v8 4/8] i386: Initialize cache information for
 EPYC family processors
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

Initialize pre-determined cache information for EPYC processors.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
---
 target/i386/cpu.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d97b290b08..b20b8691a7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1112,6 +1112,56 @@ struct X86CPUDefinition {
     CPUCaches *cache_info;
 };
 
+static CPUCaches epyc_cache_info = {
+    .l1d_cache = {
+        .type = DCACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+    },
+    .l1i_cache = {
+        .type = ICACHE,
+        .level = 1,
+        .size = 64 * KiB,
+        .line_size = 64,
+        .associativity = 4,
+        .partitions = 1,
+        .sets = 256,
+        .lines_per_tag = 1,
+        .self_init = 1,
+        .no_invd_sharing = true,
+    },
+    .l2_cache = {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 512 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 1024,
+        .lines_per_tag = 1,
+    },
+    .l3_cache = {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 8 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 8192,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .complex_indexing = true,
+    },
+};
+
 static X86CPUDefinition builtin_x86_defs[] = {
     {
         .name = "qemu64",
@@ -2306,6 +2356,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .xlevel = 0x8000000A,
         .model_id = "AMD EPYC Processor",
+        .cache_info = &epyc_cache_info,
     },
     {
         .name = "EPYC-IBPB",
@@ -2352,6 +2403,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .xlevel = 0x8000000A,
         .model_id = "AMD EPYC Processor (with IBPB)",
+        .cache_info = &epyc_cache_info,
     },
 };
 
-- 
2.17.0
