Received: from eggs.gnu.org ([2001:4830:134:3::10]:42048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQgcw-0007Ef-Op
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 16:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQgct-00014q-H9
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 16:37:42 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:07 +0300
Message-Id: <e2b830d4d61fda8631e1a880734121fa26e92c78.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/61] hw/alpha/typhoon: simplify using the
 "unimplemented" sysbus device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/alpha/alpha_sys.h |  1 -
 hw/alpha/pci.c       | 26 --------------------------
 hw/alpha/typhoon.c   |  6 ++----
 3 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index b6d8369ed7..9e67f78c60 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -15,7 +15,6 @@ PCIBus *typhoon_init(ram_addr_t, ISABus **, qemu_irq *,=
 AlphaCPU *[4],
                      pci_map_irq_fn);
=20
 /* alpha_pci.c.  */
-extern const MemoryRegionOps alpha_pci_ignore_ops;
 extern const MemoryRegionOps alpha_pci_conf1_ops;
 extern const MemoryRegionOps alpha_pci_iack_ops;
=20
diff --git a/hw/alpha/pci.c b/hw/alpha/pci.c
index 8dde637bfe..e0bcde9f70 100644
--- a/hw/alpha/pci.c
+++ b/hw/alpha/pci.c
@@ -14,32 +14,6 @@
 #include "trace.h"
=20
=20
-/* Fallback for unassigned PCI I/O operations.  Avoids MCHK.  */
-
-static uint64_t ignore_read(void *opaque, hwaddr addr, unsigned size)
-{
-    return 0;
-}
-
-static void ignore_write(void *opaque, hwaddr addr, uint64_t v, unsigned=
 size)
-{
-}
-
-const MemoryRegionOps alpha_pci_ignore_ops =3D {
-    .read =3D ignore_read,
-    .write =3D ignore_write,
-    .endianness =3D DEVICE_LITTLE_ENDIAN,
-    .valid =3D {
-        .min_access_size =3D 1,
-        .max_access_size =3D 8,
-    },
-    .impl =3D {
-        .min_access_size =3D 1,
-        .max_access_size =3D 8,
-    },
-};
-
-
 /* PCI config space reads/writes, to byte-word addressable memory.  */
 static uint64_t bw_conf1_read(void *opaque, hwaddr addr,
                               unsigned size)
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index ae11e012c7..d8e2cac3f3 100644
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
@@ -876,10 +877,7 @@ PCIBus *typhoon_init(ram_addr_t ram_size, ISABus **i=
sa_bus,
                                 &s->pchip.reg_mem);
=20
     /* Pchip0 PCI I/O, 0x801.FC00.0000, 32MB.  */
-    memory_region_init_io(&s->pchip.reg_io, OBJECT(s), &alpha_pci_ignore=
_ops,
-                          NULL, "pci0-io", 32*MB);
-    memory_region_add_subregion(addr_space, 0x801fc000000ULL,
-                                &s->pchip.reg_io);
+    create_unimplemented_device("pci0-io", 0x801fc000000ULL, 32 * MB);
=20
     b =3D pci_register_bus(dev, "pci",
                          typhoon_set_irq, sys_map_irq, s,
--=20
2.11.0
