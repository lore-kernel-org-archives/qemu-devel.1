Received: from eggs.gnu.org ([209.51.188.92]:42994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toU-0001LE-1d
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2toT-0001Yh-2u
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:05 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:34 +1100
Message-Id: <20190310082703.1245-32-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 31/60] ppc/pnv: psi: add a PSIHB_REG macro
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

This is a simple helper to translate XSCOM addresses to MMIO addresses

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190306085032.15744-13-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_psi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index c872be0b9c..a2f8d0dece 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -114,6 +114,8 @@
 #define PSIHB_BAR_MASK                  0x0003fffffff00000ull
 #define PSIHB_FSPBAR_MASK               0x0003ffff00000000ull
=20
+#define PSIHB_REG(addr) (((addr) >> 3) + PSIHB_XSCOM_BAR)
+
 static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
 {
     MemoryRegion *sysmem =3D get_system_memory();
@@ -392,13 +394,13 @@ static void pnv_psi_reg_write(PnvPsi *psi, uint32_t=
 offset, uint64_t val,
  */
 static uint64_t pnv_psi_mmio_read(void *opaque, hwaddr addr, unsigned si=
ze)
 {
-    return pnv_psi_reg_read(opaque, (addr >> 3) + PSIHB_XSCOM_BAR, true)=
;
+    return pnv_psi_reg_read(opaque, PSIHB_REG(addr), true);
 }
=20
 static void pnv_psi_mmio_write(void *opaque, hwaddr addr,
                               uint64_t val, unsigned size)
 {
-    pnv_psi_reg_write(opaque, (addr >> 3) + PSIHB_XSCOM_BAR, val, true);
+    pnv_psi_reg_write(opaque, PSIHB_REG(addr), val, true);
 }
=20
 static const MemoryRegionOps psi_mmio_ops =3D {
--=20
2.20.1
