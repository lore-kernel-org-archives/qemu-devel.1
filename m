Received: from eggs.gnu.org ([2001:4830:134:3::10]:36454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eLrwd-0005Tb-I5
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eLrwZ-0001CL-Fq
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:42:07 -0500
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:45249)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eLrwZ-0001Bn-9F
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 09:42:03 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id CA68590433
	for <qemu-devel@nongnu.org>; Mon,  4 Dec 2017 15:42:00 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 04 Dec 2017 15:41:46 +0100
Message-ID: <151239850618.30749.18071098158203257789.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] spapr: fix LSI interrupt specifiers in the
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

This patch fixes the interrupt specifiers in the "interrupt-map" property
of the PHB node, that were setting the second cell to 8 (confusion with
IRQ_TYPE_LEVEL_LOW ?) instead of 1.

VIO devices and RTAS event sources use the same format for interrupt
specifiers: while here, we introduce a common helper to handle the
encoding details.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
--
v2: - drop the erroneous changes to the "interrupts" prop in PCI device n=
odes
    - introduce a common helper to encode interrupt specifiers
---
 hw/ppc/spapr_events.c  |    3 +--
 hw/ppc/spapr_pci.c     |    5 +++--
 hw/ppc/spapr_vio.c     |    3 ++-
 include/hw/ppc/spapr.h |   11 +++++++++++
 4 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 7dc87fc7bd77..c8205795b0c8 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -282,8 +282,7 @@ void spapr_dt_events(sPAPRMachineState *spapr, void *=
fdt)
             continue;
         }
=20
-        interrupts[0] =3D cpu_to_be32(source->irq);
-        interrupts[1] =3D 0;
+        spapr_dt_encode_interrupt_specifier(interrupts, source->irq, fal=
se);
=20
         _FDT(node_offset =3D fdt_add_subnode(fdt, event_sources, source_=
name));
         _FDT(fdt_setprop(fdt, node_offset, "interrupts", interrupts,
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 39134f0ef0a3..78769e833dd0 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2121,8 +2121,9 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
             irqmap[2] =3D 0;
             irqmap[3] =3D cpu_to_be32(j+1);
             irqmap[4] =3D cpu_to_be32(xics_phandle);
-            irqmap[5] =3D cpu_to_be32(phb->lsi_table[lsi_num].irq);
-            irqmap[6] =3D cpu_to_be32(0x8);
+            spapr_dt_encode_interrupt_specifier(&irqmap[5],
+                                                phb->lsi_table[lsi_num].=
irq,
+                                                true);
         }
     }
     /* Write interrupt map */
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index bb7ed2c537b0..582b50a0443d 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -126,8 +126,9 @@ static int vio_make_devnode(VIOsPAPRDevice *dev,
     }
=20
     if (dev->irq) {
-        uint32_t ints_prop[] =3D {cpu_to_be32(dev->irq), 0};
+        uint32_t ints_prop[2];
=20
+        spapr_dt_encode_interrupt_specifier(ints_prop, dev->irq, false);
         ret =3D fdt_setprop(fdt, node_off, "interrupts", ints_prop,
                           sizeof(ints_prop));
         if (ret < 0) {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 6b8e04c78771..423e72338309 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -590,6 +590,17 @@ void spapr_load_rtas(sPAPRMachineState *spapr, void =
*fdt, hwaddr addr);
=20
 #define RTAS_EVENT_SCAN_RATE    1
=20
+/* This helper should be used to encode interrupt specifiers when the re=
lated
+ * "interrupt-controller" node has its "#interrupt-cells" property set t=
o 2 (ie,
+ * VIO devices, RTAS event sources and PHBs).
+ */
+static inline void spapr_dt_encode_interrupt_specifier(uint32_t *intspec=
,
+                                                       int irq, bool is_=
lsi)
+{
+    intspec[0] =3D cpu_to_be32(irq);
+    intspec[1] =3D is_lsi ? cpu_to_be32(1) : 0;
+}
+
 typedef struct sPAPRTCETable sPAPRTCETable;
=20
 #define TYPE_SPAPR_TCE_TABLE "spapr-tce-table"
