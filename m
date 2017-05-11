Received: from eggs.gnu.org ([2001:4830:134:3::10]:37730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tby-0002GC-O3
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tbw-0007kS-KX
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:18:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tbw-0007k6-B2
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:18:52 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:16 -0300
Message-Id: <20170511191843.13784-3-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 02/29] numa: Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, He Chen <he.chen@linux.intel.com>

From: He Chen <he.chen@linux.intel.com>

This patch is going to add SLIT table support in QEMU, and provides
additional option `dist` for command `-numa` to allow user set vNUMA
distance by QEMU command.

With this patch, when a user wants to create a guest that contains
several vNUMA nodes and also wants to set distance among those nodes,
the QEMU command would like:

```
-numa node,nodeid=0,cpus=0 \
-numa node,nodeid=1,cpus=1 \
-numa node,nodeid=2,cpus=2 \
-numa node,nodeid=3,cpus=3 \
-numa dist,src=0,dst=1,val=21 \
-numa dist,src=0,dst=2,val=31 \
-numa dist,src=0,dst=3,val=41 \
-numa dist,src=1,dst=2,val=21 \
-numa dist,src=1,dst=3,val=31 \
-numa dist,src=2,dst=3,val=21 \
```

Signed-off-by: He Chen <he.chen@linux.intel.com>
Message-Id: <1493260558-20728-1-git-send-email-he.chen@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi-schema.json            |  30 +++++++++-
 include/hw/acpi/aml-build.h |   1 +
 include/sysemu/numa.h       |   2 +
 include/sysemu/sysemu.h     |   4 ++
 hw/acpi/aml-build.c         |  26 +++++++++
 hw/i386/acpi-build.c        |   4 ++
 numa.c                      | 137 +++++++++++++++++++++++++++++++++++++++++++-
 qemu-options.hx             |  16 +++++-
 8 files changed, 215 insertions(+), 5 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 5728b7f363..f4eef33a44 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5682,10 +5682,14 @@
 ##
 # @NumaOptionsType:
 #
+# @node: NUMA nodes configuration
+#
+# @dist: NUMA distance configuration (since 2.10)
+#
 # Since: 2.1
 ##
 { 'enum': 'NumaOptionsType',
-  'data': [ 'node' ] }
+  'data': [ 'node', 'dist' ] }
 
 ##
 # @NumaOptions:
@@ -5698,7 +5702,8 @@
   'base': { 'type': 'NumaOptionsType' },
   'discriminator': 'type',
   'data': {
-    'node': 'NumaNodeOptions' }}
+    'node': 'NumaNodeOptions',
+    'dist': 'NumaDistOptions' }}
 
 ##
 # @NumaNodeOptions:
@@ -5727,6 +5732,27 @@
    '*memdev': 'str' }}
 
 ##
+# @NumaDistOptions:
+#
+# Set the distance between 2 NUMA nodes.
+#
+# @src: source NUMA node.
+#
+# @dst: destination NUMA node.
+#
+# @val: NUMA distance from source node to destination node.
+#       When a node is unreachable from another node, set the distance
+#       between them to 255.
+#
+# Since: 2.10
+##
+{ 'struct': 'NumaDistOptions',
+  'data': {
+   'src': 'uint16',
+   'dst': 'uint16',
+   'val': 'uint8' }}
+
+##
 # @HostMemPolicy:
 #
 # Host memory policy types
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 00c21f160c..329a0d0c90 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -389,4 +389,5 @@ GCC_FMT_ATTR(2, 3);
 void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
+void build_slit(GArray *table_data, BIOSLinker *linker);
 #endif
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 8f09dcf918..0ea1bc086e 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -8,6 +8,7 @@
 #include "hw/boards.h"
 
 extern int nb_numa_nodes;   /* Number of NUMA nodes */
