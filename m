Received: from eggs.gnu.org ([2001:4830:134:3::10]:44063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxZp4-0007i2-JC
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxZoz-0002Wm-QF
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:57:38 -0400
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:39192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxZoz-0002W2-Jg
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 09:57:33 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 6FA963577B
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 15:57:32 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 10 Apr 2017 15:56:55 +0200
Message-Id: <1491832618-27536-6-git-send-email-clg@kaod.org>
In-Reply-To: <1491832618-27536-1-git-send-email-clg@kaod.org>
References: <1491832618-27536-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/8] ppc/pnv: populate device tree for
 serial devices
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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 94e9744d7e67..7f2f9897f146 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -301,6 +301,37 @@ static void powernv_populate_rtc(ISADevice *d, void =
*fdt, int lpc_off)
     _FDT((fdt_setprop_string(fdt, node, "compatible", "pnpPNP,b00")));
 }
=20
+static void powernv_populate_serial(ISADevice *d, void *fdt, int lpc_off=
)
+{
+    const char compatible[] =3D "ns16550\0pnpPNP,501";
+    uint32_t io_base =3D d->ioport_id;
+    uint32_t io_regs[] =3D {
+        cpu_to_be32(1),
+        cpu_to_be32(io_base),
+        cpu_to_be32(8)
+    };
+    char *name;
+    int node;
+
+    name =3D g_strdup_printf("%s@i%x", qdev_fw_name(DEVICE(d)), io_base)=
;
+    node =3D fdt_add_subnode(fdt, lpc_off, name);
+    _FDT(node);
+    g_free(name);
+
+    _FDT((fdt_setprop(fdt, node, "reg", io_regs, sizeof(io_regs))));
+    _FDT((fdt_setprop(fdt, node, "compatible", compatible,
+                      sizeof(compatible))));
+
+    _FDT((fdt_setprop_cell(fdt, node, "clock-frequency", 1843200)));
+    _FDT((fdt_setprop_cell(fdt, node, "current-speed", 115200)));
+    _FDT((fdt_setprop_cell(fdt, node, "interrupts", d->isairq[0])));
+    _FDT((fdt_setprop_cell(fdt, node, "interrupt-parent",
+                           fdt_get_phandle(fdt, lpc_off))));
+
+    /* This is needed by Linux */
+    _FDT((fdt_setprop_string(fdt, node, "device_type", "serial")));
+}
+
 typedef struct ForeachPopulateArgs {
     void *fdt;
     int offset;
@@ -313,6 +344,8 @@ static int powernv_populate_isa_device(DeviceState *d=
ev, void *opaque)
=20
     if (object_dynamic_cast(OBJECT(dev), TYPE_MC146818_RTC)) {
         powernv_populate_rtc(d, args->fdt, args->offset);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_ISA_SERIAL)) {
+        powernv_populate_serial(d, args->fdt, args->offset);
     } else {
         error_report("unknown isa device %s@i%x", qdev_fw_name(dev),
                      d->ioport_id);
--=20
2.7.4
