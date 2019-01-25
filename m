Received: from eggs.gnu.org ([209.51.188.92]:59771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn9co-0005Fd-0I
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn9cm-0006aq-45
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gn9ck-0006Yr-6X
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:55 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 Jan 2019 17:06:43 -0500
Message-Id: <20190125220648.28164-4-jsnow@redhat.com>
In-Reply-To: <20190125220648.28164-1-jsnow@redhat.com>
References: <20190125220648.28164-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 3/8] cmd646: Move PCI IDE specific functions to
 ide/pci.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com, BALATON Zoltan <balaton@eik.bme.hu>

From: BALATON Zoltan <balaton@eik.bme.hu>

The io mem ops callbacks are not specific to CMD646 but really follow
the PCI IDE spec so move these from cmd646.c to pci.c to allow other
PCI IDE implementations to use them.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: a2b1b2b74afdc78330b8b75605687f683a249635.1547166960.git.balaton@eik.bme.hu
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/cmd646.c      | 71 ++------------------------------------------
 hw/ide/pci.c         | 65 ++++++++++++++++++++++++++++++++++++++++
 include/hw/ide/pci.h |  2 ++
 3 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index c24f71e219..95f0df9742 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -50,81 +50,14 @@
 
 static void cmd646_update_irq(PCIDevice *pd);
 
-static uint64_t cmd646_cmd_read(void *opaque, hwaddr addr,
-                                unsigned size)
-{
-    IDEBus *bus = opaque;
-
-    if (addr != 2 || size != 1) {
-        return ((uint64_t)1 << (size * 8)) - 1;
-    }
-    return ide_status_read(bus, addr + 2);
-}
-
-static void cmd646_cmd_write(void *opaque, hwaddr addr,
-                             uint64_t data, unsigned size)
-{
-    IDEBus *bus = opaque;
-
-    if (addr != 2 || size != 1) {
-        return;
-    }
-    ide_cmd_write(bus, addr + 2, data);
-}
-
-static const MemoryRegionOps cmd646_cmd_ops = {
-    .read = cmd646_cmd_read,
-    .write = cmd646_cmd_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
-static uint64_t cmd646_data_read(void *opaque, hwaddr addr,
-                                 unsigned size)
-{
-    IDEBus *bus = opaque;
-
-    if (size == 1) {
-        return ide_ioport_read(bus, addr);
-    } else if (addr == 0) {
-        if (size == 2) {
-            return ide_data_readw(bus, addr);
-        } else {
-            return ide_data_readl(bus, addr);
-        }
-    }
-    return ((uint64_t)1 << (size * 8)) - 1;
-}
-
-static void cmd646_data_write(void *opaque, hwaddr addr,
-                             uint64_t data, unsigned size)
-{
-    IDEBus *bus = opaque;
-
-    if (size == 1) {
-        ide_ioport_write(bus, addr, data);
-    } else if (addr == 0) {
-        if (size == 2) {
-            ide_data_writew(bus, addr, data);
-        } else {
-            ide_data_writel(bus, addr, data);
-        }
-    }
-}
-
-static const MemoryRegionOps cmd646_data_ops = {
-    .read = cmd646_data_read,
-    .write = cmd646_data_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-};
-
 static void setup_cmd646_bar(PCIIDEState *d, int bus_num)
 {
     IDEBus *bus = &d->bus[bus_num];
     CMD646BAR *bar = &d->cmd646_bar[bus_num];
 
-    memory_region_init_io(&bar->cmd, OBJECT(d), &cmd646_cmd_ops, bus,
+    memory_region_init_io(&bar->cmd, OBJECT(d), &pci_ide_cmd_le_ops, bus,
                           "cmd646-cmd", 4);
-    memory_region_init_io(&bar->data, OBJECT(d), &cmd646_data_ops, bus,
+    memory_region_init_io(&bar->data, OBJECT(d), &pci_ide_data_le_ops, bus,
                           "cmd646-data", 8);
 }
 
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index b75154f99f..942613a9a9 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -36,6 +36,71 @@
         (IDE_RETRY_DMA | IDE_RETRY_PIO | \
         IDE_RETRY_READ | IDE_RETRY_FLUSH)
 
+static uint64_t pci_ide_cmd_read(void *opaque, hwaddr addr, unsigned size)
+{
+    IDEBus *bus = opaque;
+
+    if (addr != 2 || size != 1) {
+        return ((uint64_t)1 << (size * 8)) - 1;
+    }
+    return ide_status_read(bus, addr + 2);
+}
+
+static void pci_ide_cmd_write(void *opaque, hwaddr addr,
+                              uint64_t data, unsigned size)
+{
+    IDEBus *bus = opaque;
+
+    if (addr != 2 || size != 1) {
+        return;
+    }
+    ide_cmd_write(bus, addr + 2, data);
+}
+
+const MemoryRegionOps pci_ide_cmd_le_ops = {
+    .read = pci_ide_cmd_read,
+    .write = pci_ide_cmd_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static uint64_t pci_ide_data_read(void *opaque, hwaddr addr, unsigned size)
+{
+    IDEBus *bus = opaque;
+
+    if (size == 1) {
+        return ide_ioport_read(bus, addr);
+    } else if (addr == 0) {
+        if (size == 2) {
+            return ide_data_readw(bus, addr);
+        } else {
+            return ide_data_readl(bus, addr);
+        }
+    }
+    return ((uint64_t)1 << (size * 8)) - 1;
+}
+
+static void pci_ide_data_write(void *opaque, hwaddr addr,
+                               uint64_t data, unsigned size)
+{
+    IDEBus *bus = opaque;
+
+    if (size == 1) {
+        ide_ioport_write(bus, addr, data);
+    } else if (addr == 0) {
+        if (size == 2) {
+            ide_data_writew(bus, addr, data);
+        } else {
+            ide_data_writel(bus, addr, data);
+        }
+    }
+}
+
+const MemoryRegionOps pci_ide_data_le_ops = {
+    .read = pci_ide_data_read,
+    .write = pci_ide_data_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
 static void bmdma_start_dma(IDEDMA *dma, IDEState *s,
                             BlockCompletionFunc *dma_cb)
 {
diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
index 013d7937d2..3110633e4c 100644
--- a/include/hw/ide/pci.h
+++ b/include/hw/ide/pci.h
@@ -71,4 +71,6 @@ extern MemoryRegionOps bmdma_addr_ioport_ops;
 void pci_ide_create_devs(PCIDevice *dev, DriveInfo **hd_table);
 
 extern const VMStateDescription vmstate_ide_pci;
+extern const MemoryRegionOps pci_ide_cmd_le_ops;
+extern const MemoryRegionOps pci_ide_data_le_ops;
 #endif
-- 
2.17.2
