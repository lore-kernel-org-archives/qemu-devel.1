Received: from eggs.gnu.org ([209.51.188.92]:57725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyON-0007Ha-Jl
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOK-0001Sj-RL
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:19 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOK-0001Rw-LQ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:16 -0500
Received: by mail-wr1-x443.google.com with SMTP id t6so9580637wrr.12
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:16 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:21 +0100
Message-Id: <1548410831-19553-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 02/52] ide: split ioport registration to a
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
Cc: yang.zhong@intel.com, thuth@redhat.com

This is not needed on ARM, and brings in ISA bus code which is otherwise not
necessary.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/Makefile.objs |  6 ++---
 hw/ide/core.c        | 25 --------------------
 hw/ide/ioport.c      | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 28 deletions(-)
 create mode 100644 hw/ide/ioport.c

diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
index fc328ff..3f3edd10 100644
--- a/hw/ide/Makefile.objs
+++ b/hw/ide/Makefile.objs
@@ -1,12 +1,12 @@
 common-obj-$(CONFIG_IDE_CORE) += core.o atapi.o
 common-obj-$(CONFIG_IDE_QDEV) += qdev.o
-common-obj-$(CONFIG_IDE_PCI) += pci.o
-common-obj-$(CONFIG_IDE_ISA) += isa.o
+common-obj-$(CONFIG_IDE_PCI) += pci.o ioport.o
+common-obj-$(CONFIG_IDE_ISA) += isa.o ioport.o
 common-obj-$(CONFIG_IDE_PIIX) += piix.o
 common-obj-$(CONFIG_IDE_CMD646) += cmd646.o
 common-obj-$(CONFIG_IDE_MACIO) += macio.o
 common-obj-$(CONFIG_IDE_MMIO) += mmio.o
-common-obj-$(CONFIG_IDE_VIA) += via.o
+common-obj-$(CONFIG_IDE_VIA) += via.o ioport.o
 common-obj-$(CONFIG_MICRODRIVE) += microdrive.o
 common-obj-$(CONFIG_AHCI) += ahci.o
 common-obj-$(CONFIG_AHCI) += ich.o
diff --git a/hw/ide/core.c b/hw/ide/core.c
index c3d779d..8483200 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2686,31 +2686,6 @@ void ide_exit(IDEState *s)
     qemu_vfree(s->io_buffer);
 }
 
-static const MemoryRegionPortio ide_portio_list[] = {
-    { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
-    { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
-    { 0, 1, 4, .read = ide_data_readl, .write = ide_data_writel },
-    PORTIO_END_OF_LIST(),
-};
-
-static const MemoryRegionPortio ide_portio2_list[] = {
-    { 0, 1, 1, .read = ide_status_read, .write = ide_cmd_write },
-    PORTIO_END_OF_LIST(),
-};
-
-void ide_init_ioport(IDEBus *bus, ISADevice *dev, int iobase, int iobase2)
-{
-    /* ??? Assume only ISA and PCI configurations, and that the PCI-ISA
-       bridge has been setup properly to always register with ISA.  */
-    isa_register_portio_list(dev, &bus->portio_list,
-                             iobase, ide_portio_list, bus, "ide");
-
-    if (iobase2) {
-        isa_register_portio_list(dev, &bus->portio2_list,
-                                 iobase2, ide_portio2_list, bus, "ide");
-    }
-}
-
 static bool is_identify_set(void *opaque, int version_id)
 {
     IDEState *s = opaque;
diff --git a/hw/ide/ioport.c b/hw/ide/ioport.c
new file mode 100644
index 0000000..b8f1b3f
--- /dev/null
+++ b/hw/ide/ioport.c
@@ -0,0 +1,67 @@
+/*
+ * QEMU IDE disk and CD/DVD-ROM Emulator
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ * Copyright (c) 2006 Openedhand Ltd.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/isa/isa.h"
+#include "qemu/error-report.h"
+#include "qemu/timer.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/blockdev.h"
+#include "sysemu/dma.h"
+#include "hw/block/block.h"
+#include "sysemu/block-backend.h"
+#include "qapi/error.h"
+#include "qemu/cutils.h"
+#include "sysemu/replay.h"
+
+#include "hw/ide/internal.h"
+#include "trace.h"
+
+static const MemoryRegionPortio ide_portio_list[] = {
+    { 0, 8, 1, .read = ide_ioport_read, .write = ide_ioport_write },
+    { 0, 1, 2, .read = ide_data_readw, .write = ide_data_writew },
+    { 0, 1, 4, .read = ide_data_readl, .write = ide_data_writel },
+    PORTIO_END_OF_LIST(),
+};
+
+static const MemoryRegionPortio ide_portio2_list[] = {
+    { 0, 1, 1, .read = ide_status_read, .write = ide_cmd_write },
+    PORTIO_END_OF_LIST(),
+};
+
+void ide_init_ioport(IDEBus *bus, ISADevice *dev, int iobase, int iobase2)
+{
+    /* ??? Assume only ISA and PCI configurations, and that the PCI-ISA
+       bridge has been setup properly to always register with ISA.  */
+    isa_register_portio_list(dev, &bus->portio_list,
+                             iobase, ide_portio_list, bus, "ide");
+
+    if (iobase2) {
+        isa_register_portio_list(dev, &bus->portio2_list,
+                                 iobase2, ide_portio2_list, bus, "ide");
+    }
+}
+
-- 
1.8.3.1
