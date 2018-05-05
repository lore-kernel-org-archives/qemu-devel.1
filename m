Received: from eggs.gnu.org ([2001:4830:134:3::10]:54640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6ke-0004eA-9e
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fF6kb-0004Bs-RF
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:38:04 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:37614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fF6kb-0004BY-Ib
	for qemu-devel@nongnu.org; Sat, 05 May 2018 19:38:01 -0400
Received: by mail-pf0-x242.google.com with SMTP id e9so16093526pfi.4
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 16:38:01 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sun,  6 May 2018 11:35:25 +1200
Message-Id: <1525563325-62963-21-git-send-email-mjc@sifive.com>
In-Reply-To: <1525563325-62963-1-git-send-email-mjc@sifive.com>
References: <1525563325-62963-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PULL 20/20] RISC-V: Mark ROM read-only after copying
 in code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

The sifive_u machine already marks its ROM readonly however
it has the wrong base address for its mask ROM. This patch
fixes the sifive_u mask ROM base address.

This commit makes all other boards consistently use mask_rom
as the variable name for their ROMs. Boards that use device
tree now check that that the device tree fits in the assigned
ROM space using the new qemu_fdt_totalsize(void *fdt)
interface, adding a bounds check and error message. This
can detect truncation.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <Alistair.Francis@wdc.com>
---
 hw/riscv/sifive_e.c | 20 +++++++---------
 hw/riscv/sifive_u.c | 51 +++++++++++++++++++++------------------
 hw/riscv/spike.c    | 69 +++++++++++++++++++++++++++++++----------------------
 hw/riscv/virt.c     | 43 ++++++++++++++++++---------------
 4 files changed, 101 insertions(+), 82 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 6fa223818502..e4ecb7aa4bb6 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -74,14 +74,6 @@ static const struct MemmapEntry {
     [SIFIVE_E_DTIM] =     { 0x80000000,     0x4000 }
 };
 
-static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t len)
-{
-    int i;
-    for (i = 0; i < (len >> 2); i++) {
-        stl_phys(&address_space_memory, pa + (i << 2), rom[i]);
-    }
-}
-
 static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
@@ -112,6 +104,7 @@ static void riscv_sifive_e_init(MachineState *machine)
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     MemoryRegion *xip_mem = g_new(MemoryRegion, 1);
+    int i;
 
     /* Initialize SOC */
     object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
@@ -131,7 +124,7 @@ static void riscv_sifive_e_init(MachineState *machine)
         memmap[SIFIVE_E_DTIM].base, main_mem);
 
     /* Mask ROM */
-    memory_region_init_ram(mask_rom, NULL, "riscv.sifive.e.mrom",
+    memory_region_init_rom(mask_rom, NULL, "riscv.sifive.e.mrom",
         memmap[SIFIVE_E_MROM].size, &error_fatal);
     memory_region_add_subregion(sys_mem,
         memmap[SIFIVE_E_MROM].base, mask_rom);
@@ -185,9 +178,12 @@ static void riscv_sifive_e_init(MachineState *machine)
         0x00028067,        /* 0x1004: jr      t0 */
     };
 
