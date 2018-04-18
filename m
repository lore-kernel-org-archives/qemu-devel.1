Received: from eggs.gnu.org ([2001:4830:134:3::10]:37613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1f8k9W-0000Vs-Pi
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1f8k9S-0003tN-RU
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:17:26 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:50337
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1f8k9S-0003s8-JI
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:17:22 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Wed, 18 Apr 2018 12:16:48 +0200
Message-Id: <1524046608-12906-3-git-send-email-frederic.konrad@adacore.com>
In-Reply-To: <1524046608-12906-1-git-send-email-frederic.konrad@adacore.com>
References: <1524046608-12906-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH v1 2/2] riscv: htif: increase the priority of
 the htif subregion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: frederic.konrad@adacore.com, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de

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

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 hw/riscv/riscv_htif.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
index 6e687f2..48e5452 100644
--- a/hw/riscv/riscv_htif.c
+++ b/hw/riscv/riscv_htif.c
@@ -253,8 +253,9 @@ HTIFState *htif_mm_init(MemoryRegion *address_space, MemoryRegion *main_mem,
         htif_be_change, s, NULL, true);
     if (address_symbol_set) {
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
