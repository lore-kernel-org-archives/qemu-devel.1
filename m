Received: from eggs.gnu.org ([209.51.188.92]:33401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gp6cd-0006x9-8c
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gp6cb-00038K-95
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:18:51 -0500
Received: from mga07.intel.com ([134.134.136.100]:58179)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1gp6ca-0002vB-RG
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:18:49 -0500
From: Tao Xu <tao3.xu@intel.com>
Date: Thu, 31 Jan 2019 15:16:54 +0800
Message-Id: <20190131071658.29120-5-tao3.xu@intel.com>
In-Reply-To: <20190131071658.29120-1-tao3.xu@intel.com>
References: <20190131071658.29120-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH v3 4/8] Extend the command-line to provide
 memory latency and bandwidth information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com, mst@redhat.com, imammedo@redhat.com, xiaoguangrong.eric@gmail.com
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, karl.heubaum@oracle.com, jingqi.liu@intel.com, danmei.wei@intel.com, qemu-devel@nongnu.org, tao3.xu@intel.com

From: Liu Jingqi <jingqi.liu@intel.com>

Add -numa hmat-lb option to provide System Locality Latency and
Bandwidth Information. These memory attributes help to build
System Locality Latency and Bandwidth Information Structure(s)
in ACPI Heterogeneous Memory Attribute Table (HMAT).

Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 numa.c          | 124 ++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json  |  94 +++++++++++++++++++++++++++++++++++-
 qemu-options.hx |  28 ++++++++++-
 3 files changed, 243 insertions(+), 3 deletions(-)

diff --git a/numa.c b/numa.c
index 9ee4f6f258..97b77356ad 100644
--- a/numa.c
+++ b/numa.c
@@ -40,6 +40,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
+#include "hw/acpi/hmat.h"
 
 QemuOptsList qemu_numa_opts = {
     .name = "numa",
@@ -180,6 +181,123 @@ static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
     have_numa_distance = true;
 }
 
+static void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
+                               Error **errp)
+{
+    struct numa_hmat_lb_info *hmat_lb = 0;
+
+    if (node->data_type <= HMATLB_DATA_TYPE_WRITE_LATENCY) {
+        if (!node->has_latency) {
+            error_setg(errp, "Please specify the latency.");
+            return;
+        }
+        if (node->has_bandwidth) {
+            error_setg(errp, "Please do not specify the bandwidth "
+                       "since the data type is latency.");
+            return;
+        }
+        if (node->has_base_bw) {
+            error_setg(errp, "Please do not specify the base-bw "
+                       "since the data type is latency.");
+            return;
+        }
+    }
+
+    if (node->data_type >= HMATLB_DATA_TYPE_ACCESS_BANDWIDTH) {
+        if (!node->has_bandwidth) {
+            error_setg(errp, "Please specify the bandwidth.");
+            return;
+        }
+        if (node->has_latency) {
+            error_setg(errp, "Please do not specify the latency "
+                       "since the data type is bandwidth.");
+            return;
+        }
+        if (node->has_base_lat) {
+            error_setg(errp, "Please do not specify the base-lat "
+                       "since the data type is bandwidth.");
+            return;
+        }
+    }
+
+    if (node->initiator >= nb_numa_nodes) {
+        error_setg(errp, "Invalid initiator=%"
+                   PRIu16 ", it should be less than %d.",
+                   node->initiator, nb_numa_nodes);
+        return;
+    }
+    if (!numa_info[node->initiator].is_initiator) {
+        error_setg(errp, "Invalid initiator=%"
+                   PRIu16 ", it isn't an initiator proximity domain.",
+                   node->initiator);
+        return;
+    }
+
+    if (node->target >= nb_numa_nodes) {
+        error_setg(errp, "Invalid initiator=%"
+                   PRIu16 ", it should be less than %d.",
+                   node->target, nb_numa_nodes);
+        return;
+    }
+    if (!numa_info[node->target].is_target) {
+        error_setg(errp, "Invalid target=%"
+                   PRIu16 ", it isn't a target proximity domain.",
+                   node->target);
+        return;
+    }
+
+    if (node->has_latency) {
+        hmat_lb = hmat_lb_info[node->hierarchy][node->data_type];
+        if (!hmat_lb) {
+            hmat_lb = g_malloc0(sizeof(*hmat_lb));
+            hmat_lb_info[node->hierarchy][node->data_type] = hmat_lb;
+        } else if (hmat_lb->latency[node->initiator][node->target]) {
+            error_setg(errp, "Duplicate configuration of the latency for "
+                       "initiator=%" PRIu16 " and target=%" PRIu16 ".",
+                       node->initiator, node->target);
+            return;
+        }
+
+        /* Only the first time of setting the base unit is valid. */
+        if ((hmat_lb->base_lat == 0) && (node->has_base_lat)) {
+            hmat_lb->base_lat = node->base_lat;
+        }
+
+        hmat_lb->latency[node->initiator][node->target] = node->latency;
+    }
+
+    if (node->has_bandwidth) {
+        hmat_lb = hmat_lb_info[node->hierarchy][node->data_type];
+
+        if (!hmat_lb) {
+            hmat_lb = g_malloc0(sizeof(*hmat_lb));
+            hmat_lb_info[node->hierarchy][node->data_type] = hmat_lb;
+        } else if (hmat_lb->bandwidth[node->initiator][node->target]) {
+            error_setg(errp, "Duplicate configuration of the bandwidth for "
+                       "initiator=%" PRIu16 " and target=%" PRIu16 ".",
+                       node->initiator, node->target);
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
+        hmat_lb->bandwidth[node->initiator][node->target] = node->bandwidth;
+    }
+
+    if (hmat_lb) {
+        hmat_lb->hierarchy = node->hierarchy;
+        hmat_lb->data_type = node->data_type;
+    }
+}
+
 static
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
 {
@@ -213,6 +331,12 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
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
index 426274ecf8..10ba90bb39 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2782,10 +2782,12 @@
 #
 # @cpu: property based CPU(s) to node mapping (Since: 2.10)
 #
+# @hmat-lb: memory latency and bandwidth information (Since: 4.0)
+#
 # Since: 2.1
 ##
 { 'enum': 'NumaOptionsType',
-  'data': [ 'node', 'dist', 'cpu' ] }
+  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
 
 ##
 # @NumaOptions:
@@ -2800,7 +2802,8 @@
   'data': {
     'node': 'NumaNodeOptions',
     'dist': 'NumaDistOptions',
-    'cpu': 'NumaCpuOptions' }}
+    'cpu': 'NumaCpuOptions',
+    'hmat-lb': 'NumaHmatLBOptions' }}
 
 ##
 # @NumaNodeOptions:
