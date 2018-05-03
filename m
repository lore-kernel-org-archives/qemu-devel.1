Received: from eggs.gnu.org ([2001:4830:134:3::10]:39257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fEFz7-0004SU-42
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1fEFz5-0003Ds-Mp
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:17:29 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Thu,  3 May 2018 17:17:15 +0200
Message-Id: <1525360636-18229-3-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1525360636-18229-1-git-send-email-frederic.konrad@adacore.com>
References: <1525360636-18229-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH V2 2/3] riscv: htif: increase the priority of
 the htif subregion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: mjc@sifive.com, kbastian@mail.uni-paderborn.de, f4bug@amsat.org, peter.maydell@linaro.org, frederic.konrad@adacore.com

The htif device is supposed to be mapped over an other subregion. So increase
its priority to one to avoid any conflict.

Here is the output of info mtree:

Before:
(qemu) info mtree
 address-space: memory
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-000000000000000f (prio 0, i/o): riscv.htif.uart
     0000000000000000-0000000000011fff (prio 0, ram): riscv.spike.bootrom
     0000000002000000-000000000200ffff (prio 0, i/o): riscv.sifive.clint
     0000000080000000-0000000087ffffff (prio 0, ram): riscv.spike.ram

 address-space: I/O
   0000000000000000-000000000000ffff (prio 0, i/o): io

 address-space: cpu-memory-0
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-000000000000000f (prio 0, i/o): riscv.htif.uart
     0000000000000000-0000000000011fff (prio 0, ram): riscv.spike.bootrom
     0000000002000000-000000000200ffff (prio 0, i/o): riscv.sifive.clint
     0000000080000000-0000000087ffffff (prio 0, ram): riscv.spike.ram

After:
 (qemu) info mtree
 address-space: memory
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-000000000000000f (prio 1, i/o): riscv.htif.uart
     0000000000000000-0000000000011fff (prio 0, ram): riscv.spike.bootrom
     0000000002000000-000000000200ffff (prio 0, i/o): riscv.sifive.clint
     0000000080000000-0000000087ffffff (prio 0, ram): riscv.spike.ram

 address-space: I/O
   0000000000000000-000000000000ffff (prio 0, i/o): io

 address-space: cpu-memory-0
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-000000000000000f (prio 1, i/o): riscv.htif.uart
     0000000000000000-0000000000011fff (prio 0, ram): riscv.spike.bootrom
     0000000002000000-000000000200ffff (prio 0, i/o): riscv.sifive.clint
     0000000080000000-0000000087ffffff (prio 0, ram): riscv.spike.ram

Reviewed-by: Michael Clark <mjc@sifive.com>
Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 hw/riscv/riscv_htif.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
index be252ec..f735129 100644
--- a/hw/riscv/riscv_htif.c
+++ b/hw/riscv/riscv_htif.c
@@ -253,8 +253,9 @@ HTIFState *htif_mm_init(MemoryRegion *address_space, MemoryRegion *main_mem,
         htif_be_change, s, NULL, true);
     if (address_symbol_set == 3) {
         memory_region_init_io(&s->mmio, NULL, &htif_mm_ops, s,
-                            TYPE_HTIF_UART, size);
-        memory_region_add_subregion(address_space, base, &s->mmio);
+                              TYPE_HTIF_UART, size);
+        memory_region_add_subregion_overlap(address_space, base,
+                                            &s->mmio, 1);
     }
 
     return s;
-- 
1.8.3.1
