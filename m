Received: from eggs.gnu.org ([2001:4830:134:3::10]:46972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgnB-0002zo-Oe
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgn9-00083d-UN
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:44:49 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 12 Jun 2018 12:44:27 +0200
Message-Id: <20180612104430.25745-6-kraxel@redhat.com>
In-Reply-To: <20180612104430.25745-1-kraxel@redhat.com>
References: <20180612104430.25745-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/8] object: fix OBJ_PROP_LINK_UNREF_ON_RELEASE
 ambivalence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Zhang Chen <zhangckid@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

A link property can be set during creation, with
object_property_add_link() and later with object_property_set_link().

add_link() doesn't add a reference to the target object, while
set_link() does.

Furthemore, OBJ_PROP_LINK_UNREF_ON_RELEASE flags, set during add_link,
says whether a reference must be released when the property is destroyed.
This can lead to leaks if the property was later set_link(), as the
added reference is never released.

Instead, rename OBJ_PROP_LINK_UNREF_ON_RELEASE to OBJ_PROP_LINK_STRONG
and use that has an indication on how the link handle reference
management in set_link().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180531195119.22021-3-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qom/object.h      | 12 +++++++++---
 hw/core/qdev-properties.c |  2 +-
 hw/core/qdev.c            |  2 +-
 hw/display/xlnx_dp.c      |  2 +-
 hw/dma/xilinx_axidma.c    |  4 ++--
 hw/dma/xlnx-zdma.c        |  2 +-
 hw/i386/pc.c              |  2 +-
 hw/i386/pc_piix.c         |  2 +-
 hw/i386/pc_q35.c          |  2 +-
 hw/ipmi/ipmi.c            |  2 +-
 hw/net/xilinx_axienet.c   |  4 ++--
 hw/ssi/xilinx_spips.c     |  2 +-
 net/can/can_host.c        |  2 +-
 net/colo-compare.c        |  2 +-
 qom/object.c              |  8 +++++---
 target/arm/cpu.c          |  4 ++--
 ui/console.c              |  2 +-
 17 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index a0c78c76f7..f3d2308d56 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1103,6 +1103,11 @@ char *object_property_get_str(Object *obj, const c=
har *name,
  * @errp: returns an error if this function fails
  *
  * Writes an object's canonical path to a property.
+ *
+ * If the link property was created with
+ * <code>OBJ_PROP_LINK_STRONG</code> bit, the old target object is
+ * unreferenced, and a reference is added to the new target object.
+ *
  */
 void object_property_set_link(Object *obj, Object *value,
                               const char *name, Error **errp);
@@ -1394,7 +1399,7 @@ void object_property_add_child(Object *obj, const c=
har *name,
=20
 typedef enum {
     /* Unref the link pointer when the property is deleted */
-    OBJ_PROP_LINK_UNREF_ON_RELEASE =3D 0x1,
+    OBJ_PROP_LINK_STRONG =3D 0x1,
 } ObjectPropertyLinkFlags;
=20
 /**
@@ -1432,8 +1437,9 @@ void object_property_allow_set_link(const Object *,=
 const char *,
  * link property.  The reference count for <code>*@child</code> is
  * managed by the property from after the function returns till the
  * property is deleted with object_property_del().  If the
- * <code>@flags</code> <code>OBJ_PROP_LINK_UNREF_ON_RELEASE</code> bit i=
s set,
- * the reference count is decremented when the property is deleted.
+ * <code>@flags</code> <code>OBJ_PROP_LINK_STRONG</code> bit is set,
+ * the reference count is decremented when the property is deleted or
+ * modified.
  */
 void object_property_add_link(Object *obj, const char *name,
                               const char *type, Object **child,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 989778ab7f..35072dec1e 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1308,7 +1308,7 @@ static void create_link_property(Object *obj, Prope=
rty *prop, Error **errp)
     object_property_add_link(obj, prop->name, prop->link_type,
                              child,
                              qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             OBJ_PROP_LINK_STRONG,
                              errp);
 }
=20
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index ffec461791..cf0db4b6da 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -409,7 +409,7 @@ void qdev_init_gpio_out_named(DeviceState *dev, qemu_=
irq *pins,
         object_property_add_link(OBJECT(dev), propname, TYPE_IRQ,
                                  (Object **)&pins[i],
                                  object_property_allow_set_link,
-                                 OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                                 OBJ_PROP_LINK_STRONG,
                                  &error_abort);
         g_free(propname);
     }
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index c32ab083f8..51301220e8 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1223,7 +1223,7 @@ static void xlnx_dp_init(Object *obj)
     object_property_add_link(obj, "dpdma", TYPE_XLNX_DPDMA,
                              (Object **) &s->dpdma,
                              xlnx_dp_set_dpdma,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             OBJ_PROP_LINK_STRONG,
                              &error_abort);
=20
     /*
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 9b48103574..401a328e27 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -525,12 +525,12 @@ static void xilinx_axidma_realize(DeviceState *dev,=
 Error **errp)
     object_property_add_link(OBJECT(ds), "dma", TYPE_XILINX_AXI_DMA,
                              (Object **)&ds->dma,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             OBJ_PROP_LINK_STRONG,
                              &local_err);
     object_property_add_link(OBJECT(cs), "dma", TYPE_XILINX_AXI_DMA,
                              (Object **)&cs->dma,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             OBJ_PROP_LINK_STRONG,
                              &local_err);
     if (local_err) {
         goto xilinx_axidma_realize_fail;
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 8eea757aff..b6745f5bcf 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -787,7 +787,7 @@ static void zdma_init(Object *obj)
     object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
                              (Object **)&s->dma_mr,
                              qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             OBJ_PROP_LINK_STRONG,
                              &error_abort);
 }
=20
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f3befe6721..ea57a46f81 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -483,7 +483,7 @@ void pc_cmos_init(PCMachineState *pcms,
                              TYPE_ISA_DEVICE,
                              (Object **)&pcms->rtc,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE, &error_abor=
t);
+                             OBJ_PROP_LINK_STRONG, &error_abort);
     object_property_set_link(OBJECT(pcms), OBJECT(s),
                              "rtc_state", &error_abort);
=20
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3d81136065..d2f0d60361 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -289,7 +289,7 @@ static void pc_init1(MachineState *machine,
                                  TYPE_HOTPLUG_HANDLER,
                                  (Object **)&pcms->acpi_dev,
                                  object_property_allow_set_link,
-                                 OBJ_PROP_LINK_UNREF_ON_RELEASE, &error_=
abort);
+                                 OBJ_PROP_LINK_STRONG, &error_abort);
         object_property_set_link(OBJECT(machine), OBJECT(piix4_pm),
                                  PC_MACHINE_ACPI_DEVICE_PROP, &error_abo=
rt);
     }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b60cbb9266..5be6ef73bb 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -194,7 +194,7 @@ static void pc_q35_init(MachineState *machine)
                              TYPE_HOTPLUG_HANDLER,
                              (Object **)&pcms->acpi_dev,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE, &error_abor=
t);
+                             OBJ_PROP_LINK_STRONG, &error_abort);
     object_property_set_link(OBJECT(machine), OBJECT(lpc),
                              PC_MACHINE_ACPI_DEVICE_PROP, &error_abort);
=20
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index 9be281fd87..63c031703d 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -104,7 +104,7 @@ void ipmi_bmc_find_and_link(Object *obj, Object **bmc=
)
 {
     object_property_add_link(obj, "bmc", TYPE_IPMI_BMC, bmc,
                              isa_ipmi_bmc_check,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             OBJ_PROP_LINK_STRONG,
                              &error_abort);
 }
=20
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index d4c2c89dc1..cc880a3d08 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -951,12 +951,12 @@ static void xilinx_enet_realize(DeviceState *dev, E=
rror **errp)
     object_property_add_link(OBJECT(ds), "enet", "xlnx.axi-ethernet",
                              (Object **) &ds->enet,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             OBJ_PROP_LINK_STRONG,
                              &local_err);
     object_property_add_link(OBJECT(cs), "enet", "xlnx.axi-ethernet",
                              (Object **) &cs->enet,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             OBJ_PROP_LINK_STRONG,
                              &local_err);
     if (local_err) {
         goto xilinx_enet_realize_fail;
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 03f5faee4b..f599025956 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1346,7 +1346,7 @@ static void xlnx_zynqmp_qspips_init(Object *obj)
     object_property_add_link(obj, "stream-connected-dma", TYPE_STREAM_SL=
AVE,
                              (Object **)&rq->dma,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             OBJ_PROP_LINK_STRONG,
                              NULL);
 }
=20
diff --git a/net/can/can_host.c b/net/can/can_host.c
index c3d26521cd..c79347abab 100644
--- a/net/can/can_host.c
+++ b/net/can/can_host.c
@@ -77,7 +77,7 @@ static void can_host_instance_init(Object *obj)
     object_property_add_link(obj, "canbus", TYPE_CAN_BUS,
                              (Object **)&ch->bus,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             OBJ_PROP_LINK_STRONG,
                              &error_abort);
 }
=20
diff --git a/net/colo-compare.c b/net/colo-compare.c
index c3a2be4c90..dd745a491b 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -980,7 +980,7 @@ static void colo_compare_init(Object *obj)
     object_property_add_link(obj, "iothread", TYPE_IOTHREAD,
                             (Object **)&s->iothread,
                             object_property_allow_set_link,
-                            OBJ_PROP_LINK_UNREF_ON_RELEASE, NULL);
+                            OBJ_PROP_LINK_STRONG, NULL);
=20
     s->vnet_hdr =3D false;
     object_property_add_bool(obj, "vnet_hdr_support", compare_get_vnet_h=
dr,
diff --git a/qom/object.c b/qom/object.c
index cb7a8cd589..e6462f289c 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1564,9 +1564,11 @@ static void object_set_link_property(Object *obj, =
Visitor *v,
         return;
     }
=20
-    object_ref(new_target);
     *child =3D new_target;
-    object_unref(old_target);
+    if (prop->flags =3D=3D OBJ_PROP_LINK_STRONG) {
+        object_ref(new_target);
+        object_unref(old_target);
+    }
 }
=20
 static Object *object_resolve_link_property(Object *parent, void *opaque=
, const gchar *part)
@@ -1581,7 +1583,7 @@ static void object_release_link_property(Object *ob=
j, const char *name,
 {
     LinkProperty *prop =3D opaque;
=20
-    if ((prop->flags & OBJ_PROP_LINK_UNREF_ON_RELEASE) && *prop->child) =
{
+    if ((prop->flags & OBJ_PROP_LINK_STRONG) && *prop->child) {
         object_unref(*prop->child);
     }
     g_free(prop);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5d60893a07..ab047b9402 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -690,7 +690,7 @@ static void arm_cpu_post_init(Object *obj)
                                  TYPE_MEMORY_REGION,
                                  (Object **)&cpu->secure_memory,
                                  qdev_prop_allow_set_link_before_realize=
,
-                                 OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                                 OBJ_PROP_LINK_STRONG,
                                  &error_abort);
 #endif
     }
@@ -718,7 +718,7 @@ static void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_M_SECURITY)) {
         object_property_add_link(obj, "idau", TYPE_IDAU_INTERFACE, &cpu-=
>idau,
                                  qdev_prop_allow_set_link_before_realize=
,
-                                 OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                                 OBJ_PROP_LINK_STRONG,
                                  &error_abort);
         qdev_property_add_static(DEVICE(obj), &arm_cpu_initsvtor_propert=
y,
                                  &error_abort);
diff --git a/ui/console.c b/ui/console.c
index ef1247f872..bc58458ee8 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1287,7 +1287,7 @@ static QemuConsole *new_console(DisplayState *ds, c=
onsole_type_t console_type,
     object_property_add_link(obj, "device", TYPE_DEVICE,
                              (Object **)&s->device,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             OBJ_PROP_LINK_STRONG,
                              &error_abort);
     object_property_add_uint32_ptr(obj, "head",
                                    &s->head, &error_abort);
--=20
2.9.3
