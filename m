Received: from eggs.gnu.org ([209.51.188.92]:56323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hH10R-0007Gi-Fh
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hH0qT-00060q-02
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:48:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:17093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hH0qS-0005wY-Lk
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:48:28 -0400
From: Tao Xu <tao3.xu@intel.com>
Date: Thu, 18 Apr 2019 14:46:01 +0800
Message-Id: <20190418064602.24558-3-tao3.xu@intel.com>
In-Reply-To: <20190418064602.24558-1-tao3.xu@intel.com>
References: <20190418064602.24558-1-tao3.xu@intel.com>
Subject: [Qemu-devel] [PATCH v2 2/3] numa: move numa global variable
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, qemu-devel@nongnu.org

The aim of this patch is to move existing numa global have_numa_distance
into NumaState.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---
 hw/arm/virt-acpi-build.c | 2 +-
 hw/arm/virt.c            | 1 +
 hw/i386/acpi-build.c     | 2 +-
 include/hw/boards.h      | 3 +++
 include/sysemu/numa.h    | 2 --
 numa.c                   | 5 ++---
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 88722e0746..76316f13fd 100644
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
index c4e8bb2437..5737275775 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -237,6 +237,9 @@ typedef struct NumaState {
     /* Number of NUMA nodes */
     int nb_numa_nodes;
 
+    /* Allow setting NUMA distance for different NUMA nodes */
+    bool have_numa_distance;
+
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
index 4cc4d5ff5c..57aa8abf42 100644
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
@@ -437,7 +436,7 @@ void numa_complete_configuration(MachineState *ms)
          * asymmetric. In this case, the distances for both directions
          * of all node pairs are required.
          */
-        if (have_numa_distance) {
+        if (ms->numa_state->have_numa_distance) {
             /* Validate enough NUMA distance information was provided. */
             validate_numa_distance(ms);
 
-- 
2.17.1
