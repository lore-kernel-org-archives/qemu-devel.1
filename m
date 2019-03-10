Received: from eggs.gnu.org ([209.51.188.92]:43004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toU-0001LO-4C
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toT-0001Yp-3R
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:06 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:35 +1100
Message-Id: <20190310082703.1245-33-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/60] ppc/pnv: psi: add a reset handler
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

Reset all regs but keep the MMIO BAR enabled as it is at realize time.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190306085032.15744-14-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_psi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index a2f8d0dece..e61861bfd3 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -442,6 +442,15 @@ static const MemoryRegionOps pnv_psi_xscom_ops =3D {
     }
 };
=20
+static void pnv_psi_reset(void *dev)
+{
+    PnvPsi *psi =3D PNV_PSI(dev);
+
+    memset(psi->regs, 0x0, sizeof(psi->regs));
+
+    psi->regs[PSIHB_XSCOM_BAR] =3D psi->bar | PSIHB_BAR_EN;
+}
+
 static void pnv_psi_init(Object *obj)
 {
     PnvPsi *psi =3D PNV_PSI(obj);
@@ -511,6 +520,8 @@ static void pnv_psi_realize(DeviceState *dev, Error *=
*errp)
         psi->regs[xivr] =3D PSIHB_XIVR_PRIO_MSK |
             ((uint64_t) i << PSIHB_XIVR_SRC_SH);
     }
+
+    qemu_register_reset(pnv_psi_reset, dev);
 }
=20
 static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
--=20
2.20.1
