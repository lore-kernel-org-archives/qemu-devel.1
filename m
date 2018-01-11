Received: from eggs.gnu.org ([2001:4830:134:3::10]:34555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eZk2f-0004yl-1J
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eZk2d-00005V-3r
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:05:41 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:41582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eZk2c-00004t-O6
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:05:39 -0500
Received: by mail-lf0-x243.google.com with SMTP id h137so3984447lfe.8
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 13:05:38 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 11 Jan 2018 13:04:58 -0800
Message-Id: <1515704703-10347-5-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1515704703-10347-1-git-send-email-jcmvbkbc@gmail.com>
References: <1515704703-10347-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 4/9] hw/xtensa: extract
 xtensa_create_memory_regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

XTFPGA boards should populate core memory regions the same way sim
machine does. Move xtensa_create_memory_regions implementation to a
separate file and use it to create instruction and data memory regions
on XTFPGA boards.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/Makefile.objs   |  1 +
 hw/xtensa/sim.c           | 38 +++++++++++---------------------
 hw/xtensa/xtensa_memory.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/xtensa/xtensa_memory.h | 40 +++++++++++++++++++++++++++++++++
 hw/xtensa/xtfpga.c        | 56 +++++++++++++++++++++++++++++++++--------------
 5 files changed, 148 insertions(+), 42 deletions(-)
 create mode 100644 hw/xtensa/xtensa_memory.c
 create mode 100644 hw/xtensa/xtensa_memory.h

diff --git a/hw/xtensa/Makefile.objs b/hw/xtensa/Makefile.objs
index cb77dc3793ac..cb4998d2bf34 100644
--- a/hw/xtensa/Makefile.objs
+++ b/hw/xtensa/Makefile.objs
@@ -1,3 +1,4 @@
 obj-y += pic_cpu.o
 obj-y += sim.o
