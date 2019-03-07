Received: from eggs.gnu.org ([209.51.188.92]:34335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21dR-0007di-1H
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:37:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21dQ-0003WO-2w
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:37:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38210
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h21dO-00029x-NO
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:37:02 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27MIas4071012
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 17:36:07 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r3b5qtm1r-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 17:36:06 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 7 Mar 2019 22:36:05 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Mar 2019 23:35:47 +0100
In-Reply-To: <20190307223548.20516-1-clg@kaod.org>
References: <20190307223548.20516-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190307223548.20516-15-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/15] ppc/pnv: add a "ibm,
 opal/power-mgt" device tree node on POWER9
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

Activate only stop0 and stop1 levels. We should not need more levels
when under QEMU.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index e68d419203e8..8be4d4cbf785 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -438,6 +438,16 @@ static void pnv_dt_isa(PnvMachineState *pnv, void *f=
dt)
                        &args);
 }
=20
+static void pnv_dt_power_mgt(void *fdt)
+{
+    int off;
+
+    off =3D fdt_add_subnode(fdt, 0, "ibm,opal");
+    off =3D fdt_add_subnode(fdt, off, "power-mgt");
+
+    _FDT(fdt_setprop_cell(fdt, off, "ibm,enabled-stop-levels", 0xc000000=
0));
+}
+
 static void *pnv_dt_create(MachineState *machine)
 {
     const char plat_compat[] =3D "qemu,powernv\0ibm,powernv";
@@ -493,6 +503,11 @@ static void *pnv_dt_create(MachineState *machine)
         pnv_dt_bmc_sensors(pnv->bmc, fdt);
     }
=20
+    /* Create an extra node for power management on Power9 */
+    if (pnv_is_power9(pnv)) {
+        pnv_dt_power_mgt(fdt);
+    }
+
     return fdt;
 }
=20
--=20
2.20.1
