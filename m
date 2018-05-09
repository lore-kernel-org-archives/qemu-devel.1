Received: from eggs.gnu.org ([2001:4830:134:3::10]:48072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fGKcV-0007Vf-Ct
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fGKcR-00048x-BV
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:38:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:30747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fGKcQ-00047J-UR
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:38:39 -0400
From: Liu Jingqi <jingqi.liu@intel.com>
Date: Wed,  9 May 2018 16:38:10 +0800
Message-Id: <1525855090-14384-1-git-send-email-jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 6/7] numa: Extend the command-line to
 provide memory side cache information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: mst@redhat.com, imammedo@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, Liu Jingqi <jingqi.liu@intel.com>

Add -numa hmat-cache option to provide Memory Side Cache Information.
These memory attributes help to build Memory Side Cache Information
Structure(s) in ACPI Heterogeneous Memory Attribute Table (HMAT).

Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
---
 numa.c          | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json  | 36 ++++++++++++++++++++--
 qemu-options.hx | 23 +++++++++++++-
 3 files changed, 151 insertions(+), 3 deletions(-)

diff --git a/numa.c b/numa.c
index ad708de..a7d6560 100644
--- a/numa.c
+++ b/numa.c
@@ -313,6 +313,95 @@ static void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
     }
 }
 
+static void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
+                            Error **errp)
+{
+    struct numa_hmat_cache_info *hmat_cache;
+    uint8_t assoc, policy, mem_pxm, level, total;
+    uint16_t i;
+
+    mem_pxm = node->node_id;
+    if (mem_pxm >= nb_numa_nodes) {
+        error_setg(errp, "Invalid node-id=%d, it should be less than %d.",
+                   mem_pxm, nb_numa_nodes);
+        return;
+    }
+    for (i = 0; i < num_target; i++) {
+        if (target_pxm[i] == mem_pxm) {
+            break;
+        }
+    }
+    if (i >= num_target) {
+        error_setg(errp, "Invalid node-id=%d, "
+                   "it isn't a target proximity domain.",
+                   mem_pxm);
+        return;
+    }
+
+    total = node->total;
+    level = node->level;
+
+    if ((total > MAX_HMAT_CACHE_LEVEL) || (level > MAX_HMAT_CACHE_LEVEL)) {
+        error_setg(errp, "Invalid cache level, it should be less than %d.",
+                   MAX_HMAT_CACHE_LEVEL);
+        return;
+    }
+
+    if (hmat_cache_info[mem_pxm][level]) {
+        error_setg(errp, "Duplicate configuration of the side cache for "
+                   "node-id=%d and level=%d.", mem_pxm, level);
+        return;
+    }
+
+    if ((level > 1) &&
+        hmat_cache_info[mem_pxm][level - 1] &&
+        (node->size >= hmat_cache_info[mem_pxm][level - 1]->size)) {
+        error_setg(errp, "Invalid size, the size of level=%d "
+                   "should be less than the size(0x%lx) of level=%d.",
+                   level, hmat_cache_info[mem_pxm][level - 1]->size, level - 1);
+        return;
+    }
+
+    if (!strcmp(node->assoc, "none")) {
+        assoc = 0;
+    } else if (!strcmp(node->assoc, "direct")) {
+        assoc = 1;
+    } else if (!strcmp(node->assoc, "complex")) {
+        assoc = 2;
+    } else {
+        error_setg(errp, "Invalid cache assoc=%s, "
+                   "it should be none/direct/complex.",
+                   node->assoc);
+        return;
+    }
+
+    if (!strcmp(node->policy, "none")) {
+        policy = 0;
+    } else if (!strcmp(node->policy, "wb")) {
+        policy = 1;
+    } else if (!strcmp(node->policy, "wt")) {
+        policy = 2;
+    } else {
+        error_setg(errp, "Invalid policy=%s, "
+                   "it should be none/write back/write through.",
+                   node->policy);
+        return;
+    }
+
+    hmat_cache = g_malloc0(sizeof(*hmat_cache));
+
+    hmat_cache->mem_proximity = mem_pxm;
+    hmat_cache->size = node->size;
+    hmat_cache->total_levels = total;
+    hmat_cache->level = level;
+    hmat_cache->associativity = assoc;
+    hmat_cache->write_policy = policy;
+    hmat_cache->line_size = node->line;
+    hmat_cache->num_smbios_handles = 0;
+
+    hmat_cache_info[mem_pxm][level] = hmat_cache;
+}
+
 static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
 {
     NumaOptions *object = NULL;
@@ -369,6 +458,12 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
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
index 8935838..9c21f2d 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2705,7 +2705,7 @@
 # Since: 2.1
 ##
 { 'enum': 'NumaOptionsType',
-  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
+  'data': [ 'node', 'dist', 'cpu', 'hmat-lb', 'hmat-cache' ] }
 
 ##
 # @NumaOptions:
@@ -2721,7 +2721,8 @@
     'node': 'NumaNodeOptions',
     'dist': 'NumaDistOptions',
     'cpu': 'NumaCpuOptions',
-    'hmat-lb': 'NumaHmatLBOptions' }}
+    'hmat-lb': 'NumaHmatLBOptions',
+    'hmat-cache': 'NumaHmatCacheOptions' }}
 
 ##
 # @NumaNodeOptions:
