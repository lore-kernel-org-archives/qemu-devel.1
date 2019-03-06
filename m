Received: from eggs.gnu.org ([209.51.188.92]:54766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGV-0005zW-Hj
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGR-0001NZ-CG
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGP-0001Ct-Sf
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:50:59 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268maHv046117
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:48 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r29u4c1j0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:48 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:46 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:06 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-2-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/27] ppc/xive: hardwire the Physical CAM line
 of the thread context
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

By default on P9, the HW CAM line (23bits) is hardwired to :

      0x000||0b1||4Bit chip number||7Bit Thread number.

When the block group mode is enabled at the controller level (PowerNV),
the CAM line is changed for CAM compares to :

      4Bit chip number||0x001||7Bit Thread number

This will require changes in xive_presenter_tctx_match() possibly.
This is a lowlevel functionality of the HW controller and it is not
strictly needed. Leave it for later.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index daa7badc8492..b21759c93856 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1112,6 +1112,30 @@ XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, C=
PUState *cs)
     return xrc->get_tctx(xrtr, cs);
 }
=20
+/*
+ * By default on P9, the HW CAM line (23bits) is hardwired to :
+ *
+ *   0x000||0b1||4Bit chip number||7Bit Thread number.
+ *
+ * When the block grouping is enabled, the CAM line is changed to :
+ *
+ *   4Bit chip number||0x001||7Bit Thread number.
+ */
+static uint32_t hw_cam_line(uint8_t chip_id, uint8_t tid)
+{
+    return 1 << 11 | (chip_id & 0xf) << 7 | (tid & 0x7f);
+}
+
+static bool xive_presenter_tctx_match_hw(XiveTCTX *tctx,
+                                         uint8_t nvt_blk, uint32_t nvt_i=
dx)
+{
+    CPUPPCState *env =3D &POWERPC_CPU(tctx->cs)->env;
+    uint32_t pir =3D env->spr_cb[SPR_PIR].default_value;
+
+    return hw_cam_line((pir >> 8) & 0xf, pir & 0x7f) =3D=3D
+        hw_cam_line(nvt_blk, nvt_idx);
+}
+
 /*
  * The thread context register words are in big-endian format.
  */
@@ -1120,6 +1144,7 @@ static int xive_presenter_tctx_match(XiveTCTX *tctx=
, uint8_t format,
                                      bool cam_ignore, uint32_t logic_ser=
v)
 {
     uint32_t cam =3D xive_nvt_cam_line(nvt_blk, nvt_idx);
+    uint32_t qw3w2 =3D xive_tctx_word2(&tctx->regs[TM_QW3_HV_PHYS]);
     uint32_t qw2w2 =3D xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
     uint32_t qw1w2 =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
     uint32_t qw0w2 =3D xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
@@ -1142,7 +1167,11 @@ static int xive_presenter_tctx_match(XiveTCTX *tct=
x, uint8_t format,
=20
         /* F=3D0 & i=3D0: Specific NVT notification */
=20
-        /* TODO (PowerNV) : PHYS ring */
+        /* PHYS ring */
+        if ((be32_to_cpu(qw3w2) & TM_QW3W2_VT) &&
+            xive_presenter_tctx_match_hw(tctx, nvt_blk, nvt_idx)) {
+            return TM_QW3_HV_PHYS;
+        }
=20
         /* HV POOL ring */
         if ((be32_to_cpu(qw2w2) & TM_QW2W2_VP) &&
--=20
2.20.1
