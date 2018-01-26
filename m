Received: from eggs.gnu.org ([2001:4830:134:3::10]:47701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1efBjA-0004Vz-0d
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 16:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1efBj7-00019E-Qy
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 16:40:04 -0500
Received: from mail-by2nam01on0049.outbound.protection.outlook.com
	([104.47.34.49]:61546
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1efBj7-00017B-Im
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 16:40:01 -0500
From: Babu Moger <babu.moger@amd.com>
Date: Fri, 26 Jan 2018 16:39:41 -0500
Message-Id: <20180126213944.7594-3-babu.moger@amd.com>
In-Reply-To: <20180126213944.7594-1-babu.moger@amd.com>
References: <20180126213944.7594-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/5] target/i386: Populate AMD Processor Cache
 Information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, pixo@polepetko.eu
Cc: mtosatti@redhat.com, babu.moger@amd.com, qemu-devel@nongnu.org, kvm@vger.kernel.org

From: Stanislav Lanci <pixo@polepetko.eu>

Adds information about cache size and topology from cpuid 0x8000001D leaf
for different cache types on AMD processors.

Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/kvm.c | 29 ++++++++++++++++++---
 2 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cb055f5940..31ee746dac 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -117,6 +117,7 @@
 #define L1I_LINE_SIZE         64
 #define L1I_ASSOCIATIVITY      8
 #define L1I_SETS              64
+#define L1I_SETS_AMD         256
 #define L1I_PARTITIONS         1
 /* Size = LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS = 32KiB */
 #define L1I_DESCRIPTOR CPUID_2_L1I_32KB_8WAY_64B
@@ -128,7 +129,9 @@
 /* Level 2 unified cache: */
 #define L2_LINE_SIZE          64
 #define L2_ASSOCIATIVITY      16
+#define L2_ASSOCIATIVITY_AMD   8
 #define L2_SETS             4096
+#define L2_SETS_AMD         1024
 #define L2_PARTITIONS          1
 /* Size = LINE_SIZE*ASSOCIATIVITY*SETS*PARTITIONS = 4MiB */
 /*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
@@ -145,6 +148,7 @@
 #define L3_N_LINE_SIZE         64
 #define L3_N_ASSOCIATIVITY     16
 #define L3_N_SETS           16384
+#define L3_N_SETS_AMD        8192
 #define L3_N_PARTITIONS         1
 #define L3_N_DESCRIPTOR CPUID_2_L3_16MB_16WAY_64B
 #define L3_N_LINES_PER_TAG      1
@@ -3143,6 +3147,78 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
+    case 0x8000001D: /* AMD TOPOEXT cache info */
+        if (cpu->cache_info_passthrough) {
+            host_cpuid(index, count, eax, ebx, ecx, edx);
+            break;
+        } else if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) {
+            *eax = 0;
+            switch (count) {
+            case 0: /* L1 dcache info */
+                *eax |= CPUID_4_TYPE_DCACHE | \
+                        CPUID_4_LEVEL(1) | \
+                        CPUID_4_SELF_INIT_LEVEL | \
+                        ((cs->nr_threads - 1) << 14);
+                *ebx = (L1D_LINE_SIZE - 1) | \
+                       ((L1D_PARTITIONS - 1) << 12) | \
+                       ((L1D_ASSOCIATIVITY - 1) << 22);
+                *ecx = L1D_SETS - 1;
+                *edx = 0;
+                break;
+            case 1: /* L1 icache info */
+                *eax |= CPUID_4_TYPE_ICACHE | \
+                        CPUID_4_LEVEL(1) | \
+                        CPUID_4_SELF_INIT_LEVEL | \
+                        ((cs->nr_threads - 1) << 14);
+                *ebx = (L1I_LINE_SIZE - 1) | \
+                       ((L1I_PARTITIONS - 1) << 12) | \
+                       ((L1I_ASSOCIATIVITY_AMD - 1) << 22);
+                *ecx = L1I_SETS_AMD - 1;
+                *edx = 0;
+                break;
+            case 2: /* L2 cache info */
+                *eax |= CPUID_4_TYPE_UNIFIED | \
+                        CPUID_4_LEVEL(2) | \
+                        CPUID_4_SELF_INIT_LEVEL | \
+                        ((cs->nr_threads - 1) << 14);
+                *ebx = (L2_LINE_SIZE - 1) | \
+                       ((L2_PARTITIONS - 1) << 12) | \
+                       ((L2_ASSOCIATIVITY_AMD - 1) << 22);
+                *ecx = L2_SETS_AMD - 1;
+                *edx = CPUID_4_INCLUSIVE;
+                break;
+            case 3: /* L3 cache info */
+                if (!cpu->enable_l3_cache) {
+                    *eax = 0;
+                    *ebx = 0;
+                    *ecx = 0;
+                    *edx = 0;
+                    break;
+                }
+                *eax |= CPUID_4_TYPE_UNIFIED | \
+                        CPUID_4_LEVEL(3) | \
+                        CPUID_4_SELF_INIT_LEVEL | \
+                        ((cs->nr_cores * cs->nr_threads - 1) << 14);
+                *ebx = (L3_N_LINE_SIZE - 1) | \
+                       ((L3_N_PARTITIONS - 1) << 12) | \
+                       ((L3_N_ASSOCIATIVITY - 1) << 22);
+                *ecx = L3_N_SETS_AMD - 1;
+                *edx = CPUID_4_NO_INVD_SHARING;
+                break;
+            default: /* end of info */
+                *eax = 0;
+                *ebx = 0;
+                *ecx = 0;
+                *edx = 0;
+                break;
+            }
+        } else {
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
+        }
+        break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
         *ebx = 0;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6f69e2fcfd..8022db7631 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -898,9 +898,32 @@ int kvm_arch_init_vcpu(CPUState *cs)
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
2.16.0
