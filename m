Received: from eggs.gnu.org ([2001:4830:134:3::10]:56873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwx-0005Tb-BN
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwn-00087x-4t
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:19 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 26 Apr 2017 17:00:24 +1000
Message-Id: <20170426070034.10727-39-david@gibson.dropbear.id.au>
In-Reply-To: <20170426070034.10727-1-david@gibson.dropbear.id.au>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 38/48] ppc/pnv: scan ISA bus to populate device
 tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

This is an empty shell that we will use to include nodes in the device
tree for ISA devices. We expect RTC, UART and IPMI BT devices.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9468e99..c445906 100644
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
2.9.3
