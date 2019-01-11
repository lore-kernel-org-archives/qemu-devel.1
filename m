Received: from eggs.gnu.org ([209.51.188.92]:38218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1ghyrZ-0000ex-1x
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1ghyrW-0003s2-Ug
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:36:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:56401)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ghyrW-0003df-Jv
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:36:46 -0500
From: Tao Xu <tao3.xu@intel.com>
Date: Fri, 11 Jan 2019 23:34:47 +0800
Message-Id: <20190111153451.14304-6-tao3.xu@intel.com>
In-Reply-To: <20190111153451.14304-1-tao3.xu@intel.com>
References: <20190111153451.14304-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH v2 5/9] numa: Extend the command-line to
 provide memory side cache information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, imammedo@redhat.com
Cc: marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, jingqi.liu@intel.com, danmei.wei@intel.com, tao3.xu@intel.com, qemu-devel@nongnu.org

From: Liu Jingqi <jingqi.liu@intel.com>

Add -numa hmat-cache option to provide Memory Side Cache Information.
These memory attributes help to build Memory Side Cache Information
Structure(s) in ACPI Heterogeneous Memory Attribute Table (HMAT).

Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 numa.c         | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json | 72 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/numa.c b/numa.c
index 97b77356ad..c2f4049689 100644
--- a/numa.c
+++ b/numa.c
@@ -298,6 +298,72 @@ static void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
     }
 }
 
+static void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
+                            Error **errp)
+{
+    struct numa_hmat_cache_info *hmat_cache;
+
+    if (node->node_id >= nb_numa_nodes) {
+        error_setg(errp, "Invalid node-id=%" PRIu32
+                   ", it should be less than %d.",
+                   node->node_id, nb_numa_nodes);
+        return;
+    }
+    if (!numa_info[node->node_id].is_target) {
+        error_setg(errp, "Invalid node-id=%" PRIu32
+                   ", it isn't a target proximity domain.",
+                   node->node_id);
+        return;
+    }
+
+    if (node->total > MAX_HMAT_CACHE_LEVEL) {
+        error_setg(errp, "Invalid total=%" PRIu8
+                   ", it should be less than or equal to %d.",
+                   node->total, MAX_HMAT_CACHE_LEVEL);
+        return;
+    }
+    if (node->level > node->total) {
+        error_setg(errp, "Invalid level=%" PRIu8
+                   ", it should be less than or equal to"
+                   " total=%" PRIu8 ".",
+                   node->level, node->total);
+        return;
+    }
+    if (hmat_cache_info[node->node_id][node->level]) {
+        error_setg(errp, "Duplicate configuration of the side cache for "
+                   "node-id=%" PRIu32 " and level=%" PRIu8 ".",
+                   node->node_id, node->level);
+        return;
+    }
+
+    if ((node->level > 1) &&
+        hmat_cache_info[node->node_id][node->level - 1] &&
+        (node->size >=
+            hmat_cache_info[node->node_id][node->level - 1]->size)) {
+        error_setg(errp, "Invalid size=0x%" PRIx64
+                   ", the size of level=%" PRIu8
+                   " should be less than the size(0x%" PRIx64
+                   ") of level=%" PRIu8 ".",
+                   node->size, node->level,
+                   hmat_cache_info[node->node_id][node->level - 1]->size,
+                   node->level - 1);
+        return;
+    }
+
+    hmat_cache = g_malloc0(sizeof(*hmat_cache));
+
+    hmat_cache->mem_proximity = node->node_id;
+    hmat_cache->size = node->size;
+    hmat_cache->total_levels = node->total;
+    hmat_cache->level = node->level;
+    hmat_cache->associativity = node->assoc;
+    hmat_cache->write_policy = node->policy;
+    hmat_cache->line_size = node->line;
+    hmat_cache->num_smbios_handles = 0;
+
+    hmat_cache_info[node->node_id][node->level] = hmat_cache;
+}
+
 static
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
 {
@@ -337,6 +403,12 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
             goto end;
         }
         break;
+    case NUMA_OPTIONS_TYPE_HMAT_CACHE:
+        parse_numa_hmat_cache(ms, &object->u.hmat_cache, &err);
+        if (err) {
+            goto end;
+        }
+        break;
     default:
         abort();
     }
diff --git a/qapi/misc.json b/qapi/misc.json
index b18eb28459..0887a3791a 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2748,10 +2748,12 @@
 #
 # @hmat-lb: memory latency and bandwidth information (Since: 2.13)
 #
+# @hmat-cache: memory side cache information (Since: 2.13)
+#
 # Since: 2.1
 ##
 { 'enum': 'NumaOptionsType',
-  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
+  'data': [ 'node', 'dist', 'cpu', 'hmat-lb', 'hmat-cache' ] }
 
 ##
 # @NumaOptions:
@@ -2767,7 +2769,8 @@
     'node': 'NumaNodeOptions',
     'dist': 'NumaDistOptions',
     'cpu': 'NumaCpuOptions',
-    'hmat-lb': 'NumaHmatLBOptions' }}
+    'hmat-lb': 'NumaHmatLBOptions',
+    'hmat-cache': 'NumaHmatCacheOptions' }}
 
 ##
 # @NumaNodeOptions:
@@ -2915,6 +2918,71 @@
    '*latency': 'uint16',
    '*bandwidth': 'uint16' }}
 
+##
+# @HmatCacheAssociativity:
+#
+# Cache associativity in the Memory Side Cache
+# Information Structure of HMAT
+#
+# @none: None
+#
+# @direct: Direct Mapped
+#
+# @complex: Complex Cache Indexing (implementation specific)
+#
+# Since: 2.13
+##
+{ 'enum': 'HmatCacheAssociativity',
+  'data': [ 'none', 'direct', 'complex' ] }
+
+##
+# @HmatCacheWritePolicy:
+#
+# Cache write policy in the Memory Side Cache
+# Information Structure of HMAT
+#
+# @none: None
+#
+# @write-back: Write Back (WB)
+#
+# @write-through: Write Through (WT)
+#
+# Since: 2.13
+##
+{ 'enum': 'HmatCacheWritePolicy',
+  'data': [ 'none', 'write-back', 'write-through' ] }
+
+##
+# @NumaHmatCacheOptions:
+#
+# Set the memory side cache information for a given memory domain.
+#
+# @node-id: the memory proximity domain to which the memory belongs.
+#
+# @size: the size of memory side cache in bytes.
+#
+# @total: the total cache levels for this memory proximity domain.
+#
+# @level: the cache level described in this structure.
+#
+# @assoc: the cache associativity, none/direct-mapped/complex(complex cache indexing).
+
+# @policy: the write policy, none/write-back/write-through.
+#
+# @line: the cache Line size in bytes.
+#
+# Since: 2.13
+##
+{ 'struct': 'NumaHmatCacheOptions',
+  'data': {
+   'node-id': 'uint32',
+   'size': 'size',
+   'total': 'uint8',
+   'level': 'uint8',
+   'assoc': 'HmatCacheAssociativity',
+   'policy': 'HmatCacheWritePolicy',
+   'line': 'uint16' }}
+
 ##
 # @HostMemPolicy:
 #
-- 
2.17.1
