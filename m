Received: from eggs.gnu.org ([2001:4830:134:3::10]:54421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1evUZA-0001R5-DD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:01:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1evUZ8-0007Uv-3O
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:01:08 -0400
Received: from mail-co1nam03on0609.outbound.protection.outlook.com
	([2a01:111:f400:fe48::609]:45310
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1evUZ7-0007Uf-Rk
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:01:06 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Mon, 12 Mar 2018 17:00:45 -0400
Message-Id: <1520888449-4352-2-git-send-email-babu.moger@amd.com>
In-Reply-To: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
References: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 1/5] target/i386: Generalize some of the
 macro definitions
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

Generalize some of the macro definitions which are generic cache
properties that are common between CPUID 4 and CPUID 0x8000001D
in preparation for adding support for 0x8000001D.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b5e431e..42dd381 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -66,22 +66,22 @@
 #define CPUID_2_L3_16MB_16WAY_64B 0x4d
 
 
-/* CPUID Leaf 4 constants: */
+/* Cache specific constants: */
 
 /* EAX: */
-#define CPUID_4_TYPE_DCACHE  1
-#define CPUID_4_TYPE_ICACHE  2
-#define CPUID_4_TYPE_UNIFIED 3
+#define TYPE_DCACHE  1
+#define TYPE_ICACHE  2
+#define TYPE_UNIFIED 3
 
-#define CPUID_4_LEVEL(l)          ((l) << 5)
+#define CACHE_LEVEL(l)          ((l) << 5)
 
-#define CPUID_4_SELF_INIT_LEVEL (1 << 8)
-#define CPUID_4_FULLY_ASSOC     (1 << 9)
+#define CACHE_SELF_INIT_LEVEL (1 << 8)
+#define CACHE_FULLY_ASSOC     (1 << 9)
 
 /* EDX: */
-#define CPUID_4_NO_INVD_SHARING (1 << 0)
-#define CPUID_4_INCLUSIVE       (1 << 1)
-#define CPUID_4_COMPLEX_IDX     (1 << 2)
+#define CACHE_NO_INVD_SHARING (1 << 0)
+#define CACHE_INCLUSIVE       (1 << 1)
+#define CACHE_COMPLEX_IDX     (1 << 2)
 
 #define ASSOC_FULL 0xFF
 
@@ -3273,29 +3273,29 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *eax = 0;
             switch (count) {
             case 0: /* L1 dcache info */
-                *eax |= CPUID_4_TYPE_DCACHE | \
-                        CPUID_4_LEVEL(1) | \
-                        CPUID_4_SELF_INIT_LEVEL;
+                *eax |= TYPE_DCACHE | \
+                        CACHE_LEVEL(1) | \
+                        CACHE_SELF_INIT_LEVEL;
                 *ebx = (L1D_LINE_SIZE - 1) | \
                        ((L1D_PARTITIONS - 1) << 12) | \
                        ((L1D_ASSOCIATIVITY - 1) << 22);
                 *ecx = L1D_SETS - 1;
-                *edx = CPUID_4_NO_INVD_SHARING;
+                *edx = CACHE_NO_INVD_SHARING;
                 break;
             case 1: /* L1 icache info */
-                *eax |= CPUID_4_TYPE_ICACHE | \
-                        CPUID_4_LEVEL(1) | \
-                        CPUID_4_SELF_INIT_LEVEL;
+                *eax |= TYPE_ICACHE | \
+                        CACHE_LEVEL(1) | \
+                        CACHE_SELF_INIT_LEVEL;
                 *ebx = (L1I_LINE_SIZE - 1) | \
                        ((L1I_PARTITIONS - 1) << 12) | \
                        ((L1I_ASSOCIATIVITY - 1) << 22);
                 *ecx = L1I_SETS - 1;
-                *edx = CPUID_4_NO_INVD_SHARING;
+                *edx = CACHE_NO_INVD_SHARING;
                 break;
             case 2: /* L2 cache info */
-                *eax |= CPUID_4_TYPE_UNIFIED | \
-                        CPUID_4_LEVEL(2) | \
-                        CPUID_4_SELF_INIT_LEVEL;
+                *eax |= TYPE_UNIFIED | \
+                        CACHE_LEVEL(2) | \
+                        CACHE_SELF_INIT_LEVEL;
                 if (cs->nr_threads > 1) {
                     *eax |= (cs->nr_threads - 1) << 14;
                 }
@@ -3303,7 +3303,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                        ((L2_PARTITIONS - 1) << 12) | \
                        ((L2_ASSOCIATIVITY - 1) << 22);
                 *ecx = L2_SETS - 1;
-                *edx = CPUID_4_NO_INVD_SHARING;
+                *edx = CACHE_NO_INVD_SHARING;
                 break;
             case 3: /* L3 cache info */
                 if (!cpu->enable_l3_cache) {
@@ -3313,16 +3313,16 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                     *edx = 0;
                     break;
                 }
-                *eax |= CPUID_4_TYPE_UNIFIED | \
-                        CPUID_4_LEVEL(3) | \
-                        CPUID_4_SELF_INIT_LEVEL;
+                *eax |= TYPE_UNIFIED | \
+                        CACHE_LEVEL(3) | \
+                        CACHE_SELF_INIT_LEVEL;
                 pkg_offset = apicid_pkg_offset(cs->nr_cores, cs->nr_threads);
                 *eax |= ((1 << pkg_offset) - 1) << 14;
                 *ebx = (L3_N_LINE_SIZE - 1) | \
                        ((L3_N_PARTITIONS - 1) << 12) | \
                        ((L3_N_ASSOCIATIVITY - 1) << 22);
                 *ecx = L3_N_SETS - 1;
-                *edx = CPUID_4_INCLUSIVE | CPUID_4_COMPLEX_IDX;
+                *edx = CACHE_INCLUSIVE | CACHE_COMPLEX_IDX;
                 break;
             default: /* end of info */
                 *eax = 0;
-- 
1.8.3.1