-    /* copy in the reset vector */
-    copy_le32_to_phys(memmap[SIFIVE_E_MROM].base, reset_vec, sizeof(reset_vec));
-    memory_region_set_readonly(mask_rom, true);
+    /* copy in the reset vector in little_endian byte order */
+    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
+        reset_vec[i] = cpu_to_le32(reset_vec[i]);
+    }
+    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
+                          memmap[SIFIVE_E_MROM].base, &address_space_memory);
 
     if (machine->kernel_filename) {
         load_kernel(machine->kernel_filename);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 84afed4c3b0e..c05dcbba955e 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -47,12 +47,14 @@
 #include "exec/address-spaces.h"
 #include "elf.h"
 
+#include <libfdt.h>
+
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } sifive_u_memmap[] = {
     [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
-    [SIFIVE_U_MROM] =     {     0x1000,     0x2000 },
+    [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
     [SIFIVE_U_UART0] =    { 0x10013000,     0x1000 },
@@ -60,14 +62,6 @@ static const struct MemmapEntry {
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
 };
 
-static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t len)
-{
-    int i;
-    for (i = 0; i < (len >> 2); i++) {
-        stl_phys(&address_space_memory, pa + (i << 2), rom[i]);
-    }
-}
-
 static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
@@ -221,9 +215,10 @@ static void riscv_sifive_u_init(MachineState *machine)
     const struct MemmapEntry *memmap = sifive_u_memmap;
 
     SiFiveUState *s = g_new0(SiFiveUState, 1);
-    MemoryRegion *sys_memory = get_system_memory();
+    MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
+    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
+    int i;
 
     /* Initialize SOC */
     object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
@@ -239,17 +234,17 @@ static void riscv_sifive_u_init(MachineState *machine)
     /* register RAM */
     memory_region_init_ram(main_mem, NULL, "riscv.sifive.u.ram",
                            machine->ram_size, &error_fatal);
-    memory_region_add_subregion(sys_memory, memmap[SIFIVE_U_DRAM].base,
+    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DRAM].base,
         main_mem);
 
     /* create device tree */
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     /* boot rom */
-    memory_region_init_ram(boot_rom, NULL, "riscv.sifive.u.mrom",
-                           memmap[SIFIVE_U_MROM].base, &error_fatal);
-    memory_region_set_readonly(boot_rom, true);
-    memory_region_add_subregion(sys_memory, 0x0, boot_rom);
+    memory_region_init_rom(mask_rom, NULL, "riscv.sifive.u.mrom",
+                           memmap[SIFIVE_U_MROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
+                                mask_rom);
 
     if (machine->kernel_filename) {
         load_kernel(machine->kernel_filename);
@@ -272,13 +267,23 @@ static void riscv_sifive_u_init(MachineState *machine)
                                        /* dtb: */
     };
 
-    /* copy in the reset vector */
-    copy_le32_to_phys(memmap[SIFIVE_U_MROM].base, reset_vec, sizeof(reset_vec));
+    /* copy in the reset vector in little_endian byte order */
+    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
+        reset_vec[i] = cpu_to_le32(reset_vec[i]);
+    }
+    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
+                          memmap[SIFIVE_U_MROM].base, &address_space_memory);
 
     /* copy in the device tree */
-    qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
-    cpu_physical_memory_write(memmap[SIFIVE_U_MROM].base +
-        sizeof(reset_vec), s->fdt, s->fdt_size);
+    if (fdt_pack(s->fdt) || fdt_totalsize(s->fdt) >
+            memmap[SIFIVE_U_MROM].size - sizeof(reset_vec)) {
+        error_report("not enough space to store device-tree");
+        exit(1);
+    }
+    qemu_fdt_dumpdtb(s->fdt, fdt_totalsize(s->fdt));
+    rom_add_blob_fixed_as("mrom.fdt", s->fdt, fdt_totalsize(s->fdt),
+                          memmap[SIFIVE_U_MROM].base + sizeof(reset_vec),
+                          &address_space_memory);
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
@@ -292,9 +297,9 @@ static void riscv_sifive_u_init(MachineState *machine)
         SIFIVE_U_PLIC_CONTEXT_BASE,
         SIFIVE_U_PLIC_CONTEXT_STRIDE,
         memmap[SIFIVE_U_PLIC].size);
-    sifive_uart_create(sys_memory, memmap[SIFIVE_U_UART0].base,
+    sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
         serial_hd(0), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART0_IRQ]);
-    /* sifive_uart_create(sys_memory, memmap[SIFIVE_U_UART1].base,
+    /* sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
         serial_hd(1), SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART1_IRQ]); */
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
         memmap[SIFIVE_U_CLINT].size, smp_cpus,
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 9e18c618bfbb..f94e2b670799 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -42,23 +42,17 @@
 #include "exec/address-spaces.h"
 #include "elf.h"
 
