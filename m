Received: from eggs.gnu.org ([2001:4830:134:3::10]:45331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXV76-0004NQ-NF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXV75-0001vJ-7D
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:12:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dXV74-0001uo-Tf
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:12:43 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Jul 2017 12:12:28 -0400
Message-Id: <20170718161230.21917-3-jsnow@redhat.com>
In-Reply-To: <20170718161230.21917-1-jsnow@redhat.com>
References: <20170718161230.21917-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] ahci: Isolate public AHCI interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

Begin separating the public/private interface by removing the minimum
set of information used by code outside of hw/ide/ and calling this
a new ahci_public.h file, which will be renamed to ahci.h in a future
patch.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170623220926.11479-3-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/hw/ide/ahci.h        | 57 +++------------------------
 include/hw/ide/ahci_public.h | 91 ++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 96 insertions(+), 52 deletions(-)
 create mode 100644 include/hw/ide/ahci_public.h

diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index f866bbf..70a0140 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -21,9 +21,10 @@
  *
  */
=20
-#ifndef HW_IDE_AHCI_H
-#define HW_IDE_AHCI_H
+#ifndef HW_IDE_AHCI_INTERNAL_H
+#define HW_IDE_AHCI_INTERNAL_H
=20
+#include "hw/ide/ahci_public.h"
 #include "hw/sysbus.h"
=20
 #define AHCI_MEM_BAR_SIZE         0x1000
@@ -210,14 +211,6 @@
 #define SATA_CAP_REV            0x2
 #define SATA_CAP_BAR            0x4
=20
-typedef struct AHCIControlRegs {
-    uint32_t    cap;
-    uint32_t    ghc;
-    uint32_t    irqstatus;
-    uint32_t    impl;
-    uint32_t    version;
-} AHCIControlRegs;
-
 typedef struct AHCIPortRegs {
     uint32_t    lst_addr;
     uint32_t    lst_addr_hi;
@@ -251,8 +244,6 @@ typedef struct AHCI_SG {
     uint32_t    flags_size;
 } QEMU_PACKED AHCI_SG;
=20
-typedef struct AHCIDevice AHCIDevice;
-
 typedef struct NCQTransferState {
     AHCIDevice *drive;
     BlockAIOCB *aiocb;
@@ -286,27 +277,13 @@ struct AHCIDevice {
     NCQTransferState ncq_tfs[AHCI_MAX_CMDS];
 };
=20
-typedef struct AHCIState {
-    DeviceState *container;
-
-    AHCIDevice *dev;
-    AHCIControlRegs control_regs;
-    MemoryRegion mem;
-    MemoryRegion idp;       /* Index-Data Pair I/O port space */
-    unsigned idp_offset;    /* Offset of index in I/O port space */
-    uint32_t idp_index;     /* Current IDP index */
-    int32_t ports;
-    qemu_irq irq;
-    AddressSpace *as;
-} AHCIState;
-
-typedef struct AHCIPCIState {
+struct AHCIPCIState {
     /*< private >*/
     PCIDevice parent_obj;
     /*< public >*/
=20
     AHCIState ahci;
-} AHCIPCIState;
+};
=20
 #define TYPE_ICH9_AHCI "ich9-ahci"
=20
@@ -372,35 +349,11 @@ void ahci_uninit(AHCIState *s);
=20
 void ahci_reset(AHCIState *s);
=20
-int32_t ahci_get_num_ports(PCIDevice *dev);
-void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd);
-
 #define TYPE_SYSBUS_AHCI "sysbus-ahci"
 #define SYSBUS_AHCI(obj) OBJECT_CHECK(SysbusAHCIState, (obj), TYPE_SYSBU=
S_AHCI)
=20
-typedef struct SysbusAHCIState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    AHCIState ahci;
-    uint32_t num_ports;
-} SysbusAHCIState;
-
 #define TYPE_ALLWINNER_AHCI "allwinner-ahci"
 #define ALLWINNER_AHCI(obj) OBJECT_CHECK(AllwinnerAHCIState, (obj), \
                        TYPE_ALLWINNER_AHCI)
=20
-#define ALLWINNER_AHCI_MMIO_OFF  0x80
-#define ALLWINNER_AHCI_MMIO_SIZE 0x80
-
-struct AllwinnerAHCIState {
-    /*< private >*/
-    SysbusAHCIState parent_obj;
-    /*< public >*/
-
-    MemoryRegion mmio;
-    uint32_t regs[ALLWINNER_AHCI_MMIO_SIZE/4];
-};
-
 #endif /* HW_IDE_AHCI_H */
diff --git a/include/hw/ide/ahci_public.h b/include/hw/ide/ahci_public.h
new file mode 100644
index 0000000..5a06537
--- /dev/null
+++ b/include/hw/ide/ahci_public.h
@@ -0,0 +1,91 @@
+/*
+ * QEMU AHCI Emulation
+ *
+ * Copyright (c) 2010 qiaochong@loongson.cn
+ * Copyright (c) 2010 Roland Elek <elek.roland@gmail.com>
+ * Copyright (c) 2010 Sebastian Herbszt <herbszt@gmx.de>
+ * Copyright (c) 2010 Alexander Graf <agraf@suse.de>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ *
+ */
+
+#ifndef HW_IDE_AHCI_H
+#define HW_IDE_AHCI_H
+
+#include "hw/sysbus.h"
+
+typedef struct AHCIDevice AHCIDevice;
+
+typedef struct AHCIControlRegs {
+    uint32_t    cap;
+    uint32_t    ghc;
+    uint32_t    irqstatus;
+    uint32_t    impl;
+    uint32_t    version;
+} AHCIControlRegs;
+
+typedef struct AHCIState {
+    DeviceState *container;
+
+    AHCIDevice *dev;
+    AHCIControlRegs control_regs;
+    MemoryRegion mem;
+    MemoryRegion idp;       /* Index-Data Pair I/O port space */
+    unsigned idp_offset;    /* Offset of index in I/O port space */
+    uint32_t idp_index;     /* Current IDP index */
+    int32_t ports;
+    qemu_irq irq;
+    AddressSpace *as;
+} AHCIState;
+
+typedef struct AHCIPCIState AHCIPCIState;
+
+#define TYPE_ICH9_AHCI "ich9-ahci"
+
+#define ICH_AHCI(obj) \
+    OBJECT_CHECK(AHCIPCIState, (obj), TYPE_ICH9_AHCI)
+
+int32_t ahci_get_num_ports(PCIDevice *dev);
+void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd);
+
+#define TYPE_SYSBUS_AHCI "sysbus-ahci"
+#define SYSBUS_AHCI(obj) OBJECT_CHECK(SysbusAHCIState, (obj), TYPE_SYSBU=
S_AHCI)
+
+typedef struct SysbusAHCIState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    AHCIState ahci;
+    uint32_t num_ports;
+} SysbusAHCIState;
+
+#define TYPE_ALLWINNER_AHCI "allwinner-ahci"
+#define ALLWINNER_AHCI(obj) OBJECT_CHECK(AllwinnerAHCIState, (obj), \
+                       TYPE_ALLWINNER_AHCI)
+
+#define ALLWINNER_AHCI_MMIO_OFF  0x80
+#define ALLWINNER_AHCI_MMIO_SIZE 0x80
+
+struct AllwinnerAHCIState {
+    /*< private >*/
+    SysbusAHCIState parent_obj;
+    /*< public >*/
+
+    MemoryRegion mmio;
+    uint32_t regs[ALLWINNER_AHCI_MMIO_SIZE/4];
+};
+
+#endif /* HW_IDE_AHCI_H */
--=20
2.9.4
