Received: from eggs.gnu.org ([2001:4830:134:3::10]:42141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkHR-0000VZ-LM
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkHN-0001R6-OU
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:21 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:52053)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cvkHN-0001QR-IW
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:17 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 8511B47D0C
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 14:43:16 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Apr 2017 14:41:37 +0200
Message-Id: <1491396106-26376-13-git-send-email-clg@kaod.org>
In-Reply-To: <1491396106-26376-1-git-send-email-clg@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/21] ppc/pnv: populate device tree for RTC
 devices
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

The code could be common to any ISA device but we are missing the IO
length.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index a3c8f6594d10..2f9c41e350d4 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -281,6 +281,26 @@ static void powernv_populate_chip(PnvChip *chip, voi=
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
@@ -288,6 +308,16 @@ typedef struct ForeachPopulateArgs {
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
2.7.4