+extern bool have_numa_distance;
 
 struct numa_addr_range {
     ram_addr_t mem_start;
@@ -21,6 +22,7 @@ typedef struct node_info {
     struct HostMemoryBackend *node_memdev;
     bool present;
     QLIST_HEAD(, numa_addr_range) addr; /* List to store address ranges */
+    uint8_t distance[MAX_NODES];
 } NodeInfo;
 
 extern NodeInfo numa_info[MAX_NODES];
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 15656b7c36..be9e22c955 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -166,6 +166,10 @@ extern int mem_prealloc;
 
 #define MAX_NODES 128
 #define NUMA_NODE_UNASSIGNED MAX_NODES
+#define NUMA_DISTANCE_MIN         10
+#define NUMA_DISTANCE_DEFAULT     20
+#define NUMA_DISTANCE_MAX         254
+#define NUMA_DISTANCE_UNREACHABLE 255
 
 #define MAX_OPTION_ROMS 16
 typedef struct QEMUOptionRom {
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index c6f2032dec..be496c817c 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -24,6 +24,7 @@
 #include "hw/acpi/aml-build.h"
 #include "qemu/bswap.h"
 #include "qemu/bitops.h"
+#include "sysemu/numa.h"
 
 static GArray *build_alloc_array(void)
 {
@@ -1609,3 +1610,28 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
     numamem->base_addr = cpu_to_le64(base);
     numamem->range_length = cpu_to_le64(len);
 }
+
+/*
+ * ACPI spec 5.2.17 System Locality Distance Information Table
+ * (Revision 2.0 or later)
+ */
+void build_slit(GArray *table_data, BIOSLinker *linker)
+{
+    int slit_start, i, j;
+    slit_start = table_data->len;
+
+    acpi_data_push(table_data, sizeof(AcpiTableHeader));
+
+    build_append_int_noprefix(table_data, nb_numa_nodes, 8);
+    for (i = 0; i < nb_numa_nodes; i++) {
+        for (j = 0; j < nb_numa_nodes; j++) {
+            assert(numa_info[i].distance[j]);
+            build_append_int_noprefix(table_data, numa_info[i].distance[j], 1);
+        }
+    }
+
+    build_header(linker, table_data,
+                 (void *)(table_data->data + slit_start),
+                 "SLIT",
+                 table_data->len - slit_start, 1, NULL, NULL);
+}
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1d8c645ed3..c7cc45cc4b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2707,6 +2707,10 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     if (pcms->numa_nodes) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, machine);
+        if (have_numa_distance) {
+            acpi_add_table(table_offsets, tables_blob);
+            build_slit(tables_blob, tables->linker);
+        }
     }
     if (acpi_get_mcfg(&mcfg)) {
         acpi_add_table(table_offsets, tables_blob);
diff --git a/numa.c b/numa.c
index 6fc2393ddd..2b3fc69915 100644
--- a/numa.c
+++ b/numa.c
@@ -51,6 +51,7 @@ static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
                              * For all nodes, nodeid < max_numa_nodeid
                              */
 int nb_numa_nodes;
+bool have_numa_distance;
 NodeInfo numa_info[MAX_NODES];
 
 void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node)
@@ -140,7 +141,7 @@ uint32_t numa_get_node(ram_addr_t addr, Error **errp)
     return -1;
 }
 
