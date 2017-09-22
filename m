Received: from eggs.gnu.org ([2001:4830:134:3::10]:51637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQOk-0006B4-NU
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvQOj-0008Rl-EC
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:01:50 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 13:01:03 -0300
Message-Id: <20170922160111.31885-4-f4bug@amsat.org>
In-Reply-To: <20170922154014.29350-1-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 26/34] hw/net/ne2000: extract ne2k-isa code
 from i386/pc to ne2000-isa.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

- add "hw/net/ne2000-isa.h" (and new entry in MAINTAINERS)
- remove the old i386 dependency

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/ne2000.h             |  3 +++
 include/hw/i386/pc.h        | 20 --------------------
 include/hw/net/ne2000-isa.h | 33 +++++++++++++++++++++++++++++++++
 hw/i386/pc.c                |  1 +
 hw/mips/mips_r4k.c          |  1 +
 hw/net/ne2000-isa.c         |  6 ++----
 hw/net/ne2000.c             |  2 --
 hw/ppc/prep.c               |  1 +
 MAINTAINERS                 |  1 +
 9 files changed, 42 insertions(+), 26 deletions(-)
 create mode 100644 include/hw/net/ne2000-isa.h

diff --git a/hw/net/ne2000.h b/hw/net/ne2000.h
index d213dccae3..adb8021bd1 100644
--- a/hw/net/ne2000.h
+++ b/hw/net/ne2000.h
@@ -1,6 +1,9 @@
 #ifndef HW_NE2000_H
 #define HW_NE2000_H
 
+#include "hw/hw.h"
+#include "net/net.h"
+
 #define NE2000_PMEM_SIZE    (32*1024)
 #define NE2000_PMEM_START   (16*1024)
 #define NE2000_PMEM_END     (NE2000_PMEM_SIZE+NE2000_PMEM_START)
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6a2e947332..020792c2e8 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -291,26 +291,6 @@ PCIBus *find_i440fx(void);
 extern PCIDevice *piix4_dev;
 int piix4_init(PCIBus *bus, ISABus **isa_bus, int devfn);
 
-/* ne2000.c */
-static inline bool isa_ne2000_init(ISABus *bus, int base, int irq, NICInfo *nd)
-{
-    DeviceState *dev;
-    ISADevice *isadev;
-
-    qemu_check_nic_model(nd, "ne2k_isa");
-
-    isadev = isa_try_create(bus, "ne2k_isa");
-    if (!isadev) {
-        return false;
-    }
-    dev = DEVICE(isadev);
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
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
+    d = isa_try_create(bus, TYPE_ISA_NE2000);
+    if (d) {
+        DeviceState *dev = DEVICE(d);
+
+        qdev_prop_set_uint32(dev, "iobase", base);
+        qdev_prop_set_uint32(dev, "irq",    irq);
+        qdev_set_nic_properties(dev, nd);
+        qdev_init_nofail(dev);
+    }
+    return d;
+}
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 788844e0de..085577e066 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -71,6 +71,7 @@
 #include "qom/cpu.h"
 #include "hw/nmi.h"
 #include "hw/i386/intel_iommu.h"
+#include "hw/net/ne2000-isa.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 349da59912..33ff89f02c 100644
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
 
-#define TYPE_ISA_NE2000 "ne2k_isa"
 #define ISA_NE2000(obj) OBJECT_CHECK(ISANE2000State, (obj), TYPE_ISA_NE2000)
 
 typedef struct ISANE2000State {
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 798d681e25..29bd4adb3f 100644
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
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 1f8ef4819b..fb330a1769 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -43,6 +43,7 @@
 #include "hw/timer/mc146818rtc.h"
 #include "hw/input/i8042.h"
 #include "hw/isa/pc87312.h"
+#include "hw/net/ne2000-isa.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/kvm.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index 3cb6bc190c..37917af0f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -973,6 +973,7 @@ Network devices
 M: Jason Wang <jasowang@redhat.com>
 S: Odd Fixes
 F: hw/net/
+F: include/hw/net/
 F: tests/virtio-net-test.c
 T: git git://github.com/jasowang/qemu.git net
 
-- 
2.14.1
