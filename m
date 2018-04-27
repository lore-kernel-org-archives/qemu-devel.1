Received: from eggs.gnu.org ([2001:4830:134:3::10]:58928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZS-0000rl-Ai
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZO-0001nG-Rn
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:21:37 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:20:39 +1000
Message-Id: <20180427092126.24812-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/49] uninorth: remove second set of uninorth
 token registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Commit 593c181160: "PPC: Newworld: Add second uninorth control register set"
added a second set of uninorth registers at 0xf3000000.

Testing MacOS 9.2 to MacOS X 10.4 reveals no accesses to this address and I
can't find any reference to it in Apple's Core99.cpp source so I'm assuming
that this was the result of another bug that has now been fixed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac_newworld.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 2f5b6f651a..39944203a4 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -147,7 +147,6 @@ static void ppc_core99_init(MachineState *machine)
     qemu_irq *pic, **openpic_irqs;
     MemoryRegion *isa = g_new(MemoryRegion, 1);
     MemoryRegion *unin_memory = g_new(MemoryRegion, 1);
-    MemoryRegion *unin2_memory = g_new(MemoryRegion, 1);
     int linux_boot, i, j, k;
     MemoryRegion *ram = g_new(MemoryRegion, 1), *bios = g_new(MemoryRegion, 1);
     hwaddr kernel_base, initrd_base, cmdline_base = 0;
@@ -282,9 +281,6 @@ static void ppc_core99_init(MachineState *machine)
     memory_region_init_io(unin_memory, NULL, &unin_ops, token, "unin", 0x1000);
     memory_region_add_subregion(get_system_memory(), 0xf8000000, unin_memory);
 
-    memory_region_init_io(unin2_memory, NULL, &unin_ops, token, "unin", 0x1000);
-    memory_region_add_subregion(get_system_memory(), 0xf3000000, unin2_memory);
-
     openpic_irqs = g_malloc0(smp_cpus * sizeof(qemu_irq *));
     openpic_irqs[0] =
         g_malloc0(smp_cpus * sizeof(qemu_irq) * OPENPIC_OUTPUT_NB);
-- 
2.14.3
