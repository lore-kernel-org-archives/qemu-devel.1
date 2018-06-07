Received: from eggs.gnu.org ([2001:4830:134:3::10]:39285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCz-0002zt-B3
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fQxCu-0004Jx-J3
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:17 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:48847)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fQxCu-0004J7-92
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:52:12 -0400
Received: from player169.ha.ovh.net (unknown [10.109.122.104])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id EB68F186AC
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 17:52:10 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Jun 2018 17:49:56 +0200
Message-Id: <20180607155003.1580-22-clg@kaod.org>
In-Reply-To: <20180607155003.1580-1-clg@kaod.org>
References: <20180607155003.1580-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 21/28] spapr: add classes for the XIVE models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XIVE models for TCG and KVM will have a lot in common. Introduce
some classes to handle the differences, mostly to synchronize the
state with KVM for the monitor and migration. This is very much like
the XICS models.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_xive.h | 13 ++++++++
 include/hw/ppc/xive.h       | 29 +++++++++++++++++
 hw/intc/spapr_xive.c        | 32 ++++++++++++++++++
 hw/intc/xive.c              | 79 +++++++++++++++++++++++++++++++++++++++=
++++++
 4 files changed, 153 insertions(+)

diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 3cbf8dbefb87..1284784f1152 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -38,6 +38,19 @@ typedef struct sPAPRXive {
     MemoryRegion tm_mmio;
 } sPAPRXive;
=20
+#define SPAPR_XIVE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(sPAPRXiveClass, (klass), TYPE_SPAPR_XIVE)
+#define SPAPR_XIVE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(sPAPRXiveClass, (obj), TYPE_SPAPR_XIVE)
+
+typedef struct sPAPRXiveClass {
+    XiveRouterClass parent_class;
+
+    void (*synchronize_state)(sPAPRXive *xive);
+    void (*pre_save)(sPAPRXive *xsrc);
+    int (*post_load)(sPAPRXive *xsrc, int version_id);
+} sPAPRXiveClass;
+
 bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn, bool lsi);
 bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 378bd61c6d18..d943770efd9d 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -68,6 +68,20 @@ typedef struct XiveSource {
     XiveFabric      *xive;
 } XiveSource;
=20
+#define XIVE_SOURCE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(XiveSourceClass, (klass), TYPE_XIVE_SOURCE)
+#define XIVE_SOURCE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(XiveSourceClass, (obj), TYPE_XIVE_SOURCE)
+
+typedef struct XiveSourceClass {
+    SysBusDeviceClass parent_class;
+
+    void (*synchronize_state)(XiveSource *xsrc);
+    void (*reset)(XiveSource *xsrc);
+    void (*pre_save)(XiveSource *xsrc);
+    int (*post_load)(XiveSource *xsrc, int version_id);
+} XiveSourceClass;
+
 /*
  * ESB MMIO setting. Can be one page, for both source triggering and
  * source management, or two different pages. See below for magic
@@ -275,6 +289,21 @@ typedef struct XiveTCTX {
     XiveRouter  *xrtr;
 } XiveTCTX;
=20
+#define XIVE_TCTX_CLASS(klass) \
+     OBJECT_CLASS_CHECK(XiveTCTXClass, (klass), TYPE_XIVE_TCTX)
+#define XIVE_TCTX_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(XiveTCTXClass, (obj), TYPE_XIVE_TCTX)
+
+typedef struct XiveTCTXClass {
+    DeviceClass parent_class;
+
+    void (*realize)(XiveTCTX *tctx, Error **errp);
+    void (*synchronize_state)(XiveTCTX *tctx);
+    void (*reset)(XiveTCTX *tctx);
+    void (*pre_save)(XiveTCTX *tctx);
+    int (*post_load)(XiveTCTX *tctx, int version_id);
+} XiveTCTXClass;
+
 /*
  * XIVE Thread Interrupt Management Aera (TIMA)
  */
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 222c1266a547..91f9b28ebcc4 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -27,8 +27,13 @@
=20
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon)
 {
+    sPAPRXiveClass *sxc =3D SPAPR_XIVE_GET_CLASS(xive);
     int i;
=20
+    if (sxc->synchronize_state) {
+        sxc->synchronize_state(xive);
+    }
+
     xive_source_pic_print_info(&xive->source, 0, mon);
=20
     monitor_printf(mon, "IVE Table\n");
@@ -279,6 +284,30 @@ static const VMStateDescription vmstate_spapr_xive_e=
q =3D {
     },
 };