+#include <libfdt.h>
+
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } spike_memmap[] = {
-    [SPIKE_MROM] =     {     0x1000,     0x2000 },
+    [SPIKE_MROM] =     {     0x1000,    0x11000 },
     [SPIKE_CLINT] =    {  0x2000000,    0x10000 },
     [SPIKE_DRAM] =     { 0x80000000,        0x0 },
 };
 
-static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t len)
-{
-    int i;
-    for (i = 0; i < (len >> 2); i++) {
-        stl_phys(&address_space_memory, pa + (i << 2), rom[i]);
-    }
-}
-
 static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
@@ -173,7 +167,8 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     SpikeState *s = g_new0(SpikeState, 1);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
+    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
+    int i;
 
     /* Initialize SOC */
     object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
@@ -196,9 +191,10 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     /* boot rom */
-    memory_region_init_ram(boot_rom, NULL, "riscv.spike.bootrom",
-                           s->fdt_size + 0x2000, &error_fatal);
-    memory_region_add_subregion(system_memory, 0x0, boot_rom);
+    memory_region_init_rom(mask_rom, NULL, "riscv.spike.mrom",
+                           memmap[SPIKE_MROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
+                                mask_rom);
 
     if (machine->kernel_filename) {
         load_kernel(machine->kernel_filename);
@@ -221,16 +217,26 @@ static void spike_v1_10_0_board_init(MachineState *machine)
                                      /* dtb: */
     };
 
-    /* copy in the reset vector */
-    copy_le32_to_phys(memmap[SPIKE_MROM].base, reset_vec, sizeof(reset_vec));
+    /* copy in the reset vector in little_endian byte order */
+    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
+        reset_vec[i] = cpu_to_le32(reset_vec[i]);
+    }
+    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
+                          memmap[SPIKE_MROM].base, &address_space_memory);
 
     /* copy in the device tree */
-    qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
-    cpu_physical_memory_write(memmap[SPIKE_MROM].base + sizeof(reset_vec),
-        s->fdt, s->fdt_size);
+    if (fdt_pack(s->fdt) || fdt_totalsize(s->fdt) >
+            memmap[SPIKE_MROM].size - sizeof(reset_vec)) {
+        error_report("not enough space to store device-tree");
+        exit(1);
+    }
+    qemu_fdt_dumpdtb(s->fdt, fdt_totalsize(s->fdt));
+    rom_add_blob_fixed_as("mrom.fdt", s->fdt, fdt_totalsize(s->fdt),
+                          memmap[SPIKE_MROM].base + sizeof(reset_vec),
+                          &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, boot_rom, &s->soc.harts[0].env, serial_hd(0));
+    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
@@ -244,7 +250,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     SpikeState *s = g_new0(SpikeState, 1);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
+    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
+    int i;
 
     /* Initialize SOC */
     object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
@@ -264,9 +271,10 @@ static void spike_v1_09_1_board_init(MachineState *machine)
         main_mem);
 
     /* boot rom */
-    memory_region_init_ram(boot_rom, NULL, "riscv.spike.bootrom",
-                           0x40000, &error_fatal);
-    memory_region_add_subregion(system_memory, 0x0, boot_rom);
+    memory_region_init_rom(mask_rom, NULL, "riscv.spike.mrom",
+                           memmap[SPIKE_MROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
+                                mask_rom);
 
     if (machine->kernel_filename) {
         load_kernel(machine->kernel_filename);
@@ -319,15 +327,20 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     g_free(isa);
     size_t config_string_len = strlen(config_string);
 
-    /* copy in the reset vector */
-    copy_le32_to_phys(memmap[SPIKE_MROM].base, reset_vec, sizeof(reset_vec));
+    /* copy in the reset vector in little_endian byte order */
+    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
+        reset_vec[i] = cpu_to_le32(reset_vec[i]);
+    }
+    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
+                          memmap[SPIKE_MROM].base, &address_space_memory);
 
     /* copy in the config string */
