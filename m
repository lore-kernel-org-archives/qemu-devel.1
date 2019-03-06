Received: from eggs.gnu.org ([209.51.188.92]:55483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SH5-0006dT-Gz
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SH4-00025C-B6
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34882
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SH3-0001Ut-QR
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:37 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268nKtP115840
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:51:02 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r2a1ebchr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:51:01 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:51:00 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:30 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-26-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 25/27] ppc/pnv: add more dummy XSCOM addresses
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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_xscom.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 46fae41f32b0..c285ef514e88 100644
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
