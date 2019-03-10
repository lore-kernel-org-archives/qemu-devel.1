Received: from eggs.gnu.org ([209.51.188.92]:44146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tq0-0002vT-LB
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpe-0002Mk-NF
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:29:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:27:03 +1100
Message-Id: <20190310082703.1245-61-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 60/60] spapr: Use CamelCase properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The qemu coding standard is to use CamelCase for type and structure names=
,
and the pseries code follows that... sort of.  There are quite a lot of
places where we bend the rules in order to preserve the capitalization of
internal acronyms like "PHB", "TCE", "DIMM" and most commonly "sPAPR".

That was a bad idea - it frequently leads to names ending up with hard to
read clusters of capital letters, and means they don't catch the eye as
type identifiers, which is kind of the point of the CamelCase convention =
in
the first place.

In short, keeping type identifiers look like CamelCase is more important
than preserving standard capitalization of internal "words".  So, this
patch renames a heap of spapr internal type names to a more standard
CamelCase.

In addition to case changes, we also make some other identifier renames:
  VIOsPAPR* -> SpaprVio*
    The reverse word ordering was only ever used to mitigate the capital
    cluster, so revert to the natural ordering.
  VIOsPAPRVTYDevice -> SpaprVioVty
  VIOsPAPRVLANDevice -> SpaprVioVlan
    Brevity, since the "Device" didn't add useful information
  sPAPRDRConnector -> SpaprDrc
  sPAPRDRConnectorClass -> SpaprDrcClass
    Brevity, and makes it clearer this is the same thing as a "DRC"
    mentioned in many other places in the code

This is 100% a mechanical search-and-replace patch.  It will, however,
conflict with essentially any and all outstanding patches touching the
spapr code.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/char/spapr_vty.c             |  58 +++---
 hw/intc/spapr_xive.c            |  86 ++++-----
 hw/intc/xics_kvm.c              |   4 +-
 hw/intc/xics_spapr.c            |  24 +--
 hw/net/spapr_llan.c             | 110 +++++------
 hw/nvram/spapr_nvram.c          |  42 ++---
 hw/ppc/spapr.c                  | 324 ++++++++++++++++----------------
 hw/ppc/spapr_caps.c             | 110 +++++------
 hw/ppc/spapr_cpu_core.c         |  52 ++---
 hw/ppc/spapr_drc.c              | 134 ++++++-------
 hw/ppc/spapr_events.c           |  92 ++++-----
 hw/ppc/spapr_hcall.c            |  98 +++++-----
 hw/ppc/spapr_iommu.c            |  78 ++++----
 hw/ppc/spapr_irq.c              | 104 +++++-----
 hw/ppc/spapr_ovec.c             |  40 ++--
 hw/ppc/spapr_pci.c              | 212 ++++++++++-----------
 hw/ppc/spapr_pci_vfio.c         |  14 +-
 hw/ppc/spapr_rng.c              |  18 +-
 hw/ppc/spapr_rtas.c             |  30 +--
 hw/ppc/spapr_rtas_ddw.c         |  32 ++--
 hw/ppc/spapr_rtc.c              |  16 +-
 hw/ppc/spapr_vio.c              | 116 ++++++------
 hw/scsi/spapr_vscsi.c           |  14 +-
 include/hw/pci-host/spapr.h     |  44 ++---
 include/hw/ppc/spapr.h          | 176 ++++++++---------
 include/hw/ppc/spapr_cpu_core.h |  24 +--
 include/hw/ppc/spapr_drc.h      | 108 +++++------
 include/hw/ppc/spapr_irq.h      |  58 +++---
 include/hw/ppc/spapr_ovec.h     |  30 +--
 include/hw/ppc/spapr_vio.h      |  74 ++++----
 include/hw/ppc/spapr_xive.h     |  18 +-
 include/hw/ppc/xics_spapr.h     |   6 +-
 target/ppc/kvm.c                |   4 +-
 33 files changed, 1175 insertions(+), 1175 deletions(-)

diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 6748334ded..617303dbaf 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -10,27 +10,27 @@
=20
 #define VTERM_BUFSIZE   16
=20
-typedef struct VIOsPAPRVTYDevice {
-    VIOsPAPRDevice sdev;
+typedef struct SpaprVioVty {
+    SpaprVioDevice sdev;
     CharBackend chardev;
     uint32_t in, out;
     uint8_t buf[VTERM_BUFSIZE];
-} VIOsPAPRVTYDevice;
+} SpaprVioVty;
=20
 #define TYPE_VIO_SPAPR_VTY_DEVICE "spapr-vty"
 #define VIO_SPAPR_VTY_DEVICE(obj) \
-     OBJECT_CHECK(VIOsPAPRVTYDevice, (obj), TYPE_VIO_SPAPR_VTY_DEVICE)
+     OBJECT_CHECK(SpaprVioVty, (obj), TYPE_VIO_SPAPR_VTY_DEVICE)
=20
 static int vty_can_receive(void *opaque)
 {
-    VIOsPAPRVTYDevice *dev =3D VIO_SPAPR_VTY_DEVICE(opaque);
+    SpaprVioVty *dev =3D VIO_SPAPR_VTY_DEVICE(opaque);
=20
     return VTERM_BUFSIZE - (dev->in - dev->out);
 }
=20
 static void vty_receive(void *opaque, const uint8_t *buf, int size)
 {
-    VIOsPAPRVTYDevice *dev =3D VIO_SPAPR_VTY_DEVICE(opaque);
+    SpaprVioVty *dev =3D VIO_SPAPR_VTY_DEVICE(opaque);
     int i;
=20
     if ((dev->in =3D=3D dev->out) && size) {
@@ -51,9 +51,9 @@ static void vty_receive(void *opaque, const uint8_t *bu=
f, int size)
     }
 }
=20
-static int vty_getchars(VIOsPAPRDevice *sdev, uint8_t *buf, int max)
+static int vty_getchars(SpaprVioDevice *sdev, uint8_t *buf, int max)
 {
-    VIOsPAPRVTYDevice *dev =3D VIO_SPAPR_VTY_DEVICE(sdev);
+    SpaprVioVty *dev =3D VIO_SPAPR_VTY_DEVICE(sdev);
     int n =3D 0;
=20
     while ((n < max) && (dev->out !=3D dev->in)) {
@@ -83,18 +83,18 @@ static int vty_getchars(VIOsPAPRDevice *sdev, uint8_t=
 *buf, int max)
     return n;
 }
=20
-void vty_putchars(VIOsPAPRDevice *sdev, uint8_t *buf, int len)
+void vty_putchars(SpaprVioDevice *sdev, uint8_t *buf, int len)
 {
-    VIOsPAPRVTYDevice *dev =3D VIO_SPAPR_VTY_DEVICE(sdev);
+    SpaprVioVty *dev =3D VIO_SPAPR_VTY_DEVICE(sdev);
=20
     /* XXX this blocks entire thread. Rewrite to use
      * qemu_chr_fe_write and background I/O callbacks */
     qemu_chr_fe_write_all(&dev->chardev, buf, len);
 }
=20
-static void spapr_vty_realize(VIOsPAPRDevice *sdev, Error **errp)
+static void spapr_vty_realize(SpaprVioDevice *sdev, Error **errp)
 {
-    VIOsPAPRVTYDevice *dev =3D VIO_SPAPR_VTY_DEVICE(sdev);
+    SpaprVioVty *dev =3D VIO_SPAPR_VTY_DEVICE(sdev);
=20
     if (!qemu_chr_fe_backend_connected(&dev->chardev)) {
         error_setg(errp, "chardev property not set");
@@ -106,14 +106,14 @@ static void spapr_vty_realize(VIOsPAPRDevice *sdev,=
 Error **errp)
 }
=20
 /* Forward declaration */
-static target_ulong h_put_term_char(PowerPCCPU *cpu, sPAPRMachineState *=
spapr,
+static target_ulong h_put_term_char(PowerPCCPU *cpu, SpaprMachineState *=
spapr,
                                     target_ulong opcode, target_ulong *a=
rgs)
 {
     target_ulong reg =3D args[0];
     target_ulong len =3D args[1];
     target_ulong char0_7 =3D args[2];
     target_ulong char8_15 =3D args[3];
-    VIOsPAPRDevice *sdev;
+    SpaprVioDevice *sdev;
     uint8_t buf[16];
=20
     sdev =3D vty_lookup(spapr, reg);
@@ -133,14 +133,14 @@ static target_ulong h_put_term_char(PowerPCCPU *cpu=
, sPAPRMachineState *spapr,
     return H_SUCCESS;
 }
=20
-static target_ulong h_get_term_char(PowerPCCPU *cpu, sPAPRMachineState *=
spapr,
+static target_ulong h_get_term_char(PowerPCCPU *cpu, SpaprMachineState *=
spapr,
                                     target_ulong opcode, target_ulong *a=
rgs)
 {
     target_ulong reg =3D args[0];
     target_ulong *len =3D args + 0;
     target_ulong *char0_7 =3D args + 1;
     target_ulong *char8_15 =3D args + 2;
-    VIOsPAPRDevice *sdev;
+    SpaprVioDevice *sdev;
     uint8_t buf[16];
=20
     sdev =3D vty_lookup(spapr, reg);
@@ -159,7 +159,7 @@ static target_ulong h_get_term_char(PowerPCCPU *cpu, =
sPAPRMachineState *spapr,
     return H_SUCCESS;
 }
=20
-void spapr_vty_create(VIOsPAPRBus *bus, Chardev *chardev)
+void spapr_vty_create(SpaprVioBus *bus, Chardev *chardev)
 {
     DeviceState *dev;
=20
@@ -169,8 +169,8 @@ void spapr_vty_create(VIOsPAPRBus *bus, Chardev *char=
dev)
 }
=20
 static Property spapr_vty_properties[] =3D {
-    DEFINE_SPAPR_PROPERTIES(VIOsPAPRVTYDevice, sdev),
-    DEFINE_PROP_CHR("chardev", VIOsPAPRVTYDevice, chardev),
+    DEFINE_SPAPR_PROPERTIES(SpaprVioVty, sdev),
+    DEFINE_PROP_CHR("chardev", SpaprVioVty, chardev),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -179,11 +179,11 @@ static const VMStateDescription vmstate_spapr_vty =3D=
 {
     .version_id =3D 1,
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
-        VMSTATE_SPAPR_VIO(sdev, VIOsPAPRVTYDevice),
+        VMSTATE_SPAPR_VIO(sdev, SpaprVioVty),
=20
-        VMSTATE_UINT32(in, VIOsPAPRVTYDevice),
-        VMSTATE_UINT32(out, VIOsPAPRVTYDevice),
-        VMSTATE_BUFFER(buf, VIOsPAPRVTYDevice),
+        VMSTATE_UINT32(in, SpaprVioVty),
+        VMSTATE_UINT32(out, SpaprVioVty),
+        VMSTATE_BUFFER(buf, SpaprVioVty),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -191,7 +191,7 @@ static const VMStateDescription vmstate_spapr_vty =3D=
 {
 static void spapr_vty_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    VIOsPAPRDeviceClass *k =3D VIO_SPAPR_DEVICE_CLASS(klass);
+    SpaprVioDeviceClass *k =3D VIO_SPAPR_DEVICE_CLASS(klass);
=20
     k->realize =3D spapr_vty_realize;
     k->dt_name =3D "vty";
@@ -205,13 +205,13 @@ static void spapr_vty_class_init(ObjectClass *klass=
, void *data)
 static const TypeInfo spapr_vty_info =3D {
     .name          =3D TYPE_VIO_SPAPR_VTY_DEVICE,
     .parent        =3D TYPE_VIO_SPAPR_DEVICE,
-    .instance_size =3D sizeof(VIOsPAPRVTYDevice),
+    .instance_size =3D sizeof(SpaprVioVty),
     .class_init    =3D spapr_vty_class_init,
 };
=20
-VIOsPAPRDevice *spapr_vty_get_default(VIOsPAPRBus *bus)
+SpaprVioDevice *spapr_vty_get_default(SpaprVioBus *bus)
 {
-    VIOsPAPRDevice *sdev, *selected;
+    SpaprVioDevice *sdev, *selected;
     BusChild *kid;
=20
     /*
@@ -246,9 +246,9 @@ VIOsPAPRDevice *spapr_vty_get_default(VIOsPAPRBus *bu=
s)
     return selected;
 }
=20
-VIOsPAPRDevice *vty_lookup(sPAPRMachineState *spapr, target_ulong reg)
+SpaprVioDevice *vty_lookup(SpaprMachineState *spapr, target_ulong reg)
 {
-    VIOsPAPRDevice *sdev;
+    SpaprVioDevice *sdev;
=20
     sdev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
     if (!sdev && reg =3D=3D 0) {
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index e0e5cb5d8e..097f88d460 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -117,7 +117,7 @@ static int spapr_xive_target_to_end(uint32_t target, =
uint8_t prio,
  * On sPAPR machines, use a simplified output for the XIVE END
  * structure dumping only the information related to the OS EQ.
  */
-static void spapr_xive_end_pic_print_info(sPAPRXive *xive, XiveEND *end,
+static void spapr_xive_end_pic_print_info(SpaprXive *xive, XiveEND *end,
                                           Monitor *mon)
 {
     uint32_t qindex =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
@@ -135,7 +135,7 @@ static void spapr_xive_end_pic_print_info(sPAPRXive *=
xive, XiveEND *end,
     monitor_printf(mon, "]");
 }
=20
-void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon)
+void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
 {
     XiveSource *xsrc =3D &xive->source;
     int i;
@@ -173,14 +173,14 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Mon=
itor *mon)
     }
 }
=20
-static void spapr_xive_map_mmio(sPAPRXive *xive)
+static void spapr_xive_map_mmio(SpaprXive *xive)
 {
     sysbus_mmio_map(SYS_BUS_DEVICE(xive), 0, xive->vc_base);
     sysbus_mmio_map(SYS_BUS_DEVICE(xive), 1, xive->end_base);
     sysbus_mmio_map(SYS_BUS_DEVICE(xive), 2, xive->tm_base);
 }
=20
-void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable)
+void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable)
 {
     memory_region_set_enabled(&xive->source.esb_mmio, enable);
     memory_region_set_enabled(&xive->tm_mmio, enable);
@@ -216,7 +216,7 @@ static void spapr_xive_end_reset(XiveEND *end)
=20
 static void spapr_xive_reset(void *dev)
 {
-    sPAPRXive *xive =3D SPAPR_XIVE(dev);
+    SpaprXive *xive =3D SPAPR_XIVE(dev);
     int i;
=20
     /*
@@ -242,7 +242,7 @@ static void spapr_xive_reset(void *dev)
=20
 static void spapr_xive_instance_init(Object *obj)
 {
-    sPAPRXive *xive =3D SPAPR_XIVE(obj);
+    SpaprXive *xive =3D SPAPR_XIVE(obj);
=20
     object_initialize_child(obj, "source", &xive->source, sizeof(xive->s=
ource),
                             TYPE_XIVE_SOURCE, &error_abort, NULL);
@@ -254,7 +254,7 @@ static void spapr_xive_instance_init(Object *obj)
=20
 static void spapr_xive_realize(DeviceState *dev, Error **errp)
 {
-    sPAPRXive *xive =3D SPAPR_XIVE(dev);
+    SpaprXive *xive =3D SPAPR_XIVE(dev);
     XiveSource *xsrc =3D &xive->source;
     XiveENDSource *end_xsrc =3D &xive->end_source;
     Error *local_err =3D NULL;
@@ -325,7 +325,7 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
 static int spapr_xive_get_eas(XiveRouter *xrtr, uint8_t eas_blk,
                               uint32_t eas_idx, XiveEAS *eas)
 {
-    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
+    SpaprXive *xive =3D SPAPR_XIVE(xrtr);
=20
     if (eas_idx >=3D xive->nr_irqs) {
         return -1;
@@ -338,7 +338,7 @@ static int spapr_xive_get_eas(XiveRouter *xrtr, uint8=
_t eas_blk,
 static int spapr_xive_get_end(XiveRouter *xrtr,
                               uint8_t end_blk, uint32_t end_idx, XiveEND=
 *end)
 {
-    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
+    SpaprXive *xive =3D SPAPR_XIVE(xrtr);
=20
     if (end_idx >=3D xive->nr_ends) {
         return -1;
@@ -352,7 +352,7 @@ static int spapr_xive_write_end(XiveRouter *xrtr, uin=
t8_t end_blk,
                                 uint32_t end_idx, XiveEND *end,
                                 uint8_t word_number)
 {
-    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
+    SpaprXive *xive =3D SPAPR_XIVE(xrtr);
=20
     if (end_idx >=3D xive->nr_ends) {
         return -1;
@@ -432,20 +432,20 @@ static const VMStateDescription vmstate_spapr_xive =
=3D {
     .version_id =3D 1,
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
-        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(eat, sPAPRXive, nr_irqs,
+        VMSTATE_UINT32_EQUAL(nr_irqs, SpaprXive, NULL),
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(eat, SpaprXive, nr_irqs,
                                      vmstate_spapr_xive_eas, XiveEAS),
-        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(endt, sPAPRXive, nr_ends,
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(endt, SpaprXive, nr_ends,
                                              vmstate_spapr_xive_end, Xiv=
eEND),
         VMSTATE_END_OF_LIST()
     },
 };
=20
 static Property spapr_xive_properties[] =3D {
-    DEFINE_PROP_UINT32("nr-irqs", sPAPRXive, nr_irqs, 0),
-    DEFINE_PROP_UINT32("nr-ends", sPAPRXive, nr_ends, 0),
-    DEFINE_PROP_UINT64("vc-base", sPAPRXive, vc_base, SPAPR_XIVE_VC_BASE=
),
-    DEFINE_PROP_UINT64("tm-base", sPAPRXive, tm_base, SPAPR_XIVE_TM_BASE=
),
+    DEFINE_PROP_UINT32("nr-irqs", SpaprXive, nr_irqs, 0),
+    DEFINE_PROP_UINT32("nr-ends", SpaprXive, nr_ends, 0),
+    DEFINE_PROP_UINT64("vc-base", SpaprXive, vc_base, SPAPR_XIVE_VC_BASE=
),
+    DEFINE_PROP_UINT64("tm-base", SpaprXive, tm_base, SPAPR_XIVE_TM_BASE=
),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -471,7 +471,7 @@ static const TypeInfo spapr_xive_info =3D {
     .name =3D TYPE_SPAPR_XIVE,
     .parent =3D TYPE_XIVE_ROUTER,
     .instance_init =3D spapr_xive_instance_init,
-    .instance_size =3D sizeof(sPAPRXive),
+    .instance_size =3D sizeof(SpaprXive),
     .class_init =3D spapr_xive_class_init,
 };
=20
@@ -482,7 +482,7 @@ static void spapr_xive_register_types(void)
=20
 type_init(spapr_xive_register_types)
=20
-bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi)
+bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi)
 {
     XiveSource *xsrc =3D &xive->source;
=20
@@ -497,7 +497,7 @@ bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t l=
isn, bool lsi)
     return true;
 }
=20
-bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn)
+bool spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn)
 {
     if (lisn >=3D xive->nr_irqs) {
         return false;
@@ -576,11 +576,11 @@ static bool spapr_xive_priority_is_reserved(uint8_t=
 priority)
 #define SPAPR_XIVE_SRC_STORE_EOI     PPC_BIT(63) /* Store EOI support */
=20
 static target_ulong h_int_get_source_info(PowerPCCPU *cpu,
-                                          sPAPRMachineState *spapr,
+                                          SpaprMachineState *spapr,
                                           target_ulong opcode,
                                           target_ulong *args)
 {
-    sPAPRXive *xive =3D spapr->xive;
+    SpaprXive *xive =3D spapr->xive;
     XiveSource *xsrc =3D &xive->source;
     target_ulong flags  =3D args[0];
     target_ulong lisn   =3D args[1];
@@ -686,11 +686,11 @@ static target_ulong h_int_get_source_info(PowerPCCP=
U *cpu,
 #define SPAPR_XIVE_SRC_MASK     PPC_BIT(63)
=20
 static target_ulong h_int_set_source_config(PowerPCCPU *cpu,
-                                            sPAPRMachineState *spapr,
+                                            SpaprMachineState *spapr,
                                             target_ulong opcode,
                                             target_ulong *args)
 {
-    sPAPRXive *xive =3D spapr->xive;
+    SpaprXive *xive =3D spapr->xive;
     XiveEAS eas, new_eas;
     target_ulong flags    =3D args[0];
     target_ulong lisn     =3D args[1];
@@ -783,11 +783,11 @@ out:
  *       equivalent to the LISN if not changed by H_INT_SET_SOURCE_CONFI=
G)
  */
 static target_ulong h_int_get_source_config(PowerPCCPU *cpu,
-                                            sPAPRMachineState *spapr,
+                                            SpaprMachineState *spapr,
                                             target_ulong opcode,
                                             target_ulong *args)
 {
-    sPAPRXive *xive =3D spapr->xive;
+    SpaprXive *xive =3D spapr->xive;
     target_ulong flags =3D args[0];
     target_ulong lisn =3D args[1];
     XiveEAS eas;
@@ -856,11 +856,11 @@ static target_ulong h_int_get_source_config(PowerPC=
CPU *cpu,
  * - R5: Power of 2 page size of the notification page
  */
 static target_ulong h_int_get_queue_info(PowerPCCPU *cpu,
-                                         sPAPRMachineState *spapr,
+                                         SpaprMachineState *spapr,
                                          target_ulong opcode,
                                          target_ulong *args)
 {
-    sPAPRXive *xive =3D spapr->xive;
+    SpaprXive *xive =3D spapr->xive;
     XiveENDSource *end_xsrc =3D &xive->end_source;
     target_ulong flags =3D args[0];
     target_ulong target =3D args[1];
@@ -942,11 +942,11 @@ static target_ulong h_int_get_queue_info(PowerPCCPU=
 *cpu,
 #define SPAPR_XIVE_END_ALWAYS_NOTIFY PPC_BIT(63)
=20
 static target_ulong h_int_set_queue_config(PowerPCCPU *cpu,
-                                           sPAPRMachineState *spapr,
+                                           SpaprMachineState *spapr,
                                            target_ulong opcode,
                                            target_ulong *args)
 {
-    sPAPRXive *xive =3D spapr->xive;
+    SpaprXive *xive =3D spapr->xive;
     target_ulong flags =3D args[0];
     target_ulong target =3D args[1];
     target_ulong priority =3D args[2];
@@ -1095,11 +1095,11 @@ out:
 #define SPAPR_XIVE_END_DEBUG     PPC_BIT(63)
=20
 static target_ulong h_int_get_queue_config(PowerPCCPU *cpu,
-                                           sPAPRMachineState *spapr,
+                                           SpaprMachineState *spapr,
                                            target_ulong opcode,
                                            target_ulong *args)
 {
-    sPAPRXive *xive =3D spapr->xive;
+    SpaprXive *xive =3D spapr->xive;
     target_ulong flags =3D args[0];
     target_ulong target =3D args[1];
     target_ulong priority =3D args[2];
@@ -1187,7 +1187,7 @@ static target_ulong h_int_get_queue_config(PowerPCC=
PU *cpu,
  * - None
  */
 static target_ulong h_int_set_os_reporting_line(PowerPCCPU *cpu,
-                                                sPAPRMachineState *spapr=
,
+                                                SpaprMachineState *spapr=
,
                                                 target_ulong opcode,
                                                 target_ulong *args)
 {
@@ -1223,7 +1223,7 @@ static target_ulong h_int_set_os_reporting_line(Pow=
erPCCPU *cpu,
  * - R4: The logical real address of the reporting line if set, else -1
  */
 static target_ulong h_int_get_os_reporting_line(PowerPCCPU *cpu,
-                                                sPAPRMachineState *spapr=
,
+                                                SpaprMachineState *spapr=
,
                                                 target_ulong opcode,
                                                 target_ulong *args)
 {
@@ -1266,11 +1266,11 @@ static target_ulong h_int_get_os_reporting_line(P=
owerPCCPU *cpu,
 #define SPAPR_XIVE_ESB_STORE PPC_BIT(63)
=20
 static target_ulong h_int_esb(PowerPCCPU *cpu,
-                              sPAPRMachineState *spapr,
+                              SpaprMachineState *spapr,
                               target_ulong opcode,
                               target_ulong *args)
 {
-    sPAPRXive *xive =3D spapr->xive;
+    SpaprXive *xive =3D spapr->xive;
     XiveEAS eas;
     target_ulong flags  =3D args[0];
     target_ulong lisn   =3D args[1];
@@ -1334,11 +1334,11 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
  * - None
  */
 static target_ulong h_int_sync(PowerPCCPU *cpu,
-                               sPAPRMachineState *spapr,
+                               SpaprMachineState *spapr,
                                target_ulong opcode,
                                target_ulong *args)
 {
-    sPAPRXive *xive =3D spapr->xive;
+    SpaprXive *xive =3D spapr->xive;
     XiveEAS eas;
     target_ulong flags =3D args[0];
     target_ulong lisn =3D args[1];
@@ -1388,11 +1388,11 @@ static target_ulong h_int_sync(PowerPCCPU *cpu,
  * - None
  */
 static target_ulong h_int_reset(PowerPCCPU *cpu,
-                                sPAPRMachineState *spapr,
+                                SpaprMachineState *spapr,
                                 target_ulong opcode,
                                 target_ulong *args)
 {
-    sPAPRXive *xive =3D spapr->xive;
+    SpaprXive *xive =3D spapr->xive;
     target_ulong flags   =3D args[0];
=20
     if (!spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
@@ -1407,7 +1407,7 @@ static target_ulong h_int_reset(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
=20
-void spapr_xive_hcall_init(sPAPRMachineState *spapr)
+void spapr_xive_hcall_init(SpaprMachineState *spapr)
 {
     spapr_register_hypercall(H_INT_GET_SOURCE_INFO, h_int_get_source_inf=
o);
     spapr_register_hypercall(H_INT_SET_SOURCE_CONFIG, h_int_set_source_c=
onfig);
@@ -1424,10 +1424,10 @@ void spapr_xive_hcall_init(sPAPRMachineState *spa=
pr)
     spapr_register_hypercall(H_INT_RESET, h_int_reset);
 }
=20
-void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
+void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void *=
fdt,
                    uint32_t phandle)
 {
-    sPAPRXive *xive =3D spapr->xive;
+    SpaprXive *xive =3D spapr->xive;
     int node;
     uint64_t timas[2 * 2];
     /* Interrupt number ranges for the IPIs */
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index c6e1b630a4..78a252e6df 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -291,7 +291,7 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int va=
l)
     }
 }
=20
-static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static void rtas_dummy(PowerPCCPU *cpu, SpaprMachineState *spapr,
                        uint32_t token,
                        uint32_t nargs, target_ulong args,
                        uint32_t nret, target_ulong rets)
@@ -300,7 +300,7 @@ static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachineS=
tate *spapr,
                  __func__);
 }
=20
-int xics_kvm_init(sPAPRMachineState *spapr, Error **errp)
+int xics_kvm_init(SpaprMachineState *spapr, Error **errp)
 {
     int rc;
=20
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 53bda6661b..607e1c167b 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -41,7 +41,7 @@
  * Guest interfaces
  */
=20
-static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_cppr(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
     target_ulong cppr =3D args[0];
@@ -50,7 +50,7 @@ static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
     return H_SUCCESS;
 }
=20
-static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_ipi(PowerPCCPU *cpu, SpaprMachineState *spapr,
                           target_ulong opcode, target_ulong *args)
 {
     target_ulong mfrr =3D args[1];
@@ -64,7 +64,7 @@ static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
     return H_SUCCESS;
 }
=20
-static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_xirr(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
     uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
@@ -73,7 +73,7 @@ static target_ulong h_xirr(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
     return H_SUCCESS;
 }
=20
-static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_xirr_x(PowerPCCPU *cpu, SpaprMachineState *spapr,
                              target_ulong opcode, target_ulong *args)
 {
     uint32_t xirr =3D icp_accept(spapr_cpu_state(cpu)->icp);
@@ -83,7 +83,7 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
     return H_SUCCESS;
 }
=20
-static target_ulong h_eoi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_eoi(PowerPCCPU *cpu, SpaprMachineState *spapr,
                           target_ulong opcode, target_ulong *args)
 {
     target_ulong xirr =3D args[0];
@@ -92,7 +92,7 @@ static target_ulong h_eoi(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
     return H_SUCCESS;
 }
=20
-static target_ulong h_ipoll(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_ipoll(PowerPCCPU *cpu, SpaprMachineState *spapr,
                             target_ulong opcode, target_ulong *args)
 {
     uint32_t mfrr;
@@ -104,7 +104,7 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
     return H_SUCCESS;
 }
=20
-static void rtas_set_xive(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static void rtas_set_xive(PowerPCCPU *cpu, SpaprMachineState *spapr,
                           uint32_t token,
                           uint32_t nargs, target_ulong args,
                           uint32_t nret, target_ulong rets)
@@ -137,7 +137,7 @@ static void rtas_set_xive(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
-static void rtas_get_xive(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static void rtas_get_xive(PowerPCCPU *cpu, SpaprMachineState *spapr,
                           uint32_t token,
                           uint32_t nargs, target_ulong args,
                           uint32_t nret, target_ulong rets)
@@ -167,7 +167,7 @@ static void rtas_get_xive(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
     rtas_st(rets, 2, ics->irqs[srcno].priority);
 }
=20
-static void rtas_int_off(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static void rtas_int_off(PowerPCCPU *cpu, SpaprMachineState *spapr,
                          uint32_t token,
                          uint32_t nargs, target_ulong args,
                          uint32_t nret, target_ulong rets)
@@ -198,7 +198,7 @@ static void rtas_int_off(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
-static void rtas_int_on(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static void rtas_int_on(PowerPCCPU *cpu, SpaprMachineState *spapr,
                         uint32_t token,
                         uint32_t nargs, target_ulong args,
                         uint32_t nret, target_ulong rets)
@@ -230,7 +230,7 @@ static void rtas_int_on(PowerPCCPU *cpu, sPAPRMachine=
State *spapr,
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
-void xics_spapr_init(sPAPRMachineState *spapr)
+void xics_spapr_init(SpaprMachineState *spapr)
 {
     /* Registration of global state belongs into realize */
     spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_xive=
);
@@ -246,7 +246,7 @@ void xics_spapr_init(sPAPRMachineState *spapr)
     spapr_register_hypercall(H_IPOLL, h_ipoll);
 }
=20
-void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
+void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *=
fdt,
                    uint32_t phandle)
 {
     uint32_t interrupt_server_ranges_prop[] =3D {
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index d239e4bd7d..63ba3929e9 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -84,7 +84,7 @@ typedef uint64_t vlan_bd_t;
=20
 #define TYPE_VIO_SPAPR_VLAN_DEVICE "spapr-vlan"
 #define VIO_SPAPR_VLAN_DEVICE(obj) \
-     OBJECT_CHECK(VIOsPAPRVLANDevice, (obj), TYPE_VIO_SPAPR_VLAN_DEVICE)
+     OBJECT_CHECK(SpaprVioVlan, (obj), TYPE_VIO_SPAPR_VLAN_DEVICE)
=20
 #define RX_POOL_MAX_BDS 4096
 #define RX_MAX_POOLS 5
@@ -95,8 +95,8 @@ typedef struct {
     vlan_bd_t bds[RX_POOL_MAX_BDS];
 } RxBufPool;
=20
-typedef struct VIOsPAPRVLANDevice {
-    VIOsPAPRDevice sdev;
+typedef struct SpaprVioVlan {
+    SpaprVioDevice sdev;
     NICConf nicconf;
     NICState *nic;
     MACAddr perm_mac;
@@ -107,11 +107,11 @@ typedef struct VIOsPAPRVLANDevice {
     QEMUTimer *rxp_timer;
     uint32_t compat_flags;             /* Compatibility flags for migrat=
ion */
     RxBufPool *rx_pool[RX_MAX_POOLS];  /* Receive buffer descriptor pool=
s */
-} VIOsPAPRVLANDevice;
+} SpaprVioVlan;
=20
 static int spapr_vlan_can_receive(NetClientState *nc)
 {
-    VIOsPAPRVLANDevice *dev =3D qemu_get_nic_opaque(nc);
+    SpaprVioVlan *dev =3D qemu_get_nic_opaque(nc);
=20
     return (dev->isopen && dev->rx_bufs > 0);
 }
@@ -123,7 +123,7 @@ static int spapr_vlan_can_receive(NetClientState *nc)
  * suitable receive buffer available. This function is used to increase
  * this counter by one.
  */
-static void spapr_vlan_record_dropped_rx_frame(VIOsPAPRVLANDevice *dev)
+static void spapr_vlan_record_dropped_rx_frame(SpaprVioVlan *dev)
 {
     uint64_t cnt;
=20
@@ -134,7 +134,7 @@ static void spapr_vlan_record_dropped_rx_frame(VIOsPA=
PRVLANDevice *dev)
 /**
  * Get buffer descriptor from one of our receive buffer pools
  */
-static vlan_bd_t spapr_vlan_get_rx_bd_from_pool(VIOsPAPRVLANDevice *dev,
+static vlan_bd_t spapr_vlan_get_rx_bd_from_pool(SpaprVioVlan *dev,
                                                 size_t size)
 {
     vlan_bd_t bd;
@@ -168,7 +168,7 @@ static vlan_bd_t spapr_vlan_get_rx_bd_from_pool(VIOsP=
APRVLANDevice *dev,
  * Get buffer descriptor from the receive buffer list page that has been
  * supplied by the guest with the H_REGISTER_LOGICAL_LAN call
  */
-static vlan_bd_t spapr_vlan_get_rx_bd_from_page(VIOsPAPRVLANDevice *dev,
+static vlan_bd_t spapr_vlan_get_rx_bd_from_page(SpaprVioVlan *dev,
                                                 size_t size)
 {
     int buf_ptr =3D dev->use_buf_ptr;
@@ -203,8 +203,8 @@ static vlan_bd_t spapr_vlan_get_rx_bd_from_page(VIOsP=
APRVLANDevice *dev,
 static ssize_t spapr_vlan_receive(NetClientState *nc, const uint8_t *buf=
,
                                   size_t size)
 {
-    VIOsPAPRVLANDevice *dev =3D qemu_get_nic_opaque(nc);
-    VIOsPAPRDevice *sdev =3D VIO_SPAPR_DEVICE(dev);
+    SpaprVioVlan *dev =3D qemu_get_nic_opaque(nc);
+    SpaprVioDevice *sdev =3D VIO_SPAPR_DEVICE(dev);
     vlan_bd_t rxq_bd =3D vio_ldq(sdev, dev->buf_list + VLAN_RXQ_BD_OFF);
     vlan_bd_t bd;
     uint64_t handle;
@@ -280,7 +280,7 @@ static NetClientInfo net_spapr_vlan_info =3D {
=20
 static void spapr_vlan_flush_rx_queue(void *opaque)
 {
-    VIOsPAPRVLANDevice *dev =3D opaque;
+    SpaprVioVlan *dev =3D opaque;
=20
     qemu_flush_queued_packets(qemu_get_queue(dev->nic));
 }
@@ -296,9 +296,9 @@ static void spapr_vlan_reset_rx_pool(RxBufPool *rxp)
     memset(rxp->bds, 0, sizeof(rxp->bds));
 }
=20
-static void spapr_vlan_reset(VIOsPAPRDevice *sdev)
+static void spapr_vlan_reset(SpaprVioDevice *sdev)
 {
-    VIOsPAPRVLANDevice *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
+    SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
     int i;
=20
     dev->buf_list =3D 0;
@@ -316,9 +316,9 @@ static void spapr_vlan_reset(VIOsPAPRDevice *sdev)
     qemu_format_nic_info_str(qemu_get_queue(dev->nic), dev->nicconf.maca=
ddr.a);
 }
=20
-static void spapr_vlan_realize(VIOsPAPRDevice *sdev, Error **errp)
+static void spapr_vlan_realize(SpaprVioDevice *sdev, Error **errp)
 {
-    VIOsPAPRVLANDevice *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
+    SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
=20
     qemu_macaddr_default_if_unset(&dev->nicconf.macaddr);
=20
@@ -334,7 +334,7 @@ static void spapr_vlan_realize(VIOsPAPRDevice *sdev, =
Error **errp)
=20
 static void spapr_vlan_instance_init(Object *obj)
 {
-    VIOsPAPRVLANDevice *dev =3D VIO_SPAPR_VLAN_DEVICE(obj);
+    SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(obj);
     int i;
=20
     device_add_bootindex_property(obj, &dev->nicconf.bootindex,
@@ -351,7 +351,7 @@ static void spapr_vlan_instance_init(Object *obj)
=20
 static void spapr_vlan_instance_finalize(Object *obj)
 {
-    VIOsPAPRVLANDevice *dev =3D VIO_SPAPR_VLAN_DEVICE(obj);
+    SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(obj);
     int i;
=20
     if (dev->compat_flags & SPAPRVLAN_FLAG_RX_BUF_POOLS) {
@@ -367,7 +367,7 @@ static void spapr_vlan_instance_finalize(Object *obj)
     }
 }
=20
-void spapr_vlan_create(VIOsPAPRBus *bus, NICInfo *nd)
+void spapr_vlan_create(SpaprVioBus *bus, NICInfo *nd)
 {
     DeviceState *dev;
=20
@@ -378,9 +378,9 @@ void spapr_vlan_create(VIOsPAPRBus *bus, NICInfo *nd)
     qdev_init_nofail(dev);
 }
=20
-static int spapr_vlan_devnode(VIOsPAPRDevice *dev, void *fdt, int node_o=
ff)
+static int spapr_vlan_devnode(SpaprVioDevice *dev, void *fdt, int node_o=
ff)
 {
-    VIOsPAPRVLANDevice *vdev =3D VIO_SPAPR_VLAN_DEVICE(dev);
+    SpaprVioVlan *vdev =3D VIO_SPAPR_VLAN_DEVICE(dev);
     uint8_t padded_mac[8] =3D {0, 0};
     int ret;
=20
@@ -415,7 +415,7 @@ static int spapr_vlan_devnode(VIOsPAPRDevice *dev, vo=
id *fdt, int node_off)
     return 0;
 }
=20
-static int check_bd(VIOsPAPRVLANDevice *dev, vlan_bd_t bd,
+static int check_bd(SpaprVioVlan *dev, vlan_bd_t bd,
                     target_ulong alignment)
 {
     if ((VLAN_BD_ADDR(bd) % alignment)
@@ -434,7 +434,7 @@ static int check_bd(VIOsPAPRVLANDevice *dev, vlan_bd_=
t bd,
 }
=20
 static target_ulong h_register_logical_lan(PowerPCCPU *cpu,
-                                           sPAPRMachineState *spapr,
+                                           SpaprMachineState *spapr,
                                            target_ulong opcode,
                                            target_ulong *args)
 {
@@ -442,8 +442,8 @@ static target_ulong h_register_logical_lan(PowerPCCPU=
 *cpu,
     target_ulong buf_list =3D args[1];
     target_ulong rec_queue =3D args[2];
     target_ulong filter_list =3D args[3];
-    VIOsPAPRDevice *sdev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
-    VIOsPAPRVLANDevice *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
+    SpaprVioDevice *sdev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
+    SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
     vlan_bd_t filter_list_bd;
=20
     if (!dev) {
@@ -500,12 +500,12 @@ static target_ulong h_register_logical_lan(PowerPCC=
PU *cpu,
=20
=20
 static target_ulong h_free_logical_lan(PowerPCCPU *cpu,
-                                       sPAPRMachineState *spapr,
+                                       SpaprMachineState *spapr,
                                        target_ulong opcode, target_ulong=
 *args)
 {
     target_ulong reg =3D args[0];
-    VIOsPAPRDevice *sdev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
-    VIOsPAPRVLANDevice *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
+    SpaprVioDevice *sdev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
+    SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
=20
     if (!dev) {
         return H_PARAMETER;
@@ -539,7 +539,7 @@ static int rx_pool_size_compare(const void *p1, const=
 void *p2)
  * Search for a matching buffer pool with exact matching size,
  * or return -1 if no matching pool has been found.
  */
-static int spapr_vlan_get_rx_pool_id(VIOsPAPRVLANDevice *dev, int size)
+static int spapr_vlan_get_rx_pool_id(SpaprVioVlan *dev, int size)
 {
     int pool;
=20
@@ -555,7 +555,7 @@ static int spapr_vlan_get_rx_pool_id(VIOsPAPRVLANDevi=
ce *dev, int size)
 /**
  * Enqueuing receive buffer by adding it to one of our receive buffer po=
ols
  */
-static target_long spapr_vlan_add_rxbuf_to_pool(VIOsPAPRVLANDevice *dev,
+static target_long spapr_vlan_add_rxbuf_to_pool(SpaprVioVlan *dev,
                                                 target_ulong buf)
 {
     int size =3D VLAN_BD_LEN(buf);
@@ -602,7 +602,7 @@ static target_long spapr_vlan_add_rxbuf_to_pool(VIOsP=
APRVLANDevice *dev,
  * This is the old way of enqueuing receive buffers: Add it to the rx qu=
eue
  * page that has been supplied by the guest (which is quite limited in s=
ize).
  */
-static target_long spapr_vlan_add_rxbuf_to_page(VIOsPAPRVLANDevice *dev,
+static target_long spapr_vlan_add_rxbuf_to_page(SpaprVioVlan *dev,
                                                 target_ulong buf)
 {
     vlan_bd_t bd;
@@ -628,14 +628,14 @@ static target_long spapr_vlan_add_rxbuf_to_page(VIO=
sPAPRVLANDevice *dev,
 }
=20
 static target_ulong h_add_logical_lan_buffer(PowerPCCPU *cpu,
-                                             sPAPRMachineState *spapr,
+                                             SpaprMachineState *spapr,
                                              target_ulong opcode,
                                              target_ulong *args)
 {
     target_ulong reg =3D args[0];
     target_ulong buf =3D args[1];
-    VIOsPAPRDevice *sdev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
-    VIOsPAPRVLANDevice *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
+    SpaprVioDevice *sdev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
+    SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
     target_long ret;
=20
     trace_spapr_vlan_h_add_logical_lan_buffer(reg, buf);
@@ -678,14 +678,14 @@ static target_ulong h_add_logical_lan_buffer(PowerP=
CCPU *cpu,
 }
=20
 static target_ulong h_send_logical_lan(PowerPCCPU *cpu,
-                                       sPAPRMachineState *spapr,
+                                       SpaprMachineState *spapr,
                                        target_ulong opcode, target_ulong=
 *args)
 {
     target_ulong reg =3D args[0];
     target_ulong *bufs =3D args + 1;
     target_ulong continue_token =3D args[7];
-    VIOsPAPRDevice *sdev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
-    VIOsPAPRVLANDevice *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
+    SpaprVioDevice *sdev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
+    SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
     unsigned total_len;
     uint8_t *lbuf, *p;
     int i, nbufs;
@@ -745,11 +745,11 @@ static target_ulong h_send_logical_lan(PowerPCCPU *=
cpu,
     return H_SUCCESS;
 }
=20
-static target_ulong h_multicast_ctrl(PowerPCCPU *cpu, sPAPRMachineState =
*spapr,
+static target_ulong h_multicast_ctrl(PowerPCCPU *cpu, SpaprMachineState =
*spapr,
                                      target_ulong opcode, target_ulong *=
args)
 {
     target_ulong reg =3D args[0];
-    VIOsPAPRDevice *dev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
+    SpaprVioDevice *dev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
=20
     if (!dev) {
         return H_PARAMETER;
@@ -759,14 +759,14 @@ static target_ulong h_multicast_ctrl(PowerPCCPU *cp=
u, sPAPRMachineState *spapr,
 }
=20
 static target_ulong h_change_logical_lan_mac(PowerPCCPU *cpu,
-                                             sPAPRMachineState *spapr,
+                                             SpaprMachineState *spapr,
                                              target_ulong opcode,
                                              target_ulong *args)
 {
     target_ulong reg =3D args[0];
     target_ulong macaddr =3D args[1];
-    VIOsPAPRDevice *sdev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
-    VIOsPAPRVLANDevice *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
+    SpaprVioDevice *sdev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
+    SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
     int i;
=20
     for (i =3D 0; i < ETH_ALEN; i++) {
@@ -780,16 +780,16 @@ static target_ulong h_change_logical_lan_mac(PowerP=
CCPU *cpu,
 }
=20
 static Property spapr_vlan_properties[] =3D {
-    DEFINE_SPAPR_PROPERTIES(VIOsPAPRVLANDevice, sdev),
-    DEFINE_NIC_PROPERTIES(VIOsPAPRVLANDevice, nicconf),
-    DEFINE_PROP_BIT("use-rx-buffer-pools", VIOsPAPRVLANDevice,
+    DEFINE_SPAPR_PROPERTIES(SpaprVioVlan, sdev),
+    DEFINE_NIC_PROPERTIES(SpaprVioVlan, nicconf),
+    DEFINE_PROP_BIT("use-rx-buffer-pools", SpaprVioVlan,
                     compat_flags, SPAPRVLAN_FLAG_RX_BUF_POOLS_BIT, true)=
,
     DEFINE_PROP_END_OF_LIST(),
 };
=20
 static bool spapr_vlan_rx_buffer_pools_needed(void *opaque)
 {
-    VIOsPAPRVLANDevice *dev =3D opaque;
+    SpaprVioVlan *dev =3D opaque;
=20
     return (dev->compat_flags & SPAPRVLAN_FLAG_RX_BUF_POOLS) !=3D 0;
 }
@@ -813,7 +813,7 @@ static const VMStateDescription vmstate_rx_pools =3D =
{
     .minimum_version_id =3D 1,
     .needed =3D spapr_vlan_rx_buffer_pools_needed,
     .fields =3D (VMStateField[]) {
-        VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(rx_pool, VIOsPAPRVLANDevice,
+        VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(rx_pool, SpaprVioVlan,
                                            RX_MAX_POOLS, 1,
                                            vmstate_rx_buffer_pool, RxBuf=
Pool),
         VMSTATE_END_OF_LIST()
@@ -825,14 +825,14 @@ static const VMStateDescription vmstate_spapr_llan =
=3D {
     .version_id =3D 1,
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
-        VMSTATE_SPAPR_VIO(sdev, VIOsPAPRVLANDevice),
+        VMSTATE_SPAPR_VIO(sdev, SpaprVioVlan),
         /* LLAN state */
-        VMSTATE_BOOL(isopen, VIOsPAPRVLANDevice),
-        VMSTATE_UINT64(buf_list, VIOsPAPRVLANDevice),
-        VMSTATE_UINT32(add_buf_ptr, VIOsPAPRVLANDevice),
-        VMSTATE_UINT32(use_buf_ptr, VIOsPAPRVLANDevice),
-        VMSTATE_UINT32(rx_bufs, VIOsPAPRVLANDevice),
-        VMSTATE_UINT64(rxq_ptr, VIOsPAPRVLANDevice),
+        VMSTATE_BOOL(isopen, SpaprVioVlan),
+        VMSTATE_UINT64(buf_list, SpaprVioVlan),
+        VMSTATE_UINT32(add_buf_ptr, SpaprVioVlan),
+        VMSTATE_UINT32(use_buf_ptr, SpaprVioVlan),
+        VMSTATE_UINT32(rx_bufs, SpaprVioVlan),
+        VMSTATE_UINT64(rxq_ptr, SpaprVioVlan),
=20
         VMSTATE_END_OF_LIST()
     },
@@ -845,7 +845,7 @@ static const VMStateDescription vmstate_spapr_llan =3D=
 {
 static void spapr_vlan_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    VIOsPAPRDeviceClass *k =3D VIO_SPAPR_DEVICE_CLASS(klass);
+    SpaprVioDeviceClass *k =3D VIO_SPAPR_DEVICE_CLASS(klass);
=20
     k->realize =3D spapr_vlan_realize;
     k->reset =3D spapr_vlan_reset;
@@ -863,7 +863,7 @@ static void spapr_vlan_class_init(ObjectClass *klass,=
 void *data)
 static const TypeInfo spapr_vlan_info =3D {
     .name          =3D TYPE_VIO_SPAPR_VLAN_DEVICE,
     .parent        =3D TYPE_VIO_SPAPR_DEVICE,
-    .instance_size =3D sizeof(VIOsPAPRVLANDevice),
+    .instance_size =3D sizeof(SpaprVioVlan),
     .class_init    =3D spapr_vlan_class_init,
     .instance_init =3D spapr_vlan_instance_init,
     .instance_finalize =3D spapr_vlan_instance_finalize,
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index bed1557d83..c98c7576e6 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -36,28 +36,28 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
=20
-typedef struct sPAPRNVRAM {
-    VIOsPAPRDevice sdev;
+typedef struct SpaprNvram {
+    SpaprVioDevice sdev;
     uint32_t size;
     uint8_t *buf;
     BlockBackend *blk;
     VMChangeStateEntry *vmstate;
-} sPAPRNVRAM;
+} SpaprNvram;
=20
 #define TYPE_VIO_SPAPR_NVRAM "spapr-nvram"
 #define VIO_SPAPR_NVRAM(obj) \
-     OBJECT_CHECK(sPAPRNVRAM, (obj), TYPE_VIO_SPAPR_NVRAM)
+     OBJECT_CHECK(SpaprNvram, (obj), TYPE_VIO_SPAPR_NVRAM)
=20
 #define MIN_NVRAM_SIZE      (8 * KiB)
 #define DEFAULT_NVRAM_SIZE  (64 * KiB)
 #define MAX_NVRAM_SIZE      (1 * MiB)
=20
-static void rtas_nvram_fetch(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static void rtas_nvram_fetch(PowerPCCPU *cpu, SpaprMachineState *spapr,
                              uint32_t token, uint32_t nargs,
                              target_ulong args,
                              uint32_t nret, target_ulong rets)
 {
-    sPAPRNVRAM *nvram =3D spapr->nvram;
+    SpaprNvram *nvram =3D spapr->nvram;
     hwaddr offset, buffer, len;
     void *membuf;
=20
@@ -93,12 +93,12 @@ static void rtas_nvram_fetch(PowerPCCPU *cpu, sPAPRMa=
chineState *spapr,
     rtas_st(rets, 1, len);
 }
=20
-static void rtas_nvram_store(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static void rtas_nvram_store(PowerPCCPU *cpu, SpaprMachineState *spapr,
                              uint32_t token, uint32_t nargs,
                              target_ulong args,
                              uint32_t nret, target_ulong rets)
 {
-    sPAPRNVRAM *nvram =3D spapr->nvram;
+    SpaprNvram *nvram =3D spapr->nvram;
     hwaddr offset, buffer, len;
     int alen;
     void *membuf;
@@ -139,9 +139,9 @@ static void rtas_nvram_store(PowerPCCPU *cpu, sPAPRMa=
chineState *spapr,
     rtas_st(rets, 1, (alen < 0) ? 0 : alen);
 }
=20
-static void spapr_nvram_realize(VIOsPAPRDevice *dev, Error **errp)
+static void spapr_nvram_realize(SpaprVioDevice *dev, Error **errp)
 {
-    sPAPRNVRAM *nvram =3D VIO_SPAPR_NVRAM(dev);
+    SpaprNvram *nvram =3D VIO_SPAPR_NVRAM(dev);
     int ret;
=20
     if (nvram->blk) {
@@ -193,16 +193,16 @@ static void spapr_nvram_realize(VIOsPAPRDevice *dev=
, Error **errp)
     spapr_rtas_register(RTAS_NVRAM_STORE, "nvram-store", rtas_nvram_stor=
e);
 }
=20
-static int spapr_nvram_devnode(VIOsPAPRDevice *dev, void *fdt, int node_=
off)
+static int spapr_nvram_devnode(SpaprVioDevice *dev, void *fdt, int node_=
off)
 {
-    sPAPRNVRAM *nvram =3D VIO_SPAPR_NVRAM(dev);
+    SpaprNvram *nvram =3D VIO_SPAPR_NVRAM(dev);
=20
     return fdt_setprop_cell(fdt, node_off, "#bytes", nvram->size);
 }
=20
 static int spapr_nvram_pre_load(void *opaque)
 {
-    sPAPRNVRAM *nvram =3D VIO_SPAPR_NVRAM(opaque);
+    SpaprNvram *nvram =3D VIO_SPAPR_NVRAM(opaque);
=20
     g_free(nvram->buf);
     nvram->buf =3D NULL;
@@ -213,7 +213,7 @@ static int spapr_nvram_pre_load(void *opaque)
=20
 static void postload_update_cb(void *opaque, int running, RunState state=
)
 {
-    sPAPRNVRAM *nvram =3D opaque;
+    SpaprNvram *nvram =3D opaque;
=20
     /* This is called after bdrv_invalidate_cache_all.  */
=20
@@ -225,7 +225,7 @@ static void postload_update_cb(void *opaque, int runn=
ing, RunState state)
=20
 static int spapr_nvram_post_load(void *opaque, int version_id)
 {
-    sPAPRNVRAM *nvram =3D VIO_SPAPR_NVRAM(opaque);
+    SpaprNvram *nvram =3D VIO_SPAPR_NVRAM(opaque);
=20
     if (nvram->blk) {
         nvram->vmstate =3D qemu_add_vm_change_state_handler(postload_upd=
ate_cb,
@@ -242,22 +242,22 @@ static const VMStateDescription vmstate_spapr_nvram=
 =3D {
     .pre_load =3D spapr_nvram_pre_load,
     .post_load =3D spapr_nvram_post_load,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT32(size, sPAPRNVRAM),
-        VMSTATE_VBUFFER_ALLOC_UINT32(buf, sPAPRNVRAM, 1, NULL, size),
+        VMSTATE_UINT32(size, SpaprNvram),
+        VMSTATE_VBUFFER_ALLOC_UINT32(buf, SpaprNvram, 1, NULL, size),
         VMSTATE_END_OF_LIST()
     },
 };
=20
 static Property spapr_nvram_properties[] =3D {
-    DEFINE_SPAPR_PROPERTIES(sPAPRNVRAM, sdev),
-    DEFINE_PROP_DRIVE("drive", sPAPRNVRAM, blk),
+    DEFINE_SPAPR_PROPERTIES(SpaprNvram, sdev),
+    DEFINE_PROP_DRIVE("drive", SpaprNvram, blk),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
 static void spapr_nvram_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    VIOsPAPRDeviceClass *k =3D VIO_SPAPR_DEVICE_CLASS(klass);
+    SpaprVioDeviceClass *k =3D VIO_SPAPR_DEVICE_CLASS(klass);
=20
     k->realize =3D spapr_nvram_realize;
     k->devnode =3D spapr_nvram_devnode;
@@ -274,7 +274,7 @@ static void spapr_nvram_class_init(ObjectClass *klass=
, void *data)
 static const TypeInfo spapr_nvram_type_info =3D {
     .name          =3D TYPE_VIO_SPAPR_NVRAM,
     .parent        =3D TYPE_VIO_SPAPR_DEVICE,
-    .instance_size =3D sizeof(sPAPRNVRAM),
+    .instance_size =3D sizeof(SpaprNvram),
     .class_init    =3D spapr_nvram_class_init,
 };
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e764e89806..6c16d6cfaf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -103,13 +103,13 @@
  * all and one to identify thread 0 of a VCORE. Any change to the first =
one
  * is likely to have an impact on the second one, so let's keep them clo=
se.
  */
-static int spapr_vcpu_id(sPAPRMachineState *spapr, int cpu_index)
+static int spapr_vcpu_id(SpaprMachineState *spapr, int cpu_index)
 {
     assert(spapr->vsmt);
     return
         (cpu_index / smp_threads) * spapr->vsmt + cpu_index % smp_thread=
s;
 }
-static bool spapr_is_thread0_in_vcore(sPAPRMachineState *spapr,
+static bool spapr_is_thread0_in_vcore(SpaprMachineState *spapr,
                                       PowerPCCPU *cpu)
 {
     assert(spapr->vsmt);
@@ -150,7 +150,7 @@ static void pre_2_10_vmstate_unregister_dummy_icp(int=
 i)
                        (void *)(uintptr_t) i);
 }
=20
-int spapr_max_server_number(sPAPRMachineState *spapr)
+int spapr_max_server_number(SpaprMachineState *spapr)
 {
     assert(spapr->vsmt);
     return DIV_ROUND_UP(max_cpus * spapr->vsmt, smp_threads);
@@ -205,7 +205,7 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int off=
set, PowerPCCPU *cpu)
 }
=20
 /* Populate the "ibm,pa-features" property */
-static void spapr_populate_pa_features(sPAPRMachineState *spapr,
+static void spapr_populate_pa_features(SpaprMachineState *spapr,
                                        PowerPCCPU *cpu,
                                        void *fdt, int offset,
                                        bool legacy_guest)
@@ -284,7 +284,7 @@ static void spapr_populate_pa_features(sPAPRMachineSt=
ate *spapr,
     _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_si=
ze)));
 }
=20
-static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
+static int spapr_fixup_cpu_dt(void *fdt, SpaprMachineState *spapr)
 {
     int ret =3D 0, offset, cpus_offset;
     CPUState *cs;
@@ -387,7 +387,7 @@ static int spapr_populate_memory_node(void *fdt, int =
nodeid, hwaddr start,
     return off;
 }
=20
-static int spapr_populate_memory(sPAPRMachineState *spapr, void *fdt)
+static int spapr_populate_memory(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *machine =3D MACHINE(spapr);
     hwaddr mem_start, node_size;
@@ -439,7 +439,7 @@ static int spapr_populate_memory(sPAPRMachineState *s=
papr, void *fdt)
 }
=20
 static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
-                                  sPAPRMachineState *spapr)
+                                  SpaprMachineState *spapr)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
     CPUPPCState *env =3D &cpu->env;
@@ -455,7 +455,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
     uint32_t vcpus_per_socket =3D smp_threads * smp_cores;
     uint32_t pft_size_prop[] =3D {0, cpu_to_be32(spapr->htab_shift)};
     int compat_smt =3D MIN(smp_threads, ppc_compat_max_vthreads(cpu));
-    sPAPRDRConnector *drc;
+    SpaprDrc *drc;
     int drc_index;
     uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
     int i;
@@ -568,7 +568,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
                               pcc->lrg_decr_bits)));
 }
=20
-static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *sp=
apr)
+static void spapr_populate_cpus_dt_node(void *fdt, SpaprMachineState *sp=
apr)
 {
     CPUState **rev;
     CPUState *cs;
@@ -692,7 +692,7 @@ spapr_get_drconf_cell(uint32_t seq_lmbs, uint64_t bas=
e_addr,
 }
=20
 /* ibm,dynamic-memory-v2 */
-static int spapr_populate_drmem_v2(sPAPRMachineState *spapr, void *fdt,
+static int spapr_populate_drmem_v2(SpaprMachineState *spapr, void *fdt,
                                    int offset, MemoryDeviceInfoList *dim=
ms)
 {
     MachineState *machine =3D MACHINE(spapr);
@@ -704,7 +704,7 @@ static int spapr_populate_drmem_v2(sPAPRMachineState =
*spapr, void *fdt,
     uint64_t mem_end =3D machine->device_memory->base +
                        memory_region_size(&machine->device_memory->mr);
     uint32_t node, buf_len, nr_entries =3D 0;
-    sPAPRDRConnector *drc;
+    SpaprDrc *drc;
     DrconfCellQueue *elem, *next;
     MemoryDeviceInfoList *info;
     QSIMPLEQ_HEAD(, DrconfCellQueue) drconf_queue
@@ -777,7 +777,7 @@ static int spapr_populate_drmem_v2(sPAPRMachineState =
*spapr, void *fdt,
 }
=20
 /* ibm,dynamic-memory */
-static int spapr_populate_drmem_v1(sPAPRMachineState *spapr, void *fdt,
+static int spapr_populate_drmem_v1(SpaprMachineState *spapr, void *fdt,
                                    int offset, MemoryDeviceInfoList *dim=
ms)
 {
     MachineState *machine =3D MACHINE(spapr);
@@ -801,7 +801,7 @@ static int spapr_populate_drmem_v1(sPAPRMachineState =
*spapr, void *fdt,
         uint32_t *dynamic_memory =3D cur_index;
=20
         if (i >=3D device_lmb_start) {
-            sPAPRDRConnector *drc;
+            SpaprDrc *drc;
=20
             drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, i);
             g_assert(drc);
@@ -846,7 +846,7 @@ static int spapr_populate_drmem_v1(sPAPRMachineState =
*spapr, void *fdt,
  * Refer to docs/specs/ppc-spapr-hotplug.txt for the documentation
  * of this device tree node.
  */
-static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *=
fdt)
+static int spapr_populate_drconf_memory(SpaprMachineState *spapr, void *=
fdt)
 {
     MachineState *machine =3D MACHINE(spapr);
     int ret, i, offset;
@@ -917,10 +917,10 @@ static int spapr_populate_drconf_memory(sPAPRMachin=
eState *spapr, void *fdt)
     return ret;
 }
=20
-static int spapr_dt_cas_updates(sPAPRMachineState *spapr, void *fdt,
-                                sPAPROptionVector *ov5_updates)
+static int spapr_dt_cas_updates(SpaprMachineState *spapr, void *fdt,
+                                SpaprOptionVector *ov5_updates)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     int ret =3D 0, offset;
=20
     /* Generate ibm,dynamic-reconfiguration-memory node if required */
@@ -966,12 +966,12 @@ static bool spapr_hotplugged_dev_before_cas(void)
     return false;
 }
=20
-int spapr_h_cas_compose_response(sPAPRMachineState *spapr,
+int spapr_h_cas_compose_response(SpaprMachineState *spapr,
                                  target_ulong addr, target_ulong size,
-                                 sPAPROptionVector *ov5_updates)
+                                 SpaprOptionVector *ov5_updates)
 {
     void *fdt, *fdt_skel;
-    sPAPRDeviceTreeUpdateHeader hdr =3D { .version_id =3D 1 };
+    SpaprDeviceTreeUpdateHeader hdr =3D { .version_id =3D 1 };
=20
     if (spapr_hotplugged_dev_before_cas()) {
         return 1;
@@ -1020,7 +1020,7 @@ int spapr_h_cas_compose_response(sPAPRMachineState =
*spapr,
     return 0;
 }
=20
-static void spapr_dt_rtas(sPAPRMachineState *spapr, void *fdt)
+static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
 {
     int rtas;
     GString *hypertas =3D g_string_sized_new(256);
@@ -1109,7 +1109,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr,=
 void *fdt)
  * and the XIVE features that the guest may request and thus the valid
  * values for bytes 23..26 of option vector 5:
  */
-static void spapr_dt_ov5_platform_support(sPAPRMachineState *spapr, void=
 *fdt,
+static void spapr_dt_ov5_platform_support(SpaprMachineState *spapr, void=
 *fdt,
                                           int chosen)
 {
     PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
@@ -1145,7 +1145,7 @@ static void spapr_dt_ov5_platform_support(sPAPRMach=
ineState *spapr, void *fdt,
                      val, sizeof(val)));
 }
=20
-static void spapr_dt_chosen(sPAPRMachineState *spapr, void *fdt)
+static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *machine =3D MACHINE(spapr);
     int chosen;
@@ -1211,7 +1211,7 @@ static void spapr_dt_chosen(sPAPRMachineState *spap=
r, void *fdt)
     g_free(bootlist);
 }
=20
-static void spapr_dt_hypervisor(sPAPRMachineState *spapr, void *fdt)
+static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
 {
     /* The /hypervisor node isn't in PAPR - this is a hack to allow PR
      * KVM to work under pHyp with some guest co-operation */
@@ -1234,14 +1234,14 @@ static void spapr_dt_hypervisor(sPAPRMachineState=
 *spapr, void *fdt)
     }
 }
=20
-static void *spapr_build_fdt(sPAPRMachineState *spapr)
+static void *spapr_build_fdt(SpaprMachineState *spapr)
 {
     MachineState *machine =3D MACHINE(spapr);
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
     int ret;
     void *fdt;
-    sPAPRPHBState *phb;
+    SpaprPhbState *phb;
     char *buf;
=20
     fdt =3D g_malloc0(FDT_MAX_SIZE);
@@ -1439,7 +1439,7 @@ void spapr_set_all_lpcrs(target_ulong value, target=
_ulong mask)
=20
 static void spapr_get_pate(PPCVirtualHypervisor *vhyp, ppc_v3_pate_t *en=
try)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(vhyp);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(vhyp);
=20
     /* Copy PATE1:GR into PATE0:HR */
     entry->dw0 =3D spapr->patb_entry & PATE0_HR;
@@ -1455,7 +1455,7 @@ static void spapr_get_pate(PPCVirtualHypervisor *vh=
yp, ppc_v3_pate_t *entry)
 /*
  * Get the fd to access the kernel htab, re-opening it if necessary
  */
-static int get_htab_fd(sPAPRMachineState *spapr)
+static int get_htab_fd(SpaprMachineState *spapr)
 {
     Error *local_err =3D NULL;
=20
@@ -1471,7 +1471,7 @@ static int get_htab_fd(sPAPRMachineState *spapr)
     return spapr->htab_fd;
 }
=20
-void close_htab_fd(sPAPRMachineState *spapr)
+void close_htab_fd(SpaprMachineState *spapr)
 {
     if (spapr->htab_fd >=3D 0) {
         close(spapr->htab_fd);
@@ -1481,14 +1481,14 @@ void close_htab_fd(sPAPRMachineState *spapr)
=20
 static hwaddr spapr_hpt_mask(PPCVirtualHypervisor *vhyp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(vhyp);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(vhyp);
=20
     return HTAB_SIZE(spapr) / HASH_PTEG_SIZE_64 - 1;
 }
=20
 static target_ulong spapr_encode_hpt_for_kvm_pr(PPCVirtualHypervisor *vh=
yp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(vhyp);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(vhyp);
=20
     assert(kvm_enabled());
=20
@@ -1502,7 +1502,7 @@ static target_ulong spapr_encode_hpt_for_kvm_pr(PPC=
VirtualHypervisor *vhyp)
 static const ppc_hash_pte64_t *spapr_map_hptes(PPCVirtualHypervisor *vhy=
p,
                                                 hwaddr ptex, int n)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(vhyp);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(vhyp);
     hwaddr pte_offset =3D ptex * HASH_PTE_SIZE_64;
=20
     if (!spapr->htab) {
@@ -1525,7 +1525,7 @@ static void spapr_unmap_hptes(PPCVirtualHypervisor =
*vhyp,
                               const ppc_hash_pte64_t *hptes,
                               hwaddr ptex, int n)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(vhyp);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(vhyp);
=20
     if (!spapr->htab) {
         g_free((void *)hptes);
@@ -1537,7 +1537,7 @@ static void spapr_unmap_hptes(PPCVirtualHypervisor =
*vhyp,
 static void spapr_store_hpte(PPCVirtualHypervisor *vhyp, hwaddr ptex,
                              uint64_t pte0, uint64_t pte1)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(vhyp);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(vhyp);
     hwaddr offset =3D ptex * HASH_PTE_SIZE_64;
=20
     if (!spapr->htab) {
@@ -1578,7 +1578,7 @@ int spapr_hpt_shift_for_ramsize(uint64_t ramsize)
     return shift;
 }
=20
-void spapr_free_hpt(sPAPRMachineState *spapr)
+void spapr_free_hpt(SpaprMachineState *spapr)
 {
     g_free(spapr->htab);
     spapr->htab =3D NULL;
@@ -1586,7 +1586,7 @@ void spapr_free_hpt(sPAPRMachineState *spapr)
     close_htab_fd(spapr);
 }
=20
-void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
+void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
                           Error **errp)
 {
     long rc;
@@ -1636,7 +1636,7 @@ void spapr_reallocate_hpt(sPAPRMachineState *spapr,=
 int shift,
     spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
 }
=20
-void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
+void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr)
 {
     int hpt_shift;
=20
@@ -1660,8 +1660,8 @@ void spapr_setup_hpt_and_vrma(sPAPRMachineState *sp=
apr)
=20
 static int spapr_reset_drcs(Object *child, void *opaque)
 {
-    sPAPRDRConnector *drc =3D
-        (sPAPRDRConnector *) object_dynamic_cast(child,
+    SpaprDrc *drc =3D
+        (SpaprDrc *) object_dynamic_cast(child,
                                                  TYPE_SPAPR_DR_CONNECTOR=
);
=20
     if (drc) {
@@ -1674,7 +1674,7 @@ static int spapr_reset_drcs(Object *child, void *op=
aque)
 static void spapr_machine_reset(void)
 {
     MachineState *machine =3D MACHINE(qdev_get_machine());
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(machine);
     PowerPCCPU *first_ppc_cpu;
     uint32_t rtas_limit;
     hwaddr rtas_addr, fdt_addr;
@@ -1779,7 +1779,7 @@ static void spapr_machine_reset(void)
     spapr->cas_reboot =3D false;
 }
=20
-static void spapr_create_nvram(sPAPRMachineState *spapr)
+static void spapr_create_nvram(SpaprMachineState *spapr)
 {
     DeviceState *dev =3D qdev_create(&spapr->vio_bus->bus, "spapr-nvram"=
);
     DriveInfo *dinfo =3D drive_get(IF_PFLASH, 0, 0);
@@ -1791,10 +1791,10 @@ static void spapr_create_nvram(sPAPRMachineState =
*spapr)
=20
     qdev_init_nofail(dev);
=20
-    spapr->nvram =3D (struct sPAPRNVRAM *)dev;
+    spapr->nvram =3D (struct SpaprNvram *)dev;
 }
=20
-static void spapr_rtc_create(sPAPRMachineState *spapr)
+static void spapr_rtc_create(SpaprMachineState *spapr)
 {
     object_initialize_child(OBJECT(spapr), "rtc",
                             &spapr->rtc, sizeof(spapr->rtc), TYPE_SPAPR_=
RTC,
@@ -1838,7 +1838,7 @@ static int spapr_pre_load(void *opaque)
=20
 static int spapr_post_load(void *opaque, int version_id)
 {
-    sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
+    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
     int err =3D 0;
=20
     err =3D spapr_caps_post_migration(spapr);
@@ -1905,7 +1905,7 @@ static bool version_before_3(void *opaque, int vers=
ion_id)
=20
 static bool spapr_pending_events_needed(void *opaque)
 {
-    sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
+    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
     return !QTAILQ_EMPTY(&spapr->pending_events);
 }
=20
@@ -1914,9 +1914,9 @@ static const VMStateDescription vmstate_spapr_event=
_entry =3D {
     .version_id =3D 1,
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT32(summary, sPAPREventLogEntry),
-        VMSTATE_UINT32(extended_length, sPAPREventLogEntry),
-        VMSTATE_VBUFFER_ALLOC_UINT32(extended_log, sPAPREventLogEntry, 0=
,
+        VMSTATE_UINT32(summary, SpaprEventLogEntry),
+        VMSTATE_UINT32(extended_length, SpaprEventLogEntry),
+        VMSTATE_VBUFFER_ALLOC_UINT32(extended_log, SpaprEventLogEntry, 0=
,
                                      NULL, extended_length),
         VMSTATE_END_OF_LIST()
     },
@@ -1928,21 +1928,21 @@ static const VMStateDescription vmstate_spapr_pen=
ding_events =3D {
     .minimum_version_id =3D 1,
     .needed =3D spapr_pending_events_needed,
     .fields =3D (VMStateField[]) {
-        VMSTATE_QTAILQ_V(pending_events, sPAPRMachineState, 1,
-                         vmstate_spapr_event_entry, sPAPREventLogEntry, =
next),
+        VMSTATE_QTAILQ_V(pending_events, SpaprMachineState, 1,
+                         vmstate_spapr_event_entry, SpaprEventLogEntry, =
next),
         VMSTATE_END_OF_LIST()
     },
 };
=20
 static bool spapr_ov5_cas_needed(void *opaque)
 {
-    sPAPRMachineState *spapr =3D opaque;
-    sPAPROptionVector *ov5_mask =3D spapr_ovec_new();
-    sPAPROptionVector *ov5_legacy =3D spapr_ovec_new();
-    sPAPROptionVector *ov5_removed =3D spapr_ovec_new();
+    SpaprMachineState *spapr =3D opaque;
+    SpaprOptionVector *ov5_mask =3D spapr_ovec_new();
+    SpaprOptionVector *ov5_legacy =3D spapr_ovec_new();
+    SpaprOptionVector *ov5_removed =3D spapr_ovec_new();
     bool cas_needed;
=20
-    /* Prior to the introduction of sPAPROptionVector, we had two option
+    /* Prior to the introduction of SpaprOptionVector, we had two option
      * vectors we dealt with: OV5_FORM1_AFFINITY, and OV5_DRCONF_MEMORY.
      * Both of these options encode machine topology into the device-tre=
e
      * in such a way that the now-booted OS should still be able to inte=
ract
@@ -1992,15 +1992,15 @@ static const VMStateDescription vmstate_spapr_ov5=
_cas =3D {
     .minimum_version_id =3D 1,
     .needed =3D spapr_ov5_cas_needed,
     .fields =3D (VMStateField[]) {
-        VMSTATE_STRUCT_POINTER_V(ov5_cas, sPAPRMachineState, 1,
-                                 vmstate_spapr_ovec, sPAPROptionVector),
+        VMSTATE_STRUCT_POINTER_V(ov5_cas, SpaprMachineState, 1,
+                                 vmstate_spapr_ovec, SpaprOptionVector),
         VMSTATE_END_OF_LIST()
     },
 };
=20
 static bool spapr_patb_entry_needed(void *opaque)
 {
-    sPAPRMachineState *spapr =3D opaque;
+    SpaprMachineState *spapr =3D opaque;
=20
     return !!spapr->patb_entry;
 }
@@ -2011,14 +2011,14 @@ static const VMStateDescription vmstate_spapr_pat=
b_entry =3D {
     .minimum_version_id =3D 1,
     .needed =3D spapr_patb_entry_needed,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT64(patb_entry, sPAPRMachineState),
+        VMSTATE_UINT64(patb_entry, SpaprMachineState),
         VMSTATE_END_OF_LIST()
     },
 };
=20
 static bool spapr_irq_map_needed(void *opaque)
 {
-    sPAPRMachineState *spapr =3D opaque;
+    SpaprMachineState *spapr =3D opaque;
=20
     return spapr->irq_map && !bitmap_empty(spapr->irq_map, spapr->irq_ma=
p_nr);
 }
@@ -2029,21 +2029,21 @@ static const VMStateDescription vmstate_spapr_irq=
_map =3D {
     .minimum_version_id =3D 1,
     .needed =3D spapr_irq_map_needed,
     .fields =3D (VMStateField[]) {
-        VMSTATE_BITMAP(irq_map, sPAPRMachineState, 0, irq_map_nr),
+        VMSTATE_BITMAP(irq_map, SpaprMachineState, 0, irq_map_nr),
         VMSTATE_END_OF_LIST()
     },
 };
=20
 static bool spapr_dtb_needed(void *opaque)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(opaque);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(opaque);
=20
     return smc->update_dt_enabled;
 }
=20
 static int spapr_dtb_pre_load(void *opaque)
 {
-    sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
+    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
=20
     g_free(spapr->fdt_blob);
     spapr->fdt_blob =3D NULL;
@@ -2059,9 +2059,9 @@ static const VMStateDescription vmstate_spapr_dtb =3D=
 {
     .needed =3D spapr_dtb_needed,
     .pre_load =3D spapr_dtb_pre_load,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT32(fdt_initial_size, sPAPRMachineState),
-        VMSTATE_UINT32(fdt_size, sPAPRMachineState),
-        VMSTATE_VBUFFER_ALLOC_UINT32(fdt_blob, sPAPRMachineState, 0, NUL=
L,
+        VMSTATE_UINT32(fdt_initial_size, SpaprMachineState),
+        VMSTATE_UINT32(fdt_size, SpaprMachineState),
+        VMSTATE_VBUFFER_ALLOC_UINT32(fdt_blob, SpaprMachineState, 0, NUL=
L,
                                      fdt_size),
         VMSTATE_END_OF_LIST()
     },
@@ -2079,9 +2079,9 @@ static const VMStateDescription vmstate_spapr =3D {
         VMSTATE_UNUSED_BUFFER(version_before_3, 0, 4),
=20
         /* RTC offset */
-        VMSTATE_UINT64_TEST(rtc_offset, sPAPRMachineState, version_befor=
e_3),
+        VMSTATE_UINT64_TEST(rtc_offset, SpaprMachineState, version_befor=
e_3),
=20
-        VMSTATE_PPC_TIMEBASE_V(tb, sPAPRMachineState, 2),
+        VMSTATE_PPC_TIMEBASE_V(tb, SpaprMachineState, 2),
         VMSTATE_END_OF_LIST()
     },
     .subsections =3D (const VMStateDescription*[]) {
@@ -2105,7 +2105,7 @@ static const VMStateDescription vmstate_spapr =3D {
=20
 static int htab_save_setup(QEMUFile *f, void *opaque)
 {
-    sPAPRMachineState *spapr =3D opaque;
+    SpaprMachineState *spapr =3D opaque;
=20
     /* "Iteration" header */
     if (!spapr->htab_shift) {
@@ -2127,7 +2127,7 @@ static int htab_save_setup(QEMUFile *f, void *opaqu=
e)
     return 0;
 }
=20
-static void htab_save_chunk(QEMUFile *f, sPAPRMachineState *spapr,
+static void htab_save_chunk(QEMUFile *f, SpaprMachineState *spapr,
                             int chunkstart, int n_valid, int n_invalid)
 {
     qemu_put_be32(f, chunkstart);
@@ -2144,7 +2144,7 @@ static void htab_save_end_marker(QEMUFile *f)
     qemu_put_be16(f, 0);
 }
=20
-static void htab_save_first_pass(QEMUFile *f, sPAPRMachineState *spapr,
+static void htab_save_first_pass(QEMUFile *f, SpaprMachineState *spapr,
                                  int64_t max_ns)
 {
     bool has_timeout =3D max_ns !=3D -1;
@@ -2192,7 +2192,7 @@ static void htab_save_first_pass(QEMUFile *f, sPAPR=
MachineState *spapr,
     spapr->htab_save_index =3D index;
 }
=20
-static int htab_save_later_pass(QEMUFile *f, sPAPRMachineState *spapr,
+static int htab_save_later_pass(QEMUFile *f, SpaprMachineState *spapr,
                                 int64_t max_ns)
 {
     bool final =3D max_ns < 0;
@@ -2270,7 +2270,7 @@ static int htab_save_later_pass(QEMUFile *f, sPAPRM=
achineState *spapr,
=20
 static int htab_save_iterate(QEMUFile *f, void *opaque)
 {
-    sPAPRMachineState *spapr =3D opaque;
+    SpaprMachineState *spapr =3D opaque;
     int fd;
     int rc =3D 0;
=20
@@ -2307,7 +2307,7 @@ static int htab_save_iterate(QEMUFile *f, void *opa=
que)
=20
 static int htab_save_complete(QEMUFile *f, void *opaque)
 {
-    sPAPRMachineState *spapr =3D opaque;
+    SpaprMachineState *spapr =3D opaque;
     int fd;
=20
     /* Iteration header */
@@ -2347,7 +2347,7 @@ static int htab_save_complete(QEMUFile *f, void *op=
aque)
=20
 static int htab_load(QEMUFile *f, void *opaque, int version_id)
 {
-    sPAPRMachineState *spapr =3D opaque;
+    SpaprMachineState *spapr =3D opaque;
     uint32_t section_hdr;
     int fd =3D -1;
     Error *local_err =3D NULL;
@@ -2437,7 +2437,7 @@ static int htab_load(QEMUFile *f, void *opaque, int=
 version_id)
=20
 static void htab_save_cleanup(void *opaque)
 {
-    sPAPRMachineState *spapr =3D opaque;
+    SpaprMachineState *spapr =3D opaque;
=20
     close_htab_fd(spapr);
 }
@@ -2457,7 +2457,7 @@ static void spapr_boot_set(void *opaque, const char=
 *boot_device,
     machine->boot_order =3D g_strdup(boot_device);
 }
=20
-static void spapr_create_lmb_dr_connectors(sPAPRMachineState *spapr)
+static void spapr_create_lmb_dr_connectors(SpaprMachineState *spapr)
 {
     MachineState *machine =3D MACHINE(spapr);
     uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
@@ -2524,7 +2524,7 @@ static CPUArchId *spapr_find_cpu_slot(MachineState =
*ms, uint32_t id, int *idx)
     return &ms->possible_cpus->cpus[index];
 }
=20
-static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
+static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
 {
     Error *local_err =3D NULL;
     bool vsmt_user =3D !!spapr->vsmt;
@@ -2596,11 +2596,11 @@ out:
     error_propagate(errp, local_err);
 }
=20
-static void spapr_init_cpus(sPAPRMachineState *spapr)
+static void spapr_init_cpus(SpaprMachineState *spapr)
 {
     MachineState *machine =3D MACHINE(spapr);
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
     const char *type =3D spapr_get_cpu_core_type(machine->cpu_type);
     const CPUArchIdList *possible_cpus;
     int boot_cores_nr =3D smp_cpus / smp_threads;
@@ -2679,8 +2679,8 @@ static PCIHostState *spapr_create_default_phb(void)
 /* pSeries LPAR / sPAPR hardware init */
 static void spapr_machine_init(MachineState *machine)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(machine);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
     const char *kernel_filename =3D machine->kernel_filename;
     const char *initrd_filename =3D machine->initrd_filename;
     PCIHostState *phb;
@@ -3076,7 +3076,7 @@ static char *spapr_get_fw_dev_path(FWPathProvider *=
p, BusState *bus,
 #define CAST(type, obj, name) \
     ((type *)object_dynamic_cast(OBJECT(obj), (name)))
     SCSIDevice *d =3D CAST(SCSIDevice,  dev, TYPE_SCSI_DEVICE);
-    sPAPRPHBState *phb =3D CAST(sPAPRPHBState, dev, TYPE_SPAPR_PCI_HOST_=
BRIDGE);
+    SpaprPhbState *phb =3D CAST(SpaprPhbState, dev, TYPE_SPAPR_PCI_HOST_=
BRIDGE);
     VHostSCSICommon *vsc =3D CAST(VHostSCSICommon, dev, TYPE_VHOST_SCSI_=
COMMON);
=20
     if (d) {
@@ -3156,14 +3156,14 @@ static char *spapr_get_fw_dev_path(FWPathProvider=
 *p, BusState *bus,
=20
 static char *spapr_get_kvm_type(Object *obj, Error **errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
     return g_strdup(spapr->kvm_type);
 }
=20
 static void spapr_set_kvm_type(Object *obj, const char *value, Error **e=
rrp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
     g_free(spapr->kvm_type);
     spapr->kvm_type =3D g_strdup(value);
@@ -3171,7 +3171,7 @@ static void spapr_set_kvm_type(Object *obj, const c=
har *value, Error **errp)
=20
 static bool spapr_get_modern_hotplug_events(Object *obj, Error **errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
     return spapr->use_hotplug_event_source;
 }
@@ -3179,7 +3179,7 @@ static bool spapr_get_modern_hotplug_events(Object =
*obj, Error **errp)
 static void spapr_set_modern_hotplug_events(Object *obj, bool value,
                                             Error **errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
     spapr->use_hotplug_event_source =3D value;
 }
@@ -3191,7 +3191,7 @@ static bool spapr_get_msix_emulation(Object *obj, E=
rror **errp)
=20
 static char *spapr_get_resize_hpt(Object *obj, Error **errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
     switch (spapr->resize_hpt) {
     case SPAPR_RESIZE_HPT_DEFAULT:
@@ -3208,7 +3208,7 @@ static char *spapr_get_resize_hpt(Object *obj, Erro=
r **errp)
=20
 static void spapr_set_resize_hpt(Object *obj, const char *value, Error *=
*errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
     if (strcmp(value, "default") =3D=3D 0) {
         spapr->resize_hpt =3D SPAPR_RESIZE_HPT_DEFAULT;
@@ -3237,7 +3237,7 @@ static void spapr_set_vsmt(Object *obj, Visitor *v,=
 const char *name,
=20
 static char *spapr_get_ic_mode(Object *obj, Error **errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
     if (spapr->irq =3D=3D &spapr_irq_xics_legacy) {
         return g_strdup("legacy");
@@ -3253,7 +3253,7 @@ static char *spapr_get_ic_mode(Object *obj, Error *=
*errp)
=20
 static void spapr_set_ic_mode(Object *obj, const char *value, Error **er=
rp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
     if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
         error_setg(errp, "This machine only uses the legacy XICS backend=
, don't pass ic-mode");
@@ -3274,14 +3274,14 @@ static void spapr_set_ic_mode(Object *obj, const =
char *value, Error **errp)
=20
 static char *spapr_get_host_model(Object *obj, Error **errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
     return g_strdup(spapr->host_model);
 }
=20
 static void spapr_set_host_model(Object *obj, const char *value, Error *=
*errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
     g_free(spapr->host_model);
     spapr->host_model =3D g_strdup(value);
@@ -3289,14 +3289,14 @@ static void spapr_set_host_model(Object *obj, con=
st char *value, Error **errp)
=20
 static char *spapr_get_host_serial(Object *obj, Error **errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
     return g_strdup(spapr->host_serial);
 }
=20
 static void spapr_set_host_serial(Object *obj, const char *value, Error =
**errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
     g_free(spapr->host_serial);
     spapr->host_serial =3D g_strdup(value);
@@ -3304,8 +3304,8 @@ static void spapr_set_host_serial(Object *obj, cons=
t char *value, Error **errp)
=20
 static void spapr_instance_init(Object *obj)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
=20
     spapr->htab_fd =3D -1;
     spapr->use_hotplug_event_source =3D true;
@@ -3362,7 +3362,7 @@ static void spapr_instance_init(Object *obj)
=20
 static void spapr_machine_finalizefn(Object *obj)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
     g_free(spapr->kvm_type);
 }
@@ -3382,7 +3382,7 @@ static void spapr_nmi(NMIState *n, int cpu_index, E=
rror **errp)
     }
 }
=20
-int spapr_lmb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spap=
r,
+int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp=
)
 {
     uint64_t addr;
@@ -3399,7 +3399,7 @@ int spapr_lmb_dt_populate(sPAPRDRConnector *drc, sP=
APRMachineState *spapr,
 static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64=
_t size,
                            bool dedicated_hp_event_source, Error **errp)
 {
-    sPAPRDRConnector *drc;
+    SpaprDrc *drc;
     uint32_t nr_lmbs =3D size/SPAPR_MEMORY_BLOCK_SIZE;
     int i;
     uint64_t addr =3D addr_start;
@@ -3448,7 +3448,7 @@ static void spapr_memory_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
                               Error **errp)
 {
     Error *local_err =3D NULL;
-    sPAPRMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
+    SpaprMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm =3D PC_DIMM(dev);
     uint64_t size, addr;
=20
@@ -3482,8 +3482,8 @@ out:
 static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceSta=
te *dev,
                                   Error **errp)
 {
-    const sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(hotplug_dev=
);
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
+    const SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(hotplug_dev=
);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm =3D PC_DIMM(dev);
     Error *local_err =3D NULL;
     uint64_t size;
@@ -3519,16 +3519,16 @@ static void spapr_memory_pre_plug(HotplugHandler =
*hotplug_dev, DeviceState *dev,
     pc_dimm_pre_plug(dimm, MACHINE(hotplug_dev), NULL, errp);
 }
=20
-struct sPAPRDIMMState {
+struct SpaprDimmState {
     PCDIMMDevice *dimm;
     uint32_t nr_lmbs;
-    QTAILQ_ENTRY(sPAPRDIMMState) next;
+    QTAILQ_ENTRY(SpaprDimmState) next;
 };
=20
-static sPAPRDIMMState *spapr_pending_dimm_unplugs_find(sPAPRMachineState=
 *s,
+static SpaprDimmState *spapr_pending_dimm_unplugs_find(SpaprMachineState=
 *s,
                                                        PCDIMMDevice *dim=
m)
 {
-    sPAPRDIMMState *dimm_state =3D NULL;
+    SpaprDimmState *dimm_state =3D NULL;
=20
     QTAILQ_FOREACH(dimm_state, &s->pending_dimm_unplugs, next) {
         if (dimm_state->dimm =3D=3D dimm) {
@@ -3538,11 +3538,11 @@ static sPAPRDIMMState *spapr_pending_dimm_unplugs=
_find(sPAPRMachineState *s,
     return dimm_state;
 }
=20
-static sPAPRDIMMState *spapr_pending_dimm_unplugs_add(sPAPRMachineState =
*spapr,
+static SpaprDimmState *spapr_pending_dimm_unplugs_add(SpaprMachineState =
*spapr,
                                                       uint32_t nr_lmbs,
                                                       PCDIMMDevice *dimm=
)
 {
-    sPAPRDIMMState *ds =3D NULL;
+    SpaprDimmState *ds =3D NULL;
=20
     /*
      * If this request is for a DIMM whose removal had failed earlier
@@ -3552,7 +3552,7 @@ static sPAPRDIMMState *spapr_pending_dimm_unplugs_a=
dd(sPAPRMachineState *spapr,
      */
     ds =3D spapr_pending_dimm_unplugs_find(spapr, dimm);
     if (!ds) {
-        ds =3D g_malloc0(sizeof(sPAPRDIMMState));
+        ds =3D g_malloc0(sizeof(SpaprDimmState));
         ds->nr_lmbs =3D nr_lmbs;
         ds->dimm =3D dimm;
         QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, ds, next);
@@ -3560,17 +3560,17 @@ static sPAPRDIMMState *spapr_pending_dimm_unplugs=
_add(sPAPRMachineState *spapr,
     return ds;
 }
=20
-static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
-                                              sPAPRDIMMState *dimm_state=
)
+static void spapr_pending_dimm_unplugs_remove(SpaprMachineState *spapr,
+                                              SpaprDimmState *dimm_state=
)
 {
     QTAILQ_REMOVE(&spapr->pending_dimm_unplugs, dimm_state, next);
     g_free(dimm_state);
 }
=20
-static sPAPRDIMMState *spapr_recover_pending_dimm_state(sPAPRMachineStat=
e *ms,
+static SpaprDimmState *spapr_recover_pending_dimm_state(SpaprMachineStat=
e *ms,
                                                         PCDIMMDevice *di=
mm)
 {
-    sPAPRDRConnector *drc;
+    SpaprDrc *drc;
     uint64_t size =3D memory_device_get_region_size(MEMORY_DEVICE(dimm),
                                                   &error_abort);
     uint32_t nr_lmbs =3D size / SPAPR_MEMORY_BLOCK_SIZE;
@@ -3599,8 +3599,8 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_s=
tate(sPAPRMachineState *ms,
 void spapr_lmb_release(DeviceState *dev)
 {
     HotplugHandler *hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(hotplug_ctrl);
-    sPAPRDIMMState *ds =3D spapr_pending_dimm_unplugs_find(spapr, PC_DIM=
M(dev));
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(hotplug_ctrl);
+    SpaprDimmState *ds =3D spapr_pending_dimm_unplugs_find(spapr, PC_DIM=
M(dev));
=20
     /* This information will get lost if a migration occurs
      * during the unplug process. In this case recover it. */
@@ -3625,8 +3625,8 @@ void spapr_lmb_release(DeviceState *dev)
=20
 static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState=
 *dev)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
-    sPAPRDIMMState *ds =3D spapr_pending_dimm_unplugs_find(spapr, PC_DIM=
M(dev));
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
+    SpaprDimmState *ds =3D spapr_pending_dimm_unplugs_find(spapr, PC_DIM=
M(dev));
=20
     pc_dimm_unplug(PC_DIMM(dev), MACHINE(hotplug_dev));
     object_property_set_bool(OBJECT(dev), false, "realized", NULL);
@@ -3636,13 +3636,13 @@ static void spapr_memory_unplug(HotplugHandler *h=
otplug_dev, DeviceState *dev)
 static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
     Error *local_err =3D NULL;
     PCDIMMDevice *dimm =3D PC_DIMM(dev);
     uint32_t nr_lmbs;
     uint64_t size, addr_start, addr;
     int i;
-    sPAPRDRConnector *drc;
+    SpaprDrc *drc;
=20
     size =3D memory_device_get_region_size(MEMORY_DEVICE(dimm), &error_a=
bort);
     nr_lmbs =3D size / SPAPR_MEMORY_BLOCK_SIZE;
@@ -3699,12 +3699,12 @@ void spapr_core_release(DeviceState *dev)
 static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *=
dev)
 {
     MachineState *ms =3D MACHINE(hotplug_dev);
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
     CPUCore *cc =3D CPU_CORE(dev);
     CPUArchId *core_slot =3D spapr_find_cpu_slot(ms, cc->core_id, NULL);
=20
     if (smc->pre_2_10_has_unused_icps) {
-        sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
+        SpaprCpuCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
         int i;
=20
         for (i =3D 0; i < cc->nr_threads; i++) {
@@ -3723,9 +3723,9 @@ static
 void spapr_core_unplug_request(HotplugHandler *hotplug_dev, DeviceState =
*dev,
                                Error **errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
     int index;
-    sPAPRDRConnector *drc;
+    SpaprDrc *drc;
     CPUCore *cc =3D CPU_CORE(dev);
=20
     if (!spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index))=
 {
@@ -3747,10 +3747,10 @@ void spapr_core_unplug_request(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
     spapr_hotplug_req_remove_by_index(drc);
 }
=20
-int spapr_core_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spa=
pr,
+int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                            void *fdt, int *fdt_start_offset, Error **err=
p)
 {
-    sPAPRCPUCore *core =3D SPAPR_CPU_CORE(drc->dev);
+    SpaprCpuCore *core =3D SPAPR_CPU_CORE(drc->dev);
     CPUState *cs =3D CPU(core->threads[0]);
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
     DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
@@ -3771,13 +3771,13 @@ int spapr_core_dt_populate(sPAPRDRConnector *drc,=
 sPAPRMachineState *spapr,
 static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *de=
v,
                             Error **errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc =3D MACHINE_GET_CLASS(spapr);
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
-    sPAPRCPUCore *core =3D SPAPR_CPU_CORE(OBJECT(dev));
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+    SpaprCpuCore *core =3D SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc =3D CPU_CORE(dev);
     CPUState *cs;
-    sPAPRDRConnector *drc;
+    SpaprDrc *drc;
     Error *local_err =3D NULL;
     CPUArchId *core_slot;
     int index;
@@ -3880,10 +3880,10 @@ out:
     error_propagate(errp, local_err);
 }
=20
-int spapr_phb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spap=
r,
+int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp=
)
 {
-    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(drc->dev);
+    SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(drc->dev);
     int intc_phandle;
=20
     intc_phandle =3D spapr_irq_get_phandle(spapr, spapr->fdt_blob, errp)=
;
@@ -3906,9 +3906,9 @@ int spapr_phb_dt_populate(sPAPRDRConnector *drc, sP=
APRMachineState *spapr,
 static void spapr_phb_pre_plug(HotplugHandler *hotplug_dev, DeviceState =
*dev,
                                Error **errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
-    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
+    SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     const unsigned windows_supported =3D spapr_phb_windows_supported(sph=
b);
=20
     if (dev->hotplugged && !smc->dr_phb_enabled) {
@@ -3934,10 +3934,10 @@ static void spapr_phb_pre_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
 static void spapr_phb_plug(HotplugHandler *hotplug_dev, DeviceState *dev=
,
                            Error **errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
-    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
-    sPAPRDRConnector *drc;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
+    SpaprDrc *drc;
     bool hotplugged =3D spapr_drc_hotplugged(dev);
     Error *local_err =3D NULL;
=20
@@ -3978,8 +3978,8 @@ static void spapr_phb_unplug(HotplugHandler *hotplu=
g_dev, DeviceState *dev)
 static void spapr_phb_unplug_request(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
-    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
-    sPAPRDRConnector *drc;
+    SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(dev);
+    SpaprDrc *drc;
=20
     drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PHB, sphb->index);
     assert(drc);
@@ -4017,9 +4017,9 @@ static void spapr_machine_device_unplug(HotplugHand=
ler *hotplug_dev,
 static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_=
dev,
                                                 DeviceState *dev, Error =
**errp)
 {
-    sPAPRMachineState *sms =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
+    SpaprMachineState *sms =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc =3D MACHINE_GET_CLASS(sms);
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
=20
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
@@ -4126,7 +4126,7 @@ static const CPUArchIdList *spapr_possible_cpu_arch=
_ids(MachineState *machine)
     return machine->possible_cpus;
 }
=20
-static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index=
,
+static void spapr_phb_placement(SpaprMachineState *spapr, uint32_t index=
,
                                 uint64_t *buid, hwaddr *pio,
                                 hwaddr *mmio32, hwaddr *mmio64,
                                 unsigned n_dma, uint32_t *liobns, Error =
**errp)
@@ -4178,14 +4178,14 @@ static void spapr_phb_placement(sPAPRMachineState=
 *spapr, uint32_t index,
=20
 static ICSState *spapr_ics_get(XICSFabric *dev, int irq)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(dev);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(dev);
=20
     return ics_valid_irq(spapr->ics, irq) ? spapr->ics : NULL;
 }
=20
 static void spapr_ics_resend(XICSFabric *dev)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(dev);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(dev);
=20
     ics_resend(spapr->ics);
 }
@@ -4200,7 +4200,7 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int =
vcpu_id)
 static void spapr_pic_print_info(InterruptStatsProvider *obj,
                                  Monitor *mon)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
=20
     spapr->irq->print_info(spapr, mon);
 }
@@ -4212,7 +4212,7 @@ int spapr_get_vcpu_id(PowerPCCPU *cpu)
=20
 void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
     int vcpu_id;
=20
     vcpu_id =3D spapr_vcpu_id(spapr, cpu_index);
@@ -4246,7 +4246,7 @@ PowerPCCPU *spapr_find_cpu(int vcpu_id)
 static void spapr_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(oc);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(oc);
     FWPathProviderClass *fwc =3D FW_PATH_PROVIDER_CLASS(oc);
     NMIClass *nc =3D NMI_CLASS(oc);
     HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
@@ -4327,10 +4327,10 @@ static const TypeInfo spapr_machine_info =3D {
     .name          =3D TYPE_SPAPR_MACHINE,
     .parent        =3D TYPE_MACHINE,
     .abstract      =3D true,
-    .instance_size =3D sizeof(sPAPRMachineState),
+    .instance_size =3D sizeof(SpaprMachineState),
     .instance_init =3D spapr_instance_init,
     .instance_finalize =3D spapr_machine_finalizefn,
-    .class_size    =3D sizeof(sPAPRMachineClass),
+    .class_size    =3D sizeof(SpaprMachineClass),
     .class_init    =3D spapr_machine_class_init,
     .interfaces =3D (InterfaceInfo[]) {
         { TYPE_FW_PATH_PROVIDER },
@@ -4380,7 +4380,7 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
  */
 static void spapr_machine_3_1_class_options(MachineClass *mc)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
         { TYPE_SPAPR_MACHINE, "host-model", "passthrough" },
         { TYPE_SPAPR_MACHINE, "host-serial", "passthrough" },
@@ -4407,7 +4407,7 @@ DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
=20
 static void spapr_machine_3_0_class_options(MachineClass *mc)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
=20
     spapr_machine_3_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len)=
;
@@ -4423,7 +4423,7 @@ DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
  */
 static void spapr_machine_2_12_class_options(MachineClass *mc)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
         { TYPE_POWERPC_CPU, "pre-3.0-migration", "on" },
         { TYPE_SPAPR_CPU_CORE, "pre-3.0-migration", "on" },
@@ -4445,7 +4445,7 @@ DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
=20
 static void spapr_machine_2_12_sxxm_class_options(MachineClass *mc)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
=20
     spapr_machine_2_12_class_options(mc);
     smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_WORKAROUND;
@@ -4461,7 +4461,7 @@ DEFINE_SPAPR_MACHINE(2_12_sxxm, "2.12-sxxm", false)=
;
=20
 static void spapr_machine_2_11_class_options(MachineClass *mc)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
=20
     spapr_machine_2_12_class_options(mc);
     smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_ON;
@@ -4488,7 +4488,7 @@ DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
=20
 static void spapr_machine_2_9_class_options(MachineClass *mc)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
         { TYPE_POWERPC_CPU, "pre-2.10-migration", "on" },
     };
@@ -4525,7 +4525,7 @@ DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
  * pseries-2.7
  */
=20
-static void phb_placement_2_7(sPAPRMachineState *spapr, uint32_t index,
+static void phb_placement_2_7(SpaprMachineState *spapr, uint32_t index,
                               uint64_t *buid, hwaddr *pio,
                               hwaddr *mmio32, hwaddr *mmio64,
                               unsigned n_dma, uint32_t *liobns, Error **=
errp)
@@ -4576,7 +4576,7 @@ static void phb_placement_2_7(sPAPRMachineState *sp=
apr, uint32_t index,
=20
 static void spapr_machine_2_7_class_options(MachineClass *mc)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
         { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem_win_size", "0xf80000000", },
         { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem64_win_size", "0", },
@@ -4618,7 +4618,7 @@ DEFINE_SPAPR_MACHINE(2_6, "2.6", false);
=20
 static void spapr_machine_2_5_class_options(MachineClass *mc)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
         { "spapr-vlan", "use-rx-buffer-pools", "off" },
     };
@@ -4637,7 +4637,7 @@ DEFINE_SPAPR_MACHINE(2_5, "2.5", false);
=20
 static void spapr_machine_2_4_class_options(MachineClass *mc)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
=20
     spapr_machine_2_5_class_options(mc);
     smc->dr_lmb_enabled =3D false;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index b68d767d63..3278c09b0f 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -34,7 +34,7 @@
=20
 #include "hw/ppc/spapr.h"
=20
-typedef struct sPAPRCapPossible {
+typedef struct SpaprCapPossible {
     int num;            /* size of vals array below */
     const char *help;   /* help text for vals */
     /*
@@ -46,9 +46,9 @@ typedef struct sPAPRCapPossible {
      *   point is observed
      */
     const char *vals[];
-} sPAPRCapPossible;
+} SpaprCapPossible;
=20
-typedef struct sPAPRCapabilityInfo {
+typedef struct SpaprCapabilityInfo {
     const char *name;
     const char *description;
     int index;
@@ -58,18 +58,18 @@ typedef struct sPAPRCapabilityInfo {
     ObjectPropertyAccessor *set;
     const char *type;
     /* Possible values if this is a custom string type */
-    sPAPRCapPossible *possible;
+    SpaprCapPossible *possible;
     /* Make sure the virtual hardware can support this capability */
-    void (*apply)(sPAPRMachineState *spapr, uint8_t val, Error **errp);
-    void (*cpu_apply)(sPAPRMachineState *spapr, PowerPCCPU *cpu,
+    void (*apply)(SpaprMachineState *spapr, uint8_t val, Error **errp);
+    void (*cpu_apply)(SpaprMachineState *spapr, PowerPCCPU *cpu,
                       uint8_t val, Error **errp);
-} sPAPRCapabilityInfo;
+} SpaprCapabilityInfo;
=20
 static void spapr_cap_get_bool(Object *obj, Visitor *v, const char *name=
,
                                void *opaque, Error **errp)
 {
-    sPAPRCapabilityInfo *cap =3D opaque;
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprCapabilityInfo *cap =3D opaque;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
     bool value =3D spapr_get_cap(spapr, cap->index) =3D=3D SPAPR_CAP_ON;
=20
     visit_type_bool(v, name, &value, errp);
@@ -78,8 +78,8 @@ static void spapr_cap_get_bool(Object *obj, Visitor *v,=
 const char *name,
 static void spapr_cap_set_bool(Object *obj, Visitor *v, const char *name=
,
                                void *opaque, Error **errp)
 {
-    sPAPRCapabilityInfo *cap =3D opaque;
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprCapabilityInfo *cap =3D opaque;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
     bool value;
     Error *local_err =3D NULL;
=20
@@ -97,8 +97,8 @@ static void spapr_cap_set_bool(Object *obj, Visitor *v,=
 const char *name,
 static void  spapr_cap_get_string(Object *obj, Visitor *v, const char *n=
ame,
                                   void *opaque, Error **errp)
 {
-    sPAPRCapabilityInfo *cap =3D opaque;
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprCapabilityInfo *cap =3D opaque;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
     char *val =3D NULL;
     uint8_t value =3D spapr_get_cap(spapr, cap->index);
=20
@@ -116,8 +116,8 @@ static void  spapr_cap_get_string(Object *obj, Visito=
r *v, const char *name,
 static void spapr_cap_set_string(Object *obj, Visitor *v, const char *na=
me,
                                  void *opaque, Error **errp)
 {
-    sPAPRCapabilityInfo *cap =3D opaque;
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprCapabilityInfo *cap =3D opaque;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
     Error *local_err =3D NULL;
     uint8_t i;
     char *val;
@@ -149,8 +149,8 @@ out:
 static void spapr_cap_get_pagesize(Object *obj, Visitor *v, const char *=
name,
                                    void *opaque, Error **errp)
 {
-    sPAPRCapabilityInfo *cap =3D opaque;
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprCapabilityInfo *cap =3D opaque;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
     uint8_t val =3D spapr_get_cap(spapr, cap->index);
     uint64_t pagesize =3D (1ULL << val);
=20
@@ -160,8 +160,8 @@ static void spapr_cap_get_pagesize(Object *obj, Visit=
or *v, const char *name,
 static void spapr_cap_set_pagesize(Object *obj, Visitor *v, const char *=
name,
                                    void *opaque, Error **errp)
 {
-    sPAPRCapabilityInfo *cap =3D opaque;
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
+    SpaprCapabilityInfo *cap =3D opaque;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
     uint64_t pagesize;
     uint8_t val;
     Error *local_err =3D NULL;
@@ -182,7 +182,7 @@ static void spapr_cap_set_pagesize(Object *obj, Visit=
or *v, const char *name,
     spapr->eff.caps[cap->index] =3D val;
 }
=20
-static void cap_htm_apply(sPAPRMachineState *spapr, uint8_t val, Error *=
*errp)
+static void cap_htm_apply(SpaprMachineState *spapr, uint8_t val, Error *=
*errp)
 {
     if (!val) {
         /* TODO: We don't support disabling htm yet */
@@ -198,7 +198,7 @@ static void cap_htm_apply(sPAPRMachineState *spapr, u=
int8_t val, Error **errp)
     }
 }
=20
-static void cap_vsx_apply(sPAPRMachineState *spapr, uint8_t val, Error *=
*errp)
+static void cap_vsx_apply(SpaprMachineState *spapr, uint8_t val, Error *=
*errp)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
     CPUPPCState *env =3D &cpu->env;
@@ -215,7 +215,7 @@ static void cap_vsx_apply(sPAPRMachineState *spapr, u=
int8_t val, Error **errp)
     }
 }
=20
-static void cap_dfp_apply(sPAPRMachineState *spapr, uint8_t val, Error *=
*errp)
+static void cap_dfp_apply(SpaprMachineState *spapr, uint8_t val, Error *=
*errp)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
     CPUPPCState *env =3D &cpu->env;
@@ -229,14 +229,14 @@ static void cap_dfp_apply(sPAPRMachineState *spapr,=
 uint8_t val, Error **errp)
     }
 }
=20
-sPAPRCapPossible cap_cfpc_possible =3D {
+SpaprCapPossible cap_cfpc_possible =3D {
     .num =3D 3,
     .vals =3D {"broken", "workaround", "fixed"},
     .help =3D "broken - no protection, workaround - workaround available=
,"
             " fixed - fixed in hardware",
 };
=20
-static void cap_safe_cache_apply(sPAPRMachineState *spapr, uint8_t val,
+static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
                                  Error **errp)
 {
     Error *local_err =3D NULL;
@@ -257,14 +257,14 @@ static void cap_safe_cache_apply(sPAPRMachineState =
*spapr, uint8_t val,
         warn_report_err(local_err);
 }
=20
-sPAPRCapPossible cap_sbbc_possible =3D {
+SpaprCapPossible cap_sbbc_possible =3D {
     .num =3D 3,
     .vals =3D {"broken", "workaround", "fixed"},
     .help =3D "broken - no protection, workaround - workaround available=
,"
             " fixed - fixed in hardware",
 };
=20
-static void cap_safe_bounds_check_apply(sPAPRMachineState *spapr, uint8_=
t val,
+static void cap_safe_bounds_check_apply(SpaprMachineState *spapr, uint8_=
t val,
                                         Error **errp)
 {
     Error *local_err =3D NULL;
@@ -285,7 +285,7 @@ static void cap_safe_bounds_check_apply(sPAPRMachineS=
tate *spapr, uint8_t val,
         warn_report_err(local_err);
 }
=20
-sPAPRCapPossible cap_ibs_possible =3D {
+SpaprCapPossible cap_ibs_possible =3D {
     .num =3D 5,
     /* Note workaround only maintained for compatibility */
     .vals =3D {"broken", "workaround", "fixed-ibs", "fixed-ccd", "fixed-=
na"},
@@ -295,7 +295,7 @@ sPAPRCapPossible cap_ibs_possible =3D {
             " fixed-na - fixed in hardware (no longer applicable)",
 };
=20
-static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
+static void cap_safe_indirect_branch_apply(SpaprMachineState *spapr,
                                            uint8_t val, Error **errp)
 {
     Error *local_err =3D NULL;
@@ -318,7 +318,7 @@ static void cap_safe_indirect_branch_apply(sPAPRMachi=
neState *spapr,
=20
 #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
=20
-void spapr_check_pagesize(sPAPRMachineState *spapr, hwaddr pagesize,
+void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
                           Error **errp)
 {
     hwaddr maxpagesize =3D (1ULL << spapr->eff.caps[SPAPR_CAP_HPT_MAXPAG=
ESIZE]);
@@ -335,7 +335,7 @@ void spapr_check_pagesize(sPAPRMachineState *spapr, h=
waddr pagesize,
     }
 }
=20
-static void cap_hpt_maxpagesize_apply(sPAPRMachineState *spapr,
+static void cap_hpt_maxpagesize_apply(SpaprMachineState *spapr,
                                       uint8_t val, Error **errp)
 {
     if (val < 12) {
@@ -372,7 +372,7 @@ static bool spapr_pagesize_cb(void *opaque, uint32_t =
seg_pshift,
     return true;
 }
=20
-static void cap_hpt_maxpagesize_cpu_apply(sPAPRMachineState *spapr,
+static void cap_hpt_maxpagesize_cpu_apply(SpaprMachineState *spapr,
                                           PowerPCCPU *cpu,
                                           uint8_t val, Error **errp)
 {
@@ -381,7 +381,7 @@ static void cap_hpt_maxpagesize_cpu_apply(sPAPRMachin=
eState *spapr,
     ppc_hash64_filter_pagesizes(cpu, spapr_pagesize_cb, &maxshift);
 }
=20
-static void cap_nested_kvm_hv_apply(sPAPRMachineState *spapr,
+static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
                                     uint8_t val, Error **errp)
 {
     if (!val) {
@@ -403,7 +403,7 @@ static void cap_nested_kvm_hv_apply(sPAPRMachineState=
 *spapr,
     }
 }
=20
-static void cap_large_decr_apply(sPAPRMachineState *spapr,
+static void cap_large_decr_apply(SpaprMachineState *spapr,
                                  uint8_t val, Error **errp)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
@@ -432,7 +432,7 @@ static void cap_large_decr_apply(sPAPRMachineState *s=
papr,
     }
 }
=20
-static void cap_large_decr_cpu_apply(sPAPRMachineState *spapr,
+static void cap_large_decr_cpu_apply(SpaprMachineState *spapr,
                                      PowerPCCPU *cpu,
                                      uint8_t val, Error **errp)
 {
@@ -451,7 +451,7 @@ static void cap_large_decr_cpu_apply(sPAPRMachineStat=
e *spapr,
     ppc_store_lpcr(cpu, lpcr);
 }
=20
-static void cap_ccf_assist_apply(sPAPRMachineState *spapr, uint8_t val,
+static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
                                  Error **errp)
 {
     uint8_t kvm_val =3D kvmppc_get_cap_count_cache_flush_assist();
@@ -466,7 +466,7 @@ static void cap_ccf_assist_apply(sPAPRMachineState *s=
papr, uint8_t val,
     }
 }
=20
-sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
+SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
     [SPAPR_CAP_HTM] =3D {
         .name =3D "htm",
         .description =3D "Allow Hardware Transactional Memory (HTM)",
@@ -566,11 +566,11 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
     },
 };
=20
-static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
+static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
                                                const char *cputype)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
-    sPAPRCapabilities caps;
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    SpaprCapabilities caps;
=20
     caps =3D smc->default_caps;
=20
@@ -615,7 +615,7 @@ static sPAPRCapabilities default_caps_with_cpu(sPAPRM=
achineState *spapr,
=20
 int spapr_caps_pre_load(void *opaque)
 {
-    sPAPRMachineState *spapr =3D opaque;
+    SpaprMachineState *spapr =3D opaque;
=20
     /* Set to default so we can tell if this came in with the migration =
*/
     spapr->mig =3D spapr->def;
@@ -624,7 +624,7 @@ int spapr_caps_pre_load(void *opaque)
=20
 int spapr_caps_pre_save(void *opaque)
 {
-    sPAPRMachineState *spapr =3D opaque;
+    SpaprMachineState *spapr =3D opaque;
=20
     spapr->mig =3D spapr->eff;
     return 0;
@@ -634,12 +634,12 @@ int spapr_caps_pre_save(void *opaque)
  * caps specific one.  Otherwise it wouldn't be called when the source
  * caps are all defaults, which could still conflict with overridden
  * caps on the destination */
-int spapr_caps_post_migration(sPAPRMachineState *spapr)
+int spapr_caps_post_migration(SpaprMachineState *spapr)
 {
     int i;
     bool ok =3D true;
-    sPAPRCapabilities dstcaps =3D spapr->eff;
-    sPAPRCapabilities srccaps;
+    SpaprCapabilities dstcaps =3D spapr->eff;
+    SpaprCapabilities srccaps;
=20
     srccaps =3D default_caps_with_cpu(spapr, MACHINE(spapr)->cpu_type);
     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
@@ -650,7 +650,7 @@ int spapr_caps_post_migration(sPAPRMachineState *spap=
r)
     }
=20
     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
-        sPAPRCapabilityInfo *info =3D &capability_table[i];
+        SpaprCapabilityInfo *info =3D &capability_table[i];
=20
         if (srccaps.caps[i] > dstcaps.caps[i]) {
             error_report("cap-%s higher level (%d) in incoming stream th=
an on destination (%d)",
@@ -671,7 +671,7 @@ int spapr_caps_post_migration(sPAPRMachineState *spap=
r)
 #define SPAPR_CAP_MIG_STATE(sname, cap)                 \
 static bool spapr_cap_##sname##_needed(void *opaque)    \
 {                                                       \
-    sPAPRMachineState *spapr =3D opaque;                  \
+    SpaprMachineState *spapr =3D opaque;                  \
                                                         \
     return spapr->cmd_line_caps[cap] &&                 \
            (spapr->eff.caps[cap] !=3D                     \
@@ -685,7 +685,7 @@ const VMStateDescription vmstate_spapr_cap_##sname =3D=
 {  \
     .needed =3D spapr_cap_##sname##_needed,               \
     .fields =3D (VMStateField[]) {                        \
         VMSTATE_UINT8(mig.caps[cap],                    \
-                      sPAPRMachineState),               \
+                      SpaprMachineState),               \
         VMSTATE_END_OF_LIST()                           \
     },                                                  \
 }
@@ -700,9 +700,9 @@ SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_K=
VM_HV);
 SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
 SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
=20
-void spapr_caps_init(sPAPRMachineState *spapr)
+void spapr_caps_init(SpaprMachineState *spapr)
 {
-    sPAPRCapabilities default_caps;
+    SpaprCapabilities default_caps;
     int i;
=20
     /* Compute the actual set of caps we should run with */
@@ -718,12 +718,12 @@ void spapr_caps_init(sPAPRMachineState *spapr)
     }
 }
=20
-void spapr_caps_apply(sPAPRMachineState *spapr)
+void spapr_caps_apply(SpaprMachineState *spapr)
 {
     int i;
=20
     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
-        sPAPRCapabilityInfo *info =3D &capability_table[i];
+        SpaprCapabilityInfo *info =3D &capability_table[i];
=20
         /*
          * If the apply function can't set the desired level and thinks =
it's
@@ -733,12 +733,12 @@ void spapr_caps_apply(sPAPRMachineState *spapr)
     }
 }
=20
-void spapr_caps_cpu_apply(sPAPRMachineState *spapr, PowerPCCPU *cpu)
+void spapr_caps_cpu_apply(SpaprMachineState *spapr, PowerPCCPU *cpu)
 {
     int i;
=20
     for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
-        sPAPRCapabilityInfo *info =3D &capability_table[i];
+        SpaprCapabilityInfo *info =3D &capability_table[i];
=20
         /*
          * If the apply function can't set the desired level and thinks =
it's
@@ -750,14 +750,14 @@ void spapr_caps_cpu_apply(sPAPRMachineState *spapr,=
 PowerPCCPU *cpu)
     }
 }
=20
-void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp)
+void spapr_caps_add_properties(SpaprMachineClass *smc, Error **errp)
 {
     Error *local_err =3D NULL;
     ObjectClass *klass =3D OBJECT_CLASS(smc);
     int i;
=20
     for (i =3D 0; i < ARRAY_SIZE(capability_table); i++) {
-        sPAPRCapabilityInfo *cap =3D &capability_table[i];
+        SpaprCapabilityInfo *cap =3D &capability_table[i];
         const char *name =3D g_strdup_printf("cap-%s", cap->name);
         char *desc;
=20
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ef6cbb9c29..f04e06cdf6 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -28,7 +28,7 @@ static void spapr_cpu_reset(void *opaque)
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
-    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
     target_ulong lpcr;
=20
     cpu_reset(cs);
@@ -116,7 +116,7 @@ const char *spapr_get_cpu_core_type(const char *cpu_t=
ype)
=20
 static bool slb_shadow_needed(void *opaque)
 {
-    sPAPRCPUState *spapr_cpu =3D opaque;
+    SpaprCpuState *spapr_cpu =3D opaque;
=20
     return spapr_cpu->slb_shadow_addr !=3D 0;
 }
@@ -127,15 +127,15 @@ static const VMStateDescription vmstate_spapr_cpu_s=
lb_shadow =3D {
     .minimum_version_id =3D 1,
     .needed =3D slb_shadow_needed,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT64(slb_shadow_addr, sPAPRCPUState),
-        VMSTATE_UINT64(slb_shadow_size, sPAPRCPUState),
+        VMSTATE_UINT64(slb_shadow_addr, SpaprCpuState),
+        VMSTATE_UINT64(slb_shadow_size, SpaprCpuState),
         VMSTATE_END_OF_LIST()
     }
 };
=20
 static bool dtl_needed(void *opaque)
 {
-    sPAPRCPUState *spapr_cpu =3D opaque;
+    SpaprCpuState *spapr_cpu =3D opaque;
=20
     return spapr_cpu->dtl_addr !=3D 0;
 }
@@ -146,15 +146,15 @@ static const VMStateDescription vmstate_spapr_cpu_d=
tl =3D {
     .minimum_version_id =3D 1,
     .needed =3D dtl_needed,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT64(dtl_addr, sPAPRCPUState),
-        VMSTATE_UINT64(dtl_size, sPAPRCPUState),
+        VMSTATE_UINT64(dtl_addr, SpaprCpuState),
+        VMSTATE_UINT64(dtl_size, SpaprCpuState),
         VMSTATE_END_OF_LIST()
     }
 };
=20
 static bool vpa_needed(void *opaque)
 {
-    sPAPRCPUState *spapr_cpu =3D opaque;
+    SpaprCpuState *spapr_cpu =3D opaque;
=20
     return spapr_cpu->vpa_addr !=3D 0;
 }
@@ -165,7 +165,7 @@ static const VMStateDescription vmstate_spapr_cpu_vpa=
 =3D {
     .minimum_version_id =3D 1,
     .needed =3D vpa_needed,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT64(vpa_addr, sPAPRCPUState),
+        VMSTATE_UINT64(vpa_addr, SpaprCpuState),
         VMSTATE_END_OF_LIST()
     },
     .subsections =3D (const VMStateDescription * []) {
@@ -188,7 +188,7 @@ static const VMStateDescription vmstate_spapr_cpu_sta=
te =3D {
     }
 };
=20
-static void spapr_unrealize_vcpu(PowerPCCPU *cpu, sPAPRCPUCore *sc)
+static void spapr_unrealize_vcpu(PowerPCCPU *cpu, SpaprCpuCore *sc)
 {
     if (!sc->pre_3_0_migration) {
         vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machine_=
data);
@@ -206,7 +206,7 @@ static void spapr_unrealize_vcpu(PowerPCCPU *cpu, sPA=
PRCPUCore *sc)
=20
 static void spapr_cpu_core_unrealize(DeviceState *dev, Error **errp)
 {
-    sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
+    SpaprCpuCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc =3D CPU_CORE(dev);
     int i;
=20
@@ -216,8 +216,8 @@ static void spapr_cpu_core_unrealize(DeviceState *dev=
, Error **errp)
     g_free(sc->threads);
 }
=20
-static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr=
,
-                               sPAPRCPUCore *sc, Error **errp)
+static void spapr_realize_vcpu(PowerPCCPU *cpu, SpaprMachineState *spapr=
,
+                               SpaprCpuCore *sc, Error **errp)
 {
     CPUPPCState *env =3D &cpu->env;
     CPUState *cs =3D CPU(cpu);
@@ -256,9 +256,9 @@ error:
     error_propagate(errp, local_err);
 }
=20
-static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error **er=
rp)
+static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **er=
rp)
 {
-    sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(sc);
+    SpaprCpuCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(sc);
     CPUCore *cc =3D CPU_CORE(sc);
     Object *obj;
     char *id;
@@ -285,7 +285,7 @@ static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc=
, int i, Error **errp)
         goto err;
     }
=20
-    cpu->machine_data =3D g_new0(sPAPRCPUState, 1);
+    cpu->machine_data =3D g_new0(SpaprCpuState, 1);
=20
     object_unref(obj);
     return cpu;
@@ -296,9 +296,9 @@ err:
     return NULL;
 }
=20
-static void spapr_delete_vcpu(PowerPCCPU *cpu, sPAPRCPUCore *sc)
+static void spapr_delete_vcpu(PowerPCCPU *cpu, SpaprCpuCore *sc)
 {
-    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
=20
     cpu->machine_data =3D NULL;
     g_free(spapr_cpu);
@@ -310,10 +310,10 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
     /* We don't use SPAPR_MACHINE() in order to exit gracefully if the u=
ser
      * tries to add a sPAPR CPU core to a non-pseries machine.
      */
-    sPAPRMachineState *spapr =3D
-        (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
+    SpaprMachineState *spapr =3D
+        (SpaprMachineState *) object_dynamic_cast(qdev_get_machine(),
                                                   TYPE_SPAPR_MACHINE);
-    sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
+    SpaprCpuCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc =3D CPU_CORE(OBJECT(dev));
     Error *local_err =3D NULL;
     int i, j;
@@ -352,8 +352,8 @@ err:
 }
=20
 static Property spapr_cpu_core_properties[] =3D {
-    DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NUMA_N=
ODE_ID),
-    DEFINE_PROP_BOOL("pre-3.0-migration", sPAPRCPUCore, pre_3_0_migratio=
n,
+    DEFINE_PROP_INT32("node-id", SpaprCpuCore, node_id, CPU_UNSET_NUMA_N=
ODE_ID),
+    DEFINE_PROP_BOOL("pre-3.0-migration", SpaprCpuCore, pre_3_0_migratio=
n,
                      false),
     DEFINE_PROP_END_OF_LIST()
 };
@@ -361,7 +361,7 @@ static Property spapr_cpu_core_properties[] =3D {
 static void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
-    sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_CLASS(oc);
+    SpaprCpuCoreClass *scc =3D SPAPR_CPU_CORE_CLASS(oc);
=20
     dc->realize =3D spapr_cpu_core_realize;
     dc->unrealize =3D spapr_cpu_core_unrealize;
@@ -382,8 +382,8 @@ static const TypeInfo spapr_cpu_core_type_infos[] =3D=
 {
         .name =3D TYPE_SPAPR_CPU_CORE,
         .parent =3D TYPE_CPU_CORE,
         .abstract =3D true,
-        .instance_size =3D sizeof(sPAPRCPUCore),
-        .class_size =3D sizeof(sPAPRCPUCoreClass),
+        .instance_size =3D sizeof(SpaprCpuCore),
+        .class_size =3D sizeof(SpaprCpuCoreClass),
     },
     DEFINE_SPAPR_CPU_CORE_TYPE("970_v2.2"),
     DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.0"),
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 2943cf47d4..597f236b9c 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -29,16 +29,16 @@
 #define DRC_INDEX_TYPE_SHIFT 28
 #define DRC_INDEX_ID_MASK ((1ULL << DRC_INDEX_TYPE_SHIFT) - 1)
=20
-sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc)
+SpaprDrcType spapr_drc_type(SpaprDrc *drc)
 {
-    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
=20
     return 1 << drck->typeshift;
 }
=20
-uint32_t spapr_drc_index(sPAPRDRConnector *drc)
+uint32_t spapr_drc_index(SpaprDrc *drc)
 {
-    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
=20
     /* no set format for a drc index: it only needs to be globally
      * unique. this is how we encode the DRC type on bare-metal
@@ -48,7 +48,7 @@ uint32_t spapr_drc_index(sPAPRDRConnector *drc)
         | (drc->id & DRC_INDEX_ID_MASK);
 }
=20
-static uint32_t drc_isolate_physical(sPAPRDRConnector *drc)
+static uint32_t drc_isolate_physical(SpaprDrc *drc)
 {
     switch (drc->state) {
     case SPAPR_DRC_STATE_PHYSICAL_POWERON:
@@ -72,7 +72,7 @@ static uint32_t drc_isolate_physical(sPAPRDRConnector *=
drc)
     return RTAS_OUT_SUCCESS;
 }
=20
-static uint32_t drc_unisolate_physical(sPAPRDRConnector *drc)
+static uint32_t drc_unisolate_physical(SpaprDrc *drc)
 {
     switch (drc->state) {
     case SPAPR_DRC_STATE_PHYSICAL_UNISOLATE:
@@ -99,7 +99,7 @@ static uint32_t drc_unisolate_physical(sPAPRDRConnector=
 *drc)
     return RTAS_OUT_SUCCESS;
 }
=20
-static uint32_t drc_isolate_logical(sPAPRDRConnector *drc)
+static uint32_t drc_isolate_logical(SpaprDrc *drc)
 {
     switch (drc->state) {
     case SPAPR_DRC_STATE_LOGICAL_AVAILABLE:
@@ -146,7 +146,7 @@ static uint32_t drc_isolate_logical(sPAPRDRConnector =
*drc)
     return RTAS_OUT_SUCCESS;
 }
=20
-static uint32_t drc_unisolate_logical(sPAPRDRConnector *drc)
+static uint32_t drc_unisolate_logical(SpaprDrc *drc)
 {
     switch (drc->state) {
     case SPAPR_DRC_STATE_LOGICAL_UNISOLATE:
@@ -170,7 +170,7 @@ static uint32_t drc_unisolate_logical(sPAPRDRConnecto=
r *drc)
     return RTAS_OUT_SUCCESS;
 }
=20
-static uint32_t drc_set_usable(sPAPRDRConnector *drc)
+static uint32_t drc_set_usable(SpaprDrc *drc)
 {
     switch (drc->state) {
     case SPAPR_DRC_STATE_LOGICAL_AVAILABLE:
@@ -202,7 +202,7 @@ static uint32_t drc_set_usable(sPAPRDRConnector *drc)
     return RTAS_OUT_SUCCESS;
 }
=20
-static uint32_t drc_set_unusable(sPAPRDRConnector *drc)
+static uint32_t drc_set_unusable(SpaprDrc *drc)
 {
     switch (drc->state) {
     case SPAPR_DRC_STATE_LOGICAL_UNUSABLE:
@@ -226,9 +226,9 @@ static uint32_t drc_set_unusable(sPAPRDRConnector *dr=
c)
     return RTAS_OUT_SUCCESS;
 }
=20
-static const char *spapr_drc_name(sPAPRDRConnector *drc)
+static const char *spapr_drc_name(SpaprDrc *drc)
 {
-    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
=20
     /* human-readable name for a DRC to encode into the DT
      * description. this is mainly only used within a guest in place
@@ -261,7 +261,7 @@ static const char *spapr_drc_name(sPAPRDRConnector *d=
rc)
  * based on the current allocation/indicator/power states
  * for the DR connector.
  */
-static sPAPRDREntitySense physical_entity_sense(sPAPRDRConnector *drc)
+static SpaprDREntitySense physical_entity_sense(SpaprDrc *drc)
 {
     /* this assumes all PCI devices are assigned to a 'live insertion'
      * power domain, where QEMU manages power state automatically as
@@ -272,7 +272,7 @@ static sPAPRDREntitySense physical_entity_sense(sPAPR=
DRConnector *drc)
         : SPAPR_DR_ENTITY_SENSE_EMPTY;
 }
=20
-static sPAPRDREntitySense logical_entity_sense(sPAPRDRConnector *drc)
+static SpaprDREntitySense logical_entity_sense(SpaprDrc *drc)
 {
     switch (drc->state) {
     case SPAPR_DRC_STATE_LOGICAL_UNUSABLE:
@@ -290,7 +290,7 @@ static sPAPRDREntitySense logical_entity_sense(sPAPRD=
RConnector *drc)
 static void prop_get_index(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
-    sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(obj);
+    SpaprDrc *drc =3D SPAPR_DR_CONNECTOR(obj);
     uint32_t value =3D spapr_drc_index(drc);
     visit_type_uint32(v, name, &value, errp);
 }
@@ -298,7 +298,7 @@ static void prop_get_index(Object *obj, Visitor *v, c=
onst char *name,
 static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
-    sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(obj);
+    SpaprDrc *drc =3D SPAPR_DR_CONNECTOR(obj);
     QNull *null =3D NULL;
     Error *err =3D NULL;
     int fdt_offset_next, fdt_offset, fdt_depth;
@@ -374,7 +374,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, con=
st char *name,
     } while (fdt_depth !=3D 0);
 }
=20
-void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, Error **err=
p)
+void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp)
 {
     trace_spapr_drc_attach(spapr_drc_index(drc));
=20
@@ -393,9 +393,9 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceSt=
ate *d, Error **errp)
                              NULL, 0, NULL);
 }
=20
-static void spapr_drc_release(sPAPRDRConnector *drc)
+static void spapr_drc_release(SpaprDrc *drc)
 {
-    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
=20
     drck->release(drc->dev);
=20
@@ -407,9 +407,9 @@ static void spapr_drc_release(sPAPRDRConnector *drc)
     drc->dev =3D NULL;
 }
=20
-void spapr_drc_detach(sPAPRDRConnector *drc)
+void spapr_drc_detach(SpaprDrc *drc)
 {
-    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
=20
     trace_spapr_drc_detach(spapr_drc_index(drc));
=20
@@ -425,9 +425,9 @@ void spapr_drc_detach(sPAPRDRConnector *drc)
     spapr_drc_release(drc);
 }
=20
-void spapr_drc_reset(sPAPRDRConnector *drc)
+void spapr_drc_reset(SpaprDrc *drc)
 {
-    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
=20
     trace_spapr_drc_reset(spapr_drc_index(drc));
=20
@@ -456,8 +456,8 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
=20
 bool spapr_drc_needed(void *opaque)
 {
-    sPAPRDRConnector *drc =3D (sPAPRDRConnector *)opaque;
-    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    SpaprDrc *drc =3D (SpaprDrc *)opaque;
+    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
=20
     /* If no dev is plugged in there is no need to migrate the DRC state=
 */
     if (!drc->dev) {
@@ -477,14 +477,14 @@ static const VMStateDescription vmstate_spapr_drc =3D=
 {
     .minimum_version_id =3D 1,
     .needed =3D spapr_drc_needed,
     .fields  =3D (VMStateField []) {
-        VMSTATE_UINT32(state, sPAPRDRConnector),
+        VMSTATE_UINT32(state, SpaprDrc),
         VMSTATE_END_OF_LIST()
     }
 };
=20
 static void realize(DeviceState *d, Error **errp)
 {
-    sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
+    SpaprDrc *drc =3D SPAPR_DR_CONNECTOR(d);
     Object *root_container;
     gchar *link_name;
     gchar *child_name;
@@ -517,7 +517,7 @@ static void realize(DeviceState *d, Error **errp)
=20
 static void unrealize(DeviceState *d, Error **errp)
 {
-    sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(d);
+    SpaprDrc *drc =3D SPAPR_DR_CONNECTOR(d);
     Object *root_container;
     gchar *name;
=20
@@ -529,10 +529,10 @@ static void unrealize(DeviceState *d, Error **errp)
     g_free(name);
 }
=20
-sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type=
,
+SpaprDrc *spapr_dr_connector_new(Object *owner, const char *type,
                                          uint32_t id)
 {
-    sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(object_new(type));
+    SpaprDrc *drc =3D SPAPR_DR_CONNECTOR(object_new(type));
     char *prop_name;
=20
     drc->id =3D id;
@@ -549,8 +549,8 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *owne=
r, const char *type,
=20
 static void spapr_dr_connector_instance_init(Object *obj)
 {
-    sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(obj);
-    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
+    SpaprDrc *drc =3D SPAPR_DR_CONNECTOR(obj);
+    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
=20
     object_property_add_uint32_ptr(obj, "id", &drc->id, NULL);
     object_property_add(obj, "index", "uint32", prop_get_index,
@@ -574,8 +574,8 @@ static void spapr_dr_connector_class_init(ObjectClass=
 *k, void *data)
=20
 static bool drc_physical_needed(void *opaque)
 {
-    sPAPRDRCPhysical *drcp =3D (sPAPRDRCPhysical *)opaque;
-    sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(drcp);
+    SpaprDrcPhysical *drcp =3D (SpaprDrcPhysical *)opaque;
+    SpaprDrc *drc =3D SPAPR_DR_CONNECTOR(drcp);
=20
     if ((drc->dev && (drcp->dr_indicator =3D=3D SPAPR_DR_INDICATOR_ACTIV=
E))
         || (!drc->dev && (drcp->dr_indicator =3D=3D SPAPR_DR_INDICATOR_I=
NACTIVE))) {
@@ -590,15 +590,15 @@ static const VMStateDescription vmstate_spapr_drc_p=
hysical =3D {
     .minimum_version_id =3D 1,
     .needed =3D drc_physical_needed,
     .fields  =3D (VMStateField []) {
-        VMSTATE_UINT32(dr_indicator, sPAPRDRCPhysical),
+        VMSTATE_UINT32(dr_indicator, SpaprDrcPhysical),
         VMSTATE_END_OF_LIST()
     }
 };
=20
 static void drc_physical_reset(void *opaque)
 {
-    sPAPRDRConnector *drc =3D SPAPR_DR_CONNECTOR(opaque);
-    sPAPRDRCPhysical *drcp =3D SPAPR_DRC_PHYSICAL(drc);
+    SpaprDrc *drc =3D SPAPR_DR_CONNECTOR(opaque);
+    SpaprDrcPhysical *drcp =3D SPAPR_DRC_PHYSICAL(drc);
=20
     if (drc->dev) {
         drcp->dr_indicator =3D SPAPR_DR_INDICATOR_ACTIVE;
@@ -609,7 +609,7 @@ static void drc_physical_reset(void *opaque)
=20
 static void realize_physical(DeviceState *d, Error **errp)
 {
-    sPAPRDRCPhysical *drcp =3D SPAPR_DRC_PHYSICAL(d);
+    SpaprDrcPhysical *drcp =3D SPAPR_DRC_PHYSICAL(d);
     Error *local_err =3D NULL;
=20
     realize(d, &local_err);
@@ -625,7 +625,7 @@ static void realize_physical(DeviceState *d, Error **=
errp)
=20
 static void unrealize_physical(DeviceState *d, Error **errp)
 {
-    sPAPRDRCPhysical *drcp =3D SPAPR_DRC_PHYSICAL(d);
+    SpaprDrcPhysical *drcp =3D SPAPR_DRC_PHYSICAL(d);
     Error *local_err =3D NULL;
=20
     unrealize(d, &local_err);
@@ -641,7 +641,7 @@ static void unrealize_physical(DeviceState *d, Error =
**errp)
 static void spapr_drc_physical_class_init(ObjectClass *k, void *data)
 {
     DeviceClass *dk =3D DEVICE_CLASS(k);
-    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
+    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
=20
     dk->realize =3D realize_physical;
     dk->unrealize =3D unrealize_physical;
@@ -654,7 +654,7 @@ static void spapr_drc_physical_class_init(ObjectClass=
 *k, void *data)
=20
 static void spapr_drc_logical_class_init(ObjectClass *k, void *data)
 {
-    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
+    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
=20
     drck->dr_entity_sense =3D logical_entity_sense;
     drck->isolate =3D drc_isolate_logical;
@@ -665,7 +665,7 @@ static void spapr_drc_logical_class_init(ObjectClass =
*k, void *data)
=20
 static void spapr_drc_cpu_class_init(ObjectClass *k, void *data)
 {
-    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
+    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
=20
     drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_CPU;
     drck->typename =3D "CPU";
@@ -676,7 +676,7 @@ static void spapr_drc_cpu_class_init(ObjectClass *k, =
void *data)
=20
 static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
 {
-    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
+    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
=20
     drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI;
     drck->typename =3D "28";
@@ -687,7 +687,7 @@ static void spapr_drc_pci_class_init(ObjectClass *k, =
void *data)
=20
 static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
 {
-    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
+    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
=20
     drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB;
     drck->typename =3D "MEM";
@@ -698,7 +698,7 @@ static void spapr_drc_lmb_class_init(ObjectClass *k, =
void *data)
=20
 static void spapr_drc_phb_class_init(ObjectClass *k, void *data)
 {
-    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
+    SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_CLASS(k);
=20
     drck->typeshift =3D SPAPR_DR_CONNECTOR_TYPE_SHIFT_PHB;
     drck->typename =3D "PHB";
@@ -710,9 +710,9 @@ static void spapr_drc_phb_class_init(ObjectClass *k, =
void *data)
 static const TypeInfo spapr_dr_connector_info =3D {
     .name          =3D TYPE_SPAPR_DR_CONNECTOR,
     .parent        =3D TYPE_DEVICE,
-    .instance_size =3D sizeof(sPAPRDRConnector),
+    .instance_size =3D sizeof(SpaprDrc),
     .instance_init =3D spapr_dr_connector_instance_init,
-    .class_size    =3D sizeof(sPAPRDRConnectorClass),
+    .class_size    =3D sizeof(SpaprDrcClass),
     .class_init    =3D spapr_dr_connector_class_init,
     .abstract      =3D true,
 };
@@ -720,7 +720,7 @@ static const TypeInfo spapr_dr_connector_info =3D {
 static const TypeInfo spapr_drc_physical_info =3D {
     .name          =3D TYPE_SPAPR_DRC_PHYSICAL,
     .parent        =3D TYPE_SPAPR_DR_CONNECTOR,
-    .instance_size =3D sizeof(sPAPRDRCPhysical),
+    .instance_size =3D sizeof(SpaprDrcPhysical),
     .class_init    =3D spapr_drc_physical_class_init,
     .abstract      =3D true,
 };
@@ -753,13 +753,13 @@ static const TypeInfo spapr_drc_lmb_info =3D {
 static const TypeInfo spapr_drc_phb_info =3D {
     .name          =3D TYPE_SPAPR_DRC_PHB,
     .parent        =3D TYPE_SPAPR_DRC_LOGICAL,
-    .instance_size =3D sizeof(sPAPRDRConnector),
+    .instance_size =3D sizeof(SpaprDrc),
     .class_init    =3D spapr_drc_phb_class_init,
 };
=20
 /* helper functions for external users */
=20
-sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
+SpaprDrc *spapr_drc_by_index(uint32_t index)
 {
     Object *obj;
     gchar *name;
@@ -771,9 +771,9 @@ sPAPRDRConnector *spapr_drc_by_index(uint32_t index)
     return !obj ? NULL : SPAPR_DR_CONNECTOR(obj);
 }
=20
-sPAPRDRConnector *spapr_drc_by_id(const char *type, uint32_t id)
+SpaprDrc *spapr_drc_by_id(const char *type, uint32_t id)
 {
-    sPAPRDRConnectorClass *drck
+    SpaprDrcClass *drck
         =3D SPAPR_DR_CONNECTOR_CLASS(object_class_by_name(type));
=20
     return spapr_drc_by_index(drck->typeshift << DRC_INDEX_TYPE_SHIFT
@@ -787,7 +787,7 @@ sPAPRDRConnector *spapr_drc_by_id(const char *type, u=
int32_t id)
  * @path: path in the DT to generate properties
  * @owner: parent Object/DeviceState for which to generate DRC
  *         descriptions for
- * @drc_type_mask: mask of sPAPRDRConnectorType values corresponding
+ * @drc_type_mask: mask of SpaprDrcType values corresponding
  *   to the types of DRCs to generate entries for
  *
  * generate OF properties to describe DRC topology/indices to guests
@@ -826,8 +826,8 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, =
Object *owner,
     object_property_iter_init(&iter, root_container);
     while ((prop =3D object_property_iter_next(&iter))) {
         Object *obj;
-        sPAPRDRConnector *drc;
-        sPAPRDRConnectorClass *drck;
+        SpaprDrc *drc;
+        SpaprDrcClass *drck;
         uint32_t drc_index, drc_power_domain;
=20
         if (!strstart(prop->type, "link<", NULL)) {
@@ -918,8 +918,8 @@ out:
=20
 static uint32_t rtas_set_isolation_state(uint32_t idx, uint32_t state)
 {
-    sPAPRDRConnector *drc =3D spapr_drc_by_index(idx);
-    sPAPRDRConnectorClass *drck;
+    SpaprDrc *drc =3D spapr_drc_by_index(idx);
+    SpaprDrcClass *drck;
=20
     if (!drc) {
         return RTAS_OUT_NO_SUCH_INDICATOR;
@@ -943,7 +943,7 @@ static uint32_t rtas_set_isolation_state(uint32_t idx=
, uint32_t state)
=20
 static uint32_t rtas_set_allocation_state(uint32_t idx, uint32_t state)
 {
-    sPAPRDRConnector *drc =3D spapr_drc_by_index(idx);
+    SpaprDrc *drc =3D spapr_drc_by_index(idx);
=20
     if (!drc || !object_dynamic_cast(OBJECT(drc), TYPE_SPAPR_DRC_LOGICAL=
)) {
         return RTAS_OUT_NO_SUCH_INDICATOR;
@@ -965,7 +965,7 @@ static uint32_t rtas_set_allocation_state(uint32_t id=
x, uint32_t state)
=20
 static uint32_t rtas_set_dr_indicator(uint32_t idx, uint32_t state)
 {
-    sPAPRDRConnector *drc =3D spapr_drc_by_index(idx);
+    SpaprDrc *drc =3D spapr_drc_by_index(idx);
=20
     if (!drc || !object_dynamic_cast(OBJECT(drc), TYPE_SPAPR_DRC_PHYSICA=
L)) {
         return RTAS_OUT_NO_SUCH_INDICATOR;
@@ -982,7 +982,7 @@ static uint32_t rtas_set_dr_indicator(uint32_t idx, u=
int32_t state)
     return RTAS_OUT_SUCCESS;
 }
=20
-static void rtas_set_indicator(PowerPCCPU *cpu, sPAPRMachineState *spapr=
,
+static void rtas_set_indicator(PowerPCCPU *cpu, SpaprMachineState *spapr=
,
                                uint32_t token,
                                uint32_t nargs, target_ulong args,
                                uint32_t nret, target_ulong rets)
@@ -1017,7 +1017,7 @@ out:
     rtas_st(rets, 0, ret);
 }
=20
-static void rtas_get_sensor_state(PowerPCCPU *cpu, sPAPRMachineState *sp=
apr,
+static void rtas_get_sensor_state(PowerPCCPU *cpu, SpaprMachineState *sp=
apr,
                                   uint32_t token, uint32_t nargs,
                                   target_ulong args, uint32_t nret,
                                   target_ulong rets)
@@ -1025,8 +1025,8 @@ static void rtas_get_sensor_state(PowerPCCPU *cpu, =
sPAPRMachineState *spapr,
     uint32_t sensor_type;
     uint32_t sensor_index;
     uint32_t sensor_state =3D 0;
-    sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
+    SpaprDrc *drc;
+    SpaprDrcClass *drck;
     uint32_t ret =3D RTAS_OUT_SUCCESS;
=20
     if (nargs !=3D 2 || nret !=3D 2) {
@@ -1079,7 +1079,7 @@ static void configure_connector_st(target_ulong add=
r, target_ulong offset,
 }
=20
 static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
-                                         sPAPRMachineState *spapr,
+                                         SpaprMachineState *spapr,
                                          uint32_t token, uint32_t nargs,
                                          target_ulong args, uint32_t nre=
t,
                                          target_ulong rets)
@@ -1087,9 +1087,9 @@ static void rtas_ibm_configure_connector(PowerPCCPU=
 *cpu,
     uint64_t wa_addr;
     uint64_t wa_offset;
     uint32_t drc_index;
-    sPAPRDRConnector *drc;
-    sPAPRDRConnectorClass *drck;
-    sPAPRDRCCResponse resp =3D SPAPR_DR_CC_RESPONSE_CONTINUE;
+    SpaprDrc *drc;
+    SpaprDrcClass *drck;
+    SpaprDRCCResponse resp =3D SPAPR_DR_CC_RESPONSE_CONTINUE;
     int rc;
=20
     if (nargs !=3D 2 || nret !=3D 1) {
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index ab9a1f0063..ae0f093f59 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -229,18 +229,18 @@ static const char * const event_names[EVENT_CLASS_M=
AX] =3D {
     [EVENT_CLASS_IO]                    =3D "ibm,io-events",
 };
=20
-struct sPAPREventSource {
+struct SpaprEventSource {
     int irq;
     uint32_t mask;
     bool enabled;
 };
=20
-static sPAPREventSource *spapr_event_sources_new(void)
+static SpaprEventSource *spapr_event_sources_new(void)
 {
-    return g_new0(sPAPREventSource, EVENT_CLASS_MAX);
+    return g_new0(SpaprEventSource, EVENT_CLASS_MAX);
 }
=20
-static void spapr_event_sources_register(sPAPREventSource *event_sources=
,
+static void spapr_event_sources_register(SpaprEventSource *event_sources=
,
                                         EventClassIndex index, int irq)
 {
     /* we only support 1 irq per event class at the moment */
@@ -251,8 +251,8 @@ static void spapr_event_sources_register(sPAPREventSo=
urce *event_sources,
     event_sources[index].enabled =3D true;
 }
=20
-static const sPAPREventSource *
-spapr_event_sources_get_source(sPAPREventSource *event_sources,
+static const SpaprEventSource *
+spapr_event_sources_get_source(SpaprEventSource *event_sources,
                                EventClassIndex index)
 {
     g_assert(index < EVENT_CLASS_MAX);
@@ -261,11 +261,11 @@ spapr_event_sources_get_source(sPAPREventSource *ev=
ent_sources,
     return &event_sources[index];
 }
=20
-void spapr_dt_events(sPAPRMachineState *spapr, void *fdt)
+void spapr_dt_events(SpaprMachineState *spapr, void *fdt)
 {
     uint32_t irq_ranges[EVENT_CLASS_MAX * 2];
     int i, count =3D 0, event_sources;
-    sPAPREventSource *events =3D spapr->event_sources;
+    SpaprEventSource *events =3D spapr->event_sources;
=20
     g_assert(events);
=20
@@ -274,7 +274,7 @@ void spapr_dt_events(sPAPRMachineState *spapr, void *=
fdt)
     for (i =3D 0, count =3D 0; i < EVENT_CLASS_MAX; i++) {
         int node_offset;
         uint32_t interrupts[2];
-        const sPAPREventSource *source =3D
+        const SpaprEventSource *source =3D
             spapr_event_sources_get_source(events, i);
         const char *source_name =3D event_names[i];
=20
@@ -298,10 +298,10 @@ void spapr_dt_events(sPAPRMachineState *spapr, void=
 *fdt)
                       irq_ranges, count * sizeof(uint32_t))));
 }
=20
-static const sPAPREventSource *
-rtas_event_log_to_source(sPAPRMachineState *spapr, int log_type)
+static const SpaprEventSource *
+rtas_event_log_to_source(SpaprMachineState *spapr, int log_type)
 {
-    const sPAPREventSource *source;
+    const SpaprEventSource *source;
=20
     g_assert(spapr->event_sources);
=20
@@ -325,9 +325,9 @@ rtas_event_log_to_source(sPAPRMachineState *spapr, in=
t log_type)
     return source;
 }
=20
-static int rtas_event_log_to_irq(sPAPRMachineState *spapr, int log_type)
+static int rtas_event_log_to_irq(SpaprMachineState *spapr, int log_type)
 {
-    const sPAPREventSource *source;
+    const SpaprEventSource *source;
=20
     source =3D rtas_event_log_to_source(spapr, log_type);
     g_assert(source);
@@ -336,24 +336,24 @@ static int rtas_event_log_to_irq(sPAPRMachineState =
*spapr, int log_type)
     return source->irq;
 }
=20
-static uint32_t spapr_event_log_entry_type(sPAPREventLogEntry *entry)
+static uint32_t spapr_event_log_entry_type(SpaprEventLogEntry *entry)
 {
     return entry->summary & RTAS_LOG_TYPE_MASK;
 }
=20
-static void rtas_event_log_queue(sPAPRMachineState *spapr,
-                                 sPAPREventLogEntry *entry)
+static void rtas_event_log_queue(SpaprMachineState *spapr,
+                                 SpaprEventLogEntry *entry)
 {
     QTAILQ_INSERT_TAIL(&spapr->pending_events, entry, next);
 }
=20
-static sPAPREventLogEntry *rtas_event_log_dequeue(sPAPRMachineState *spa=
pr,
+static SpaprEventLogEntry *rtas_event_log_dequeue(SpaprMachineState *spa=
pr,
                                                   uint32_t event_mask)
 {
-    sPAPREventLogEntry *entry =3D NULL;
+    SpaprEventLogEntry *entry =3D NULL;
=20
     QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
-        const sPAPREventSource *source =3D
+        const SpaprEventSource *source =3D
             rtas_event_log_to_source(spapr,
                                      spapr_event_log_entry_type(entry));
=20
@@ -371,11 +371,11 @@ static sPAPREventLogEntry *rtas_event_log_dequeue(s=
PAPRMachineState *spapr,
=20
 static bool rtas_event_log_contains(uint32_t event_mask)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
-    sPAPREventLogEntry *entry =3D NULL;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    SpaprEventLogEntry *entry =3D NULL;
=20
     QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
-        const sPAPREventSource *source =3D
+        const SpaprEventSource *source =3D
             rtas_event_log_to_source(spapr,
                                      spapr_event_log_entry_type(entry));
=20
@@ -401,7 +401,7 @@ static void spapr_init_v6hdr(struct rtas_event_log_v6=
 *v6hdr)
 static void spapr_init_maina(struct rtas_event_log_v6_maina *maina,
                              int section_count)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
     struct tm tm;
     int year;
=20
@@ -424,15 +424,15 @@ static void spapr_init_maina(struct rtas_event_log_=
v6_maina *maina,
=20
 static void spapr_powerdown_req(Notifier *n, void *opaque)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
-    sPAPREventLogEntry *entry;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    SpaprEventLogEntry *entry;
     struct rtas_event_log_v6 *v6hdr;
     struct rtas_event_log_v6_maina *maina;
     struct rtas_event_log_v6_mainb *mainb;
     struct rtas_event_log_v6_epow *epow;
     struct epow_extended_log *new_epow;
=20
-    entry =3D g_new(sPAPREventLogEntry, 1);
+    entry =3D g_new(SpaprEventLogEntry, 1);
     new_epow =3D g_malloc0(sizeof(*new_epow));
     entry->extended_log =3D new_epow;
=20
@@ -473,18 +473,18 @@ static void spapr_powerdown_req(Notifier *n, void *=
opaque)
 }
=20
 static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
-                                    sPAPRDRConnectorType drc_type,
+                                    SpaprDrcType drc_type,
                                     union drc_identifier *drc_id)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
-    sPAPREventLogEntry *entry;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    SpaprEventLogEntry *entry;
     struct hp_extended_log *new_hp;
     struct rtas_event_log_v6 *v6hdr;
     struct rtas_event_log_v6_maina *maina;
     struct rtas_event_log_v6_mainb *mainb;
     struct rtas_event_log_v6_hp *hp;
=20
-    entry =3D g_new(sPAPREventLogEntry, 1);
+    entry =3D g_new(SpaprEventLogEntry, 1);
     new_hp =3D g_malloc0(sizeof(struct hp_extended_log));
     entry->extended_log =3D new_hp;
=20
@@ -558,9 +558,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, ui=
nt8_t hp_action,
                    rtas_event_log_to_irq(spapr, RTAS_LOG_TYPE_HOTPLUG)))=
;
 }
=20
-void spapr_hotplug_req_add_by_index(sPAPRDRConnector *drc)
+void spapr_hotplug_req_add_by_index(SpaprDrc *drc)
 {
-    sPAPRDRConnectorType drc_type =3D spapr_drc_type(drc);
+    SpaprDrcType drc_type =3D spapr_drc_type(drc);
     union drc_identifier drc_id;
=20
     drc_id.index =3D spapr_drc_index(drc);
@@ -568,9 +568,9 @@ void spapr_hotplug_req_add_by_index(sPAPRDRConnector =
*drc)
                             RTAS_LOG_V6_HP_ACTION_ADD, drc_type, &drc_id=
);
 }
=20
-void spapr_hotplug_req_remove_by_index(sPAPRDRConnector *drc)
+void spapr_hotplug_req_remove_by_index(SpaprDrc *drc)
 {
-    sPAPRDRConnectorType drc_type =3D spapr_drc_type(drc);
+    SpaprDrcType drc_type =3D spapr_drc_type(drc);
     union drc_identifier drc_id;
=20
     drc_id.index =3D spapr_drc_index(drc);
@@ -578,7 +578,7 @@ void spapr_hotplug_req_remove_by_index(sPAPRDRConnect=
or *drc)
                             RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc=
_id);
 }
=20
-void spapr_hotplug_req_add_by_count(sPAPRDRConnectorType drc_type,
+void spapr_hotplug_req_add_by_count(SpaprDrcType drc_type,
                                        uint32_t count)
 {
     union drc_identifier drc_id;
@@ -588,7 +588,7 @@ void spapr_hotplug_req_add_by_count(sPAPRDRConnectorT=
ype drc_type,
                             RTAS_LOG_V6_HP_ACTION_ADD, drc_type, &drc_id=
);
 }
=20
-void spapr_hotplug_req_remove_by_count(sPAPRDRConnectorType drc_type,
+void spapr_hotplug_req_remove_by_count(SpaprDrcType drc_type,
                                           uint32_t count)
 {
     union drc_identifier drc_id;
@@ -598,7 +598,7 @@ void spapr_hotplug_req_remove_by_count(sPAPRDRConnect=
orType drc_type,
                             RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc=
_id);
 }
=20
-void spapr_hotplug_req_add_by_count_indexed(sPAPRDRConnectorType drc_typ=
e,
+void spapr_hotplug_req_add_by_count_indexed(SpaprDrcType drc_type,
                                             uint32_t count, uint32_t ind=
ex)
 {
     union drc_identifier drc_id;
@@ -609,7 +609,7 @@ void spapr_hotplug_req_add_by_count_indexed(sPAPRDRCo=
nnectorType drc_type,
                             RTAS_LOG_V6_HP_ACTION_ADD, drc_type, &drc_id=
);
 }
=20
-void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_=
type,
+void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
                                                uint32_t count, uint32_t =
index)
 {
     union drc_identifier drc_id;
@@ -620,14 +620,14 @@ void spapr_hotplug_req_remove_by_count_indexed(sPAP=
RDRConnectorType drc_type,
                             RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc=
_id);
 }
=20
-static void check_exception(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
                             uint32_t token, uint32_t nargs,
                             target_ulong args,
                             uint32_t nret, target_ulong rets)
 {
     uint32_t mask, buf, len, event_len;
     uint64_t xinfo;
-    sPAPREventLogEntry *event;
+    SpaprEventLogEntry *event;
     struct rtas_error_log header;
     int i;
=20
@@ -671,7 +671,7 @@ static void check_exception(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
      */
     for (i =3D 0; i < EVENT_CLASS_MAX; i++) {
         if (rtas_event_log_contains(EVENT_CLASS_MASK(i))) {
-            const sPAPREventSource *source =3D
+            const SpaprEventSource *source =3D
                 spapr_event_sources_get_source(spapr->event_sources, i);
=20
             g_assert(source->enabled);
@@ -685,7 +685,7 @@ out_no_events:
     rtas_st(rets, 0, RTAS_OUT_NO_ERRORS_FOUND);
 }
=20
-static void event_scan(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static void event_scan(PowerPCCPU *cpu, SpaprMachineState *spapr,
                        uint32_t token, uint32_t nargs,
                        target_ulong args,
                        uint32_t nret, target_ulong rets)
@@ -697,9 +697,9 @@ static void event_scan(PowerPCCPU *cpu, sPAPRMachineS=
tate *spapr,
     rtas_st(rets, 0, RTAS_OUT_NO_ERRORS_FOUND);
 }
=20
-void spapr_clear_pending_events(sPAPRMachineState *spapr)
+void spapr_clear_pending_events(SpaprMachineState *spapr)
 {
-    sPAPREventLogEntry *entry =3D NULL, *next_entry;
+    SpaprEventLogEntry *entry =3D NULL, *next_entry;
=20
     QTAILQ_FOREACH_SAFE(entry, &spapr->pending_events, next, next_entry)=
 {
         QTAILQ_REMOVE(&spapr->pending_events, entry, next);
@@ -708,7 +708,7 @@ void spapr_clear_pending_events(sPAPRMachineState *sp=
apr)
     }
 }
=20
-void spapr_events_init(sPAPRMachineState *spapr)
+void spapr_events_init(SpaprMachineState *spapr)
 {
     int epow_irq =3D SPAPR_IRQ_EPOW;
=20
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 7016a09386..4486ffd37d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -34,7 +34,7 @@ static inline bool valid_ptex(PowerPCCPU *cpu, target_u=
long ptex)
     return true;
 }
=20
-static bool is_ram_address(sPAPRMachineState *spapr, hwaddr addr)
+static bool is_ram_address(SpaprMachineState *spapr, hwaddr addr)
 {
     MachineState *machine =3D MACHINE(spapr);
     DeviceMemoryState *dms =3D machine->device_memory;
@@ -50,7 +50,7 @@ static bool is_ram_address(sPAPRMachineState *spapr, hw=
addr addr)
     return false;
 }
=20
-static target_ulong h_enter(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_enter(PowerPCCPU *cpu, SpaprMachineState *spapr,
                             target_ulong opcode, target_ulong *args)
 {
     target_ulong flags =3D args[0];
@@ -160,7 +160,7 @@ static RemoveResult remove_hpte(PowerPCCPU *cpu, targ=
et_ulong ptex,
     return REMOVE_SUCCESS;
 }
=20
-static target_ulong h_remove(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_remove(PowerPCCPU *cpu, SpaprMachineState *spapr,
                              target_ulong opcode, target_ulong *args)
 {
     CPUPPCState *env =3D &cpu->env;
@@ -208,7 +208,7 @@ static target_ulong h_remove(PowerPCCPU *cpu, sPAPRMa=
chineState *spapr,
=20
 #define H_BULK_REMOVE_MAX_BATCH        4
=20
-static target_ulong h_bulk_remove(PowerPCCPU *cpu, sPAPRMachineState *sp=
apr,
+static target_ulong h_bulk_remove(PowerPCCPU *cpu, SpaprMachineState *sp=
apr,
                                   target_ulong opcode, target_ulong *arg=
s)
 {
     CPUPPCState *env =3D &cpu->env;
@@ -260,7 +260,7 @@ static target_ulong h_bulk_remove(PowerPCCPU *cpu, sP=
APRMachineState *spapr,
     return rc;
 }
=20
-static target_ulong h_protect(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_protect(PowerPCCPU *cpu, SpaprMachineState *spapr,
                               target_ulong opcode, target_ulong *args)
 {
     CPUPPCState *env =3D &cpu->env;
@@ -299,7 +299,7 @@ static target_ulong h_protect(PowerPCCPU *cpu, sPAPRM=
achineState *spapr,
     return H_SUCCESS;
 }
=20
-static target_ulong h_read(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_read(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
     target_ulong flags =3D args[0];
@@ -328,7 +328,7 @@ static target_ulong h_read(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
     return H_SUCCESS;
 }
=20
-struct sPAPRPendingHPT {
+struct SpaprPendingHpt {
     /* These fields are read-only after initialization */
     int shift;
     QemuThread thread;
@@ -342,7 +342,7 @@ struct sPAPRPendingHPT {
     void *hpt;
 };
=20
-static void free_pending_hpt(sPAPRPendingHPT *pending)
+static void free_pending_hpt(SpaprPendingHpt *pending)
 {
     if (pending->hpt) {
         qemu_vfree(pending->hpt);
@@ -353,7 +353,7 @@ static void free_pending_hpt(sPAPRPendingHPT *pending=
)
=20
 static void *hpt_prepare_thread(void *opaque)
 {
-    sPAPRPendingHPT *pending =3D opaque;
+    SpaprPendingHpt *pending =3D opaque;
     size_t size =3D 1ULL << pending->shift;
=20
     pending->hpt =3D qemu_memalign(size, size);
@@ -379,9 +379,9 @@ static void *hpt_prepare_thread(void *opaque)
 }
=20
 /* Must be called with BQL held */
-static void cancel_hpt_prepare(sPAPRMachineState *spapr)
+static void cancel_hpt_prepare(SpaprMachineState *spapr)
 {
-    sPAPRPendingHPT *pending =3D spapr->pending_hpt;
+    SpaprPendingHpt *pending =3D spapr->pending_hpt;
=20
     /* Let the thread know it's cancelled */
     spapr->pending_hpt =3D NULL;
@@ -438,13 +438,13 @@ static target_ulong resize_hpt_convert_rc(int ret)
 }
=20
 static target_ulong h_resize_hpt_prepare(PowerPCCPU *cpu,
-                                         sPAPRMachineState *spapr,
+                                         SpaprMachineState *spapr,
                                          target_ulong opcode,
                                          target_ulong *args)
 {
     target_ulong flags =3D args[0];
     int shift =3D args[1];
-    sPAPRPendingHPT *pending =3D spapr->pending_hpt;
+    SpaprPendingHpt *pending =3D spapr->pending_hpt;
     uint64_t current_ram_size;
     int rc;
=20
@@ -503,7 +503,7 @@ static target_ulong h_resize_hpt_prepare(PowerPCCPU *=
cpu,
=20
     /* start new prepare */
=20
-    pending =3D g_new0(sPAPRPendingHPT, 1);
+    pending =3D g_new0(SpaprPendingHpt, 1);
     pending->shift =3D shift;
     pending->ret =3D H_HARDWARE;
=20
@@ -672,7 +672,7 @@ static void do_push_sregs_to_kvm_pr(CPUState *cs, run=
_on_cpu_data data)
     }
 }
=20
-static void push_sregs_to_kvm_pr(sPAPRMachineState *spapr)
+static void push_sregs_to_kvm_pr(SpaprMachineState *spapr)
 {
     CPUState *cs;
=20
@@ -691,13 +691,13 @@ static void push_sregs_to_kvm_pr(sPAPRMachineState =
*spapr)
 }
=20
 static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
-                                        sPAPRMachineState *spapr,
+                                        SpaprMachineState *spapr,
                                         target_ulong opcode,
                                         target_ulong *args)
 {
     target_ulong flags =3D args[0];
     target_ulong shift =3D args[1];
-    sPAPRPendingHPT *pending =3D spapr->pending_hpt;
+    SpaprPendingHpt *pending =3D spapr->pending_hpt;
     int rc;
     size_t newsize;
=20
@@ -759,7 +759,7 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *c=
pu,
     return rc;
 }
=20
-static target_ulong h_set_sprg0(PowerPCCPU *cpu, sPAPRMachineState *spap=
r,
+static target_ulong h_set_sprg0(PowerPCCPU *cpu, SpaprMachineState *spap=
r,
                                 target_ulong opcode, target_ulong *args)
 {
     cpu_synchronize_state(CPU(cpu));
@@ -768,7 +768,7 @@ static target_ulong h_set_sprg0(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
     return H_SUCCESS;
 }
=20
-static target_ulong h_set_dabr(PowerPCCPU *cpu, sPAPRMachineState *spapr=
,
+static target_ulong h_set_dabr(PowerPCCPU *cpu, SpaprMachineState *spapr=
,
                                target_ulong opcode, target_ulong *args)
 {
     if (!has_spr(cpu, SPR_DABR)) {
@@ -786,7 +786,7 @@ static target_ulong h_set_dabr(PowerPCCPU *cpu, sPAPR=
MachineState *spapr,
     return H_SUCCESS;
 }
=20
-static target_ulong h_set_xdabr(PowerPCCPU *cpu, sPAPRMachineState *spap=
r,
+static target_ulong h_set_xdabr(PowerPCCPU *cpu, SpaprMachineState *spap=
r,
                                 target_ulong opcode, target_ulong *args)
 {
     target_ulong dabrx =3D args[1];
@@ -807,7 +807,7 @@ static target_ulong h_set_xdabr(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
     return H_SUCCESS;
 }
=20
-static target_ulong h_page_init(PowerPCCPU *cpu, sPAPRMachineState *spap=
r,
+static target_ulong h_page_init(PowerPCCPU *cpu, SpaprMachineState *spap=
r,
                                 target_ulong opcode, target_ulong *args)
 {
     target_ulong flags =3D args[0];
@@ -882,7 +882,7 @@ static target_ulong register_vpa(PowerPCCPU *cpu, tar=
get_ulong vpa)
 {
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
-    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
     uint16_t size;
     uint8_t tmp;
=20
@@ -918,7 +918,7 @@ static target_ulong register_vpa(PowerPCCPU *cpu, tar=
get_ulong vpa)
=20
 static target_ulong deregister_vpa(PowerPCCPU *cpu, target_ulong vpa)
 {
-    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
=20
     if (spapr_cpu->slb_shadow_addr) {
         return H_RESOURCE;
@@ -934,7 +934,7 @@ static target_ulong deregister_vpa(PowerPCCPU *cpu, t=
arget_ulong vpa)
=20
 static target_ulong register_slb_shadow(PowerPCCPU *cpu, target_ulong ad=
dr)
 {
-    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
     uint32_t size;
=20
     if (addr =3D=3D 0) {
@@ -963,7 +963,7 @@ static target_ulong register_slb_shadow(PowerPCCPU *c=
pu, target_ulong addr)
=20
 static target_ulong deregister_slb_shadow(PowerPCCPU *cpu, target_ulong =
addr)
 {
-    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
=20
     spapr_cpu->slb_shadow_addr =3D 0;
     spapr_cpu->slb_shadow_size =3D 0;
@@ -972,7 +972,7 @@ static target_ulong deregister_slb_shadow(PowerPCCPU =
*cpu, target_ulong addr)
=20
 static target_ulong register_dtl(PowerPCCPU *cpu, target_ulong addr)
 {
-    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
     uint32_t size;
=20
     if (addr =3D=3D 0) {
@@ -998,7 +998,7 @@ static target_ulong register_dtl(PowerPCCPU *cpu, tar=
get_ulong addr)
=20
 static target_ulong deregister_dtl(PowerPCCPU *cpu, target_ulong addr)
 {
-    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
=20
     spapr_cpu->dtl_addr =3D 0;
     spapr_cpu->dtl_size =3D 0;
@@ -1006,7 +1006,7 @@ static target_ulong deregister_dtl(PowerPCCPU *cpu,=
 target_ulong addr)
     return H_SUCCESS;
 }
=20
-static target_ulong h_register_vpa(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
+static target_ulong h_register_vpa(PowerPCCPU *cpu, SpaprMachineState *s=
papr,
                                    target_ulong opcode, target_ulong *ar=
gs)
 {
     target_ulong flags =3D args[0];
@@ -1049,7 +1049,7 @@ static target_ulong h_register_vpa(PowerPCCPU *cpu,=
 sPAPRMachineState *spapr,
     return ret;
 }
=20
-static target_ulong h_cede(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_cede(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
     CPUPPCState *env =3D &cpu->env;
@@ -1065,7 +1065,7 @@ static target_ulong h_cede(PowerPCCPU *cpu, sPAPRMa=
chineState *spapr,
     return H_SUCCESS;
 }
=20
-static target_ulong h_rtas(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_rtas(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
     target_ulong rtas_r3 =3D args[0];
@@ -1077,7 +1077,7 @@ static target_ulong h_rtas(PowerPCCPU *cpu, sPAPRMa=
chineState *spapr,
                            nret, rtas_r3 + 12 + 4*nargs);
 }
=20
-static target_ulong h_logical_load(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
+static target_ulong h_logical_load(PowerPCCPU *cpu, SpaprMachineState *s=
papr,
                                    target_ulong opcode, target_ulong *ar=
gs)
 {
     CPUState *cs =3D CPU(cpu);
@@ -1101,7 +1101,7 @@ static target_ulong h_logical_load(PowerPCCPU *cpu,=
 sPAPRMachineState *spapr,
     return H_PARAMETER;
 }
=20
-static target_ulong h_logical_store(PowerPCCPU *cpu, sPAPRMachineState *=
spapr,
+static target_ulong h_logical_store(PowerPCCPU *cpu, SpaprMachineState *=
spapr,
                                     target_ulong opcode, target_ulong *a=
rgs)
 {
     CPUState *cs =3D CPU(cpu);
@@ -1127,7 +1127,7 @@ static target_ulong h_logical_store(PowerPCCPU *cpu=
, sPAPRMachineState *spapr,
     return H_PARAMETER;
 }
=20
-static target_ulong h_logical_memop(PowerPCCPU *cpu, sPAPRMachineState *=
spapr,
+static target_ulong h_logical_memop(PowerPCCPU *cpu, SpaprMachineState *=
spapr,
                                     target_ulong opcode, target_ulong *a=
rgs)
 {
     CPUState *cs =3D CPU(cpu);
@@ -1196,14 +1196,14 @@ static target_ulong h_logical_memop(PowerPCCPU *c=
pu, sPAPRMachineState *spapr,
     return H_SUCCESS;
 }
=20
-static target_ulong h_logical_icbi(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
+static target_ulong h_logical_icbi(PowerPCCPU *cpu, SpaprMachineState *s=
papr,
                                    target_ulong opcode, target_ulong *ar=
gs)
 {
     /* Nothing to do on emulation, KVM will trap this in the kernel */
     return H_SUCCESS;
 }
=20
-static target_ulong h_logical_dcbf(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
+static target_ulong h_logical_dcbf(PowerPCCPU *cpu, SpaprMachineState *s=
papr,
                                    target_ulong opcode, target_ulong *ar=
gs)
 {
     /* Nothing to do on emulation, KVM will trap this in the kernel */
@@ -1263,7 +1263,7 @@ static target_ulong h_set_mode_resource_addr_trans_=
mode(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
=20
-static target_ulong h_set_mode(PowerPCCPU *cpu, sPAPRMachineState *spapr=
,
+static target_ulong h_set_mode(PowerPCCPU *cpu, SpaprMachineState *spapr=
,
                                target_ulong opcode, target_ulong *args)
 {
     target_ulong resource =3D args[1];
@@ -1282,7 +1282,7 @@ static target_ulong h_set_mode(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
     return ret;
 }
=20
-static target_ulong h_clean_slb(PowerPCCPU *cpu, sPAPRMachineState *spap=
r,
+static target_ulong h_clean_slb(PowerPCCPU *cpu, SpaprMachineState *spap=
r,
                                 target_ulong opcode, target_ulong *args)
 {
     qemu_log_mask(LOG_UNIMP, "Unimplemented SPAPR hcall 0x"TARGET_FMT_lx=
"%s\n",
@@ -1290,7 +1290,7 @@ static target_ulong h_clean_slb(PowerPCCPU *cpu, sP=
APRMachineState *spapr,
     return H_FUNCTION;
 }
=20
-static target_ulong h_invalidate_pid(PowerPCCPU *cpu, sPAPRMachineState =
*spapr,
+static target_ulong h_invalidate_pid(PowerPCCPU *cpu, SpaprMachineState =
*spapr,
                                      target_ulong opcode, target_ulong *=
args)
 {
     qemu_log_mask(LOG_UNIMP, "Unimplemented SPAPR hcall 0x"TARGET_FMT_lx=
"%s\n",
@@ -1298,7 +1298,7 @@ static target_ulong h_invalidate_pid(PowerPCCPU *cp=
u, sPAPRMachineState *spapr,
     return H_FUNCTION;
 }
=20
-static void spapr_check_setup_free_hpt(sPAPRMachineState *spapr,
+static void spapr_check_setup_free_hpt(SpaprMachineState *spapr,
                                        uint64_t patbe_old, uint64_t patb=
e_new)
 {
     /*
@@ -1331,7 +1331,7 @@ static void spapr_check_setup_free_hpt(sPAPRMachine=
State *spapr,
 #define FLAG_GTSE               0x01
=20
 static target_ulong h_register_process_table(PowerPCCPU *cpu,
-                                             sPAPRMachineState *spapr,
+                                             SpaprMachineState *spapr,
                                              target_ulong opcode,
                                              target_ulong *args)
 {
@@ -1414,7 +1414,7 @@ static target_ulong h_register_process_table(PowerP=
CCPU *cpu,
 #define H_SIGNAL_SYS_RESET_ALLBUTSELF  -2
=20
 static target_ulong h_signal_sys_reset(PowerPCCPU *cpu,
-                                       sPAPRMachineState *spapr,
+                                       SpaprMachineState *spapr,
                                        target_ulong opcode, target_ulong=
 *args)
 {
     target_long target =3D args[0];
@@ -1449,7 +1449,7 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *=
cpu,
     }
 }
=20
-static uint32_t cas_check_pvr(sPAPRMachineState *spapr, PowerPCCPU *cpu,
+static uint32_t cas_check_pvr(SpaprMachineState *spapr, PowerPCCPU *cpu,
                               target_ulong *addr, bool *raw_mode_support=
ed,
                               Error **errp)
 {
@@ -1500,7 +1500,7 @@ static uint32_t cas_check_pvr(sPAPRMachineState *sp=
apr, PowerPCCPU *cpu,
 }
=20
 static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
-                                                  sPAPRMachineState *spa=
pr,
+                                                  SpaprMachineState *spa=
pr,
                                                   target_ulong opcode,
                                                   target_ulong *args)
 {
@@ -1508,7 +1508,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
     target_ulong addr =3D ppc64_phys_to_real(args[0]);
     target_ulong ov_table;
     uint32_t cas_pvr;
-    sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates=
;
+    SpaprOptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates=
;
     bool guest_radix;
     Error *local_err =3D NULL;
     bool raw_mode_supported =3D false;
@@ -1651,7 +1651,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
 }
=20
 static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
-                                              sPAPRMachineState *spapr,
+                                              SpaprMachineState *spapr,
                                               target_ulong opcode,
                                               target_ulong *args)
 {
@@ -1687,7 +1687,7 @@ static target_ulong h_home_node_associativity(Power=
PCCPU *cpu,
 }
=20
 static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
-                                              sPAPRMachineState *spapr,
+                                              SpaprMachineState *spapr,
                                               target_ulong opcode,
                                               target_ulong *args)
 {
@@ -1751,13 +1751,13 @@ static target_ulong h_get_cpu_characteristics(Pow=
erPCCPU *cpu,
     return H_SUCCESS;
 }
=20
-static target_ulong h_update_dt(PowerPCCPU *cpu, sPAPRMachineState *spap=
r,
+static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spap=
r,
                                 target_ulong opcode, target_ulong *args)
 {
     target_ulong dt =3D ppc64_phys_to_real(args[0]);
     struct fdt_header hdr =3D { 0 };
     unsigned cb;
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     void *fdt;
=20
     cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
@@ -1816,7 +1816,7 @@ void spapr_register_hypercall(target_ulong opcode, =
spapr_hcall_fn fn)
 target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
                              target_ulong *args)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
=20
     if ((opcode <=3D MAX_HCALL_OPCODE)
         && ((opcode & 0x3) =3D=3D 0)) {
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 8f231799b2..5aff4d5a05 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -32,7 +32,7 @@
=20
 #include <libfdt.h>
=20
-enum sPAPRTCEAccess {
+enum SpaprTceAccess {
     SPAPR_TCE_FAULT =3D 0,
     SPAPR_TCE_RO =3D 1,
     SPAPR_TCE_WO =3D 2,
@@ -42,11 +42,11 @@ enum sPAPRTCEAccess {
 #define IOMMU_PAGE_SIZE(shift)      (1ULL << (shift))
 #define IOMMU_PAGE_MASK(shift)      (~(IOMMU_PAGE_SIZE(shift) - 1))
=20
-static QLIST_HEAD(, sPAPRTCETable) spapr_tce_tables;
+static QLIST_HEAD(, SpaprTceTable) spapr_tce_tables;
=20
-sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong liobn)
+SpaprTceTable *spapr_tce_find_by_liobn(target_ulong liobn)
 {
-    sPAPRTCETable *tcet;
+    SpaprTceTable *tcet;
=20
     if (liobn & 0xFFFFFFFF00000000ULL) {
         hcall_dprintf("Request for out-of-bounds LIOBN 0x" TARGET_FMT_lx=
 "\n",
@@ -115,7 +115,7 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUM=
emoryRegion *iommu,
                                                IOMMUAccessFlags flag,
                                                int iommu_idx)
 {
-    sPAPRTCETable *tcet =3D container_of(iommu, sPAPRTCETable, iommu);
+    SpaprTceTable *tcet =3D container_of(iommu, SpaprTceTable, iommu);
     uint64_t tce;
     IOMMUTLBEntry ret =3D {
         .target_as =3D &address_space_memory,
@@ -147,7 +147,7 @@ static void spapr_tce_replay(IOMMUMemoryRegion *iommu=
_mr, IOMMUNotifier *n)
     IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_GET_CLASS(iommu=
_mr);
     hwaddr addr, granularity;
     IOMMUTLBEntry iotlb;
-    sPAPRTCETable *tcet =3D container_of(iommu_mr, sPAPRTCETable, iommu)=
;
+    SpaprTceTable *tcet =3D container_of(iommu_mr, SpaprTceTable, iommu)=
;
=20
     if (tcet->skipping_replay) {
         return;
@@ -173,7 +173,7 @@ static void spapr_tce_replay(IOMMUMemoryRegion *iommu=
_mr, IOMMUNotifier *n)
=20
 static int spapr_tce_table_pre_save(void *opaque)
 {
-    sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(opaque);
+    SpaprTceTable *tcet =3D SPAPR_TCE_TABLE(opaque);
=20
     tcet->mig_table =3D tcet->table;
     tcet->mig_nb_table =3D tcet->nb_table;
@@ -186,7 +186,7 @@ static int spapr_tce_table_pre_save(void *opaque)
=20
 static uint64_t spapr_tce_get_min_page_size(IOMMUMemoryRegion *iommu)
 {
-    sPAPRTCETable *tcet =3D container_of(iommu, sPAPRTCETable, iommu);
+    SpaprTceTable *tcet =3D container_of(iommu, SpaprTceTable, iommu);
=20
     return 1ULL << tcet->page_shift;
 }
@@ -194,7 +194,7 @@ static uint64_t spapr_tce_get_min_page_size(IOMMUMemo=
ryRegion *iommu)
 static int spapr_tce_get_attr(IOMMUMemoryRegion *iommu,
                               enum IOMMUMemoryRegionAttr attr, void *dat=
a)
 {
-    sPAPRTCETable *tcet =3D container_of(iommu, sPAPRTCETable, iommu);
+    SpaprTceTable *tcet =3D container_of(iommu, SpaprTceTable, iommu);
=20
     if (attr =3D=3D IOMMU_ATTR_SPAPR_TCE_FD && kvmppc_has_cap_spapr_vfio=
()) {
         *(int *) data =3D tcet->fd;
@@ -208,7 +208,7 @@ static void spapr_tce_notify_flag_changed(IOMMUMemory=
Region *iommu,
                                           IOMMUNotifierFlag old,
                                           IOMMUNotifierFlag new)
 {
-    struct sPAPRTCETable *tbl =3D container_of(iommu, sPAPRTCETable, iom=
mu);
+    struct SpaprTceTable *tbl =3D container_of(iommu, SpaprTceTable, iom=
mu);
=20
     if (old =3D=3D IOMMU_NOTIFIER_NONE && new !=3D IOMMU_NOTIFIER_NONE) =
{
         spapr_tce_set_need_vfio(tbl, true);
@@ -219,7 +219,7 @@ static void spapr_tce_notify_flag_changed(IOMMUMemory=
Region *iommu,
=20
 static int spapr_tce_table_post_load(void *opaque, int version_id)
 {
-    sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(opaque);
+    SpaprTceTable *tcet =3D SPAPR_TCE_TABLE(opaque);
     uint32_t old_nb_table =3D tcet->nb_table;
     uint64_t old_bus_offset =3D tcet->bus_offset;
     uint32_t old_page_shift =3D tcet->page_shift;
@@ -253,7 +253,7 @@ static int spapr_tce_table_post_load(void *opaque, in=
t version_id)
=20
 static bool spapr_tce_table_ex_needed(void *opaque)
 {
-    sPAPRTCETable *tcet =3D opaque;
+    SpaprTceTable *tcet =3D opaque;
=20
     return tcet->bus_offset || tcet->page_shift !=3D 0xC;
 }
@@ -264,8 +264,8 @@ static const VMStateDescription vmstate_spapr_tce_tab=
le_ex =3D {
     .minimum_version_id =3D 1,
     .needed =3D spapr_tce_table_ex_needed,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT64(bus_offset, sPAPRTCETable),
-        VMSTATE_UINT32(page_shift, sPAPRTCETable),
+        VMSTATE_UINT64(bus_offset, SpaprTceTable),
+        VMSTATE_UINT32(page_shift, SpaprTceTable),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -278,12 +278,12 @@ static const VMStateDescription vmstate_spapr_tce_t=
able =3D {
     .post_load =3D spapr_tce_table_post_load,
     .fields      =3D (VMStateField []) {
         /* Sanity check */
-        VMSTATE_UINT32_EQUAL(liobn, sPAPRTCETable, NULL),
+        VMSTATE_UINT32_EQUAL(liobn, SpaprTceTable, NULL),
=20
         /* IOMMU state */
-        VMSTATE_UINT32(mig_nb_table, sPAPRTCETable),
-        VMSTATE_BOOL(bypass, sPAPRTCETable),
-        VMSTATE_VARRAY_UINT32_ALLOC(mig_table, sPAPRTCETable, mig_nb_tab=
le, 0,
+        VMSTATE_UINT32(mig_nb_table, SpaprTceTable),
+        VMSTATE_BOOL(bypass, SpaprTceTable),
+        VMSTATE_VARRAY_UINT32_ALLOC(mig_table, SpaprTceTable, mig_nb_tab=
le, 0,
                                     vmstate_info_uint64, uint64_t),
=20
         VMSTATE_END_OF_LIST()
@@ -296,7 +296,7 @@ static const VMStateDescription vmstate_spapr_tce_tab=
le =3D {
=20
 static void spapr_tce_table_realize(DeviceState *dev, Error **errp)
 {
-    sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(dev);
+    SpaprTceTable *tcet =3D SPAPR_TCE_TABLE(dev);
     Object *tcetobj =3D OBJECT(tcet);
     gchar *tmp;
=20
@@ -318,7 +318,7 @@ static void spapr_tce_table_realize(DeviceState *dev,=
 Error **errp)
                      tcet);
 }
=20
-void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio)
+void spapr_tce_set_need_vfio(SpaprTceTable *tcet, bool need_vfio)
 {
     size_t table_size =3D tcet->nb_table * sizeof(uint64_t);
     uint64_t *oldtable;
@@ -347,9 +347,9 @@ void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, boo=
l need_vfio)
     tcet->fd =3D newfd;
 }
=20
-sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn)
+SpaprTceTable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn)
 {
-    sPAPRTCETable *tcet;
+    SpaprTceTable *tcet;
     gchar *tmp;
=20
     if (spapr_tce_find_by_liobn(liobn)) {
@@ -371,7 +371,7 @@ sPAPRTCETable *spapr_tce_new_table(DeviceState *owner=
, uint32_t liobn)
     return tcet;
 }
=20
-void spapr_tce_table_enable(sPAPRTCETable *tcet,
+void spapr_tce_table_enable(SpaprTceTable *tcet,
                             uint32_t page_shift, uint64_t bus_offset,
                             uint32_t nb_table)
 {
@@ -396,7 +396,7 @@ void spapr_tce_table_enable(sPAPRTCETable *tcet,
                                 MEMORY_REGION(&tcet->iommu));
 }
=20
-void spapr_tce_table_disable(sPAPRTCETable *tcet)
+void spapr_tce_table_disable(SpaprTceTable *tcet)
 {
     if (!tcet->nb_table) {
         return;
@@ -415,7 +415,7 @@ void spapr_tce_table_disable(sPAPRTCETable *tcet)
=20
 static void spapr_tce_table_unrealize(DeviceState *dev, Error **errp)
 {
-    sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(dev);
+    SpaprTceTable *tcet =3D SPAPR_TCE_TABLE(dev);
=20
     vmstate_unregister(DEVICE(tcet), &vmstate_spapr_tce_table, tcet);
=20
@@ -424,14 +424,14 @@ static void spapr_tce_table_unrealize(DeviceState *=
dev, Error **errp)
     spapr_tce_table_disable(tcet);
 }
=20
-MemoryRegion *spapr_tce_get_iommu(sPAPRTCETable *tcet)
+MemoryRegion *spapr_tce_get_iommu(SpaprTceTable *tcet)
 {
     return &tcet->root;
 }
=20
 static void spapr_tce_reset(DeviceState *dev)
 {
-    sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(dev);
+    SpaprTceTable *tcet =3D SPAPR_TCE_TABLE(dev);
     size_t table_size =3D tcet->nb_table * sizeof(uint64_t);
=20
     if (tcet->nb_table) {
@@ -439,7 +439,7 @@ static void spapr_tce_reset(DeviceState *dev)
     }
 }
=20
-static target_ulong put_tce_emu(sPAPRTCETable *tcet, target_ulong ioba,
+static target_ulong put_tce_emu(SpaprTceTable *tcet, target_ulong ioba,
                                 target_ulong tce)
 {
     IOMMUTLBEntry entry;
@@ -465,7 +465,7 @@ static target_ulong put_tce_emu(sPAPRTCETable *tcet, =
target_ulong ioba,
 }
=20
 static target_ulong h_put_tce_indirect(PowerPCCPU *cpu,
-                                       sPAPRMachineState *spapr,
+                                       SpaprMachineState *spapr,
                                        target_ulong opcode, target_ulong=
 *args)
 {
     int i;
@@ -475,7 +475,7 @@ static target_ulong h_put_tce_indirect(PowerPCCPU *cp=
u,
     target_ulong tce_list =3D args[2];
     target_ulong npages =3D args[3];
     target_ulong ret =3D H_PARAMETER, tce =3D 0;
-    sPAPRTCETable *tcet =3D spapr_tce_find_by_liobn(liobn);
+    SpaprTceTable *tcet =3D spapr_tce_find_by_liobn(liobn);
     CPUState *cs =3D CPU(cpu);
     hwaddr page_mask, page_size;
=20
@@ -510,7 +510,7 @@ static target_ulong h_put_tce_indirect(PowerPCCPU *cp=
u,
     return ret;
 }
=20
-static target_ulong h_stuff_tce(PowerPCCPU *cpu, sPAPRMachineState *spap=
r,
+static target_ulong h_stuff_tce(PowerPCCPU *cpu, SpaprMachineState *spap=
r,
                               target_ulong opcode, target_ulong *args)
 {
     int i;
@@ -519,7 +519,7 @@ static target_ulong h_stuff_tce(PowerPCCPU *cpu, sPAP=
RMachineState *spapr,
     target_ulong tce_value =3D args[2];
     target_ulong npages =3D args[3];
     target_ulong ret =3D H_PARAMETER;
-    sPAPRTCETable *tcet =3D spapr_tce_find_by_liobn(liobn);
+    SpaprTceTable *tcet =3D spapr_tce_find_by_liobn(liobn);
     hwaddr page_mask, page_size;
=20
     if (!tcet) {
@@ -549,14 +549,14 @@ static target_ulong h_stuff_tce(PowerPCCPU *cpu, sP=
APRMachineState *spapr,
     return ret;
 }
=20
-static target_ulong h_put_tce(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_put_tce(PowerPCCPU *cpu, SpaprMachineState *spapr,
                               target_ulong opcode, target_ulong *args)
 {
     target_ulong liobn =3D args[0];
     target_ulong ioba =3D args[1];
     target_ulong tce =3D args[2];
     target_ulong ret =3D H_PARAMETER;
-    sPAPRTCETable *tcet =3D spapr_tce_find_by_liobn(liobn);
+    SpaprTceTable *tcet =3D spapr_tce_find_by_liobn(liobn);
=20
     if (tcet) {
         hwaddr page_mask =3D IOMMU_PAGE_MASK(tcet->page_shift);
@@ -574,7 +574,7 @@ static target_ulong h_put_tce(PowerPCCPU *cpu, sPAPRM=
achineState *spapr,
     return ret;
 }
=20
-static target_ulong get_tce_emu(sPAPRTCETable *tcet, target_ulong ioba,
+static target_ulong get_tce_emu(SpaprTceTable *tcet, target_ulong ioba,
                                 target_ulong *tce)
 {
     unsigned long index =3D (ioba - tcet->bus_offset) >> tcet->page_shif=
t;
@@ -590,14 +590,14 @@ static target_ulong get_tce_emu(sPAPRTCETable *tcet=
, target_ulong ioba,
     return H_SUCCESS;
 }
=20
-static target_ulong h_get_tce(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_get_tce(PowerPCCPU *cpu, SpaprMachineState *spapr,
                               target_ulong opcode, target_ulong *args)
 {
     target_ulong liobn =3D args[0];
     target_ulong ioba =3D args[1];
     target_ulong tce =3D 0;
     target_ulong ret =3D H_PARAMETER;
-    sPAPRTCETable *tcet =3D spapr_tce_find_by_liobn(liobn);
+    SpaprTceTable *tcet =3D spapr_tce_find_by_liobn(liobn);
=20
     if (tcet) {
         hwaddr page_mask =3D IOMMU_PAGE_MASK(tcet->page_shift);
@@ -649,7 +649,7 @@ int spapr_dma_dt(void *fdt, int node_off, const char =
*propname,
 }
=20
 int spapr_tcet_dma_dt(void *fdt, int node_off, const char *propname,
-                      sPAPRTCETable *tcet)
+                      SpaprTceTable *tcet)
 {
     if (!tcet) {
         return 0;
@@ -680,7 +680,7 @@ static void spapr_tce_table_class_init(ObjectClass *k=
lass, void *data)
 static TypeInfo spapr_tce_table_info =3D {
     .name =3D TYPE_SPAPR_TCE_TABLE,
     .parent =3D TYPE_DEVICE,
-    .instance_size =3D sizeof(sPAPRTCETable),
+    .instance_size =3D sizeof(SpaprTceTable),
     .class_init =3D spapr_tce_table_class_init,
 };
=20
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 4145079d7f..253e4de7fd 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -20,13 +20,13 @@
=20
 #include "trace.h"
=20
-void spapr_irq_msi_init(sPAPRMachineState *spapr, uint32_t nr_msis)
+void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis)
 {
     spapr->irq_map_nr =3D nr_msis;
     spapr->irq_map =3D bitmap_new(spapr->irq_map_nr);
 }
=20
-int spapr_irq_msi_alloc(sPAPRMachineState *spapr, uint32_t num, bool ali=
gn,
+int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool ali=
gn,
                         Error **errp)
 {
     int irq;
@@ -51,12 +51,12 @@ int spapr_irq_msi_alloc(sPAPRMachineState *spapr, uin=
t32_t num, bool align,
     return irq + SPAPR_IRQ_MSI;
 }
=20
-void spapr_irq_msi_free(sPAPRMachineState *spapr, int irq, uint32_t num)
+void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num)
 {
     bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
 }
=20
-void spapr_irq_msi_reset(sPAPRMachineState *spapr)
+void spapr_irq_msi_reset(SpaprMachineState *spapr)
 {
     bitmap_clear(spapr->irq_map, 0, spapr->irq_map_nr);
 }
@@ -66,7 +66,7 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr)
  * XICS IRQ backend.
  */
=20
-static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
+static ICSState *spapr_ics_create(SpaprMachineState *spapr,
                                   int nr_irqs, Error **errp)
 {
     Error *local_err =3D NULL;
@@ -92,7 +92,7 @@ error:
     return NULL;
 }
=20
-static void spapr_irq_init_xics(sPAPRMachineState *spapr, int nr_irqs,
+static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_irqs,
                                 Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
@@ -126,7 +126,7 @@ error:
 #define ICS_IRQ_FREE(ics, srcno)   \
     (!((ics)->irqs[(srcno)].flags & (XICS_FLAGS_IRQ_MASK)))
=20
-static int spapr_irq_claim_xics(sPAPRMachineState *spapr, int irq, bool =
lsi,
+static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool =
lsi,
                                 Error **errp)
 {
     ICSState *ics =3D spapr->ics;
@@ -147,7 +147,7 @@ static int spapr_irq_claim_xics(sPAPRMachineState *sp=
apr, int irq, bool lsi,
     return 0;
 }
=20
-static void spapr_irq_free_xics(sPAPRMachineState *spapr, int irq, int n=
um)
+static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq, int n=
um)
 {
     ICSState *ics =3D spapr->ics;
     uint32_t srcno =3D irq - ics->offset;
@@ -164,7 +164,7 @@ static void spapr_irq_free_xics(sPAPRMachineState *sp=
apr, int irq, int num)
     }
 }
=20
-static qemu_irq spapr_qirq_xics(sPAPRMachineState *spapr, int irq)
+static qemu_irq spapr_qirq_xics(SpaprMachineState *spapr, int irq)
 {
     ICSState *ics =3D spapr->ics;
     uint32_t srcno =3D irq - ics->offset;
@@ -176,7 +176,7 @@ static qemu_irq spapr_qirq_xics(sPAPRMachineState *sp=
apr, int irq)
     return NULL;
 }
=20
-static void spapr_irq_print_info_xics(sPAPRMachineState *spapr, Monitor =
*mon)
+static void spapr_irq_print_info_xics(SpaprMachineState *spapr, Monitor =
*mon)
 {
     CPUState *cs;
=20
@@ -189,12 +189,12 @@ static void spapr_irq_print_info_xics(sPAPRMachineS=
tate *spapr, Monitor *mon)
     ics_pic_print_info(spapr->ics, mon);
 }
=20
-static void spapr_irq_cpu_intc_create_xics(sPAPRMachineState *spapr,
+static void spapr_irq_cpu_intc_create_xics(SpaprMachineState *spapr,
                                            PowerPCCPU *cpu, Error **errp=
)
 {
     Error *local_err =3D NULL;
     Object *obj;
-    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
=20
     obj =3D icp_create(OBJECT(cpu), TYPE_ICP, XICS_FABRIC(spapr),
                      &local_err);
@@ -206,7 +206,7 @@ static void spapr_irq_cpu_intc_create_xics(sPAPRMachi=
neState *spapr,
     spapr_cpu->icp =3D ICP(obj);
 }
=20
-static int spapr_irq_post_load_xics(sPAPRMachineState *spapr, int versio=
n_id)
+static int spapr_irq_post_load_xics(SpaprMachineState *spapr, int versio=
n_id)
 {
     if (!kvm_irqchip_in_kernel()) {
         CPUState *cs;
@@ -220,17 +220,17 @@ static int spapr_irq_post_load_xics(sPAPRMachineSta=
te *spapr, int version_id)
=20
 static void spapr_irq_set_irq_xics(void *opaque, int srcno, int val)
 {
-    sPAPRMachineState *spapr =3D opaque;
+    SpaprMachineState *spapr =3D opaque;
=20
     ics_simple_set_irq(spapr->ics, srcno, val);
 }
=20
-static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
+static void spapr_irq_reset_xics(SpaprMachineState *spapr, Error **errp)
 {
     /* TODO: create the KVM XICS device */
 }
=20
-static const char *spapr_irq_get_nodename_xics(sPAPRMachineState *spapr)
+static const char *spapr_irq_get_nodename_xics(SpaprMachineState *spapr)
 {
     return XICS_NODENAME;
 }
@@ -239,7 +239,7 @@ static const char *spapr_irq_get_nodename_xics(sPAPRM=
achineState *spapr)
 #define SPAPR_IRQ_XICS_NR_MSIS     \
     (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
=20
-sPAPRIrq spapr_irq_xics =3D {
+SpaprIrq spapr_irq_xics =3D {
     .nr_irqs     =3D SPAPR_IRQ_XICS_NR_IRQS,
     .nr_msis     =3D SPAPR_IRQ_XICS_NR_MSIS,
     .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
@@ -260,7 +260,7 @@ sPAPRIrq spapr_irq_xics =3D {
 /*
  * XIVE IRQ backend.
  */
-static void spapr_irq_init_xive(sPAPRMachineState *spapr, int nr_irqs,
+static void spapr_irq_init_xive(SpaprMachineState *spapr, int nr_irqs,
                                 Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
@@ -294,7 +294,7 @@ static void spapr_irq_init_xive(sPAPRMachineState *sp=
apr, int nr_irqs,
     spapr_xive_hcall_init(spapr);
 }
=20
-static int spapr_irq_claim_xive(sPAPRMachineState *spapr, int irq, bool =
lsi,
+static int spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bool =
lsi,
                                 Error **errp)
 {
     if (!spapr_xive_irq_claim(spapr->xive, irq, lsi)) {
@@ -304,7 +304,7 @@ static int spapr_irq_claim_xive(sPAPRMachineState *sp=
apr, int irq, bool lsi,
     return 0;
 }
=20
-static void spapr_irq_free_xive(sPAPRMachineState *spapr, int irq, int n=
um)
+static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq, int n=
um)
 {
     int i;
=20
@@ -313,9 +313,9 @@ static void spapr_irq_free_xive(sPAPRMachineState *sp=
apr, int irq, int num)
     }
 }
=20
-static qemu_irq spapr_qirq_xive(sPAPRMachineState *spapr, int irq)
+static qemu_irq spapr_qirq_xive(SpaprMachineState *spapr, int irq)
 {
-    sPAPRXive *xive =3D spapr->xive;
+    SpaprXive *xive =3D spapr->xive;
=20
     if (irq >=3D xive->nr_irqs) {
         return NULL;
@@ -327,7 +327,7 @@ static qemu_irq spapr_qirq_xive(sPAPRMachineState *sp=
apr, int irq)
     return spapr->qirqs[irq];
 }
=20
-static void spapr_irq_print_info_xive(sPAPRMachineState *spapr,
+static void spapr_irq_print_info_xive(SpaprMachineState *spapr,
                                       Monitor *mon)
 {
     CPUState *cs;
@@ -341,12 +341,12 @@ static void spapr_irq_print_info_xive(sPAPRMachineS=
tate *spapr,
     spapr_xive_pic_print_info(spapr->xive, mon);
 }
=20
-static void spapr_irq_cpu_intc_create_xive(sPAPRMachineState *spapr,
+static void spapr_irq_cpu_intc_create_xive(SpaprMachineState *spapr,
                                            PowerPCCPU *cpu, Error **errp=
)
 {
     Error *local_err =3D NULL;
     Object *obj;
-    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
=20
     obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(spapr->xive), &loc=
al_err);
     if (local_err) {
@@ -363,12 +363,12 @@ static void spapr_irq_cpu_intc_create_xive(sPAPRMac=
hineState *spapr,
     spapr_xive_set_tctx_os_cam(spapr_cpu->tctx);
 }
=20
-static int spapr_irq_post_load_xive(sPAPRMachineState *spapr, int versio=
n_id)
+static int spapr_irq_post_load_xive(SpaprMachineState *spapr, int versio=
n_id)
 {
     return 0;
 }
=20
-static void spapr_irq_reset_xive(sPAPRMachineState *spapr, Error **errp)
+static void spapr_irq_reset_xive(SpaprMachineState *spapr, Error **errp)
 {
     CPUState *cs;
=20
@@ -385,12 +385,12 @@ static void spapr_irq_reset_xive(sPAPRMachineState =
*spapr, Error **errp)
=20
 static void spapr_irq_set_irq_xive(void *opaque, int srcno, int val)
 {
-    sPAPRMachineState *spapr =3D opaque;
+    SpaprMachineState *spapr =3D opaque;
=20
     xive_source_set_irq(&spapr->xive->source, srcno, val);
 }
=20
-static const char *spapr_irq_get_nodename_xive(sPAPRMachineState *spapr)
+static const char *spapr_irq_get_nodename_xive(SpaprMachineState *spapr)
 {
     return spapr->xive->nodename;
 }
@@ -403,7 +403,7 @@ static const char *spapr_irq_get_nodename_xive(sPAPRM=
achineState *spapr)
 #define SPAPR_IRQ_XIVE_NR_IRQS     0x2000
 #define SPAPR_IRQ_XIVE_NR_MSIS     (SPAPR_IRQ_XIVE_NR_IRQS - SPAPR_IRQ_M=
SI)
=20
-sPAPRIrq spapr_irq_xive =3D {
+SpaprIrq spapr_irq_xive =3D {
     .nr_irqs     =3D SPAPR_IRQ_XIVE_NR_IRQS,
     .nr_msis     =3D SPAPR_IRQ_XIVE_NR_MSIS,
     .ov5         =3D SPAPR_OV5_XIVE_EXPLOIT,
@@ -434,13 +434,13 @@ sPAPRIrq spapr_irq_xive =3D {
  * Returns the sPAPR IRQ backend negotiated by CAS. XICS is the
  * default.
  */
-static sPAPRIrq *spapr_irq_current(sPAPRMachineState *spapr)
+static SpaprIrq *spapr_irq_current(SpaprMachineState *spapr)
 {
     return spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT) ?
         &spapr_irq_xive : &spapr_irq_xics;
 }
=20
-static void spapr_irq_init_dual(sPAPRMachineState *spapr, int nr_irqs,
+static void spapr_irq_init_dual(SpaprMachineState *spapr, int nr_irqs,
                                 Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
@@ -464,7 +464,7 @@ static void spapr_irq_init_dual(sPAPRMachineState *sp=
apr, int nr_irqs,
     }
 }
=20
-static int spapr_irq_claim_dual(sPAPRMachineState *spapr, int irq, bool =
lsi,
+static int spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, bool =
lsi,
                                 Error **errp)
 {
     Error *local_err =3D NULL;
@@ -485,30 +485,30 @@ static int spapr_irq_claim_dual(sPAPRMachineState *=
spapr, int irq, bool lsi,
     return ret;
 }
=20
-static void spapr_irq_free_dual(sPAPRMachineState *spapr, int irq, int n=
um)
+static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq, int n=
um)
 {
     spapr_irq_xics.free(spapr, irq, num);
     spapr_irq_xive.free(spapr, irq, num);
 }
=20
-static qemu_irq spapr_qirq_dual(sPAPRMachineState *spapr, int irq)
+static qemu_irq spapr_qirq_dual(SpaprMachineState *spapr, int irq)
 {
     return spapr_irq_current(spapr)->qirq(spapr, irq);
 }
=20
-static void spapr_irq_print_info_dual(sPAPRMachineState *spapr, Monitor =
*mon)
+static void spapr_irq_print_info_dual(SpaprMachineState *spapr, Monitor =
*mon)
 {
     spapr_irq_current(spapr)->print_info(spapr, mon);
 }
=20
-static void spapr_irq_dt_populate_dual(sPAPRMachineState *spapr,
+static void spapr_irq_dt_populate_dual(SpaprMachineState *spapr,
                                        uint32_t nr_servers, void *fdt,
                                        uint32_t phandle)
 {
     spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, phandl=
e);
 }
=20
-static void spapr_irq_cpu_intc_create_dual(sPAPRMachineState *spapr,
+static void spapr_irq_cpu_intc_create_dual(SpaprMachineState *spapr,
                                            PowerPCCPU *cpu, Error **errp=
)
 {
     Error *local_err =3D NULL;
@@ -522,7 +522,7 @@ static void spapr_irq_cpu_intc_create_dual(sPAPRMachi=
neState *spapr,
     spapr_irq_xics.cpu_intc_create(spapr, cpu, errp);
 }
=20
-static int spapr_irq_post_load_dual(sPAPRMachineState *spapr, int versio=
n_id)
+static int spapr_irq_post_load_dual(SpaprMachineState *spapr, int versio=
n_id)
 {
     /*
      * Force a reset of the XIVE backend after migration. The machine
@@ -535,7 +535,7 @@ static int spapr_irq_post_load_dual(sPAPRMachineState=
 *spapr, int version_id)
     return spapr_irq_current(spapr)->post_load(spapr, version_id);
 }
=20
-static void spapr_irq_reset_dual(sPAPRMachineState *spapr, Error **errp)
+static void spapr_irq_reset_dual(SpaprMachineState *spapr, Error **errp)
 {
     /*
      * Deactivate the XIVE MMIOs. The XIVE backend will reenable them
@@ -548,12 +548,12 @@ static void spapr_irq_reset_dual(sPAPRMachineState =
*spapr, Error **errp)
=20
 static void spapr_irq_set_irq_dual(void *opaque, int srcno, int val)
 {
-    sPAPRMachineState *spapr =3D opaque;
+    SpaprMachineState *spapr =3D opaque;
=20
     spapr_irq_current(spapr)->set_irq(spapr, srcno, val);
 }
=20
-static const char *spapr_irq_get_nodename_dual(sPAPRMachineState *spapr)
+static const char *spapr_irq_get_nodename_dual(SpaprMachineState *spapr)
 {
     return spapr_irq_current(spapr)->get_nodename(spapr);
 }
@@ -564,7 +564,7 @@ static const char *spapr_irq_get_nodename_dual(sPAPRM=
achineState *spapr)
 #define SPAPR_IRQ_DUAL_NR_IRQS     0x2000
 #define SPAPR_IRQ_DUAL_NR_MSIS     (SPAPR_IRQ_DUAL_NR_IRQS - SPAPR_IRQ_M=
SI)
=20
-sPAPRIrq spapr_irq_dual =3D {
+SpaprIrq spapr_irq_dual =3D {
     .nr_irqs     =3D SPAPR_IRQ_DUAL_NR_IRQS,
     .nr_msis     =3D SPAPR_IRQ_DUAL_NR_MSIS,
     .ov5         =3D SPAPR_OV5_XIVE_BOTH,
@@ -585,7 +585,7 @@ sPAPRIrq spapr_irq_dual =3D {
 /*
  * sPAPR IRQ frontend routines for devices
  */
-void spapr_irq_init(sPAPRMachineState *spapr, Error **errp)
+void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
=20
@@ -611,34 +611,34 @@ void spapr_irq_init(sPAPRMachineState *spapr, Error=
 **errp)
                                       spapr->irq->nr_irqs);
 }
=20
-int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp)
+int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp)
 {
     return spapr->irq->claim(spapr, irq, lsi, errp);
 }
=20
-void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num)
+void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
 {
     spapr->irq->free(spapr, irq, num);
 }
=20
-qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq)
+qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
 {
     return spapr->irq->qirq(spapr, irq);
 }
=20
-int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id)
+int spapr_irq_post_load(SpaprMachineState *spapr, int version_id)
 {
     return spapr->irq->post_load(spapr, version_id);
 }
=20
-void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp)
+void spapr_irq_reset(SpaprMachineState *spapr, Error **errp)
 {
     if (spapr->irq->reset) {
         spapr->irq->reset(spapr, errp);
     }
 }
=20
-int spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt, Error **e=
rrp)
+int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error **e=
rrp)
 {
     const char *nodename =3D spapr->irq->get_nodename(spapr);
     int offset, phandle;
@@ -684,7 +684,7 @@ static int ics_find_free_block(ICSState *ics, int num=
, int alignnum)
     return -1;
 }
=20
-int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align, Error =
**errp)
+int spapr_irq_find(SpaprMachineState *spapr, int num, bool align, Error =
**errp)
 {
     ICSState *ics =3D spapr->ics;
     int first =3D -1;
@@ -716,7 +716,7 @@ int spapr_irq_find(sPAPRMachineState *spapr, int num,=
 bool align, Error **errp)
=20
 #define SPAPR_IRQ_XICS_LEGACY_NR_IRQS     0x400
=20
-sPAPRIrq spapr_irq_xics_legacy =3D {
+SpaprIrq spapr_irq_xics_legacy =3D {
     .nr_irqs     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
     .nr_msis     =3D SPAPR_IRQ_XICS_LEGACY_NR_IRQS,
     .ov5         =3D SPAPR_OV5_XIVE_LEGACY,
diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index 318bf33de4..a65b7c7da9 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -26,7 +26,7 @@
  * allows us to more safely make assumptions about the bitmap size and
  * simplify the calling code somewhat
  */
-struct sPAPROptionVector {
+struct SpaprOptionVector {
     unsigned long *bitmap;
     int32_t bitmap_size; /* only used for migration */
 };
@@ -36,25 +36,25 @@ const VMStateDescription vmstate_spapr_ovec =3D {
     .version_id =3D 1,
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
-        VMSTATE_BITMAP(bitmap, sPAPROptionVector, 1, bitmap_size),
+        VMSTATE_BITMAP(bitmap, SpaprOptionVector, 1, bitmap_size),
         VMSTATE_END_OF_LIST()
     }
 };
=20
-sPAPROptionVector *spapr_ovec_new(void)
+SpaprOptionVector *spapr_ovec_new(void)
 {
-    sPAPROptionVector *ov;
+    SpaprOptionVector *ov;
=20
-    ov =3D g_new0(sPAPROptionVector, 1);
+    ov =3D g_new0(SpaprOptionVector, 1);
     ov->bitmap =3D bitmap_new(OV_MAXBITS);
     ov->bitmap_size =3D OV_MAXBITS;
=20
     return ov;
 }
=20
-sPAPROptionVector *spapr_ovec_clone(sPAPROptionVector *ov_orig)
+SpaprOptionVector *spapr_ovec_clone(SpaprOptionVector *ov_orig)
 {
-    sPAPROptionVector *ov;
+    SpaprOptionVector *ov;
=20
     g_assert(ov_orig);
=20
@@ -64,9 +64,9 @@ sPAPROptionVector *spapr_ovec_clone(sPAPROptionVector *=
ov_orig)
     return ov;
 }
=20
-void spapr_ovec_intersect(sPAPROptionVector *ov,
-                          sPAPROptionVector *ov1,
-                          sPAPROptionVector *ov2)
+void spapr_ovec_intersect(SpaprOptionVector *ov,
+                          SpaprOptionVector *ov1,
+                          SpaprOptionVector *ov2)
 {
     g_assert(ov);
     g_assert(ov1);
@@ -76,9 +76,9 @@ void spapr_ovec_intersect(sPAPROptionVector *ov,
 }
=20
 /* returns true if options bits were removed, false otherwise */
-bool spapr_ovec_diff(sPAPROptionVector *ov,
-                     sPAPROptionVector *ov_old,
-                     sPAPROptionVector *ov_new)
+bool spapr_ovec_diff(SpaprOptionVector *ov,
+                     SpaprOptionVector *ov_old,
+                     SpaprOptionVector *ov_new)
 {
     unsigned long *change_mask =3D bitmap_new(OV_MAXBITS);
     unsigned long *removed_bits =3D bitmap_new(OV_MAXBITS);
@@ -102,7 +102,7 @@ bool spapr_ovec_diff(sPAPROptionVector *ov,
     return bits_were_removed;
 }
=20
-void spapr_ovec_cleanup(sPAPROptionVector *ov)
+void spapr_ovec_cleanup(SpaprOptionVector *ov)
 {
     if (ov) {
         g_free(ov->bitmap);
@@ -110,7 +110,7 @@ void spapr_ovec_cleanup(sPAPROptionVector *ov)
     }
 }
=20
-void spapr_ovec_set(sPAPROptionVector *ov, long bitnr)
+void spapr_ovec_set(SpaprOptionVector *ov, long bitnr)
 {
     g_assert(ov);
     g_assert(bitnr < OV_MAXBITS);
@@ -118,7 +118,7 @@ void spapr_ovec_set(sPAPROptionVector *ov, long bitnr=
)
     set_bit(bitnr, ov->bitmap);
 }
=20
-void spapr_ovec_clear(sPAPROptionVector *ov, long bitnr)
+void spapr_ovec_clear(SpaprOptionVector *ov, long bitnr)
 {
     g_assert(ov);
     g_assert(bitnr < OV_MAXBITS);
@@ -126,7 +126,7 @@ void spapr_ovec_clear(sPAPROptionVector *ov, long bit=
nr)
     clear_bit(bitnr, ov->bitmap);
 }
=20
-bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr)
+bool spapr_ovec_test(SpaprOptionVector *ov, long bitnr)
 {
     g_assert(ov);
     g_assert(bitnr < OV_MAXBITS);
@@ -178,9 +178,9 @@ static target_ulong vector_addr(target_ulong table_ad=
dr, int vector)
     return table_addr;
 }
=20
-sPAPROptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int =
vector)
+SpaprOptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int =
vector)
 {
-    sPAPROptionVector *ov;
+    SpaprOptionVector *ov;
     target_ulong addr;
     uint16_t vector_len;
     int i;
@@ -210,7 +210,7 @@ sPAPROptionVector *spapr_ovec_parse_vector(target_ulo=
ng table_addr, int vector)
 }
=20
 int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
-                           sPAPROptionVector *ov, const char *name)
+                           SpaprOptionVector *ov, const char *name)
 {
     uint8_t vec[OV_MAXBYTES + 1];
     uint16_t vec_len;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 69059c36eb..20915d2b3c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -61,9 +61,9 @@
 #define RTAS_TYPE_MSI           1
 #define RTAS_TYPE_MSIX          2
=20
-sPAPRPHBState *spapr_pci_find_phb(sPAPRMachineState *spapr, uint64_t bui=
d)
+SpaprPhbState *spapr_pci_find_phb(SpaprMachineState *spapr, uint64_t bui=
d)
 {
-    sPAPRPHBState *sphb;
+    SpaprPhbState *sphb;
=20
     QLIST_FOREACH(sphb, &spapr->phbs, list) {
         if (sphb->buid !=3D buid) {
@@ -75,10 +75,10 @@ sPAPRPHBState *spapr_pci_find_phb(sPAPRMachineState *=
spapr, uint64_t buid)
     return NULL;
 }
=20
-PCIDevice *spapr_pci_find_dev(sPAPRMachineState *spapr, uint64_t buid,
+PCIDevice *spapr_pci_find_dev(SpaprMachineState *spapr, uint64_t buid,
                               uint32_t config_addr)
 {
-    sPAPRPHBState *sphb =3D spapr_pci_find_phb(spapr, buid);
+    SpaprPhbState *sphb =3D spapr_pci_find_phb(spapr, buid);
     PCIHostState *phb =3D PCI_HOST_BRIDGE(sphb);
     int bus_num =3D (config_addr >> 16) & 0xFF;
     int devfn =3D (config_addr >> 8) & 0xFF;
@@ -96,7 +96,7 @@ static uint32_t rtas_pci_cfgaddr(uint32_t arg)
     return ((arg >> 20) & 0xf00) | (arg & 0xff);
 }
=20
-static void finish_read_pci_config(sPAPRMachineState *spapr, uint64_t bu=
id,
+static void finish_read_pci_config(SpaprMachineState *spapr, uint64_t bu=
id,
                                    uint32_t addr, uint32_t size,
                                    target_ulong rets)
 {
@@ -126,7 +126,7 @@ static void finish_read_pci_config(sPAPRMachineState =
*spapr, uint64_t buid,
     rtas_st(rets, 1, val);
 }
=20
-static void rtas_ibm_read_pci_config(PowerPCCPU *cpu, sPAPRMachineState =
*spapr,
+static void rtas_ibm_read_pci_config(PowerPCCPU *cpu, SpaprMachineState =
*spapr,
                                      uint32_t token, uint32_t nargs,
                                      target_ulong args,
                                      uint32_t nret, target_ulong rets)
@@ -146,7 +146,7 @@ static void rtas_ibm_read_pci_config(PowerPCCPU *cpu,=
 sPAPRMachineState *spapr,
     finish_read_pci_config(spapr, buid, addr, size, rets);
 }
=20
-static void rtas_read_pci_config(PowerPCCPU *cpu, sPAPRMachineState *spa=
pr,
+static void rtas_read_pci_config(PowerPCCPU *cpu, SpaprMachineState *spa=
pr,
                                  uint32_t token, uint32_t nargs,
                                  target_ulong args,
                                  uint32_t nret, target_ulong rets)
@@ -164,7 +164,7 @@ static void rtas_read_pci_config(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
     finish_read_pci_config(spapr, 0, addr, size, rets);
 }
=20
-static void finish_write_pci_config(sPAPRMachineState *spapr, uint64_t b=
uid,
+static void finish_write_pci_config(SpaprMachineState *spapr, uint64_t b=
uid,
                                     uint32_t addr, uint32_t size,
                                     uint32_t val, target_ulong rets)
 {
@@ -192,7 +192,7 @@ static void finish_write_pci_config(sPAPRMachineState=
 *spapr, uint64_t buid,
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
-static void rtas_ibm_write_pci_config(PowerPCCPU *cpu, sPAPRMachineState=
 *spapr,
+static void rtas_ibm_write_pci_config(PowerPCCPU *cpu, SpaprMachineState=
 *spapr,
                                       uint32_t token, uint32_t nargs,
                                       target_ulong args,
                                       uint32_t nret, target_ulong rets)
@@ -213,7 +213,7 @@ static void rtas_ibm_write_pci_config(PowerPCCPU *cpu=
, sPAPRMachineState *spapr,
     finish_write_pci_config(spapr, buid, addr, size, val, rets);
 }
=20
-static void rtas_write_pci_config(PowerPCCPU *cpu, sPAPRMachineState *sp=
apr,
+static void rtas_write_pci_config(PowerPCCPU *cpu, SpaprMachineState *sp=
apr,
                                   uint32_t token, uint32_t nargs,
                                   target_ulong args,
                                   uint32_t nret, target_ulong rets)
@@ -262,12 +262,12 @@ static void spapr_msi_setmsg(PCIDevice *pdev, hwadd=
r addr, bool msix,
     }
 }
=20
-static void rtas_ibm_change_msi(PowerPCCPU *cpu, sPAPRMachineState *spap=
r,
+static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spap=
r,
                                 uint32_t token, uint32_t nargs,
                                 target_ulong args, uint32_t nret,
                                 target_ulong rets)
 {
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+    SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
     uint32_t config_addr =3D rtas_ld(args, 0);
     uint64_t buid =3D rtas_ldq(args, 1);
     unsigned int func =3D rtas_ld(args, 3);
@@ -275,14 +275,14 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, sP=
APRMachineState *spapr,
     unsigned int seq_num =3D rtas_ld(args, 5);
     unsigned int ret_intr_type;
     unsigned int irq, max_irqs =3D 0;
-    sPAPRPHBState *phb =3D NULL;
+    SpaprPhbState *phb =3D NULL;
     PCIDevice *pdev =3D NULL;
     spapr_pci_msi *msi;
     int *config_addr_key;
     Error *err =3D NULL;
     int i;
=20
-    /* Fins sPAPRPHBState */
+    /* Fins SpaprPhbState */
     phb =3D spapr_pci_find_phb(spapr, buid);
     if (phb) {
         pdev =3D spapr_pci_find_dev(spapr, buid, config_addr);
@@ -439,7 +439,7 @@ out:
 }
=20
 static void rtas_ibm_query_interrupt_source_number(PowerPCCPU *cpu,
-                                                   sPAPRMachineState *sp=
apr,
+                                                   SpaprMachineState *sp=
apr,
                                                    uint32_t token,
                                                    uint32_t nargs,
                                                    target_ulong args,
@@ -449,11 +449,11 @@ static void rtas_ibm_query_interrupt_source_number(=
PowerPCCPU *cpu,
     uint32_t config_addr =3D rtas_ld(args, 0);
     uint64_t buid =3D rtas_ldq(args, 1);
     unsigned int intr_src_num =3D -1, ioa_intr_num =3D rtas_ld(args, 3);
-    sPAPRPHBState *phb =3D NULL;
+    SpaprPhbState *phb =3D NULL;
     PCIDevice *pdev =3D NULL;
     spapr_pci_msi *msi;
=20
-    /* Find sPAPRPHBState */
+    /* Find SpaprPhbState */
     phb =3D spapr_pci_find_phb(spapr, buid);
     if (phb) {
         pdev =3D spapr_pci_find_dev(spapr, buid, config_addr);
@@ -480,12 +480,12 @@ static void rtas_ibm_query_interrupt_source_number(=
PowerPCCPU *cpu,
 }
=20
 static void rtas_ibm_set_eeh_option(PowerPCCPU *cpu,
-                                    sPAPRMachineState *spapr,
+                                    SpaprMachineState *spapr,
                                     uint32_t token, uint32_t nargs,
                                     target_ulong args, uint32_t nret,
                                     target_ulong rets)
 {
-    sPAPRPHBState *sphb;
+    SpaprPhbState *sphb;
     uint32_t addr, option;
     uint64_t buid;
     int ret;
@@ -516,12 +516,12 @@ param_error_exit:
 }
=20
 static void rtas_ibm_get_config_addr_info2(PowerPCCPU *cpu,
-                                           sPAPRMachineState *spapr,
+                                           SpaprMachineState *spapr,
                                            uint32_t token, uint32_t narg=
s,
                                            target_ulong args, uint32_t n=
ret,
                                            target_ulong rets)
 {
-    sPAPRPHBState *sphb;
+    SpaprPhbState *sphb;
     PCIDevice *pdev;
     uint32_t addr, option;
     uint64_t buid;
@@ -570,12 +570,12 @@ param_error_exit:
 }
=20
 static void rtas_ibm_read_slot_reset_state2(PowerPCCPU *cpu,
-                                            sPAPRMachineState *spapr,
+                                            SpaprMachineState *spapr,
                                             uint32_t token, uint32_t nar=
gs,
                                             target_ulong args, uint32_t =
nret,
                                             target_ulong rets)
 {
-    sPAPRPHBState *sphb;
+    SpaprPhbState *sphb;
     uint64_t buid;
     int state, ret;
=20
@@ -612,12 +612,12 @@ param_error_exit:
 }
=20
 static void rtas_ibm_set_slot_reset(PowerPCCPU *cpu,
-                                    sPAPRMachineState *spapr,
+                                    SpaprMachineState *spapr,
                                     uint32_t token, uint32_t nargs,
                                     target_ulong args, uint32_t nret,
                                     target_ulong rets)
 {
-    sPAPRPHBState *sphb;
+    SpaprPhbState *sphb;
     uint32_t option;
     uint64_t buid;
     int ret;
@@ -646,12 +646,12 @@ param_error_exit:
 }
=20
 static void rtas_ibm_configure_pe(PowerPCCPU *cpu,
-                                  sPAPRMachineState *spapr,
+                                  SpaprMachineState *spapr,
                                   uint32_t token, uint32_t nargs,
                                   target_ulong args, uint32_t nret,
                                   target_ulong rets)
 {
-    sPAPRPHBState *sphb;
+    SpaprPhbState *sphb;
     uint64_t buid;
     int ret;
=20
@@ -679,12 +679,12 @@ param_error_exit:
=20
 /* To support it later */
 static void rtas_ibm_slot_error_detail(PowerPCCPU *cpu,
-                                       sPAPRMachineState *spapr,
+                                       SpaprMachineState *spapr,
                                        uint32_t token, uint32_t nargs,
                                        target_ulong args, uint32_t nret,
                                        target_ulong rets)
 {
-    sPAPRPHBState *sphb;
+    SpaprPhbState *sphb;
     int option;
     uint64_t buid;
=20
@@ -741,7 +741,7 @@ static void pci_spapr_set_irq(void *opaque, int irq_n=
um, int level)
      * Here we use the number returned by pci_spapr_map_irq to find a
      * corresponding qemu_irq.
      */
-    sPAPRPHBState *phb =3D opaque;
+    SpaprPhbState *phb =3D opaque;
=20
     trace_spapr_pci_lsi_set(phb->dtbusname, irq_num, phb->lsi_table[irq_=
num].irq);
     qemu_set_irq(spapr_phb_lsi_qirq(phb, irq_num), level);
@@ -749,7 +749,7 @@ static void pci_spapr_set_irq(void *opaque, int irq_n=
um, int level)
=20
 static PCIINTxRoute spapr_route_intx_pin_to_irq(void *opaque, int pin)
 {
-    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(opaque);
+    SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(opaque);
     PCIINTxRoute route;
=20
     route.mode =3D PCI_INTX_ENABLED;
@@ -766,7 +766,7 @@ static PCIINTxRoute spapr_route_intx_pin_to_irq(void =
*opaque, int pin)
 static void spapr_msi_write(void *opaque, hwaddr addr,
                             uint64_t data, unsigned size)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
     uint32_t irq =3D data;
=20
     trace_spapr_pci_msi_write(addr, data, irq);
@@ -786,12 +786,12 @@ static const MemoryRegionOps spapr_msi_ops =3D {
  */
 static AddressSpace *spapr_pci_dma_iommu(PCIBus *bus, void *opaque, int =
devfn)
 {
-    sPAPRPHBState *phb =3D opaque;
+    SpaprPhbState *phb =3D opaque;
=20
     return &phb->iommu_as;
 }
=20
-static char *spapr_phb_vfio_get_loc_code(sPAPRPHBState *sphb,  PCIDevice=
 *pdev)
+static char *spapr_phb_vfio_get_loc_code(SpaprPhbState *sphb,  PCIDevice=
 *pdev)
 {
     char *path =3D NULL, *buf =3D NULL, *host =3D NULL;
=20
@@ -822,7 +822,7 @@ err_out:
     return NULL;
 }
=20
-static char *spapr_phb_get_loc_code(sPAPRPHBState *sphb, PCIDevice *pdev=
)
+static char *spapr_phb_get_loc_code(SpaprPhbState *sphb, PCIDevice *pdev=
)
 {
     char *buf;
     const char *devtype =3D "qemu";
@@ -1249,11 +1249,11 @@ static gchar *pci_get_node_name(PCIDevice *dev)
     }
 }
=20
-static uint32_t spapr_phb_get_pci_drc_index(sPAPRPHBState *phb,
+static uint32_t spapr_phb_get_pci_drc_index(SpaprPhbState *phb,
                                             PCIDevice *pdev);
=20
 static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int o=
ffset,
-                                       sPAPRPHBState *sphb)
+                                       SpaprPhbState *sphb)
 {
     ResourceProps rp;
     bool is_bridge =3D false;
@@ -1358,7 +1358,7 @@ static void spapr_populate_pci_child_dt(PCIDevice *=
dev, void *fdt, int offset,
 }
=20
 /* create OF node for pci device and required OF DT properties */
-static int spapr_create_pci_child_dt(sPAPRPHBState *phb, PCIDevice *dev,
+static int spapr_create_pci_child_dt(SpaprPhbState *phb, PCIDevice *dev,
                                      void *fdt, int node_offset)
 {
     int offset;
@@ -1382,7 +1382,7 @@ void spapr_phb_remove_pci_device_cb(DeviceState *de=
v)
     object_unparent(OBJECT(dev));
 }
=20
-static sPAPRDRConnector *spapr_phb_get_pci_func_drc(sPAPRPHBState *phb,
+static SpaprDrc *spapr_phb_get_pci_func_drc(SpaprPhbState *phb,
                                                     uint32_t busnr,
                                                     int32_t devfn)
 {
@@ -1390,17 +1390,17 @@ static sPAPRDRConnector *spapr_phb_get_pci_func_d=
rc(sPAPRPHBState *phb,
                            (phb->index << 16) | (busnr << 8) | devfn);
 }
=20
-static sPAPRDRConnector *spapr_phb_get_pci_drc(sPAPRPHBState *phb,
+static SpaprDrc *spapr_phb_get_pci_drc(SpaprPhbState *phb,
                                                PCIDevice *pdev)
 {
     uint32_t busnr =3D pci_bus_num(PCI_BUS(qdev_get_parent_bus(DEVICE(pd=
ev))));
     return spapr_phb_get_pci_func_drc(phb, busnr, pdev->devfn);
 }
=20
-static uint32_t spapr_phb_get_pci_drc_index(sPAPRPHBState *phb,
+static uint32_t spapr_phb_get_pci_drc_index(SpaprPhbState *phb,
                                             PCIDevice *pdev)
 {
-    sPAPRDRConnector *drc =3D spapr_phb_get_pci_drc(phb, pdev);
+    SpaprDrc *drc =3D spapr_phb_get_pci_drc(phb, pdev);
=20
     if (!drc) {
         return 0;
@@ -1409,11 +1409,11 @@ static uint32_t spapr_phb_get_pci_drc_index(sPAPR=
PHBState *phb,
     return spapr_drc_index(drc);
 }
=20
-int spapr_pci_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spap=
r,
+int spapr_pci_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp=
)
 {
     HotplugHandler *plug_handler =3D qdev_get_hotplug_handler(drc->dev);
-    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(plug_handler);
+    SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(plug_handler);
     PCIDevice *pdev =3D PCI_DEVICE(drc->dev);
=20
     *fdt_start_offset =3D spapr_create_pci_child_dt(sphb, pdev, fdt, 0);
@@ -1423,9 +1423,9 @@ int spapr_pci_dt_populate(sPAPRDRConnector *drc, sP=
APRMachineState *spapr,
 static void spapr_pci_plug(HotplugHandler *plug_handler,
                            DeviceState *plugged_dev, Error **errp)
 {
-    sPAPRPHBState *phb =3D SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
+    SpaprPhbState *phb =3D SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
     PCIDevice *pdev =3D PCI_DEVICE(plugged_dev);
-    sPAPRDRConnector *drc =3D spapr_phb_get_pci_drc(phb, pdev);
+    SpaprDrc *drc =3D spapr_phb_get_pci_drc(phb, pdev);
     Error *local_err =3D NULL;
     PCIBus *bus =3D PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
     uint32_t slotnr =3D PCI_SLOT(pdev->devfn);
@@ -1472,9 +1472,9 @@ static void spapr_pci_plug(HotplugHandler *plug_han=
dler,
         int i;
=20
         for (i =3D 0; i < 8; i++) {
-            sPAPRDRConnector *func_drc;
-            sPAPRDRConnectorClass *func_drck;
-            sPAPRDREntitySense state;
+            SpaprDrc *func_drc;
+            SpaprDrcClass *func_drck;
+            SpaprDREntitySense state;
=20
             func_drc =3D spapr_phb_get_pci_func_drc(phb, pci_bus_num(bus=
),
                                                   PCI_DEVFN(slotnr, i));
@@ -1513,9 +1513,9 @@ static void spapr_pci_unplug(HotplugHandler *plug_h=
andler,
 static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
                                      DeviceState *plugged_dev, Error **e=
rrp)
 {
-    sPAPRPHBState *phb =3D SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
+    SpaprPhbState *phb =3D SPAPR_PCI_HOST_BRIDGE(DEVICE(plug_handler));
     PCIDevice *pdev =3D PCI_DEVICE(plugged_dev);
-    sPAPRDRConnector *drc =3D spapr_phb_get_pci_drc(phb, pdev);
+    SpaprDrc *drc =3D spapr_phb_get_pci_drc(phb, pdev);
=20
     if (!phb->dr_enabled) {
         error_setg(errp, QERR_BUS_NO_HOTPLUG,
@@ -1529,9 +1529,9 @@ static void spapr_pci_unplug_request(HotplugHandler=
 *plug_handler,
     if (!spapr_drc_unplug_requested(drc)) {
         PCIBus *bus =3D PCI_BUS(qdev_get_parent_bus(DEVICE(pdev)));
         uint32_t slotnr =3D PCI_SLOT(pdev->devfn);
-        sPAPRDRConnector *func_drc;
-        sPAPRDRConnectorClass *func_drck;
-        sPAPRDREntitySense state;
+        SpaprDrc *func_drc;
+        SpaprDrcClass *func_drck;
+        SpaprDREntitySense state;
         int i;
=20
         /* ensure any other present functions are pending unplug */
@@ -1573,7 +1573,7 @@ static void spapr_pci_unplug_request(HotplugHandler=
 *plug_handler,
=20
 static void spapr_phb_finalizefn(Object *obj)
 {
-    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(obj);
+    SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(obj);
=20
     g_free(sphb->dtbusname);
     sphb->dtbusname =3D NULL;
@@ -1581,11 +1581,11 @@ static void spapr_phb_finalizefn(Object *obj)
=20
 static void spapr_phb_unrealize(DeviceState *dev, Error **errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
     SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
     PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
-    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(phb);
-    sPAPRTCETable *tcet;
+    SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(phb);
+    SpaprTceTable *tcet;
     int i;
     const unsigned windows_supported =3D spapr_phb_windows_supported(sph=
b);
=20
@@ -1608,7 +1608,7 @@ static void spapr_phb_unrealize(DeviceState *dev, E=
rror **errp)
=20
     if (sphb->dr_enabled) {
         for (i =3D PCI_SLOT_MAX * 8 - 1; i >=3D 0; i--) {
-            sPAPRDRConnector *drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PCI=
,
+            SpaprDrc *drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PCI,
                                                     (sphb->index << 16) =
| i);
=20
             if (drc) {
@@ -1645,18 +1645,18 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
     /* We don't use SPAPR_MACHINE() in order to exit gracefully if the u=
ser
      * tries to add a sPAPR PHB to a non-pseries machine.
      */
-    sPAPRMachineState *spapr =3D
-        (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
+    SpaprMachineState *spapr =3D
+        (SpaprMachineState *) object_dynamic_cast(qdev_get_machine(),
                                                   TYPE_SPAPR_MACHINE);
-    sPAPRMachineClass *smc =3D spapr ? SPAPR_MACHINE_GET_CLASS(spapr) : =
NULL;
+    SpaprMachineClass *smc =3D spapr ? SPAPR_MACHINE_GET_CLASS(spapr) : =
NULL;
     SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
-    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(s);
+    SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(s);
     PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
     char *namebuf;
     int i;
     PCIBus *bus;
     uint64_t msi_window_size =3D 4096;
-    sPAPRTCETable *tcet;
+    SpaprTceTable *tcet;
     const unsigned windows_supported =3D spapr_phb_windows_supported(sph=
b);
=20
     if (!spapr) {
@@ -1855,10 +1855,10 @@ static int spapr_phb_children_reset(Object *child=
, void *opaque)
     return 0;
 }
=20
-void spapr_phb_dma_reset(sPAPRPHBState *sphb)
+void spapr_phb_dma_reset(SpaprPhbState *sphb)
 {
     int i;
-    sPAPRTCETable *tcet;
+    SpaprTceTable *tcet;
=20
     for (i =3D 0; i < SPAPR_PCI_DMA_MAX_WINDOWS; ++i) {
         tcet =3D spapr_tce_find_by_liobn(sphb->dma_liobn[i]);
@@ -1876,7 +1876,7 @@ void spapr_phb_dma_reset(sPAPRPHBState *sphb)
=20
 static void spapr_phb_reset(DeviceState *qdev)
 {
-    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(qdev);
+    SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(qdev);
=20
     spapr_phb_dma_reset(sphb);
=20
@@ -1889,27 +1889,27 @@ static void spapr_phb_reset(DeviceState *qdev)
 }
=20
 static Property spapr_phb_properties[] =3D {
-    DEFINE_PROP_UINT32("index", sPAPRPHBState, index, -1),
-    DEFINE_PROP_UINT64("mem_win_size", sPAPRPHBState, mem_win_size,
+    DEFINE_PROP_UINT32("index", SpaprPhbState, index, -1),
+    DEFINE_PROP_UINT64("mem_win_size", SpaprPhbState, mem_win_size,
                        SPAPR_PCI_MEM32_WIN_SIZE),
-    DEFINE_PROP_UINT64("mem64_win_size", sPAPRPHBState, mem64_win_size,
+    DEFINE_PROP_UINT64("mem64_win_size", SpaprPhbState, mem64_win_size,
                        SPAPR_PCI_MEM64_WIN_SIZE),
-    DEFINE_PROP_UINT64("io_win_size", sPAPRPHBState, io_win_size,
+    DEFINE_PROP_UINT64("io_win_size", SpaprPhbState, io_win_size,
                        SPAPR_PCI_IO_WIN_SIZE),
-    DEFINE_PROP_BOOL("dynamic-reconfiguration", sPAPRPHBState, dr_enable=
d,
+    DEFINE_PROP_BOOL("dynamic-reconfiguration", SpaprPhbState, dr_enable=
d,
                      true),
     /* Default DMA window is 0..1GB */
-    DEFINE_PROP_UINT64("dma_win_addr", sPAPRPHBState, dma_win_addr, 0),
-    DEFINE_PROP_UINT64("dma_win_size", sPAPRPHBState, dma_win_size, 0x40=
000000),
-    DEFINE_PROP_UINT64("dma64_win_addr", sPAPRPHBState, dma64_win_addr,
+    DEFINE_PROP_UINT64("dma_win_addr", SpaprPhbState, dma_win_addr, 0),
+    DEFINE_PROP_UINT64("dma_win_size", SpaprPhbState, dma_win_size, 0x40=
000000),
+    DEFINE_PROP_UINT64("dma64_win_addr", SpaprPhbState, dma64_win_addr,
                        0x800000000000000ULL),
-    DEFINE_PROP_BOOL("ddw", sPAPRPHBState, ddw_enabled, true),
-    DEFINE_PROP_UINT64("pgsz", sPAPRPHBState, page_size_mask,
+    DEFINE_PROP_BOOL("ddw", SpaprPhbState, ddw_enabled, true),
+    DEFINE_PROP_UINT64("pgsz", SpaprPhbState, page_size_mask,
                        (1ULL << 12) | (1ULL << 16)),
-    DEFINE_PROP_UINT32("numa_node", sPAPRPHBState, numa_node, -1),
-    DEFINE_PROP_BOOL("pre-2.8-migration", sPAPRPHBState,
+    DEFINE_PROP_UINT32("numa_node", SpaprPhbState, numa_node, -1),
+    DEFINE_PROP_BOOL("pre-2.8-migration", SpaprPhbState,
                      pre_2_8_migration, false),
-    DEFINE_PROP_BOOL("pcie-extended-configuration-space", sPAPRPHBState,
+    DEFINE_PROP_BOOL("pcie-extended-configuration-space", SpaprPhbState,
                      pcie_ecs, true),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -1939,7 +1939,7 @@ static const VMStateDescription vmstate_spapr_pci_m=
si =3D {
=20
 static int spapr_pci_pre_save(void *opaque)
 {
-    sPAPRPHBState *sphb =3D opaque;
+    SpaprPhbState *sphb =3D opaque;
     GHashTableIter iter;
     gpointer key, value;
     int i;
@@ -1977,7 +1977,7 @@ static int spapr_pci_pre_save(void *opaque)
=20
 static int spapr_pci_post_load(void *opaque, int version_id)
 {
-    sPAPRPHBState *sphb =3D opaque;
+    SpaprPhbState *sphb =3D opaque;
     gpointer key, value;
     int i;
=20
@@ -1997,7 +1997,7 @@ static int spapr_pci_post_load(void *opaque, int ve=
rsion_id)
=20
 static bool pre_2_8_migration(void *opaque, int version_id)
 {
-    sPAPRPHBState *sphb =3D opaque;
+    SpaprPhbState *sphb =3D opaque;
=20
     return sphb->pre_2_8_migration;
 }
@@ -2009,16 +2009,16 @@ static const VMStateDescription vmstate_spapr_pci=
 =3D {
     .pre_save =3D spapr_pci_pre_save,
     .post_load =3D spapr_pci_post_load,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT64_EQUAL(buid, sPAPRPHBState, NULL),
-        VMSTATE_UINT32_TEST(mig_liobn, sPAPRPHBState, pre_2_8_migration)=
,
-        VMSTATE_UINT64_TEST(mig_mem_win_addr, sPAPRPHBState, pre_2_8_mig=
ration),
-        VMSTATE_UINT64_TEST(mig_mem_win_size, sPAPRPHBState, pre_2_8_mig=
ration),
-        VMSTATE_UINT64_TEST(mig_io_win_addr, sPAPRPHBState, pre_2_8_migr=
ation),
-        VMSTATE_UINT64_TEST(mig_io_win_size, sPAPRPHBState, pre_2_8_migr=
ation),
-        VMSTATE_STRUCT_ARRAY(lsi_table, sPAPRPHBState, PCI_NUM_PINS, 0,
+        VMSTATE_UINT64_EQUAL(buid, SpaprPhbState, NULL),
+        VMSTATE_UINT32_TEST(mig_liobn, SpaprPhbState, pre_2_8_migration)=
,
+        VMSTATE_UINT64_TEST(mig_mem_win_addr, SpaprPhbState, pre_2_8_mig=
ration),
+        VMSTATE_UINT64_TEST(mig_mem_win_size, SpaprPhbState, pre_2_8_mig=
ration),
+        VMSTATE_UINT64_TEST(mig_io_win_addr, SpaprPhbState, pre_2_8_migr=
ation),
+        VMSTATE_UINT64_TEST(mig_io_win_size, SpaprPhbState, pre_2_8_migr=
ation),
+        VMSTATE_STRUCT_ARRAY(lsi_table, SpaprPhbState, PCI_NUM_PINS, 0,
                              vmstate_spapr_pci_lsi, struct spapr_pci_lsi=
),
-        VMSTATE_INT32(msi_devs_num, sPAPRPHBState),
-        VMSTATE_STRUCT_VARRAY_ALLOC(msi_devs, sPAPRPHBState, msi_devs_nu=
m, 0,
+        VMSTATE_INT32(msi_devs_num, SpaprPhbState),
+        VMSTATE_STRUCT_VARRAY_ALLOC(msi_devs, SpaprPhbState, msi_devs_nu=
m, 0,
                                     vmstate_spapr_pci_msi, spapr_pci_msi=
_mig),
         VMSTATE_END_OF_LIST()
     },
@@ -2027,7 +2027,7 @@ static const VMStateDescription vmstate_spapr_pci =3D=
 {
 static const char *spapr_phb_root_bus_path(PCIHostState *host_bridge,
                                            PCIBus *rootbus)
 {
-    sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(host_bridge);
+    SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(host_bridge);
=20
     return sphb->dtbusname;
 }
@@ -2055,7 +2055,7 @@ static void spapr_phb_class_init(ObjectClass *klass=
, void *data)
 static const TypeInfo spapr_phb_info =3D {
     .name          =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
     .parent        =3D TYPE_PCI_HOST_BRIDGE,
-    .instance_size =3D sizeof(sPAPRPHBState),
+    .instance_size =3D sizeof(SpaprPhbState),
     .instance_finalize =3D spapr_phb_finalizefn,
     .class_init    =3D spapr_phb_class_init,
     .interfaces    =3D (InterfaceInfo[]) {
@@ -2064,19 +2064,19 @@ static const TypeInfo spapr_phb_info =3D {
     }
 };
=20
-typedef struct sPAPRFDT {
+typedef struct SpaprFdt {
     void *fdt;
     int node_off;
-    sPAPRPHBState *sphb;
-} sPAPRFDT;
+    SpaprPhbState *sphb;
+} SpaprFdt;
=20
 static void spapr_populate_pci_devices_dt(PCIBus *bus, PCIDevice *pdev,
                                           void *opaque)
 {
     PCIBus *sec_bus;
-    sPAPRFDT *p =3D opaque;
+    SpaprFdt *p =3D opaque;
     int offset;
-    sPAPRFDT s_fdt;
+    SpaprFdt s_fdt;
=20
     offset =3D spapr_create_pci_child_dt(p->sphb, pdev, p->fdt, p->node_=
off);
     if (!offset) {
@@ -2128,7 +2128,7 @@ static void spapr_phb_pci_enumerate_bridge(PCIBus *=
bus, PCIDevice *pdev,
     pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, *bus_no, 1);
 }
=20
-static void spapr_phb_pci_enumerate(sPAPRPHBState *phb)
+static void spapr_phb_pci_enumerate(SpaprPhbState *phb)
 {
     PCIBus *bus =3D PCI_HOST_BRIDGE(phb)->bus;
     unsigned int bus_no =3D 0;
@@ -2139,7 +2139,7 @@ static void spapr_phb_pci_enumerate(sPAPRPHBState *=
phb)
=20
 }
=20
-int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, voi=
d *fdt,
+int spapr_populate_pci_dt(SpaprPhbState *phb, uint32_t intc_phandle, voi=
d *fdt,
                           uint32_t nr_msis, int *node_offset)
 {
     int bus_off, i, j, ret;
@@ -2187,10 +2187,10 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb, uin=
t32_t intc_phandle, void *fdt,
                                 cpu_to_be32(0x0),
                                 cpu_to_be32(0x0),
                                 cpu_to_be32(phb->numa_node)};
-    sPAPRTCETable *tcet;
+    SpaprTceTable *tcet;
     PCIBus *bus =3D PCI_HOST_BRIDGE(phb)->bus;
-    sPAPRFDT s_fdt;
-    sPAPRDRConnector *drc;
+    SpaprFdt s_fdt;
+    SpaprDrc *drc;
=20
     /* Start populating the FDT */
     nodename =3D g_strdup_printf("pci@%" PRIx64, phb->buid);
@@ -2345,8 +2345,8 @@ static int spapr_switch_one_vga(DeviceState *dev, v=
oid *opaque)
=20
 void spapr_pci_switch_vga(bool big_endian)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
-    sPAPRPHBState *sphb;
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    SpaprPhbState *sphb;
=20
     /*
      * For backward compatibility with existing guests, we switch
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index 71491dbd28..5f5dde567d 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -28,12 +28,12 @@
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
=20
-bool spapr_phb_eeh_available(sPAPRPHBState *sphb)
+bool spapr_phb_eeh_available(SpaprPhbState *sphb)
 {
     return vfio_eeh_as_ok(&sphb->iommu_as);
 }
=20
-static void spapr_phb_vfio_eeh_reenable(sPAPRPHBState *sphb)
+static void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb)
 {
     vfio_eeh_as_op(&sphb->iommu_as, VFIO_EEH_PE_ENABLE);
 }
@@ -49,7 +49,7 @@ void spapr_phb_vfio_reset(DeviceState *qdev)
     spapr_phb_vfio_eeh_reenable(SPAPR_PCI_HOST_BRIDGE(qdev));
 }
=20
-int spapr_phb_vfio_eeh_set_option(sPAPRPHBState *sphb,
+int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
                                   unsigned int addr, int option)
 {
     uint32_t op;
@@ -96,7 +96,7 @@ int spapr_phb_vfio_eeh_set_option(sPAPRPHBState *sphb,
     return RTAS_OUT_SUCCESS;
 }
=20
-int spapr_phb_vfio_eeh_get_state(sPAPRPHBState *sphb, int *state)
+int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
 {
     int ret;
=20
@@ -145,14 +145,14 @@ static void spapr_phb_vfio_eeh_clear_bus_msix(PCIBu=
s *bus, void *opaque)
                            spapr_phb_vfio_eeh_clear_dev_msix, NULL);
 }
=20
-static void spapr_phb_vfio_eeh_pre_reset(sPAPRPHBState *sphb)
+static void spapr_phb_vfio_eeh_pre_reset(SpaprPhbState *sphb)
 {
        PCIHostState *phb =3D PCI_HOST_BRIDGE(sphb);
=20
        pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_clear_bus_msix, NUL=
L);
 }
=20
-int spapr_phb_vfio_eeh_reset(sPAPRPHBState *sphb, int option)
+int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
 {
     uint32_t op;
     int ret;
@@ -181,7 +181,7 @@ int spapr_phb_vfio_eeh_reset(sPAPRPHBState *sphb, int=
 option)
     return RTAS_OUT_SUCCESS;
 }
=20
-int spapr_phb_vfio_eeh_configure(sPAPRPHBState *sphb)
+int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
 {
     int ret;
=20
diff --git a/hw/ppc/spapr_rng.c b/hw/ppc/spapr_rng.c
index 644bac96f8..4060987590 100644
--- a/hw/ppc/spapr_rng.c
+++ b/hw/ppc/spapr_rng.c
@@ -29,15 +29,15 @@
 #include "kvm_ppc.h"
=20
 #define SPAPR_RNG(obj) \
-    OBJECT_CHECK(sPAPRRngState, (obj), TYPE_SPAPR_RNG)
+    OBJECT_CHECK(SpaprRngState, (obj), TYPE_SPAPR_RNG)
=20
-struct sPAPRRngState {
+struct SpaprRngState {
     /*< private >*/
     DeviceState ds;
     RngBackend *backend;
     bool use_kvm;
 };
-typedef struct sPAPRRngState sPAPRRngState;
+typedef struct SpaprRngState SpaprRngState;
=20
 struct HRandomData {
     QemuSemaphore sem;
@@ -64,10 +64,10 @@ static void random_recv(void *dest, const void *src, =
size_t size)
 }
=20
 /* Handler for the H_RANDOM hypercall */
-static target_ulong h_random(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_random(PowerPCCPU *cpu, SpaprMachineState *spapr,
                              target_ulong opcode, target_ulong *args)
 {
-    sPAPRRngState *rngstate;
+    SpaprRngState *rngstate;
     HRandomData hrdata;
=20
     rngstate =3D SPAPR_RNG(object_resolve_path_type("", TYPE_SPAPR_RNG, =
NULL));
@@ -109,7 +109,7 @@ static void spapr_rng_instance_init(Object *obj)
 static void spapr_rng_realize(DeviceState *dev, Error **errp)
 {
=20
-    sPAPRRngState *rngstate =3D SPAPR_RNG(dev);
+    SpaprRngState *rngstate =3D SPAPR_RNG(dev);
=20
     if (rngstate->use_kvm) {
         if (kvmppc_enable_hwrng() =3D=3D 0) {
@@ -133,8 +133,8 @@ static void spapr_rng_realize(DeviceState *dev, Error=
 **errp)
 }
=20
 static Property spapr_rng_properties[] =3D {
-    DEFINE_PROP_BOOL("use-kvm", sPAPRRngState, use_kvm, false),
-    DEFINE_PROP_LINK("rng", sPAPRRngState, backend, TYPE_RNG_BACKEND,
+    DEFINE_PROP_BOOL("use-kvm", SpaprRngState, use_kvm, false),
+    DEFINE_PROP_LINK("rng", SpaprRngState, backend, TYPE_RNG_BACKEND,
                      RngBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -152,7 +152,7 @@ static void spapr_rng_class_init(ObjectClass *oc, voi=
d *data)
 static const TypeInfo spapr_rng_info =3D {
     .name          =3D TYPE_SPAPR_RNG,
     .parent        =3D TYPE_DEVICE,
-    .instance_size =3D sizeof(sPAPRRngState),
+    .instance_size =3D sizeof(SpaprRngState),
     .instance_init =3D spapr_rng_instance_init,
     .class_init    =3D spapr_rng_class_init,
 };
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 7a2cb786a3..24c45b12d4 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -50,13 +50,13 @@
 #include "target/ppc/mmu-hash64.h"
 #include "target/ppc/mmu-book3s-v3.h"
=20
-static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
+static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *s=
papr,
                                    uint32_t token, uint32_t nargs,
                                    target_ulong args,
                                    uint32_t nret, target_ulong rets)
 {
     uint8_t c =3D rtas_ld(args, 0);
-    VIOsPAPRDevice *sdev =3D vty_lookup(spapr, 0);
+    SpaprVioDevice *sdev =3D vty_lookup(spapr, 0);
=20
     if (!sdev) {
         rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
@@ -66,7 +66,7 @@ static void rtas_display_character(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
     }
 }
=20
-static void rtas_power_off(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static void rtas_power_off(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            uint32_t token, uint32_t nargs, target_ulong =
args,
                            uint32_t nret, target_ulong rets)
 {
@@ -79,7 +79,7 @@ static void rtas_power_off(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
-static void rtas_system_reboot(PowerPCCPU *cpu, sPAPRMachineState *spapr=
,
+static void rtas_system_reboot(PowerPCCPU *cpu, SpaprMachineState *spapr=
,
                                uint32_t token, uint32_t nargs,
                                target_ulong args,
                                uint32_t nret, target_ulong rets)
@@ -93,7 +93,7 @@ static void rtas_system_reboot(PowerPCCPU *cpu, sPAPRMa=
chineState *spapr,
 }
=20
 static void rtas_query_cpu_stopped_state(PowerPCCPU *cpu_,
-                                         sPAPRMachineState *spapr,
+                                         SpaprMachineState *spapr,
                                          uint32_t token, uint32_t nargs,
                                          target_ulong args,
                                          uint32_t nret, target_ulong ret=
s)
@@ -123,7 +123,7 @@ static void rtas_query_cpu_stopped_state(PowerPCCPU *=
cpu_,
     rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
 }
=20
-static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPRMachineState *spapr=
,
+static void rtas_start_cpu(PowerPCCPU *callcpu, SpaprMachineState *spapr=
,
                            uint32_t token, uint32_t nargs,
                            target_ulong args,
                            uint32_t nret, target_ulong rets)
@@ -194,7 +194,7 @@ static void rtas_start_cpu(PowerPCCPU *callcpu, sPAPR=
MachineState *spapr,
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
-static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static void rtas_stop_self(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            uint32_t token, uint32_t nargs,
                            target_ulong args,
                            uint32_t nret, target_ulong rets)
@@ -226,7 +226,7 @@ static inline int sysparm_st(target_ulong addr, targe=
t_ulong len,
 }
=20
 static void rtas_ibm_get_system_parameter(PowerPCCPU *cpu,
-                                          sPAPRMachineState *spapr,
+                                          SpaprMachineState *spapr,
                                           uint32_t token, uint32_t nargs=
,
                                           target_ulong args,
                                           uint32_t nret, target_ulong re=
ts)
@@ -268,7 +268,7 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU =
*cpu,
 }
=20
 static void rtas_ibm_set_system_parameter(PowerPCCPU *cpu,
-                                          sPAPRMachineState *spapr,
+                                          SpaprMachineState *spapr,
                                           uint32_t token, uint32_t nargs=
,
                                           target_ulong args,
                                           uint32_t nret, target_ulong re=
ts)
@@ -288,7 +288,7 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU =
*cpu,
 }
=20
 static void rtas_ibm_os_term(PowerPCCPU *cpu,
-                            sPAPRMachineState *spapr,
+                            SpaprMachineState *spapr,
                             uint32_t token, uint32_t nargs,
                             target_ulong args,
                             uint32_t nret, target_ulong rets)
@@ -298,7 +298,7 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
-static void rtas_set_power_level(PowerPCCPU *cpu, sPAPRMachineState *spa=
pr,
+static void rtas_set_power_level(PowerPCCPU *cpu, SpaprMachineState *spa=
pr,
                                  uint32_t token, uint32_t nargs,
                                  target_ulong args, uint32_t nret,
                                  target_ulong rets)
@@ -323,7 +323,7 @@ static void rtas_set_power_level(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
     rtas_st(rets, 1, 100);
 }
=20
-static void rtas_get_power_level(PowerPCCPU *cpu, sPAPRMachineState *spa=
pr,
+static void rtas_get_power_level(PowerPCCPU *cpu, SpaprMachineState *spa=
pr,
                                   uint32_t token, uint32_t nargs,
                                   target_ulong args, uint32_t nret,
                                   target_ulong rets)
@@ -353,7 +353,7 @@ static struct rtas_call {
     spapr_rtas_fn fn;
 } rtas_table[RTAS_TOKEN_MAX - RTAS_TOKEN_BASE];
=20
-target_ulong spapr_rtas_call(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+target_ulong spapr_rtas_call(PowerPCCPU *cpu, SpaprMachineState *spapr,
                              uint32_t token, uint32_t nargs, target_ulon=
g args,
                              uint32_t nret, target_ulong rets)
 {
@@ -387,7 +387,7 @@ uint64_t qtest_rtas_call(char *cmd, uint32_t nargs, u=
int64_t args,
=20
     for (token =3D 0; token < RTAS_TOKEN_MAX - RTAS_TOKEN_BASE; token++)=
 {
         if (strcmp(cmd, rtas_table[token].name) =3D=3D 0) {
-            sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine(=
));
+            SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine(=
));
             PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
=20
             rtas_table[token].fn(cpu, spapr, token + RTAS_TOKEN_BASE,
@@ -425,7 +425,7 @@ void spapr_dt_rtas_tokens(void *fdt, int rtas)
     }
 }
=20
-void spapr_load_rtas(sPAPRMachineState *spapr, void *fdt, hwaddr addr)
+void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr)
 {
     int rtas_node;
     int ret;
diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
index cc9d1f5c1c..f6538189f4 100644
--- a/hw/ppc/spapr_rtas_ddw.c
+++ b/hw/ppc/spapr_rtas_ddw.c
@@ -26,16 +26,16 @@
=20
 static int spapr_phb_get_active_win_num_cb(Object *child, void *opaque)
 {
-    sPAPRTCETable *tcet;
+    SpaprTceTable *tcet;
=20
-    tcet =3D (sPAPRTCETable *) object_dynamic_cast(child, TYPE_SPAPR_TCE=
_TABLE);
+    tcet =3D (SpaprTceTable *) object_dynamic_cast(child, TYPE_SPAPR_TCE=
_TABLE);
     if (tcet && tcet->nb_table) {
         ++*(unsigned *)opaque;
     }
     return 0;
 }
=20
-static unsigned spapr_phb_get_active_win_num(sPAPRPHBState *sphb)
+static unsigned spapr_phb_get_active_win_num(SpaprPhbState *sphb)
 {
     unsigned ret =3D 0;
=20
@@ -46,9 +46,9 @@ static unsigned spapr_phb_get_active_win_num(sPAPRPHBSt=
ate *sphb)
=20
 static int spapr_phb_get_free_liobn_cb(Object *child, void *opaque)
 {
-    sPAPRTCETable *tcet;
+    SpaprTceTable *tcet;
=20
-    tcet =3D (sPAPRTCETable *) object_dynamic_cast(child, TYPE_SPAPR_TCE=
_TABLE);
+    tcet =3D (SpaprTceTable *) object_dynamic_cast(child, TYPE_SPAPR_TCE=
_TABLE);
     if (tcet && !tcet->nb_table) {
         *(uint32_t *)opaque =3D tcet->liobn;
         return 1;
@@ -56,7 +56,7 @@ static int spapr_phb_get_free_liobn_cb(Object *child, v=
oid *opaque)
     return 0;
 }
=20
-static unsigned spapr_phb_get_free_liobn(sPAPRPHBState *sphb)
+static unsigned spapr_phb_get_free_liobn(SpaprPhbState *sphb)
 {
     uint32_t liobn =3D 0;
=20
@@ -90,12 +90,12 @@ static uint32_t spapr_page_mask_to_query_mask(uint64_=
t page_mask)
 }
=20
 static void rtas_ibm_query_pe_dma_window(PowerPCCPU *cpu,
-                                         sPAPRMachineState *spapr,
+                                         SpaprMachineState *spapr,
                                          uint32_t token, uint32_t nargs,
                                          target_ulong args,
                                          uint32_t nret, target_ulong ret=
s)
 {
-    sPAPRPHBState *sphb;
+    SpaprPhbState *sphb;
     uint64_t buid;
     uint32_t avail, addr, pgmask =3D 0;
=20
@@ -129,13 +129,13 @@ param_error_exit:
 }
=20
 static void rtas_ibm_create_pe_dma_window(PowerPCCPU *cpu,
-                                          sPAPRMachineState *spapr,
+                                          SpaprMachineState *spapr,
                                           uint32_t token, uint32_t nargs=
,
                                           target_ulong args,
                                           uint32_t nret, target_ulong re=
ts)
 {
-    sPAPRPHBState *sphb;
-    sPAPRTCETable *tcet =3D NULL;
+    SpaprPhbState *sphb;
+    SpaprTceTable *tcet =3D NULL;
     uint32_t addr, page_shift, window_shift, liobn;
     uint64_t buid, win_addr;
     int windows;
@@ -206,13 +206,13 @@ param_error_exit:
 }
=20
 static void rtas_ibm_remove_pe_dma_window(PowerPCCPU *cpu,
-                                          sPAPRMachineState *spapr,
+                                          SpaprMachineState *spapr,
                                           uint32_t token, uint32_t nargs=
,
                                           target_ulong args,
                                           uint32_t nret, target_ulong re=
ts)
 {
-    sPAPRPHBState *sphb;
-    sPAPRTCETable *tcet;
+    SpaprPhbState *sphb;
+    SpaprTceTable *tcet;
     uint32_t liobn;
=20
     if ((nargs !=3D 1) || (nret !=3D 1)) {
@@ -241,12 +241,12 @@ param_error_exit:
 }
=20
 static void rtas_ibm_reset_pe_dma_window(PowerPCCPU *cpu,
-                                         sPAPRMachineState *spapr,
+                                         SpaprMachineState *spapr,
                                          uint32_t token, uint32_t nargs,
                                          target_ulong args,
                                          uint32_t nret, target_ulong ret=
s)
 {
-    sPAPRPHBState *sphb;
+    SpaprPhbState *sphb;
     uint64_t buid;
     uint32_t addr;
=20
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index eb95a7077d..d732a3ea95 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -34,7 +34,7 @@
 #include "qapi/qapi-events-target.h"
 #include "qemu/cutils.h"
=20
-void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns)
+void spapr_rtc_read(SpaprRtcState *rtc, struct tm *tm, uint32_t *ns)
 {
     int64_t host_ns =3D qemu_clock_get_ns(rtc_clock);
     int64_t guest_ns;
@@ -53,7 +53,7 @@ void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, =
uint32_t *ns)
     }
 }
=20
-int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset)
+int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset)
 {
     if (!rtc) {
         return -ENODEV;
@@ -64,7 +64,7 @@ int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t=
 legacy_offset)
     return 0;
 }
=20
-static void rtas_get_time_of_day(PowerPCCPU *cpu, sPAPRMachineState *spa=
pr,
+static void rtas_get_time_of_day(PowerPCCPU *cpu, SpaprMachineState *spa=
pr,
                                  uint32_t token, uint32_t nargs,
                                  target_ulong args,
                                  uint32_t nret, target_ulong rets)
@@ -89,12 +89,12 @@ static void rtas_get_time_of_day(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
     rtas_st(rets, 7, ns);
 }
=20
-static void rtas_set_time_of_day(PowerPCCPU *cpu, sPAPRMachineState *spa=
pr,
+static void rtas_set_time_of_day(PowerPCCPU *cpu, SpaprMachineState *spa=
pr,
                                  uint32_t token, uint32_t nargs,
                                  target_ulong args,
                                  uint32_t nret, target_ulong rets)
 {
-    sPAPRRTCState *rtc =3D &spapr->rtc;
+    SpaprRtcState *rtc =3D &spapr->rtc;
     struct tm tm;
     time_t new_s;
     int64_t host_ns;
@@ -134,7 +134,7 @@ static void spapr_rtc_qom_date(Object *obj, struct tm=
 *current_tm, Error **errp)
=20
 static void spapr_rtc_realize(DeviceState *dev, Error **errp)
 {
-    sPAPRRTCState *rtc =3D SPAPR_RTC(dev);
+    SpaprRtcState *rtc =3D SPAPR_RTC(dev);
     struct tm tm;
     time_t host_s;
     int64_t rtc_ns;
@@ -154,7 +154,7 @@ static const VMStateDescription vmstate_spapr_rtc =3D=
 {
     .version_id =3D 1,
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
-        VMSTATE_INT64(ns_offset, sPAPRRTCState),
+        VMSTATE_INT64(ns_offset, SpaprRtcState),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -177,7 +177,7 @@ static void spapr_rtc_class_init(ObjectClass *oc, voi=
d *data)
 static const TypeInfo spapr_rtc_info =3D {
     .name          =3D TYPE_SPAPR_RTC,
     .parent        =3D TYPE_DEVICE,
-    .instance_size =3D sizeof(sPAPRRTCState),
+    .instance_size =3D sizeof(SpaprRtcState),
     .class_init    =3D spapr_rtc_class_init,
 };
=20
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 2b7e7ecac5..583c13deda 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -46,8 +46,8 @@
=20
 static char *spapr_vio_get_dev_name(DeviceState *qdev)
 {
-    VIOsPAPRDevice *dev =3D VIO_SPAPR_DEVICE(qdev);
-    VIOsPAPRDeviceClass *pc =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
+    SpaprVioDevice *dev =3D VIO_SPAPR_DEVICE(qdev);
+    SpaprVioDeviceClass *pc =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
=20
     /* Device tree style name device@reg */
     return g_strdup_printf("%s@%x", pc->dt_name, dev->reg);
@@ -65,16 +65,16 @@ static const TypeInfo spapr_vio_bus_info =3D {
     .name =3D TYPE_SPAPR_VIO_BUS,
     .parent =3D TYPE_BUS,
     .class_init =3D spapr_vio_bus_class_init,
-    .instance_size =3D sizeof(VIOsPAPRBus),
+    .instance_size =3D sizeof(SpaprVioBus),
 };
=20
-VIOsPAPRDevice *spapr_vio_find_by_reg(VIOsPAPRBus *bus, uint32_t reg)
+SpaprVioDevice *spapr_vio_find_by_reg(SpaprVioBus *bus, uint32_t reg)
 {
     BusChild *kid;
-    VIOsPAPRDevice *dev =3D NULL;
+    SpaprVioDevice *dev =3D NULL;
=20
     QTAILQ_FOREACH(kid, &bus->bus.children, sibling) {
-        dev =3D (VIOsPAPRDevice *)kid->child;
+        dev =3D (SpaprVioDevice *)kid->child;
         if (dev->reg =3D=3D reg) {
             return dev;
         }
@@ -83,10 +83,10 @@ VIOsPAPRDevice *spapr_vio_find_by_reg(VIOsPAPRBus *bu=
s, uint32_t reg)
     return NULL;
 }
=20
-static int vio_make_devnode(VIOsPAPRDevice *dev,
+static int vio_make_devnode(SpaprVioDevice *dev,
                             void *fdt)
 {
-    VIOsPAPRDeviceClass *pc =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
+    SpaprVioDeviceClass *pc =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
     int vdevice_off, node_off, ret;
     char *dt_name;
=20
@@ -152,13 +152,13 @@ static int vio_make_devnode(VIOsPAPRDevice *dev,
 /*
  * CRQ handling
  */
-static target_ulong h_reg_crq(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static target_ulong h_reg_crq(PowerPCCPU *cpu, SpaprMachineState *spapr,
                               target_ulong opcode, target_ulong *args)
 {
     target_ulong reg =3D args[0];
     target_ulong queue_addr =3D args[1];
     target_ulong queue_len =3D args[2];
-    VIOsPAPRDevice *dev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
+    SpaprVioDevice *dev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
=20
     if (!dev) {
         hcall_dprintf("Unit 0x" TARGET_FMT_lx " does not exist\n", reg);
@@ -197,7 +197,7 @@ static target_ulong h_reg_crq(PowerPCCPU *cpu, sPAPRM=
achineState *spapr,
     return H_SUCCESS;
 }
=20
-static target_ulong free_crq(VIOsPAPRDevice *dev)
+static target_ulong free_crq(SpaprVioDevice *dev)
 {
     dev->crq.qladdr =3D 0;
     dev->crq.qsize =3D 0;
@@ -208,11 +208,11 @@ static target_ulong free_crq(VIOsPAPRDevice *dev)
     return H_SUCCESS;
 }
=20
-static target_ulong h_free_crq(PowerPCCPU *cpu, sPAPRMachineState *spapr=
,
+static target_ulong h_free_crq(PowerPCCPU *cpu, SpaprMachineState *spapr=
,
                                target_ulong opcode, target_ulong *args)
 {
     target_ulong reg =3D args[0];
-    VIOsPAPRDevice *dev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
+    SpaprVioDevice *dev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
=20
     if (!dev) {
         hcall_dprintf("Unit 0x" TARGET_FMT_lx " does not exist\n", reg);
@@ -222,13 +222,13 @@ static target_ulong h_free_crq(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
     return free_crq(dev);
 }
=20
-static target_ulong h_send_crq(PowerPCCPU *cpu, sPAPRMachineState *spapr=
,
+static target_ulong h_send_crq(PowerPCCPU *cpu, SpaprMachineState *spapr=
,
                                target_ulong opcode, target_ulong *args)
 {
     target_ulong reg =3D args[0];
     target_ulong msg_hi =3D args[1];
     target_ulong msg_lo =3D args[2];
-    VIOsPAPRDevice *dev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
+    SpaprVioDevice *dev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
     uint64_t crq_mangle[2];
=20
     if (!dev) {
@@ -245,11 +245,11 @@ static target_ulong h_send_crq(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
     return H_HARDWARE;
 }
=20
-static target_ulong h_enable_crq(PowerPCCPU *cpu, sPAPRMachineState *spa=
pr,
+static target_ulong h_enable_crq(PowerPCCPU *cpu, SpaprMachineState *spa=
pr,
                                  target_ulong opcode, target_ulong *args=
)
 {
     target_ulong reg =3D args[0];
-    VIOsPAPRDevice *dev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
+    SpaprVioDevice *dev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
=20
     if (!dev) {
         hcall_dprintf("Unit 0x" TARGET_FMT_lx " does not exist\n", reg);
@@ -260,7 +260,7 @@ static target_ulong h_enable_crq(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
 }
=20
 /* Returns negative error, 0 success, or positive: queue full */
-int spapr_vio_send_crq(VIOsPAPRDevice *dev, uint8_t *crq)
+int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t *crq)
 {
     int rc;
     uint8_t byte;
@@ -303,7 +303,7 @@ int spapr_vio_send_crq(VIOsPAPRDevice *dev, uint8_t *=
crq)
=20
 /* "quiesce" handling */
=20
-static void spapr_vio_quiesce_one(VIOsPAPRDevice *dev)
+static void spapr_vio_quiesce_one(SpaprVioDevice *dev)
 {
     if (dev->tcet) {
         device_reset(DEVICE(dev->tcet));
@@ -311,7 +311,7 @@ static void spapr_vio_quiesce_one(VIOsPAPRDevice *dev=
)
     free_crq(dev);
 }
=20
-void spapr_vio_set_bypass(VIOsPAPRDevice *dev, bool bypass)
+void spapr_vio_set_bypass(SpaprVioDevice *dev, bool bypass)
 {
     if (!dev->tcet) {
         return;
@@ -323,13 +323,13 @@ void spapr_vio_set_bypass(VIOsPAPRDevice *dev, bool=
 bypass)
     dev->tcet->bypass =3D bypass;
 }
=20
-static void rtas_set_tce_bypass(PowerPCCPU *cpu, sPAPRMachineState *spap=
r,
+static void rtas_set_tce_bypass(PowerPCCPU *cpu, SpaprMachineState *spap=
r,
                                 uint32_t token,
                                 uint32_t nargs, target_ulong args,
                                 uint32_t nret, target_ulong rets)
 {
-    VIOsPAPRBus *bus =3D spapr->vio_bus;
-    VIOsPAPRDevice *dev;
+    SpaprVioBus *bus =3D spapr->vio_bus;
+    SpaprVioDevice *dev;
     uint32_t unit, enable;
=20
     if (nargs !=3D 2) {
@@ -354,14 +354,14 @@ static void rtas_set_tce_bypass(PowerPCCPU *cpu, sP=
APRMachineState *spapr,
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
-static void rtas_quiesce(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+static void rtas_quiesce(PowerPCCPU *cpu, SpaprMachineState *spapr,
                          uint32_t token,
                          uint32_t nargs, target_ulong args,
                          uint32_t nret, target_ulong rets)
 {
-    VIOsPAPRBus *bus =3D spapr->vio_bus;
+    SpaprVioBus *bus =3D spapr->vio_bus;
     BusChild *kid;
-    VIOsPAPRDevice *dev =3D NULL;
+    SpaprVioDevice *dev =3D NULL;
=20
     if (nargs !=3D 0) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
@@ -369,18 +369,18 @@ static void rtas_quiesce(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
     }
=20
     QTAILQ_FOREACH(kid, &bus->bus.children, sibling) {
-        dev =3D (VIOsPAPRDevice *)kid->child;
+        dev =3D (SpaprVioDevice *)kid->child;
         spapr_vio_quiesce_one(dev);
     }
=20
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
-static VIOsPAPRDevice *reg_conflict(VIOsPAPRDevice *dev)
+static SpaprVioDevice *reg_conflict(SpaprVioDevice *dev)
 {
-    VIOsPAPRBus *bus =3D SPAPR_VIO_BUS(dev->qdev.parent_bus);
+    SpaprVioBus *bus =3D SPAPR_VIO_BUS(dev->qdev.parent_bus);
     BusChild *kid;
-    VIOsPAPRDevice *other;
+    SpaprVioDevice *other;
=20
     /*
      * Check for a device other than the given one which is already
@@ -400,8 +400,8 @@ static VIOsPAPRDevice *reg_conflict(VIOsPAPRDevice *d=
ev)
=20
 static void spapr_vio_busdev_reset(DeviceState *qdev)
 {
-    VIOsPAPRDevice *dev =3D VIO_SPAPR_DEVICE(qdev);
-    VIOsPAPRDeviceClass *pc =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
+    SpaprVioDevice *dev =3D VIO_SPAPR_DEVICE(qdev);
+    SpaprVioDeviceClass *pc =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
=20
     /* Shut down the request queue and TCEs if necessary */
     spapr_vio_quiesce_one(dev);
@@ -465,9 +465,9 @@ static inline uint32_t spapr_vio_reg_to_irq(uint32_t =
reg)
=20
 static void spapr_vio_busdev_realize(DeviceState *qdev, Error **errp)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
-    VIOsPAPRDevice *dev =3D (VIOsPAPRDevice *)qdev;
-    VIOsPAPRDeviceClass *pc =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    SpaprVioDevice *dev =3D (SpaprVioDevice *)qdev;
+    SpaprVioDeviceClass *pc =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
     char *id;
     Error *local_err =3D NULL;
=20
@@ -478,7 +478,7 @@ static void spapr_vio_busdev_realize(DeviceState *qde=
v, Error **errp)
          * rather than using spapr_vio_find_by_reg() because sdev
          * itself is already in the list.
          */
-        VIOsPAPRDevice *other =3D reg_conflict(dev);
+        SpaprVioDevice *other =3D reg_conflict(dev);
=20
         if (other) {
             error_setg(errp, "%s and %s devices conflict at address %#x"=
,
@@ -489,7 +489,7 @@ static void spapr_vio_busdev_realize(DeviceState *qde=
v, Error **errp)
         }
     } else {
         /* Need to assign an address */
-        VIOsPAPRBus *bus =3D SPAPR_VIO_BUS(dev->qdev.parent_bus);
+        SpaprVioBus *bus =3D SPAPR_VIO_BUS(dev->qdev.parent_bus);
=20
         do {
             dev->reg =3D bus->next_reg++;
@@ -540,14 +540,14 @@ static void spapr_vio_busdev_realize(DeviceState *q=
dev, Error **errp)
     pc->realize(dev, errp);
 }
=20
-static target_ulong h_vio_signal(PowerPCCPU *cpu, sPAPRMachineState *spa=
pr,
+static target_ulong h_vio_signal(PowerPCCPU *cpu, SpaprMachineState *spa=
pr,
                                  target_ulong opcode,
                                  target_ulong *args)
 {
     target_ulong reg =3D args[0];
     target_ulong mode =3D args[1];
-    VIOsPAPRDevice *dev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
-    VIOsPAPRDeviceClass *pc;
+    SpaprVioDevice *dev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
+    SpaprVioDeviceClass *pc;
=20
     if (!dev) {
         return H_PARAMETER;
@@ -564,9 +564,9 @@ static target_ulong h_vio_signal(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
     return H_SUCCESS;
 }
=20
-VIOsPAPRBus *spapr_vio_bus_init(void)
+SpaprVioBus *spapr_vio_bus_init(void)
 {
-    VIOsPAPRBus *bus;
+    SpaprVioBus *bus;
     BusState *qbus;
     DeviceState *dev;
=20
@@ -615,14 +615,14 @@ const VMStateDescription vmstate_spapr_vio =3D {
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
         /* Sanity check */
-        VMSTATE_UINT32_EQUAL(reg, VIOsPAPRDevice, NULL),
-        VMSTATE_UINT32_EQUAL(irq, VIOsPAPRDevice, NULL),
+        VMSTATE_UINT32_EQUAL(reg, SpaprVioDevice, NULL),
+        VMSTATE_UINT32_EQUAL(irq, SpaprVioDevice, NULL),
=20
         /* General VIO device state */
-        VMSTATE_UINT64(signal_state, VIOsPAPRDevice),
-        VMSTATE_UINT64(crq.qladdr, VIOsPAPRDevice),
-        VMSTATE_UINT32(crq.qsize, VIOsPAPRDevice),
-        VMSTATE_UINT32(crq.qnext, VIOsPAPRDevice),
+        VMSTATE_UINT64(signal_state, SpaprVioDevice),
+        VMSTATE_UINT64(crq.qladdr, SpaprVioDevice),
+        VMSTATE_UINT32(crq.qsize, SpaprVioDevice),
+        VMSTATE_UINT32(crq.qnext, SpaprVioDevice),
=20
         VMSTATE_END_OF_LIST()
     },
@@ -639,9 +639,9 @@ static void vio_spapr_device_class_init(ObjectClass *=
klass, void *data)
 static const TypeInfo spapr_vio_type_info =3D {
     .name =3D TYPE_VIO_SPAPR_DEVICE,
     .parent =3D TYPE_DEVICE,
-    .instance_size =3D sizeof(VIOsPAPRDevice),
+    .instance_size =3D sizeof(SpaprVioDevice),
     .abstract =3D true,
-    .class_size =3D sizeof(VIOsPAPRDeviceClass),
+    .class_size =3D sizeof(SpaprVioDeviceClass),
     .class_init =3D vio_spapr_device_class_init,
 };
=20
@@ -656,10 +656,10 @@ type_init(spapr_vio_register_types)
=20
 static int compare_reg(const void *p1, const void *p2)
 {
-    VIOsPAPRDevice const *dev1, *dev2;
+    SpaprVioDevice const *dev1, *dev2;
=20
-    dev1 =3D (VIOsPAPRDevice *)*(DeviceState **)p1;
-    dev2 =3D (VIOsPAPRDevice *)*(DeviceState **)p2;
+    dev1 =3D (SpaprVioDevice *)*(DeviceState **)p1;
+    dev2 =3D (SpaprVioDevice *)*(DeviceState **)p2;
=20
     if (dev1->reg < dev2->reg) {
         return -1;
@@ -672,7 +672,7 @@ static int compare_reg(const void *p1, const void *p2=
)
     return 1;
 }
=20
-void spapr_dt_vdevice(VIOsPAPRBus *bus, void *fdt)
+void spapr_dt_vdevice(SpaprVioBus *bus, void *fdt)
 {
     DeviceState *qdev, **qdevs;
     BusChild *kid;
@@ -707,8 +707,8 @@ void spapr_dt_vdevice(VIOsPAPRBus *bus, void *fdt)
     /* Hack alert. Give the devices to libfdt in reverse order, we happe=
n
      * to know that will mean they are in forward order in the tree. */
     for (i =3D num - 1; i >=3D 0; i--) {
-        VIOsPAPRDevice *dev =3D (VIOsPAPRDevice *)(qdevs[i]);
-        VIOsPAPRDeviceClass *vdc =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
+        SpaprVioDevice *dev =3D (SpaprVioDevice *)(qdevs[i]);
+        SpaprVioDeviceClass *vdc =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
=20
         ret =3D vio_make_devnode(dev, fdt);
         if (ret < 0) {
@@ -721,9 +721,9 @@ void spapr_dt_vdevice(VIOsPAPRBus *bus, void *fdt)
     g_free(qdevs);
 }
=20
-gchar *spapr_vio_stdout_path(VIOsPAPRBus *bus)
+gchar *spapr_vio_stdout_path(SpaprVioBus *bus)
 {
-    VIOsPAPRDevice *dev;
+    SpaprVioDevice *dev;
     char *name, *path;
=20
     dev =3D spapr_vty_get_default(bus);
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index a9e49c7cb5..26dfc0340f 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -91,7 +91,7 @@ typedef struct vscsi_req {
      OBJECT_CHECK(VSCSIState, (obj), TYPE_VIO_SPAPR_VSCSI_DEVICE)
=20
 typedef struct {
-    VIOsPAPRDevice vdev;
+    SpaprVioDevice vdev;
     SCSIBus bus;
     vscsi_req reqs[VSCSI_REQ_LIMIT];
 } VSCSIState;
@@ -1115,7 +1115,7 @@ static void vscsi_got_payload(VSCSIState *s, vscsi_=
crq *crq)
 }
=20
=20
-static int vscsi_do_crq(struct VIOsPAPRDevice *dev, uint8_t *crq_data)
+static int vscsi_do_crq(struct SpaprVioDevice *dev, uint8_t *crq_data)
 {
     VSCSIState *s =3D VIO_SPAPR_VSCSI_DEVICE(dev);
     vscsi_crq crq;
@@ -1187,7 +1187,7 @@ static const struct SCSIBusInfo vscsi_scsi_info =3D=
 {
     .load_request =3D vscsi_load_request,
 };
=20
-static void spapr_vscsi_reset(VIOsPAPRDevice *dev)
+static void spapr_vscsi_reset(SpaprVioDevice *dev)
 {
     VSCSIState *s =3D VIO_SPAPR_VSCSI_DEVICE(dev);
     int i;
@@ -1198,7 +1198,7 @@ static void spapr_vscsi_reset(VIOsPAPRDevice *dev)
     }
 }
=20
-static void spapr_vscsi_realize(VIOsPAPRDevice *dev, Error **errp)
+static void spapr_vscsi_realize(SpaprVioDevice *dev, Error **errp)
 {
     VSCSIState *s =3D VIO_SPAPR_VSCSI_DEVICE(dev);
=20
@@ -1208,7 +1208,7 @@ static void spapr_vscsi_realize(VIOsPAPRDevice *dev=
, Error **errp)
                  &vscsi_scsi_info, NULL);
 }
=20
-void spapr_vscsi_create(VIOsPAPRBus *bus)
+void spapr_vscsi_create(SpaprVioBus *bus)
 {
     DeviceState *dev;
=20
@@ -1218,7 +1218,7 @@ void spapr_vscsi_create(VIOsPAPRBus *bus)
     scsi_bus_legacy_handle_cmdline(&VIO_SPAPR_VSCSI_DEVICE(dev)->bus);
 }
=20
-static int spapr_vscsi_devnode(VIOsPAPRDevice *dev, void *fdt, int node_=
off)
+static int spapr_vscsi_devnode(SpaprVioDevice *dev, void *fdt, int node_=
off)
 {
     int ret;
=20
@@ -1256,7 +1256,7 @@ static const VMStateDescription vmstate_spapr_vscsi=
 =3D {
 static void spapr_vscsi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
-    VIOsPAPRDeviceClass *k =3D VIO_SPAPR_DEVICE_CLASS(klass);
+    SpaprVioDeviceClass *k =3D VIO_SPAPR_DEVICE_CLASS(klass);
=20
     k->realize =3D spapr_vscsi_realize;
     k->reset =3D spapr_vscsi_reset;
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index ab0e3a0a6f..b4aad26798 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -28,11 +28,11 @@
 #define TYPE_SPAPR_PCI_HOST_BRIDGE "spapr-pci-host-bridge"
=20
 #define SPAPR_PCI_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(sPAPRPHBState, (obj), TYPE_SPAPR_PCI_HOST_BRIDGE)
+    OBJECT_CHECK(SpaprPhbState, (obj), TYPE_SPAPR_PCI_HOST_BRIDGE)
=20
 #define SPAPR_PCI_DMA_MAX_WINDOWS    2
=20
-typedef struct sPAPRPHBState sPAPRPHBState;
+typedef struct SpaprPhbState SpaprPhbState;
=20
 typedef struct spapr_pci_msi {
     uint32_t first_irq;
@@ -44,7 +44,7 @@ typedef struct spapr_pci_msi_mig {
     spapr_pci_msi value;
 } spapr_pci_msi_mig;
=20
-struct sPAPRPHBState {
+struct SpaprPhbState {
     PCIHostState parent_obj;
=20
     uint32_t index;
@@ -72,7 +72,7 @@ struct sPAPRPHBState {
     int32_t msi_devs_num;
     spapr_pci_msi_mig *msi_devs;
=20
-    QLIST_ENTRY(sPAPRPHBState) list;
+    QLIST_ENTRY(SpaprPhbState) list;
=20
     bool ddw_enabled;
     uint64_t page_size_mask;
@@ -105,56 +105,56 @@ struct sPAPRPHBState {
=20
 #define SPAPR_PCI_MSI_WINDOW         0x40000000000ULL
=20
-static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int=
 pin)
+static inline qemu_irq spapr_phb_lsi_qirq(struct SpaprPhbState *phb, int=
 pin)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
=20
     return spapr_qirq(spapr, phb->lsi_table[pin].irq);
 }
=20
-int spapr_populate_pci_dt(sPAPRPHBState *phb, uint32_t intc_phandle, voi=
d *fdt,
+int spapr_populate_pci_dt(SpaprPhbState *phb, uint32_t intc_phandle, voi=
d *fdt,
                           uint32_t nr_msis, int *node_offset);
=20
 void spapr_pci_rtas_init(void);
=20
-sPAPRPHBState *spapr_pci_find_phb(sPAPRMachineState *spapr, uint64_t bui=
d);
-PCIDevice *spapr_pci_find_dev(sPAPRMachineState *spapr, uint64_t buid,
+SpaprPhbState *spapr_pci_find_phb(SpaprMachineState *spapr, uint64_t bui=
d);
+PCIDevice *spapr_pci_find_dev(SpaprMachineState *spapr, uint64_t buid,
                               uint32_t config_addr);
=20
 /* DRC callbacks */
 void spapr_phb_remove_pci_device_cb(DeviceState *dev);
-int spapr_pci_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spap=
r,
+int spapr_pci_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp=
);
=20
 /* VFIO EEH hooks */
 #ifdef CONFIG_LINUX
-bool spapr_phb_eeh_available(sPAPRPHBState *sphb);
-int spapr_phb_vfio_eeh_set_option(sPAPRPHBState *sphb,
+bool spapr_phb_eeh_available(SpaprPhbState *sphb);
+int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
                                   unsigned int addr, int option);
-int spapr_phb_vfio_eeh_get_state(sPAPRPHBState *sphb, int *state);
-int spapr_phb_vfio_eeh_reset(sPAPRPHBState *sphb, int option);
-int spapr_phb_vfio_eeh_configure(sPAPRPHBState *sphb);
+int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state);
+int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option);
+int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb);
 void spapr_phb_vfio_reset(DeviceState *qdev);
 #else
-static inline bool spapr_phb_eeh_available(sPAPRPHBState *sphb)
+static inline bool spapr_phb_eeh_available(SpaprPhbState *sphb)
 {
     return false;
 }
-static inline int spapr_phb_vfio_eeh_set_option(sPAPRPHBState *sphb,
+static inline int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
                                                 unsigned int addr, int o=
ption)
 {
     return RTAS_OUT_HW_ERROR;
 }
-static inline int spapr_phb_vfio_eeh_get_state(sPAPRPHBState *sphb,
+static inline int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb,
                                                int *state)
 {
     return RTAS_OUT_HW_ERROR;
 }
-static inline int spapr_phb_vfio_eeh_reset(sPAPRPHBState *sphb, int opti=
on)
+static inline int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int opti=
on)
 {
     return RTAS_OUT_HW_ERROR;
 }
-static inline int spapr_phb_vfio_eeh_configure(sPAPRPHBState *sphb)
+static inline int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
 {
     return RTAS_OUT_HW_ERROR;
 }
@@ -163,9 +163,9 @@ static inline void spapr_phb_vfio_reset(DeviceState *=
qdev)
 }
 #endif
=20
-void spapr_phb_dma_reset(sPAPRPHBState *sphb);
+void spapr_phb_dma_reset(SpaprPhbState *sphb);
=20
-static inline unsigned spapr_phb_windows_supported(sPAPRPHBState *sphb)
+static inline unsigned spapr_phb_windows_supported(SpaprPhbState *sphb)
 {
     return sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
 }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f117a7ce6e..2b4c05a2ec 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -8,16 +8,16 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/ppc/spapr_ovec.h"
 #include "hw/ppc/spapr_irq.h"
-#include "hw/ppc/spapr_xive.h"  /* For sPAPRXive */
+#include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
 #include "hw/ppc/xics.h"        /* For ICSState */
=20
-struct VIOsPAPRBus;
-struct sPAPRPHBState;
-struct sPAPRNVRAM;
+struct SpaprVioBus;
+struct SpaprPhbState;
+struct SpaprNvram;
=20
-typedef struct sPAPREventLogEntry sPAPREventLogEntry;
-typedef struct sPAPREventSource sPAPREventSource;
-typedef struct sPAPRPendingHPT sPAPRPendingHPT;
+typedef struct SpaprEventLogEntry SpaprEventLogEntry;
+typedef struct SpaprEventSource SpaprEventSource;
+typedef struct SpaprPendingHpt SpaprPendingHpt;
=20
 #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
 #define SPAPR_ENTRY_POINT       0x100
@@ -27,32 +27,32 @@ typedef struct sPAPRPendingHPT sPAPRPendingHPT;
 #define TYPE_SPAPR_RTC "spapr-rtc"
=20
 #define SPAPR_RTC(obj)                                  \
-    OBJECT_CHECK(sPAPRRTCState, (obj), TYPE_SPAPR_RTC)
+    OBJECT_CHECK(SpaprRtcState, (obj), TYPE_SPAPR_RTC)
=20
-typedef struct sPAPRRTCState sPAPRRTCState;
-struct sPAPRRTCState {
+typedef struct SpaprRtcState SpaprRtcState;
+struct SpaprRtcState {
     /*< private >*/
     DeviceState parent_obj;
     int64_t ns_offset;
 };
=20
-typedef struct sPAPRDIMMState sPAPRDIMMState;
-typedef struct sPAPRMachineClass sPAPRMachineClass;
+typedef struct SpaprDimmState SpaprDimmState;
+typedef struct SpaprMachineClass SpaprMachineClass;
=20
 #define TYPE_SPAPR_MACHINE      "spapr-machine"
 #define SPAPR_MACHINE(obj) \
-    OBJECT_CHECK(sPAPRMachineState, (obj), TYPE_SPAPR_MACHINE)
+    OBJECT_CHECK(SpaprMachineState, (obj), TYPE_SPAPR_MACHINE)
 #define SPAPR_MACHINE_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(sPAPRMachineClass, obj, TYPE_SPAPR_MACHINE)
+    OBJECT_GET_CLASS(SpaprMachineClass, obj, TYPE_SPAPR_MACHINE)
 #define SPAPR_MACHINE_CLASS(klass) \
-    OBJECT_CLASS_CHECK(sPAPRMachineClass, klass, TYPE_SPAPR_MACHINE)
+    OBJECT_CLASS_CHECK(SpaprMachineClass, klass, TYPE_SPAPR_MACHINE)
=20
 typedef enum {
     SPAPR_RESIZE_HPT_DEFAULT =3D 0,
     SPAPR_RESIZE_HPT_DISABLED,
     SPAPR_RESIZE_HPT_ENABLED,
     SPAPR_RESIZE_HPT_REQUIRED,
-} sPAPRResizeHPT;
+} SpaprResizeHpt;
=20
 /**
  * Capabilities
@@ -99,15 +99,15 @@ typedef enum {
 #define SPAPR_CAP_FIXED_CCD             0x03
 #define SPAPR_CAP_FIXED_NA              0x10 /* Lets leave a bit of a ga=
p... */
=20
-typedef struct sPAPRCapabilities sPAPRCapabilities;
-struct sPAPRCapabilities {
+typedef struct SpaprCapabilities SpaprCapabilities;
+struct SpaprCapabilities {
     uint8_t caps[SPAPR_CAP_NUM];
 };
=20
 /**
- * sPAPRMachineClass:
+ * SpaprMachineClass:
  */
-struct sPAPRMachineClass {
+struct SpaprMachineClass {
     /*< private >*/
     MachineClass parent_class;
=20
@@ -119,33 +119,33 @@ struct sPAPRMachineClass {
     bool pre_2_10_has_unused_icps;
     bool legacy_irq_allocation;
=20
-    void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
+    void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio,=20
                           hwaddr *mmio32, hwaddr *mmio64,
                           unsigned n_dma, uint32_t *liobns, Error **errp=
);
-    sPAPRResizeHPT resize_hpt_default;
-    sPAPRCapabilities default_caps;
-    sPAPRIrq *irq;
+    SpaprResizeHpt resize_hpt_default;
+    SpaprCapabilities default_caps;
+    SpaprIrq *irq;
 };
=20
 /**
- * sPAPRMachineState:
+ * SpaprMachineState:
  */
-struct sPAPRMachineState {
+struct SpaprMachineState {
     /*< private >*/
     MachineState parent_obj;
=20
-    struct VIOsPAPRBus *vio_bus;
-    QLIST_HEAD(, sPAPRPHBState) phbs;
-    struct sPAPRNVRAM *nvram;
+    struct SpaprVioBus *vio_bus;
+    QLIST_HEAD(, SpaprPhbState) phbs;
+    struct SpaprNvram *nvram;
     ICSState *ics;
-    sPAPRRTCState rtc;
+    SpaprRtcState rtc;
=20
-    sPAPRResizeHPT resize_hpt;
+    SpaprResizeHpt resize_hpt;
     void *htab;
     uint32_t htab_shift;
     uint64_t patb_entry; /* Process tbl registed in H_REGISTER_PROCESS_T=
ABLE */
-    sPAPRPendingHPT *pending_hpt; /* in-progress resize */
+    SpaprPendingHpt *pending_hpt; /* in-progress resize */
=20
     hwaddr rma_size;
     int vrma_adjust;
@@ -164,15 +164,15 @@ struct sPAPRMachineState {
     uint32_t vsmt;       /* Virtual SMT mode (KVM's "core stride") */
=20
     Notifier epow_notifier;
-    QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
+    QTAILQ_HEAD(, SpaprEventLogEntry) pending_events;
     bool use_hotplug_event_source;
-    sPAPREventSource *event_sources;
+    SpaprEventSource *event_sources;
=20
     /* ibm,client-architecture-support option negotiation */
     bool cas_reboot;
     bool cas_legacy_guest_workaround;
-    sPAPROptionVector *ov5;         /* QEMU-supported option vectors */
-    sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vecto=
rs */
+    SpaprOptionVector *ov5;         /* QEMU-supported option vectors */
+    SpaprOptionVector *ov5_cas;     /* negotiated (via CAS) option vecto=
rs */
     uint32_t max_compat_pvr;
=20
     /* Migration state */
@@ -183,7 +183,7 @@ struct sPAPRMachineState {
     /* Pending DIMM unplug cache. It is populated when a LMB
      * unplug starts. It can be regenerated if a migration
      * occurs during the unplug process. */
-    QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
+    QTAILQ_HEAD(, SpaprDimmState) pending_dimm_unplugs;
=20
     /*< public >*/
     char *kvm_type;
@@ -192,12 +192,12 @@ struct sPAPRMachineState {
=20
     int32_t irq_map_nr;
     unsigned long *irq_map;
-    sPAPRXive  *xive;
-    sPAPRIrq *irq;
+    SpaprXive  *xive;
+    SpaprIrq *irq;
     qemu_irq *qirqs;
=20
     bool cmd_line_caps[SPAPR_CAP_NUM];
-    sPAPRCapabilities def, eff, mig;
+    SpaprCapabilities def, eff, mig;
 };
=20
 #define H_SUCCESS         0
@@ -503,16 +503,16 @@ struct sPAPRMachineState {
 #define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
 #define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
=20
-typedef struct sPAPRDeviceTreeUpdateHeader {
+typedef struct SpaprDeviceTreeUpdateHeader {
     uint32_t version_id;
-} sPAPRDeviceTreeUpdateHeader;
+} SpaprDeviceTreeUpdateHeader;
=20
 #define hcall_dprintf(fmt, ...) \
     do { \
         qemu_log_mask(LOG_GUEST_ERROR, "%s: " fmt, __func__, ## __VA_ARG=
S__); \
     } while (0)
=20
-typedef target_ulong (*spapr_hcall_fn)(PowerPCCPU *cpu, sPAPRMachineStat=
e *sm,
+typedef target_ulong (*spapr_hcall_fn)(PowerPCCPU *cpu, SpaprMachineStat=
e *sm,
                                        target_ulong opcode,
                                        target_ulong *args);
=20
@@ -666,16 +666,16 @@ static inline void rtas_st(target_ulong phys, int n=
, uint32_t val)
     stl_be_phys(&address_space_memory, ppc64_phys_to_real(phys + 4*n), v=
al);
 }
=20
-typedef void (*spapr_rtas_fn)(PowerPCCPU *cpu, sPAPRMachineState *sm,
+typedef void (*spapr_rtas_fn)(PowerPCCPU *cpu, SpaprMachineState *sm,
                               uint32_t token,
                               uint32_t nargs, target_ulong args,
                               uint32_t nret, target_ulong rets);
 void spapr_rtas_register(int token, const char *name, spapr_rtas_fn fn);
-target_ulong spapr_rtas_call(PowerPCCPU *cpu, sPAPRMachineState *sm,
+target_ulong spapr_rtas_call(PowerPCCPU *cpu, SpaprMachineState *sm,
                              uint32_t token, uint32_t nargs, target_ulon=
g args,
                              uint32_t nret, target_ulong rets);
 void spapr_dt_rtas_tokens(void *fdt, int rtas);
-void spapr_load_rtas(sPAPRMachineState *spapr, void *fdt, hwaddr addr);
+void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr);
=20
 #define SPAPR_TCE_PAGE_SHIFT   12
 #define SPAPR_TCE_PAGE_SIZE    (1ULL << SPAPR_TCE_PAGE_SHIFT)
@@ -702,17 +702,17 @@ static inline void spapr_dt_irq(uint32_t *intspec, =
int irq, bool is_lsi)
     intspec[1] =3D is_lsi ? cpu_to_be32(1) : 0;
 }
=20
-typedef struct sPAPRTCETable sPAPRTCETable;
+typedef struct SpaprTceTable SpaprTceTable;
=20
 #define TYPE_SPAPR_TCE_TABLE "spapr-tce-table"
 #define SPAPR_TCE_TABLE(obj) \
-    OBJECT_CHECK(sPAPRTCETable, (obj), TYPE_SPAPR_TCE_TABLE)
+    OBJECT_CHECK(SpaprTceTable, (obj), TYPE_SPAPR_TCE_TABLE)
=20
 #define TYPE_SPAPR_IOMMU_MEMORY_REGION "spapr-iommu-memory-region"
 #define SPAPR_IOMMU_MEMORY_REGION(obj) \
         OBJECT_CHECK(IOMMUMemoryRegion, (obj), TYPE_SPAPR_IOMMU_MEMORY_R=
EGION)
=20
-struct sPAPRTCETable {
+struct SpaprTceTable {
     DeviceState parent;
     uint32_t liobn;
     uint32_t nb_table;
@@ -727,69 +727,69 @@ struct sPAPRTCETable {
     int fd;
     MemoryRegion root;
     IOMMUMemoryRegion iommu;
-    struct VIOsPAPRDevice *vdev; /* for @bypass migration compatibility =
only */
-    QLIST_ENTRY(sPAPRTCETable) list;
+    struct SpaprVioDevice *vdev; /* for @bypass migration compatibility =
only */
+    QLIST_ENTRY(SpaprTceTable) list;
 };
=20
-sPAPRTCETable *spapr_tce_find_by_liobn(target_ulong liobn);
+SpaprTceTable *spapr_tce_find_by_liobn(target_ulong liobn);
=20
-struct sPAPREventLogEntry {
+struct SpaprEventLogEntry {
     uint32_t summary;
     uint32_t extended_length;
     void *extended_log;
-    QTAILQ_ENTRY(sPAPREventLogEntry) next;
+    QTAILQ_ENTRY(SpaprEventLogEntry) next;
 };
=20
-void spapr_events_init(sPAPRMachineState *sm);
-void spapr_dt_events(sPAPRMachineState *sm, void *fdt);
-int spapr_h_cas_compose_response(sPAPRMachineState *sm,
+void spapr_events_init(SpaprMachineState *sm);
+void spapr_dt_events(SpaprMachineState *sm, void *fdt);
+int spapr_h_cas_compose_response(SpaprMachineState *sm,
                                  target_ulong addr, target_ulong size,
-                                 sPAPROptionVector *ov5_updates);
-void close_htab_fd(sPAPRMachineState *spapr);
-void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr);
-void spapr_free_hpt(sPAPRMachineState *spapr);
-sPAPRTCETable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn);
-void spapr_tce_table_enable(sPAPRTCETable *tcet,
+                                 SpaprOptionVector *ov5_updates);
+void close_htab_fd(SpaprMachineState *spapr);
+void spapr_setup_hpt_and_vrma(SpaprMachineState *spapr);
+void spapr_free_hpt(SpaprMachineState *spapr);
+SpaprTceTable *spapr_tce_new_table(DeviceState *owner, uint32_t liobn);
+void spapr_tce_table_enable(SpaprTceTable *tcet,
                             uint32_t page_shift, uint64_t bus_offset,
                             uint32_t nb_table);
-void spapr_tce_table_disable(sPAPRTCETable *tcet);
-void spapr_tce_set_need_vfio(sPAPRTCETable *tcet, bool need_vfio);
+void spapr_tce_table_disable(SpaprTceTable *tcet);
+void spapr_tce_set_need_vfio(SpaprTceTable *tcet, bool need_vfio);
=20
-MemoryRegion *spapr_tce_get_iommu(sPAPRTCETable *tcet);
+MemoryRegion *spapr_tce_get_iommu(SpaprTceTable *tcet);
 int spapr_dma_dt(void *fdt, int node_off, const char *propname,
                  uint32_t liobn, uint64_t window, uint32_t size);
 int spapr_tcet_dma_dt(void *fdt, int node_off, const char *propname,
-                      sPAPRTCETable *tcet);
+                      SpaprTceTable *tcet);
 void spapr_pci_switch_vga(bool big_endian);
-void spapr_hotplug_req_add_by_index(sPAPRDRConnector *drc);
-void spapr_hotplug_req_remove_by_index(sPAPRDRConnector *drc);
-void spapr_hotplug_req_add_by_count(sPAPRDRConnectorType drc_type,
+void spapr_hotplug_req_add_by_index(SpaprDrc *drc);
+void spapr_hotplug_req_remove_by_index(SpaprDrc *drc);
+void spapr_hotplug_req_add_by_count(SpaprDrcType drc_type,
                                        uint32_t count);
-void spapr_hotplug_req_remove_by_count(sPAPRDRConnectorType drc_type,
+void spapr_hotplug_req_remove_by_count(SpaprDrcType drc_type,
                                           uint32_t count);
-void spapr_hotplug_req_add_by_count_indexed(sPAPRDRConnectorType drc_typ=
e,
+void spapr_hotplug_req_add_by_count_indexed(SpaprDrcType drc_type,
                                             uint32_t count, uint32_t ind=
ex);
-void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_=
type,
+void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
                                                uint32_t count, uint32_t =
index);
 int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
-void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
+void spapr_reallocate_hpt(SpaprMachineState *spapr, int shift,
                           Error **errp);
-void spapr_clear_pending_events(sPAPRMachineState *spapr);
-int spapr_max_server_number(sPAPRMachineState *spapr);
+void spapr_clear_pending_events(SpaprMachineState *spapr);
+int spapr_max_server_number(SpaprMachineState *spapr);
=20
 /* DRC callbacks. */
 void spapr_core_release(DeviceState *dev);
-int spapr_core_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spa=
pr,
+int spapr_core_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                            void *fdt, int *fdt_start_offset, Error **err=
p);
 void spapr_lmb_release(DeviceState *dev);
-int spapr_lmb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spap=
r,
+int spapr_lmb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp=
);
 void spapr_phb_release(DeviceState *dev);
-int spapr_phb_dt_populate(sPAPRDRConnector *drc, sPAPRMachineState *spap=
r,
+int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp=
);
=20
-void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
-int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
+void spapr_rtc_read(SpaprRtcState *rtc, struct tm *tm, uint32_t *ns);
+int spapr_rtc_import_offset(SpaprRtcState *rtc, int64_t legacy_offset);
=20
 #define TYPE_SPAPR_RNG "spapr-rng"
=20
@@ -843,18 +843,18 @@ extern const VMStateDescription vmstate_spapr_cap_n=
ested_kvm_hv;
 extern const VMStateDescription vmstate_spapr_cap_large_decr;
 extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
=20
-static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
+static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
 {
     return spapr->eff.caps[cap];
 }
=20
-void spapr_caps_init(sPAPRMachineState *spapr);
-void spapr_caps_apply(sPAPRMachineState *spapr);
-void spapr_caps_cpu_apply(sPAPRMachineState *spapr, PowerPCCPU *cpu);
-void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
-int spapr_caps_post_migration(sPAPRMachineState *spapr);
+void spapr_caps_init(SpaprMachineState *spapr);
+void spapr_caps_apply(SpaprMachineState *spapr);
+void spapr_caps_cpu_apply(SpaprMachineState *spapr, PowerPCCPU *cpu);
+void spapr_caps_add_properties(SpaprMachineClass *smc, Error **errp);
+int spapr_caps_post_migration(SpaprMachineState *spapr);
=20
-void spapr_check_pagesize(sPAPRMachineState *spapr, hwaddr pagesize,
+void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
                           Error **errp);
 /*
  * XIVE definitions
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
index d64f86bc28..f9645a7290 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -16,43 +16,43 @@
=20
 #define TYPE_SPAPR_CPU_CORE "spapr-cpu-core"
 #define SPAPR_CPU_CORE(obj) \
-    OBJECT_CHECK(sPAPRCPUCore, (obj), TYPE_SPAPR_CPU_CORE)
+    OBJECT_CHECK(SpaprCpuCore, (obj), TYPE_SPAPR_CPU_CORE)
 #define SPAPR_CPU_CORE_CLASS(klass) \
-    OBJECT_CLASS_CHECK(sPAPRCPUCoreClass, (klass), TYPE_SPAPR_CPU_CORE)
+    OBJECT_CLASS_CHECK(SpaprCpuCoreClass, (klass), TYPE_SPAPR_CPU_CORE)
 #define SPAPR_CPU_CORE_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(sPAPRCPUCoreClass, (obj), TYPE_SPAPR_CPU_CORE)
+     OBJECT_GET_CLASS(SpaprCpuCoreClass, (obj), TYPE_SPAPR_CPU_CORE)
=20
 #define SPAPR_CPU_CORE_TYPE_NAME(model) model "-" TYPE_SPAPR_CPU_CORE
=20
-typedef struct sPAPRCPUCore {
+typedef struct SpaprCpuCore {
     /*< private >*/
     CPUCore parent_obj;
=20
     /*< public >*/
     PowerPCCPU **threads;
     int node_id;
-    bool pre_3_0_migration; /* older machine don't know about sPAPRCPUSt=
ate */
-} sPAPRCPUCore;
+    bool pre_3_0_migration; /* older machine don't know about SpaprCpuSt=
ate */
+} SpaprCpuCore;
=20
-typedef struct sPAPRCPUCoreClass {
+typedef struct SpaprCpuCoreClass {
     DeviceClass parent_class;
     const char *cpu_type;
-} sPAPRCPUCoreClass;
+} SpaprCpuCoreClass;
=20
 const char *spapr_get_cpu_core_type(const char *cpu_type);
 void spapr_cpu_set_entry_state(PowerPCCPU *cpu, target_ulong nip, target=
_ulong r3);
=20
-typedef struct sPAPRCPUState {
+typedef struct SpaprCpuState {
     uint64_t vpa_addr;
     uint64_t slb_shadow_addr, slb_shadow_size;
     uint64_t dtl_addr, dtl_size;
     struct ICPState *icp;
     struct XiveTCTX *tctx;
-} sPAPRCPUState;
+} SpaprCpuState;
=20
-static inline sPAPRCPUState *spapr_cpu_state(PowerPCCPU *cpu)
+static inline SpaprCpuState *spapr_cpu_state(PowerPCCPU *cpu)
 {
-    return (sPAPRCPUState *)cpu->machine_data;
+    return (SpaprCpuState *)cpu->machine_data;
 }
=20
 #endif
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 46b0f6216d..fad0a887f9 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -22,65 +22,65 @@
=20
 #define TYPE_SPAPR_DR_CONNECTOR "spapr-dr-connector"
 #define SPAPR_DR_CONNECTOR_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DR_CONNE=
CTOR)
+        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DR_CONNECTOR)
 #define SPAPR_DR_CONNECTOR_CLASS(klass) \
-        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, \
+        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, \
                            TYPE_SPAPR_DR_CONNECTOR)
-#define SPAPR_DR_CONNECTOR(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
+#define SPAPR_DR_CONNECTOR(obj) OBJECT_CHECK(SpaprDrc, (obj), \
                                              TYPE_SPAPR_DR_CONNECTOR)
=20
 #define TYPE_SPAPR_DRC_PHYSICAL "spapr-drc-physical"
 #define SPAPR_DRC_PHYSICAL_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_PHYS=
ICAL)
+        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PHYSICAL)
 #define SPAPR_DRC_PHYSICAL_CLASS(klass) \
-        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, \
+        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, \
                            TYPE_SPAPR_DRC_PHYSICAL)
-#define SPAPR_DRC_PHYSICAL(obj) OBJECT_CHECK(sPAPRDRCPhysical, (obj), \
+#define SPAPR_DRC_PHYSICAL(obj) OBJECT_CHECK(SpaprDrcPhysical, (obj), \
                                              TYPE_SPAPR_DRC_PHYSICAL)
=20
 #define TYPE_SPAPR_DRC_LOGICAL "spapr-drc-logical"
 #define SPAPR_DRC_LOGICAL_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_LOGI=
CAL)
+        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_LOGICAL)
 #define SPAPR_DRC_LOGICAL_CLASS(klass) \
-        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, \
+        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, \
                            TYPE_SPAPR_DRC_LOGICAL)
-#define SPAPR_DRC_LOGICAL(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
+#define SPAPR_DRC_LOGICAL(obj) OBJECT_CHECK(SpaprDrc, (obj), \
                                              TYPE_SPAPR_DRC_LOGICAL)
=20
 #define TYPE_SPAPR_DRC_CPU "spapr-drc-cpu"
 #define SPAPR_DRC_CPU_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_CPU)
+        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_CPU)
 #define SPAPR_DRC_CPU_CLASS(klass) \
-        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_DRC_=
CPU)
-#define SPAPR_DRC_CPU(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
+        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_CPU)
+#define SPAPR_DRC_CPU(obj) OBJECT_CHECK(SpaprDrc, (obj), \
                                         TYPE_SPAPR_DRC_CPU)
=20
 #define TYPE_SPAPR_DRC_PCI "spapr-drc-pci"
 #define SPAPR_DRC_PCI_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_PCI)
+        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PCI)
 #define SPAPR_DRC_PCI_CLASS(klass) \
-        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_DRC_=
PCI)
-#define SPAPR_DRC_PCI(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
+        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_PCI)
+#define SPAPR_DRC_PCI(obj) OBJECT_CHECK(SpaprDrc, (obj), \
                                         TYPE_SPAPR_DRC_PCI)
=20
 #define TYPE_SPAPR_DRC_LMB "spapr-drc-lmb"
 #define SPAPR_DRC_LMB_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_LMB)
+        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_LMB)
 #define SPAPR_DRC_LMB_CLASS(klass) \
-        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_DRC_=
LMB)
-#define SPAPR_DRC_LMB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
+        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_LMB)
+#define SPAPR_DRC_LMB(obj) OBJECT_CHECK(SpaprDrc, (obj), \
                                         TYPE_SPAPR_DRC_LMB)
=20
 #define TYPE_SPAPR_DRC_PHB "spapr-drc-phb"
 #define SPAPR_DRC_PHB_GET_CLASS(obj) \
-        OBJECT_GET_CLASS(sPAPRDRConnectorClass, obj, TYPE_SPAPR_DRC_PHB)
+        OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PHB)
 #define SPAPR_DRC_PHB_CLASS(klass) \
-        OBJECT_CLASS_CHECK(sPAPRDRConnectorClass, klass, TYPE_SPAPR_DRC_=
PHB)
-#define SPAPR_DRC_PHB(obj) OBJECT_CHECK(sPAPRDRConnector, (obj), \
+        OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_PHB)
+#define SPAPR_DRC_PHB(obj) OBJECT_CHECK(SpaprDrc, (obj), \
                                         TYPE_SPAPR_DRC_PHB)
=20
 /*
- * Various hotplug types managed by sPAPRDRConnector
+ * Various hotplug types managed by SpaprDrc
  *
  * these are somewhat arbitrary, but to make things easier
  * when generating DRC indexes later we've aligned the bit
@@ -96,7 +96,7 @@ typedef enum {
     SPAPR_DR_CONNECTOR_TYPE_SHIFT_VIO =3D 3,
     SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI =3D 4,
     SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB =3D 8,
-} sPAPRDRConnectorTypeShift;
+} SpaprDrcTypeShift;
=20
 typedef enum {
     SPAPR_DR_CONNECTOR_TYPE_ANY =3D ~0,
@@ -105,7 +105,7 @@ typedef enum {
     SPAPR_DR_CONNECTOR_TYPE_VIO =3D 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_V=
IO,
     SPAPR_DR_CONNECTOR_TYPE_PCI =3D 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_P=
CI,
     SPAPR_DR_CONNECTOR_TYPE_LMB =3D 1 << SPAPR_DR_CONNECTOR_TYPE_SHIFT_L=
MB,
-} sPAPRDRConnectorType;
+} SpaprDrcType;
=20
 /*
  * set via set-indicator RTAS calls
@@ -117,7 +117,7 @@ typedef enum {
 typedef enum {
     SPAPR_DR_ISOLATION_STATE_ISOLATED   =3D 0,
     SPAPR_DR_ISOLATION_STATE_UNISOLATED =3D 1
-} sPAPRDRIsolationState;
+} SpaprDRIsolationState;
=20
 /*
  * set via set-indicator RTAS calls
@@ -133,7 +133,7 @@ typedef enum {
     SPAPR_DR_ALLOCATION_STATE_USABLE    =3D 1,
     SPAPR_DR_ALLOCATION_STATE_EXCHANGE  =3D 2,
     SPAPR_DR_ALLOCATION_STATE_RECOVER   =3D 3
-} sPAPRDRAllocationState;
+} SpaprDRAllocationState;
=20
 /*
  * DR-indicator (LED/visual indicator)
@@ -152,7 +152,7 @@ typedef enum {
     SPAPR_DR_INDICATOR_ACTIVE     =3D 1,
     SPAPR_DR_INDICATOR_IDENTIFY   =3D 2,
     SPAPR_DR_INDICATOR_ACTION     =3D 3,
-} sPAPRDRIndicatorState;
+} SpaprDRIndicatorState;
=20
 /*
  * returned via get-sensor-state RTAS calls
@@ -170,7 +170,7 @@ typedef enum {
     SPAPR_DR_ENTITY_SENSE_UNUSABLE  =3D 2,
     SPAPR_DR_ENTITY_SENSE_EXCHANGE  =3D 3,
     SPAPR_DR_ENTITY_SENSE_RECOVER   =3D 4,
-} sPAPRDREntitySense;
+} SpaprDREntitySense;
=20
 typedef enum {
     SPAPR_DR_CC_RESPONSE_NEXT_SIB         =3D 1, /* currently unused */
@@ -181,7 +181,7 @@ typedef enum {
     SPAPR_DR_CC_RESPONSE_ERROR            =3D -1,
     SPAPR_DR_CC_RESPONSE_CONTINUE         =3D -2,
     SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE =3D -9003,
-} sPAPRDRCCResponse;
+} SpaprDRCCResponse;
=20
 typedef enum {
     /*
@@ -199,9 +199,9 @@ typedef enum {
     SPAPR_DRC_STATE_PHYSICAL_POWERON    =3D 6,
     SPAPR_DRC_STATE_PHYSICAL_UNISOLATE  =3D 7,
     SPAPR_DRC_STATE_PHYSICAL_CONFIGURED =3D 8,
-} sPAPRDRCState;
+} SpaprDrcState;
=20
-typedef struct sPAPRDRConnector {
+typedef struct SpaprDrc {
     /*< private >*/
     DeviceState parent;
=20
@@ -220,60 +220,60 @@ typedef struct sPAPRDRConnector {
     bool unplug_requested;
     void *fdt;
     int fdt_start_offset;
-} sPAPRDRConnector;
+} SpaprDrc;
=20
-struct sPAPRMachineState;
+struct SpaprMachineState;
=20
-typedef struct sPAPRDRConnectorClass {
+typedef struct SpaprDrcClass {
     /*< private >*/
     DeviceClass parent;
-    sPAPRDRCState empty_state;
-    sPAPRDRCState ready_state;
+    SpaprDrcState empty_state;
+    SpaprDrcState ready_state;
=20
     /*< public >*/
-    sPAPRDRConnectorTypeShift typeshift;
+    SpaprDrcTypeShift typeshift;
     const char *typename; /* used in device tree, PAPR 13.5.2.6 & C.6.1 =
*/
     const char *drc_name_prefix; /* used other places in device tree */
=20
-    sPAPRDREntitySense (*dr_entity_sense)(sPAPRDRConnector *drc);
-    uint32_t (*isolate)(sPAPRDRConnector *drc);
-    uint32_t (*unisolate)(sPAPRDRConnector *drc);
+    SpaprDREntitySense (*dr_entity_sense)(SpaprDrc *drc);
+    uint32_t (*isolate)(SpaprDrc *drc);
+    uint32_t (*unisolate)(SpaprDrc *drc);
     void (*release)(DeviceState *dev);
=20
-    int (*dt_populate)(sPAPRDRConnector *drc, struct sPAPRMachineState *=
spapr,
+    int (*dt_populate)(SpaprDrc *drc, struct SpaprMachineState *spapr,
                        void *fdt, int *fdt_start_offset, Error **errp);
-} sPAPRDRConnectorClass;
+} SpaprDrcClass;
=20
-typedef struct sPAPRDRCPhysical {
+typedef struct SpaprDrcPhysical {
     /*< private >*/
-    sPAPRDRConnector parent;
+    SpaprDrc parent;
=20
     /* DR-indicator */
     uint32_t dr_indicator;
-} sPAPRDRCPhysical;
+} SpaprDrcPhysical;
=20
 static inline bool spapr_drc_hotplugged(DeviceState *dev)
 {
     return dev->hotplugged && !runstate_check(RUN_STATE_INMIGRATE);
 }
=20
-void spapr_drc_reset(sPAPRDRConnector *drc);
+void spapr_drc_reset(SpaprDrc *drc);
=20
-uint32_t spapr_drc_index(sPAPRDRConnector *drc);
-sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc);
+uint32_t spapr_drc_index(SpaprDrc *drc);
+SpaprDrcType spapr_drc_type(SpaprDrc *drc);
=20
-sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type=
,
+SpaprDrc *spapr_dr_connector_new(Object *owner, const char *type,
                                          uint32_t id);
-sPAPRDRConnector *spapr_drc_by_index(uint32_t index);
-sPAPRDRConnector *spapr_drc_by_id(const char *type, uint32_t id);
+SpaprDrc *spapr_drc_by_index(uint32_t index);
+SpaprDrc *spapr_drc_by_id(const char *type, uint32_t id);
 int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
                           uint32_t drc_type_mask);
=20
-void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, Error **err=
p);
-void spapr_drc_detach(sPAPRDRConnector *drc);
+void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Error **errp);
+void spapr_drc_detach(SpaprDrc *drc);
 bool spapr_drc_needed(void *opaque);
=20
-static inline bool spapr_drc_unplug_requested(sPAPRDRConnector *drc)
+static inline bool spapr_drc_unplug_requested(SpaprDrc *drc)
 {
     return drc->unplug_requested;
 }
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index ec1ee64fa6..b855f74e44 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -22,51 +22,51 @@
 #define SPAPR_IRQ_MSI        0x1300  /* Offset of the dynamic range cove=
red
                                       * by the bitmap allocator */
=20
-typedef struct sPAPRMachineState sPAPRMachineState;
+typedef struct SpaprMachineState SpaprMachineState;
=20
-void spapr_irq_msi_init(sPAPRMachineState *spapr, uint32_t nr_msis);
-int spapr_irq_msi_alloc(sPAPRMachineState *spapr, uint32_t num, bool ali=
gn,
+void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
+int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool ali=
gn,
                         Error **errp);
-void spapr_irq_msi_free(sPAPRMachineState *spapr, int irq, uint32_t num)=
;
-void spapr_irq_msi_reset(sPAPRMachineState *spapr);
+void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num)=
;
+void spapr_irq_msi_reset(SpaprMachineState *spapr);
=20
-typedef struct sPAPRIrq {
+typedef struct SpaprIrq {
     uint32_t    nr_irqs;
     uint32_t    nr_msis;
     uint8_t     ov5;
=20
-    void (*init)(sPAPRMachineState *spapr, int nr_irqs, Error **errp);
-    int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error **er=
rp);
-    void (*free)(sPAPRMachineState *spapr, int irq, int num);
-    qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
-    void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
-    void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
+    void (*init)(SpaprMachineState *spapr, int nr_irqs, Error **errp);
+    int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **er=
rp);
+    void (*free)(SpaprMachineState *spapr, int irq, int num);
+    qemu_irq (*qirq)(SpaprMachineState *spapr, int irq);
+    void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
+    void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
                         void *fdt, uint32_t phandle);
-    void (*cpu_intc_create)(sPAPRMachineState *spapr, PowerPCCPU *cpu,
+    void (*cpu_intc_create)(SpaprMachineState *spapr, PowerPCCPU *cpu,
                             Error **errp);
-    int (*post_load)(sPAPRMachineState *spapr, int version_id);
-    void (*reset)(sPAPRMachineState *spapr, Error **errp);
+    int (*post_load)(SpaprMachineState *spapr, int version_id);
+    void (*reset)(SpaprMachineState *spapr, Error **errp);
     void (*set_irq)(void *opaque, int srcno, int val);
-    const char *(*get_nodename)(sPAPRMachineState *spapr);
-} sPAPRIrq;
+    const char *(*get_nodename)(SpaprMachineState *spapr);
+} SpaprIrq;
=20
-extern sPAPRIrq spapr_irq_xics;
-extern sPAPRIrq spapr_irq_xics_legacy;
-extern sPAPRIrq spapr_irq_xive;
-extern sPAPRIrq spapr_irq_dual;
+extern SpaprIrq spapr_irq_xics;
+extern SpaprIrq spapr_irq_xics_legacy;
+extern SpaprIrq spapr_irq_xive;
+extern SpaprIrq spapr_irq_dual;
=20
-void spapr_irq_init(sPAPRMachineState *spapr, Error **errp);
-int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
-void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
-qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
-int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
-void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
-int spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt, Error **e=
rrp);
+void spapr_irq_init(SpaprMachineState *spapr, Error **errp);
+int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp);
+void spapr_irq_free(SpaprMachineState *spapr, int irq, int num);
+qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq);
+int spapr_irq_post_load(SpaprMachineState *spapr, int version_id);
+void spapr_irq_reset(SpaprMachineState *spapr, Error **errp);
+int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error **e=
rrp);
=20
 /*
  * XICS legacy routines
  */
-int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align, Error =
**errp);
+int spapr_irq_find(SpaprMachineState *spapr, int num, bool align, Error =
**errp);
 #define spapr_irq_findone(spapr, errp) spapr_irq_find(spapr, 1, false, e=
rrp)
=20
 #endif
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index 0f2d8d715d..188a9367e2 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -39,7 +39,7 @@
 #include "cpu.h"
 #include "migration/vmstate.h"
=20
-typedef struct sPAPROptionVector sPAPROptionVector;
+typedef struct SpaprOptionVector SpaprOptionVector;
=20
 #define OV_BIT(byte, bit) ((byte - 1) * BITS_PER_BYTE + bit)
=20
@@ -61,21 +61,21 @@ typedef struct sPAPROptionVector sPAPROptionVector;
 #define OV5_MMU_RADIX_GTSE      OV_BIT(26, 1) /* Radix GTSE */
=20
 /* interfaces */
-sPAPROptionVector *spapr_ovec_new(void);
-sPAPROptionVector *spapr_ovec_clone(sPAPROptionVector *ov_orig);
-void spapr_ovec_intersect(sPAPROptionVector *ov,
-                          sPAPROptionVector *ov1,
-                          sPAPROptionVector *ov2);
-bool spapr_ovec_diff(sPAPROptionVector *ov,
-                     sPAPROptionVector *ov_old,
-                     sPAPROptionVector *ov_new);
-void spapr_ovec_cleanup(sPAPROptionVector *ov);
-void spapr_ovec_set(sPAPROptionVector *ov, long bitnr);
-void spapr_ovec_clear(sPAPROptionVector *ov, long bitnr);
-bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr);
-sPAPROptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int =
vector);
+SpaprOptionVector *spapr_ovec_new(void);
+SpaprOptionVector *spapr_ovec_clone(SpaprOptionVector *ov_orig);
+void spapr_ovec_intersect(SpaprOptionVector *ov,
+                          SpaprOptionVector *ov1,
+                          SpaprOptionVector *ov2);
+bool spapr_ovec_diff(SpaprOptionVector *ov,
+                     SpaprOptionVector *ov_old,
+                     SpaprOptionVector *ov_new);
+void spapr_ovec_cleanup(SpaprOptionVector *ov);
+void spapr_ovec_set(SpaprOptionVector *ov, long bitnr);
+void spapr_ovec_clear(SpaprOptionVector *ov, long bitnr);
+bool spapr_ovec_test(SpaprOptionVector *ov, long bitnr);
+SpaprOptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int =
vector);
 int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
-                           sPAPROptionVector *ov, const char *name);
+                           SpaprOptionVector *ov, const char *name);
=20
 /* migration */
 extern const VMStateDescription vmstate_spapr_ovec;
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index e8b006d18f..04609f214e 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -26,91 +26,91 @@
=20
 #define TYPE_VIO_SPAPR_DEVICE "vio-spapr-device"
 #define VIO_SPAPR_DEVICE(obj) \
-     OBJECT_CHECK(VIOsPAPRDevice, (obj), TYPE_VIO_SPAPR_DEVICE)
+     OBJECT_CHECK(SpaprVioDevice, (obj), TYPE_VIO_SPAPR_DEVICE)
 #define VIO_SPAPR_DEVICE_CLASS(klass) \
-     OBJECT_CLASS_CHECK(VIOsPAPRDeviceClass, (klass), TYPE_VIO_SPAPR_DEV=
ICE)
+     OBJECT_CLASS_CHECK(SpaprVioDeviceClass, (klass), TYPE_VIO_SPAPR_DEV=
ICE)
 #define VIO_SPAPR_DEVICE_GET_CLASS(obj) \
-     OBJECT_GET_CLASS(VIOsPAPRDeviceClass, (obj), TYPE_VIO_SPAPR_DEVICE)
+     OBJECT_GET_CLASS(SpaprVioDeviceClass, (obj), TYPE_VIO_SPAPR_DEVICE)
=20
 #define TYPE_SPAPR_VIO_BUS "spapr-vio-bus"
-#define SPAPR_VIO_BUS(obj) OBJECT_CHECK(VIOsPAPRBus, (obj), TYPE_SPAPR_V=
IO_BUS)
+#define SPAPR_VIO_BUS(obj) OBJECT_CHECK(SpaprVioBus, (obj), TYPE_SPAPR_V=
IO_BUS)
=20
 #define TYPE_SPAPR_VIO_BRIDGE "spapr-vio-bridge"
=20
-typedef struct VIOsPAPR_CRQ {
+typedef struct SpaprVioCrq {
     uint64_t qladdr;
     uint32_t qsize;
     uint32_t qnext;
-    int(*SendFunc)(struct VIOsPAPRDevice *vdev, uint8_t *crq);
-} VIOsPAPR_CRQ;
+    int(*SendFunc)(struct SpaprVioDevice *vdev, uint8_t *crq);
+} SpaprVioCrq;
=20
-typedef struct VIOsPAPRDevice VIOsPAPRDevice;
-typedef struct VIOsPAPRBus VIOsPAPRBus;
+typedef struct SpaprVioDevice SpaprVioDevice;
+typedef struct SpaprVioBus SpaprVioBus;
=20
-typedef struct VIOsPAPRDeviceClass {
+typedef struct SpaprVioDeviceClass {
     DeviceClass parent_class;
=20
     const char *dt_name, *dt_type, *dt_compatible;
     target_ulong signal_mask;
     uint32_t rtce_window_size;
-    void (*realize)(VIOsPAPRDevice *dev, Error **errp);
-    void (*reset)(VIOsPAPRDevice *dev);
-    int (*devnode)(VIOsPAPRDevice *dev, void *fdt, int node_off);
-} VIOsPAPRDeviceClass;
+    void (*realize)(SpaprVioDevice *dev, Error **errp);
+    void (*reset)(SpaprVioDevice *dev);
+    int (*devnode)(SpaprVioDevice *dev, void *fdt, int node_off);
+} SpaprVioDeviceClass;
=20
-struct VIOsPAPRDevice {
+struct SpaprVioDevice {
     DeviceState qdev;
     uint32_t reg;
     uint32_t irq;
     uint64_t signal_state;
-    VIOsPAPR_CRQ crq;
+    SpaprVioCrq crq;
     AddressSpace as;
     MemoryRegion mrroot;
     MemoryRegion mrbypass;
-    sPAPRTCETable *tcet;
+    SpaprTceTable *tcet;
 };
=20
 #define DEFINE_SPAPR_PROPERTIES(type, field)           \
         DEFINE_PROP_UINT32("reg", type, field.reg, -1)
=20
-struct VIOsPAPRBus {
+struct SpaprVioBus {
     BusState bus;
     uint32_t next_reg;
 };
=20
-extern VIOsPAPRBus *spapr_vio_bus_init(void);
-extern VIOsPAPRDevice *spapr_vio_find_by_reg(VIOsPAPRBus *bus, uint32_t =
reg);
-void spapr_dt_vdevice(VIOsPAPRBus *bus, void *fdt);
-extern gchar *spapr_vio_stdout_path(VIOsPAPRBus *bus);
+extern SpaprVioBus *spapr_vio_bus_init(void);
+extern SpaprVioDevice *spapr_vio_find_by_reg(SpaprVioBus *bus, uint32_t =
reg);
+void spapr_dt_vdevice(SpaprVioBus *bus, void *fdt);
+extern gchar *spapr_vio_stdout_path(SpaprVioBus *bus);
=20
-static inline qemu_irq spapr_vio_qirq(VIOsPAPRDevice *dev)
+static inline qemu_irq spapr_vio_qirq(SpaprVioDevice *dev)
 {
-    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
=20
     return spapr_qirq(spapr, dev->irq);
 }
=20
-static inline bool spapr_vio_dma_valid(VIOsPAPRDevice *dev, uint64_t tad=
dr,
+static inline bool spapr_vio_dma_valid(SpaprVioDevice *dev, uint64_t tad=
dr,
                                        uint32_t size, DMADirection dir)
 {
     return dma_memory_valid(&dev->as, taddr, size, dir);
 }
=20
-static inline int spapr_vio_dma_read(VIOsPAPRDevice *dev, uint64_t taddr=
,
+static inline int spapr_vio_dma_read(SpaprVioDevice *dev, uint64_t taddr=
,
                                      void *buf, uint32_t size)
 {
     return (dma_memory_read(&dev->as, taddr, buf, size) !=3D 0) ?
         H_DEST_PARM : H_SUCCESS;
 }
=20
-static inline int spapr_vio_dma_write(VIOsPAPRDevice *dev, uint64_t tadd=
r,
+static inline int spapr_vio_dma_write(SpaprVioDevice *dev, uint64_t tadd=
r,
                                       const void *buf, uint32_t size)
 {
     return (dma_memory_write(&dev->as, taddr, buf, size) !=3D 0) ?
         H_DEST_PARM : H_SUCCESS;
 }
=20
-static inline int spapr_vio_dma_set(VIOsPAPRDevice *dev, uint64_t taddr,
+static inline int spapr_vio_dma_set(SpaprVioDevice *dev, uint64_t taddr,
                                     uint8_t c, uint32_t size)
 {
     return (dma_memory_set(&dev->as, taddr, c, size) !=3D 0) ?
@@ -123,21 +123,21 @@ static inline int spapr_vio_dma_set(VIOsPAPRDevice =
*dev, uint64_t taddr,
 #define vio_stq(_dev, _addr, _val) (stq_be_dma(&(_dev)->as, (_addr), (_v=
al)))
 #define vio_ldq(_dev, _addr) (ldq_be_dma(&(_dev)->as, (_addr)))
=20
-int spapr_vio_send_crq(VIOsPAPRDevice *dev, uint8_t *crq);
+int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t *crq);
=20
-VIOsPAPRDevice *vty_lookup(sPAPRMachineState *spapr, target_ulong reg);
-void vty_putchars(VIOsPAPRDevice *sdev, uint8_t *buf, int len);
-void spapr_vty_create(VIOsPAPRBus *bus, Chardev *chardev);
-void spapr_vlan_create(VIOsPAPRBus *bus, NICInfo *nd);
-void spapr_vscsi_create(VIOsPAPRBus *bus);
+SpaprVioDevice *vty_lookup(SpaprMachineState *spapr, target_ulong reg);
+void vty_putchars(SpaprVioDevice *sdev, uint8_t *buf, int len);
+void spapr_vty_create(SpaprVioBus *bus, Chardev *chardev);
+void spapr_vlan_create(SpaprVioBus *bus, NICInfo *nd);
+void spapr_vscsi_create(SpaprVioBus *bus);
=20
-VIOsPAPRDevice *spapr_vty_get_default(VIOsPAPRBus *bus);
+SpaprVioDevice *spapr_vty_get_default(SpaprVioBus *bus);
=20
 extern const VMStateDescription vmstate_spapr_vio;
=20
 #define VMSTATE_SPAPR_VIO(_f, _s) \
-    VMSTATE_STRUCT(_f, _s, 0, vmstate_spapr_vio, VIOsPAPRDevice)
+    VMSTATE_STRUCT(_f, _s, 0, vmstate_spapr_vio, SpaprVioDevice)
=20
-void spapr_vio_set_bypass(VIOsPAPRDevice *dev, bool bypass);
+void spapr_vio_set_bypass(SpaprVioDevice *dev, bool bypass);
=20
 #endif /* HW_SPAPR_VIO_H */
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 2d31f24e3b..fc3e9652f9 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -13,9 +13,9 @@
 #include "hw/ppc/xive.h"
=20
 #define TYPE_SPAPR_XIVE "spapr-xive"
-#define SPAPR_XIVE(obj) OBJECT_CHECK(sPAPRXive, (obj), TYPE_SPAPR_XIVE)
+#define SPAPR_XIVE(obj) OBJECT_CHECK(SpaprXive, (obj), TYPE_SPAPR_XIVE)
=20
-typedef struct sPAPRXive {
+typedef struct SpaprXive {
     XiveRouter    parent;
=20
     /* Internal interrupt source for IPIs and virtual devices */
@@ -38,16 +38,16 @@ typedef struct sPAPRXive {
     /* TIMA mapping address */
     hwaddr        tm_base;
     MemoryRegion  tm_mmio;
-} sPAPRXive;
+} SpaprXive;
=20
-bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
-bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
-void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
+bool spapr_xive_irq_claim(SpaprXive *xive, uint32_t lisn, bool lsi);
+bool spapr_xive_irq_free(SpaprXive *xive, uint32_t lisn);
+void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
=20
-void spapr_xive_hcall_init(sPAPRMachineState *spapr);
-void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
+void spapr_xive_hcall_init(SpaprMachineState *spapr);
+void spapr_dt_xive(SpaprMachineState *spapr, uint32_t nr_servers, void *=
fdt,
                    uint32_t phandle);
 void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
-void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable);
+void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable);
=20
 #endif /* PPC_SPAPR_XIVE_H */
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
index b8d924baf4..15a8dcff66 100644
--- a/include/hw/ppc/xics_spapr.h
+++ b/include/hw/ppc/xics_spapr.h
@@ -31,9 +31,9 @@
=20
 #define XICS_NODENAME "interrupt-controller"
=20
-void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
+void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void *=
fdt,
                    uint32_t phandle);
-int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
-void xics_spapr_init(sPAPRMachineState *spapr);
+int xics_kvm_init(SpaprMachineState *spapr, Error **errp);
+void xics_spapr_init(SpaprMachineState *spapr);
=20
 #endif /* XICS_SPAPR_H */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d0bfb076df..fc268661bc 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -756,7 +756,7 @@ static int kvm_get_fp(CPUState *cs)
 static int kvm_get_vpa(CPUState *cs)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
     struct kvm_one_reg reg;
     int ret;
=20
@@ -796,7 +796,7 @@ static int kvm_get_vpa(CPUState *cs)
 static int kvm_put_vpa(CPUState *cs)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-    sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
+    SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
     struct kvm_one_reg reg;
     int ret;
=20
--=20
2.20.1
