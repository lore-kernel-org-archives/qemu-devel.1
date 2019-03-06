Received: from eggs.gnu.org ([209.51.188.92]:55535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SHC-0006ls-No
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SH4-000267-UL
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SH3-0001QZ-Rh
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:38 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mU5r124263
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:59 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r2a8ejvmk-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:59 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:56 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:27 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-23-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 22/27] ppc/pnv: extend XSCOM core support for
 POWER9
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

Add a couple of XSCOM addresses controlling the power management
states of the core.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_core.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 38179cdc53dc..c3d6350dc90a 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -60,6 +60,12 @@ static void pnv_cpu_reset(void *opaque)
 #define PNV_XSCOM_EX_DTS_RESULT0     0x50000
 #define PNV_XSCOM_EX_DTS_RESULT1     0x50001
=20
+/*
+ * POWER9 core controls
+ */
+#define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP 0xf010d
+#define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR 0xf010a
+
 static uint64_t pnv_core_xscom_read(void *opaque, hwaddr addr,
                                     unsigned int width)
 {
@@ -74,6 +80,10 @@ static uint64_t pnv_core_xscom_read(void *opaque, hwad=
dr addr,
     case PNV_XSCOM_EX_DTS_RESULT1:
         val =3D 0x24f000000000000ull;
         break;
+    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP:
+    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
+        val =3D 0x0;
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "Warning: reading reg=3D0x%" HWADDR_PRI=
x "\n",
                   addr);
@@ -85,8 +95,16 @@ static uint64_t pnv_core_xscom_read(void *opaque, hwad=
dr addr,
 static void pnv_core_xscom_write(void *opaque, hwaddr addr, uint64_t val=
,
                                  unsigned int width)
 {
-    qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=3D0x%" HWADDR_PRIx=
 "\n",
-                  addr);
+    uint32_t offset =3D addr >> 3;
+
+    switch (offset) {
+    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP:
+    case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=3D0x%" HWADDR_=
PRIx "\n",
+                      addr);
+    }
 }
=20
 static const MemoryRegionOps pnv_core_xscom_ops =3D {
--=20
2.20.1
