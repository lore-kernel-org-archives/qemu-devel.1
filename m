Received: from eggs.gnu.org ([2001:4830:134:3::10]:58233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQn8p-00089x-U5
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQn8l-0003eM-SQ
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 23:35:03 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:28:02 +0300
Message-Id: <04c94605e6d075eb6af860ad8bcd144d7e783d4d.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 57/61] hw/net/ne2000: extract ne2k-isa code from
 i386/pc to ne2000-isa.c
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

- add "hw/net/ne2000-isa.h"
- remove the old i386 dependency

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au> [PPC]
---
 hw/i386/pc.c                |  1 +
 hw/mips/mips_r4k.c          |  1 +
 hw/net/ne2000-isa.c         |  6 ++----
 hw/net/ne2000.c             |  2 --
 hw/net/ne2000.h             |  3 +++
 hw/ppc/prep.c               |  1 +
 include/hw/i386/pc.h        | 20 --------------------
 include/hw/net/ne2000-isa.h | 33 +++++++++++++++++++++++++++++++++
 8 files changed, 41 insertions(+), 26 deletions(-)
 create mode 100644 include/hw/net/ne2000-isa.h

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index fe5e8b53bb..3fcf318a95 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -69,6 +69,7 @@
 #include "qom/cpu.h"
 #include "hw/nmi.h"
 #include "hw/i386/intel_iommu.h"
+#include "hw/net/ne2000-isa.h"
=20
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 9884ee7e9f..244bd41813 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -18,6 +18,7 @@
 #include "hw/char/serial.h"
 #include "hw/isa/isa.h"
 #include "net/net.h"
+#include "hw/net/ne2000-isa.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
 #include "hw/block/flash.h"
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index f3455339ee..70e5c1d3d4 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -22,17 +22,15 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "hw/hw.h"
-#include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
+#include "hw/net/ne2000-isa.h"
 #include "hw/qdev.h"
-#include "net/net.h"
 #include "ne2000.h"
+#include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
=20
-#define TYPE_ISA_NE2000 "ne2k_isa"
 #define ISA_NE2000(obj) OBJECT_CHECK(ISANE2000State, (obj), TYPE_ISA_NE2=
000)
=20
 typedef struct ISANE2000State {
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 3938e6ddd8..6874c8c6b9 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -22,9 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/pci/pci.h"
-#include "net/net.h"
 #include "ne2000.h"
 #include "hw/loader.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/net/ne2000.h b/hw/net/ne2000.h
index d213dccae3..adb8021bd1 100644
--- a/hw/net/ne2000.h
+++ b/hw/net/ne2000.h
@@ -1,6 +1,9 @@
 #ifndef HW_NE2000_H
 #define HW_NE2000_H
=20
+#include "hw/hw.h"
+#include "net/net.h"
+
 #define NE2000_PMEM_SIZE    (32*1024)
 #define NE2000_PMEM_START   (16*1024)
 #define NE2000_PMEM_END     (NE2000_PMEM_SIZE+NE2000_PMEM_START)
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 6f8accc397..af08ac319a 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -42,6 +42,7 @@
 #include "hw/loader.h"
 #include "hw/timer/mc146818rtc.h"
 #include "hw/isa/pc87312.h"
+#include "hw/net/ne2000-isa.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/kvm.h"
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 1d55ba3322..ab84e31cce 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -302,26 +302,6 @@ PCIBus *find_i440fx(void);
 extern PCIDevice *piix4_dev;
 int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
=20
-/* ne2000.c */
-static inline bool isa_ne2000_init(ISABus *bus, int base, int irq, NICIn=
fo *nd)
-{
-    DeviceState *dev;
-    ISADevice *isadev;
-
-    qemu_check_nic_model(nd, "ne2k_isa");
-
-    isadev =3D isa_try_create(bus, "ne2k_isa");
-    if (!isadev) {
-        return false;
-    }
-    dev =3D DEVICE(isadev);
-    qdev_prop_set_uint32(dev, "iobase", base);
-    qdev_prop_set_uint32(dev, "irq",    irq);
-    qdev_set_nic_properties(dev, nd);
-    qdev_init_nofail(dev);
-    return true;
-}
-
 /* pc_sysfw.c */
 void pc_system_firmware_init(MemoryRegion *rom_memory,
                              bool isapc_ram_fw);
diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
new file mode 100644
index 0000000000..ff2bed9c95
--- /dev/null
+++ b/include/hw/net/ne2000-isa.h
@@ -0,0 +1,33 @@
+/*
+ * QEMU NE2000 emulation -- isa bus windup
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+#include "hw/hw.h"
+#include "hw/qdev.h"
+#include "hw/isa/isa.h"
+#include "net/net.h"
+
+#define TYPE_ISA_NE2000 "ne2k_isa"
+
+static inline ISADevice *isa_ne2000_init(ISABus *bus, int base, int irq,
+                                         NICInfo *nd)
+{
+    ISADevice *d;
+
+    qemu_check_nic_model(nd, "ne2k_isa");
+
+    d =3D isa_try_create(bus, TYPE_ISA_NE2000);
+    if (d) {
+        DeviceState *dev =3D DEVICE(d);
+
+        qdev_prop_set_uint32(dev, "iobase", base);
+        qdev_prop_set_uint32(dev, "irq",    irq);
+        qdev_set_nic_properties(dev, nd);
+        qdev_init_nofail(dev);
+    }
+    return d;
+}
--=20
2.11.0
