Received: from eggs.gnu.org ([209.51.188.92]:38340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3VB-00051h-B4
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3V9-0002lB-LR
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3V9-0002je-Al
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:47 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9hkg0003982
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:45 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q9xemjh3g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:45 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:46:42 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:07 +0100
In-Reply-To: <20190128094625.4428-1-clg@kaod.org>
References: <20190128094625.4428-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-2-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/19] ppc/xive: hardwire the Physical CAM line
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
 include/hw/ppc/xive.h |  1 +
 hw/intc/xive.c        | 53 ++++++++++++++++++++++++++++++++++++++++---
 hw/ppc/pnv_core.c     | 16 ++++++++-----
 3 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index ec3bb2aae45a..04d54e8315f7 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -319,6 +319,7 @@ typedef struct XiveTCTX {
     qemu_irq    output;
=20
     uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
+    uint32_t    hw_cam;
 } XiveTCTX;
=20
 /*
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 2e9b8efd4342..f5642f2338de 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -469,6 +469,12 @@ static void xive_tctx_realize(DeviceState *dev, Erro=
r **errp)
     Object *obj;
     Error *local_err =3D NULL;
=20
+    if (!tctx->hw_cam) {
+        error_setg(errp, "XIVE: HW CAM is not set for CPU %d",
+                   tctx->cs->cpu_index);
+        return;
+    }
+
     obj =3D object_property_get_link(OBJECT(dev), "cpu", &local_err);
     if (!obj) {
         error_propagate(errp, local_err);
@@ -509,11 +515,17 @@ static const VMStateDescription vmstate_xive_tctx =3D=
 {
     },
 };
=20
+static Property  xive_tctx_properties[] =3D {
+    DEFINE_PROP_UINT32("hw-cam", XiveTCTX, hw_cam, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void xive_tctx_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->desc =3D "XIVE Interrupt Thread Context";
+    dc->props =3D xive_tctx_properties;
     dc->realize =3D xive_tctx_realize;
     dc->unrealize =3D xive_tctx_unrealize;
     dc->vmsd =3D &vmstate_xive_tctx;
@@ -526,8 +538,21 @@ static const TypeInfo xive_tctx_info =3D {
     .class_init    =3D xive_tctx_class_init,
 };
=20
+/*
+ * The HW CAM line (23bits) is hardwired to :
+ *
+ *   0x000||0b1||4Bit chip number||7Bit Thread number.
+ */
+static uint32_t hw_cam_line(uint8_t chip_id, uint8_t tid)
+{
+    return 1 << 11 | (chip_id & 0xf) << 7 | (tid & 0x7f);
+}
+
 Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
 {
+    CPUPPCState *env =3D &POWERPC_CPU(cpu)->env;
+    uint32_t pir =3D env->spr_cb[SPR_PIR].default_value;
+    uint32_t hw_cam =3D hw_cam_line((pir >> 8) & 0xf, pir & 0x7f);
     Error *local_err =3D NULL;
     Object *obj;
=20
@@ -535,6 +560,10 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xr=
tr, Error **errp)
     object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
     object_unref(obj);
     object_property_add_const_link(obj, "cpu", cpu, &error_abort);
+    object_property_set_int(obj, hw_cam, "hw-cam", &local_err);
+    if (local_err) {
+        goto error;
+    }
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
         goto error;
@@ -1112,14 +1141,28 @@ XiveTCTX *xive_router_get_tctx(XiveRouter *xrtr, =
CPUState *cs)
     return xrc->get_tctx(xrtr, cs);
 }
=20
+/*
+ * When the block grouping is enabled, the CAM line is changed to :
+ *
+ *   4Bit chip number||0x001||7Bit Thread number.
+ */
+static bool xive_presenter_tctx_match_hw(XiveRouter *xrtr, XiveTCTX *tct=
x,
+                                         uint8_t nvt_blk, uint32_t nvt_i=
dx)
+{
+    /* TODO: block group support */
+    return tctx->hw_cam =3D=3D hw_cam_line(nvt_blk, nvt_idx);
+}
+
 /*
  * The thread context register words are in big-endian format.
  */
-static int xive_presenter_tctx_match(XiveTCTX *tctx, uint8_t format,
+static int xive_presenter_tctx_match(XiveRouter *xrtr,
+                                     XiveTCTX *tctx, uint8_t format,
                                      uint8_t nvt_blk, uint32_t nvt_idx,
                                      bool cam_ignore, uint32_t logic_ser=
v)
 {
     uint32_t cam =3D xive_nvt_cam_line(nvt_blk, nvt_idx);
+    uint32_t qw3w2 =3D xive_tctx_word2(&tctx->regs[TM_QW3_HV_PHYS]);
     uint32_t qw2w2 =3D xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
     uint32_t qw1w2 =3D xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
     uint32_t qw0w2 =3D xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
@@ -1142,7 +1185,11 @@ static int xive_presenter_tctx_match(XiveTCTX *tct=
x, uint8_t format,
=20
         /* F=3D0 & i=3D0: Specific NVT notification */
=20
-        /* TODO (PowerNV) : PHYS ring */
+        /* PHYS ring */
+        if ((be32_to_cpu(qw3w2) & TM_QW3W2_VT) &&
+            xive_presenter_tctx_match_hw(xrtr, tctx, nvt_blk, nvt_idx)) =
{
+            return TM_QW3_HV_PHYS;
+        }
=20
         /* HV POOL ring */
         if ((be32_to_cpu(qw2w2) & TM_QW2W2_VP) &&
@@ -1199,7 +1246,7 @@ static bool xive_presenter_match(XiveRouter *xrtr, =
uint8_t format,
          * Check the thread context CAM lines and record matches. We
          * will handle CPU exception delivery later
          */
-        ring =3D xive_presenter_tctx_match(tctx, format, nvt_blk, nvt_id=
x,
+        ring =3D xive_presenter_tctx_match(xrtr, tctx, format, nvt_blk, =
nvt_idx,
                                          cam_ignore, logic_serv);
         /*
          * Save the context and follow on to catch duplicates, that we
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 7c806da720c6..f035522b4ec9 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -114,12 +114,6 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvChi=
p *chip, Error **errp)
         return;
     }
=20
-    pcc->intc_create(chip, cpu, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
     core_pir =3D object_property_get_uint(OBJECT(cpu), "core-pir", &erro=
r_abort);
=20
     /*
@@ -129,6 +123,16 @@ static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvChi=
p *chip, Error **errp)
      */
     pir->default_value =3D core_pir + thread_index;
=20
+    /*
+     * On P9, the interrupt presenter needs to hardwire the PIR value
+     * in the thread interrupt context of the CPU.
+     */
+    pcc->intc_create(chip, cpu, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
=20
--=20
2.20.1
