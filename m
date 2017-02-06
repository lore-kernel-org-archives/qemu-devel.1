Received: from eggs.gnu.org ([2001:4830:134:3::10]:35319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caYHL-0004cm-I6
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caYHI-00008h-SR
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:39:39 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  6 Feb 2017 12:39:27 +1100
Message-Id: <20170206013927.13693-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170206013927.13693-1-david@gibson.dropbear.id.au>
References: <20170206013927.13693-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] Split ISA and sysbus versions of m48t59
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, edgar.iglesias@gmail.com, michael@walle.cc, proljc@gmail.com, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com, veroniabahaa@gmail.com, mst@redhat.com, armbru@redhat.com, agraf@suse.de, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The m48t59 device supports both ISA and direct sysbus attached versions o=
f
the device in the one .c file.  This can be awkward for some embedded
machine types which need the sysbus M48T59, but don't want to pull in the
ISA bus code and its other dependencies.

Therefore, this patch splits out the code for the ISA attached M48T59 int=
o
its own C file.  It will be built when both CONFIG_M48T59 and
CONFIG_ISA_BUS are enabled.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/timer/Makefile.objs     |   3 +
 hw/timer/m48t59-internal.h |  82 ++++++++++++++++
 hw/timer/m48t59-isa.c      | 181 +++++++++++++++++++++++++++++++++++
 hw/timer/m48t59.c          | 228 ++++-----------------------------------=
------
 4 files changed, 284 insertions(+), 210 deletions(-)
 create mode 100644 hw/timer/m48t59-internal.h
 create mode 100644 hw/timer/m48t59-isa.c

diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 71994f2..fc99668 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -6,6 +6,9 @@ common-obj-$(CONFIG_DS1338) +=3D ds1338.o
 common-obj-$(CONFIG_HPET) +=3D hpet.o
 common-obj-$(CONFIG_I8254) +=3D i8254_common.o i8254.o
 common-obj-$(CONFIG_M48T59) +=3D m48t59.o
+ifeq ($(CONFIG_ISA_BUS),y)
+common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
+endif
 common-obj-$(CONFIG_PL031) +=3D pl031.o
 common-obj-$(CONFIG_PUV3) +=3D puv3_ost.o
 common-obj-$(CONFIG_TWL92230) +=3D twl92230.o
