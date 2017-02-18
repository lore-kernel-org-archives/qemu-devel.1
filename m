Received: from eggs.gnu.org ([2001:4830:134:3::10]:54188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cfEk7-0001s5-S7
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 18:48:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cfEk5-0007CD-3Q
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 18:48:43 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cfEk4-0007Bw-T6
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 18:48:41 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so8448101wmi.1
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 15:48:40 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
Date: Sun, 19 Feb 2017 00:48:31 +0100
Message-Id: <1487461713-23092-2-git-send-email-huth@tuxfamily.org>
In-Reply-To: <1487461713-23092-1-git-send-email-huth@tuxfamily.org>
References: <1487461713-23092-1-git-send-email-huth@tuxfamily.org>
Subject: [Qemu-devel] [PULL 1/3] hw/m68k: Remove dummy machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Since it is now possible to instantiate a CPU and RAM with the "none"
machine, too, and a kernel can be loaded there with the generic loader
device, there is no more need for the m68k "dummy" machine. Thus let's
remove this unmaintained file now.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 MAINTAINERS           |  4 ---
 hw/m68k/Makefile.objs |  2 --
 hw/m68k/dummy_m68k.c  | 84 ---------------------------------------------------
 3 files changed, 90 deletions(-)
 delete mode 100644 hw/m68k/dummy_m68k.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fb57d8e..3efe7c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -565,10 +565,6 @@ S: Orphan
 F: hw/m68k/an5206.c
 F: hw/m68k/mcf5206.c
 
-dummy_m68k
-S: Orphan
-F: hw/m68k/dummy_m68k.c
-
 mcf5208
 S: Orphan
 F: hw/m68k/mcf5208.c
diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
index c4352e7..d1f089c 100644
--- a/hw/m68k/Makefile.objs
+++ b/hw/m68k/Makefile.objs
@@ -1,4 +1,2 @@
 obj-y += an5206.o mcf5208.o
-obj-y += dummy_m68k.o
-
 obj-y += mcf5206.o mcf_intc.o
diff --git a/hw/m68k/dummy_m68k.c b/hw/m68k/dummy_m68k.c
deleted file mode 100644
index 0b11d20..0000000
--- a/hw/m68k/dummy_m68k.c
+++ /dev/null
@@ -1,84 +0,0 @@
-/*
- * Dummy board with just RAM and CPU for use as an ISS.
- *
- * Copyright (c) 2007 CodeSourcery.
- *
- * This code is licensed under the GPL
- */
-
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "cpu.h"
-#include "hw/hw.h"
-#include "hw/boards.h"
-#include "hw/loader.h"
-#include "elf.h"
-#include "exec/address-spaces.h"
-
-#define KERNEL_LOAD_ADDR 0x10000
-
-/* Board init.  */
-
-static void dummy_m68k_init(MachineState *machine)
-{
-    ram_addr_t ram_size = machine->ram_size;
-    const char *cpu_model = machine->cpu_model;
-    const char *kernel_filename = machine->kernel_filename;
-    M68kCPU *cpu;
-    CPUM68KState *env;
-    MemoryRegion *address_space_mem =  get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
-    int kernel_size;
-    uint64_t elf_entry;
-    hwaddr entry;
-
-    if (!cpu_model)
-        cpu_model = "cfv4e";
-    cpu = cpu_m68k_init(cpu_model);
-    if (!cpu) {
-        fprintf(stderr, "Unable to find m68k CPU definition\n");
-        exit(1);
-    }
-    env = &cpu->env;
-
-    /* Initialize CPU registers.  */
-    env->vbr = 0;
-
-    /* RAM at address zero */
-    memory_region_allocate_system_memory(ram, NULL, "dummy_m68k.ram",
-                                         ram_size);
-    memory_region_add_subregion(address_space_mem, 0, ram);
-
-    /* Load kernel.  */
-    if (kernel_filename) {
-        kernel_size = load_elf(kernel_filename, NULL, NULL, &elf_entry,
-                               NULL, NULL, 1, EM_68K, 0, 0);
-        entry = elf_entry;
-        if (kernel_size < 0) {
-            kernel_size = load_uimage(kernel_filename, &entry, NULL, NULL,
-                                      NULL, NULL);
-        }
-        if (kernel_size < 0) {
-            kernel_size = load_image_targphys(kernel_filename,
-                                              KERNEL_LOAD_ADDR,
-                                              ram_size - KERNEL_LOAD_ADDR);
-            entry = KERNEL_LOAD_ADDR;
-        }
-        if (kernel_size < 0) {
-            fprintf(stderr, "qemu: could not load kernel '%s'\n",
-                    kernel_filename);
-            exit(1);
-        }
-    } else {
-        entry = 0;
-    }
-    env->pc = entry;
-}
-
-static void dummy_m68k_machine_init(MachineClass *mc)
-{
-    mc->desc = "Dummy board";
-    mc->init = dummy_m68k_init;
-}
-
-DEFINE_MACHINE("dummy", dummy_m68k_machine_init)
-- 
2.7.4
