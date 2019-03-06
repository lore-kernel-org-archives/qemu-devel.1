Received: from eggs.gnu.org ([209.51.188.92]:55146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGq-0006GQ-RZ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGo-0001lf-Sp
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGk-0001WG-JE
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:21 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mWS4000702
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:51:03 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r2a9vtenr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:51:02 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:51:00 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:31 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-27-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 26/27] ppc/pnv: add a "ibm,
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

Activate stop0 and stop1 levels.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 30153ad5acea..9d40b006c0af 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -456,6 +456,16 @@ static void pnv_dt_isa(PnvMachineState *pnv, void *f=
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
@@ -511,6 +521,11 @@ static void *pnv_dt_create(MachineState *machine)
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