@@ -2822,6 +2823,37 @@
    '*bandwidth': 'uint16' }}
 
 ##
+# @NumaHmatCacheOptions:
+#
+# Set the memory side cache information for a given memory domain.
+#
+# @node-id: the memory proximity domain to wich the memory belongs.
+#
+# @size: the size of memory side cache in bytes.
+#
+# @total: the total cache levels for this memory proximity domain.
+#
+# @level: the cache level described in this structure.
+#
+# @assoc: the cache associativity, none/direct(direct mapped)/complex(complex cache indexing).
+
+# @policy: the write policy, none/wb(write back)/wt(wirte through).
+#
+# @line: the cache Line size in bytes.
+#
+# Since: 2.10
+##
+{ 'struct': 'NumaHmatCacheOptions',
+  'data': {
+   'node-id': 'uint32',
+   'size': 'size',
+   'total': 'uint8',
+   'level': 'uint8',
+   'assoc': 'str',
+   'policy': 'str',
+   'line': 'uint16' }}
+
+##
 # @HostMemPolicy:
 #
 # Host memory policy types
diff --git a/qemu-options.hx b/qemu-options.hx
index 8c38d83..90f4857 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -174,7 +174,8 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
     "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
     "-numa dist,src=source,dst=destination,val=distance\n"
     "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
-    "-numa hmat-lb,initiator=node,target=node,hierarchy=mem|cache,data-type=access|read|write[,base-lat=blat][,base-bw=bbw][,latency=lat][,bandwidth=bw]\n",
+    "-numa hmat-lb,initiator=node,target=node,hierarchy=mem|cache,data-type=access|read|write[,base-lat=blat][,base-bw=bbw][,latency=lat][,bandwidth=bw]\n"
+    "-numa hmat-cache,node-id=node,size=len,total=tot,level=lvl,assoc=none|direct|complex,policy=none|wb|wt,line=bytes\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
@@ -182,6 +183,7 @@ STEXI
 @itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
 @itemx -numa cpu,node-id=@var{node}[,socket-id=@var{x}][,core-id=@var{y}][,thread-id=@var{z}]
 @itemx -numa hmat-lb,initiator=@var{node},target=@var{node},hierarchy=@var{str},data-type=@var{str}[,base-lat=@var{blat}][,base-bw=@var{bbw}][,latency=@var{lat}][,bandwidth=@var{bw}]
+@itemx -numa hmat-cache,node-id=@var{node},size=@var{size},total=@var{tot},level=@var{lvl},assoc=@var{str},policy=@var{str},line=@var{bytes}
 @findex -numa
 Define a NUMA node and assign RAM and VCPUs to it.
 Set the NUMA distance from a source node to a destination node.
@@ -266,6 +268,25 @@ The latency is @var{lat} multiplied by @var{blat} and the bandwidth is @var{bw}
 When the processors in NUMA node 1 access memory in NUMA node 2 that acts as 2nd level memory side cache,
 the second line containing 'hmat-lb' sets the access hit bandwidth information.
 
+Use 'hmat-cache' to set Memory Side Cache Information for a given NUMA node that contains memory
+to build ACPI Heterogeneous Attribute Memory Table (HMAT).
+
+For example:
+@example
+-m 2G \
+-smp 3,sockets=2,maxcpus=3 \
+-numa node,cpus=0-1,nodeid=0 \
+-numa node,mem=1G,cpus=2,nodeid=1 \
+-numa node,mem=1G,nodeid=2 \
+-numa hmat-cache,node-id=1,size=0x10000,total=3,level=2,assoc=direct,policy=wb,line=16
+@end example
+
+It describes memory side cache information for NUMA node 1.
+The memory is belongs to NUMA node 1 which has three total cache levels.
+And it acts as the second-level cache which size is @var{size}.
+The cache associativity is Direct Mapped and write policy is Write Back。
+The cache line size is 16 bytes.
+
 ETEXI
 
 DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
-- 
2.7.4
