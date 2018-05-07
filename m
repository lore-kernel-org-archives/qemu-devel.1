Received: from eggs.gnu.org ([2001:4830:134:3::10]:35496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fFpMz-0008Aa-8M
	for qemu-devel@nongnu.org; Mon, 07 May 2018 19:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fFpMy-0006qv-Cs
	for qemu-devel@nongnu.org; Mon, 07 May 2018 19:16:37 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:37500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fFpMy-0006pu-6s
	for qemu-devel@nongnu.org; Mon, 07 May 2018 19:16:36 -0400
Received: by mail-pg0-x244.google.com with SMTP id a13-v6so20315976pgu.4
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 16:16:36 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Tue,  8 May 2018 11:14:52 +1200
Message-Id: <1525734893-10299-3-git-send-email-mjc@sifive.com>
In-Reply-To: <1525734893-10299-1-git-send-email-mjc@sifive.com>
References: <1525734893-10299-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PULL 2/3] riscv: htif: increase the priority of the
 htif subregion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, KONRAD Frederic <frederic.konrad@adacore.com>

From: KONRAD Frederic <frederic.konrad@adacore.com>

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
Message-Id: <1525360636-18229-3-git-send-email-frederic.konrad@adacore.com>
---
 hw/riscv/riscv_htif.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
index be252ec8cce9..f73512941fb6 100644
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
2.7.0
