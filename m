Received: from eggs.gnu.org ([2001:4830:134:3::10]:52017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtGB-0005FW-QN
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtGA-00035X-DP
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:34562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eMtGA-000355-1Y
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:30 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Thu,  7 Dec 2017 18:18:04 +0800
Message-Id: <20171207101812.23602-3-haozhong.zhang@intel.com>
In-Reply-To: <20171207101812.23602-1-haozhong.zhang@intel.com>
References: <20171207101812.23602-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v4 02/10] xen-hvm: create the hotplug
 memory region on Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

The guest physical address of vNVDIMM is allocated from the hotplug
memory region, which is not created when QEMU is used as Xen device
model. In order to use vNVDIMM for Xen HVM domains, this commit reuses
the code for pc machine type to create the hotplug memory region for
Xen HVM domains.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
---
 hw/i386/pc.c          | 86 ++++++++++++++++++++++++++++-----------------------
 hw/i386/xen/xen-hvm.c |  2 ++
 include/hw/i386/pc.h  |  1 +
 3 files changed, 51 insertions(+), 38 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 186545d2a4..9f46c8df79 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1315,6 +1315,53 @@ void xen_load_linux(PCMachineState *pcms)
     pcms->fw_cfg = fw_cfg;
 }
 
+void pc_memory_hotplug_init(PCMachineState *pcms, MemoryRegion *system_memory)
+{
+    MachineState *machine = MACHINE(pcms);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    ram_addr_t hotplug_mem_size = machine->maxram_size - machine->ram_size;
+
+    if (!pcmc->has_reserved_memory || machine->ram_size >= machine->maxram_size)
+        return;
+
+    if (memory_region_size(&pcms->hotplug_memory.mr)) {
+        error_report("hotplug memory region has been initialized");
+        exit(EXIT_FAILURE);
+    }
+
+    if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
+        error_report("unsupported amount of memory slots: %"PRIu64,
+                     machine->ram_slots);
+        exit(EXIT_FAILURE);
+    }
+
+    if (QEMU_ALIGN_UP(machine->maxram_size,
+                      TARGET_PAGE_SIZE) != machine->maxram_size) {
+        error_report("maximum memory size must by aligned to multiple of "
+                     "%d bytes", TARGET_PAGE_SIZE);
+        exit(EXIT_FAILURE);
+    }
+
+    pcms->hotplug_memory.base =
+        ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1ULL << 30);
+
+    if (pcmc->enforce_aligned_dimm) {
+        /* size hotplug region assuming 1G page max alignment per slot */
+        hotplug_mem_size += (1ULL << 30) * machine->ram_slots;
+    }
+
+    if ((pcms->hotplug_memory.base + hotplug_mem_size) < hotplug_mem_size) {
+        error_report("unsupported amount of maximum memory: " RAM_ADDR_FMT,
+                     machine->maxram_size);
+        exit(EXIT_FAILURE);
+    }
+
+    memory_region_init(&pcms->hotplug_memory.mr, OBJECT(pcms),
+                       "hotplug-memory", hotplug_mem_size);
+    memory_region_add_subregion(system_memory, pcms->hotplug_memory.base,
+                                &pcms->hotplug_memory.mr);
+}
+
 void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion *system_memory,
                     MemoryRegion *rom_memory,
@@ -1366,44 +1413,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     /* initialize hotplug memory address space */
-    if (pcmc->has_reserved_memory &&
-        (machine->ram_size < machine->maxram_size)) {
-        ram_addr_t hotplug_mem_size =
-            machine->maxram_size - machine->ram_size;
-
-        if (machine->ram_slots > ACPI_MAX_RAM_SLOTS) {
-            error_report("unsupported amount of memory slots: %"PRIu64,
-                         machine->ram_slots);
-            exit(EXIT_FAILURE);
-        }
-
-        if (QEMU_ALIGN_UP(machine->maxram_size,
-                          TARGET_PAGE_SIZE) != machine->maxram_size) {
-            error_report("maximum memory size must by aligned to multiple of "
-                         "%d bytes", TARGET_PAGE_SIZE);
-            exit(EXIT_FAILURE);
-        }
-
-        pcms->hotplug_memory.base =
-            ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1ULL << 30);
-
-        if (pcmc->enforce_aligned_dimm) {
-            /* size hotplug region assuming 1G page max alignment per slot */
-            hotplug_mem_size += (1ULL << 30) * machine->ram_slots;
-        }
-
-        if ((pcms->hotplug_memory.base + hotplug_mem_size) <
-            hotplug_mem_size) {
-            error_report("unsupported amount of maximum memory: " RAM_ADDR_FMT,
-                         machine->maxram_size);
-            exit(EXIT_FAILURE);
-        }
-
-        memory_region_init(&pcms->hotplug_memory.mr, OBJECT(pcms),
-                           "hotplug-memory", hotplug_mem_size);
-        memory_region_add_subregion(system_memory, pcms->hotplug_memory.base,
-                                    &pcms->hotplug_memory.mr);
-    }
+    pc_memory_hotplug_init(pcms, system_memory);
 
     /* Initialize PC system firmware */
     pc_system_firmware_init(rom_memory, !pcmc->pci_enabled);
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 02d92fd268..fe01b7a025 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -235,6 +235,8 @@ static void xen_ram_init(PCMachineState *pcms,
                                  pcms->above_4g_mem_size);
         memory_region_add_subregion(sysmem, 0x100000000ULL, &ram_hi);
     }
+
+    pc_memory_hotplug_init(pcms, sysmem);
 }
 
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ef438bd765..86e375b616 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -249,6 +249,7 @@ void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion *rom_memory,
                     MemoryRegion **ram_memory);
 uint64_t pc_pci_hole64_start(void);
+void pc_memory_hotplug_init(PCMachineState *pcms, MemoryRegion *system_memory);
 qemu_irq pc_allocate_cpu_irq(void);
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
 void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
-- 
2.15.1
