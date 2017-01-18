Received: from eggs.gnu.org ([2001:4830:134:3::10]:46887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cTyIy-0004vX-Jq
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cTyIw-0001jy-32
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:02:08 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:33108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1cTyIv-0001iZ-N7
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:02:06 -0500
From: Marek Vasut <marex@denx.de>
Date: Wed, 18 Jan 2017 23:01:45 +0100
Message-Id: <20170118220146.489-7-marex@denx.de>
In-Reply-To: <20170118220146.489-1-marex@denx.de>
References: <20170118220146.489-1-marex@denx.de>
Subject: [Qemu-devel] [PATCH V6 6/7] nios2: Add Altera 10M50 GHRD emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>, Jeff Da Silva <jdasilva@altera.com>, Ley Foon Tan <lftan@altera.com>, Sandra Loosemore <sandra@codesourcery.com>, Yves Vandervennet <yvanderv@altera.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

Add the Altera 10M50 Nios2 GHRD model. This allows emulating the
10M50 development kit with the Nios2 GHRD loaded in the FPGA. It
is possible to boot Linux kernel and run userspace, thus far only
from initrd as storage support is not yet implemented.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Wulff <crwulff@gmail.com>
Cc: Jeff Da Silva <jdasilva@altera.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Sandra Loosemore <sandra@codesourcery.com>
Cc: Yves Vandervennet <yvanderv@altera.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Richard Henderson <rth@twiddle.net>
Reviewed-by: Alexander Graf <agraf@suse.de>
---
V3: Checkpatch cleanup, move cpu_pic.c here
V4: Add initrd DT address translation (thanks Guenter)
V5: Rebase on top of qemu/master
V6: Rebase on top of qemu/master
---
 hw/nios2/10m50_devboard.c | 126 ++++++++++++++++++++++++++
 hw/nios2/Makefile.objs    |   1 +
 hw/nios2/boot.c           | 223 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/nios2/boot.h           |  11 +++
 hw/nios2/cpu_pic.c        |  70 +++++++++++++++
 5 files changed, 431 insertions(+)
 create mode 100644 hw/nios2/10m50_devboard.c
 create mode 100644 hw/nios2/Makefile.objs
 create mode 100644 hw/nios2/boot.c
 create mode 100644 hw/nios2/boot.h
 create mode 100644 hw/nios2/cpu_pic.c

diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
new file mode 100644
index 0000000000..62e5738b65
--- /dev/null
+++ b/hw/nios2/10m50_devboard.c
@@ -0,0 +1,126 @@
+/*
+ * Altera 10M50 Nios2 GHRD
+ *
+ * Copyright (c) 2016 Marek Vasut <marek.vasut@gmail.com>
+ *
+ * Based on LabX device code
+ *
+ * Copyright (c) 2012 Chris Wulff <crwulff@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "cpu.h"
+
+#include "hw/sysbus.h"
+#include "hw/hw.h"
+#include "hw/char/serial.h"
+#include "sysemu/sysemu.h"
+#include "hw/boards.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "qemu/config-file.h"
+
+#include "boot.h"
+
+#define BINARY_DEVICE_TREE_FILE    "10m50-devboard.dtb"
+
+static void nios2_10m50_ghrd_init(MachineState *machine)
+{
+    Nios2CPU *cpu;
+    DeviceState *dev;
+    MemoryRegion *address_space_mem = get_system_memory();
+    MemoryRegion *phys_tcm = g_new(MemoryRegion, 1);
+    MemoryRegion *phys_tcm_alias = g_new(MemoryRegion, 1);
+    MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
+    MemoryRegion *phys_ram_alias = g_new(MemoryRegion, 1);
+    ram_addr_t tcm_base = 0x0;
+    ram_addr_t tcm_size = 0x1000;    /* 1 kiB, but QEMU limit is 4 kiB */
+    ram_addr_t ram_base = 0x08000000;
+    ram_addr_t ram_size = 0x08000000;
+    qemu_irq *cpu_irq, irq[32];
+    int i;
+
+    /* Physical TCM (tb_ram_1k) with alias at 0xc0000000 */
+    memory_region_init_ram(phys_tcm, NULL, "nios2.tcm", tcm_size, &error_abort);
+    memory_region_init_alias(phys_tcm_alias, NULL, "nios2.tcm.alias",
+                             phys_tcm, 0, tcm_size);
+    vmstate_register_ram_global(phys_tcm);
+    memory_region_add_subregion(address_space_mem, tcm_base, phys_tcm);
+    memory_region_add_subregion(address_space_mem, 0xc0000000 + tcm_base,
+                                phys_tcm_alias);
+
+    /* Physical DRAM with alias at 0xc0000000 */
+    memory_region_init_ram(phys_ram, NULL, "nios2.ram", ram_size, &error_abort);
+    memory_region_init_alias(phys_ram_alias, NULL, "nios2.ram.alias",
+                             phys_ram, 0, ram_size);
+    vmstate_register_ram_global(phys_ram);
+    memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
+    memory_region_add_subregion(address_space_mem, 0xc0000000 + ram_base,
+                                phys_ram_alias);
+
+    /* Create CPU -- FIXME */
+    cpu = cpu_nios2_init("nios2");
+
+    /* Register: CPU interrupt controller (PIC) */
+    cpu_irq = nios2_cpu_pic_init(cpu);
+
+    /* Register: Internal Interrupt Controller (IIC) */
+    dev = qdev_create(NULL, "altera,iic");
+    qdev_prop_set_ptr(dev, "cpu", cpu);
+    qdev_init_nofail(dev);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irq[0]);
+    for (i = 0; i < 32; i++) {
+        irq[i] = qdev_get_gpio_in(dev, i);
+    }
+
+    /* Register: Altera 16550 UART */
+    serial_mm_init(address_space_mem, 0xf8001600, 2, irq[1], 115200,
+                   serial_hds[0], DEVICE_NATIVE_ENDIAN);
+
+    /* Register: Timer sys_clk_timer  */
+    dev = qdev_create(NULL, "ALTR.timer");
+    qdev_prop_set_uint32(dev, "clock-frequency", 75 * 1000000);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xf8001440);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[0]);
+
+    /* Register: Timer sys_clk_timer_1  */
+    dev = qdev_create(NULL, "ALTR.timer");
+    qdev_prop_set_uint32(dev, "clock-frequency", 75 * 1000000);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xe0000880);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[5]);
+
+    /* Configure new exception vectors and reset CPU for it to take effect. */
+    cpu->reset_addr = 0xd4000000;
+    cpu->exception_addr = 0xc8000120;
+    cpu->fast_tlb_miss_addr = 0xc0000100;
+
+    nios2_load_kernel(cpu, ram_base, ram_size, machine->initrd_filename,
+                      BINARY_DEVICE_TREE_FILE, NULL);
+}
+
+static void nios2_10m50_ghrd_machine_init(struct MachineClass *mc)
+{
+    mc->desc = "Altera 10M50 GHRD Nios II design";
+    mc->init = nios2_10m50_ghrd_init;
+    mc->is_default = 1;
+}
+
+DEFINE_MACHINE("10m50-ghrd", nios2_10m50_ghrd_machine_init);
diff --git a/hw/nios2/Makefile.objs b/hw/nios2/Makefile.objs
new file mode 100644
index 0000000000..6b5c421760
--- /dev/null
+++ b/hw/nios2/Makefile.objs
@@ -0,0 +1 @@
+obj-y = boot.o cpu_pic.o 10m50_devboard.o
diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
new file mode 100644
index 0000000000..e0a9aff2f4
--- /dev/null
+++ b/hw/nios2/boot.c
@@ -0,0 +1,223 @@
+/*
+ * Nios2 kernel loader
+ *
+ * Copyright (c) 2016 Marek Vasut <marek.vasut@gmail.com>
+ *
+ * Based on microblaze kernel loader
+ *
+ * Copyright (c) 2012 Peter Crosthwaite <peter.crosthwaite@petalogix.com>
+ * Copyright (c) 2012 PetaLogix
+ * Copyright (c) 2009 Edgar E. Iglesias.
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
+#include "qemu-common.h"
+#include "cpu.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
+#include "qemu/error-report.h"
+#include "qemu-common.h"
+#include "sysemu/device_tree.h"
+#include "sysemu/sysemu.h"
+#include "hw/loader.h"
+#include "elf.h"
+#include "qemu/cutils.h"
+
+#include "boot.h"
+
+#define NIOS2_MAGIC    0x534f494e
+
+static struct nios2_boot_info {
+    void (*machine_cpu_reset)(Nios2CPU *);
+    uint32_t bootstrap_pc;
+    uint32_t cmdline;
+    uint32_t initrd_start;
+    uint32_t initrd_end;
+    uint32_t fdt;
+} boot_info;
+
+static void main_cpu_reset(void *opaque)
+{
+    Nios2CPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+    CPUNios2State *env = &cpu->env;
+
+    cpu_reset(CPU(cpu));
+
+    env->regs[R_ARG0] = NIOS2_MAGIC;
+    env->regs[R_ARG1] = boot_info.initrd_start;
+    env->regs[R_ARG2] = boot_info.fdt;
+    env->regs[R_ARG3] = boot_info.cmdline;
+
+    cpu_set_pc(cs, boot_info.bootstrap_pc);
+    if (boot_info.machine_cpu_reset) {
+        boot_info.machine_cpu_reset(cpu);
+    }
+}
+
+static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
+{
+    return addr - 0xc0000000LL;
+}
+
+static int nios2_load_dtb(struct nios2_boot_info bi, const uint32_t ramsize,
+                          const char *kernel_cmdline, const char *dtb_filename)
+{
+    int fdt_size;
+    void *fdt = NULL;
+    int r;
+
+    if (dtb_filename) {
+        fdt = load_device_tree(dtb_filename, &fdt_size);
+    }
+    if (!fdt) {
+        return 0;
+    }
+
+    if (kernel_cmdline) {
+        r = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
+                                    kernel_cmdline);
+        if (r < 0) {
+            fprintf(stderr, "couldn't set /chosen/bootargs\n");
+        }
+    }
+
+    if (bi.initrd_start) {
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
+                              translate_kernel_address(NULL, bi.initrd_start));
+
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+                              translate_kernel_address(NULL, bi.initrd_end));
+    }
+
+    cpu_physical_memory_write(bi.fdt, fdt, fdt_size);
+    return fdt_size;
+}
+
+void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
+                            uint32_t ramsize,
+                            const char *initrd_filename,
+                            const char *dtb_filename,
+                            void (*machine_cpu_reset)(Nios2CPU *))
+{
+    QemuOpts *machine_opts;
+    const char *kernel_filename;
+    const char *kernel_cmdline;
+    const char *dtb_arg;
+    char *filename = NULL;
+
+    machine_opts = qemu_get_machine_opts();
+    kernel_filename = qemu_opt_get(machine_opts, "kernel");
+    kernel_cmdline = qemu_opt_get(machine_opts, "append");
+    dtb_arg = qemu_opt_get(machine_opts, "dtb");
+    /* default to pcbios dtb as passed by machine_init */
+    if (!dtb_arg) {
+        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, dtb_filename);
+    }
+
+    boot_info.machine_cpu_reset = machine_cpu_reset;
+    qemu_register_reset(main_cpu_reset, cpu);
+
+    if (kernel_filename) {
+        int kernel_size, fdt_size;
+        uint64_t entry, low, high;
+        uint32_t base32;
+        int big_endian = 0;
+
+#ifdef TARGET_WORDS_BIGENDIAN
+        big_endian = 1;
+#endif
+
+        /* Boots a kernel elf binary. */
+        kernel_size = load_elf(kernel_filename, NULL, NULL,
+                               &entry, &low, &high,
+                               big_endian, EM_ALTERA_NIOS2, 0, 0);
+        base32 = entry;
+        if (base32 == 0xc0000000) {
+            kernel_size = load_elf(kernel_filename, translate_kernel_address,
+                                   NULL, &entry, NULL, NULL,
+                                   big_endian, EM_ALTERA_NIOS2, 0, 0);
+        }
+
+        /* Always boot into physical ram. */
+        boot_info.bootstrap_pc = ddr_base + 0xc0000000 + (entry & 0x07ffffff);
+
+        /* If it wasn't an ELF image, try an u-boot image. */
+        if (kernel_size < 0) {
+            hwaddr uentry, loadaddr;
+
+            kernel_size = load_uimage(kernel_filename, &uentry, &loadaddr, 0,
+                                      NULL, NULL);
+            boot_info.bootstrap_pc = uentry;
+            high = loadaddr + kernel_size;
+        }
+
+        /* Not an ELF image nor an u-boot image, try a RAW image. */
+        if (kernel_size < 0) {
+            kernel_size = load_image_targphys(kernel_filename, ddr_base,
+                                              ram_size);
+            boot_info.bootstrap_pc = ddr_base;
+            high = ddr_base + kernel_size;
+        }
+
+        high = ROUND_UP(high, 1024 * 1024);
+
+        /* If initrd is available, it goes after the kernel, aligned to 1M. */
+        if (initrd_filename) {
+            int initrd_size;
+            uint32_t initrd_offset;
+
+            boot_info.initrd_start = high;
+            initrd_offset = boot_info.initrd_start - ddr_base;
+
+            initrd_size = load_ramdisk(initrd_filename,
+                                       boot_info.initrd_start,
+                                       ram_size - initrd_offset);
+            if (initrd_size < 0) {
+                initrd_size = load_image_targphys(initrd_filename,
+                                                  boot_info.initrd_start,
+                                                  ram_size - initrd_offset);
+            }
+            if (initrd_size < 0) {
+                error_report("qemu: could not load initrd '%s'",
+                             initrd_filename);
+                exit(EXIT_FAILURE);
+            }
+            high += initrd_size;
+        }
+        high = ROUND_UP(high, 4);
+        boot_info.initrd_end = high;
+
+        /* Device tree must be placed right after initrd (if available) */
+        boot_info.fdt = high;
+        fdt_size = nios2_load_dtb(boot_info, ram_size, kernel_cmdline,
+                                  /* Preference a -dtb argument */
+                                  dtb_arg ? dtb_arg : filename);
+        high += fdt_size;
+
+        /* Kernel command is at the end, 4k aligned. */
+        boot_info.cmdline = ROUND_UP(high, 4096);
+        if (kernel_cmdline && strlen(kernel_cmdline)) {
+            pstrcpy_targphys("cmdline", boot_info.cmdline, 256, kernel_cmdline);
+        }
+    }
+    g_free(filename);
+}
diff --git a/hw/nios2/boot.h b/hw/nios2/boot.h
new file mode 100644
index 0000000000..3116753818
--- /dev/null
+++ b/hw/nios2/boot.h
@@ -0,0 +1,11 @@
+#ifndef NIOS2_BOOT_H
+#define NIOS2_BOOT_H
+
+#include "hw/hw.h"
+#include "cpu.h"
+
+void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base, uint32_t ramsize,
+                       const char *initrd_filename, const char *dtb_filename,
+                       void (*machine_cpu_reset)(Nios2CPU *));
+
+#endif /* NIOS2_BOOT_H */
diff --git a/hw/nios2/cpu_pic.c b/hw/nios2/cpu_pic.c
new file mode 100644
index 0000000000..0f95987ef3
--- /dev/null
+++ b/hw/nios2/cpu_pic.c
@@ -0,0 +1,70 @@
+/*
+ * Altera Nios2 CPU PIC
+ *
+ * Copyright (c) 2016 Marek Vasut <marek.vasut@gmail.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "cpu.h"
+
+#include "qemu/config-file.h"
+
+#include "boot.h"
+
+static void nios2_pic_cpu_handler(void *opaque, int irq, int level)
+{
+    Nios2CPU *cpu = opaque;
+    CPUNios2State *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+    int type = irq ? CPU_INTERRUPT_NMI : CPU_INTERRUPT_HARD;
+
+    if (type == CPU_INTERRUPT_HARD) {
+        env->irq_pending = level;
+
+        if (level && (env->regs[CR_STATUS] & CR_STATUS_PIE)) {
+            env->irq_pending = 0;
+            cpu_interrupt(cs, type);
+        } else if (!level) {
+            env->irq_pending = 0;
+            cpu_reset_interrupt(cs, type);
+        }
+    } else {
+        if (level) {
+            cpu_interrupt(cs, type);
+        } else {
+            cpu_reset_interrupt(cs, type);
+        }
+    }
+}
+
+void nios2_check_interrupts(CPUNios2State *env)
+{
+    Nios2CPU *cpu = nios2_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+
+    if (env->irq_pending) {
+        env->irq_pending = 0;
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    }
+}
+
+qemu_irq *nios2_cpu_pic_init(Nios2CPU *cpu)
+{
+    return qemu_allocate_irqs(nios2_pic_cpu_handler, cpu, 2);
+}
-- 
2.11.0
