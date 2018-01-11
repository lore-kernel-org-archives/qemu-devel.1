Received: from eggs.gnu.org ([2001:4830:134:3::10]:48178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZSWp-0003Le-AO
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZSWl-0008Mg-SS
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:39 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZSWl-0008MA-GW
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 21:23:35 -0500
Received: by mail-pf0-x242.google.com with SMTP id e76so16861pfk.1
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 18:23:35 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 10 Jan 2018 18:21:58 -0800
Message-Id: <1515637324-96034-16-git-send-email-mjc@sifive.com>
In-Reply-To: <1515637324-96034-1-git-send-email-mjc@sifive.com>
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v3 15/21] RISC-V Spike Machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

RISC-V machines compatble with Spike aka riscv-isa-sim, the RISC-V
Instruction Set Simulator. The following machines are implemented:

- 'spike_v1.9'; HTIF console, config-string, Privileged ISA Version 1.9.1
- 'spike_v1.10'; HTIF console, device-tree, Privileged ISA Version 1.10

Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/spike_v1_09.c   | 207 ++++++++++++++++++++++++++++++++++
 hw/riscv/spike_v1_10.c   | 281 +++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/spike.h |  51 +++++++++
 3 files changed, 539 insertions(+)
 create mode 100644 hw/riscv/spike_v1_09.c
 create mode 100644 hw/riscv/spike_v1_10.c
 create mode 100644 include/hw/riscv/spike.h

