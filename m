Received: from eggs.gnu.org ([2001:4830:134:3::10]:47806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fGKb0-0006Fv-1y
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fGKav-0001wA-TR
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:37:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:22274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fGKav-0001uH-Gl
	for qemu-devel@nongnu.org; Wed, 09 May 2018 04:37:05 -0400
From: Liu Jingqi <jingqi.liu@intel.com>
Date: Wed,  9 May 2018 16:36:38 +0800
Message-Id: <1525854998-14243-1-git-send-email-jingqi.liu@intel.com>
Subject: [Qemu-devel] [PATCH v1 5/7] numa: Extend the command-line to
 provide memory latency and bandwidth information
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

Add -numa hmat-lb option to provide System Locality Latency and
Bandwidth Information. These memory attributes help to build
System Locality Latency and Bandwidth Information Structure(s)
in ACPI Heterogeneous Memory Attribute Table (HMAT).

Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
---
 numa.c          | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json  |  42 ++++++++++++++++-
 qemu-options.hx |  28 ++++++++++-
 3 files changed, 209 insertions(+), 3 deletions(-)

diff --git a/numa.c b/numa.c
index fe0009c..ad708de 100644
--- a/numa.c
+++ b/numa.c
@@ -177,6 +177,142 @@ static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
     have_numa_distance = true;
 }
 
