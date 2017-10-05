Received: from eggs.gnu.org ([2001:4830:134:3::10]:45531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xr-0003Qc-6D
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e08xo-0003sm-Ay
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:25:35 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  5 Oct 2017 18:24:50 +0200
Message-Id: <1507220690-265042-24-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 23/23] ppc: pnv: consolidate type definitions
 and batch register them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

Use a new DEFINE_TYPES() helper to simplify type registration

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/ppc/pnv.c | 92 ++++++++++++++++++++++--------------------------------------
 1 file changed, 34 insertions(+), 58 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index ab7083b..e23dc3c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -730,13 +730,6 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV Chip POWER8E";
 }
 
-static const TypeInfo pnv_chip_power8e_info = {
-    .name          = TYPE_PNV_CHIP_POWER8E,
-    .parent        = TYPE_PNV_CHIP,
-    .instance_size = sizeof(PnvChip),
-    .class_init    = pnv_chip_power8e_class_init,
-};
-
 static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -751,13 +744,6 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV Chip POWER8";
 }
 
-static const TypeInfo pnv_chip_power8_info = {
-    .name          = TYPE_PNV_CHIP_POWER8,
-    .parent        = TYPE_PNV_CHIP,
-    .instance_size = sizeof(PnvChip),
-    .class_init    = pnv_chip_power8_class_init,
-};
-
 static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -772,13 +758,6 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV Chip POWER8NVL";
 }
 
-static const TypeInfo pnv_chip_power8nvl_info = {
-    .name          = TYPE_PNV_CHIP_POWER8NVL,
-    .parent        = TYPE_PNV_CHIP,
-    .instance_size = sizeof(PnvChip),
-    .class_init    = pnv_chip_power8nvl_class_init,
-};
-
 static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -793,13 +772,6 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV Chip POWER9";
 }
 
-static const TypeInfo pnv_chip_power9_info = {
-    .name          = TYPE_PNV_CHIP_POWER9,
-    .parent        = TYPE_PNV_CHIP,
-    .instance_size = sizeof(PnvChip),
-    .class_init    = pnv_chip_power9_class_init,
-};
-
 static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
@@ -1001,15 +973,6 @@ static void pnv_chip_class_init(ObjectClass *klass, void *data)
     dc->desc = "PowerNV Chip";
 }
 
-static const TypeInfo pnv_chip_info = {
-    .name          = TYPE_PNV_CHIP,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .class_init    = pnv_chip_class_init,
-    .instance_init = pnv_chip_init,
-    .class_size    = sizeof(PnvChipClass),
-    .abstract      = true,
-};
-
 static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
 {
     PnvMachineState *pnv = POWERNV_MACHINE(xi);
@@ -1145,27 +1108,40 @@ static void powernv_machine_class_init(ObjectClass *oc, void *data)
     powernv_machine_class_props_init(oc);
 }
 
-static const TypeInfo powernv_machine_info = {
-    .name          = TYPE_POWERNV_MACHINE,
-    .parent        = TYPE_MACHINE,
-    .instance_size = sizeof(PnvMachineState),
-    .instance_init = powernv_machine_initfn,
-    .class_init    = powernv_machine_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_XICS_FABRIC },
-        { TYPE_INTERRUPT_STATS_PROVIDER },
-        { },
+#define DEFINE_PNV_CHIP_TYPE(type, class_initfn) \
+    {                                            \
+        .name          = type,                   \
+        .class_init    = class_initfn,           \
+        .parent        = TYPE_PNV_CHIP,          \
+    }
+
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_POWERNV_MACHINE,
+        .parent        = TYPE_MACHINE,
+        .instance_size = sizeof(PnvMachineState),
+        .instance_init = powernv_machine_initfn,
+        .class_init    = powernv_machine_class_init,
+        .interfaces = (InterfaceInfo[]) {
+            { TYPE_XICS_FABRIC },
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { },
+        },
     },
+    {
+        .name          = TYPE_PNV_CHIP,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .class_init    = pnv_chip_class_init,
+        .instance_init = pnv_chip_init,
+        .instance_size = sizeof(PnvChip),
+        .class_size    = sizeof(PnvChipClass),
+        .abstract      = true,
+    },
+    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER9, pnv_chip_power9_class_init),
+    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class_init),
+    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_class_init),
+    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
+                         pnv_chip_power8nvl_class_init),
 };
 
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
-- 
2.7.4
