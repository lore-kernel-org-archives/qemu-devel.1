Received: from eggs.gnu.org ([2001:4830:134:3::10]:56571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIG-0001cM-Nb
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIF-0003UW-AL
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:00 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:59:21 +1000
Message-Id: <20170424015927.8933-42-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 41/47] ppc/pnv: populate device tree for IPMI BT
 devices
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

When an ipmi-bt device [1] is defined on the ISA bus, we need to
populate the device tree with the object properties. Such devices are
created with the command line options :

   -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10

[1] https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg03168.html

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index dfa21e4..977e126 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -354,6 +354,39 @@ static void powernv_populate_serial(ISADevice *d, vo=
id *fdt, int lpc_off)
     _FDT((fdt_setprop_string(fdt, node, "device_type", "serial")));
 }
=20
+static void powernv_populate_ipmi_bt(ISADevice *d, void *fdt, int lpc_of=
f)
+{
+    const char compatible[] =3D "bt\0ipmi-bt";
+    uint32_t io_base;
+    uint32_t io_regs[] =3D {
+        cpu_to_be32(1),
+        0, /* 'io_base' retrieved from the 'ioport' property of 'isa-ipm=
i-bt' */
+        cpu_to_be32(3)
+    };
+    uint32_t irq;
+    char *name;
+    int node;
+
+    io_base =3D object_property_get_int(OBJECT(d), "ioport", &error_fata=
l);
+    io_regs[1] =3D cpu_to_be32(io_base);
+
+    irq =3D object_property_get_int(OBJECT(d), "irq", &error_fatal);
+
+    name =3D g_strdup_printf("%s@i%x", qdev_fw_name(DEVICE(d)), io_base)=
;
+    node =3D fdt_add_subnode(fdt, lpc_off, name);
+    _FDT(node);
+    g_free(name);
+
+    fdt_setprop(fdt, node, "reg", io_regs, sizeof(io_regs));
+    fdt_setprop(fdt, node, "compatible", compatible, sizeof(compatible))=
;
+
+    /* Mark it as reserved to avoid Linux trying to claim it */
+    _FDT((fdt_setprop_string(fdt, node, "status", "reserved")));
+    _FDT((fdt_setprop_cell(fdt, node, "interrupts", irq)));
+    _FDT((fdt_setprop_cell(fdt, node, "interrupt-parent",
+                           fdt_get_phandle(fdt, lpc_off))));
+}
+
 typedef struct ForeachPopulateArgs {
     void *fdt;
     int offset;
@@ -368,6 +401,8 @@ static int powernv_populate_isa_device(DeviceState *d=
ev, void *opaque)
         powernv_populate_rtc(d, args->fdt, args->offset);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_ISA_SERIAL)) {
         powernv_populate_serial(d, args->fdt, args->offset);
+    } else if (object_dynamic_cast(OBJECT(dev), "isa-ipmi-bt")) {
+        powernv_populate_ipmi_bt(d, args->fdt, args->offset);
     } else {
         error_report("unknown isa device %s@i%x", qdev_fw_name(dev),
                      d->ioport_id);
--=20
2.9.3
