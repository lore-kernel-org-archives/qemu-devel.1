Received: from eggs.gnu.org ([2001:4830:134:3::10]:33190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2C7-0001L2-9a
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ey2C3-0002aq-2Z
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:19:51 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:33246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ey2C2-0002aD-Q4
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 17:19:46 -0400
Received: by mail-pl0-x243.google.com with SMTP id c11-v6so11043495plo.0
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 14:19:46 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Mon, 19 Mar 2018 14:18:29 -0700
Message-Id: <1521494329-19546-7-git-send-email-mjc@sifive.com>
In-Reply-To: <1521494329-19546-1-git-send-email-mjc@sifive.com>
References: <1521494329-19546-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v4 06/26] RISC-V: Mark ROM read-only after
 copying in code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

The sifive_u machine already marks its ROM readonly. This fixes
the remaining boards.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c      |  9 +++++----
 hw/riscv/spike.c         | 18 ++++++++++--------
 hw/riscv/virt.c          |  7 ++++---
 include/hw/riscv/spike.h |  8 --------
 4 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 6116c38..25df16c 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -223,7 +223,7 @@ static void riscv_sifive_u_init(MachineState *machine)
     SiFiveUState *s = g_new0(SiFiveUState, 1);
     MemoryRegion *sys_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
+    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
 
     /* Initialize SOC */
     object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
@@ -246,10 +246,10 @@ static void riscv_sifive_u_init(MachineState *machine)
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     /* boot rom */
-    memory_region_init_ram(boot_rom, NULL, "riscv.sifive.u.mrom",
+    memory_region_init_ram(mask_rom, NULL, "riscv.sifive.u.mrom",
                            memmap[SIFIVE_U_MROM].base, &error_fatal);
-    memory_region_set_readonly(boot_rom, true);
-    memory_region_add_subregion(sys_memory, 0x0, boot_rom);
+    memory_region_set_readonly(mask_rom, true);
+    memory_region_add_subregion(sys_memory, 0x0, mask_rom);
 
     if (machine->kernel_filename) {
         load_kernel(machine->kernel_filename);
@@ -279,6 +279,7 @@ static void riscv_sifive_u_init(MachineState *machine)
     qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
     cpu_physical_memory_write(memmap[SIFIVE_U_MROM].base +
         sizeof(reset_vec), s->fdt, s->fdt_size);
+    memory_region_set_readonly(mask_rom, true);
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 7710333..74edf33 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -173,7 +173,7 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     SpikeState *s = g_new0(SpikeState, 1);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
+    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
 
     /* Initialize SOC */
     object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
@@ -196,9 +196,9 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     /* boot rom */
-    memory_region_init_ram(boot_rom, NULL, "riscv.spike.bootrom",
+    memory_region_init_ram(mask_rom, NULL, "riscv.spike.mrom",
                            s->fdt_size + 0x2000, &error_fatal);
-    memory_region_add_subregion(system_memory, 0x0, boot_rom);
+    memory_region_add_subregion(system_memory, 0x0, mask_rom);
 
     if (machine->kernel_filename) {
         load_kernel(machine->kernel_filename);
@@ -228,9 +228,10 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
     cpu_physical_memory_write(memmap[SPIKE_MROM].base + sizeof(reset_vec),
         s->fdt, s->fdt_size);
+    memory_region_set_readonly(mask_rom, true);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, boot_rom, &s->soc.harts[0].env, serial_hds[0]);
+    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hds[0]);
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
@@ -244,7 +245,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     SpikeState *s = g_new0(SpikeState, 1);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
+    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
 
     /* Initialize SOC */
     object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
@@ -264,9 +265,9 @@ static void spike_v1_09_1_board_init(MachineState *machine)
         main_mem);
 
     /* boot rom */
-    memory_region_init_ram(boot_rom, NULL, "riscv.spike.bootrom",
+    memory_region_init_ram(mask_rom, NULL, "riscv.spike.mrom",
                            0x40000, &error_fatal);
-    memory_region_add_subregion(system_memory, 0x0, boot_rom);
+    memory_region_add_subregion(system_memory, 0x0, mask_rom);
 
     if (machine->kernel_filename) {
         load_kernel(machine->kernel_filename);
@@ -325,9 +326,10 @@ static void spike_v1_09_1_board_init(MachineState *machine)
     /* copy in the config string */
     cpu_physical_memory_write(memmap[SPIKE_MROM].base + sizeof(reset_vec),
         config_string, config_string_len);
+    memory_region_set_readonly(mask_rom, true);
 
     /* initialize HTIF using symbols found in load_kernel */
-    htif_mm_init(system_memory, boot_rom, &s->soc.harts[0].env, serial_hds[0]);
+    htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hds[0]);
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f8c19b4..f1e3641 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -270,7 +270,7 @@ static void riscv_virt_board_init(MachineState *machine)
     RISCVVirtState *s = g_new0(RISCVVirtState, 1);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
-    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
+    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
@@ -296,9 +296,9 @@ static void riscv_virt_board_init(MachineState *machine)
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     /* boot rom */
-    memory_region_init_ram(boot_rom, NULL, "riscv_virt_board.bootrom",
+    memory_region_init_ram(mask_rom, NULL, "riscv_virt_board.mrom",
                            s->fdt_size + 0x2000, &error_fatal);
-    memory_region_add_subregion(system_memory, 0x0, boot_rom);
+    memory_region_add_subregion(system_memory, 0x0, mask_rom);
 
     if (machine->kernel_filename) {
         uint64_t kernel_entry = load_kernel(machine->kernel_filename);
@@ -339,6 +339,7 @@ static void riscv_virt_board_init(MachineState *machine)
     qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
     cpu_physical_memory_write(memmap[VIRT_MROM].base + sizeof(reset_vec),
         s->fdt, s->fdt_size);
+    memory_region_set_readonly(mask_rom, true);
 
     /* create PLIC hart topology configuration string */
     plic_hart_config_len = (strlen(VIRT_PLIC_HART_CONFIG) + 1) * smp_cpus;
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
index d85a64e..179b6cf 100644
--- a/include/hw/riscv/spike.h
+++ b/include/hw/riscv/spike.h
@@ -22,20 +22,12 @@
 #define TYPE_RISCV_SPIKE_V1_09_1_BOARD "riscv.spike_v1_9_1"
 #define TYPE_RISCV_SPIKE_V1_10_0_BOARD "riscv.spike_v1_10"
 
-#define SPIKE(obj) \
-    OBJECT_CHECK(SpikeState, (obj), TYPE_RISCV_SPIKE_BOARD)
-
 typedef struct {
-    /*< private >*/
-    SysBusDevice parent_obj;
-
-    /*< public >*/
     RISCVHartArrayState soc;
     void *fdt;
     int fdt_size;
 } SpikeState;
 
-
 enum {
     SPIKE_MROM,
     SPIKE_CLINT,
-- 
2.7.0