-    cpu_physical_memory_write(memmap[SPIKE_MROM].base + sizeof(reset_vec),
-        config_string, config_string_len);
+    rom_add_blob_fixed_as("mrom.reset", config_string, config_string_len,
+                          memmap[SPIKE_MROM].base + sizeof(reset_vec),
+                          &address_space_memory);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, boot_rom, &s->soc.harts[0].env, serial_hd(0));
+    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 7ef9ba26debc..ad03113e0f72 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -40,13 +40,15 @@
 #include "exec/address-spaces.h"
 #include "elf.h"
 
+#include <libfdt.h>
+
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } virt_memmap[] = {
     [VIRT_DEBUG] =    {        0x0,      0x100 },
-    [VIRT_MROM] =     {     0x1000,     0x2000 },
-    [VIRT_TEST] =     {     0x4000,     0x1000 },
+    [VIRT_MROM] =     {     0x1000,    0x11000 },
+    [VIRT_TEST] =     {   0x100000,     0x1000 },
     [VIRT_CLINT] =    {  0x2000000,    0x10000 },
     [VIRT_PLIC] =     {  0xc000000,  0x4000000 },
     [VIRT_UART0] =    { 0x10000000,      0x100 },
@@ -54,14 +56,6 @@ static const struct MemmapEntry {
     [VIRT_DRAM] =     { 0x80000000,        0x0 },
 };
 
-static void copy_le32_to_phys(hwaddr pa, uint32_t *rom, size_t len)
-{
-    int i;
-    for (i = 0; i < (len >> 2); i++) {
-        stl_phys(&address_space_memory, pa + (i << 2), rom[i]);
-    }
-}
-
 static uint64_t load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
@@ -272,7 +266,7 @@ static void riscv_virt_board_init(MachineState *machine)
     RISCVVirtState *s = g_new0(RISCVVirtState, 1);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
+    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
@@ -299,9 +293,10 @@ static void riscv_virt_board_init(MachineState *machine)
     fdt = create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     /* boot rom */
-    memory_region_init_ram(boot_rom, NULL, "riscv_virt_board.bootrom",
-                           s->fdt_size + 0x2000, &error_fatal);
-    memory_region_add_subregion(system_memory, 0x0, boot_rom);
+    memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
+                           memmap[VIRT_MROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
+                                mask_rom);
 
     if (machine->kernel_filename) {
         uint64_t kernel_entry = load_kernel(machine->kernel_filename);
@@ -335,13 +330,23 @@ static void riscv_virt_board_init(MachineState *machine)
                                      /* dtb: */
     };
 
-    /* copy in the reset vector */
-    copy_le32_to_phys(memmap[VIRT_MROM].base, reset_vec, sizeof(reset_vec));
+    /* copy in the reset vector in little_endian byte order */
+    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
+        reset_vec[i] = cpu_to_le32(reset_vec[i]);
+    }
+    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
+                          memmap[VIRT_MROM].base, &address_space_memory);
 
     /* copy in the device tree */
-    qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
-    cpu_physical_memory_write(memmap[VIRT_MROM].base + sizeof(reset_vec),
-        s->fdt, s->fdt_size);
+    if (fdt_pack(s->fdt) || fdt_totalsize(s->fdt) >
+            memmap[VIRT_MROM].size - sizeof(reset_vec)) {
+        error_report("not enough space to store device-tree");
+        exit(1);
+    }
+    qemu_fdt_dumpdtb(s->fdt, fdt_totalsize(s->fdt));
+    rom_add_blob_fixed_as("mrom.fdt", s->fdt, fdt_totalsize(s->fdt),
+                          memmap[VIRT_MROM].base + sizeof(reset_vec),
+                          &address_space_memory);
 
     /* create PLIC hart topology configuration string */
     plic_hart_config_len = (strlen(VIRT_PLIC_HART_CONFIG) + 1) * smp_cpus;
-- 
2.7.0
