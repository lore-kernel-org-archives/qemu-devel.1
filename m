Received: from eggs.gnu.org ([2001:4830:134:3::10]:41346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQm32-0005p0-9I
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 22:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQm2z-00014I-9W
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 22:25:00 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:28:03 +0300
Message-Id: <e03e0a8c0fcb59b032fb93dd90662201a38fc09a.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 58/61] hw/misc/pvpanic: extract public API from
 i386/pc to "hw/misc/pvpanic.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

and remove the old i386/pc dependency.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/i386/acpi-build.c      |  2 +-
 hw/misc/pvpanic.c         |  9 ++++-----
 include/hw/i386/pc.h      |  3 ---
 include/hw/misc/pvpanic.h | 21 +++++++++++++++++++++
 4 files changed, 26 insertions(+), 9 deletions(-)
 create mode 100644 include/hw/misc/pvpanic.h

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 73519ab3ac..63bbc610eb 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -28,8 +28,8 @@
 #include "qemu/error-report.h"
 #include "hw/pci/pci.h"
 #include "qom/cpu.h"
-#include "hw/i386/pc.h"
 #include "target/i386/cpu.h"
+#include "hw/misc/pvpanic.h"
 #include "hw/timer/hpet.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index 3a0e4ba828..b26250dec9 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -17,7 +17,7 @@
 #include "qemu/log.h"
=20
 #include "hw/nvram/fw_cfg.h"
-#include "hw/i386/pc.h"
+#include "hw/misc/pvpanic.h"
=20
 /* The bit of supported pv event */
 #define PVPANIC_F_PANICKED      0
@@ -25,9 +25,8 @@
 /* The pv event value */
 #define PVPANIC_PANICKED        (1 << PVPANIC_F_PANICKED)
=20
-#define TYPE_ISA_PVPANIC_DEVICE    "pvpanic"
 #define ISA_PVPANIC_DEVICE(obj)    \
-    OBJECT_CHECK(PVPanicState, (obj), TYPE_ISA_PVPANIC_DEVICE)
+    OBJECT_CHECK(PVPanicState, (obj), TYPE_PVPANIC)
=20
 static void handle_event(int event)
 {
@@ -104,7 +103,7 @@ static void pvpanic_isa_realizefn(DeviceState *dev, E=
rror **errp)
=20
 uint16_t pvpanic_port(void)
 {
-    Object *o =3D object_resolve_path_type("", TYPE_ISA_PVPANIC_DEVICE, =
NULL);
+    Object *o =3D object_resolve_path_type("", TYPE_PVPANIC, NULL);
     if (!o) {
         return 0;
     }
@@ -126,7 +125,7 @@ static void pvpanic_isa_class_init(ObjectClass *klass=
, void *data)
 }
=20
 static TypeInfo pvpanic_isa_info =3D {
-    .name          =3D TYPE_ISA_PVPANIC_DEVICE,
+    .name          =3D TYPE_PVPANIC,
     .parent        =3D TYPE_ISA_DEVICE,
     .instance_size =3D sizeof(PVPanicState),
     .instance_init =3D pvpanic_isa_initfn,
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ab84e31cce..6f77eb0665 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -306,9 +306,6 @@ int piix4_init(PCIBus *bus, ISABus **isa_bus, int dev=
fn);
 void pc_system_firmware_init(MemoryRegion *rom_memory,
                              bool isapc_ram_fw);
=20
-/* pvpanic.c */
-uint16_t pvpanic_port(void);
-
 /* acpi-build.c */
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
                        const CPUArchIdList *apic_ids, GArray *entry);
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
new file mode 100644
index 0000000000..36a54e270c
--- /dev/null
+++ b/include/hw/misc/pvpanic.h
@@ -0,0 +1,21 @@
+/*
+ * QEMU simulated pvpanic device.
+ *
+ * Copyright Fujitsu, Corp. 2013
+ *
+ * Authors:
+ *     Wen Congyang <wency@cn.fujitsu.com>
+ *     Hu Tao <hutao@cn.fujitsu.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+#ifndef HW_MISC_PVPANIC_H
+#define HW_MISC_PVPANIC_H
+
+#define TYPE_PVPANIC "pvpanic"
+
+uint16_t pvpanic_port(void);
+
+#endif
--=20
2.11.0
