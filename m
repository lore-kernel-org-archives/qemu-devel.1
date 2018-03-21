Received: from eggs.gnu.org ([2001:4830:134:3::10]:53052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eykeN-00020y-Ut
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eykeL-00025P-OV
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:47:59 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:42555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eykeL-000254-Fr
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:47:57 -0400
Received: by mail-pf0-x242.google.com with SMTP id a16so2460337pfn.9
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 13:47:57 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 21 Mar 2018 13:46:44 -0700
Message-Id: <1521665220-3869-9-git-send-email-mjc@sifive.com>
In-Reply-To: <1521665220-3869-1-git-send-email-mjc@sifive.com>
References: <1521665220-3869-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PULL 08/24] RISC-V: Make sure rom has space for fdt
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

Remove a potential buffer overflow (not seen in practice).
Perhaps cpu_physical_memory_write already has bound checks.
This change however makes space for the maximum device tree
size and adds an explicit bounds check and error message.
It doesn't trigger, but it may help in the future if the
device-tree size is exceeded. e.g. large bootargs.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c | 20 ++++++++++++--------
 hw/riscv/spike.c    | 16 +++++++++++-----
 hw/riscv/virt.c     | 13 +++++++++----
 3 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 083043a..57b4f4f 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -52,7 +52,7 @@ static const struct MemmapEntry {
     hwaddr size;
 } sifive_u_memmap[] = {
     [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
-    [SIFIVE_U_MROM] =     {     0x1000,     0x2000 },
+    [SIFIVE_U_MROM] =     {     0x1000,    0x11000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
     [SIFIVE_U_UART0] =    { 0x10013000,     0x1000 },
@@ -221,7 +221,7 @@ static void riscv_sifive_u_init(MachineState *machine)
     const struct MemmapEntry *memmap = sifive_u_memmap;
 
     SiFiveUState *s = g_new0(SiFiveUState, 1);
-    MemoryRegion *sys_memory = get_system_memory();
+    MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
 
@@ -239,7 +239,7 @@ static void riscv_sifive_u_init(MachineState *machine)
     /* register RAM */
     memory_region_init_ram(main_mem, NULL, "riscv.sifive.u.ram",
                            machine->ram_size, &error_fatal);
-    memory_region_add_subregion(sys_memory, memmap[SIFIVE_U_DRAM].base,
+    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DRAM].base,
         main_mem);
 
     /* create device tree */
@@ -247,9 +247,9 @@ static void riscv_sifive_u_init(MachineState *machine)
 
     /* boot rom */
     memory_region_init_ram(mask_rom, NULL, "riscv.sifive.u.mrom",
-                           memmap[SIFIVE_U_MROM].base, &error_fatal);
-    memory_region_set_readonly(mask_rom, true);
-    memory_region_add_subregion(sys_memory, 0x0, mask_rom);
+                           memmap[SIFIVE_U_MROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
+                                mask_rom);
 
     if (machine->kernel_filename) {
         load_kernel(machine->kernel_filename);
@@ -276,6 +276,10 @@ static void riscv_sifive_u_init(MachineState *machine)
     copy_le32_to_phys(memmap[SIFIVE_U_MROM].base, reset_vec, sizeof(reset_vec));
 
     /* copy in the device tree */
+    if (s->fdt_size >= memmap[SIFIVE_U_MROM].size - sizeof(reset_vec)) {
+        error_report("qemu: not enough space to store device-tree");
+        exit(1);
+    }
     qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
     cpu_physical_memory_write(memmap[SIFIVE_U_MROM].base +
         sizeof(reset_vec), s->fdt, s->fdt_size);
@@ -293,9 +297,9 @@ static void riscv_sifive_u_init(MachineState *machine)
         SIFIVE_U_PLIC_CONTEXT_BASE,
         SIFIVE_U_PLIC_CONTEXT_STRIDE,
         memmap[SIFIVE_U_PLIC].size);
-    sifive_uart_create(sys_memory, memmap[SIFIVE_U_UART0].base,
+    sifive_uart_create(system_memory, memmap[SIFIVE_U_UART0].base,
         serial_hds[0], SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART0_IRQ]);
-    /* sifive_uart_create(sys_memory, memmap[SIFIVE_U_UART1].base,
+    /* sifive_uart_create(system_memory, memmap[SIFIVE_U_UART1].base,
         serial_hds[1], SIFIVE_PLIC(s->plic)->irqs[SIFIVE_U_UART1_IRQ]); */
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
         memmap[SIFIVE_U_CLINT].size, smp_cpus,
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 64e585e..c7d937b 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -46,7 +46,7 @@ static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } spike_memmap[] = {
-    [SPIKE_MROM] =     {     0x1000,     0x2000 },
+    [SPIKE_MROM] =     {     0x1000,    0x11000 },
     [SPIKE_CLINT] =    {  0x2000000,    0x10000 },
     [SPIKE_DRAM] =     { 0x80000000,        0x0 },
 };
@@ -197,8 +197,9 @@ static void spike_v1_10_0_board_init(MachineState *machine)
 
     /* boot rom */
     memory_region_init_ram(mask_rom, NULL, "riscv.spike.mrom",
-                           s->fdt_size + 0x2000, &error_fatal);
-    memory_region_add_subregion(system_memory, 0x0, mask_rom);
+                           memmap[SPIKE_MROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
+                                mask_rom);
 
     if (machine->kernel_filename) {
         load_kernel(machine->kernel_filename);
@@ -225,6 +226,10 @@ static void spike_v1_10_0_board_init(MachineState *machine)
     copy_le32_to_phys(memmap[SPIKE_MROM].base, reset_vec, sizeof(reset_vec));
 
     /* copy in the device tree */
+    if (s->fdt_size >= memmap[SPIKE_MROM].size - sizeof(reset_vec)) {
+        error_report("qemu: not enough space to store device-tree");
+        exit(1);
+    }
     qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
     cpu_physical_memory_write(memmap[SPIKE_MROM].base + sizeof(reset_vec),
         s->fdt, s->fdt_size);
@@ -266,8 +271,9 @@ static void spike_v1_09_1_board_init(MachineState *machine)
 
     /* boot rom */
     memory_region_init_ram(mask_rom, NULL, "riscv.spike.mrom",
-                           0x40000, &error_fatal);
-    memory_region_add_subregion(system_memory, 0x0, mask_rom);
+                           memmap[SPIKE_MROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
+                                mask_rom);
 
     if (machine->kernel_filename) {
         load_kernel(machine->kernel_filename);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5913100..d680cbd 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -45,8 +45,8 @@ static const struct MemmapEntry {
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
@@ -297,8 +297,9 @@ static void riscv_virt_board_init(MachineState *machine)
 
     /* boot rom */
     memory_region_init_ram(mask_rom, NULL, "riscv_virt_board.mrom",
-                           s->fdt_size + 0x2000, &error_fatal);
-    memory_region_add_subregion(system_memory, 0x0, mask_rom);
+                           memmap[VIRT_MROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
+                                mask_rom);
 
     if (machine->kernel_filename) {
         uint64_t kernel_entry = load_kernel(machine->kernel_filename);
@@ -336,6 +337,10 @@ static void riscv_virt_board_init(MachineState *machine)
     copy_le32_to_phys(memmap[VIRT_MROM].base, reset_vec, sizeof(reset_vec));
 
     /* copy in the device tree */
+    if (s->fdt_size >= memmap[VIRT_MROM].size - sizeof(reset_vec)) {
+        error_report("qemu: not enough space to store device-tree");
+        exit(1);
+    }
     qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
     cpu_physical_memory_write(memmap[VIRT_MROM].base + sizeof(reset_vec),
         s->fdt, s->fdt_size);
-- 
2.7.0
