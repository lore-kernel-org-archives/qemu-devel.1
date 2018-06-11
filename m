Received: from eggs.gnu.org ([2001:4830:134:3::10]:55947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQYA-0006qF-U4
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQY9-0000Wk-MN
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:24:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQY9-0000W8-EY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:24:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:23:54 -0300
Message-Id: <20180611172355.12067-3-ehabkost@redhat.com>
In-Reply-To: <20180611172355.12067-1-ehabkost@redhat.com>
References: <20180611172355.12067-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] i386: Populate AMD Processor Cache
 Information for cpuid 0x8000001D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, Babu Moger <babu.moger@amd.com>

From: Babu Moger <babu.moger@amd.com>

Add information for cpuid 0x8000001D leaf. Populate cache topology inform=
ation
for different cache types (Data Cache, Instruction Cache, L2 and L3) supp=
orted
by 0x8000001D leaf. Please refer to the Processor Programming Reference (=
PPR)
for AMD Family 17h Model for more details.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Message-Id: <1527176614-26271-3-git-send-email-babu.moger@amd.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/kvm.c |  29 ++++++++++--
 2 files changed, 143 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1ea7bf4911..1e69e68f25 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -334,6 +334,99 @@ static void encode_cache_cpuid80000006(CPUCacheInfo =
*l2,
     }
 }
=20
+/*
+ * Definitions used for building CPUID Leaf 0x8000001D and 0x8000001E
+ * Please refer to the AMD64 Architecture Programmer=E2=80=99s Manual Vo=
lume 3.
+ * Define the constants to build the cpu topology. Right now, TOPOEXT
+ * feature is enabled only on EPYC. So, these constants are based on
+ * EPYC supported configurations. We may need to handle the cases if
+ * these values change in future.
+ */
+/* Maximum core complexes in a node */
+#define MAX_CCX 2
+/* Maximum cores in a core complex */
+#define MAX_CORES_IN_CCX 4
+/* Maximum cores in a node */
+#define MAX_CORES_IN_NODE 8
+/* Maximum nodes in a socket */
+#define MAX_NODES_PER_SOCKET 4
+
+/*
+ * Figure out the number of nodes required to build this config.
+ * Max cores in a node is 8
+ */
+static int nodes_in_socket(int nr_cores)
+{
+    int nodes;
+
+    nodes =3D DIV_ROUND_UP(nr_cores, MAX_CORES_IN_NODE);
+
+   /* Hardware does not support config with 3 nodes, return 4 in that ca=
se */
+    return (nodes =3D=3D 3) ? 4 : nodes;
+}
+
+/*
+ * Decide the number of cores in a core complex with the given nr_cores =
using
+ * following set constants MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_NODE =
and
+ * MAX_NODES_PER_SOCKET. Maintain symmetry as much as possible
+ * L3 cache is shared across all cores in a core complex. So, this will =
also
+ * tell us how many cores are sharing the L3 cache.
+ */
+static int cores_in_core_complex(int nr_cores)
+{
+    int nodes;
+
+    /* Check if we can fit all the cores in one core complex */
+    if (nr_cores <=3D MAX_CORES_IN_CCX) {
+        return nr_cores;
+    }
+    /* Get the number of nodes required to build this config */
+    nodes =3D nodes_in_socket(nr_cores);
+
+    /*
+     * Divide the cores accros all the core complexes
+     * Return rounded up value
+     */
+    return DIV_ROUND_UP(nr_cores, nodes * MAX_CCX);
+}
+
+/* Encode cache info for CPUID[8000001D] */
+static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs=
,
+                                uint32_t *eax, uint32_t *ebx,
+                                uint32_t *ecx, uint32_t *edx)
+{
+    uint32_t l3_cores;
+    assert(cache->size =3D=3D cache->line_size * cache->associativity *
+                          cache->partitions * cache->sets);
+
+    *eax =3D CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
+               (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
+
+    /* L3 is shared among multiple cores */
+    if (cache->level =3D=3D 3) {
+        l3_cores =3D cores_in_core_complex(cs->nr_cores);
+        *eax |=3D ((l3_cores * cs->nr_threads) - 1) << 14;
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
@@ -4003,6 +4096,30 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t inde=
x, uint32_t count,
             *edx =3D 0;
         }
         break;
+    case 0x8000001D:
+        *eax =3D 0;
+        switch (count) {
+        case 0: /* L1 dcache info */
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, cs=
,
+                                       eax, ebx, ecx, edx);
+            break;
+        case 1: /* L1 icache info */
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache, cs=
,
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
index 44f70733e7..445e0e0b11 100644
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
+                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->=
edx);
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
+            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx)=
;
+            break;
+        }
     }
=20
     /* Call Centaur's CPUID instructions they are supported. */
--=20
2.18.0.rc1.1.g3f1ff2140
