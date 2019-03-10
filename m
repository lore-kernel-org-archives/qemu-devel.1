Received: from eggs.gnu.org ([209.51.188.92]:43832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpa-0002TL-9d
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpZ-0002Iw-Dm
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:29:14 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:58 +1100
Message-Id: <20190310082703.1245-56-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 55/60] ppc/pnv: add more dummy XSCOM addresses
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

To improve OPAL/skiboot support. We don't need to strictly model these
XSCOM accesses.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190307223548.20516-14-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_xscom.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 46fae41f32..c285ef514e 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -64,11 +64,21 @@ static uint64_t xscom_read_default(PnvChip *chip, uin=
t32_t pcba)
     switch (pcba) {
     case 0xf000f:
         return PNV_CHIP_GET_CLASS(chip)->chip_cfam_id;
+    case 0x18002:       /* ECID2 */
+        return 0;
+
     case 0x1010c00:     /* PIBAM FIR */
     case 0x1010c03:     /* PIBAM FIR MASK */
-    case 0x2020007:     /* ADU stuff */
-    case 0x2020009:     /* ADU stuff */
-    case 0x202000f:     /* ADU stuff */
+
+        /* P9 xscom reset */
+    case 0x0090018:     /* Receive status reg */
+    case 0x0090012:     /* log register */
+    case 0x0090013:     /* error register */
+
+        /* P8 xscom reset */
+    case 0x2020007:     /* ADU stuff, log register */
+    case 0x2020009:     /* ADU stuff, error register */
+    case 0x202000f:     /* ADU stuff, receive status register*/
         return 0;
     case 0x2013f00:     /* PBA stuff */
     case 0x2013f01:     /* PBA stuff */
@@ -100,9 +110,20 @@ static bool xscom_write_default(PnvChip *chip, uint3=
2_t pcba, uint64_t val)
     case 0x1010c03:     /* PIBAM FIR MASK */
     case 0x1010c04:     /* PIBAM FIR MASK */
     case 0x1010c05:     /* PIBAM FIR MASK */
-    case 0x2020007:     /* ADU stuff */
-    case 0x2020009:     /* ADU stuff */
-    case 0x202000f:     /* ADU stuff */
+        /* P9 xscom reset */
+    case 0x0090018:     /* Receive status reg */
+    case 0x0090012:     /* log register */
+    case 0x0090013:     /* error register */
+
+        /* P8 xscom reset */
+    case 0x2020007:     /* ADU stuff, log register */
+    case 0x2020009:     /* ADU stuff, error register */
+    case 0x202000f:     /* ADU stuff, receive status register*/
+
+    case 0x2013028:     /* CAPP stuff */
+    case 0x201302a:     /* CAPP stuff */
+    case 0x2013801:     /* CAPP stuff */
+    case 0x2013802:     /* CAPP stuff */
         return true;
     default:
         return false;
--=20
2.20.1
