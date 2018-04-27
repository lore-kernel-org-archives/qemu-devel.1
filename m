Received: from eggs.gnu.org ([2001:4830:134:3::10]:59271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZy-0001W9-5o
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzZx-00021c-3n
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:10 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:20:43 +1000
Message-Id: <20180427092126.24812-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/49] uninorth: alter pci_pmac_init() and
 pci_pmac_u3_init() to return uninorth device
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

This is in preparation for moving the device wiring into the New World ma=
chine.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/uninorth.c | 16 ++++++++--------
 hw/ppc/mac.h           | 10 ++++++----
 hw/ppc/mac_newworld.c  | 10 ++++++++--
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 600d675573..b081e3c153 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -166,9 +166,9 @@ static void pci_unin_internal_init(Object *obj)
     sysbus_init_mmio(sbd, &h->data_mem);
 }
=20
-PCIBus *pci_pmac_init(qemu_irq *pic,
-                      MemoryRegion *address_space_mem,
-                      MemoryRegion *address_space_io)
+UNINState *pci_pmac_init(qemu_irq *pic,
+                         MemoryRegion *address_space_mem,
+                         MemoryRegion *address_space_io)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -228,12 +228,12 @@ PCIBus *pci_pmac_init(qemu_irq *pic,
     sysbus_mmio_map(s, 1, 0xf4c00000);
 #endif
=20
-    return h->bus;
+    return d;
 }
=20
-PCIBus *pci_pmac_u3_init(qemu_irq *pic,
-                         MemoryRegion *address_space_mem,
-                         MemoryRegion *address_space_io)
+UNINState *pci_pmac_u3_init(qemu_irq *pic,
+                            MemoryRegion *address_space_mem,
+                            MemoryRegion *address_space_io)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -265,7 +265,7 @@ PCIBus *pci_pmac_u3_init(qemu_irq *pic,
=20
     pci_create_simple(h->bus, 11 << 3, "u3-agp");
=20
-    return h->bus;
+    return d;
 }
=20
 static void unin_main_pci_host_realize(PCIDevice *d, Error **errp)
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index a02f797598..fcf13cb757 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -31,6 +31,8 @@
 #include "hw/ide/internal.h"
 #include "hw/input/adb.h"
 #include "hw/misc/mos6522.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci-host/uninorth.h"
=20
 /* SMP is not enabled, for now */
 #define MAX_CPUS 1
@@ -86,12 +88,12 @@ PCIBus *pci_grackle_init(uint32_t base, qemu_irq *pic=
,
                          MemoryRegion *address_space_io);
=20
 /* UniNorth PCI */
-PCIBus *pci_pmac_init(qemu_irq *pic,
-                      MemoryRegion *address_space_mem,
-                      MemoryRegion *address_space_io);
-PCIBus *pci_pmac_u3_init(qemu_irq *pic,
+UNINState *pci_pmac_init(qemu_irq *pic,
                          MemoryRegion *address_space_mem,
                          MemoryRegion *address_space_io);
+UNINState *pci_pmac_u3_init(qemu_irq *pic,
+                            MemoryRegion *address_space_mem,
+                            MemoryRegion *address_space_io);
=20
 /* Mac NVRAM */
 #define TYPE_MACIO_NVRAM "macio-nvram"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 4ff1c293a8..ccf34ee36c 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -151,6 +151,7 @@ static void ppc_core99_init(MachineState *machine)
     MemoryRegion *ram =3D g_new(MemoryRegion, 1), *bios =3D g_new(Memory=
Region, 1);
     hwaddr kernel_base, initrd_base, cmdline_base =3D 0;
     long kernel_size, initrd_size;
+    UNINState *uninorth_pci;
     PCIBus *pci_bus;
     NewWorldMacIOState *macio;
     MACIOIDEState *macio_ide;
@@ -344,10 +345,12 @@ static void ppc_core99_init(MachineState *machine)
=20
     if (PPC_INPUT(env) =3D=3D PPC_FLAGS_INPUT_970) {
         /* 970 gets a U3 bus */
-        pci_bus =3D pci_pmac_u3_init(pic, get_system_memory(), get_syste=
m_io());
+        uninorth_pci =3D pci_pmac_u3_init(pic, get_system_memory(),
+                                        get_system_io());
         machine_arch =3D ARCH_MAC99_U3;
     } else {
-        pci_bus =3D pci_pmac_init(pic, get_system_memory(), get_system_i=
o());
+        uninorth_pci =3D pci_pmac_init(pic, get_system_memory(),
+                                     get_system_io());
         machine_arch =3D ARCH_MAC99;
     }
=20
@@ -360,6 +363,9 @@ static void ppc_core99_init(MachineState *machine)
         tbfreq =3D TBFREQ;
     }
=20
+    /* init basic PC hardware */
+    pci_bus =3D PCI_HOST_BRIDGE(uninorth_pci)->bus;
+
     /* MacIO */
     macio =3D NEWWORLD_MACIO(pci_create(pci_bus, -1, TYPE_NEWWORLD_MACIO=
));
     dev =3D DEVICE(macio);
--=20
2.14.3
