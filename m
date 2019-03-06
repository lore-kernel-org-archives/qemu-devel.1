Received: from eggs.gnu.org ([209.51.188.92]:55468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SH5-0006dI-BY
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SH3-00023Q-3l
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47748
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SH0-0001GH-Sz
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:36 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mjo4192233
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:55 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r29pact38-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:54 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:53 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:18 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-14-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/27] ppc/pnv: psi: add a reset handler
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

Reset all regs but keep the MMIO BAR enabled as it is at realize time.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_psi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index a2f8d0dece80..e61861bfd3c6 100644
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
