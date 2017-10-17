Received: from eggs.gnu.org ([2001:4830:134:3::10]:50839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOe-0008Um-Nj
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOb-0007Cv-St
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:49 +1100
Message-Id: <20171017042152.29443-32-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/34] ppc: pnv: consolidate type definitions
 and batch register them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

Use a new DEFINE_TYPES() helper to simplify type registration

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 92 ++++++++++++++++++++++--------------------------------=
------
 1 file changed, 34 insertions(+), 58 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 80c7f62bbc..c35c439d81 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -729,13 +729,6 @@ static void pnv_chip_power8e_class_init(ObjectClass =
*klass, void *data)
     dc->desc =3D "PowerNV Chip POWER8E";
 }
=20
-static const TypeInfo pnv_chip_power8e_info =3D {
-    .name          =3D TYPE_PNV_CHIP_POWER8E,
-    .parent        =3D TYPE_PNV_CHIP,
-    .instance_size =3D sizeof(PnvChip),
-    .class_init    =3D pnv_chip_power8e_class_init,
-};
-
 static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -750,13 +743,6 @@ static void pnv_chip_power8_class_init(ObjectClass *=
klass, void *data)
     dc->desc =3D "PowerNV Chip POWER8";
 }
=20
-static const TypeInfo pnv_chip_power8_info =3D {
-    .name          =3D TYPE_PNV_CHIP_POWER8,
-    .parent        =3D TYPE_PNV_CHIP,
-    .instance_size =3D sizeof(PnvChip),
-    .class_init    =3D pnv_chip_power8_class_init,
-};
-
 static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data=
)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -771,13 +757,6 @@ static void pnv_chip_power8nvl_class_init(ObjectClas=
s *klass, void *data)
     dc->desc =3D "PowerNV Chip POWER8NVL";
 }
=20
-static const TypeInfo pnv_chip_power8nvl_info =3D {
-    .name          =3D TYPE_PNV_CHIP_POWER8NVL,
-    .parent        =3D TYPE_PNV_CHIP,
-    .instance_size =3D sizeof(PnvChip),
-    .class_init    =3D pnv_chip_power8nvl_class_init,
-};
-
 static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -792,13 +771,6 @@ static void pnv_chip_power9_class_init(ObjectClass *=
klass, void *data)
     dc->desc =3D "PowerNV Chip POWER9";
 }
=20
-static const TypeInfo pnv_chip_power9_info =3D {
-    .name          =3D TYPE_PNV_CHIP_POWER9,
-    .parent        =3D TYPE_PNV_CHIP,
-    .instance_size =3D sizeof(PnvChip),
-    .class_init    =3D pnv_chip_power9_class_init,
-};
-
 static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
 {
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
@@ -1000,15 +972,6 @@ static void pnv_chip_class_init(ObjectClass *klass,=
 void *data)
     dc->desc =3D "PowerNV Chip";
 }
=20
-static const TypeInfo pnv_chip_info =3D {
-    .name          =3D TYPE_PNV_CHIP,
-    .parent        =3D TYPE_SYS_BUS_DEVICE,
-    .class_init    =3D pnv_chip_class_init,
-    .instance_init =3D pnv_chip_init,
-    .class_size    =3D sizeof(PnvChipClass),
-    .abstract      =3D true,
-};
-
 static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
 {
     PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
@@ -1144,27 +1107,40 @@ static void powernv_machine_class_init(ObjectClas=
s *oc, void *data)
     powernv_machine_class_props_init(oc);
 }
=20
-static const TypeInfo powernv_machine_info =3D {
-    .name          =3D TYPE_POWERNV_MACHINE,
-    .parent        =3D TYPE_MACHINE,
-    .instance_size =3D sizeof(PnvMachineState),
-    .instance_init =3D powernv_machine_initfn,
-    .class_init    =3D powernv_machine_class_init,
-    .interfaces =3D (InterfaceInfo[]) {
-        { TYPE_XICS_FABRIC },
-        { TYPE_INTERRUPT_STATS_PROVIDER },
-        { },
+#define DEFINE_PNV_CHIP_TYPE(type, class_initfn) \
+    {                                            \
+        .name          =3D type,                   \
+        .class_init    =3D class_initfn,           \
+        .parent        =3D TYPE_PNV_CHIP,          \
+    }
+
+static const TypeInfo types[] =3D {
+    {
+        .name          =3D TYPE_POWERNV_MACHINE,
+        .parent        =3D TYPE_MACHINE,
+        .instance_size =3D sizeof(PnvMachineState),
+        .instance_init =3D powernv_machine_initfn,
+        .class_init    =3D powernv_machine_class_init,
+        .interfaces =3D (InterfaceInfo[]) {
+            { TYPE_XICS_FABRIC },
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { },
+        },
     },
+    {
+        .name          =3D TYPE_PNV_CHIP,
+        .parent        =3D TYPE_SYS_BUS_DEVICE,
+        .class_init    =3D pnv_chip_class_init,
+        .instance_init =3D pnv_chip_init,
+        .instance_size =3D sizeof(PnvChip),
+        .class_size    =3D sizeof(PnvChipClass),
+        .abstract      =3D true,
+    },
+    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER9, pnv_chip_power9_class_ini=
t),
+    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class_ini=
t),
+    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_class_i=
nit),
+    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
+                         pnv_chip_power8nvl_class_init),
 };
=20
-static void powernv_machine_register_types(void)
-{
-    type_register_static(&powernv_machine_info);
-    type_register_static(&pnv_chip_info);
-    type_register_static(&pnv_chip_power8e_info);
-    type_register_static(&pnv_chip_power8_info);
-    type_register_static(&pnv_chip_power8nvl_info);
-    type_register_static(&pnv_chip_power9_info);
-}
-
-type_init(powernv_machine_register_types)
+DEFINE_TYPES(types)
--=20
2.13.6
