Received: from eggs.gnu.org ([209.51.188.92]:56960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hBtB4-0000xi-Tr
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hBtB3-0000Ak-KD
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:36:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:25556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hBtB3-00006n-87
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 23:36:33 -0400
From: Tao Xu <tao3.xu@intel.com>
Date: Thu,  4 Apr 2019 11:34:28 +0800
Message-Id: <20190404033429.17232-3-tao3.xu@intel.com>
In-Reply-To: <20190404033429.17232-1-tao3.xu@intel.com>
References: <20190404033429.17232-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH 2/3] numa: move numa global variable
 have_numa_distance into MachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: imammedo@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, jingqi.liu@intel.com, tao3.xu@intel.com

The aim of this patch is to move existing numa global have_numa_distance
into NumaState.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 hw/arm/virt-acpi-build.c | 1 +
 hw/arm/virt.c            | 1 +
 hw/i386/acpi-build.c     | 2 +-
 include/hw/boards.h      | 3 +++
 include/sysemu/numa.h    | 2 --
 numa.c                   | 7 +++++--
 6 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f9b72333a9..2a6dab6706 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -784,6 +784,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     GArray *tables_blob = tables->table_data;
     MachineState *ms = MACHINE(vms);
     int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
+    bool have_numa_distance = ms->numa_state->have_numa_distance;
 
     table_offsets = g_array_new(false, true /* clear */,
                                         sizeof(uint32_t));
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 430189af1a..8a07f0442f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -197,6 +197,7 @@ static void create_fdt(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
     int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
+    bool have_numa_distance = ms->numa_state->have_numa_distance;
     void *fdt = create_device_tree(&vms->fdt_size);
 
     if (!fdt) {
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 416da318ae..d092eafd19 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2685,7 +2685,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     if (pcms->numa_nodes) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, machine);
-        if (have_numa_distance) {
+        if (machine->numa_state->have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
             build_slit(tables_blob, tables->linker);
         }
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 2d4536b1a0..cd7fe0f933 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -235,6 +235,9 @@ typedef struct DeviceMemoryState {
 typedef struct NumaState {
     /* Number of NUMA nodes */
     int nb_numa_nodes;
+
+    /* Allow setting NUMA distance for different NUMA nodes */
+    bool have_numa_distance;
 } NumaState;
 
 /**
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 6c753f9ccf..0d3920767a 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -6,8 +6,6 @@
 #include "sysemu/hostmem.h"
 #include "hw/boards.h"
 
-extern bool have_numa_distance;
-
 struct NodeInfo {
     uint64_t node_mem;
     struct HostMemoryBackend *node_memdev;
diff --git a/numa.c b/numa.c
index ff40f6f04f..a6d9951145 100644
--- a/numa.c
+++ b/numa.c
@@ -52,7 +52,7 @@ static int have_memdevs = -1;
 static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
                              * For all nodes, nodeid < max_numa_nodeid
                              */
-bool have_numa_distance;
+
 NodeInfo numa_info[MAX_NODES];
 
 
@@ -143,6 +143,8 @@ static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
     uint16_t src = dist->src;
     uint16_t dst = dist->dst;
     uint8_t val = dist->val;
+    MachineState *ms = MACHINE(qdev_get_machine());
+
 
     if (src >= MAX_NODES || dst >= MAX_NODES) {
         error_setg(errp, "Parameter '%s' expects an integer between 0 and %d",
@@ -170,7 +172,7 @@ static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
     }
 
     numa_info[src].distance[dst] = val;
-    have_numa_distance = true;
+    ms->numa_state->have_numa_distance = true;
 }
 
 static
@@ -359,6 +361,7 @@ void numa_complete_configuration(MachineState *ms)
     int i;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     int nb_numa_nodes = ms->numa_state->nb_numa_nodes;
+    bool have_numa_distance = ms->numa_state->have_numa_distance;
 
     /*
      * If memory hotplug is enabled (slots > 0) but without '-numa'
-- 
2.17.1
