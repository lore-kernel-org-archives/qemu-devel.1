Received: from eggs.gnu.org ([2001:4830:134:3::10]:39853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fKvMr-0002NN-7d
	for qemu-devel@nongnu.org; Mon, 21 May 2018 20:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Babu.Moger@amd.com>) id 1fKvMn-00079v-Nj
	for qemu-devel@nongnu.org; Mon, 21 May 2018 20:41:33 -0400
Received: from mail-co1nam03on0050.outbound.protection.outlook.com
	([104.47.40.50]:16315
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1fKvMn-00078T-E8
	for qemu-devel@nongnu.org; Mon, 21 May 2018 20:41:29 -0400
From: Babu Moger <babu.moger@amd.com>
Date: Mon, 21 May 2018 20:41:13 -0400
Message-Id: <1526949675-106737-4-git-send-email-babu.moger@amd.com>
In-Reply-To: <1526949675-106737-1-git-send-email-babu.moger@amd.com>
References: <1526949675-106737-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v10 3/5] i386: Add support for CPUID_8000_001E
 for AMD
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

Add support for cpuid leaf CPUID_8000_001E. Build the config that closely
match the underlying hardware. Please refer Processor Programming Reference
(PPR) for AMD Family 17h Model for more details.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 target/i386/cpu.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1dd060a..d9ccaad 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -415,6 +415,86 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
            (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
 }
 
+/* Data structure to hold the configuration info for a given core index */
+struct epyc_topo {
+    /* core complex id of the current core index */
+    int ccx_id;
+    /* new core id for this core index in the topology */
+    int core_id;
+    /* Node(or Die) id this core index */
+    int node_id;
+    /* Number of nodes(or dies) in this config, 0 based */
+    int num_nodes;
+};
+
+/*
+ * Build the configuration closely match the EPYC hardware
+ * nr_cores : Total number of cores in the config
+ * core_id  : Core index of the current CPU
+ * topo     : Data structure to hold all the config info for this core index
+ * Rules
+ * Max ccx in a node(die) = 2
+ * Max cores in a ccx     = 4
+ * Max nodes(dies)        = 4 (1, 2, 4)
+ * Max sockets            = 2
+ * Maintain symmetry as much as possible
+ */
+static void epyc_build_topology(int nr_cores, int core_id,
+                                struct epyc_topo *topo)
+{
+    int nodes = 1, cores_in_ccx;
+    int i;
+
+    /* Lets see if we can fit  all the cores in one ccx */
+    if (nr_cores <= MAX_CORES_IN_CCX) {
+        cores_in_ccx = nr_cores;
+        goto topo;
+    }
+    /*
+     * Figure out the number of nodes(or dies) required to build
+     * this config. Max cores in a node is 8
+     */
+    for (i = nodes; i <= MAX_NODES_EPYC; i++) {
+        if (nr_cores <= (i * MAX_CORES_IN_NODE)) {
+            nodes = i;
+            break;
+        }
+        /* We support nodes 1, 2, 4 */
+        if (i == 3) {
+            continue;
+        }
+    }
+    /* Spread the cores accros all the CCXs and return max cores in a ccx */
+    cores_in_ccx = (nr_cores / (nodes * MAX_CCX)) +
+                   ((nr_cores % (nodes * MAX_CCX)) ? 1 : 0);
+
+topo:
+    topo->node_id = core_id / (cores_in_ccx * MAX_CCX);
+    topo->ccx_id = (core_id % (cores_in_ccx * MAX_CCX)) / cores_in_ccx;
+    topo->core_id = core_id % cores_in_ccx;
+    /* num_nodes is 0 based, return n - 1 */
+    topo->num_nodes = nodes - 1;
+}
+
+/* Encode cache info for CPUID[8000001E] */
+static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
+                                       uint32_t *eax, uint32_t *ebx,
+                                       uint32_t *ecx, uint32_t *edx)
+{
+    struct epyc_topo topo = {0};
+
+    *eax = cpu->apic_id;
+    epyc_build_topology(cs->nr_cores, cpu->core_id, &topo);
+    if (cs->nr_threads - 1) {
+        *ebx = ((cs->nr_threads - 1) << 8) | (topo.node_id << 3) |
+                (topo.ccx_id << 2) | topo.core_id;
+    } else {
+        *ebx = (topo.node_id << 4) | (topo.ccx_id << 3) | topo.core_id;
+    }
+    *ecx = (topo.num_nodes << 8) | (cpu->socket_id << 2) | topo.node_id;
+    *edx = 0;
+}
+
 /*
  * Definitions of the hardcoded cache entries we expose:
  * These are legacy cache values. If there is a need to change any
@@ -4108,6 +4188,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
1.8.3.1
