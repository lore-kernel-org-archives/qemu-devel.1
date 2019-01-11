Received: from eggs.gnu.org ([209.51.188.92]:38233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1ghyrZ-0000fe-Vc
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1ghyrX-0003ta-Nm
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:36:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:56403)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ghyrX-0003gw-A6
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:36:47 -0500
From: Tao Xu <tao3.xu@intel.com>
Date: Fri, 11 Jan 2019 23:34:49 +0800
Message-Id: <20190111153451.14304-8-tao3.xu@intel.com>
In-Reply-To: <20190111153451.14304-1-tao3.xu@intel.com>
References: <20190111153451.14304-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH v2 7/9] hmat acpi: fix some coding style and
 small issues
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

Per Igor and Eric's comments, fix some small issues of V1 patch:
  - update the version number in qapi/misc.json
  - including the expansion of the acronym HMAT in qapi/misc.json
  - correct spell mistakes in qapi/misc.json and qemu-options.hx
  - fix the comment syle in hw/i386/acpi-build.c
  and hw/acpi/hmat.h
  - remove some unnecessary head files in hw/acpi/hmat.c
  - use hardcoded numbers from spec to generate
  Memory Subsystem Address Range Structure in hw/acpi/hmat.c
  - drop the struct AcpiHmat and AcpiHmatSpaRange
  in hw/acpi/hmat.h

Reviewed-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 hw/acpi/hmat.c       | 39 +++++++++++++++++----------------------
 hw/acpi/hmat.h       | 26 ++++----------------------
 hw/i386/acpi-build.c |  6 ++++--
 qapi/misc.json       | 44 +++++++++++++++++++++++---------------------
 qemu-options.hx      |  2 +-
 5 files changed, 49 insertions(+), 68 deletions(-)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index cf17c0ae4f..e8ba9250e9 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -22,17 +22,12 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
 
-#include "unistd.h"
-#include "fcntl.h"
 #include "qemu/osdep.h"
 #include "sysemu/numa.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/acpi-build.h"
-#include "hw/acpi/acpi.h"
 #include "hw/acpi/hmat.h"
-#include "hw/acpi/aml-build.h"
 #include "hw/nvram/fw_cfg.h"
-#include "hw/acpi/bios-linker-loader.h"
 
 struct numa_hmat_lb_info *hmat_lb_info[HMAT_LB_LEVELS][HMAT_LB_TYPES] = {0};
 struct numa_hmat_cache_info
@@ -42,7 +37,7 @@ static uint32_t initiator_pxm[MAX_NODES], target_pxm[MAX_NODES];
 static uint32_t num_initiator, num_target;
 
 /* Build Memory Subsystem Address Range Structure */
