Received: from eggs.gnu.org ([209.51.188.92]:34339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21dR-0007dr-58
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:37:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21dQ-0003Wl-4W
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:37:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40552
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h21dO-0001zC-P3
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:37:03 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27MIac1057220
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 17:36:01 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r3a2snp0j-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 17:36:00 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 7 Mar 2019 22:35:59 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Mar 2019 23:35:38 +0100
In-Reply-To: <20190307223548.20516-1-clg@kaod.org>
References: <20190307223548.20516-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190307223548.20516-6-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/15] ppc/pnv: add a 'dt_isa_nodename' to
 the chip
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

The ISA bus has a different DT nodename on POWER9. Compute the name
when the PnvChip is realized, that is before it is used by the machine
to populate the device tree with the ISA devices.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h |  2 ++
 hw/ppc/pnv.c         | 18 +++++-------------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 8d80cb34eebb..c81f157f41a9 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -58,6 +58,8 @@ typedef struct PnvChip {
     MemoryRegion xscom_mmio;
     MemoryRegion xscom;
     AddressSpace xscom_as;
+
+    gchar        *dt_isa_nodename;
 } PnvChip;
=20
 #define TYPE_PNV8_CHIP "pnv8-chip"
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 922e3ec48bb5..6625562d276d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -417,24 +417,12 @@ static int pnv_dt_isa_device(DeviceState *dev, void=
 *opaque)
     return 0;
 }
=20
-static int pnv_chip_isa_offset(PnvChip *chip, void *fdt)
-{
-    char *name;
-    int offset;
-
-    name =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x",
-                           (uint64_t) PNV_XSCOM_BASE(chip), PNV_XSCOM_LP=
C_BASE);
-    offset =3D fdt_path_offset(fdt, name);
-    g_free(name);
-    return offset;
-}
-
 /* The default LPC bus of a multichip system is on chip 0. It's
  * recognized by the firmware (skiboot) using a "primary" property.
  */
 static void pnv_dt_isa(PnvMachineState *pnv, void *fdt)
 {
-    int isa_offset =3D pnv_chip_isa_offset(pnv->chips[0], fdt);
+    int isa_offset =3D fdt_path_offset(fdt, pnv->chips[0]->dt_isa_nodena=
me);
     ForeachPopulateArgs args =3D {
         .fdt =3D fdt,
         .offset =3D isa_offset,
@@ -866,6 +854,10 @@ static void pnv_chip_power8_realize(DeviceState *dev=
, Error **errp)
                              &error_fatal);
     pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip8->lpc.xscom_=
regs);
=20
+    chip->dt_isa_nodename =3D g_strdup_printf("/xscom@%" PRIx64 "/isa@%x=
",
+                                            (uint64_t) PNV_XSCOM_BASE(ch=
ip),
+                                            PNV_XSCOM_LPC_BASE);
+
     /* Interrupt Management Area. This is the memory region holding
      * all the Interrupt Control Presenter (ICP) registers */
     pnv_chip_icp_realize(chip8, &local_err);
--=20
2.20.1
