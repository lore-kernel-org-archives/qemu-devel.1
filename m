Received: from eggs.gnu.org ([209.51.188.92]:53849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCAbY-0007wY-2X
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCAbW-0006rB-54
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:13:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCAbU-0006lJ-5D
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 18:13:01 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  5 Apr 2019 00:12:38 +0200
Message-Id: <20190404221238.12468-5-philmd@redhat.com>
In-Reply-To: <20190404221238.12468-1-philmd@redhat.com>
References: <20190404221238.12468-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.1 4/4] hw/mips/r4k: Refactor the Super
 I/O chipset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

ISA Super I/O are already modeled by the ISASuperIODevice abstract
device.
Since this board uses a generic ISA Super I/O chipset, refactor it
as the TYPE_R4K_SUPERIO device, child of ISASuperIODevice.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/mips_r4k.c | 61 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 93dbf76bb49..b51a9523b43 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -18,6 +18,7 @@
 #include "hw/i386/pc.h"
 #include "hw/char/serial.h"
 #include "hw/isa/isa.h"
+#include "hw/isa/superio.h"
 #include "net/net.h"
 #include "hw/net/ne2000-isa.h"
 #include "sysemu/sysemu.h"
@@ -29,7 +30,6 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/timer/mc146818rtc.h"
-#include "hw/input/i8042.h"
 #include "hw/timer/i8254.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
@@ -37,10 +37,6 @@
=20
 #define MAX_IDE_BUS 2
=20
-static const int ide_iobase[2] =3D { 0x1f0, 0x170 };
-static const int ide_iobase2[2] =3D { 0x3f6, 0x376 };
-static const int ide_irq[2] =3D { 14, 15 };
-
 static ISADevice *pit; /* PIT i8254 */
=20
 /* i8254 PIT is attached to the IRQ0 at PIC i8259 */
@@ -73,6 +69,49 @@ static const MemoryRegionOps mips_qemu_ops =3D {
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
+#define TYPE_R4K_SUPERIO "r4k-superio"
+
+static uint16_t get_ide_iobase(ISASuperIODevice *sio, uint8_t index)
+{
+    static const uint16_t ide_iobase[] =3D { 0x1f0, 0x3f6, 0x170, 0x376 =
};
+
+    return ide_iobase[index];
+}
+
+static unsigned int get_ide_irq(ISASuperIODevice *sio, uint8_t index)
+{
+    return index < MAX_IDE_DEVS ? 14 : 15;
+}
+
+static void r4k_superio_class_init(ObjectClass *klass, void *data)
+{
+    ISASuperIOClass *sc =3D ISA_SUPERIO_CLASS(klass);
+
+    sc->serial.count =3D MAX_ISA_SERIAL_PORTS;
+    sc->parallel.count =3D 0;
+    sc->floppy.count =3D 0;
+    sc->ide =3D (ISASuperIOFuncs){
+        .count =3D MAX_IDE_BUS * MAX_IDE_DEVS,
+        .get_iobase =3D get_ide_iobase,
+        .get_irq    =3D get_ide_irq,
+    };
+}
+
+static const TypeInfo r4k_superio_type_info =3D {
+    .name          =3D TYPE_R4K_SUPERIO,
+    .parent        =3D TYPE_ISA_SUPERIO,
+    .instance_size =3D sizeof(ISASuperIODevice),
+    .class_size    =3D sizeof(ISASuperIOClass),
+    .class_init    =3D r4k_superio_class_init,
+};
+
+static void r4k_superio_register_types(void)
+{
+    type_register_static(&r4k_superio_type_info);
+}
+
+type_init(r4k_superio_register_types)
+
 typedef struct ResetData {
     MIPSCPU *cpu;
     uint64_t vector;
@@ -179,10 +218,8 @@ void mips_r4k_init(MachineState *machine)
     MIPSCPU *cpu;
     CPUMIPSState *env;
     ResetData *reset_info;
-    int i;
     qemu_irq *i8259;
     ISABus *isa_bus;
-    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     DriveInfo *dinfo;
     int be;
=20
@@ -274,20 +311,12 @@ void mips_r4k_init(MachineState *machine)
=20
     pit =3D i8254_pit_init(isa_bus, 0x40, 0, NULL);
=20
-    serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);
-
     isa_vga_init(isa_bus);
=20
     if (nd_table[0].used)
         isa_ne2000_init(isa_bus, 0x300, 9, &nd_table[0]);
=20
-    ide_drive_get(hd, ARRAY_SIZE(hd));
-    for(i =3D 0; i < MAX_IDE_BUS; i++)
-        isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i], ide_irq[i],
-                     hd[MAX_IDE_DEVS * i],
-                     hd[MAX_IDE_DEVS * i + 1]);
-
-    isa_create_simple(isa_bus, TYPE_I8042);
+    isa_create_simple(isa_bus, TYPE_R4K_SUPERIO);
 }
=20
 static void mips_machine_init(MachineClass *mc)
--=20
2.20.1
