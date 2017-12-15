Received: from eggs.gnu.org ([2001:4830:134:3::10]:53394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixR-0003i9-Lp
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePixO-0004kf-Ef
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 00:54:53 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Dec 2017 16:54:30 +1100
Message-Id: <20171215055435.24204-20-david@gibson.dropbear.id.au>
In-Reply-To: <20171215055435.24204-1-david@gibson.dropbear.id.au>
References: <20171215055435.24204-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/24] spapr: fix LSI interrupt specifiers in
 the device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

LoPAPR 1.1 B.6.9.1.2 describes the "#interrupt-cells" property of the
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
v3: - reference public LoPAPR instead of internal PAPR+ in changelog
    - change helper name to spapr_dt_xics_irq()

v2: - drop the erroneous changes to the "interrupts" prop in PCI device n=
odes
    - introduce a common helper to encode interrupt specifiers
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_events.c  |  3 +--
 hw/ppc/spapr_pci.c     |  3 +--
 hw/ppc/spapr_vio.c     |  3 ++-
 include/hw/ppc/spapr.h | 10 ++++++++++
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 7dc87fc7bd..c7a64e6b8d 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -282,8 +282,7 @@ void spapr_dt_events(sPAPRMachineState *spapr, void *=
fdt)
             continue;
         }
=20
-        interrupts[0] =3D cpu_to_be32(source->irq);
-        interrupts[1] =3D 0;
+        spapr_dt_xics_irq(interrupts, source->irq, false);
=20
         _FDT(node_offset =3D fdt_add_subnode(fdt, event_sources, source_=
name));
         _FDT(fdt_setprop(fdt, node_offset, "interrupts", interrupts,
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 39134f0ef0..88797b3d36 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2121,8 +2121,7 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
             irqmap[2] =3D 0;
             irqmap[3] =3D cpu_to_be32(j+1);
             irqmap[4] =3D cpu_to_be32(xics_phandle);
-            irqmap[5] =3D cpu_to_be32(phb->lsi_table[lsi_num].irq);
-            irqmap[6] =3D cpu_to_be32(0x8);
+            spapr_dt_xics_irq(&irqmap[5], phb->lsi_table[lsi_num].irq, t=
rue);
         }
     }
     /* Write interrupt map */
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index bb7ed2c537..472dd6f33a 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -126,8 +126,9 @@ static int vio_make_devnode(VIOsPAPRDevice *dev,
     }
=20
     if (dev->irq) {
-        uint32_t ints_prop[] =3D {cpu_to_be32(dev->irq), 0};
+        uint32_t ints_prop[2];
=20
+        spapr_dt_xics_irq(ints_prop, dev->irq, false);
         ret =3D fdt_setprop(fdt, node_off, "interrupts", ints_prop,
                           sizeof(ints_prop));
         if (ret < 0) {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 6b8e04c787..14757b805e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -590,6 +590,16 @@ void spapr_load_rtas(sPAPRMachineState *spapr, void =
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
+static inline void spapr_dt_xics_irq(uint32_t *intspec, int irq, bool is=
_lsi)
+{
+    intspec[0] =3D cpu_to_be32(irq);
+    intspec[1] =3D is_lsi ? cpu_to_be32(1) : 0;
+}
+
 typedef struct sPAPRTCETable sPAPRTCETable;
=20
 #define TYPE_SPAPR_TCE_TABLE "spapr-tce-table"
--=20
2.14.3
