Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EC6C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 07:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D122178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 07:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D122178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSccY-0001UJ-QN
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 02:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iScUC-0001Vx-JM
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 02:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iScU7-0005g5-Qe
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 02:45:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:5076)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iScU7-0004DB-DW
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 02:45:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Nov 2019 23:45:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,277,1569308400"; d="scan'208";a="404016877"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2019 23:45:32 -0800
From: Tao Xu <tao3.xu@intel.com>
To: mst@redhat.com, imammedo@redhat.com, eblake@redhat.com,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, armbru@redhat.com,
 mdroth@linux.vnet.ibm.com, thuth@redhat.com, lvivier@redhat.com
Subject: [PATCH v15 06/12] numa: Extend CLI to provide memory latency and
 bandwidth information
Date: Thu,  7 Nov 2019 15:45:05 +0800
Message-Id: <20191107074511.14304-7-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191107074511.14304-1-tao3.xu@intel.com>
References: <20191107074511.14304-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Jingqi <jingqi.liu@intel.com>

Add -numa hmat-lb option to provide System Locality Latency and
Bandwidth Information. These memory attributes help to build
System Locality Latency and Bandwidth Information Structure(s)
in ACPI Heterogeneous Memory Attribute Table (HMAT).

Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v15:
    - Change the QAPI version tag to 5.0 (Eric)

Changes in v14:
    - Use qemu ctz64 and clz64 instead of builtin function
    - Improve help message in qemu-options.hx

Changes in v13:
    - Reuse Garray to store the raw bandwidth and bandwidth data
    - Calculate common base unit using range bitmap (Igor)
---
 hw/core/numa.c        | 136 ++++++++++++++++++++++++++++++++++++++++++
 include/sysemu/numa.h |  68 +++++++++++++++++++++
 qapi/machine.json     |  94 ++++++++++++++++++++++++++++-
 qemu-options.hx       |  49 ++++++++++++++-
 4 files changed, 344 insertions(+), 3 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index eba66ab768..f391760c20 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/numa.h"
 #include "sysemu/sysemu.h"
@@ -198,6 +199,128 @@ void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
     ms->numa_state->have_numa_distance = true;
 }
 
