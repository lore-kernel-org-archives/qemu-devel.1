Received: from eggs.gnu.org ([2001:4830:134:3::10]:42861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fp1Ay-0002t6-PE
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 20:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1fp1Au-0006DD-Mo
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 20:57:40 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:47825)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1fp1Au-0006Cy-GM
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 20:57:36 -0400
From: Julian Brown <julian@codesourcery.com>
Date: Sun, 12 Aug 2018 17:57:13 -0700
Message-ID: <8bd30e5cb32ea56528ccade24258067c80bfb4f4.1534121196.git.julian@codesourcery.com>
In-Reply-To: <cover.1534121196.git.julian@codesourcery.com>
References: <cover.1534121196.git.julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 1/2] Add generic Nios II board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andrew Jenner <Andrew_Jenner@mentor.com>, Sandra Loosemore <sandra@codesourcery.com>, Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>

This patch adds support for a generic MMU-less Nios II board that can
be used e.g. for bare-metal compiler testing.  Nios II booting is also
tweaked so that bare-metal binaries start executing in RAM starting at
0x00000000, rather than an alias at 0xc0000000, which allows features
such as unwinding to work when binaries are linked to start at the
beginning of the address space.

The generic_nommu.c parts are by Andrew Jenner, based on code by Marek
Vasut.

Originally by Marek Vasut and Andrew Jenner.

Signed-off-by: Julian Brown <julian@codesourcery.com>
Signed-off-by: Andrew Jenner <andrew@codesourcery.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
 hw/nios2/Makefile.objs   |   2 +-
 hw/nios2/boot.c          |   5 +-
 hw/nios2/generic_nommu.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 2 deletions(-)
 create mode 100644 hw/nios2/generic_nommu.c

diff --git a/hw/nios2/Makefile.objs b/hw/nios2/Makefile.objs
index 6b5c421..680caaa 100644
--- a/hw/nios2/Makefile.objs
+++ b/hw/nios2/Makefile.objs
@@ -1 +1 @@
-obj-y = boot.o cpu_pic.o 10m50_devboard.o
+obj-y = boot.o cpu_pic.o 10m50_devboard.o generic_nommu.o
diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index 4bb5b60..a027c11 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -140,6 +140,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
         uint64_t entry, low, high;
         uint32_t base32;
         int big_endian = 0;
+        int kernel_space = 0;
 
 #ifdef TARGET_WORDS_BIGENDIAN
         big_endian = 1;
@@ -154,10 +155,12 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
             kernel_size = load_elf(kernel_filename, translate_kernel_address,
                                    NULL, &entry, NULL, NULL,
                                    big_endian, EM_ALTERA_NIOS2, 0, 0);
+            kernel_space = 1;
         }
 
         /* Always boot into physical ram. */
-        boot_info.bootstrap_pc = ddr_base + 0xc0000000 + (entry & 0x07ffffff);
+        boot_info.bootstrap_pc = ddr_base + (kernel_space ? 0xc0000000 : 0)
+                                 + (entry & 0x07ffffff);
 
         /* If it wasn't an ELF image, try an u-boot image. */
         if (kernel_size < 0) {
diff --git a/hw/nios2/generic_nommu.c b/hw/nios2/generic_nommu.c
new file mode 100644
index 0000000..f4bbc6e
--- /dev/null
+++ b/hw/nios2/generic_nommu.c
@@ -0,0 +1,128 @@
+/*
+ * Generic simulator target with no MMU
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
+#define BINARY_DEVICE_TREE_FILE    "generic-nommu.dtb"
+
+static void nios2_generic_nommu_init(MachineState *machine)
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
+    ram_addr_t ram_base = 0x10000000;
+    ram_addr_t ram_size = 0x08000000;
+    qemu_irq *cpu_irq, irq[32];
+    int i;
+
+    /* Physical TCM (tb_ram_1k) with alias at 0xc0000000 */
+    memory_region_init_ram(phys_tcm, NULL, "nios2.tcm", tcm_size,
+                           &error_abort);
+    memory_region_init_alias(phys_tcm_alias, NULL, "nios2.tcm.alias",
+                             phys_tcm, 0, tcm_size);
+    memory_region_add_subregion(address_space_mem, tcm_base, phys_tcm);
+    memory_region_add_subregion(address_space_mem, 0xc0000000 + tcm_base,
+                                phys_tcm_alias);
+
+    /* Physical DRAM with alias at 0xc0000000 */
+    memory_region_init_ram(phys_ram, NULL, "nios2.ram", ram_size,
+                           &error_abort);
+    memory_region_init_alias(phys_ram_alias, NULL, "nios2.ram.alias",
+                             phys_ram, 0, ram_size);
+    memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
+    memory_region_add_subregion(address_space_mem, 0xc0000000 + ram_base,
+                                phys_ram_alias);
+
+    cpu = NIOS2_CPU(cpu_create(TYPE_NIOS2_CPU));
+
+    /* Remove MMU */
+    cpu->mmu_present = false;
+
+    /* Register: CPU interrupt controller (PIC) */
+    cpu_irq = nios2_cpu_pic_init(cpu);
+
+    /* Register: Internal Interrupt Controller (IIC) */
+    dev = qdev_create(NULL, "altera,iic");
+    object_property_add_const_link(OBJECT(dev), "cpu", OBJECT(cpu),
+                                   &error_abort);
+    qdev_init_nofail(dev);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irq[0]);
+    for (i = 0; i < 32; i++) {
+        irq[i] = qdev_get_gpio_in(dev, i);
+    }
+
+    /* Register: Altera 16550 UART */
+    serial_mm_init(address_space_mem, 0xf8001600, 2, irq[1], 115200,
+                   serial_hd(0), DEVICE_NATIVE_ENDIAN);
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
+    cpu->reset_addr = 0xd0000000;
+    cpu->exception_addr = 0xc8000120;
+    cpu->fast_tlb_miss_addr = 0x7fff400;
+
+    nios2_load_kernel(cpu, ram_base, ram_size, machine->initrd_filename,
+                      BINARY_DEVICE_TREE_FILE, NULL);
+}
+
+static void nios2_generic_nommu_machine_init(struct MachineClass *mc)
+{
+    mc->desc = "Generic NOMMU Nios II design";
+    mc->init = nios2_generic_nommu_init;
+}
+
+DEFINE_MACHINE("nios2-generic-nommu", nios2_generic_nommu_machine_init);
-- 
2.8.1
