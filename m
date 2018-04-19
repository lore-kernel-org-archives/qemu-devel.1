Received: from eggs.gnu.org ([2001:4830:134:3::10]:58019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wo-00013M-Ft
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:46:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98wk-0000g8-It
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:58 -0400
Received: from 12.mo1.mail-out.ovh.net ([87.98.162.229]:38248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98wk-0000f6-7v
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:45:54 -0400
Received: from player792.ha.ovh.net (unknown [10.109.122.78])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id AA69AF025C
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:45:52 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:18 +0200
Message-Id: <20180419124331.3915-23-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 22/35] spapr: add classes for the XIVE models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The XIVE models for the emulated and the KVM mode will have a lot in
common. Introduce some classes to handle the differences, mostly to
synchronize the state with KVM for the monitor and migration. This is
very much like XICS is doing.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c        | 32 ++++++++++++++++++
 hw/intc/xive.c              | 79 +++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/spapr_xive.h | 13 ++++++++
 include/hw/ppc/xive.h       | 30 +++++++++++++++++
 4 files changed, 154 insertions(+)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 98e067bfc90c..f0c2fe52b3c6 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -20,8 +20,13 @@
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
     xive_source_pic_print_info(&xive->source, mon);
=20
     monitor_printf(mon, "IVE Table\n");
@@ -150,6 +155,30 @@ static XiveEQ *spapr_xive_get_eq(XiveFabric *xf, uin=
t32_t eq_idx)
     return xive_nvt_eq_get(nvt, SPAPR_XIVE_EQ_PRIO(eq_idx));
 }
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
@@ -164,6 +193,8 @@ static const VMStateDescription vmstate_spapr_xive =3D=
 {
     .name =3D TYPE_SPAPR_XIVE,
     .version_id =3D 1,
     .minimum_version_id =3D 1,
+    .pre_save =3D vmstate_spapr_xive_pre_save,
+    .post_load =3D vmstate_spapr_xive_post_load,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(ivt, sPAPRXive, nr_irqs,
@@ -199,6 +230,7 @@ static const TypeInfo spapr_xive_info =3D {
     .instance_init =3D spapr_xive_init,
     .instance_size =3D sizeof(sPAPRXive),
     .class_init =3D spapr_xive_class_init,
+    .class_size =3D sizeof(sPAPRXiveClass),
     .interfaces =3D (InterfaceInfo[]) {
             { TYPE_XIVE_FABRIC },
             { },
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 2daa36f77a6b..11af3bf1184a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -349,9 +349,14 @@ static char *xive_nvt_ring_print(uint8_t *ring)
=20
 void xive_nvt_pic_print_info(XiveNVT *nvt, Monitor *mon)
 {
+    XiveNVTClass *xnc =3D XIVE_NVT_GET_CLASS(nvt);
     int cpu_index =3D nvt->cs ? nvt->cs->cpu_index : -1;
     char *s;
=20
+    if (xnc->synchronize_state) {
+        xnc->synchronize_state(nvt);
+    }
+
     monitor_printf(mon, "CPU[%04x]: QW    NSR CPPR IPB LSMFB ACK# INC AG=
E PIPR"
                    " W2\n", cpu_index);
=20
@@ -366,6 +371,7 @@ void xive_nvt_pic_print_info(XiveNVT *nvt, Monitor *m=
on)
 static void xive_nvt_reset(void *dev)
 {
     XiveNVT *nvt =3D XIVE_NVT(dev);
+    XiveNVTClass *xnc =3D XIVE_NVT_GET_CLASS(nvt);
     int i;
=20
     memset(nvt->regs, 0, sizeof(nvt->regs));
@@ -378,11 +384,16 @@ static void xive_nvt_reset(void *dev)
     for (i =3D 0; i < ARRAY_SIZE(nvt->eqt); i++) {
         xive_eq_reset(&nvt->eqt[i]);
     }
+
+    if (xnc->reset) {
+        xnc->reset(nvt);
+    }
 }
=20
 static void xive_nvt_realize(DeviceState *dev, Error **errp)
 {
     XiveNVT *nvt =3D XIVE_NVT(dev);
+    XiveNVTClass *xnc =3D XIVE_NVT_GET_CLASS(nvt);
     PowerPCCPU *cpu;
     CPUPPCState *env;
     Object *obj;
@@ -410,6 +421,10 @@ static void xive_nvt_realize(DeviceState *dev, Error=
 **errp)
         return;
     }
=20
+    if (xnc->realize) {
+        xnc->realize(nvt, errp);
+    }
+
     qemu_register_reset(xive_nvt_reset, dev);
 }
=20
@@ -442,10 +457,36 @@ static const VMStateDescription vmstate_xive_nvt_eq=
 =3D {
     },
 };
=20
+static int vmstate_xive_nvt_pre_save(void *opaque)
+{
+    XiveNVT *nvt =3D opaque;
+    XiveNVTClass *xnc =3D XIVE_NVT_GET_CLASS(nvt);
+
+    if (xnc->pre_save) {
+        xnc->pre_save(nvt);
+    }
+
+    return 0;
+}
+
+static int vmstate_xive_nvt_post_load(void *opaque, int version_id)
+{
+    XiveNVT *nvt =3D opaque;
+    XiveNVTClass *xnc =3D XIVE_NVT_GET_CLASS(nvt);
+
+    if (xnc->post_load) {
+        xnc->post_load(nvt, version_id);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_xive_nvt =3D {
     .name =3D TYPE_XIVE_NVT,
     .version_id =3D 1,
     .minimum_version_id =3D 1,
+    .pre_save =3D vmstate_xive_nvt_pre_save,
+    .post_load =3D vmstate_xive_nvt_post_load,
     .fields =3D (VMStateField[]) {
         VMSTATE_BUFFER(regs, XiveNVT),
         VMSTATE_STRUCT_ARRAY(eqt, XiveNVT, (XIVE_PRIORITY_MAX + 1), 1,
@@ -470,6 +511,7 @@ static const TypeInfo xive_nvt_info =3D {
     .instance_size =3D sizeof(XiveNVT),
     .instance_init =3D xive_nvt_init,
     .class_init    =3D xive_nvt_class_init,
+    .class_size    =3D sizeof(XiveNVTClass),
 };
=20
 /*
@@ -819,8 +861,13 @@ static void xive_source_set_irq(void *opaque, int sr=
cno, int val)
=20
 void xive_source_pic_print_info(XiveSource *xsrc, Monitor *mon)
 {
+    XiveSourceClass *xsc =3D XIVE_SOURCE_GET_CLASS(xsrc);
     int i;
=20
+    if (xsc->synchronize_state) {
+        xsc->synchronize_state(xsrc);
+    }
+
     monitor_printf(mon, "XIVE Source %6x ..%6x\n",
                    xsrc->offset, xsrc->offset + xsrc->nr_irqs - 1);
     for (i =3D 0; i < xsrc->nr_irqs; i++) {
@@ -840,6 +887,7 @@ void xive_source_pic_print_info(XiveSource *xsrc, Mon=
itor *mon)
 static void xive_source_reset(DeviceState *dev)
 {
     XiveSource *xsrc =3D XIVE_SOURCE(dev);
+    XiveSourceClass *xsc =3D XIVE_SOURCE_GET_CLASS(xsrc);
     int i;
=20
     /* Keep the IRQ type */
@@ -849,6 +897,10 @@ static void xive_source_reset(DeviceState *dev)
=20
     /* SBEs are initialized to 0b01 which corresponds to "ints off" */
     memset(xsrc->sbe, 0x55, xsrc->sbe_size);
+
+    if (xsc->reset) {
+        xsc->reset(xsrc);
+    }
 }
=20
 static void xive_source_realize(DeviceState *dev, Error **errp)
@@ -895,10 +947,36 @@ static void xive_source_realize(DeviceState *dev, E=
rror **errp)
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
         VMSTATE_VBUFFER_UINT32(sbe, XiveSource, 1, NULL, sbe_size),
@@ -934,6 +1012,7 @@ static const TypeInfo xive_source_info =3D {
     .parent        =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(XiveSource),
     .class_init    =3D xive_source_class_init,
+    .class_size    =3D sizeof(XiveSourceClass),
 };
=20
 static void xive_register_types(void)
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index df87e68b3d05..41e2784403b2 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -32,6 +32,19 @@ typedef struct sPAPRXive {
     MemoryRegion tm_mmio_os;
 } sPAPRXive;
=20
+#define SPAPR_XIVE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(sPAPRXiveClass, (klass), TYPE_SPAPR_XIVE)
+#define SPAPR_XIVE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(sPAPRXiveClass, (obj), TYPE_SPAPR_XIVE)
+
+typedef struct sPAPRXiveClass {
+    SysBusDeviceClass parent_class;
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
index 24ce58812a7c..36de10af0109 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -60,6 +60,20 @@ typedef struct XiveSource {
     XiveFabric   *xive;
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
@@ -186,6 +200,22 @@ typedef struct XiveNVT {
     XiveEQ    eqt[XIVE_PRIORITY_MAX + 1];
 } XiveNVT;
=20
+
+#define XIVE_NVT_CLASS(klass) \
+     OBJECT_CLASS_CHECK(XiveNVTClass, (klass), TYPE_XIVE_NVT)
+#define XIVE_NVT_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(XiveNVTClass, (obj), TYPE_XIVE_NVT)
+
+typedef struct XiveNVTClass {
+    DeviceClass parent_class;
+
+    void (*realize)(XiveNVT *nvt, Error **errp);
+    void (*synchronize_state)(XiveNVT *nvt);
+    void (*reset)(XiveNVT *nvt);
+    void (*pre_save)(XiveNVT *nvt);
+    int (*post_load)(XiveNVT *nvt, int version_id);
+} XiveNVTClass;
+
 extern const MemoryRegionOps xive_tm_user_ops;
 extern const MemoryRegionOps xive_tm_os_ops;
=20
--=20
2.13.6
