Received: from eggs.gnu.org ([2001:4830:134:3::10]:55564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9Q6-0003pF-OG
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eu9Q5-0006oK-Im
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:14 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:43673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eu9Q5-0006o2-C4
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 23:14:13 -0500
Received: by mail-pf0-x243.google.com with SMTP id j2so831848pff.10
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 20:14:13 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Fri,  9 Mar 2018 17:12:23 +1300
Message-Id: <1520568765-58189-2-git-send-email-mjc@sifive.com>
In-Reply-To: <1520568765-58189-1-git-send-email-mjc@sifive.com>
References: <1520568765-58189-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v2 01/23] RISC-V: Make virt create_fdt
 interface consistent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>

create_fdt sets the fdt variable on RISCVVirtState and this is
used to access the fdt. This reverts a change introduced in
https://github.com/riscv/riscv-qemu/pull/109 which introduced
a redundant return value, overlooking the RISCVVirtState
structure member that made create_fdt inconsistent with the
other RISC-V machines. The other alternative is to change
the other boards to return the fdt. Note: the RISCVVirtState
also contains fdt_size.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/virt.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e2c214e..37968d2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -108,7 +108,7 @@ static hwaddr load_initrd(const char *filename, uint64_t mem_size,
     return *start + size;
 }
 
-static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
+static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
     void *fdt;
@@ -264,8 +264,6 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
     qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     g_free(nodename);
-
-    return fdt;
 }
 
 static void riscv_virt_board_init(MachineState *machine)
@@ -279,7 +277,6 @@ static void riscv_virt_board_init(MachineState *machine)
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
-    void *fdt;
 
     /* Initialize SOC */
     object_initialize(&s->soc, sizeof(s->soc), TYPE_RISCV_HART_ARRAY);
@@ -299,7 +296,7 @@ static void riscv_virt_board_init(MachineState *machine)
         main_mem);
 
     /* create device tree */
-    fdt = create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
+    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     /* boot rom */
     memory_region_init_ram(boot_rom, NULL, "riscv_virt_board.bootrom",
@@ -314,9 +311,9 @@ static void riscv_virt_board_init(MachineState *machine)
             hwaddr end = load_initrd(machine->initrd_filename,
                                      machine->ram_size, kernel_entry,
                                      &start);
-            qemu_fdt_setprop_cell(fdt, "/chosen",
-                                  "linux,initrd-start", start);
-            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-start",
+                                  start);
+            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
                                   end);
         }
     }
-- 
2.7.0
