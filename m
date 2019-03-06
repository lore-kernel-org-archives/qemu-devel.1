Received: from eggs.gnu.org ([209.51.188.92]:55018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGj-00066w-S5
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGg-0001eI-Pt
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGc-0001Gk-Rt
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:14 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mVn4147408
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:55 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r2a9vteeu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:54 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:52 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:17 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-13-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 12/27] ppc/pnv: psi: add a PSIHB_REG macro
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

This is a simple helper to translate XSCOM addresses to MMIO addresses

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_psi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index c872be0b9c0d..a2f8d0dece80 100644
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