-static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
+static void parse_numa_node(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
 {
     uint16_t nodenr;
     uint16List *cpus = NULL;
@@ -212,6 +213,43 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
     max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
 }
 
+static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
+{
+    uint16_t src = dist->src;
+    uint16_t dst = dist->dst;
+    uint8_t val = dist->val;
+
+    if (src >= MAX_NODES || dst >= MAX_NODES) {
+        error_setg(errp,
+                   "Invalid node %" PRIu16
+                   ", max possible could be %" PRIu16,
+                   MAX(src, dst), MAX_NODES);
+        return;
+    }
+
+    if (!numa_info[src].present || !numa_info[dst].present) {
+        error_setg(errp, "Source/Destination NUMA node is missing. "
+                   "Please use '-numa node' option to declare it first.");
+        return;
+    }
+
+    if (val < NUMA_DISTANCE_MIN) {
+        error_setg(errp, "NUMA distance (%" PRIu8 ") is invalid, "
+                   "it shouldn't be less than %d.",
+                   val, NUMA_DISTANCE_MIN);
+        return;
+    }
+
+    if (src == dst && val != NUMA_DISTANCE_MIN) {
+        error_setg(errp, "Local distance of node %d should be %d.",
+                   src, NUMA_DISTANCE_MIN);
+        return;
+    }
+
+    numa_info[src].distance[dst] = val;
+    have_numa_distance = true;
+}
+
 static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
 {
     NumaOptions *object = NULL;
@@ -229,12 +267,18 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
 
     switch (object->type) {
     case NUMA_OPTIONS_TYPE_NODE:
-        numa_node_parse(&object->u.node, opts, &err);
+        parse_numa_node(&object->u.node, opts, &err);
         if (err) {
             goto end;
         }
         nb_numa_nodes++;
         break;
+    case NUMA_OPTIONS_TYPE_DIST:
+        parse_numa_distance(&object->u.dist, &err);
+        if (err) {
+            goto end;
+        }
+        break;
     default:
         abort();
     }
@@ -294,6 +338,75 @@ static void validate_numa_cpus(void)
     g_free(seen_cpus);
 }
 
+/* If all node pair distances are symmetric, then only distances
+ * in one direction are enough. If there is even one asymmetric
+ * pair, though, then all distances must be provided. The
+ * distance from a node to itself is always NUMA_DISTANCE_MIN,
+ * so providing it is never necessary.
+ */
+static void validate_numa_distance(void)
+{
+    int src, dst;
+    bool is_asymmetrical = false;
+
+    for (src = 0; src < nb_numa_nodes; src++) {
+        for (dst = src; dst < nb_numa_nodes; dst++) {
+            if (numa_info[src].distance[dst] == 0 &&
+                numa_info[dst].distance[src] == 0) {
+                if (src != dst) {
+                    error_report("The distance between node %d and %d is "
+                                 "missing, at least one distance value "
+                                 "between each nodes should be provided.",
+                                 src, dst);
+                    exit(EXIT_FAILURE);
+                }
+            }
+
+            if (numa_info[src].distance[dst] != 0 &&
+                numa_info[dst].distance[src] != 0 &&
+                numa_info[src].distance[dst] !=
+                numa_info[dst].distance[src]) {
+                is_asymmetrical = true;
+            }
+        }
+    }
+
+    if (is_asymmetrical) {
+        for (src = 0; src < nb_numa_nodes; src++) {
+            for (dst = 0; dst < nb_numa_nodes; dst++) {
+                if (src != dst && numa_info[src].distance[dst] == 0) {
+                    error_report("At least one asymmetrical pair of "
+                            "distances is given, please provide distances "
+                            "for both directions of all node pairs.");
+                    exit(EXIT_FAILURE);
+                }
+            }
+        }
+    }
+}
+
+static void complete_init_numa_distance(void)
+{
+    int src, dst;
+
+    /* Fixup NUMA distance by symmetric policy because if it is an
+     * asymmetric distance table, it should be a complete table and
+     * there would not be any missing distance except local node, which
+     * is verified by validate_numa_distance above.
+     */
+    for (src = 0; src < nb_numa_nodes; src++) {
+        for (dst = 0; dst < nb_numa_nodes; dst++) {
+            if (numa_info[src].distance[dst] == 0) {
+                if (src == dst) {
+                    numa_info[src].distance[dst] = NUMA_DISTANCE_MIN;
+                } else {
+                    numa_info[src].distance[dst] = numa_info[dst].distance[src];
+                }
+            }
+        }
+    }
+}
+
 void parse_numa_opts(MachineClass *mc)
 {
     int i;
@@ -390,6 +503,26 @@ void parse_numa_opts(MachineClass *mc)
         }
 
         validate_numa_cpus();
+
+        /* QEMU needs at least all unique node pair distances to build
+         * the whole NUMA distance table. QEMU treats the distance table
+         * as symmetric by default, i.e. distance A->B == distance B->A.
+         * Thus, QEMU is able to complete the distance table
+         * initialization even though only distance A->B is provided and
+         * distance B->A is not. QEMU knows the distance of a node to
+         * itself is always 10, so A->A distances may be omitted. When
+         * the distances of two nodes of a pair differ, i.e. distance
+         * A->B != distance B->A, then that means the distance table is
+         * asymmetric. In this case, the distances for both directions
+         * of all node pairs are required.
+         */
+        if (have_numa_distance) {
+            /* Validate enough NUMA distance information was provided. */
+            validate_numa_distance();
+
+            /* Validation succeeded, now fill in any missing distances. */
+            complete_init_numa_distance();
+        }
     } else {
         numa_set_mem_node_id(0, ram_size, 0);
     }
diff --git a/qemu-options.hx b/qemu-options.hx
index 70c0ded12e..e10c1454d1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -139,12 +139,15 @@ ETEXI
 
 DEF("numa", HAS_ARG, QEMU_OPTION_numa,
     "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
-    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n", QEMU_ARCH_ALL)
+    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
+    "-numa dist,src=source,dst=destination,val=distance\n", QEMU_ARCH_ALL)
 STEXI
 @item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
 @itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
+@itemx -numa dist,src=@var{source},dst=@var{destination},val=@var{distance}
 @findex -numa
 Define a NUMA node and assign RAM and VCPUs to it.
+Set the NUMA distance from a source node to a destination node.
 
 @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
 @samp{cpus} option represent a contiguous range of CPU indexes
@@ -167,6 +170,17 @@ split equally between them.
 @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
 if one node uses @samp{memdev}, all of them have to use it.
 
+@var{source} and @var{destination} are NUMA node IDs.
+@var{distance} is the NUMA distance from @var{source} to @var{destination}.
+The distance from a node to itself is always 10. If any pair of nodes is
+given a distance, then all pairs must be given distances. Although, when
+distances are only given in one direction for each pair of nodes, then
+the distances in the opposite directions are assumed to be the same. If,
+however, an asymmetrical pair of distances is given for even one node
+pair, then all node pairs must be provided distance values for both
+directions, even when they are symmetrical. When a node is unreachable
+from another node, set the pair's distance to 255.
+
 Note that the -@option{numa} option doesn't allocate any of the
 specified resources, it just assigns existing resources to NUMA
 nodes. This means that one still has to use the @option{-m},
-- 
2.11.0.259.g40922b1
