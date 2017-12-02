Received: from eggs.gnu.org ([2001:4830:134:3::10]:53650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eLDUl-00016r-To
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 14:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eLDUh-0004pX-EM
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 14:30:39 -0500
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:47376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eLDUh-0004dc-3d
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 14:30:35 -0500
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 4B9F78263C
	for <qemu-devel@nongnu.org>; Sat,  2 Dec 2017 20:30:23 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Sat, 02 Dec 2017 20:30:11 +0100
Message-ID: <151224301160.13812.16487624528793386353.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] spapr: fix LSI interrupt specifiers in the
 device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Cedric Le Goater <clg@kaod.org>

PAPR 2.7 C.6.9.1.2 describes the "#interrupt-cells" property of the
PowerPC External Interrupt Source Controller node as follows:

=E2=80=9C#interrupt-cells=E2=80=9D

  Standard property name to define the number of cells in an interrupt-
  specifier within an interrupt domain.

  prop-encoded-array: An integer, encoded as with encode-int, that denote=
s
  the number of cells required to represent an interrupt specifier in its
  child nodes.

  The value of this property for the PowerPC External Interrupt option sh=
all
  be 2. Thus all interrupt specifiers (as used in the standard =E2=80=9Ci=
nterrupts=E2=80=9D
  property) shall consist of two cells, each containing an integer encode=
d
  as with encode-int. The first integer represents the interrupt number t=
he
  second integer is the trigger code: 0 for edge triggered, 1 for level
  triggered.

This patch adds a second cell to the interrupt specifier stored in the
"interrupts" property of PCI device nodes. This property only exists if
the Interrupt Pin register is set, ie, the interrupt is level, the extra
cell is hence set to 1.

This also fixes the interrupt specifiers in the "interrupt-map" property
of the PHB node, that were setting the second cell to 8 (confusion with
IRQ_TYPE_LEVEL_LOW ?) instead of 1.

While here, let's introduce defines for the interrupt specifier trigger
code, and patch other users in spapr.

Signed-off-by: Greg Kurz <groug@kaod.org>
---

This fixes /proc/interrupts in linux guests where LSIs appear as
Edge instead of Level.
---
 hw/ppc/spapr_events.c  |    2 +-
 hw/ppc/spapr_pci.c     |    4 +++-
 hw/ppc/spapr_vio.c     |    3 ++-
 include/hw/ppc/spapr.h |    3 +++
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index e377fc7ddea2..4bcb98f948ea 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -283,7 +283,7 @@ void spapr_dt_events(sPAPRMachineState *spapr, void *=
fdt)
         }
=20
         interrupts[0] =3D cpu_to_be32(source->irq);
-        interrupts[1] =3D 0;
+        interrupts[1] =3D SPAPR_DT_INTERRUPT_IDENTIFIER_EDGE;
=20
         _FDT(node_offset =3D fdt_add_subnode(fdt, event_sources, source_=
name));
         _FDT(fdt_setprop(fdt, node_offset, "interrupts", interrupts,
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 5a3122a9f9f9..91fedbf0929c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1231,6 +1231,8 @@ static void spapr_populate_pci_child_dt(PCIDevice *=
dev, void *fdt, int offset,
     if (pci_default_read_config(dev, PCI_INTERRUPT_PIN, 1)) {
         _FDT(fdt_setprop_cell(fdt, offset, "interrupts",
                  pci_default_read_config(dev, PCI_INTERRUPT_PIN, 1)));
+        _FDT(fdt_appendprop_cell(fdt, offset, "interrupts",
+                                 SPAPR_DT_INTERRUPT_IDENTIFIER_LEVEL));
     }
=20
     if (!is_bridge) {
@@ -2122,7 +2124,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
             irqmap[3] =3D cpu_to_be32(j+1);
             irqmap[4] =3D cpu_to_be32(xics_phandle);
             irqmap[5] =3D cpu_to_be32(phb->lsi_table[lsi_num].irq);
-            irqmap[6] =3D cpu_to_be32(0x8);
+            irqmap[6] =3D cpu_to_be32(SPAPR_DT_INTERRUPT_IDENTIFIER_LEVE=
L);
         }
     }
     /* Write interrupt map */
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index ea3bc8bd9e21..29a17651a17c 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -126,7 +126,8 @@ static int vio_make_devnode(VIOsPAPRDevice *dev,
     }
=20
     if (dev->irq) {
-        uint32_t ints_prop[] =3D {cpu_to_be32(dev->irq), 0};
+        uint32_t ints_prop[] =3D { cpu_to_be32(dev->irq),
+                                 SPAPR_DT_INTERRUPT_IDENTIFIER_EDGE };
=20
         ret =3D fdt_setprop(fdt, node_off, "interrupts", ints_prop,
                           sizeof(ints_prop));
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9d21ca9bde3a..8f6298bde59b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -590,6 +590,9 @@ void spapr_load_rtas(sPAPRMachineState *spapr, void *=
fdt, hwaddr addr);
=20
 #define RTAS_EVENT_SCAN_RATE    1
=20
+#define SPAPR_DT_INTERRUPT_IDENTIFIER_EDGE  0
+#define SPAPR_DT_INTERRUPT_IDENTIFIER_LEVEL 1
+
 typedef struct sPAPRTCETable sPAPRTCETable;
=20
 #define TYPE_SPAPR_TCE_TABLE "spapr-tce-table"
