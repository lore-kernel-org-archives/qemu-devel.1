Received: from eggs.gnu.org ([2001:4830:134:3::10]:57969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e9fY0-00087o-3e
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 19:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1e9fXv-0008Rf-SX
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 19:02:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1e9fXv-0008R3-J2
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 19:02:11 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 31 Oct 2017 19:02:05 -0400
Message-Id: <20171031230206.32731-2-jsnow@redhat.com>
In-Reply-To: <20171031230206.32731-1-jsnow@redhat.com>
References: <20171031230206.32731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] hw/ide/ahci: Move allwinner code into a
 separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The allwinner code is only needed for the allwinner board (for which
we also have a separate CONFIG_ALLWINNER_A10 config switch), so it
does not make sense that we compile this for all the other boards
that need AHCI, too. Let's move it to a separate file that is only
compiled when CONFIG_ALLWINNER_A10 is set.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 1508784509-29377-1-git-send-email-thuth@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/Makefile.objs    |   1 +
 hw/ide/ahci-allwinner.c | 127 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ide/ahci.c           |  95 ------------------------------------
 3 files changed, 128 insertions(+), 95 deletions(-)
 create mode 100644 hw/ide/ahci-allwinner.c

diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
index 729e9bd..f0edca3 100644
--- a/hw/ide/Makefile.objs
+++ b/hw/ide/Makefile.objs
@@ -10,3 +10,4 @@ common-obj-$(CONFIG_IDE_VIA) +=3D via.o
 common-obj-$(CONFIG_MICRODRIVE) +=3D microdrive.o
 common-obj-$(CONFIG_AHCI) +=3D ahci.o
 common-obj-$(CONFIG_AHCI) +=3D ich.o
