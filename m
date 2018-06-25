Received: from eggs.gnu.org ([2001:4830:134:3::10]:54236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvQ-0001ga-6i
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXZvO-00033U-7R
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXZvN-00032k-P0
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:25:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 25 Jun 2018 19:25:13 -0300
Message-Id: <20180625222524.382-2-ehabkost@redhat.com>
In-Reply-To: <20180625222524.382-1-ehabkost@redhat.com>
References: <20180625222524.382-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 01/12] i386: Add support for CPUID_8000_001E for
 AMD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Babu Moger <babu.moger@amd.com>

From: Babu Moger <babu.moger@amd.com>

Add support for cpuid leaf CPUID_8000_001E. Build the config that closely
match the underlying hardware. Please refer to the Processor Programming
Reference (PPR) for AMD Family 17h Model for more details.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Message-Id: <1528498581-131037-2-git-send-email-babu.moger@amd.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1e69e68f25..86fb1a4fb8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -427,6 +427,87 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
            (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
 }
 
+/* Data structure to hold the configuration info for a given core index */
+struct core_topology {
+    /* core complex id of the current core index */
+    int ccx_id;
+    /*
+     * Adjusted core index for this core in the topology
+     * This can be 0,1,2,3 with max 4 cores in a core complex
+     */
+    int core_id;
+    /* Node id for this core index */
+    int node_id;
+    /* Number of nodes in this config */
+    int num_nodes;
+};
+
+/*
+ * Build the configuration closely match the EPYC hardware. Using the EPYC
+ * hardware configuration values (MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_NODE)
+ * right now. This could change in future.
+ * nr_cores : Total number of cores in the config
+ * core_id  : Core index of the current CPU
+ * topo     : Data structure to hold all the config info for this core index
+ */
+static void build_core_topology(int nr_cores, int core_id,
+                                struct core_topology *topo)
+{
+    int nodes, cores_in_ccx;
+
+    /* First get the number of nodes required */
+    nodes = nodes_in_socket(nr_cores);
+
+    cores_in_ccx = cores_in_core_complex(nr_cores);
+
+    topo->node_id = core_id / (cores_in_ccx * MAX_CCX);
+    topo->ccx_id = (core_id % (cores_in_ccx * MAX_CCX)) / cores_in_ccx;
+    topo->core_id = core_id % cores_in_ccx;
+    topo->num_nodes = nodes;
+}
+
+/* Encode cache info for CPUID[8000001E] */
+static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
+                                       uint32_t *eax, uint32_t *ebx,
+                                       uint32_t *ecx, uint32_t *edx)
+{
+    struct core_topology topo = {0};
+
+    build_core_topology(cs->nr_cores, cpu->core_id, &topo);
+    *eax = cpu->apic_id;
+    /*
+     * CPUID_Fn8000001E_EBX
+     * 31:16 Reserved
+     * 15:8  Threads per core (The number of threads per core is
+     *       Threads per core + 1)
+     *  7:0  Core id (see bit decoding below)
+     *       SMT:
+     *           4:3 node id
+     *             2 Core complex id
+     *           1:0 Core id
+     *       Non SMT:
+     *           5:4 node id
+     *             3 Core complex id
+     *           1:0 Core id
+     */
+    if (cs->nr_threads - 1) {
+        *ebx = ((cs->nr_threads - 1) << 8) | (topo.node_id << 3) |
+                (topo.ccx_id << 2) | topo.core_id;
+    } else {
+        *ebx = (topo.node_id << 4) | (topo.ccx_id << 3) | topo.core_id;
+    }
+    /*
+     * CPUID_Fn8000001E_ECX
+     * 31:11 Reserved
+     * 10:8  Nodes per processor (Nodes per processor is number of nodes + 1)
+     *  7:0  Node id (see bit decoding below)
+     *         2  Socket id
+     *       1:0  Node id
+     */
+    *ecx = ((topo.num_nodes - 1) << 8) | (cpu->socket_id << 2) | topo.node_id;
+    *edx = 0;
+}
+
 /*
  * Definitions of the hardcoded cache entries we expose:
  * These are legacy cache values. If there is a need to change any
@@ -4120,6 +4201,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             break;
         }
         break;
+    case 0x8000001E:
+        assert(cpu->core_id <= 255);
+        encode_topo_cpuid8000001e(cs, cpu,
+                                  eax, ebx, ecx, edx);
+        break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
         *ebx = 0;
-- 
2.18.0.rc1.1.g3f1ff2140