diff --git a/hw/timer/m48t59-internal.h b/hw/timer/m48t59-internal.h
new file mode 100644
index 0000000..32ae957
--- /dev/null
+++ b/hw/timer/m48t59-internal.h
@@ -0,0 +1,82 @@
+/*
+ * QEMU M48T59 and M48T08 NVRAM emulation (common header)
+ *
+ * Copyright (c) 2003-2005, 2007 Jocelyn Mayer
+ * Copyright (c) 2013 Herv=C3=A9 Poussineau
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#ifndef HW_M48T59_INTERNAL_H
+#define HW_M48T59_INTERNAL_H 1
+
+//#define DEBUG_NVRAM
+
+#if defined(DEBUG_NVRAM)
+#define NVRAM_PRINTF(fmt, ...) do { printf(fmt , ## __VA_ARGS__); } whil=
e (0)
+#else
+#define NVRAM_PRINTF(fmt, ...) do { } while (0)
+#endif
+
+/*
+ * The M48T02, M48T08 and M48T59 chips are very similar. The newer '59 h=
as
+ * alarm and a watchdog timer and related control registers. In the
+ * PPC platform there is also a nvram lock function.
+ */
+
+typedef struct M48txxInfo {
+    const char *bus_name;
+    uint32_t model; /* 2 =3D m48t02, 8 =3D m48t08, 59 =3D m48t59 */
+    uint32_t size;
+} M48txxInfo;
+
+typedef struct M48t59State {
+    /* Hardware parameters */
+    qemu_irq IRQ;
+    MemoryRegion iomem;
+    uint32_t size;
+    int32_t base_year;
+    /* RTC management */
+    time_t   time_offset;
+    time_t   stop_time;
+    /* Alarm & watchdog */
+    struct tm alarm;
+    QEMUTimer *alrm_timer;
+    QEMUTimer *wd_timer;
+    /* NVRAM storage */
+    uint8_t *buffer;
+    /* Model parameters */
+    uint32_t model; /* 2 =3D m48t02, 8 =3D m48t08, 59 =3D m48t59 */
+    /* NVRAM storage */
+    uint16_t addr;
+    uint8_t  lock;
+} M48t59State;
+
+uint32_t m48t59_read(M48t59State *NVRAM, uint32_t addr);
+void m48t59_write(M48t59State *NVRAM, uint32_t addr, uint32_t val);
+void m48t59_reset_common(M48t59State *NVRAM);
+void m48t59_realize_common(M48t59State *s, Error **errp);
+
+static inline void m48t59_toggle_lock(M48t59State *NVRAM, int lock)
+{
+    NVRAM->lock ^=3D 1 << lock;
+}
+
+extern const MemoryRegionOps m48t59_io_ops;
+
+#endif /* HW_M48T59_INTERNAL_H */
diff --git a/hw/timer/m48t59-isa.c b/hw/timer/m48t59-isa.c
new file mode 100644
index 0000000..ea1ba70
--- /dev/null
+++ b/hw/timer/m48t59-isa.c
@@ -0,0 +1,181 @@
+/*
+ * QEMU M48T59 and M48T08 NVRAM emulation (ISA bus interface
+ *
+ * Copyright (c) 2003-2005, 2007 Jocelyn Mayer
+ * Copyright (c) 2013 Herv=C3=A9 Poussineau
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "hw/isa/isa.h"
+#include "hw/timer/m48t59.h"
+#include "m48t59-internal.h"
+
+#define TYPE_M48TXX_ISA "isa-m48txx"
+#define M48TXX_ISA_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(M48txxISADeviceClass, (obj), TYPE_M48TXX_ISA)
+#define M48TXX_ISA_CLASS(klass) \
+    OBJECT_CLASS_CHECK(M48txxISADeviceClass, (klass), TYPE_M48TXX_ISA)
+#define M48TXX_ISA(obj) \
+    OBJECT_CHECK(M48txxISAState, (obj), TYPE_M48TXX_ISA)
+
+typedef struct M48txxISAState {
+    ISADevice parent_obj;
+    M48t59State state;
+    uint32_t io_base;
+    MemoryRegion io;
+} M48txxISAState;
+
+typedef struct M48txxISADeviceClass {
+    ISADeviceClass parent_class;
+    M48txxInfo info;
+} M48txxISADeviceClass;
+
+static M48txxInfo m48txx_isa_info[] =3D {
+    {
+        .bus_name =3D "isa-m48t59",
+        .model =3D 59,
+        .size =3D 0x2000,
+    }
+};
+
+Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
+                       int base_year, int model)
+{
+    DeviceState *dev;
+    int i;
+
+    for (i =3D 0; i < ARRAY_SIZE(m48txx_isa_info); i++) {
+        if (m48txx_isa_info[i].size !=3D size ||
+            m48txx_isa_info[i].model !=3D model) {
+            continue;
+        }
+
+        dev =3D DEVICE(isa_create(bus, m48txx_isa_info[i].bus_name));
+        qdev_prop_set_uint32(dev, "iobase", io_base);
+        qdev_prop_set_int32(dev, "base-year", base_year);
+        qdev_init_nofail(dev);
+        return NVRAM(dev);
+    }
+
+    assert(false);
+    return NULL;
+}
+
+static uint32_t m48txx_isa_read(Nvram *obj, uint32_t addr)
+{
+    M48txxISAState *d =3D M48TXX_ISA(obj);
+    return m48t59_read(&d->state, addr);
+}
+
+static void m48txx_isa_write(Nvram *obj, uint32_t addr, uint32_t val)
+{
+    M48txxISAState *d =3D M48TXX_ISA(obj);
+    m48t59_write(&d->state, addr, val);
+}
+
+static void m48txx_isa_toggle_lock(Nvram *obj, int lock)
+{
+    M48txxISAState *d =3D M48TXX_ISA(obj);
+    m48t59_toggle_lock(&d->state, lock);
+}
+
+static Property m48t59_isa_properties[] =3D {
+    DEFINE_PROP_INT32("base-year", M48txxISAState, state.base_year, 0),
+    DEFINE_PROP_UINT32("iobase", M48txxISAState, io_base, 0x74),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void m48t59_reset_isa(DeviceState *d)
+{
+    M48txxISAState *isa =3D M48TXX_ISA(d);
+    M48t59State *NVRAM =3D &isa->state;
+
+    m48t59_reset_common(NVRAM);
+}
+
+static void m48t59_isa_realize(DeviceState *dev, Error **errp)
+{
+    M48txxISADeviceClass *u =3D M48TXX_ISA_GET_CLASS(dev);
+    ISADevice *isadev =3D ISA_DEVICE(dev);
+    M48txxISAState *d =3D M48TXX_ISA(dev);
+    M48t59State *s =3D &d->state;
+
+    s->model =3D u->info.model;
+    s->size =3D u->info.size;
+    isa_init_irq(isadev, &s->IRQ, 8);
+    m48t59_realize_common(s, errp);
+    memory_region_init_io(&d->io, OBJECT(dev), &m48t59_io_ops, s, "m48t5=
9", 4);
+    if (d->io_base !=3D 0) {
+        isa_register_ioport(isadev, &d->io, d->io_base);
+    }
+}
+
+static void m48txx_isa_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    NvramClass *nc =3D NVRAM_CLASS(klass);
+
+    dc->realize =3D m48t59_isa_realize;
+    dc->reset =3D m48t59_reset_isa;
+    dc->props =3D m48t59_isa_properties;
+    nc->read =3D m48txx_isa_read;
+    nc->write =3D m48txx_isa_write;
+    nc->toggle_lock =3D m48txx_isa_toggle_lock;
+}
+
+static void m48txx_isa_concrete_class_init(ObjectClass *klass, void *dat=
a)
+{
+    M48txxISADeviceClass *u =3D M48TXX_ISA_CLASS(klass);
+    M48txxInfo *info =3D data;
+
+    u->info =3D *info;
+}
+
+static const TypeInfo m48txx_isa_type_info =3D {
+    .name =3D TYPE_M48TXX_ISA,
+    .parent =3D TYPE_ISA_DEVICE,
+    .instance_size =3D sizeof(M48txxISAState),
+    .abstract =3D true,
+    .class_init =3D m48txx_isa_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_NVRAM },
+        { }
+    }
+};
+
+static void m48t59_isa_register_types(void)
+{
+    TypeInfo isa_type_info =3D {
+        .parent =3D TYPE_M48TXX_ISA,
+        .class_size =3D sizeof(M48txxISADeviceClass),
+        .class_init =3D m48txx_isa_concrete_class_init,
+    };
+    int i;
+
+    type_register_static(&m48txx_isa_type_info);
+
+    for (i =3D 0; i < ARRAY_SIZE(m48txx_isa_info); i++) {
+        isa_type_info.name =3D m48txx_isa_info[i].bus_name;
+        isa_type_info.class_data =3D &m48txx_isa_info[i];
+        type_register(&isa_type_info);
+    }
+}
+
+type_init(m48t59_isa_register_types)
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index e46ca88..0157977 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -29,17 +29,10 @@
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
-#include "hw/isa/isa.h"
 #include "exec/address-spaces.h"
 #include "qemu/bcd.h"
=20
-//#define DEBUG_NVRAM
-
-#if defined(DEBUG_NVRAM)
-#define NVRAM_PRINTF(fmt, ...) do { printf(fmt , ## __VA_ARGS__); } whil=
e (0)
-#else
-#define NVRAM_PRINTF(fmt, ...) do { } while (0)
-#endif
+#include "m48t59-internal.h"
=20
 #define TYPE_M48TXX_SYS_BUS "sysbus-m48txx"
 #define M48TXX_SYS_BUS_GET_CLASS(obj) \
@@ -49,27 +42,6 @@
 #define M48TXX_SYS_BUS(obj) \
     OBJECT_CHECK(M48txxSysBusState, (obj), TYPE_M48TXX_SYS_BUS)
=20
-#define TYPE_M48TXX_ISA "isa-m48txx"
-#define M48TXX_ISA_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(M48txxISADeviceClass, (obj), TYPE_M48TXX_ISA)
-#define M48TXX_ISA_CLASS(klass) \
-    OBJECT_CLASS_CHECK(M48txxISADeviceClass, (klass), TYPE_M48TXX_ISA)
-#define M48TXX_ISA(obj) \
-    OBJECT_CHECK(M48txxISAState, (obj), TYPE_M48TXX_ISA)
-
-/*
- * The M48T02, M48T08 and M48T59 chips are very similar. The newer '59 h=
as
- * alarm and a watchdog timer and related control registers. In the
- * PPC platform there is also a nvram lock function.
- */
-
-typedef struct M48txxInfo {
-    const char *isa_name;
-    const char *sysbus_name;
-    uint32_t model; /* 2 =3D m48t02, 8 =3D m48t08, 59 =3D m48t59 */
-    uint32_t size;
-} M48txxInfo;
-
 /*
  * Chipset docs:
  * http://www.st.com/stonline/products/literature/ds/2410/m48t02.pdf
@@ -77,40 +49,6 @@ typedef struct M48txxInfo {
  * http://www.st.com/stonline/products/literature/od/7001/m48t59y.pdf
  */
