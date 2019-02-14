Received: from eggs.gnu.org ([209.51.188.92]:38705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1guHfy-0000Ho-Cz
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1guHfr-0004OJ-BS
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:07:42 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 14 Feb 2019 09:07:14 -0500
Message-Id: <20190214140714.15738-1-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC] memory: use memory_region_init_ram() instead of
 memory_region_allocate_system_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jan.kiszka@web.de, peter.maydell@linaro.org, atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, qemu-arm@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com

I'm considering to deprecating -mem-path/prealloc CLI options and replacing
them with a single memdev Machine property to allow interested users to pick
used backend for initial RAM (fixes mixed -mem-path+hostmem backends issues)
and as a transition step to modeling initial as a Device instead of (ab)using
MemoryRegion APIs.

Currently most boards use memory_region_allocate_system_memory() to allocate
RAM and the interface tied up too much to MemoryRegion that makes changing API
to hostmem across tree is quite a bit of work sometimes requiring logic rewrite
to do it cleanly and I'm not sure it's worth the effort and that it really has
a merit to do in case of TCG only boards.

I suggest to get rid memory_region_allocate_system_memory() on TCG only boards
since most of them don't really need NUMA features provided by this API and/or
probably won't noticeably benefit from -mem-path/prealloc backed memory if at all
and replacing memory allocation with plain memory_region_init_ram() API.

It won't require extensive changes in TCG only boards we have now, since they would
continue to use MemoryRegion based API approach. And the boards, that really need
to use hugepages or numa features, could be amended to use new machine memdev
property and/or initial RAM being allocated by implictly (-m) using hostmem-ram backend.

Also some boards (ab)use memory_region_allocate_system_memory(), calling it several
times to allocate various fixed sized chunks of RAM and ROMs, which is problematic
to map to a single initial RAM Machine::memdev backend and is currently broken if
-mem-path points to a not hugepage pool.

This RFC attempts to cleanup things a bit on TCG only boards (only several ones)
side and test waters if it's acceptable approach.  If it looks acceptable, I'll send
a proper series to make usage of memory_region_allocate_system_memory() minimal across
the codebase and then convert boards that actually use numa/hugepages to initial RAM
memdev model (arm/virt, spapr, s390x, pc/q35).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/musicpal.c    |  4 ++--
 hw/arm/vexpress.c    |  4 ++--
 hw/sparc64/niagara.c | 30 +++++++++++++++---------------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index d22532a11c..197e7d1282 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1592,8 +1592,8 @@ static void musicpal_init(MachineState *machine)
     cpu = ARM_CPU(cpu_create(machine->cpu_type));
 
     /* For now we use a fixed - the original - RAM size */
-    memory_region_allocate_system_memory(ram, NULL, "musicpal.ram",
-                                         MP_RAM_DEFAULT_SIZE);
+    memory_region_init_ram(ram, NULL, "musicpal.ram", MP_RAM_DEFAULT_SIZE,
+                           &error_fatal);
     memory_region_add_subregion(address_space_mem, 0, ram);
 
     memory_region_init_ram(sram, NULL, "musicpal.sram", MP_SRAM_SIZE,
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index c02d18ee61..a2cf5c0af2 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -280,8 +280,8 @@ static void a9_daughterboard_init(const VexpressMachineState *vms,
         exit(1);
     }
 
-    memory_region_allocate_system_memory(ram, NULL, "vexpress.highmem",
-                                         ram_size);
+    memory_region_init_ram(ram, NULL, "vexpress.highmem", ram_size,
+                           &error_fatal);
     low_ram_size = ram_size;
     if (low_ram_size > 0x4000000) {
         low_ram_size = 0x4000000;
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index f8a856f611..62e0348d5f 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -37,6 +37,7 @@
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
+#include "qapi/error.h"
 
 
 typedef struct NiagaraBoardState {
@@ -108,27 +109,26 @@ static void niagara_init(MachineState *machine)
     /* init CPUs */
     sparc64_cpu_devinit(machine->cpu_type, NIAGARA_PROM_BASE);
     /* set up devices */
-    memory_region_allocate_system_memory(&s->hv_ram, NULL, "sun4v-hv.ram",
-                                         NIAGARA_HV_RAM_SIZE);
+    memory_region_init_ram(&s->hv_ram, NULL, "sun4v-hv.ram",
+                                         NIAGARA_HV_RAM_SIZE, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_HV_RAM_BASE, &s->hv_ram);
 
-    memory_region_allocate_system_memory(&s->partition_ram, NULL,
-                                         "sun4v-partition.ram",
-                                         machine->ram_size);
+    memory_region_init_ram(&s->partition_ram, NULL, "sun4v-partition.ram",
+                                         machine->ram_size, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_PARTITION_RAM_BASE,
                                 &s->partition_ram);
 
-    memory_region_allocate_system_memory(&s->nvram, NULL,
-                                         "sun4v.nvram", NIAGARA_NVRAM_SIZE);
+    memory_region_init_ram(&s->nvram, NULL, "sun4v.nvram", NIAGARA_NVRAM_SIZE,
+                           &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_NVRAM_BASE, &s->nvram);
-    memory_region_allocate_system_memory(&s->md_rom, NULL,
-                                         "sun4v-md.rom", NIAGARA_MD_ROM_SIZE);
+    memory_region_init_ram(&s->md_rom, NULL, "sun4v-md.rom",
+                           NIAGARA_MD_ROM_SIZE, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_MD_ROM_BASE, &s->md_rom);
-    memory_region_allocate_system_memory(&s->hv_rom, NULL,
-                                         "sun4v-hv.rom", NIAGARA_HV_ROM_SIZE);
+    memory_region_init_ram(&s->hv_rom, NULL, "sun4v-hv.rom",
+                           NIAGARA_HV_ROM_SIZE, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_HV_ROM_BASE, &s->hv_rom);
-    memory_region_allocate_system_memory(&s->prom, NULL,
-                                         "sun4v.prom", PROM_SIZE_MAX);
+    memory_region_init_ram(&s->prom, NULL, "sun4v.prom",
+                                         PROM_SIZE_MAX, &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_PROM_BASE, &s->prom);
 
     add_rom_or_fail("nvram1", NIAGARA_NVRAM_BASE);
@@ -145,8 +145,8 @@ static void niagara_init(MachineState *machine)
         BlockBackend *blk = blk_by_legacy_dinfo(dinfo);
         int size = blk_getlength(blk);
         if (size > 0) {
-            memory_region_allocate_system_memory(&s->vdisk_ram, NULL,
-                                                 "sun4v_vdisk.ram", size);
+            memory_region_init_ram(&s->vdisk_ram, NULL, "sun4v_vdisk.ram", size,
+                                   &error_fatal);
             memory_region_add_subregion(get_system_memory(),
                                         NIAGARA_VDISK_BASE, &s->vdisk_ram);
             dinfo->is_default = 1;
-- 
2.18.1