@@ -2863,6 +2866,93 @@
    'base': 'CpuInstanceProperties',
    'data' : {} }
 
+##
+# @HmatLBMemoryHierarchy:
+#
+# The memory hierarchy in the System Locality Latency
+# and Bandwidth Information Structure of HMAT (Heterogeneous
+# Memory Attribute Table)
+#
+# @memory: the structure represents the memory performance
+#
+# @last-level: last level memory of memory side cached memory
+#
+# @first-level: first level memory of memory side cached memory
+#
+# @second-level: second level memory of memory side cached memory
+#
+# @third-level: third level memory of memory side cached memory
+#
+# Since: 4.0
+##
+{ 'enum': 'HmatLBMemoryHierarchy',
+  'data': [ 'memory', 'last-level', 'first-level',
+            'second-level', 'third-level' ] }
+
+##
+# @HmatLBDataType:
+#
+# Data type in the System Locality Latency
+# and Bandwidth Information Structure of HMAT (Heterogeneous
+# Memory Attribute Table)
+#
+# @access-latency: access latency (nanoseconds)
+#
+# @read-latency: read latency (nanoseconds)
+#
+# @write-latency: write latency (nanoseconds)
+#
+# @access-bandwidth: access bandwidth (MB/s)
+#
+# @read-bandwidth: read bandwidth (MB/s)
+#
+# @write-bandwidth: write bandwidth (MB/s)
+#
+# Since: 4.0
+##
+{ 'enum': 'HmatLBDataType',
+  'data': [ 'access-latency', 'read-latency', 'write-latency',
+            'access-bandwidth', 'read-bandwidth', 'write-bandwidth' ] }
+
+##
+# @NumaHmatLBOptions:
+#
+# Set the system locality latency and bandwidth information
+# between Initiator and Target proximity Domains.
+#
+# @initiator: the Initiator Proximity Domain.
+#
+# @target: the Target Proximity Domain.
+#
+# @hierarchy: the Memory Hierarchy. Indicates the performance
+#             of memory or side cache.
+#
+# @data-type: presents the type of data, access/read/write
+#             latency or hit latency.
+#
+# @base-lat: the base unit for latency in nanoseconds.
+#
+# @base-bw: the base unit for bandwidth in megabytes per second(MB/s).
+#
+# @latency: the value of latency based on Base Unit from @initiator
+#           to @target proximity domain.
+#
+# @bandwidth: the value of bandwidth based on Base Unit between
+#             @initiator and @target proximity domain.
+#
+# Since: 4.0
+##
+{ 'struct': 'NumaHmatLBOptions',
+  'data': {
+   'initiator': 'uint16',
+   'target': 'uint16',
+   'hierarchy': 'HmatLBMemoryHierarchy',
+   'data-type': 'HmatLBDataType',
+   '*base-lat': 'uint64',
+   '*base-bw': 'uint64',
+   '*latency': 'uint16',
+   '*bandwidth': 'uint16' }}
+
 ##
 # @HostMemPolicy:
 #
diff --git a/qemu-options.hx b/qemu-options.hx
index 521511ec13..fec20a93e7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -163,16 +163,19 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
     "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
     "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
     "-numa dist,src=source,dst=destination,val=distance\n"
-    "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n",
+    "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
+    "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|last-level,data-type=access-latency|read-latency|write-latency[,base-lat=blat][,base-bw=bbw][,latency=lat][,bandwidth=bw]\n",
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
@@ -230,6 +233,29 @@ specified resources, it just assigns existing resources to NUMA
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
+-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,base-lat=10,base-bw=20,latency=10,bandwidth=10 \
+-numa hmat-lb,initiator=1,target=2,hierarchy=first-level,data-type=access-latency,base-bw=10,bandwidth=20
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
2.17.1