+static void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
+                            Error **errp)
+{
+    struct numa_hmat_lb_info *hmat_lb = 0;
+    uint8_t hierarchy, data_type, level;
+    uint16_t initiator, target;
+    uint16_t i;
+
+    if (!node->has_latency && !node->has_bandwidth) {
+        error_setg(errp, "Should specify latency or bandwidth.");
+        return;
+    }
+
+    if (!strcmp(node->hierarchy, "mem")) {
+        hierarchy = HMAT_LB_MEM_MEMORY;
+        level = HMAT_LB_MEM_MEMORY;
+     } else if (!strcmp(node->hierarchy, "cache")) {
+        hierarchy = HMAT_LB_MEM_CACHE_LAST_LEVEL;
+        if (!node->has_level) {
+            error_setg(errp, "Please provide level, it should be less than %d.",
+                       HMAT_LB_MEM_CACHE_3RD_LEVEL);
+            return;
+        } else if (node->level < HMAT_LB_MEM_CACHE_3RD_LEVEL) {
+            level = node->level + 1;
+        } else {
+            error_setg(errp, "Invalid level=%"
+                       PRIu8 ",it should be less than %d.",
+                       node->level, HMAT_LB_MEM_CACHE_3RD_LEVEL);
+            return;
+        }
+        hierarchy += node->level;
+    } else {
+        error_setg(errp, "Invalid memory hierarchy, it should be mem/cache.");
+        return;
+    }
+
+    if (!strcmp(node->data_type, "access")) {
+        data_type = HMAT_LB_DATA_ACCESS_LATENCY;
+    } else if (!strcmp(node->data_type, "read")) {
+        data_type = HMAT_LB_DATA_READ_LATENCY;
+    } else if (!strcmp(node->data_type, "write")) {
+        data_type = HMAT_LB_DATA_WRITE_LATENCY;
+    } else {
+        error_setg(errp, "Invalid data type, it should be access/read/write.");
+        return;
+    }
+
+    initiator = node->initiator;
+    if (initiator >= nb_numa_nodes) {
+        error_setg(errp, "Invalid initiator=%"
+                   PRIu16 ", it should be less than %d.",
+                   node->initiator, nb_numa_nodes);
+        return;
+    }
+    for (i = 0; i < num_initiator; i++) {
+        if (initiator_pxm[i] == initiator) {
+            break;
+        }
+    }
+    if (i >= num_initiator) {
+        error_setg(errp, "Invalid initiator=%"
+                   PRIu16 ", it isn't an initiator proximity domain.",
+                   node->initiator);
+        return;
+    }
+
+    target = node->target;
+    if (target >= nb_numa_nodes) {
+        error_setg(errp, "Invalid initiator=%"
+                   PRIu16 ", it should be less than %d.",
+                   node->target, nb_numa_nodes);
+        return;
+    }
+    for (i = 0; i < num_target; i++) {
+        if (target_pxm[i] == target) {
+            break;
+        }
+    }
+    if (i >= num_target) {
+        error_setg(errp, "Invalid target=%"
+                   PRIu16 ", it isn't a target proximity domain.",
+                   node->target);
+        return;
+    }
+
+    if (node->has_latency) {
+        hmat_lb = hmat_lb_info[hierarchy][data_type];
+        if (!hmat_lb) {
+            hmat_lb = g_malloc0(sizeof(*hmat_lb));
+            hmat_lb_info[hierarchy][data_type] = hmat_lb;
+        } else if (hmat_lb->latency[initiator][target]) {
+            error_setg(errp, "Duplicate configuration of the latency for "
+                       "initiator=%d and target=%d.", initiator, target);
+            return;
+        }
+
+        /* Only the first time of setting the base unit is valid. */
+        if ((hmat_lb->base_lat == 0) && (node->has_base_lat)) {
+            hmat_lb->base_lat = node->base_lat;
+        }
+
+        hmat_lb->latency[initiator][target] = node->latency;
+    }
+
+    if (node->has_bandwidth) {
+        data_type += HMAT_LB_DATA_ACCESS_BANDWIDTH;
+        hmat_lb = hmat_lb_info[hierarchy][data_type];
+
+        if (!hmat_lb) {
+            hmat_lb = g_malloc0(sizeof(*hmat_lb));
+            hmat_lb_info[hierarchy][data_type] = hmat_lb;
+        } else if (hmat_lb->bandwidth[initiator][target]) {
+            error_setg(errp, "Duplicate configuration of the bandwidth for "
+                       "initiator=%d and target=%d.", initiator, target);
+            return;
+        }
+
+        /* Only the first time of setting the base unit is valid. */
+        if (hmat_lb->base_bw == 0) {
+            if (!node->has_base_bw) {
+                error_setg(errp, "Please provide the base-bw!");
+                return;
+            } else {
+                hmat_lb->base_bw = node->base_bw;
+            }
+        }
+
+        hmat_lb->bandwidth[initiator][target] = node->bandwidth;
+    }
+
+    if (hmat_lb) {
+        hmat_lb->hierarchy = level;
+        hmat_lb->data_type = data_type;
+    }
+}
+
 static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
 {
     NumaOptions *object = NULL;
@@ -227,6 +363,12 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
         machine_set_cpu_numa_node(ms, qapi_NumaCpuOptions_base(&object->u.cpu),
                                   &err);
         break;
+    case NUMA_OPTIONS_TYPE_HMAT_LB:
+        parse_numa_hmat_lb(ms, &object->u.hmat_lb, &err);
+        if (err) {
+            goto end;
+        }
+        break;
     default:
         abort();
     }
diff --git a/qapi/misc.json b/qapi/misc.json
index f5988cc..8935838 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2705,7 +2705,7 @@
 # Since: 2.1
 ##
 { 'enum': 'NumaOptionsType',
-  'data': [ 'node', 'dist', 'cpu' ] }
+  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
 
 ##
 # @NumaOptions:
@@ -2720,7 +2720,8 @@
   'data': {
     'node': 'NumaNodeOptions',
     'dist': 'NumaDistOptions',
-    'cpu': 'NumaCpuOptions' }}
+    'cpu': 'NumaCpuOptions',
+    'hmat-lb': 'NumaHmatLBOptions' }}
 
 ##
 # @NumaNodeOptions:
@@ -2784,6 +2785,43 @@
    'data' : {} }
 
 ##
