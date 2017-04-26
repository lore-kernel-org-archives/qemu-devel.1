Received: from eggs.gnu.org ([2001:4830:134:3::10]:56857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwv-0005R8-AI
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Gwl-00086W-Mm
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:01:17 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 26 Apr 2017 17:00:26 +1000
Message-Id: <20170426070034.10727-41-david@gibson.dropbear.id.au>
In-Reply-To: <20170426070034.10727-1-david@gibson.dropbear.id.au>
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 40/48] ppc/pnv: populate device tree for serial
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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8ab5bb1..dfa21e4 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -323,6 +323,37 @@ static void powernv_populate_rtc(ISADevice *d, void =
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
@@ -335,6 +366,8 @@ static int powernv_populate_isa_device(DeviceState *d=
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
2.9.3
