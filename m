Received: from eggs.gnu.org ([2001:4830:134:3::10]:41909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQC-0000Bq-BR
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cQB-00068a-4r
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:48 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:34 -0300
Message-Id: <20171006235023.11952-40-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 39/88] hw/i386: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: renamed PC -> hw/i386, split of target/i386/cpu.c, added more changes]
---
 hw/i386/acpi-build.c  | 4 ++--
 hw/i386/amd_iommu.c   | 4 ++--
 hw/i386/intel_iommu.c | 2 +-
 hw/i386/pc.c          | 8 ++++----
 hw/i386/pc_sysfw.c    | 6 +++---
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2af37a9129..1aff7b4d2f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -777,7 +777,7 @@ static void crs_range_insert(GPtrArray *ranges, uint64_t base, uint64_t limit)
 {
     CrsRangeEntry *entry;
 
-    entry = g_malloc(sizeof(*entry));
+    entry = g_new(CrsRangeEntry, 1);
     entry->base = base;
     entry->limit = limit;
 
@@ -2877,7 +2877,7 @@ void acpi_setup(void)
         return;
     }
 
-    build_state = g_malloc0(sizeof *build_state);
+    build_state = g_new0(AcpiBuildState, 1);
 
     acpi_build_tables_init(&tables);
     acpi_build(&tables, MACHINE(pcms));
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 334938a280..f871025376 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1033,13 +1033,13 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
     /* allocate memory during the first run */
     if (!iommu_as) {
-        iommu_as = g_malloc0(sizeof(AMDVIAddressSpace *) * PCI_DEVFN_MAX);
+        iommu_as = g_new0(AMDVIAddressSpace *, PCI_DEVFN_MAX);
         s->address_spaces[bus_num] = iommu_as;
     }
 
     /* set up AMD-Vi region */
     if (!iommu_as[devfn]) {
-        iommu_as[devfn] = g_malloc0(sizeof(AMDVIAddressSpace));
+        iommu_as[devfn] = g_new0(AMDVIAddressSpace, 1);
         iommu_as[devfn]->bus_num = (uint8_t)bus_num;
         iommu_as[devfn]->devfn = (uint8_t)devfn;
         iommu_as[devfn]->iommu_state = s;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3a5bb0bc2e..62c94008ad 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2708,7 +2708,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus, int devfn)
 
     if (!vtd_dev_as) {
         snprintf(name, sizeof(name), "intel_iommu_devfn_%d", devfn);
-        vtd_bus->dev_as[devfn] = vtd_dev_as = g_malloc0(sizeof(VTDAddressSpace));
+        vtd_bus->dev_as[devfn] = vtd_dev_as = g_new0(VTDAddressSpace, 1);
 
         vtd_dev_as->bus = bus;
         vtd_dev_as->devfn = (uint8_t)devfn;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 05985d4927..393aefdc4c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1175,7 +1175,7 @@ static void pc_build_feature_control_file(PCMachineState *pcms)
         return;
     }
 
-    val = g_malloc(sizeof(*val));
+    val = g_new(uint64_t, 1);
     *val = cpu_to_le64(feature_control_bits | FEATURE_CONTROL_LOCKED);
     fw_cfg_add_file(pcms->fw_cfg, "etc/msr_feature_control", val, sizeof(*val));
 }
@@ -1336,11 +1336,11 @@ void pc_memory_init(PCMachineState *pcms,
      * aliases to address portions of it, mostly for backwards compatibility
      * with older qemus that used qemu_ram_alloc().
      */
-    ram = g_malloc(sizeof(*ram));
+    ram = g_new(MemoryRegion, 1);
     memory_region_allocate_system_memory(ram, NULL, "pc.ram",
                                          machine->ram_size);
     *ram_memory = ram;
-    ram_below_4g = g_malloc(sizeof(*ram_below_4g));
+    ram_below_4g = g_new(MemoryRegion, 1);
     memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
                              0, pcms->below_4g_mem_size);
     memory_region_add_subregion(system_memory, 0, ram_below_4g);
@@ -1408,7 +1408,7 @@ void pc_memory_init(PCMachineState *pcms,
     /* Initialize PC system firmware */
     pc_system_firmware_init(rom_memory, !pcmc->pci_enabled);
 
-    option_rom_mr = g_malloc(sizeof(*option_rom_mr));
+    option_rom_mr = g_new(MemoryRegion, 1);
     memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
                            &error_fatal);
     if (pcmc->pci_enabled) {
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 6b183747fc..d80cb17d70 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -56,7 +56,7 @@ static void pc_isa_bios_init(MemoryRegion *rom_memory,
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = MIN(flash_size, 128 * 1024);
-    isa_bios = g_malloc(sizeof(*isa_bios));
+    isa_bios = g_new(MemoryRegion, 1);
     memory_region_init_ram(isa_bios, NULL, "isa-bios", isa_bios_size,
                            &error_fatal);
     memory_region_add_subregion_overlap(rom_memory,
@@ -193,7 +193,7 @@ static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
         (bios_size % 65536) != 0) {
         goto bios_error;
     }
-    bios = g_malloc(sizeof(*bios));
+    bios = g_new(MemoryRegion, 1);
     memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
     if (!isapc_ram_fw) {
         memory_region_set_readonly(bios, true);
@@ -211,7 +211,7 @@ static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
     if (isa_bios_size > (128 * 1024)) {
         isa_bios_size = 128 * 1024;
     }
-    isa_bios = g_malloc(sizeof(*isa_bios));
+    isa_bios = g_new(MemoryRegion, 1);
     memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
                              bios_size - isa_bios_size, isa_bios_size);
     memory_region_add_subregion_overlap(rom_memory,
-- 
2.14.2
