Received: from eggs.gnu.org ([2001:4830:134:3::10]:56871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIN-0001hG-Ry
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TIM-0003bb-V4
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:07 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:59:19 +1000
Message-Id: <20170424015927.8933-40-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 39/47] ppc/pnv: populate device tree for RTC
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

The code could be common to any ISA device but we are missing the IO
length.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c445906..8ab5bb1 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -303,6 +303,26 @@ static void powernv_populate_chip(PnvChip *chip, voi=
d *fdt)
     g_free(typename);
 }
=20
+static void powernv_populate_rtc(ISADevice *d, void *fdt, int lpc_off)
+{
+    uint32_t io_base =3D d->ioport_id;
+    uint32_t io_regs[] =3D {
+        cpu_to_be32(1),
+        cpu_to_be32(io_base),
+        cpu_to_be32(2)
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
+    _FDT((fdt_setprop_string(fdt, node, "compatible", "pnpPNP,b00")));
+}
+
 typedef struct ForeachPopulateArgs {
     void *fdt;
     int offset;
@@ -310,6 +330,16 @@ typedef struct ForeachPopulateArgs {
=20
 static int powernv_populate_isa_device(DeviceState *dev, void *opaque)
 {
+    ForeachPopulateArgs *args =3D opaque;
+    ISADevice *d =3D ISA_DEVICE(dev);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_MC146818_RTC)) {
+        powernv_populate_rtc(d, args->fdt, args->offset);
+    } else {
+        error_report("unknown isa device %s@i%x", qdev_fw_name(dev),
+                     d->ioport_id);
+    }
+
     return 0;
 }
=20
--=20
2.9.3