+common-obj-$(CONFIG_ALLWINNER_A10) +=3D ahci-allwinner.o
diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
new file mode 100644
index 0000000..c3f1604
--- /dev/null
+++ b/hw/ide/ahci-allwinner.c
@@ -0,0 +1,127 @@
+/*
+ * QEMU Allwinner AHCI Emulation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "qemu/error-report.h"
+#include "sysemu/block-backend.h"
+#include "sysemu/dma.h"
+#include "hw/ide/internal.h"
+#include "hw/ide/ahci_internal.h"
+
+#include "trace.h"
+
+#define ALLWINNER_AHCI_BISTAFR    ((0xa0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_BISTCR     ((0xa4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_BISTFCTR   ((0xa8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_BISTSR     ((0xac - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_BISTDECR   ((0xb0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_DIAGNR0    ((0xb4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_DIAGNR1    ((0xb8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_OOBR       ((0xbc - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_PHYCS0R    ((0xc0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_PHYCS1R    ((0xc4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_PHYCS2R    ((0xc8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_TIMER1MS   ((0xe0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_GPARAM1R   ((0xe8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_GPARAM2R   ((0xec - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_PPARAMR    ((0xf0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_TESTR      ((0xf4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_VERSIONR   ((0xf8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_IDR        ((0xfc - ALLWINNER_AHCI_MMIO_OFF) / 4)
+#define ALLWINNER_AHCI_RWCR       ((0xfc - ALLWINNER_AHCI_MMIO_OFF) / 4)
+
+static uint64_t allwinner_ahci_mem_read(void *opaque, hwaddr addr,
+                                        unsigned size)
+{
+    AllwinnerAHCIState *a =3D opaque;
+    AHCIState *s =3D &(SYSBUS_AHCI(a)->ahci);
+    uint64_t val =3D a->regs[addr / 4];
+
+    switch (addr / 4) {
+    case ALLWINNER_AHCI_PHYCS0R:
+        val |=3D 0x2 << 28;
+        break;
+    case ALLWINNER_AHCI_PHYCS2R:
+        val &=3D ~(0x1 << 24);
+        break;
+    }
+    trace_allwinner_ahci_mem_read(s, a, addr, val, size);
+    return  val;
+}
+
+static void allwinner_ahci_mem_write(void *opaque, hwaddr addr,
+                                     uint64_t val, unsigned size)
+{
+    AllwinnerAHCIState *a =3D opaque;
+    AHCIState *s =3D &(SYSBUS_AHCI(a)->ahci);
+
+    trace_allwinner_ahci_mem_write(s, a, addr, val, size);
+    a->regs[addr / 4] =3D val;
+}
+
+static const MemoryRegionOps allwinner_ahci_mem_ops =3D {
+    .read =3D allwinner_ahci_mem_read,
+    .write =3D allwinner_ahci_mem_write,
+    .valid.min_access_size =3D 4,
+    .valid.max_access_size =3D 4,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+};
+
+static void allwinner_ahci_init(Object *obj)
+{
+    SysbusAHCIState *s =3D SYSBUS_AHCI(obj);
+    AllwinnerAHCIState *a =3D ALLWINNER_AHCI(obj);
+
+    memory_region_init_io(&a->mmio, OBJECT(obj), &allwinner_ahci_mem_ops=
, a,
+                          "allwinner-ahci", ALLWINNER_AHCI_MMIO_SIZE);
+    memory_region_add_subregion(&s->ahci.mem, ALLWINNER_AHCI_MMIO_OFF,
+                                &a->mmio);
+}
+
+static const VMStateDescription vmstate_allwinner_ahci =3D {
+    .name =3D "allwinner-ahci",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AllwinnerAHCIState,
+                             ALLWINNER_AHCI_MMIO_SIZE / 4),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_ahci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->vmsd =3D &vmstate_allwinner_ahci;
+}
+
+static const TypeInfo allwinner_ahci_info =3D {
+    .name          =3D TYPE_ALLWINNER_AHCI,
+    .parent        =3D TYPE_SYSBUS_AHCI,
+    .instance_size =3D sizeof(AllwinnerAHCIState),
+    .instance_init =3D allwinner_ahci_init,
+    .class_init    =3D allwinner_ahci_class_init,
+};
+
+static void sysbus_ahci_register_types(void)
+{
+    type_register_static(&allwinner_ahci_info);
+}
+
+type_init(sysbus_ahci_register_types)
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 32d1296..373311f 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1737,104 +1737,9 @@ static const TypeInfo sysbus_ahci_info =3D {
     .class_init    =3D sysbus_ahci_class_init,
 };
=20
-#define ALLWINNER_AHCI_BISTAFR    ((0xa0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_BISTCR     ((0xa4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_BISTFCTR   ((0xa8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_BISTSR     ((0xac - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_BISTDECR   ((0xb0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_DIAGNR0    ((0xb4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_DIAGNR1    ((0xb8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_OOBR       ((0xbc - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_PHYCS0R    ((0xc0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_PHYCS1R    ((0xc4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_PHYCS2R    ((0xc8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_TIMER1MS   ((0xe0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_GPARAM1R   ((0xe8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_GPARAM2R   ((0xec - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_PPARAMR    ((0xf0 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_TESTR      ((0xf4 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_VERSIONR   ((0xf8 - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_IDR        ((0xfc - ALLWINNER_AHCI_MMIO_OFF) / 4)
-#define ALLWINNER_AHCI_RWCR       ((0xfc - ALLWINNER_AHCI_MMIO_OFF) / 4)
-
-static uint64_t allwinner_ahci_mem_read(void *opaque, hwaddr addr,
-                                        unsigned size)
-{
-    AllwinnerAHCIState *a =3D opaque;
-    AHCIState *s =3D &(SYSBUS_AHCI(a)->ahci);
-    uint64_t val =3D a->regs[addr/4];
-
-    switch (addr / 4) {
-    case ALLWINNER_AHCI_PHYCS0R:
-        val |=3D 0x2 << 28;
-        break;
-    case ALLWINNER_AHCI_PHYCS2R:
-        val &=3D ~(0x1 << 24);
-        break;
-    }
-    trace_allwinner_ahci_mem_read(s, a, addr, val, size);
-    return  val;
-}
-
-static void allwinner_ahci_mem_write(void *opaque, hwaddr addr,
-                                     uint64_t val, unsigned size)
-{
-    AllwinnerAHCIState *a =3D opaque;
-    AHCIState *s =3D &(SYSBUS_AHCI(a)->ahci);
-
-    trace_allwinner_ahci_mem_write(s, a, addr, val, size);
-    a->regs[addr/4] =3D val;
-}
-
-static const MemoryRegionOps allwinner_ahci_mem_ops =3D {
-    .read =3D allwinner_ahci_mem_read,
-    .write =3D allwinner_ahci_mem_write,
-    .valid.min_access_size =3D 4,
-    .valid.max_access_size =3D 4,
-    .endianness =3D DEVICE_LITTLE_ENDIAN,
-};
-
-static void allwinner_ahci_init(Object *obj)
-{
-    SysbusAHCIState *s =3D SYSBUS_AHCI(obj);
-    AllwinnerAHCIState *a =3D ALLWINNER_AHCI(obj);
-
-    memory_region_init_io(&a->mmio, OBJECT(obj), &allwinner_ahci_mem_ops=
, a,
-                          "allwinner-ahci", ALLWINNER_AHCI_MMIO_SIZE);
-    memory_region_add_subregion(&s->ahci.mem, ALLWINNER_AHCI_MMIO_OFF,
-                                &a->mmio);
-}
-
-static const VMStateDescription vmstate_allwinner_ahci =3D {
-    .name =3D "allwinner-ahci",
-    .version_id =3D 1,
-    .minimum_version_id =3D 1,
-    .fields =3D (VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(regs, AllwinnerAHCIState,
-                             ALLWINNER_AHCI_MMIO_SIZE/4),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void allwinner_ahci_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-
-    dc->vmsd =3D &vmstate_allwinner_ahci;
-}
-
-static const TypeInfo allwinner_ahci_info =3D {
-    .name          =3D TYPE_ALLWINNER_AHCI,
-    .parent        =3D TYPE_SYSBUS_AHCI,
-    .instance_size =3D sizeof(AllwinnerAHCIState),
-    .instance_init =3D allwinner_ahci_init,
-    .class_init    =3D allwinner_ahci_class_init,
-};
-
 static void sysbus_ahci_register_types(void)
 {
     type_register_static(&sysbus_ahci_info);
-    type_register_static(&allwinner_ahci_info);
 }
=20
 type_init(sysbus_ahci_register_types)
--=20
2.9.5