=20
-typedef struct M48t59State {
-    /* Hardware parameters */
-    qemu_irq IRQ;
-    MemoryRegion iomem;
-    uint32_t size;
-    int32_t base_year;
-    /* RTC management */
-    time_t   time_offset;
-    time_t   stop_time;
-    /* Alarm & watchdog */
-    struct tm alarm;
-    QEMUTimer *alrm_timer;
-    QEMUTimer *wd_timer;
-    /* NVRAM storage */
-    uint8_t *buffer;
-    /* Model parameters */
-    uint32_t model; /* 2 =3D m48t02, 8 =3D m48t08, 59 =3D m48t59 */
-    /* NVRAM storage */
-    uint16_t addr;
-    uint8_t  lock;
-} M48t59State;
-
-typedef struct M48txxISAState {
-    ISADevice parent_obj;
-    M48t59State state;
-    uint32_t io_base;
-    MemoryRegion io;
-} M48txxISAState;
-
-typedef struct M48txxISADeviceClass {
-    ISADeviceClass parent_class;
-    M48txxInfo info;
-} M48txxISADeviceClass;
-
 typedef struct M48txxSysBusState {
     SysBusDevice parent_obj;
     M48t59State state;
@@ -122,21 +60,17 @@ typedef struct M48txxSysBusDeviceClass {
     M48txxInfo info;
 } M48txxSysBusDeviceClass;
=20
-static M48txxInfo m48txx_info[] =3D {
+static M48txxInfo m48txx_sysbus_info[] =3D {
     {
-        .sysbus_name =3D "sysbus-m48t02",
+        .bus_name =3D "sysbus-m48t02",
         .model =3D 2,
         .size =3D 0x800,
     },{
-        .sysbus_name =3D "sysbus-m48t08",
+        .bus_name =3D "sysbus-m48t08",
         .model =3D 8,
         .size =3D 0x2000,
     },{
-        .sysbus_name =3D "sysbus-m48t59",
-        .model =3D 59,
-        .size =3D 0x2000,
-    },{
-        .isa_name =3D "isa-m48t59",
+        .bus_name =3D "sysbus-m48t59",
         .model =3D 59,
         .size =3D 0x2000,
     }
@@ -248,7 +182,7 @@ static void set_up_watchdog(M48t59State *NVRAM, uint8=
_t value)
 }
=20
 /* Direct access to NVRAM */
-static void m48t59_write(M48t59State *NVRAM, uint32_t addr, uint32_t val=
)
+void m48t59_write(M48t59State *NVRAM, uint32_t addr, uint32_t val)
 {
     struct tm tm;
     int tmp;
@@ -413,7 +347,7 @@ static void m48t59_write(M48t59State *NVRAM, uint32_t=
 addr, uint32_t val)
     }
 }
=20
-static uint32_t m48t59_read(M48t59State *NVRAM, uint32_t addr)
+uint32_t m48t59_read(M48t59State *NVRAM, uint32_t addr)
 {
     struct tm tm;
     uint32_t retval =3D 0xFF;
@@ -517,11 +451,6 @@ static uint32_t m48t59_read(M48t59State *NVRAM, uint=
32_t addr)
     return retval;
 }
=20
-static void m48t59_toggle_lock(M48t59State *NVRAM, int lock)
-{
-    NVRAM->lock ^=3D 1 << lock;
-}
-
 /* IO access to NVRAM */
 static void NVRAM_writeb(void *opaque, hwaddr addr, uint64_t val,
                          unsigned size)
@@ -639,7 +568,7 @@ static const VMStateDescription vmstate_m48t59 =3D {
     }
 };