+void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
+                        Error **errp)
+{
+    int first_bit, last_bit;
+    uint64_t max_latency, temp_base_la;
+    NodeInfo *numa_info = numa_state->nodes;
+    HMAT_LB_Info *hmat_lb =
+        numa_state->hmat_lb[node->hierarchy][node->data_type];
+    HMAT_LB_Data lb_data;
+
+    /* Error checking */
+    if (node->initiator >= numa_state->num_nodes) {
+        error_setg(errp, "Invalid initiator=%d, it should be less than %d.",
+                   node->initiator, numa_state->num_nodes);
+        return;
+    }
+    if (node->target >= numa_state->num_nodes) {
+        error_setg(errp, "Invalid target=%d, it should be less than %d.",
+                   node->target, numa_state->num_nodes);
+        return;
+    }
+    if (!numa_info[node->initiator].has_cpu) {
+        error_setg(errp, "Invalid initiator=%d, it isn't an "
+                   "initiator proximity domain.", node->initiator);
+        return;
+    }
+    if (!numa_info[node->target].present) {
+        error_setg(errp, "Invalid target=%d, it hasn't a valid NUMA node.",
+                   node->target);
+        return;
+    }
+
+    if (!hmat_lb) {
+        hmat_lb = g_malloc0(sizeof(*hmat_lb));
+        numa_state->hmat_lb[node->hierarchy][node->data_type] = hmat_lb;
+        hmat_lb->latency = g_array_new(false, true, sizeof(HMAT_LB_Data));
+        hmat_lb->bandwidth = g_array_new(false, true, sizeof(HMAT_LB_Data));
+    }
+    hmat_lb->hierarchy = node->hierarchy;
+    hmat_lb->data_type = node->data_type;
+    lb_data.initiator = node->initiator;
+    lb_data.target = node->target;
+
+    /* Input latency data */
+    if (node->data_type <= HMATLB_DATA_TYPE_WRITE_LATENCY) {
+        if (!node->has_latency) {
+            error_setg(errp, "Missing 'latency' option.");
+            return;
+        }
+        if (node->has_bandwidth) {
+            error_setg(errp, "Invalid option 'bandwidth' since "
+                       "the data type is latency.");
+            return;
+        }
+
+        if (hmat_lb->base_latency == 0) {
+            hmat_lb->base_latency = UINT64_MAX;
+        }
+
+        /* Calculate the temporary base and compressed latency */
+        max_latency = node->latency;
+        temp_base_la = 1;
+        while (QEMU_IS_ALIGNED(max_latency, 10)) {
+            max_latency /= 10;
+            temp_base_la *= 10;
+        }
+
+        /* Calculate the max compressed latency */
+        hmat_lb->base_latency = MIN(hmat_lb->base_latency, temp_base_la);
+        max_latency = node->latency / hmat_lb->base_latency;
+        hmat_lb->max_entry_la = MAX(hmat_lb->max_entry_la, max_latency);
+
+        if (hmat_lb->max_entry_la >= UINT16_MAX) {
+            error_setg(errp, "Latency %" PRIu64 " between initiator=%d and "
+                       "target=%d should not differ from previously entered "
+                       "values on more than %d.", node->latency,
+                       node->initiator, node->target, UINT16_MAX - 1);
+            return;
+        }
+
+        lb_data.rawdata = node->latency;
+        g_array_append_val(hmat_lb->latency, lb_data);
+    }
+
+    /* Input bandwidth data */
+    if (node->data_type >= HMATLB_DATA_TYPE_ACCESS_BANDWIDTH) {
+        if (!node->has_bandwidth) {
+            error_setg(errp, "Missing 'bandwidth' option.");
+            return;
+        }
+        if (node->has_latency) {
+            error_setg(errp, "Invalid option 'latency' since "
+                       "the data type is bandwidth.");
+            return;
+        }
+        if (!QEMU_IS_ALIGNED(node->bandwidth, MiB)) {
+            error_setg(errp, "Bandwidth %" PRIu64 " between initiator=%d and "
+                       "target=%d should be 1MB aligned.", node->bandwidth,
+                       node->initiator, node->target);
+            return;
+        }
+
+        hmat_lb->range_bitmap_bw |= node->bandwidth;
+
+        first_bit = ctz64(hmat_lb->range_bitmap_bw);
+        hmat_lb->base_bandwidth = UINT64_C(1) << first_bit;
+        last_bit = 64 - clz64(hmat_lb->range_bitmap_bw);
+        if ((last_bit - first_bit) > UINT16_BITS ||
+            (MAKE_64BIT_MASK(first_bit, UINT16_BITS) == node->bandwidth)) {
+            error_setg(errp, "Bandwidth %" PRIu64 " between initiator=%d and "
+                       "target=%d should not differ from previously entered "
+                       "values on more than %d.", node->bandwidth,
+                       node->initiator, node->target, UINT16_MAX - 1);
+            return;
+        }
+
+        hmat_lb->base_bandwidth = UINT64_C(1) << first_bit;
+        lb_data.rawdata = node->bandwidth;
+        g_array_append_val(hmat_lb->bandwidth, lb_data);
+    }
+}
+
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
 {
     Error *err = NULL;
@@ -236,6 +359,19 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
         machine_set_cpu_numa_node(ms, qapi_NumaCpuOptions_base(&object->u.cpu),
                                   &err);
         break;
+    case NUMA_OPTIONS_TYPE_HMAT_LB:
+        if (!ms->numa_state->hmat_enabled) {
+            error_setg(errp, "ACPI Heterogeneous Memory Attribute Table "
+                       "(HMAT) is disabled, enable it with -machine hmat=on "
+                       "before using any of hmat specific options.");
+            return;
+        }
+
+        parse_numa_hmat_lb(ms->numa_state, &object->u.hmat_lb, &err);
+        if (err) {
+            goto end;
+        }
+        break;
     default:
         abort();
     }
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 788cbec7a2..36e1b4dece 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -14,6 +14,29 @@ struct CPUArchId;
 #define NUMA_DISTANCE_MAX         254
 #define NUMA_DISTANCE_UNREACHABLE 255
 
