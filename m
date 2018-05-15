Received: from eggs.gnu.org ([2001:4830:134:3::10]:35675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIhuu-0008Sv-AL
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fIhut-00016n-FQ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56609)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fIhut-00016Q-9q
	for qemu-devel@nongnu.org; Tue, 15 May 2018 17:55:31 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 15 May 2018 18:54:34 -0300
Message-Id: <20180515215436.6457-6-ehabkost@redhat.com>
In-Reply-To: <20180515215436.6457-1-ehabkost@redhat.com>
References: <20180515215436.6457-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] i386: Initialize cache information for EPYC
 family processors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Babu Moger <babu.moger@amd.com>

From: Babu Moger <babu.moger@amd.com>

Initialize pre-determined cache information for EPYC processors.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
Message-Id: <20180510204148.11687-5-babu.moger@amd.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 55685ed19d..174a8f434b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1109,6 +1109,56 @@ struct X86CPUDefinition {
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
@@ -2345,6 +2395,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .xlevel = 0x8000000A,
         .model_id = "AMD EPYC Processor",
+        .cache_info = &epyc_cache_info,
     },
     {
         .name = "EPYC-IBPB",
@@ -2391,6 +2442,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_6_EAX_ARAT,
         .xlevel = 0x8000000A,
         .model_id = "AMD EPYC Processor (with IBPB)",
+        .cache_info = &epyc_cache_info,
     },
 };
 
-- 
2.14.3
