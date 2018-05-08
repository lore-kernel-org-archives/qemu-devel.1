Received: from eggs.gnu.org ([2001:4830:134:3::10]:48835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fG8vH-0003oH-BZ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fG8vG-0004yL-AJ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:09:19 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:37628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fG8vG-0004xm-3s
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:09:18 -0400
Received: by mail-pf0-x241.google.com with SMTP id e9so20473692pfi.4
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 13:09:18 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed,  9 May 2018 08:07:39 +1200
Message-Id: <1525810060-36690-3-git-send-email-mjc@sifive.com>
In-Reply-To: <1525810060-36690-1-git-send-email-mjc@sifive.com>
References: <1525810060-36690-1-git-send-email-mjc@sifive.com>
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
Cc: patches@groups.riscv.org, KONRAD Frederic <frederic.konrad@adacore.com>, Michael Clark <mjc@sifive.com>

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
Signed-off-by: Michael Clark <mjc@sifive.com>

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