+# @NumaHmatLBOptions:
+#
+# Set the system locality latency and bandwidth information between Initiator and Target proximity Domains.
+#
+# @initiator: the Initiator Proximity Domain.
+#
+# @target: the Target Proximity Domain.
+#
+# @hierarchy: the Memory Hierarchy. Indicates the performance of memory or side cache.
+#
+# @level: indicates the level of side cache, if it's the performance of side cache.
+#
+# @data-type: presents the type of data, access/read/write latency or hit latency.
+#
+# @base-lat: the base unit for latency in nanosecondsbytes.
+#
+# @base-bw: the base unit for bandwidth in megabytes per second(MB/s).
+#
+# @latency: the value of latency based on Base Unit from @initiator to @target proximity domain.
+#
+# @bandwidth: the value of bandwidth based on Base Unit between @initiator to @target proximity domain.
+#
+# Since: 2.10
+##
+{ 'struct': 'NumaHmatLBOptions',
+  'data': {
+   'initiator': 'uint16',
+   'target': 'uint16',
+   'hierarchy': 'str',
+   '*level': 'uint8',
+   'data-type': 'str',
+   '*base-lat': 'uint64',
+   '*base-bw': 'uint64',
+   '*latency': 'uint16',
+   '*bandwidth': 'uint16' }}
+
+##
 # @HostMemPolicy:
 #
 # Host memory policy types
diff --git a/qemu-options.hx b/qemu-options.hx
index c611766..8c38d83 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -173,16 +173,19 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
     "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
     "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
     "-numa dist,src=source,dst=destination,val=distance\n"
-    "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n",
+    "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
+    "-numa hmat-lb,initiator=node,target=node,hierarchy=mem|cache,data-type=access|read|write[,base-lat=blat][,base-bw=bbw][,latency=lat][,bandwidth=bw]\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
 @itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
 @itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
 @itemx -numa cpu,node-id=@var{node}[,socket-id=@var{x}][,core-id=@var{y}][,thread-id=@var{z}]
+@itemx -numa hmat-lb,initiator=@var{node},target=@var{node},hierarchy=@var{str},data-type=@var{str}[,base-lat=@var{blat}][,base-bw=@var{bbw}][,latency=@var{lat}][,bandwidth=@var{bw}]
 @findex -numa
 Define a NUMA node and assign RAM and VCPUs to it.
 Set the NUMA distance from a source node to a destination node.
+Set the ACPI Heterogeneous Memory Attribute for the given nodes.
 
 Legacy VCPU assignment uses @samp{cpus} option where
 @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
@@ -240,6 +243,29 @@ specified resources, it just assigns existing resources to NUMA
 nodes. This means that one still has to use the @option{-m},
 @option{-smp} options to allocate RAM and VCPUs respectively.
 
+Use 'hmat-lb' to set System Locality Latency and Bandwidth Information
+between initiator NUMA node and target NUMA node to build ACPI Heterogeneous Attribute Memory Table (HMAT).
+Initiator NUMA node can create memory requests, usually including one or more processors.
+Target NUMA node contains addressable memory.
+
+For example:
+@example
+-m 2G \
+-smp 3,sockets=2,maxcpus=3 \
+-numa node,cpus=0-1,nodeid=0 \
+-numa node,mem=1G,cpus=2,nodeid=1 \
+-numa node,mem=1G,nodeid=2 \
+-numa hmat-lb,initiator=0,target=1,hierarchy=mem,data-type=access,base-lat=10,base-bw=20,latency=10,bandwidth=10 \
+-numa hmat-lb,initiator=1,target=2,hierarchy=cache,level=2,data-type=access,base-bw=10,bandwidth=20
+@end example
+
+When the processors in NUMA node 0 access memory in NUMA node 1,
+the first line containing 'hmat-lb' sets the latency and bandwidth information.
+The latency is @var{lat} multiplied by @var{blat} and the bandwidth is @var{bw} multiplied by @var{bbw}.
+
+When the processors in NUMA node 1 access memory in NUMA node 2 that acts as 2nd level memory side cache,
+the second line containing 'hmat-lb' sets the access hit bandwidth information.
+
 ETEXI
 
 DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
-- 
2.7.4