+/* the value of AcpiHmatLBInfo flags */
+enum {
+    HMAT_LB_MEM_MEMORY           = 0,
+    HMAT_LB_MEM_CACHE_1ST_LEVEL  = 1,
+    HMAT_LB_MEM_CACHE_2ND_LEVEL  = 2,
+    HMAT_LB_MEM_CACHE_3RD_LEVEL  = 3,
+};
+
+/* the value of AcpiHmatLBInfo data type */
+enum {
+    HMAT_LB_DATA_ACCESS_LATENCY   = 0,
+    HMAT_LB_DATA_READ_LATENCY     = 1,
+    HMAT_LB_DATA_WRITE_LATENCY    = 2,
+    HMAT_LB_DATA_ACCESS_BANDWIDTH = 3,
+    HMAT_LB_DATA_READ_BANDWIDTH   = 4,
+    HMAT_LB_DATA_WRITE_BANDWIDTH  = 5,
+};
+
+#define UINT16_BITS       16
+
+#define HMAT_LB_LEVELS    (HMAT_LB_MEM_CACHE_3RD_LEVEL + 1)
+#define HMAT_LB_TYPES     (HMAT_LB_DATA_WRITE_BANDWIDTH + 1)
+
 struct NodeInfo {
     uint64_t node_mem;
     struct HostMemoryBackend *node_memdev;
@@ -28,6 +51,46 @@ struct NumaNodeMem {
     uint64_t node_plugged_mem;
 };
 
+struct HMAT_LB_Data {
+    uint8_t     initiator;
+    uint8_t     target;
+    uint64_t    rawdata;
+};
+typedef struct HMAT_LB_Data HMAT_LB_Data;
+
+struct HMAT_LB_Info {
+    /* Indicates it's memory or the specified level memory side cache. */
+    uint8_t     hierarchy;
+
+    /* Present the type of data, access/read/write latency or bandwidth. */
+    uint8_t     data_type;
+
+    /* The max compressed latency for calculating common latency base */
+    uint64_t    max_entry_la;
+
+    /* The range bitmap of bandwidth for calculating common bandwidth base */
+    uint64_t    range_bitmap_bw;
+
+    /* The common base unit for latencies */
+    uint64_t    base_latency;
+
+    /* The common base unit for bandwidths */
+    uint64_t    base_bandwidth;
+
+    /* Array to store the compressed latencies */
+    uint16_t    *entry_latency;
+
+    /* Array to store the compressed latencies */
+    uint16_t    *entry_bandwidth;
+
+    /* Array to store the latencies */
+    GArray      *latency;
+
+    /* Array to store the bandwidthes */
+    GArray      *bandwidth;
+};
+typedef struct HMAT_LB_Info HMAT_LB_Info;
+
 struct NumaState {
     /* Number of NUMA nodes */
     int num_nodes;
@@ -40,11 +103,16 @@ struct NumaState {
 
     /* NUMA nodes information */
     NodeInfo nodes[MAX_NODES];
+
+    /* NUMA nodes HMAT Locality Latency and Bandwidth Information */
+    HMAT_LB_Info *hmat_lb[HMAT_LB_LEVELS][HMAT_LB_TYPES];
 };
 typedef struct NumaState NumaState;
 
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp);
 void parse_numa_opts(MachineState *ms);
+void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
+                        Error **errp);
 void numa_complete_configuration(MachineState *ms);
 void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms);
 extern QemuOptsList qemu_numa_opts;
