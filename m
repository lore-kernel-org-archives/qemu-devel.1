Received: from eggs.gnu.org ([2001:4830:134:3::10]:38680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjYK-0006eg-R0
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjYH-0007ol-O4
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFjYH-0007oD-IG
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:03:53 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 May 2018 14:03:11 -0300
Message-Id: <20180507170315.11497-9-ehabkost@redhat.com>
In-Reply-To: <20180507170315.11497-1-ehabkost@redhat.com>
References: <20180507170315.11497-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 08/12] machine: rename MemoryHotplugState to
 DeviceMemoryState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Rename it to better match the new terminology.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180423165126.15441-9-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h     | 8 ++++----
 hw/ppc/spapr_hcall.c    | 6 +++---
 hw/ppc/spapr_rtas_ddw.c | 5 ++---
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index e27c28b514..ef7457f5dd 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -214,15 +214,15 @@ struct MachineClass {
 };
 
 /**
- * MemoryHotplugState:
+ * DeviceMemoryState:
  * @base: address in guest physical address space where the memory
  * address space for memory devices starts
  * @mr: address space container for memory devices
  */
-typedef struct MemoryHotplugState {
+typedef struct DeviceMemoryState {
     hwaddr base;
     MemoryRegion mr;
-} MemoryHotplugState;
+} DeviceMemoryState;
 
 /**
  * MachineState:
@@ -254,7 +254,7 @@ struct MachineState {
     bool enforce_config_section;
     bool enable_graphics;
     char *memory_encryption;
-    MemoryHotplugState *device_memory;
+    DeviceMemoryState *device_memory;
 
     ram_addr_t ram_size;
     ram_addr_t maxram_size;
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 52b8f40955..022f6d8101 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -67,13 +67,13 @@ static inline bool valid_ptex(PowerPCCPU *cpu, target_ulong ptex)
 static bool is_ram_address(sPAPRMachineState *spapr, hwaddr addr)
 {
     MachineState *machine = MACHINE(spapr);
-    MemoryHotplugState *hpms = machine->device_memory;
+    DeviceMemoryState *dms = machine->device_memory;
 
     if (addr < machine->ram_size) {
         return true;
     }
-    if ((addr >= hpms->base)
-        && ((addr - hpms->base) < memory_region_size(&hpms->mr))) {
+    if ((addr >= dms->base)
+        && ((addr - dms->base) < memory_region_size(&dms->mr))) {
         return true;
     }
 
diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
index d3666c1921..329feb148f 100644
--- a/hw/ppc/spapr_rtas_ddw.c
+++ b/hw/ppc/spapr_rtas_ddw.c
@@ -122,9 +122,8 @@ static void rtas_ibm_query_pe_dma_window(PowerPCCPU *cpu,
     if (machine->ram_size == machine->maxram_size) {
         max_window_size = machine->ram_size;
     } else {
-        MemoryHotplugState *hpms = machine->device_memory;
-
-        max_window_size = hpms->base + memory_region_size(&hpms->mr);
+        max_window_size = machine->device_memory->base +
+                          memory_region_size(&machine->device_memory->mr);
     }
 
     avail = SPAPR_PCI_DMA_MAX_WINDOWS - spapr_phb_get_active_win_num(sphb);
-- 
2.14.3
