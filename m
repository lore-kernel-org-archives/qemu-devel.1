Received: from eggs.gnu.org ([2001:4830:134:3::10]:54447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1evUZE-0001VT-50
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1evUZA-0007Vi-8V
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:01:12 -0400
Received: from mail-bn3nam01on0040.outbound.protection.outlook.com
	([104.47.33.40]:22240
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1evUZA-0007VI-1R
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:01:08 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Mon, 12 Mar 2018 17:00:46 -0400
Message-Id: <1520888449-4352-3-git-send-email-babu.moger@amd.com>
In-Reply-To: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
References: <1520888449-4352-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 2/5] target/i386: Populate AMD Processor
 Cache Information
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

From: Stanislav Lanci <pixo@polepetko.eu>

Add information for cpuid 0x8000001D leaf. Populate cache topology information
for different cache types(Data Cache, Instruction Cache, L2 and L3) supported
by 0x8000001D leaf. Please refer Processor Programming Reference (PPR) for AMD
Family 17h Model for more details.

Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/kvm.c | 29 ++++++++++++++++++++++---
 2 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 42dd381..5fdbedd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -118,6 +118,7 @@
 #define L1I_LINE_SIZE         64
 #define L1I_ASSOCIATIVITY      8
 #define L1I_SETS              64
+#define L1I_SETS_AMD         256
 #define L1I_PARTITIONS         1
 /* Size = LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS = 32KiB */
 #define L1I_DESCRIPTOR CPUID_2_L1I_32KB_8WAY_64B
@@ -129,7 +130,9 @@
 /* Level 2 unified cache: */
 #define L2_LINE_SIZE          64
 #define L2_ASSOCIATIVITY      16
+#define L2_ASSOCIATIVITY_AMD   8
 #define L2_SETS             4096
+#define L2_SETS_AMD         1024
 #define L2_PARTITIONS          1
 /* Size = LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS = 4MiB */
 /*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
@@ -146,6 +149,7 @@
 #define L3_N_LINE_SIZE         64
 #define L3_N_ASSOCIATIVITY     16
 #define L3_N_SETS           16384
+#define L3_N_SETS_AMD        8192
 #define L3_N_PARTITIONS         1
 #define L3_N_DESCRIPTOR CPUID_2_L3_16MB_16WAY_64B
 #define L3_N_LINES_PER_TAG      1
@@ -3590,6 +3594,67 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
+    case 0x8000001D: /* AMD TOPOEXT cache info */
+        switch (count) {
+        case 0: /* L1 dcache info */
+            *eax |= TYPE_DCACHE | \
+                    CACHE_LEVEL(1) | \
+                    CACHE_SELF_INIT_LEVEL | \
+                    ((cs->nr_threads - 1) << 14);
+            *ebx = (L1D_LINE_SIZE - 1) | \
+                   ((L1D_PARTITIONS - 1) << 12) | \
+                   ((L1D_ASSOCIATIVITY - 1) << 22);
+            *ecx = L1D_SETS - 1;
+            *edx = 0;
+            break;
+        case 1: /* L1 icache info */
+            *eax |= TYPE_ICACHE | \
+                    CACHE_LEVEL(1) | \
+                    CACHE_SELF_INIT_LEVEL | \
+                    ((cs->nr_threads - 1) << 14);
+            *ebx = (L1I_LINE_SIZE - 1) | \
+                   ((L1I_PARTITIONS - 1) << 12) | \
+                   ((L1I_ASSOCIATIVITY_AMD - 1) << 22);
+            *ecx = L1I_SETS_AMD - 1;
+            *edx = 0;
+            break;
+        case 2: /* L2 cache info */
+            *eax |= TYPE_UNIFIED | \
+                    CACHE_LEVEL(2) | \
+                    CACHE_SELF_INIT_LEVEL | \
+                    ((cs->nr_threads - 1) << 14);
+            *ebx = (L2_LINE_SIZE - 1) | \
+                   ((L2_PARTITIONS - 1) << 12) | \
+                   ((L2_ASSOCIATIVITY_AMD - 1) << 22);
+            *ecx = L2_SETS_AMD - 1;
+            *edx = CACHE_INCLUSIVE;
+            break;
+        case 3: /* L3 cache info */
+            if (cpu->enable_l3_cache) {
+                *eax |= TYPE_UNIFIED | \
+                        CACHE_LEVEL(3) | \
+                        CACHE_SELF_INIT_LEVEL | \
+                        ((cs->nr_cores * cs->nr_threads - 1) << 14);
+                *ebx = (L3_N_LINE_SIZE - 1) | \
+                       ((L3_N_PARTITIONS - 1) << 12) | \
+                       ((L3_N_ASSOCIATIVITY - 1) << 22);
+                *ecx = L3_N_SETS_AMD - 1;
+                *edx = CACHE_NO_INVD_SHARING;
+            } else {
+                *eax = 0;
+                *ebx = 0;
+                *ecx = 0;
+                *edx = 0;
+            }
+            break;
+        default: /* end of info */
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
+            break;
+        }
+        break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
         *ebx = 0;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index ad4b159..0eb39b52 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -909,9 +909,32 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
         c = &cpuid_data.entries[cpuid_i++];
 
-        c->function = i;
-        c->flags = 0;
-        cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+        switch (i) {
+        case 0x8000001d:
+            /* Query for all AMD cache information leaves */
+            for (j = 0; ; j++) {
+                c->function = i;
+                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+                c->index = j;
+                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
+
+                if (c->eax == 0) {
+                    break;
+                }
+                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                    fprintf(stderr, "cpuid_data is full, no space for "
+                            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
+                    abort();
+                }
+                c = &cpuid_data.entries[cpuid_i++];
+            }
+            break;
+        default:
+            c->function = i;
+            c->flags = 0;
+            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            break;
+        }
     }
 
     /* Call Centaur's CPUID instructions they are supported. */
-- 
1.8.3.1
