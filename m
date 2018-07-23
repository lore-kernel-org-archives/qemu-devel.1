Received: from eggs.gnu.org ([2001:4830:134:3::10]:42748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKF-0003UB-Vh
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKE-00059m-Tq
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:59 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:16 -0500
Message-Id: <20180723201748.25573-68-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 67/99] RISC-V: Minimal QEMU 2.12 fix for
 sifive_u machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>

From: Michael Clark <mjc@sifive.com>

The 'sifive_u' board has a bug where the ROM is
created as RAM at the wrong address and marked
readonly. The bug renders the board unusable.
This is a minimal fix and allows booting Linux.

5aec3247c190f10654250203a1742490ae7343a2
"RISC-V: Mark ROM read-only after copying in code"
contains a comprehensive fix using the ROM APIs
memory_region_init_rom and rom_add_blob_fixed_as
which could be backported.

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/riscv/sifive_u.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 1c2deefa6c..19b034449c 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -250,9 +250,9 @@ static void riscv_sifive_u_init(MachineState *machine)
 
     /* boot rom */
     memory_region_init_ram(boot_rom, NULL, "riscv.sifive.u.mrom",
-                           memmap[SIFIVE_U_MROM].base, &error_fatal);
-    memory_region_set_readonly(boot_rom, true);
-    memory_region_add_subregion(sys_memory, 0x0, boot_rom);
+                           memmap[SIFIVE_U_MROM].size, &error_fatal);
+    memory_region_add_subregion(sys_memory, memmap[SIFIVE_U_MROM].base,
+                                boot_rom);
 
     if (machine->kernel_filename) {
         load_kernel(machine->kernel_filename);
@@ -282,6 +282,7 @@ static void riscv_sifive_u_init(MachineState *machine)
     qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
     cpu_physical_memory_write(memmap[SIFIVE_U_MROM].base +
         sizeof(reset_vec), s->fdt, s->fdt_size);
+    memory_region_set_readonly(boot_rom, true);
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
-- 
2.17.1
