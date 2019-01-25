Received: from eggs.gnu.org ([209.51.188.92]:59777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn9co-0005Fi-21
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gn9cm-0006ah-3e
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gn9ck-0006Yl-7P
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:06:54 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 Jan 2019 17:06:42 -0500
Message-Id: <20190125220648.28164-3-jsnow@redhat.com>
In-Reply-To: <20190125220648.28164-1-jsnow@redhat.com>
References: <20190125220648.28164-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 2/8] cmd646: Remove IDEBus from CMD646BAR
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

The cmd646 io mem ops callbacks only need the IDEBus which is
currently passed via a CMD646BAR struct. No need to wrap it up like
that, we can pass it directly to these callbacks which then allows to
drop the IDEBus from the CMD646BAR.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 7a31c155c9899869794499d841d30c7ef32aae47.1547166960.git.balaton@eik.bme.hu
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/cmd646.c      | 29 ++++++++++++++---------------
 include/hw/ide/pci.h |  1 -
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 41c1831f9a..c24f71e219 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -53,23 +53,23 @@ static void cmd646_update_irq(PCIDevice *pd);
 static uint64_t cmd646_cmd_read(void *opaque, hwaddr addr,
                                 unsigned size)
 {
-    CMD646BAR *cmd646bar = opaque;
+    IDEBus *bus = opaque;
 
     if (addr != 2 || size != 1) {
         return ((uint64_t)1 << (size * 8)) - 1;
     }
-    return ide_status_read(cmd646bar->bus, addr + 2);
+    return ide_status_read(bus, addr + 2);
 }
 
 static void cmd646_cmd_write(void *opaque, hwaddr addr,
                              uint64_t data, unsigned size)
 {
-    CMD646BAR *cmd646bar = opaque;
+    IDEBus *bus = opaque;
 
     if (addr != 2 || size != 1) {
         return;
     }
-    ide_cmd_write(cmd646bar->bus, addr + 2, data);
+    ide_cmd_write(bus, addr + 2, data);
 }
 
 static const MemoryRegionOps cmd646_cmd_ops = {
@@ -81,15 +81,15 @@ static const MemoryRegionOps cmd646_cmd_ops = {
 static uint64_t cmd646_data_read(void *opaque, hwaddr addr,
                                  unsigned size)
 {
-    CMD646BAR *cmd646bar = opaque;
+    IDEBus *bus = opaque;
 
     if (size == 1) {
-        return ide_ioport_read(cmd646bar->bus, addr);
+        return ide_ioport_read(bus, addr);
     } else if (addr == 0) {
         if (size == 2) {
-            return ide_data_readw(cmd646bar->bus, addr);
+            return ide_data_readw(bus, addr);
         } else {
-            return ide_data_readl(cmd646bar->bus, addr);
+            return ide_data_readl(bus, addr);
         }
     }
     return ((uint64_t)1 << (size * 8)) - 1;
@@ -98,15 +98,15 @@ static uint64_t cmd646_data_read(void *opaque, hwaddr addr,
 static void cmd646_data_write(void *opaque, hwaddr addr,
                              uint64_t data, unsigned size)
 {
-    CMD646BAR *cmd646bar = opaque;
+    IDEBus *bus = opaque;
 
     if (size == 1) {
-        ide_ioport_write(cmd646bar->bus, addr, data);
+        ide_ioport_write(bus, addr, data);
     } else if (addr == 0) {
         if (size == 2) {
-            ide_data_writew(cmd646bar->bus, addr, data);
+            ide_data_writew(bus, addr, data);
         } else {
-            ide_data_writel(cmd646bar->bus, addr, data);
+            ide_data_writel(bus, addr, data);
         }
     }
 }
@@ -122,10 +122,9 @@ static void setup_cmd646_bar(PCIIDEState *d, int bus_num)
     IDEBus *bus = &d->bus[bus_num];
     CMD646BAR *bar = &d->cmd646_bar[bus_num];
 
-    bar->bus = bus;
-    memory_region_init_io(&bar->cmd, OBJECT(d), &cmd646_cmd_ops, bar,
+    memory_region_init_io(&bar->cmd, OBJECT(d), &cmd646_cmd_ops, bus,
                           "cmd646-cmd", 4);
-    memory_region_init_io(&bar->data, OBJECT(d), &cmd646_data_ops, bar,
+    memory_region_init_io(&bar->data, OBJECT(d), &cmd646_data_ops, bus,
                           "cmd646-data", 8);
 }
 
diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
index ed723acfb4..013d7937d2 100644
--- a/include/hw/ide/pci.h
+++ b/include/hw/ide/pci.h
@@ -40,7 +40,6 @@ typedef struct BMDMAState {
 typedef struct CMD646BAR {
     MemoryRegion cmd;
     MemoryRegion data;
-    IDEBus *bus;
 } CMD646BAR;
 
 #define TYPE_PCI_IDE "pci-ide"
-- 
2.17.2