-static void hmat_build_spa_info(GArray *table_data,
+static void build_hmat_spa(GArray *table_data,
                                 uint64_t base, uint64_t length, int node)
 {
     uint16_t flags = 0;
@@ -54,27 +49,27 @@ static void hmat_build_spa_info(GArray *table_data,
         flags |= HMAT_SPA_MEM_VALID;
     }
 
+    /* Memory Subsystem Address Range Structure */
     /* Type */
-    build_append_int_noprefix(table_data, ACPI_HMAT_SPA, sizeof(uint16_t));
-    /* Reserved0 */
-    build_append_int_noprefix(table_data, 0, sizeof(uint16_t));
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
     /* Length */
-    build_append_int_noprefix(table_data, sizeof(AcpiHmatSpaRange),
-                              sizeof(uint32_t));
+    build_append_int_noprefix(table_data, 40, 4);
     /* Flags */
-    build_append_int_noprefix(table_data, flags, sizeof(uint16_t));
-    /* Reserved1 */
-    build_append_int_noprefix(table_data, 0, sizeof(uint16_t));
+    build_append_int_noprefix(table_data, flags, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
     /* Process Proximity Domain */
-    build_append_int_noprefix(table_data, node, sizeof(uint32_t));
+    build_append_int_noprefix(table_data, node, 4);
     /* Memory Proximity Domain */
-    build_append_int_noprefix(table_data, node, sizeof(uint32_t));
-    /* Reserved2 */
-    build_append_int_noprefix(table_data, 0, sizeof(uint32_t));
+    build_append_int_noprefix(table_data, node, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
     /* System Physical Address Range Base */
-    build_append_int_noprefix(table_data, base, sizeof(uint64_t));
+    build_append_int_noprefix(table_data, base, 8);
     /* System Physical Address Range Length */
-    build_append_int_noprefix(table_data, length, sizeof(uint64_t));
+    build_append_int_noprefix(table_data, length, 8);
 }
 
 static int pc_dimm_device_list(Object *obj, void *opaque)
@@ -401,7 +396,7 @@ static void hmat_build_hma_buffer(PCMachineState *pcms)
     g_array_free(hma_buf->hma, true);
 
     hma_buf->hma = g_array_new(false, true /* clear */, 1);
-    acpi_data_push(hma_buf->hma, sizeof(AcpiHmat));
+    acpi_data_push(hma_buf->hma, 40);
 
     /* build HMAT in a given buffer. */
     hmat_build_hma(hma_buf->hma, pcms);
@@ -543,7 +538,7 @@ void hmat_build_acpi(GArray *table_data, BIOSLinker *linker,
     uint64_t hmat_start, hmat_len;
 
     hmat_start = table_data->len;
-    acpi_data_push(table_data, sizeof(AcpiHmat));
+    acpi_data_push(table_data, 40);
 
     hmat_build_hma(table_data, pcms);
     hmat_len = table_data->len - hmat_start;
diff --git a/hw/acpi/hmat.h b/hw/acpi/hmat.h
index dd6948f738..2c080a51b8 100644
--- a/hw/acpi/hmat.h
+++ b/hw/acpi/hmat.h
@@ -78,27 +78,6 @@ enum {
 #define HMAT_LB_LEVELS    (HMAT_LB_MEM_CACHE_3RD_LEVEL + 1)
 #define HMAT_LB_TYPES     (HMAT_LB_DATA_WRITE_BANDWIDTH + 1)
 
-/*
- * HMAT (Heterogeneous Memory Attributes Table)
- */
-struct AcpiHmat {
-    ACPI_TABLE_HEADER_DEF
-    uint32_t    reserved;
-} QEMU_PACKED;
-typedef struct AcpiHmat AcpiHmat;
-
-struct AcpiHmatSpaRange {
-    ACPI_HMAT_SUB_HEADER_DEF
-    uint16_t    flags;
-    uint16_t    reserved1;
-    uint32_t    proc_proximity;
-    uint32_t    mem_proximity;
-    uint32_t    reserved2;
-    uint64_t    spa_base;
-    uint64_t    spa_length;
-} QEMU_PACKED;
-typedef struct AcpiHmatSpaRange AcpiHmatSpaRange;
-
 struct AcpiHmatLBInfo {
     ACPI_HMAT_SUB_HEADER_DEF
     uint8_t     flags;
@@ -166,7 +145,10 @@ struct numa_hmat_cache_info {
     uint32_t    mem_proximity;
     /* Size of memory side cache in bytes. */
     uint64_t    size;
-    /* Total cache levels for this memory proximity domain. */
+    /*
+     * Total cache levels for this memory
+     * pr#include "hw/acpi/aml-build.h"oximity domain.
+     */
     uint8_t     total_levels;
     /* Cache level described in this structure. */
     uint8_t     level;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 569132f3ab..729e67e829 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -120,7 +120,8 @@ typedef struct AcpiBuildPciBusHotplugState {
     bool pcihp_bridge_en;
 } AcpiBuildPciBusHotplugState;
 
-/* The memory contains at least one hole
+/*
+ * The memory contains at least one hole
  * from 640k-1M and possibly another one from 3.5G-4G.
  * So far, the number of memory ranges is up to 2
  * more than the number of numa nodes.
@@ -2267,7 +2268,8 @@ void build_mem_ranges(PCMachineState *pcms)
     uint64_t mem_len, mem_base, next_base;
     int i;
 
-    /* the memory map is a bit tricky, it contains at least one hole
+    /*
+     * the memory map is a bit tricky, it contains at least one hole
      * from 640k-1M and possibly another one from 3.5G-4G.
      */
     mem_ranges_number = 0;
diff --git a/qapi/misc.json b/qapi/misc.json
index 0887a3791a..dc06190168 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2746,9 +2746,9 @@
 #
 # @cpu: property based CPU(s) to node mapping (Since: 2.10)
 #
-# @hmat-lb: memory latency and bandwidth information (Since: 2.13)
+# @hmat-lb: memory latency and bandwidth information (Since: 3.10)
 #
-# @hmat-cache: memory side cache information (Since: 2.13)
+# @hmat-cache: memory side cache information (Since: 3.10)
 #
 # Since: 2.1
 ##
@@ -2837,43 +2837,45 @@
 # @HmatLBMemoryHierarchy:
 #
 # The memory hierarchy in the System Locality Latency
-# and Bandwidth Information Structure of HMAT
+# and Bandwidth Information Structure of HMAT (Heterogeneous
+# Memory Attribute Table)
 #
 # @memory: the structure represents the memory performance
 #
 # @last-level: last level memory of memory side cached memory
 #
-# @1st-level: first level memory of memory side cached memory
+# @first-level: first level memory of memory side cached memory
 #
-# @2nd-level: second level memory of memory side cached memory
+# @second-level: second level memory of memory side cached memory
 #
-# @3rd-level: third level memory of memory side cached memory
+# @third-level: third level memory of memory side cached memory
 #
-# Since: 2.13
+# Since: 3.10
 ##
 { 'enum': 'HmatLBMemoryHierarchy',
-  'data': [ 'memory', 'last-level', '1st-level',
-            '2nd-level', '3rd-level' ] }
+  'data': [ 'memory', 'last-level', 'first-level',
+            'second-level', 'third-level' ] }
 
 ##
 # @HmatLBDataType:
 #
 # Data type in the System Locality Latency
-# and Bandwidth Information Structure of HMAT
+# and Bandwidth Information Structure of HMAT (Heterogeneous
+# Memory Attribute Table)
 #
-# @access-latency: access latency
+# @access-latency: access latency (nanoseconds)
 #
-# @read-latency: read latency
+# @read-latency: read latency (nanoseconds)
 #
-# @write-latency: write latency
+# @write-latency: write latency (nanoseconds)
 #
-# @access-bandwidth: access bandwitch
+# @access-bandwidth: access bandwidth (MB/s)
 #
-# @read-bandwidth: read bandwidth
+# @read-bandwidth: read bandwidth (MB/s)
 #
-# @write-bandwidth: write bandwidth
+# @write-bandwidth: write bandwidth (MB/s)
 #
-# Since: 2.13
+# Since: 3.10
 ##
 { 'enum': 'HmatLBDataType',
   'data': [ 'access-latency', 'read-latency', 'write-latency',
@@ -2905,7 +2907,7 @@
 # @bandwidth: the value of bandwidth based on Base Unit between
 #             @initiator and @target proximity domain.
 #
-# Since: 2.13
+# Since: 3.10
 ##
 { 'struct': 'NumaHmatLBOptions',
   'data': {
@@ -2930,7 +2932,7 @@
 #
 # @complex: Complex Cache Indexing (implementation specific)
 #
-# Since: 2.13
+# Since: 3.10
 ##
 { 'enum': 'HmatCacheAssociativity',
   'data': [ 'none', 'direct', 'complex' ] }
@@ -2947,7 +2949,7 @@
 #
 # @write-through: Write Through (WT)
 #
-# Since: 2.13
+# Since: 3.10
 ##
 { 'enum': 'HmatCacheWritePolicy',
   'data': [ 'none', 'write-back', 'write-through' ] }
@@ -2971,7 +2973,7 @@
 #
 # @line: the cache Line size in bytes.
 #
-# Since: 2.13
+# Since: 3.10
 ##
 { 'struct': 'NumaHmatCacheOptions',
   'data': {
diff --git a/qemu-options.hx b/qemu-options.hx
index 88f078c846..99363b7144 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -246,7 +246,7 @@ For example:
 -numa node,mem=1G,cpus=2,nodeid=1 \
 -numa node,mem=1G,nodeid=2 \
 -numa hmat-lb,initiator=0,target=1,hierarchy=memory,data-type=access-latency,base-lat=10,base-bw=20,latency=10,bandwidth=10 \
--numa hmat-lb,initiator=1,target=2,hierarchy=1st-level,data-type=access-latency,base-bw=10,bandwidth=20
+-numa hmat-lb,initiator=1,target=2,hierarchy=first-level,data-type=access-latency,base-bw=10,bandwidth=20
 @end example
 
 When the processors in NUMA node 0 access memory in NUMA node 1,
-- 
2.17.1