=20
-static void m48t59_reset_common(M48t59State *NVRAM)
+void m48t59_reset_common(M48t59State *NVRAM)
 {
     NVRAM->addr =3D 0;
     NVRAM->lock =3D 0;
@@ -650,14 +579,6 @@ static void m48t59_reset_common(M48t59State *NVRAM)
         timer_del(NVRAM->wd_timer);
 }
=20
-static void m48t59_reset_isa(DeviceState *d)
-{
-    M48txxISAState *isa =3D M48TXX_ISA(d);
-    M48t59State *NVRAM =3D &isa->state;
-
-    m48t59_reset_common(NVRAM);
-}
-
 static void m48t59_reset_sysbus(DeviceState *d)
 {
     M48txxSysBusState *sys =3D M48TXX_SYS_BUS(d);
@@ -666,7 +587,7 @@ static void m48t59_reset_sysbus(DeviceState *d)
     m48t59_reset_common(NVRAM);
 }
=20
-static const MemoryRegionOps m48t59_io_ops =3D {
+const MemoryRegionOps m48t59_io_ops =3D {
     .read =3D NVRAM_readb,
     .write =3D NVRAM_writeb,
     .impl =3D {
@@ -685,14 +606,13 @@ Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
     SysBusDevice *s;
     int i;
=20
-    for (i =3D 0; i < ARRAY_SIZE(m48txx_info); i++) {
-        if (!m48txx_info[i].sysbus_name ||
-            m48txx_info[i].size !=3D size ||
-            m48txx_info[i].model !=3D model) {
+    for (i =3D 0; i < ARRAY_SIZE(m48txx_sysbus_info); i++) {
+        if (m48txx_sysbus_info[i].size !=3D size ||
+            m48txx_sysbus_info[i].model !=3D model) {
             continue;
         }
=20
-        dev =3D qdev_create(NULL, m48txx_info[i].sysbus_name);
+        dev =3D qdev_create(NULL, m48txx_sysbus_info[i].bus_name);
         qdev_prop_set_int32(dev, "base-year", base_year);
         qdev_init_nofail(dev);
         s =3D SYS_BUS_DEVICE(dev);
@@ -712,31 +632,7 @@ Nvram *m48t59_init(qemu_irq IRQ, hwaddr mem_base,
     return NULL;
 }
=20
-Nvram *m48t59_init_isa(ISABus *bus, uint32_t io_base, uint16_t size,
-                       int base_year, int model)
-{
-    DeviceState *dev;
-    int i;
-
-    for (i =3D 0; i < ARRAY_SIZE(m48txx_info); i++) {
-        if (!m48txx_info[i].isa_name ||
-            m48txx_info[i].size !=3D size ||
-            m48txx_info[i].model !=3D model) {
-            continue;
-        }
-
-        dev =3D DEVICE(isa_create(bus, m48txx_info[i].isa_name));
-        qdev_prop_set_uint32(dev, "iobase", io_base);
-        qdev_prop_set_int32(dev, "base-year", base_year);
-        qdev_init_nofail(dev);
-        return NVRAM(dev);
-    }
-
-    assert(false);
-    return NULL;
-}
-
-static void m48t59_realize_common(M48t59State *s, Error **errp)
+void m48t59_realize_common(M48t59State *s, Error **errp)
 {
     s->buffer =3D g_malloc0(s->size);
     if (s->model =3D=3D 59) {
@@ -748,23 +644,6 @@ static void m48t59_realize_common(M48t59State *s, Er=
ror **errp)
     vmstate_register(NULL, -1, &vmstate_m48t59, s);
 }
=20
-static void m48t59_isa_realize(DeviceState *dev, Error **errp)
-{
-    M48txxISADeviceClass *u =3D M48TXX_ISA_GET_CLASS(dev);
-    ISADevice *isadev =3D ISA_DEVICE(dev);
-    M48txxISAState *d =3D M48TXX_ISA(dev);
-    M48t59State *s =3D &d->state;
-
-    s->model =3D u->info.model;
-    s->size =3D u->info.size;
-    isa_init_irq(isadev, &s->IRQ, 8);
-    m48t59_realize_common(s, errp);
-    memory_region_init_io(&d->io, OBJECT(dev), &m48t59_io_ops, s, "m48t5=
9", 4);
-    if (d->io_base !=3D 0) {
-        isa_register_ioport(isadev, &d->io, d->io_base);
-    }
-}
-
 static int m48t59_init1(SysBusDevice *dev)
 {
     M48txxSysBusDeviceClass *u =3D M48TXX_SYS_BUS_GET_CLASS(dev);
@@ -791,51 +670,6 @@ static int m48t59_init1(SysBusDevice *dev)
     return 0;
 }
=20
-static uint32_t m48txx_isa_read(Nvram *obj, uint32_t addr)
-{
-    M48txxISAState *d =3D M48TXX_ISA(obj);
-    return m48t59_read(&d->state, addr);
-}
-
-static void m48txx_isa_write(Nvram *obj, uint32_t addr, uint32_t val)
-{
-    M48txxISAState *d =3D M48TXX_ISA(obj);
-    m48t59_write(&d->state, addr, val);
-}
-
-static void m48txx_isa_toggle_lock(Nvram *obj, int lock)
-{
-    M48txxISAState *d =3D M48TXX_ISA(obj);
-    m48t59_toggle_lock(&d->state, lock);
-}
-
-static Property m48t59_isa_properties[] =3D {
-    DEFINE_PROP_INT32("base-year", M48txxISAState, state.base_year, 0),
-    DEFINE_PROP_UINT32("iobase", M48txxISAState, io_base, 0x74),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void m48txx_isa_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-    NvramClass *nc =3D NVRAM_CLASS(klass);
-
-    dc->realize =3D m48t59_isa_realize;
-    dc->reset =3D m48t59_reset_isa;
-    dc->props =3D m48t59_isa_properties;
-    nc->read =3D m48txx_isa_read;
-    nc->write =3D m48txx_isa_write;
-    nc->toggle_lock =3D m48txx_isa_toggle_lock;
-}
-
-static void m48txx_isa_concrete_class_init(ObjectClass *klass, void *dat=
a)
-{
-    M48txxISADeviceClass *u =3D M48TXX_ISA_CLASS(klass);
-    M48txxInfo *info =3D data;
-
-    u->info =3D *info;
-}
-
 static uint32_t m48txx_sysbus_read(Nvram *obj, uint32_t addr)
 {
     M48txxSysBusState *d =3D M48TXX_SYS_BUS(obj);
@@ -899,18 +733,6 @@ static const TypeInfo m48txx_sysbus_type_info =3D {
     }
 };
=20
-static const TypeInfo m48txx_isa_type_info =3D {
-    .name =3D TYPE_M48TXX_ISA,
-    .parent =3D TYPE_ISA_DEVICE,
-    .instance_size =3D sizeof(M48txxISAState),
-    .abstract =3D true,
-    .class_init =3D m48txx_isa_class_init,
-    .interfaces =3D (InterfaceInfo[]) {
-        { TYPE_NVRAM },
-        { }
-    }
-};
-
 static void m48t59_register_types(void)
 {
     TypeInfo sysbus_type_info =3D {
@@ -918,29 +740,15 @@ static void m48t59_register_types(void)
         .class_size =3D sizeof(M48txxSysBusDeviceClass),
         .class_init =3D m48txx_sysbus_concrete_class_init,
     };
-    TypeInfo isa_type_info =3D {
-        .parent =3D TYPE_M48TXX_ISA,
-        .class_size =3D sizeof(M48txxISADeviceClass),
-        .class_init =3D m48txx_isa_concrete_class_init,
-    };
     int i;
=20
     type_register_static(&nvram_info);
     type_register_static(&m48txx_sysbus_type_info);
-    type_register_static(&m48txx_isa_type_info);
=20
-    for (i =3D 0; i < ARRAY_SIZE(m48txx_info); i++) {
-        if (m48txx_info[i].sysbus_name) {
-            sysbus_type_info.name =3D m48txx_info[i].sysbus_name;
-            sysbus_type_info.class_data =3D &m48txx_info[i];
-            type_register(&sysbus_type_info);
-        }
-
-        if (m48txx_info[i].isa_name) {
-            isa_type_info.name =3D m48txx_info[i].isa_name;
-            isa_type_info.class_data =3D &m48txx_info[i];
-            type_register(&isa_type_info);
-        }
+    for (i =3D 0; i < ARRAY_SIZE(m48txx_sysbus_info); i++) {
+        sysbus_type_info.name =3D m48txx_sysbus_info[i].bus_name;
+        sysbus_type_info.class_data =3D &m48txx_sysbus_info[i];
+        type_register(&sysbus_type_info);
     }
 }
=20
--=20
2.9.3