+obj-y += xtensa_memory.o
 obj-y += xtfpga.o
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 2bb883b66494..5c0ba231d1fb 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -36,25 +36,7 @@
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
-
-static void xtensa_create_memory_regions(const XtensaMemory *memory,
-                                         const char *name)
-{
-    unsigned i;
-    GString *num_name = g_string_new(NULL);
-
-    for (i = 0; i < memory->num; ++i) {
-        MemoryRegion *m;
-
-        g_string_printf(num_name, "%s%u", name, i);
-        m = g_new(MemoryRegion, 1);
-        memory_region_init_ram(m, NULL, num_name->str,
-                               memory->location[i].size, &error_fatal);
-        memory_region_add_subregion(get_system_memory(),
-                                    memory->location[i].addr, m);
-    }
-    g_string_free(num_name, true);
-}
+#include "xtensa_memory.h"
 
 static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
 {
@@ -94,12 +76,18 @@ static void xtensa_sim_init(MachineState *machine)
         XtensaMemory sysram = env->config->sysram;
 
         sysram.location[0].size = ram_size;
-        xtensa_create_memory_regions(&env->config->instrom, "xtensa.instrom");
-        xtensa_create_memory_regions(&env->config->instram, "xtensa.instram");
-        xtensa_create_memory_regions(&env->config->datarom, "xtensa.datarom");
-        xtensa_create_memory_regions(&env->config->dataram, "xtensa.dataram");
-        xtensa_create_memory_regions(&env->config->sysrom, "xtensa.sysrom");
-        xtensa_create_memory_regions(&sysram, "xtensa.sysram");
+        xtensa_create_memory_regions(&env->config->instrom, "xtensa.instrom",
+                                     get_system_memory());
+        xtensa_create_memory_regions(&env->config->instram, "xtensa.instram",
+                                     get_system_memory());
+        xtensa_create_memory_regions(&env->config->datarom, "xtensa.datarom",
+                                     get_system_memory());
+        xtensa_create_memory_regions(&env->config->dataram, "xtensa.dataram",
+                                     get_system_memory());
+        xtensa_create_memory_regions(&env->config->sysrom, "xtensa.sysrom",
+                                     get_system_memory());
+        xtensa_create_memory_regions(&sysram, "xtensa.sysram",
+                                     get_system_memory());
     }
 
     if (serial_hds[0]) {
diff --git a/hw/xtensa/xtensa_memory.c b/hw/xtensa/xtensa_memory.c
new file mode 100644
index 000000000000..394967f842b7
--- /dev/null
+++ b/hw/xtensa/xtensa_memory.c
@@ -0,0 +1,55 @@
+/*
+ * Copyright (c) 2017, Max Filippov, Open Source and Linux Lab.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of the Open Source and Linux Lab nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "sysemu/sysemu.h"
+#include "hw/boards.h"
+#include "exec/memory.h"
+#include "qemu/error-report.h"
+#include "xtensa_memory.h"
+
+void xtensa_create_memory_regions(const XtensaMemory *memory,
+                                  const char *name,
+                                  MemoryRegion *super)
+{
+    unsigned i;
+    GString *num_name = g_string_new(NULL);
+
+    for (i = 0; i < memory->num; ++i) {
+        MemoryRegion *m;
+
+        g_string_printf(num_name, "%s%u", name, i);
+        m = g_new(MemoryRegion, 1);
+        memory_region_init_ram(m, NULL, num_name->str,
+                               memory->location[i].size, &error_fatal);
+        memory_region_add_subregion(super, memory->location[i].addr, m);
+    }
+    g_string_free(num_name, true);
+}
diff --git a/hw/xtensa/xtensa_memory.h b/hw/xtensa/xtensa_memory.h
new file mode 100644
index 000000000000..cab4d172d42a
--- /dev/null
+++ b/hw/xtensa/xtensa_memory.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (c) 2017, Max Filippov, Open Source and Linux Lab.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of the Open Source and Linux Lab nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef _XTENSA_MEMORY_H
+#define _XTENSA_MEMORY_H
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "exec/memory.h"
+
+void xtensa_create_memory_regions(const XtensaMemory *memory,
+                                  const char *name,
+                                  MemoryRegion *super);
+
+#endif
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index ccc1ed8d8d7f..40e16baa7c34 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -44,6 +44,7 @@
 #include "sysemu/device_tree.h"
 #include "qemu/error-report.h"
 #include "bootparam.h"
+#include "xtensa_memory.h"
 
 typedef struct XtfpgaBoardDesc {
     hwaddr flash_base;
@@ -216,7 +217,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     XtensaCPU *cpu = NULL;
     CPUXtensaState *env = NULL;
-    MemoryRegion *ram, *rom, *system_io;
+    MemoryRegion *system_io;
     DriveInfo *dinfo;
     pflash_t *flash = NULL;
     QemuOpts *machine_opts = qemu_get_machine_opts();
@@ -238,10 +239,21 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
         cpu_reset(CPU(cpu));
     }
 
-    ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram(ram, NULL, "xtfpga.dram", machine->ram_size,
-                           &error_fatal);
-    memory_region_add_subregion(system_memory, 0, ram);
+    if (env) {
+        XtensaMemory sysram = env->config->sysram;
+
+        sysram.location[0].size = machine->ram_size;
+        xtensa_create_memory_regions(&env->config->instrom, "xtensa.instrom",
+                                     system_memory);
+        xtensa_create_memory_regions(&env->config->instram, "xtensa.instram",
+                                     system_memory);
+        xtensa_create_memory_regions(&env->config->datarom, "xtensa.datarom",
+                                     system_memory);
+        xtensa_create_memory_regions(&env->config->dataram, "xtensa.dataram",
+                                     system_memory);
+        xtensa_create_memory_regions(&sysram, "xtensa.sysram",
+                                     system_memory);
+    }
 
     system_io = g_malloc(sizeof(*system_io));
     memory_region_init_io(system_io, NULL, &xtfpga_io_ops, NULL, "xtfpga.io",
@@ -269,21 +281,24 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     if (kernel_filename) {
         uint32_t entry_point = env->pc;
         size_t bp_size = 3 * get_tag_size(0); /* first/last and memory tags */
-        uint32_t tagptr = 0xfe000000 + board->sram_size;
+        uint32_t tagptr = env->config->sysrom.location[0].addr +
+            board->sram_size;
         uint32_t cur_tagptr;
         BpMemInfo memory_location = {
             .type = tswap32(MEMORY_TYPE_CONVENTIONAL),
-            .start = tswap32(0),
-            .end = tswap32(machine->ram_size),
+            .start = tswap32(env->config->sysram.location[0].addr),
+            .end = tswap32(env->config->sysram.location[0].addr +
+                           machine->ram_size),
         };
         uint32_t lowmem_end = machine->ram_size < 0x08000000 ?
             machine->ram_size : 0x08000000;
         uint32_t cur_lowmem = QEMU_ALIGN_UP(lowmem_end / 2, 4096);
 
-        rom = g_malloc(sizeof(*rom));
-        memory_region_init_ram(rom, NULL, "xtfpga.sram", board->sram_size,
-                               &error_fatal);
-        memory_region_add_subregion(system_memory, 0xfe000000, rom);
+        lowmem_end += env->config->sysram.location[0].addr;
+        cur_lowmem += env->config->sysram.location[0].addr;
+
+        xtensa_create_memory_regions(&env->config->sysrom, "xtensa.sysrom",
+                                     system_memory);
 
         if (kernel_cmdline) {
             bp_size += get_tag_size(strlen(kernel_cmdline) + 1);
@@ -404,13 +419,20 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
         if (flash) {
             MemoryRegion *flash_mr = pflash_cfi01_get_memory(flash);
             MemoryRegion *flash_io = g_malloc(sizeof(*flash_io));
+            uint32_t size = env->config->sysrom.location[0].size;
+
+            if (board->flash_size - board->flash_boot_base < size) {
+                size = board->flash_size - board->flash_boot_base;
+            }
 
             memory_region_init_alias(flash_io, NULL, "xtfpga.flash",
-                    flash_mr, board->flash_boot_base,
-                    board->flash_size - board->flash_boot_base < 0x02000000 ?
-                    board->flash_size - board->flash_boot_base : 0x02000000);
-            memory_region_add_subregion(system_memory, 0xfe000000,
-                    flash_io);
+                                     flash_mr, board->flash_boot_base, size);
+            memory_region_add_subregion(system_memory,
+                                        env->config->sysrom.location[0].addr,
+                                        flash_io);
+        } else {
+            xtensa_create_memory_regions(&env->config->sysrom, "xtensa.sysrom",
+                                         system_memory);
         }
     }
 }
-- 
2.1.4