diff --git a/hw/riscv/spike_v1_09.c b/hw/riscv/spike_v1_09.c
new file mode 100644
index 0000000..9b32c6a
--- /dev/null
+++ b/hw/riscv/spike_v1_09.c
@@ -0,0 +1,207 @@
+/*
+ * QEMU RISC-V Spike Board
+ *
+ * Author: Sagar Karandikar, sagark@eecs.berkeley.edu
+ *
+ * This provides a RISC-V Board with the following devices:
+ *
+ * 0) HTIF Test Pass/Fail Reporting (no syscall proxy)
+ * 1) HTIF Console
+ *
+ * These are created by htif_mm_init below.
+ *
+ * This board currently uses a hardcoded devicetree that indicates one hart.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "hw/hw.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "hw/sysbus.h"
+#include "target/riscv/cpu.h"
+#include "hw/riscv/riscv_htif.h"
+#include "hw/riscv/riscv_hart.h"
+#include "hw/riscv/sifive_clint.h"
+#include "hw/riscv/spike.h"
+#include "chardev/char.h"
+#include "sysemu/arch_init.h"
+#include "exec/address-spaces.h"
+#include "elf.h"
+
+static const struct MemmapEntry {
+    hwaddr base;
+    hwaddr size;
+} spike_memmap[] = {
+    [SPIKE_MROM] =     {     0x1000,     0x2000 },
+    [SPIKE_CLINT] =    {  0x2000000,    0x10000 },
+    [SPIKE_DRAM] =     { 0x80000000,        0x0 },
+};
+
+static uint64_t identity_translate(void *opaque, uint64_t addr)
+{
+    return addr;
+}
+
+static uint64_t load_kernel(const char *kernel_filename)
+{
+    uint64_t kernel_entry, kernel_high;
+
+    if (load_elf(kernel_filename, identity_translate, NULL,
+                 &kernel_entry, NULL, &kernel_high,
+                 /* little_endian = */ 0, ELF_MACHINE, 1, 0) < 0) {
+        error_report("qemu: could not load kernel '%s'", kernel_filename);
+        exit(1);
+    }
+    return kernel_entry;
+}
+
+static void riscv_spike_board_init(MachineState *machine)
+{
+    const struct MemmapEntry *memmap = spike_memmap;
+
+    SpikeState *s = g_new0(SpikeState, 1);
+    /* const char *cpu_model = machine->cpu_model; */
+    /* const char *kernel_cmdline = machine->kernel_cmdline; */
+    /* const char *initrd_filename = machine->initrd_filename; */
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *main_mem = g_new(MemoryRegion, 1);
+    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
+
+    /* Initialize SOC */
+    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
+                              &error_abort);
+    object_property_set_str(OBJECT(&s->soc), TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_09,
+                            "cpu-model", &error_abort);
+    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
+                            &error_abort);
+    object_property_set_bool(OBJECT(&s->soc), true, "realized",
+                            &error_abort);
+
+    /* register system main memory (actual RAM) */
+    memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
+                           machine->ram_size, &error_fatal);
+    memory_region_add_subregion(system_memory, DRAM_BASE, main_mem);
+
+    /* boot rom */
+    memory_region_init_ram(boot_rom, NULL, "riscv.spike.bootrom",
+                           0x40000, &error_fatal);
+    memory_region_add_subregion(system_memory, 0x0, boot_rom);
+
+    if (machine->kernel_filename) {
+        load_kernel(machine->kernel_filename);
+    }
+
+    uint32_t reset_vec[8] = {
+        0x297 + memmap[SPIKE_DRAM].base - memmap[SPIKE_MROM].base, /* lui */
+        0x00028067,                   /* jump to DRAM_BASE */
+        0x00000000,                   /* reserved */
+        memmap[SPIKE_MROM].base + sizeof(reset_vec), /* config string pointer */
+        0, 0, 0, 0                    /* trap vector */
+    };
+
+    /* part one of config string - before memory size specified */
+    const char *config_string_tmpl =
+        "platform {\n"
+        "  vendor ucb;\n"
+        "  arch spike;\n"
+        "};\n"
+        "rtc {\n"
+        "  addr 0x" "40000000" ";\n"
+        "};\n"
+        "ram {\n"
+        "  0 {\n"
+        "    addr 0x" "80000000" ";\n"
+        "    size 0x" "%016" PRIx64 ";\n"
+        "  };\n"
+        "};\n"
+        "core {\n"
+        "  0" " {\n"
+        "    " "0 {\n"
+        "      isa " "rv64imafd" ";\n"
+        "      timecmp 0x" "40000008" ";\n"
+        "      ipi 0x" "40001000" ";\n" /* match dummy ipi region above */
+        "    };\n"
+        "  };\n"
+        "};\n";
+
+    /* build config string with supplied memory size */
+    size_t config_string_size = strlen(config_string_tmpl) + 16;
+    char *config_string = malloc(config_string_size);
+    snprintf(config_string, config_string_size,
+        config_string_tmpl, (uint64_t)ram_size);
+    size_t config_string_len = strlen(config_string);
+
+    /* copy in the reset vector */
+    cpu_physical_memory_write(memmap[SPIKE_MROM].base, reset_vec,
+        sizeof(reset_vec));
+
+    /* copy in the config string */
+    cpu_physical_memory_write(memmap[SPIKE_MROM].base + sizeof(reset_vec),
+        config_string, config_string_len);
+
+    /* add memory mapped htif registers at location specified in the symbol
+       table of the elf being loaded (thus kernel_filename is passed to the
+       init rather than an address) */
+    htif_mm_init(system_memory, machine->kernel_filename,
+        s->soc.harts[0].env.irq[4], boot_rom,
+        &s->soc.harts[0].env, serial_hds[0]);
+
+    /* Core Local Interruptor (timer and IPI) */
+    sifive_clint_create(0x40000000, 0x2000, smp_cpus, 0x1000, 0x8, 0x0);
+}
+
+static int riscv_spike_board_sysbus_device_init(SysBusDevice *sysbusdev)
+{
+    return 0;
+}
+
+static void riscv_spike_board_class_init(ObjectClass *klass, void *data)
+{
+    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
+    k->init = riscv_spike_board_sysbus_device_init;
+}
+
+static const TypeInfo riscv_spike_board_device = {
+    .name          = TYPE_RISCV_SPIKE_V1_09_1_BOARD,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SpikeState),
+    .class_init    = riscv_spike_board_class_init,
+};
+
+static void riscv_spike_board_machine_init(MachineClass *mc)
+{
+    mc->desc = "RISC-V Spike Board (Privileged ISA v1.9.1)";
+    mc->init = riscv_spike_board_init;
+    mc->max_cpus = 1;
+    mc->is_default = 1;
+}
+
+DEFINE_MACHINE("spike_v1.9", riscv_spike_board_machine_init)
+
+static void riscv_spike_board_register_types(void)
+{
+    type_register_static(&riscv_spike_board_device);
+}
+
+type_init(riscv_spike_board_register_types);
diff --git a/hw/riscv/spike_v1_10.c b/hw/riscv/spike_v1_10.c
new file mode 100644
index 0000000..4edff49
--- /dev/null
+++ b/hw/riscv/spike_v1_10.c
@@ -0,0 +1,281 @@
+/*
+ * QEMU RISC-V Spike Board
+ *
+ * Author: Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Author: Michael Clark, mjc@sifive.com
+ *
+ * This provides a RISC-V Board with the following devices:
+ *
+ * 0) HTIF Test Pass/Fail Reporting (no syscall proxy)
+ * 1) HTIF Console
+ *
+ * These are created by htif_mm_init below.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "hw/hw.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "hw/sysbus.h"
+#include "target/riscv/cpu.h"
+#include "hw/riscv/riscv_htif.h"
+#include "hw/riscv/riscv_hart.h"
+#include "hw/riscv/sifive_clint.h"
+#include "hw/riscv/spike.h"
+#include "chardev/char.h"
+#include "sysemu/arch_init.h"
+#include "sysemu/device_tree.h"
+#include "exec/address-spaces.h"
+#include "elf.h"
+
+static const struct MemmapEntry {
+    hwaddr base;
+    hwaddr size;
+} spike_memmap[] = {
+    [SPIKE_MROM] =     {     0x1000,     0x2000 },
+    [SPIKE_CLINT] =    {  0x2000000,    0x10000 },
+    [SPIKE_DRAM] =     { 0x80000000,        0x0 },
+};
+
+static uint64_t identity_translate(void *opaque, uint64_t addr)
+{
+    return addr;
+}
+
+static uint64_t load_kernel(const char *kernel_filename)
+{
+    uint64_t kernel_entry, kernel_high;
+
+    if (load_elf(kernel_filename, identity_translate, NULL,
+                 &kernel_entry, NULL, &kernel_high,
+                 /* little_endian = */ 0, ELF_MACHINE, 1, 0) < 0) {
+        error_report("qemu: could not load kernel '%s'", kernel_filename);
+        exit(1);
+    }
+    return kernel_entry;
+}
+
+static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
+    uint64_t mem_size, const char *cmdline)
+{
+    void *fdt;
+    int cpu;
+    uint32_t *cells;
+    char *nodename;
+
+    fdt = s->fdt = create_device_tree(&s->fdt_size);
+    if (!fdt) {
+        error_report("create_device_tree() failed");
+        exit(1);
+    }
+
+    qemu_fdt_setprop_string(fdt, "/", "model", "ucbbar,spike-bare,qemu");
+    qemu_fdt_setprop_string(fdt, "/", "compatible", "ucbbar,spike-bare-dev");
+    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
+
+    qemu_fdt_add_subnode(fdt, "/htif");
+    qemu_fdt_setprop_string(fdt, "/htif", "compatible", "ucb,htif0");
+
+    qemu_fdt_add_subnode(fdt, "/soc");
+    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
+    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "ucbbar,spike-bare-soc");
+    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
+
+    nodename = g_strdup_printf("/memory@%lx",
+        (long)memmap[SPIKE_DRAM].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        memmap[SPIKE_DRAM].base >> 32, memmap[SPIKE_DRAM].base,
+        mem_size >> 32, mem_size);
+    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
+    g_free(nodename);
+
+    qemu_fdt_add_subnode(fdt, "/cpus");
+    qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency", 10000000);
+    qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0x0);
+    qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
+
+    for (cpu = s->soc.num_harts - 1; cpu >= 0; cpu--) {
+        nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
+        char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
+        char *isa = riscv_isa_string(&s->soc.harts[cpu]);
+        qemu_fdt_add_subnode(fdt, nodename);
+        qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", 1000000000);
+        qemu_fdt_setprop_string(fdt, nodename, "mmu-type", "riscv,sv48");
+        qemu_fdt_setprop_string(fdt, nodename, "riscv,isa", isa);
+        qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
+        qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
+        qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
+        qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
+        qemu_fdt_add_subnode(fdt, intc);
+        qemu_fdt_setprop_cell(fdt, intc, "phandle", 1);
+        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", 1);
+        qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
+        qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
+        qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
+        g_free(isa);
+        g_free(intc);
+        g_free(nodename);
+    }
+
+    cells =  g_new0(uint32_t, s->soc.num_harts * 4);
+    for (cpu = 0; cpu < s->soc.num_harts; cpu++) {
+        nodename =
+            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
+        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
+        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
+        cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
+        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
+        cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
+        g_free(nodename);
+    }
+    nodename = g_strdup_printf("/soc/clint@%lx",
+        (long)memmap[SPIKE_CLINT].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,clint0");
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[SPIKE_CLINT].base,
+        0x0, memmap[SPIKE_CLINT].size);
+    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
+        cells, s->soc.num_harts * sizeof(uint32_t) * 4);
+    g_free(cells);
+    g_free(nodename);
+
+    qemu_fdt_add_subnode(fdt, "/chosen");
+    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+ }
+
+static void riscv_spike_board_init(MachineState *machine)
+{
+    const struct MemmapEntry *memmap = spike_memmap;
+
+    SpikeState *s = g_new0(SpikeState, 1);
+    /* const char *cpu_model = machine->cpu_model; */
+    /* const char *kernel_cmdline = machine->kernel_cmdline; */
+    /* const char *initrd_filename = machine->initrd_filename; */
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *main_mem = g_new(MemoryRegion, 1);
+    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
+
+    /* Initialize SOC */
+    object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
+                              &error_abort);
+    object_property_set_str(OBJECT(&s->soc), TYPE_RISCV_CPU_IMAFDCSU_PRIV_1_10,
+                            "cpu-model", &error_abort);
+    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
+                            &error_abort);
+    object_property_set_bool(OBJECT(&s->soc), true, "realized",
+                            &error_abort);
+
+    /* register system main memory (actual RAM) */
+    memory_region_init_ram(main_mem, NULL, "riscv.spike.ram",
+                           machine->ram_size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SPIKE_DRAM].base,
+        main_mem);
+
+    /* create device tree */
+    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
+
+    /* boot rom */
+    memory_region_init_ram(boot_rom, NULL, "riscv.spike.bootrom",
+                           s->fdt_size + 0x2000, &error_fatal);
+    memory_region_add_subregion(system_memory, 0x0, boot_rom);
+
+    if (machine->kernel_filename) {
+        load_kernel(machine->kernel_filename);
+    }
+
+    /* reset vector */
+    uint32_t reset_vec[8] = {
+        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
+        0x02028593,                  /*     addi   a1, t0, %pcrel_lo(1b) */
+        0xf1402573,                  /*     csrr   a0, mhartid  */
+#if defined(TARGET_RISCV32)
+        0x0182a283,                  /*     lw     t0, 24(t0) */
+#elif defined(TARGET_RISCV64)
+        0x0182b283,                  /*     ld     t0, 24(t0) */
+#endif
+        0x00028067,                  /*     jr     t0 */
+        0x00000000,
+        memmap[SPIKE_DRAM].base,     /* start: .dword DRAM_BASE */
+        0x00000000,
+                                     /* dtb: */
+    };
+
+    /* copy in the reset vector */
+    cpu_physical_memory_write(memmap[SPIKE_MROM].base,
+        reset_vec, sizeof(reset_vec));
+
+    /* copy in the device tree */
+    qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
+    cpu_physical_memory_write(memmap[SPIKE_MROM].base + sizeof(reset_vec),
+        s->fdt, s->fdt_size);
+
+    /* add memory mapped htif registers at location specified in the symbol
+       table of the elf being loaded (thus kernel_filename is passed to the
+       init rather than an address) */
+    htif_mm_init(system_memory, machine->kernel_filename,
+        s->soc.harts[0].env.irq[4], boot_rom,
+        &s->soc.harts[0].env, serial_hds[0]);
+
+    /* Core Local Interruptor (timer and IPI) */
+    sifive_clint_create(0x2000000, 0x10000, smp_cpus,
+        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+}
+
+static int riscv_spike_board_sysbus_device_init(SysBusDevice *sysbusdev)
+{
+    return 0;
+}
+
+static void riscv_spike_board_class_init(ObjectClass *klass, void *data)
+{
+    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
+    k->init = riscv_spike_board_sysbus_device_init;
+}
+
+static const TypeInfo riscv_spike_board_device = {
+    .name          = TYPE_RISCV_SPIKE_V1_10_0_BOARD,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SpikeState),
+    .class_init    = riscv_spike_board_class_init,
+};
+
+static void riscv_spike_board_machine_init(MachineClass *mc)
+{
+    mc->desc = "RISC-V Spike Board (Privileged ISA v1.10)";
+    mc->init = riscv_spike_board_init;
+    mc->max_cpus = 1;
+}
+
+DEFINE_MACHINE("spike_v1.10", riscv_spike_board_machine_init)
+
+static void riscv_spike_board_register_types(void)
+{
+    type_register_static(&riscv_spike_board_device);
+}
+
+type_init(riscv_spike_board_register_types);
diff --git a/include/hw/riscv/spike.h b/include/hw/riscv/spike.h
new file mode 100644
index 0000000..cb4d6ac
--- /dev/null
+++ b/include/hw/riscv/spike.h
@@ -0,0 +1,51 @@
+/*
+ * SiFive U500 series machine interface
+ *
+ * Copyright (c) 2017 SiFive, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_SPIKE_H
+#define HW_SPIKE_H
+
+#define TYPE_RISCV_SPIKE_V1_09_1_BOARD "riscv.spike_v1_9"
+#define TYPE_RISCV_SPIKE_V1_10_0_BOARD "riscv.spike_v1_10"
+
+#define SPIKE(obj) \
+    OBJECT_CHECK(SpikeState, (obj), TYPE_RISCV_SPIKE_BOARD)
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    RISCVHartArrayState soc;
+    void *fdt;
+    int fdt_size;
+} SpikeState;
+
+
+enum {
+    SPIKE_MROM,
+    SPIKE_CLINT,
+    SPIKE_DRAM
+};
+
+#endif
-- 
2.7.0
