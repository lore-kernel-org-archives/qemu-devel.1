Received: from eggs.gnu.org ([2001:4830:134:3::10]:54468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTSoM-0007oL-AQ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTSoI-000088-EG
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:14 -0400
Received: from 20.mo7.mail-out.ovh.net ([46.105.49.208]:58053)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fTSoI-00007p-6y
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:10 -0400
Received: from player738.ha.ovh.net (unknown [10.109.108.37])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 9043FB3829
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 16:01:08 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 14 Jun 2018 16:00:40 +0200
Message-Id: <20180614140043.9231-4-clg@kaod.org>
In-Reply-To: <20180614140043.9231-1-clg@kaod.org>
References: <20180614140043.9231-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/6] ppc/pnv: introduce an 'isa_bus_name' field
 under the LPC model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This is again a small cleanup to hide to the machine the details of
the ISA bus. The ISA bus device tree nodename will be different on
Power9.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv_lpc.h | 1 +
 hw/ppc/pnv.c             | 9 +--------
 hw/ppc/pnv_lpc.c         | 4 ++++
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index fb4b7b83d798..e8f7dcb9bfe9 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -70,6 +70,7 @@ typedef struct PnvLpcController {
     PnvPsi *psi;
=20
     bool   primary;
+    char   *isa_bus_name;
 } PnvLpcController;
=20
 ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, int chip_type);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d2126ee4affc..72cfe4c2627c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -267,14 +267,7 @@ static void pnv_dt_icp(PnvChip *chip, void *fdt, uin=
t32_t pir,
=20
 static int pnv_chip_lpc_offset(PnvChip *chip, void *fdt)
 {
-    char *name;
-    int offset;
-
-    name =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
-                           (uint64_t) PNV_XSCOM_BASE(chip), PNV_XSCOM_LP=
C_BASE);
-    offset =3D fdt_path_offset(fdt, name);
-    g_free(name);
-    return offset;
+    return fdt_path_offset(fdt, chip->lpc.isa_bus_name);
 }
=20
 static void pnv_dt_chip(PnvChip *chip, void *fdt)
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 7c6c012d5176..7f13c4bcf52c 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -481,6 +481,10 @@ static void pnv_lpc_realize(DeviceState *dev, Error =
**errp)
     pnv_xscom_region_init(&lpc->xscom_regs, OBJECT(dev),
                           &pnv_lpc_xscom_ops, lpc, "xscom-lpc",
                           PNV_XSCOM_LPC_SIZE);
+
+    lpc->isa_bus_name =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
+                                        (uint64_t) PNV_XSCOM_BASE(chip),
+                                        PNV_XSCOM_LPC_BASE);
 }
=20
 static void pnv_lpc_class_init(ObjectClass *klass, void *data)
--=20
2.13.6
