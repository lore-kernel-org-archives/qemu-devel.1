Received: from eggs.gnu.org ([209.51.188.92]:43351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tot-0001jM-DD
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tos-0001qg-Hr
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:31 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:59 +1100
Message-Id: <20190310082703.1245-57-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 56/60] ppc/pnv: add a "ibm,
 opal/power-mgt" device tree node on POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Activate only stop0 and stop1 levels. We should not need more levels
when under QEMU.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190307223548.20516-15-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index e68d419203..8be4d4cbf7 100644
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
