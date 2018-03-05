Received: from eggs.gnu.org ([2001:4830:134:3::10]:41476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHk-0003XD-6q
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:28:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1esoHj-00072W-2G
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:28:04 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  5 Mar 2018 08:27:16 -0300
Message-Id: <20180305112732.26471-15-f4bug@amsat.org>
In-Reply-To: <20180305112732.26471-1-f4bug@amsat.org>
References: <20180305112732.26471-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 14/30] hw/alpha: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/alpha/typhoon.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 6a40869488..0acfb4b1d0 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -812,8 +812,6 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
                      qemu_irq *p_rtc_irq,
                      AlphaCPU *cpus[4], pci_map_irq_fn sys_map_irq)
 {
-    const uint64_t MB = 1024 * 1024;
-    const uint64_t GB = 1024 * MB;
     MemoryRegion *addr_space = get_system_memory();
     DeviceState *dev;
     TyphoonState *s;
@@ -854,30 +852,30 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
 
     /* Pchip0 CSRs, 0x801.8000.0000, 256MB.  */
     memory_region_init_io(&s->pchip.region, OBJECT(s), &pchip_ops, s, "pchip0",
-                          256*MB);
+                          256 * M_BYTE);
     memory_region_add_subregion(addr_space, 0x80180000000ULL,
                                 &s->pchip.region);
 
     /* Cchip CSRs, 0x801.A000.0000, 256MB.  */
     memory_region_init_io(&s->cchip.region, OBJECT(s), &cchip_ops, s, "cchip0",
-                          256*MB);
+                          256 * M_BYTE);
     memory_region_add_subregion(addr_space, 0x801a0000000ULL,
                                 &s->cchip.region);
 
     /* Dchip CSRs, 0x801.B000.0000, 256MB.  */
     memory_region_init_io(&s->dchip_region, OBJECT(s), &dchip_ops, s, "dchip0",
-                          256*MB);
+                          256 * M_BYTE);
     memory_region_add_subregion(addr_space, 0x801b0000000ULL,
                                 &s->dchip_region);
 
     /* Pchip0 PCI memory, 0x800.0000.0000, 4GB.  */
-    memory_region_init(&s->pchip.reg_mem, OBJECT(s), "pci0-mem", 4*GB);
+    memory_region_init(&s->pchip.reg_mem, OBJECT(s), "pci0-mem", 4 * G_BYTE);
     memory_region_add_subregion(addr_space, 0x80000000000ULL,
                                 &s->pchip.reg_mem);
 
     /* Pchip0 PCI I/O, 0x801.FC00.0000, 32MB.  */
     memory_region_init_io(&s->pchip.reg_io, OBJECT(s), &alpha_pci_ignore_ops,
-                          NULL, "pci0-io", 32*MB);
+                          NULL, "pci0-io", 32 * M_BYTE);
     memory_region_add_subregion(addr_space, 0x801fc000000ULL,
                                 &s->pchip.reg_io);
 
@@ -898,13 +896,13 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
 
     /* Pchip0 PCI special/interrupt acknowledge, 0x801.F800.0000, 64MB.  */
     memory_region_init_io(&s->pchip.reg_iack, OBJECT(s), &alpha_pci_iack_ops,
-                          b, "pci0-iack", 64*MB);
+                          b, "pci0-iack", 64 * M_BYTE);
     memory_region_add_subregion(addr_space, 0x801f8000000ULL,
                                 &s->pchip.reg_iack);
 
     /* Pchip0 PCI configuration, 0x801.FE00.0000, 16MB.  */
     memory_region_init_io(&s->pchip.reg_conf, OBJECT(s), &alpha_pci_conf1_ops,
-                          b, "pci0-conf", 16*MB);
+                          b, "pci0-conf", 16 * M_BYTE);
     memory_region_add_subregion(addr_space, 0x801fe000000ULL,
                                 &s->pchip.reg_conf);
 
-- 
2.16.2
