Received: from eggs.gnu.org ([2001:4830:134:3::10]:44993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f0wBk-0002MO-2w
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f0wBg-0003r4-UN
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:31:28 -0400
Received: from mail-bn3nam01on0062.outbound.protection.outlook.com
	([104.47.33.62]:51955
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1f0wBg-0003qh-OD
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 17:31:24 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Tue, 27 Mar 2018 17:31:05 -0400
Message-Id: <1522186271-27743-4-git-send-email-babu.moger@amd.com>
In-Reply-To: <1522186271-27743-1-git-send-email-babu.moger@amd.com>
References: <1522186271-27743-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 3/9] i386: Initialize cache information for
 EPYC family processors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, babu.moger@amd.com

Initialize pre-determined cache information for EPYC processors.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eec4a97..67faa53 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2299,6 +2299,54 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .xlevel = 0x8000000A,
         .model_id = "AMD EPYC Processor",
+        .cache_info.valid = 1,
+        .cache_info.l1d_cache = {
+            .type = DCACHE,
+            .level = 1,
+            .size = 32 * KiB,
+            .line_size = 64,
+            .associativity = 8,
+            .partitions = 1,
+            .sets = 64,
+            .lines_per_tag = 1,
+            .self_init = 1,
+            .no_invd_sharing = true,
+        },
+        .cache_info.l1i_cache = {
+            .type = ICACHE,
+            .level = 1,
+            .size = 64 * KiB,
+            .line_size = 64,
+            .associativity = 4,
+            .partitions = 1,
+            .sets = 256,
+            .lines_per_tag = 1,
+            .self_init = 1,
+            .no_invd_sharing = true,
+        },
+        .cache_info.l2_cache = {
+            .type = UNIFIED_CACHE,
+            .level = 2,
+            .size = 512 * KiB,
+            .line_size = 64,
+            .associativity = 8,
+            .partitions = 1,
+            .sets = 1024,
+            .lines_per_tag = 1,
+        },
+        .cache_info.l3_cache = {
+            .type = UNIFIED_CACHE,
+            .level = 3,
+            .size = 16 * MiB,
+            .line_size = 64,
+            .associativity = 16,
+            .partitions = 1,
+            .sets = 16384,
+            .lines_per_tag = 1,
+            .self_init = true,
+            .inclusive = true,
+            .complex_indexing = true,
+        },
     },
     {
         .name = "EPYC-IBPB",
@@ -2345,6 +2393,54 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .xlevel = 0x8000000A,
         .model_id = "AMD EPYC Processor (with IBPB)",
+        .cache_info.valid = 1,
+        .cache_info.l1d_cache = {
+            .type = DCACHE,
+            .level = 1,
+            .size = 32 * KiB,
+            .line_size = 64,
+            .associativity = 8,
+            .partitions = 1,
+            .sets = 64,
+            .lines_per_tag = 1,
+            .self_init = 1,
+            .no_invd_sharing = true,
+        },
+        .cache_info.l1i_cache = {
+            .type = ICACHE,
+            .level = 1,
+            .size = 64 * KiB,
+            .line_size = 64,
+            .associativity = 4,
+            .partitions = 1,
+            .sets = 256,
+            .lines_per_tag = 1,
+            .self_init = 1,
+            .no_invd_sharing = true,
+        },
+        .cache_info.l2_cache = {
+            .type = UNIFIED_CACHE,
+            .level = 2,
+            .size = 512 * KiB,
+            .line_size = 64,
+            .associativity = 8,
+            .partitions = 1,
+            .sets = 1024,
+            .lines_per_tag = 1,
+        },
+        .cache_info.l3_cache = {
+            .type = UNIFIED_CACHE,
+            .level = 3,
+            .size = 16 * MiB,
+            .line_size = 64,
+            .associativity = 16,
+            .partitions = 1,
+            .sets = 16384,
+            .lines_per_tag = 1,
+            .self_init = true,
+            .inclusive = true,
+            .complex_indexing = true,
+        },
     },
 };
 
-- 
1.8.3.1
