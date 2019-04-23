Received: from eggs.gnu.org ([209.51.188.92]:34121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hIq8V-0001iY-7E
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hIq8U-0002qP-0x
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:46:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:31627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hIq8T-0002p2-NX
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:46:37 -0400
From: Tao Xu <tao3.xu@intel.com>
Date: Tue, 23 Apr 2019 15:44:27 +0800
Message-Id: <20190423074428.23031-3-tao3.xu@intel.com>
In-Reply-To: <20190423074428.23031-1-tao3.xu@intel.com>
References: <20190423074428.23031-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH v3 2/3] numa: move numa global variable
 have_numa_distance into MachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com
Cc: tao3.xu@intel.com, jingqi.liu@intel.com, qemu-devel@nongnu.org

The aim of this patch is to move existing numa global have_numa_distance
into NumaState.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 hw/arm/virt-acpi-build.c | 2 +-
 hw/arm/virt.c            | 2 +-
 hw/i386/acpi-build.c     | 2 +-
 include/hw/boards.h      | 2 ++
 include/sysemu/numa.h    | 2 --
 numa.c                   | 5 ++---
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6805b4de51..65f070843c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -815,7 +815,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     if (nb_numa_nodes > 0) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, vms);
-        if (have_numa_distance) {
+        if (ms->numa_state->have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
             build_slit(tables_blob, tables->linker, ms);
         }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 280174b1b7..6cd5e13eb9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -228,7 +228,7 @@ static void create_fdt(VirtMachineState *vms)
                                 "clk24mhz");
     qemu_fdt_setprop_cell(fdt, "/apb-pclk", "phandle", vms->clock_phandle);
 
-    if (have_numa_distance) {
+    if (nb_numa_nodes > 0 && ms->numa_state->have_numa_distance) {
         int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
         uint32_t *matrix = g_malloc0(size);
         int idx, i, j;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7d9bc88ac9..43a807c483 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2685,7 +2685,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     if (pcms->numa_nodes) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, machine);
-        if (have_numa_distance) {
+        if (machine->numa_state->have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
             build_slit(tables_blob, tables->linker, machine);
         }
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 579d73f6c4..c3ff2dbd4a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -238,6 +238,8 @@ typedef struct NumaState {
     /* Number of NUMA nodes */
     int num_nodes;
 
+    /* Allow setting NUMA distance for different NUMA nodes */
+    bool have_numa_distance;
 } NumaState;
 
 /**
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index a55e2be563..1a29408db9 100644
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
index 343fcaf13f..d4f5ff5193 100644
--- a/numa.c
+++ b/numa.c
@@ -52,7 +52,6 @@ static int have_memdevs = -1;
 static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
                              * For all nodes, nodeid < max_numa_nodeid
                              */
-bool have_numa_distance;
 NodeInfo numa_info[MAX_NODES];
 
 
@@ -171,7 +170,7 @@ void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error **errp)
     }
 
     numa_info[src].distance[dst] = val;
-    have_numa_distance = true;
+    ms->numa_state->have_numa_distance = true;
 }
 
 static
@@ -442,7 +441,7 @@ void numa_complete_configuration(MachineState *ms)
          * asymmetric. In this case, the distances for both directions
          * of all node pairs are required.
          */
-        if (have_numa_distance) {
+        if (ms->numa_state->have_numa_distance) {
             /* Validate enough NUMA distance information was provided. */
             validate_numa_distance(ms);
 
-- 
2.17.1
