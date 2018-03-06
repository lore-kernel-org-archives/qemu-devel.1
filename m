Received: from eggs.gnu.org ([2001:4830:134:3::10]:42435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJF4-0000T8-VO
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJF3-0005Vi-Lu
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 15:31:22 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  6 Mar 2018 20:30:46 +0000
Message-Id: <20180306203103.25563-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 02/19] uninorth: remove second set of uninorth
 token registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

Commit 593c181160: "PPC: Newworld: Add second uninorth control register set"
added a second set of uninorth registers at 0xf3000000.

Testing MacOS 9.2 to MacOS X 10.4 reveals no accesses to this address and I
can't find any reference to it in Apple's Core99.cpp source so I'm assuming
that this was the result of another bug that has now been fixed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac_newworld.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index a749e2565d..1eba79d54b 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -148,7 +148,6 @@ static void ppc_core99_init(MachineState *machine)
     qemu_irq *pic, **openpic_irqs;
     MemoryRegion *isa = g_new(MemoryRegion, 1);
     MemoryRegion *unin_memory = g_new(MemoryRegion, 1);
-    MemoryRegion *unin2_memory = g_new(MemoryRegion, 1);
     int linux_boot, i, j, k;
     MemoryRegion *ram = g_new(MemoryRegion, 1), *bios = g_new(MemoryRegion, 1);
     hwaddr kernel_base, initrd_base, cmdline_base = 0;
@@ -283,9 +282,6 @@ static void ppc_core99_init(MachineState *machine)
     memory_region_init_io(unin_memory, NULL, &unin_ops, token, "unin", 0x1000);
     memory_region_add_subregion(get_system_memory(), 0xf8000000, unin_memory);
 
-    memory_region_init_io(unin2_memory, NULL, &unin_ops, token, "unin", 0x1000);
-    memory_region_add_subregion(get_system_memory(), 0xf3000000, unin2_memory);
-
     openpic_irqs = g_malloc0(smp_cpus * sizeof(qemu_irq *));
     openpic_irqs[0] =
         g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_NB);
-- 
2.11.0