=20
+static int vmstate_spapr_xive_pre_save(void *opaque)
+{
+    sPAPRXive *xive =3D opaque;
+    sPAPRXiveClass *sxc =3D SPAPR_XIVE_GET_CLASS(xive);
+
+    if (sxc->pre_save) {
+        sxc->pre_save(xive);
+    }
+
+    return 0;
+}
+
+static int vmstate_spapr_xive_post_load(void *opaque, int version_id)
+{
+    sPAPRXive *xive =3D opaque;
+    sPAPRXiveClass *sxc =3D SPAPR_XIVE_GET_CLASS(xive);
+
+    if (sxc->post_load) {
+        sxc->post_load(xive, version_id);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_spapr_xive_ive =3D {
     .name =3D TYPE_SPAPR_XIVE "/ive",
     .version_id =3D 1,
@@ -293,6 +322,8 @@ static const VMStateDescription vmstate_spapr_xive =3D=
 {
     .name =3D TYPE_SPAPR_XIVE,
     .version_id =3D 1,
     .minimum_version_id =3D 1,
+    .pre_save =3D vmstate_spapr_xive_pre_save,
+    .post_load =3D vmstate_spapr_xive_post_load,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(ivt, sPAPRXive, nr_irqs,
@@ -336,6 +367,7 @@ static const TypeInfo spapr_xive_info =3D {
     .instance_init =3D spapr_xive_instance_init,
     .instance_size =3D sizeof(sPAPRXive),
     .class_init =3D spapr_xive_class_init,
+    .class_size =3D sizeof(sPAPRXiveClass),
 };
=20
 static void spapr_xive_register_types(void)
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 8d86f739522d..5cf9fc4e1cb3 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -438,9 +438,14 @@ static const struct {
=20
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon)
 {
+    XiveTCTXClass *xtc =3D XIVE_TCTX_GET_CLASS(tctx);
     int cpu_index =3D tctx->cs ? tctx->cs->cpu_index : -1;
     int i;
=20
+    if (xtc->synchronize_state) {
+        xtc->synchronize_state(tctx);
+    }
+
     monitor_printf(mon, "CPU[%04x]:   QW   NSR CPPR IPB LSMFB ACK# INC A=
GE PIPR"
                    "  W2\n", cpu_index);
=20
@@ -486,6 +491,7 @@ static uint32_t xive_tctx_hw_cam(XiveTCTX *tctx, bool=
 block_group)
 static void xive_tctx_reset(void *dev)
 {
     XiveTCTX *tctx =3D XIVE_TCTX(dev);
+    XiveTCTXClass *xtc =3D XIVE_TCTX_GET_CLASS(tctx);
     PowerPCCPU *cpu =3D POWERPC_CPU(tctx->cs);
     CPUPPCState *env =3D &cpu->env;
=20
@@ -512,11 +518,16 @@ static void xive_tctx_reset(void *dev)
             TM_QW1W2_VO | tctx_cam_line(tctx->xrtr->chip_id, cpu->vcpu_i=
d));
         memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &os_cam, 4);
     }
+
+    if (xtc->reset) {
+        xtc->reset(tctx);
+    }
 }
=20
 static void xive_tctx_realize(DeviceState *dev, Error **errp)
 {
     XiveTCTX *tctx =3D XIVE_TCTX(dev);
+    XiveTCTXClass *xtc =3D XIVE_TCTX_GET_CLASS(tctx);
     PowerPCCPU *cpu;
     CPUPPCState *env;
     Object *obj;
@@ -552,6 +563,10 @@ static void xive_tctx_realize(DeviceState *dev, Erro=
r **errp)
         return;
     }
=20
+    if (xtc->realize) {
+        xtc->realize(tctx, errp);
+    }
+
     qemu_register_reset(xive_tctx_reset, dev);
 }
=20
@@ -560,10 +575,36 @@ static void xive_tctx_unrealize(DeviceState *dev, E=
rror **errp)
     qemu_unregister_reset(xive_tctx_reset, dev);
 }
=20
+static int vmstate_xive_tctx_pre_save(void *opaque)
+{
+    XiveTCTX *tctx =3D opaque;
+    XiveTCTXClass *xnc =3D XIVE_TCTX_GET_CLASS(tctx);
+
+    if (xnc->pre_save) {
+        xnc->pre_save(tctx);
+    }
+
+    return 0;
+}
+
+static int vmstate_xive_tctx_post_load(void *opaque, int version_id)
+{
+    XiveTCTX *tctx =3D opaque;
+    XiveTCTXClass *xnc =3D XIVE_TCTX_GET_CLASS(tctx);
+
+    if (xnc->post_load) {
+        xnc->post_load(tctx, version_id);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_xive_tctx =3D {
     .name =3D TYPE_XIVE_TCTX,
     .version_id =3D 1,
     .minimum_version_id =3D 1,
+    .pre_save =3D vmstate_xive_tctx_pre_save,
+    .post_load =3D vmstate_xive_tctx_post_load,
     .fields =3D (VMStateField[]) {
         VMSTATE_BUFFER(regs, XiveTCTX),
         VMSTATE_END_OF_LIST()
@@ -585,6 +626,7 @@ static const TypeInfo xive_tctx_info =3D {
     .parent        =3D TYPE_DEVICE,
     .instance_size =3D sizeof(XiveTCTX),
     .class_init    =3D xive_tctx_class_init,
+    .class_size    =3D sizeof(XiveTCTXClass),
 };
=20
 Object *xive_tctx_create(Object *cpu, const char *type, XiveRouter *xrtr=
,
@@ -922,8 +964,13 @@ static void xive_source_set_irq(void *opaque, int sr=
cno, int val)
=20
 void xive_source_pic_print_info(XiveSource *xsrc, uint32_t offset, Monit=
or *mon)
 {
+    XiveSourceClass *xsc =3D XIVE_SOURCE_GET_CLASS(xsrc);
     int i;
=20
+    if (xsc->synchronize_state) {
+        xsc->synchronize_state(xsrc);
+    }
+
     monitor_printf(mon, "XIVE Source %8x ..%8x\n",
                    offset, offset + xsrc->nr_irqs - 1);
     for (i =3D 0; i < xsrc->nr_irqs; i++) {
@@ -944,11 +991,16 @@ void xive_source_pic_print_info(XiveSource *xsrc, u=
int32_t offset, Monitor *mon)
 static void xive_source_reset(DeviceState *dev)
 {
     XiveSource *xsrc =3D XIVE_SOURCE(dev);
+    XiveSourceClass *xsc =3D XIVE_SOURCE_GET_CLASS(xsrc);
=20
     /* Do not clear the LSI bitmap */
=20
     /* PQs are initialized to 0b01 which corresponds to "ints off" */
     memset(xsrc->status, 0x1, xsrc->nr_irqs);
+
+    if (xsc->reset) {
+        xsc->reset(xsrc);
+    }
 }
=20
 static void xive_source_realize(DeviceState *dev, Error **errp)
@@ -993,10 +1045,36 @@ static void xive_source_realize(DeviceState *dev, =
Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xsrc->esb_mmio);
 }
=20
+static int vmstate_xive_source_pre_save(void *opaque)
+{
+    XiveSource *xsrc =3D opaque;
+    XiveSourceClass *xsc =3D XIVE_SOURCE_GET_CLASS(xsrc);
+
+    if (xsc->pre_save) {
+        xsc->pre_save(xsrc);
+    }
+
+    return 0;
+}
+
+static int vmstate_xive_source_post_load(void *opaque, int version_id)
+{
+    XiveSource *xsrc =3D opaque;
+    XiveSourceClass *xsc =3D XIVE_SOURCE_GET_CLASS(xsrc);
+
+    if (xsc->post_load) {
+        xsc->post_load(xsrc, version_id);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_xive_source =3D {
     .name =3D TYPE_XIVE_SOURCE,
     .version_id =3D 1,
     .minimum_version_id =3D 1,
+    .pre_save =3D vmstate_xive_source_pre_save,
+    .post_load =3D vmstate_xive_source_post_load,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32_EQUAL(nr_irqs, XiveSource, NULL),
         VMSTATE_VBUFFER_UINT32(status, XiveSource, 1, NULL, nr_irqs),
@@ -1032,6 +1110,7 @@ static const TypeInfo xive_source_info =3D {
     .parent        =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(XiveSource),
     .class_init    =3D xive_source_class_init,
+    .class_size    =3D sizeof(XiveSourceClass),
 };
=20
 /*
--=20
2.13.6
