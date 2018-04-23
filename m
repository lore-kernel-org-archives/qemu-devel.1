Received: from eggs.gnu.org ([2001:4830:134:3::10]:49835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAehI-0007nw-KD
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAehH-0008T1-NL
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 12:52:12 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 23 Apr 2018 18:51:23 +0200
Message-Id: <20180423165126.15441-9-david@redhat.com>
In-Reply-To: <20180423165126.15441-1-david@redhat.com>
References: <20180423165126.15441-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 08/11] machine: rename MemoryHotplugState to
 DeviceMemoryState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Rename it to better match the new terminology.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/ppc/spapr_hcall.c    | 6 +++---
 hw/ppc/spapr_rtas_ddw.c | 5 ++---
 include/hw/boards.h     | 8 ++++----
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index e99686389d..3b3d927c98 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -64,13 +64,13 @@ static inline bool valid_ptex(PowerPCCPU *cpu, target_ulong ptex)
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
diff --git a/include/hw/boards.h b/include/hw/boards.h
index ffc1ee782f..8748964e6f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -215,15 +215,15 @@ struct MachineClass {
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
@@ -255,7 +255,7 @@ struct MachineState {
     bool enforce_config_section;
     bool enable_graphics;
     char *memory_encryption;
-    MemoryHotplugState *device_memory;
+    DeviceMemoryState *device_memory;
 
     ram_addr_t ram_size;
     ram_addr_t maxram_size;
-- 
2.14.3
