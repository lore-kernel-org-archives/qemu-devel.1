Received: from eggs.gnu.org ([2001:4830:134:3::10]:44078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxZp7-0007l4-Uy
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxZp3-0002Z8-Tw
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:57:42 -0400
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:59557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxZp3-0002Yd-Ms
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:57:37 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 8D38C3576F
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 15:57:36 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 10 Apr 2017 15:56:56 +0200
Message-Id: <1491832618-27536-7-git-send-email-clg@kaod.org>
In-Reply-To: <1491832618-27536-1-git-send-email-clg@kaod.org>
References: <1491832618-27536-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 6/8] ppc/pnv: populate device tree for IPMI
 BT devices
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

When an ipmi-bt device [1] is defined on the ISA bus, we need to
populate the device tree with the object properties. Such devices are
created with the command line options :

   -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10

[1] https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg03168.html

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes sinve v1:

 - reworked the assignement of the ISA IO base in the 'reg' array
   property
=20
 hw/ppc/pnv.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7f2f9897f146..ec5d62a479b3 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -332,6 +332,39 @@ static void powernv_populate_serial(ISADevice *d, vo=
id *fdt, int lpc_off)
     _FDT((fdt_setprop_string(fdt, node, "device_type", "serial")));
 }
=20
+static void powernv_populate_ipmi_bt(ISADevice *d, void *fdt, int lpc_of=
f)
+{
+    const char compatible[] =3D "bt\0ipmi-bt";
+    uint32_t io_base =3D 0x0;
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
@@ -346,6 +379,8 @@ static int powernv_populate_isa_device(DeviceState *d=
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
2.7.4