diff --git a/qapi/machine.json b/qapi/machine.json
index 27d0e37534..da4d2c2cfc 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -426,10 +426,12 @@
 #
 # @cpu: property based CPU(s) to node mapping (Since: 2.10)
 #
+# @hmat-lb: memory latency and bandwidth information (Since: 5.0)
+#
 # Since: 2.1
 ##
 { 'enum': 'NumaOptionsType',
-  'data': [ 'node', 'dist', 'cpu' ] }
+  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
 
 ##
 # @NumaOptions:
@@ -444,7 +446,8 @@
   'data': {
     'node': 'NumaNodeOptions',
     'dist': 'NumaDistOptions',
-    'cpu': 'NumaCpuOptions' }}
+    'cpu': 'NumaCpuOptions',
+    'hmat-lb': 'NumaHmatLBOptions' }}
 
 ##
 # @NumaNodeOptions:
@@ -557,6 +560,93 @@
    'base': 'CpuInstanceProperties',
    'data' : {} }
 
+##
+# @HmatLBMemoryHierarchy:
+#
+# The memory hierarchy in the System Locality Latency
+# and Bandwidth Information Structure of HMAT (Heterogeneous
+# Memory Attribute Table)
+#
+# For more information of @HmatLBMemoryHierarchy see
+# the chapter 5.2.27.4: Table 5-142: Field "Flags" of ACPI 6.3 spec.
+#
+# @memory: the structure represents the memory performance
+#
+# @first-level: first level memory of memory side cached memory
+#
+# @second-level: second level memory of memory side cached memory
+#
+# @third-level: third level memory of memory side cached memory
+#
+# Since: 5.0
+##
+{ 'enum': 'HmatLBMemoryHierarchy',
+  'data': [ 'memory', 'first-level', 'second-level', 'third-level' ] }
+
+##
+# @HmatLBDataType:
+#
+# Data type in the System Locality Latency
+# and Bandwidth Information Structure of HMAT (Heterogeneous
+# Memory Attribute Table)
+#
+# For more information of @HmatLBDataType see
+# the chapter 5.2.27.4: Table 5-142:  Field "Data Type" of ACPI 6.3 spec.
+#
+# @access-latency: access latency (nanoseconds)
+#
+# @read-latency: read latency (nanoseconds)
+#
+# @write-latency: write latency (nanoseconds)
+#
+# @access-bandwidth: access bandwidth (B/s)
+#
+# @read-bandwidth: read bandwidth (B/s)
+#
+# @write-bandwidth: write bandwidth (B/s)
+#
+# Since: 5.0
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
+# For more information of @NumaHmatLBOptions see
+# the chapter 5.2.27.4: Table 5-142 of ACPI 6.3 spec.
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
+# @latency: the value of latency from @initiator to @target proximity domain,
+#           the latency unit is "ns(nanosecond)".
+#
+# @bandwidth: the value of bandwidth between @initiator and @target proximity
+#             domain, the bandwidth unit is "B(/s)".
+#
+# Since: 5.0
+##
+{ 'struct': 'NumaHmatLBOptions',
+    'data': {
+    'initiator': 'uint16',
+    'target': 'uint16',
+    'hierarchy': 'HmatLBMemoryHierarchy',
+    'data-type': 'HmatLBDataType',
+    '*latency': 'time',
+    '*bandwidth': 'size' }}
+
 ##
 # @HostMemPolicy:
 #
diff --git a/qemu-options.hx b/qemu-options.hx
index cb0417b736..ec4ec37010 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -168,16 +168,19 @@ DEF("numa", HAS_ARG, QEMU_OPTION_numa,
     "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
     "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node][,initiator=node]\n"
     "-numa dist,src=source,dst=destination,val=distance\n"
-    "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n",
+    "-numa cpu,node-id=node[,socket-id=x][,core-id=y][,thread-id=z]\n"
+    "-numa hmat-lb,initiator=node,target=node,hierarchy=memory|first-level|second-level|third-level,data-type=access-latency|read-latency|write-latency[,latency=lat][,bandwidth=bw]\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}][,initiator=@var{initiator}]
 @itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}][,initiator=@var{initiator}]
 @itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
 @itemx -numa cpu,node-id=@var{node}[,socket-id=@var{x}][,core-id=@var{y}][,thread-id=@var{z}]
