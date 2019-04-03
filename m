Received: from eggs.gnu.org ([209.51.188.92]:46158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1hBlwy-0003HV-R1
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 15:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1hBlww-0001l4-PL
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 15:53:32 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:43846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
	id 1hBlwr-0001Vl-1d
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 15:53:27 -0400
From: Sandra Loosemore <sandra@codesourcery.com>
Date: Wed, 3 Apr 2019 13:53:04 -0600
Message-ID: <1554321185-2825-2-git-send-email-sandra@codesourcery.com>
In-Reply-To: <1554321185-2825-1-git-send-email-sandra@codesourcery.com>
References: <1554321185-2825-1-git-send-email-sandra@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 1/2] Add generic Nios II board.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: crwulff@gmail.com, marex@denx.de, peter.maydell@linaro.org

This patch adds support for a generic MMU-less Nios II board that can
be used e.g. for bare-metal compiler testing with the linker script
and startup code provided by libgloss.  Nios II booting is also
tweaked so that bare-metal binaries start executing in RAM starting at
0x00000000, rather than an alias at 0xc0000000, which allows features
such as unwinding to work when binaries are linked to start at the
beginning of the address space.

The generic_nommu.c parts are based on code by Andrew Jenner, which was
in turn based on code by Marek Vasut.

Originally by Marek Vasut and Andrew Jenner.

Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
Signed-off-by: Julian Brown <julian@codesourcery.com>
Signed-off-by: Andrew Jenner <andrew@codesourcery.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
 default-configs/nios2-softmmu.mak |   1 +
 hw/nios2/Kconfig                  |   4 ++
 hw/nios2/Makefile.objs            |   1 +
 hw/nios2/boot.c                   |  18 ++++---
 hw/nios2/generic_nommu.c          | 105 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 123 insertions(+), 6 deletions(-)
 create mode 100644 hw/nios2/generic_nommu.c

diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-softmmu.mak
index e11dc54..e130d02 100644
--- a/default-configs/nios2-softmmu.mak
+++ b/default-configs/nios2-softmmu.mak
@@ -3,3 +3,4 @@
 # Boards:
 #
 CONFIG_NIOS2_10M50=y
+CONFIG_NIOS2_GENERIC_NOMMU=y
diff --git a/hw/nios2/Kconfig b/hw/nios2/Kconfig
index ab953e0..b10ea64 100644
--- a/hw/nios2/Kconfig
+++ b/hw/nios2/Kconfig
@@ -4,5 +4,9 @@ config NIOS2_10M50
     select SERIAL
     select ALTERA_TIMER
 
+config NIOS2_GENERIC_NOMMU
+    bool
+    select NIOS2
+
 config NIOS2
     bool
diff --git a/hw/nios2/Makefile.objs b/hw/nios2/Makefile.objs
index 89a419a..3e01798 100644
--- a/hw/nios2/Makefile.objs
+++ b/hw/nios2/Makefile.objs
@@ -1,2 +1,3 @@
 obj-y = boot.o cpu_pic.o
 obj-$(CONFIG_NIOS2_10M50) += 10m50_devboard.o
+obj-$(CONFIG_NIOS2_GENERIC_NOMMU) += generic_nommu.o
diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index 5f0ab2f..276068c 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -138,7 +138,6 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
     if (kernel_filename) {
         int kernel_size, fdt_size;
         uint64_t entry, low, high;
-        uint32_t base32;
         int big_endian = 0;
 
 #ifdef TARGET_WORDS_BIGENDIAN
@@ -149,17 +148,24 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
                                &entry, &low, &high,
                                big_endian, EM_ALTERA_NIOS2, 0, 0);
-        base32 = entry;
-        if (base32 == 0xc0000000) {
+        if ((uint32_t)entry == 0xc0000000) {
+            /*
+             * The Nios II processor reference guide documents that the
+             * kernel is placed at virtual memory address 0xc0000000,
+             * and we've got something that points there.  Reload it
+             * and adjust the entry to get the address in physical RAM.
+             */
             kernel_size = load_elf(kernel_filename, NULL,
                                    translate_kernel_address, NULL,
                                    &entry, NULL, NULL,
                                    big_endian, EM_ALTERA_NIOS2, 0, 0);
+            boot_info.bootstrap_pc = ddr_base + 0xc0000000 +
+                (entry & 0x07ffffff);
+        } else {
+            /* Use the entry point in the ELF image.  */
+            boot_info.bootstrap_pc = (uint32_t)entry;
         }
 
-        /* Always boot into physical ram. */
-        boot_info.bootstrap_pc = ddr_base + 0xc0000000 + (entry & 0x07ffffff);
-
         /* If it wasn't an ELF image, try an u-boot image. */
         if (kernel_size < 0) {
             hwaddr uentry, loadaddr = LOAD_UIMAGE_LOADADDR_INVALID;
diff --git a/hw/nios2/generic_nommu.c b/hw/nios2/generic_nommu.c
new file mode 100644
index 0000000..1788ffa
--- /dev/null
+++ b/hw/nios2/generic_nommu.c
@@ -0,0 +1,105 @@
+/*
+ * Generic simulator target with no MMU or devices.  This emulation is
+ * compatible with the libgloss qemu-hosted.ld linker script for using
+ * QEMU as an instruction set simulator.
+ *
+ * Copyright (c) 2018-2019 Mentor Graphics
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
+    MemoryRegion *address_space_mem = get_system_memory();
+    MemoryRegion *phys_tcm = g_new(MemoryRegion, 1);
+    MemoryRegion *phys_tcm_alias = g_new(MemoryRegion, 1);
+    MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
+    MemoryRegion *phys_ram_alias = g_new(MemoryRegion, 1);
+    ram_addr_t tcm_base = 0x0;
+    ram_addr_t tcm_size = 0x1000;    /* 1 kiB, but QEMU limit is 4 kiB */
+    ram_addr_t ram_base = 0x10000000;
+    ram_addr_t ram_size = 0x08000000;
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
+    /* Reset vector is the first 32 bytes of RAM.  */
+    cpu->reset_addr = ram_base;
+
+    /* The interrupt vector comes right after reset.  */
+    cpu->exception_addr = ram_base + 0x20;
+
+    /*
+     * The linker script does have a TLB miss memory region declared,
+     * but this should never be used with no MMU.
+     */
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
