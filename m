Received: from eggs.gnu.org ([2001:4830:134:3::10]:45100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZQ7S-0006Sx-Ja
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:49:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZQ7M-0000bv-MH
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:49:18 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:46164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZQ7L-0000aZ-M2
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:49:11 -0500
Received: by mail-pg0-x243.google.com with SMTP id r2so1083542pgq.13
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 15:49:11 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 10 Jan 2018 15:46:35 -0800
Message-Id: <1515628000-93285-17-git-send-email-mjc@sifive.com>
In-Reply-To: <1515628000-93285-1-git-send-email-mjc@sifive.com>
References: <1515628000-93285-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v2 16/21] RISC-V VirtIO Machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches+subscribe@groups.riscv.org>

RISC-V machine with device-tree, 16550a UART and VirtIO MMIO.
The following machine is implemented:

- 'virt'; CLINT, PLIC, 16550A UART, VirtIO MMIO, device-tree

Signed-off-by: Michael Clark <mjc@sifive.com>
---
 hw/riscv/virt.c         | 364 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h |  73 ++++++++++
 2 files changed, 437 insertions(+)
 create mode 100644 hw/riscv/virt.c
 create mode 100644 include/hw/riscv/virt.h

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
new file mode 100644
index 0000000..7c6fead
--- /dev/null
+++ b/hw/riscv/virt.c
@@ -0,0 +1,364 @@
+/*
+ * QEMU RISC-V VirtIO Board
+ *
+ * Copyright (c) 2017 SiFive, Inc.
+ *
+ * RISC-V machine with 16550a UART and VirtIO MMIO
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
+#include "hw/char/serial.h"
+#include "target/riscv/cpu.h"
+#include "hw/riscv/riscv_htif.h"
+#include "hw/riscv/riscv_hart.h"
+#include "hw/riscv/sifive_plic.h"
+#include "hw/riscv/sifive_clint.h"
+#include "hw/riscv/virt.h"
+#include "chardev/char.h"
+#include "sysemu/arch_init.h"
+#include "sysemu/device_tree.h"
+#include "exec/address-spaces.h"
+#include "elf.h"
+
+static const struct MemmapEntry {
+    hwaddr base;
+    hwaddr size;
+} virt_memmap[] = {
+    [VIRT_DEBUG] =    {        0x0,      0x100 },
+    [VIRT_MROM] =     {     0x1000,     0x2000 },
+    [VIRT_CLINT] =    {  0x2000000,    0x10000 },
+    [VIRT_PLIC] =     {  0xc000000,  0x4000000 },
+    [VIRT_UART0] =    { 0x10000000,      0x100 },
+    [VIRT_VIRTIO] =   { 0x10001000,     0x1000 },
+    [VIRT_DRAM] =     { 0x80000000,        0x0 },
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
+static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
+    uint64_t mem_size, const char *cmdline)
+{
+    void *fdt;
+    int cpu;
+    uint32_t *cells;
+    char *nodename;
+    uint32_t plic_phandle, phandle = 1;
+    int i;
+
+    fdt = s->fdt = create_device_tree(&s->fdt_size);
+    if (!fdt) {
+        error_report("create_device_tree() failed");
+        exit(1);
+    }
+
+    qemu_fdt_setprop_string(fdt, "/", "model", "riscv-virtio,qemu");
+    qemu_fdt_setprop_string(fdt, "/", "compatible", "riscv-virtio");
+    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
+
+    qemu_fdt_add_subnode(fdt, "/soc");
+    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
+    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "riscv-virtio-soc");
+    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
+    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
+
+    nodename = g_strdup_printf("/memory@%lx",
+        (long)memmap[VIRT_DRAM].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        memmap[VIRT_DRAM].base >> 32, memmap[VIRT_DRAM].base,
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
+        int cpu_phandle = phandle++;
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
+        qemu_fdt_setprop_cell(fdt, intc, "phandle", cpu_phandle);
+        qemu_fdt_setprop_cell(fdt, intc, "linux,phandle", cpu_phandle);
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
+        (long)memmap[VIRT_CLINT].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,clint0");
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[VIRT_CLINT].base,
+        0x0, memmap[VIRT_CLINT].size);
+    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
+        cells, s->soc.num_harts * sizeof(uint32_t) * 4);
+    g_free(cells);
+    g_free(nodename);
+
+    plic_phandle = phandle++;
+    cells =  g_new0(uint32_t, s->soc.num_harts * 4);
+    for (cpu = 0; cpu < s->soc.num_harts; cpu++) {
+        nodename =
+            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
+        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
+        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
+        cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
+        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
+        cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
+        g_free(nodename);
+    }
+    nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
+        (long)memmap[VIRT_PLIC].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 1);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv,plic0");
+    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
+        cells, s->soc.num_harts * sizeof(uint32_t) * 4);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[VIRT_PLIC].base,
+        0x0, memmap[VIRT_PLIC].size);
+    qemu_fdt_setprop_string(fdt, nodename, "reg-names", "control");
+    qemu_fdt_setprop_cell(fdt, nodename, "riscv,max-priority", 7);
+    qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", VIRTIO_NDEV);
+    qemu_fdt_setprop_cells(fdt, nodename, "phandle", plic_phandle);
+    qemu_fdt_setprop_cells(fdt, nodename, "linux,phandle", plic_phandle);
+    plic_phandle = qemu_fdt_get_phandle(fdt, nodename);
+    g_free(cells);
+    g_free(nodename);
+
+    for (i = 0; i < VIRTIO_COUNT; i++) {
+        nodename = g_strdup_printf("/virtio_mmio@%lx",
+            (long)(memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size));
+        qemu_fdt_add_subnode(fdt, nodename);
+        qemu_fdt_setprop_string(fdt, nodename, "compatible", "virtio,mmio");
+        qemu_fdt_setprop_cells(fdt, nodename, "reg",
+            0x0, memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size,
+            0x0, memmap[VIRT_VIRTIO].size);
+        qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle);
+        qemu_fdt_setprop_cells(fdt, nodename, "interrupts", VIRTIO_IRQ + i);
+        g_free(nodename);
+    }
+
+    nodename = g_strdup_printf("/uart@%lx",
+        (long)memmap[VIRT_UART0].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "ns16550a");
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[VIRT_UART0].base,
+        0x0, memmap[VIRT_UART0].size);
+    qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", 3686400);
+        qemu_fdt_setprop_cells(fdt, nodename, "interrupt-parent", plic_phandle);
+        qemu_fdt_setprop_cells(fdt, nodename, "interrupts", UART0_IRQ);
+
+    qemu_fdt_add_subnode(fdt, "/chosen");
+    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
+    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
+    g_free(nodename);
+}
+
+static void riscv_virt_board_init(MachineState *machine)
+{
+    const struct MemmapEntry *memmap = virt_memmap;
+
+    RISCVVirtState *s = g_new0(RISCVVirtState, 1);
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *main_mem = g_new(MemoryRegion, 1);
+    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
+    char *plic_hart_config;
+    size_t plic_hart_config_len;
+    int i;
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
+    memory_region_init_ram(main_mem, NULL, "riscv_virt_board.ram",
+                           machine->ram_size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[VIRT_DRAM].base,
+        main_mem);
+
+    /* create device tree */
+    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
+
+    /* boot rom */
+    memory_region_init_ram(boot_rom, NULL, "riscv_virt_board.bootrom",
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
+        memmap[VIRT_DRAM].base,      /* start: .dword memmap[VIRT_DRAM].base */
+        0x00000000,
+                                     /* dtb: */
+    };
+
+    /* copy in the reset vector */
+    cpu_physical_memory_write(ROM_BASE, reset_vec, sizeof(reset_vec));
+
+    /* copy in the device tree */
+    qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
+    cpu_physical_memory_write(ROM_BASE + sizeof(reset_vec),
+        s->fdt, s->fdt_size);
+
+    /* create PLIC hart topology configuration string */
+    plic_hart_config_len = (strlen(VIRT_PLIC_HART_CONFIG) + 1) * smp_cpus;
+    plic_hart_config = g_malloc0(plic_hart_config_len);
+    for (i = 0; i < smp_cpus; i++) {
+        if (i != 0) {
+            strncat(plic_hart_config, ",", plic_hart_config_len);
+        }
+        strncat(plic_hart_config, VIRT_PLIC_HART_CONFIG, plic_hart_config_len);
+        plic_hart_config_len -= (strlen(VIRT_PLIC_HART_CONFIG) + 1);
+    }
+
+    /* MMIO */
+    s->plic = sifive_plic_create(memmap[VIRT_PLIC].base,
+        plic_hart_config,
+        VIRT_PLIC_NUM_SOURCES,
+        VIRT_PLIC_NUM_PRIORITIES,
+        VIRT_PLIC_PRIORITY_BASE,
+        VIRT_PLIC_PENDING_BASE,
+        VIRT_PLIC_ENABLE_BASE,
+        VIRT_PLIC_ENABLE_STRIDE,
+        VIRT_PLIC_CONTEXT_BASE,
+        VIRT_PLIC_CONTEXT_STRIDE,
+        memmap[VIRT_PLIC].size);
+    sifive_clint_create(memmap[VIRT_CLINT].base,
+        memmap[VIRT_CLINT].size, smp_cpus,
+        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+
+    for (i = 0; i < VIRTIO_COUNT; i++) {
+        sysbus_create_simple("virtio-mmio",
+            memmap[VIRT_VIRTIO].base + i * memmap[VIRT_VIRTIO].size,
+            SIFIVE_PLIC(s->plic)->irqs[VIRTIO_IRQ + i]);
+    }
+
+    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
+        0, SIFIVE_PLIC(s->plic)->irqs[UART0_IRQ], 399193,
+        serial_hds[0], DEVICE_LITTLE_ENDIAN);
+}
+
+static int riscv_virt_board_sysbus_device_init(SysBusDevice *sysbusdev)
+{
+    return 0;
+}
+
+static void riscv_virt_board_class_init(ObjectClass *klass, void *data)
+{
+    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
+    k->init = riscv_virt_board_sysbus_device_init;
+}
+
+static const TypeInfo riscv_virt_board_device = {
+    .name          = TYPE_RISCV_VIRT_BOARD,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RISCVVirtState),
+    .class_init    = riscv_virt_board_class_init,
+};
+
+static void riscv_virt_board_machine_init(MachineClass *mc)
+{
+    mc->desc = "RISC-V VirtIO Board (Privileged spec v1.10)";
+    mc->init = riscv_virt_board_init;
+    mc->max_cpus = 8; /* hardcoded limit in BBL */
+}
+
+DEFINE_MACHINE("virt", riscv_virt_board_machine_init)
+
+static void riscv_virt_board_register_types(void)
+{
+    type_register_static(&riscv_virt_board_device);
+}
+
+type_init(riscv_virt_board_register_types);
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
new file mode 100644
index 0000000..9e5467a
--- /dev/null
+++ b/include/hw/riscv/virt.h
@@ -0,0 +1,73 @@
+/*
+ * SiFive VirtIO Board
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
+#ifndef HW_VIRT_H
+#define HW_VIRT_H
+
+#define TYPE_RISCV_VIRT_BOARD "riscv.virt"
+#define VIRT(obj) \
+    OBJECT_CHECK(RISCVVirtState, (obj), TYPE_RISCV_VIRT_BOARD)
+
+enum { ROM_BASE = 0x1000 };
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    RISCVHartArrayState soc;
+    DeviceState *plic;
+    void *fdt;
+    int fdt_size;
+} RISCVVirtState;
+
+enum {
+    VIRT_DEBUG,
+    VIRT_MROM,
+    VIRT_CLINT,
+    VIRT_PLIC,
+    VIRT_UART0,
+    VIRT_VIRTIO,
+    VIRT_DRAM
+};
+
+
+enum {
+    UART0_IRQ = 10,
+    VIRTIO_IRQ = 1, /* 1 to 8 */
+    VIRTIO_COUNT = 8,
+    VIRTIO_NDEV = 10
+};
+
+#define VIRT_PLIC_HART_CONFIG "MS"
+#define VIRT_PLIC_NUM_SOURCES 127
+#define VIRT_PLIC_NUM_PRIORITIES 7
+#define VIRT_PLIC_PRIORITY_BASE 0x0
+#define VIRT_PLIC_PENDING_BASE 0x1000
+#define VIRT_PLIC_ENABLE_BASE 0x2000
+#define VIRT_PLIC_ENABLE_STRIDE 0x80
+#define VIRT_PLIC_CONTEXT_BASE 0x200000
+#define VIRT_PLIC_CONTEXT_STRIDE 0x1000
+
+#endif
-- 
2.7.0