+@itemx -numa hmat-lb,initiator=@var{node},target=@var{node},hierarchy=@var{hierarchy},data-type=@var{tpye}[,latency=@var{lat}][,bandwidth=@var{bw}]
 @findex -numa
 Define a NUMA node and assign RAM and VCPUs to it.
 Set the NUMA distance from a source node to a destination node.
+Set the ACPI Heterogeneous Memory Attributes for the given nodes.
 
 Legacy VCPU assignment uses @samp{cpus} option where
 @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
@@ -256,6 +259,50 @@ specified resources, it just assigns existing resources to NUMA
 nodes. This means that one still has to use the @option{-m},
 @option{-smp} options to allocate RAM and VCPUs respectively.
 
+Use @samp{hmat-lb} to set System Locality Latency and Bandwidth Information
+between initiator and target NUMA nodes in ACPI Heterogeneous Attribute Memory Table (HMAT).
+Initiator NUMA node can create memory requests, usually it has one or more processors.
+Target NUMA node contains addressable memory.
+
+In @samp{hmat-lb} option, @var{node} are NUMA node IDs. @var{hierarchy} is the memory
+hierarchy of the target NUMA node: if @var{hierarchy} is 'memory', the structure
+represents the memory performance; if @var{hierarchy} is 'first-level|second-level|third-level',
+this structure represents aggregated performance of memory side caches for each domain.
+@var{type} of 'data-type' is type of data represented by this structure instance:
+if 'hierarchy' is 'memory', 'data-type' is 'access|read|write' latency or 'access|read|write'
+bandwidth of the target memory; if 'hierarchy' is 'first-level|second-level|third-level',
+'data-type' is 'access|read|write' hit latency or 'access|read|write' hit bandwidth of the
+target memory side cache.
+
+@var{lat} of 'latency' is latency value, the possible value and units are
+NUM[ns|us|ms] (nanosecond|microsecond|millisecond), the recommended unit is 'ns'.
+@var{bw} is bandwidth value, the possible value and units are NUM[M|G|T], mean that
+the bandwidth value are NUM MB/s, GB/s or TB/s. Note that for @var{lat} and @var{bw}
+max NUM is 65534, if NUM is 0, means the corresponding latency or bandwidth information
+is not provided. And if input numbers without any unit, the latency unit will be 'ns'
+and the bandwidth will be MB/s.
+
+For example, the following option assigns NUMA node 0 and 1. Node 0 has 2 cpus and
+a ram, node 1 has only a ram. The processors in node 0 access memory in node
+0 with access-latency 5 nanoseconds, access-bandwidth is 200 MB/s;
+The processors in NUMA node 0 access memory in NUMA node 1 with access-latency 10
+nanoseconds, access-bandwidth is 100 MB/s.
+@example
+-machine hmat=on \
+-m 2G \
+-object memory-backend-ram,size=1G,id=m0 \
+-object memory-backend-ram,size=1G,id=m1 \
+-smp 2 \
+-numa node,nodeid=0,memdev=m0 \
+-numa node,nodeid=1,memdev=m1,initiator=0 \
+-numa cpu,node-id=0,socket-id=0 \
+-numa cpu,node-id=0,socket-id=1 \
+-numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-latency,latency=5ns \
+-numa hmat-lb,initiator=0,target=0,hierarchy=memory,data-type=access-bandwidth,bandwidth=200M \
+-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,latency=10ns \
+-numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-bandwidth,bandwidth=100M
+@end example
+
 ETEXI
 
 DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
-- 
2.20.1


