Received: from eggs.gnu.org ([209.51.188.92]:42792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to6-0000ut-8P
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to4-0001K3-Kp
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:24 +1100
Message-Id: <20190310082703.1245-22-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/60] ppc/xive: hardwire the Physical CAM line
 of the thread context
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

By default on P9, the HW CAM line (23bits) is hardwired to :

      0x000||0b1||4Bit chip number||7Bit Thread number.

When the block group mode is enabled at the controller level (PowerNV),
the CAM line is changed for CAM compares to :

      4Bit chip number||0x001||7Bit Thread number

This will require changes in xive_presenter_tctx_match() possibly.
This is a lowlevel functionality of the HW controller and it is not
strictly needed. Leave it for later.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190306085032.15744-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xive.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index daa7badc84..b21759c938 100644
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
