Received: from eggs.gnu.org ([2001:4830:134:3::10]:38219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxxkg-0006jQ-G2
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxxkd-0003et-BE
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:42 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:36343)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxxkc-0003di-Pu
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:39 -0400
Received: from player778.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 4235D31468
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 17:30:36 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 11 Apr 2017 17:30:01 +0200
Message-Id: <1491924606-20026-4-git-send-email-clg@kaod.org>
In-Reply-To: <1491924606-20026-1-git-send-email-clg@kaod.org>
References: <1491924606-20026-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/8] ppc/pnv: scan ISA bus to populate
 device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This is an empty shell that we will use to include nodes in the device
tree for ISA devices. We expect RTC, UART and IPMI BT devices.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---

 Changes since v2:

 - used the pnv_chip_lpc_offset() routine to locate the lpc node of
   chip 0 in the device tree. This is more precise than looking for a
   "ibm,lpc" compatible property.
 =20
 hw/ppc/pnv.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9468e991bfb2..c445906358d7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -303,6 +303,29 @@ static void powernv_populate_chip(PnvChip *chip, voi=
d *fdt)
     g_free(typename);
 }
=20
+typedef struct ForeachPopulateArgs {
+    void *fdt;
+    int offset;
+} ForeachPopulateArgs;
+
+static int powernv_populate_isa_device(DeviceState *dev, void *opaque)
+{
+    return 0;
+}
+
+static void powernv_populate_isa(ISABus *bus, void *fdt, int lpc_offset)
+{
+    ForeachPopulateArgs args =3D {
+        .fdt =3D fdt,
+        .offset =3D lpc_offset,
+    };
+
+    /* ISA devices are not necessarily parented to the ISA bus so we
+     * can not use object_child_foreach() */
+    qbus_walk_children(BUS(bus), powernv_populate_isa_device,
+                       NULL, NULL, NULL, &args);
+}
+
 static void *powernv_create_fdt(MachineState *machine)
 {
     const char plat_compat[] =3D "qemu,powernv\0ibm,powernv";
@@ -311,6 +334,7 @@ static void *powernv_create_fdt(MachineState *machine=
)
     char *buf;
     int off;
     int i;
+    int lpc_offset;
=20
     fdt =3D g_malloc0(FDT_MAX_SIZE);
     _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
@@ -350,6 +374,10 @@ static void *powernv_create_fdt(MachineState *machin=
e)
     for (i =3D 0; i < pnv->num_chips; i++) {
         powernv_populate_chip(pnv->chips[i], fdt);
     }
+
+    /* Populate ISA devices on chip 0 */
+    lpc_offset =3D pnv_chip_lpc_offset(pnv->chips[0], fdt);
+    powernv_populate_isa(pnv->isa_bus, fdt, lpc_offset);
     return fdt;
 }
=20
--=20
2.7.4
