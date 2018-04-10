Received: from eggs.gnu.org ([2001:4830:134:3::10]:33786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f62V6-0003Es-A9
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 19:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1f62V3-0005iT-47
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 19:16:32 -0400
Received: from mail-bn3nam01on0087.outbound.protection.outlook.com
	([104.47.33.87]:7416
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1f62V2-0005iK-Sh
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 19:16:29 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Tue, 10 Apr 2018 19:16:06 -0400
Message-Id: <1523402169-113351-7-git-send-email-babu.moger@amd.com>
In-Reply-To: <1523402169-113351-1-git-send-email-babu.moger@amd.com>
References: <1523402169-113351-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 6/9] i386: Populate AMD Processor Cache
 Information for cpuid 0x8000001D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com, babu.moger@amd.com

Add information for cpuid 0x8000001D leaf. Populate cache topology information
for different cache types(Data Cache, Instruction Cache, L2 and L3) supported
by 0x8000001D leaf. Please refer Processor Programming Reference (PPR) for AMD
Family 17h Model for more details.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
---
 target/i386/cpu.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/kvm.c | 29 ++++++++++++++++--
 2 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 76b3bc9..63f2d31 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -307,6 +307,14 @@ static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
                           a == ASSOC_FULL ? 0xF : \
                           0 /* invalid value */)
 
+/* Definitions used on CPUID Leaf 0x8000001D */
+/* Number of logical cores in a complex */
+#define CORES_IN_CMPLX  4
+/* Number of logical processors sharing cache */
+#define NUM_SHARING_CACHE(threads)   (threads ? \
+                         (((CORES_IN_CMPLX - 1) * 2) + 1)  : \
+                         (CORES_IN_CMPLX - 1))
+
 /*
  * Encode cache info for CPUID[0x80000006].ECX and CPUID[0x80000006].EDX
  * @l3 can be NULL.
@@ -336,6 +344,41 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
     }
 }
 
+/* Encode cache info for CPUID[8000001D] */
+static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, int nr_threads,
+                                uint32_t *eax, uint32_t *ebx,
+                                uint32_t *ecx, uint32_t *edx)
+{
+    assert(cache->size == cache->line_size * cache->associativity *
+                          cache->partitions * cache->sets);
+
+    *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
+               (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
+
+    /* L3 is shared among multiple cores */
+    if (cache->level == 3) {
+        *eax |= (NUM_SHARING_CACHE(nr_threads - 1) << 14);
+    } else {
+        *eax |= ((nr_threads - 1) << 14);
+    }
+
+    assert(cache->line_size > 0);
+    assert(cache->partitions > 0);
+    assert(cache->associativity > 0);
+    /* We don't implement fully-associative caches */
+    assert(cache->associativity < cache->sets);
+    *ebx = (cache->line_size - 1) |
+           ((cache->partitions - 1) << 12) |
+           ((cache->associativity - 1) << 22);
+
+    assert(cache->sets > 0);
+    *ecx = cache->sets - 1;
+
+    *edx = (cache->no_invd_sharing ? CACHE_NO_INVD_SHARING : 0) |
+           (cache->inclusive ? CACHE_INCLUSIVE : 0) |
+           (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
+}
+
 /* Definitions of the hardcoded cache entries we expose: */
 
 /* L1 data cache: */
@@ -4006,6 +4049,55 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
+    case 0x8000001D:
+        *eax = 0;
+        switch (count) {
+        case 0: /* L1 dcache info */
+            if (env->cache_info.valid && !cpu->legacy_cache) {
+                encode_cache_cpuid8000001d(&env->cache_info.l1d_cache,
+                                           cs->nr_threads,
+                                           eax, ebx, ecx, edx);
+            } else {
+                encode_cache_cpuid8000001d(&l1d_cache_amd, cs->nr_threads,
+                                           eax, ebx, ecx, edx);
+            }
+            break;
+        case 1: /* L1 icache info */
+            if (env->cache_info.valid && !cpu->legacy_cache) {
+                encode_cache_cpuid8000001d(&env->cache_info.l1i_cache,
+                                           cs->nr_threads,
+                                           eax, ebx, ecx, edx);
+            } else {
+                encode_cache_cpuid8000001d(&l1i_cache_amd,
+                                           cs->nr_threads,
+                                           eax, ebx, ecx, edx);
+            }
+            break;
+        case 2: /* L2 cache info */
+            if (env->cache_info.valid && !cpu->legacy_cache) {
+                encode_cache_cpuid8000001d(&env->cache_info.l2_cache,
+                                           cs->nr_threads,
+                                           eax, ebx, ecx, edx);
+            } else {
+                encode_cache_cpuid8000001d(&l2_cache_amd, cs->nr_threads,
+                                           eax, ebx, ecx, edx);
+            }
+            break;
+        case 3: /* L3 cache info */
+            if (env->cache_info.valid && !cpu->legacy_cache) {
+                encode_cache_cpuid8000001d(&env->cache_info.l3_cache,
+                                           cs->nr_threads,
+                                           eax, ebx, ecx, edx);
+            } else {
+                encode_cache_cpuid8000001d(&l3_cache, cs->nr_threads,
+                                           eax, ebx, ecx, edx);
+            }
+            break;
+        default: /* end of info */
+            *eax = *ebx = *ecx = *edx = 0;
+            break;
+        }
+        break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
         *ebx = 0;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index d23fff1..d170d2a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -937,9 +937,32 @@ int kvm_arch_init_vcpu(CPUState *cs)
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
