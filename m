Received: from eggs.gnu.org ([2001:4830:134:3::10]:39855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fKvMr-0002NO-7i
	for qemu-devel@nongnu.org; Mon, 21 May 2018 20:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fKvMn-00079Z-6s
	for qemu-devel@nongnu.org; Mon, 21 May 2018 20:41:33 -0400
Received: from mail-co1nam03on0050.outbound.protection.outlook.com
	([104.47.40.50]:16315
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fKvMm-00078T-Ui
	for qemu-devel@nongnu.org; Mon, 21 May 2018 20:41:29 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Mon, 21 May 2018 20:41:12 -0400
Message-ID: <1526949675-106737-3-git-send-email-babu.moger@amd.com>
In-Reply-To: <1526949675-106737-1-git-send-email-babu.moger@amd.com>
References: <1526949675-106737-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 2/5] i386: Populate AMD Processor Cache
 Information for cpuid 0x8000001D
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

Add information for cpuid 0x8000001D leaf. Populate cache topology informat=
ion
for different cache types(Data Cache, Instruction Cache, L2 and L3) support=
ed
by 0x8000001D leaf. Please refer Processor Programming Reference (PPR) for =
AMD
Family 17h Model for more details.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 target/i386/kvm.c |  29 +++++++++++++--
 2 files changed, 129 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d9773b6..1dd060a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -336,6 +336,85 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l=
2,
     }
 }
=20
+/* Definitions used for building CPUID Leaf 0x8000001D and 0x8000001E */
+/* Please refer AMD64 Architecture Programmer=E2=80=99s Manual Volume 3 */
+#define MAX_CCX 2
+#define MAX_CORES_IN_CCX 4
+#define MAX_NODES_EPYC 4
+#define MAX_CORES_IN_NODE 8
+
+/* Number of logical processors sharing L3 cache */
+#define NUM_SHARING_CACHE(threads, num_sharing)   ((threads > 1) ? \
+                         (((num_sharing - 1) * threads) + 1)  : \
+                         (num_sharing - 1))
+/*
+ * L3 Cache is shared between all the cores in a core complex.
+ * Maximum cores that can share L3 is 4.
+ */
+static int num_sharing_l3_cache(int nr_cores)
+{
+    int i, nodes =3D 1;
+
+    /* Check if we can fit all the cores in one CCX */
+    if (nr_cores <=3D MAX_CORES_IN_CCX) {
+        return nr_cores;
+    }
+    /*
+     * Figure out the number of nodes(or dies) required to build
+     * this config. Max cores in a node is 8
+     */
+    for (i =3D nodes; i <=3D MAX_NODES_EPYC; i++) {
+        if (nr_cores <=3D (i * MAX_CORES_IN_NODE)) {
+            nodes =3D i;
+            break;
+        }
+        /* We support nodes 1, 2, 4 */
+        if (i =3D=3D 3) {
+            continue;
+        }
+    }
+    /* Spread the cores accros all the CCXs and return max cores in a ccx =
*/
+    return (nr_cores / (nodes * MAX_CCX)) +
+            ((nr_cores % (nodes * MAX_CCX)) ? 1 : 0);
+}
+
+/* Encode cache info for CPUID[8000001D] */
+static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
+                                uint32_t *eax, uint32_t *ebx,
+                                uint32_t *ecx, uint32_t *edx)
+{
+    uint32_t num_share_l3;
+    assert(cache->size =3D=3D cache->line_size * cache->associativity *
+                          cache->partitions * cache->sets);
+
+    *eax =3D CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
+               (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
+
+    /* L3 is shared among multiple cores */
+    if (cache->level =3D=3D 3) {
+        num_share_l3 =3D num_sharing_l3_cache(cs->nr_cores);
+        *eax |=3D (NUM_SHARING_CACHE(cs->nr_threads, num_share_l3) << 14);
+    } else {
+        *eax |=3D ((cs->nr_threads - 1) << 14);
+    }
+
+    assert(cache->line_size > 0);
+    assert(cache->partitions > 0);
+    assert(cache->associativity > 0);
+    /* We don't implement fully-associative caches */
+    assert(cache->associativity < cache->sets);
+    *ebx =3D (cache->line_size - 1) |
+           ((cache->partitions - 1) << 12) |
+           ((cache->associativity - 1) << 22);
+
+    assert(cache->sets > 0);
+    *ecx =3D cache->sets - 1;
+
+    *edx =3D (cache->no_invd_sharing ? CACHE_NO_INVD_SHARING : 0) |
+           (cache->inclusive ? CACHE_INCLUSIVE : 0) |
+           (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
+}
+
 /*
  * Definitions of the hardcoded cache entries we expose:
  * These are legacy cache values. If there is a need to change any
@@ -4005,6 +4084,30 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index,=
 uint32_t count,
             *edx =3D 0;
         }
         break;
+    case 0x8000001D:
+        *eax =3D 0;
+        switch (count) {
+        case 0: /* L1 dcache info */
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, cs,
+                                       eax, ebx, ecx, edx);
+            break;
+        case 1: /* L1 icache info */
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache, cs,
+                                       eax, ebx, ecx, edx);
+            break;
+        case 2: /* L2 cache info */
+            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache, cs,
+                                       eax, ebx, ecx, edx);
+            break;
+        case 3: /* L3 cache info */
+            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache, cs,
+                                       eax, ebx, ecx, edx);
+            break;
+        default: /* end of info */
+            *eax =3D *ebx =3D *ecx =3D *edx =3D 0;
+            break;
+        }
+        break;
     case 0xC0000000:
         *eax =3D env->cpuid_xlevel2;
         *ebx =3D 0;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index d6666a4..a8bf7eb 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -979,9 +979,32 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
         c =3D &cpuid_data.entries[cpuid_i++];
=20
-        c->function =3D i;
-        c->flags =3D 0;
-        cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+        switch (i) {
+        case 0x8000001d:
+            /* Query for all AMD cache information leaves */
+            for (j =3D 0; ; j++) {
+                c->function =3D i;
+                c->flags =3D KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+                c->index =3D j;
+                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->ed=
x);
+
+                if (c->eax =3D=3D 0) {
+                    break;
+                }
+                if (cpuid_i =3D=3D KVM_MAX_CPUID_ENTRIES) {
+                    fprintf(stderr, "cpuid_data is full, no space for "
+                            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
+                    abort();
+                }
+                c =3D &cpuid_data.entries[cpuid_i++];
+            }
+            break;
+        default:
+            c->function =3D i;
+            c->flags =3D 0;
+            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            break;
+        }
     }
=20
     /* Call Centaur's CPUID instructions they are supported. */
--=20
1.8.3.1
