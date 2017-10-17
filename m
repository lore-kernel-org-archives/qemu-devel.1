Received: from eggs.gnu.org ([2001:4830:134:3::10]:50140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4ahD-0001si-QJ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:50:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4ah8-0007SK-VT
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 18:50:47 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 17 Oct 2017 19:50:25 -0300
Message-Id: <20171017225025.25451-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/alpha/typhoon: simplify using the
 "unimplemented" sysbus device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/alpha/alpha_sys.h |  1 -
 hw/alpha/pci.c       | 26 --------------------------
 hw/alpha/typhoon.c   |  6 ++----
 3 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index b6d8369ed7..9e67f78c60 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -15,7 +15,6 @@ PCIBus *typhoon_init(ram_addr_t, ISABus **, qemu_irq *, AlphaCPU *[4],
                      pci_map_irq_fn);
 
 /* alpha_pci.c.  */
-extern const MemoryRegionOps alpha_pci_ignore_ops;
 extern const MemoryRegionOps alpha_pci_conf1_ops;
 extern const MemoryRegionOps alpha_pci_iack_ops;
 
diff --git a/hw/alpha/pci.c b/hw/alpha/pci.c
index 8dde637bfe..e0bcde9f70 100644
--- a/hw/alpha/pci.c
+++ b/hw/alpha/pci.c
@@ -14,32 +14,6 @@
 #include "trace.h"
 
 
-/* Fallback for unassigned PCI I/O operations.  Avoids MCHK.  */
-
-static uint64_t ignore_read(void *opaque, hwaddr addr, unsigned size)
-{
-    return 0;
-}
-
-static void ignore_write(void *opaque, hwaddr addr, uint64_t v, unsigned size)
-{
-}
-
-const MemoryRegionOps alpha_pci_ignore_ops = {
-    .read = ignore_read,
-    .write = ignore_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 8,
-    },
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 8,
-    },
-};
-
-
 /* PCI config space reads/writes, to byte-word addressable memory.  */
 static uint64_t bw_conf1_read(void *opaque, hwaddr addr,
                               unsigned size)
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index ae11e012c7..5852d6c582 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -11,6 +11,7 @@
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/devices.h"
+#include "hw/misc/unimp.h"
 #include "sysemu/sysemu.h"
 #include "alpha_sys.h"
 #include "exec/address-spaces.h"
@@ -876,10 +877,7 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **isa_bus,
                                 &s->pchip.reg_mem);
 
     /* Pchip0 PCI I/O, 0x801.FC00.0000, 32MB.  */
-    memory_region_init_io(&s->pchip.reg_io, OBJECT(s), &alpha_pci_ignore_ops,
-                          NULL, "pci0-io", 32*MB);
-    memory_region_add_subregion(addr_space, 0x801fc000000ULL,
-                                &s->pchip.reg_io);
+    create_unimplemented_device("pci0-io", 0x801fc000000ULL, 32*MB);
 
     b = pci_register_bus(dev, "pci",
                          typhoon_set_irq, sys_map_irq, s,
-- 
2.15.0.rc0
