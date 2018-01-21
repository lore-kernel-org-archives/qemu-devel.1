Received: from eggs.gnu.org ([2001:4830:134:3::10]:34712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBfq-0006Em-2g
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1edBfn-00037B-5d
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:22 -0500
Received: from chuckie.co.uk ([82.165.15.123]:47976
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1edBfm-0002x8-RR
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 04:12:19 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 21 Jan 2018 09:11:45 +0000
Message-Id: <20180121091154.17426-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180121091154.17426-1-mark.cave-ayland@ilande.co.uk>
References: <20180121091154.17426-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCHv2 01/10] apb: split simba PCI bridge into
 hw/pci-bridge/simba.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Move the QOM type and macros into a new include/hw/pci-bridge/simba.h
file, and add a new CONFIG_SIMBA Makefile.objs variable which is enabled
for sparc64-softmmu builds only.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 default-configs/sparc64-softmmu.mak |   1 +
 hw/pci-bridge/Makefile.objs         |   2 +
 hw/pci-bridge/simba.c               | 101 ++++++++++++++++++++++++++++++++++++
 hw/pci-host/apb.c                   |  62 +---------------------
 include/hw/pci-bridge/simba.h       |  38 ++++++++++++++
 include/hw/pci-host/apb.h           |   9 ----
 6 files changed, 143 insertions(+), 70 deletions(-)
 create mode 100644 hw/pci-bridge/simba.c
 create mode 100644 include/hw/pci-bridge/simba.h

diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index 3e177bbd7b..9b742a7b41 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -12,6 +12,7 @@ CONFIG_FDC=y
 CONFIG_IDE_ISA=y
 CONFIG_IDE_CMD646=y
 CONFIG_PCI_APB=y
+CONFIG_SIMBA=y
 CONFIG_SUNHME=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
diff --git a/hw/pci-bridge/Makefile.objs b/hw/pci-bridge/Makefile.objs
index 1b05023662..47065f87d9 100644
--- a/hw/pci-bridge/Makefile.objs
+++ b/hw/pci-bridge/Makefile.objs
@@ -6,3 +6,5 @@ common-obj-$(CONFIG_IOH3420) += ioh3420.o
 common-obj-$(CONFIG_I82801B11) += i82801b11.o
 # NewWorld PowerMac
 common-obj-$(CONFIG_DEC_PCI) += dec.o
+# Sun4u
+common-obj-$(CONFIG_SIMBA) += simba.o
diff --git a/hw/pci-bridge/simba.c b/hw/pci-bridge/simba.c
new file mode 100644
index 0000000000..05ba6f0f34
--- /dev/null
+++ b/hw/pci-bridge/simba.c
@@ -0,0 +1,101 @@
+/*
+ * QEMU Simba PCI bridge
+ *
+ * Copyright (c) 2006 Fabrice Bellard
+ * Copyright (c) 2012,2013 Artyom Tarasenko
+ * Copyright (c) 2018 Mark Cave-Ayland
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
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci-bridge/simba.h"
+
+/*
+ * Chipset docs:
+ * APB: "Advanced PCI Bridge (APB) User's Manual",
+ * http://www.sun.com/processors/manuals/805-1251.pdf
+ */
+
+static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
+{
+    /*
+     * command register:
+     * According to PCI bridge spec, after reset
+     *   bus master bit is off
+     *   memory space enable bit is off
+     * According to manual (805-1251.pdf).
+     *   the reset value should be zero unless the boot pin is tied high
+     *   (which is true) and thus it should be PCI_COMMAND_MEMORY.
+     */
+    PBMPCIBridge *br = PBM_PCI_BRIDGE(dev);
+
+    pci_bridge_initfn(dev, TYPE_PCI_BUS);
+
+    pci_set_word(dev->config + PCI_COMMAND, PCI_COMMAND_MEMORY);
+    pci_set_word(dev->config + PCI_STATUS,
+                 PCI_STATUS_FAST_BACK | PCI_STATUS_66MHZ |
+                 PCI_STATUS_DEVSEL_MEDIUM);
+
+    /* Allow 32-bit IO addresses */
+    pci_set_word(dev->config + PCI_IO_BASE, PCI_IO_RANGE_TYPE_32);
+    pci_set_word(dev->config + PCI_IO_LIMIT, PCI_IO_RANGE_TYPE_32);
+    pci_set_word(dev->wmask + PCI_IO_BASE_UPPER16, 0xffff);
+    pci_set_word(dev->wmask + PCI_IO_LIMIT_UPPER16, 0xffff);
+
+    pci_bridge_update_mappings(PCI_BRIDGE(br));
+}
+
+static void pbm_pci_bridge_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = apb_pci_bridge_realize;
+    k->exit = pci_bridge_exitfn;
+    k->vendor_id = PCI_VENDOR_ID_SUN;
+    k->device_id = PCI_DEVICE_ID_SUN_SIMBA;
+    k->revision = 0x11;
+    k->config_write = pci_bridge_write_config;
+    k->is_bridge = 1;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->reset = pci_bridge_reset;
+    dc->vmsd = &vmstate_pci_device;
+}
+
+static const TypeInfo pbm_pci_bridge_info = {
+    .name          = TYPE_PBM_PCI_BRIDGE,
+    .parent        = TYPE_PCI_BRIDGE,
+    .class_init    = pbm_pci_bridge_class_init,
+    .instance_size = sizeof(PBMPCIBridge),
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void pbm_register_types(void)
+{
+    type_register_static(&pbm_pci_bridge_info);
+}
+
+type_init(pbm_register_types)
diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index ec676f94b6..3a5c046794 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -33,6 +33,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
+#include "hw/pci-bridge/simba.h"
 #include "hw/pci-host/apb.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
@@ -53,9 +54,6 @@ do { printf("APB: " fmt , ## __VA_ARGS__); } while (0)
  * Chipset docs:
  * PBM: "UltraSPARC IIi User's Manual",
  * http://www.sun.com/processors/manuals/805-0087.pdf
- *
- * APB: "Advanced PCI Bridge (APB) User's Manual",
- * http://www.sun.com/processors/manuals/805-1251.pdf
  */
 
 #define PBM_PCI_IMR_MASK    0x7fffffff
@@ -348,35 +346,6 @@ static void pci_apb_set_irq(void *opaque, int irq_num, int level)
     }
 }
 
-static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
-{
-    /*
-     * command register:
-     * According to PCI bridge spec, after reset
-     *   bus master bit is off
-     *   memory space enable bit is off
-     * According to manual (805-1251.pdf).
-     *   the reset value should be zero unless the boot pin is tied high
-     *   (which is true) and thus it should be PCI_COMMAND_MEMORY.
-     */
-    PBMPCIBridge *br = PBM_PCI_BRIDGE(dev);
-
-    pci_bridge_initfn(dev, TYPE_PCI_BUS);
-
-    pci_set_word(dev->config + PCI_COMMAND, PCI_COMMAND_MEMORY);
-    pci_set_word(dev->config + PCI_STATUS,
-                 PCI_STATUS_FAST_BACK | PCI_STATUS_66MHZ |
-                 PCI_STATUS_DEVSEL_MEDIUM);
-
-    /* Allow 32-bit IO addresses */
-    pci_set_word(dev->config + PCI_IO_BASE, PCI_IO_RANGE_TYPE_32);
-    pci_set_word(dev->config + PCI_IO_LIMIT, PCI_IO_RANGE_TYPE_32);
-    pci_set_word(dev->wmask + PCI_IO_BASE_UPPER16, 0xffff);
-    pci_set_word(dev->wmask + PCI_IO_LIMIT_UPPER16, 0xffff);
-
-    pci_bridge_update_mappings(PCI_BRIDGE(br));
-}
-
 static void pci_pbm_reset(DeviceState *d)
 {
     APBState *s = APB_DEVICE(d);
@@ -564,39 +533,10 @@ static const TypeInfo pbm_host_info = {
     .class_init    = pbm_host_class_init,
 };
 
-static void pbm_pci_bridge_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-
-    k->realize = apb_pci_bridge_realize;
-    k->exit = pci_bridge_exitfn;
-    k->vendor_id = PCI_VENDOR_ID_SUN;
-    k->device_id = PCI_DEVICE_ID_SUN_SIMBA;
-    k->revision = 0x11;
-    k->config_write = pci_bridge_write_config;
-    k->is_bridge = 1;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-    dc->reset = pci_bridge_reset;
-    dc->vmsd = &vmstate_pci_device;
-}
-
-static const TypeInfo pbm_pci_bridge_info = {
-    .name          = TYPE_PBM_PCI_BRIDGE,
-    .parent        = TYPE_PCI_BRIDGE,
-    .class_init    = pbm_pci_bridge_class_init,
-    .instance_size = sizeof(PBMPCIBridge),
-    .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
-    },
-};
-
 static void pbm_register_types(void)
 {
     type_register_static(&pbm_host_info);
     type_register_static(&pbm_pci_host_info);
-    type_register_static(&pbm_pci_bridge_info);
 }
 
 type_init(pbm_register_types)
diff --git a/include/hw/pci-bridge/simba.h b/include/hw/pci-bridge/simba.h
new file mode 100644
index 0000000000..5ab1330236
--- /dev/null
+++ b/include/hw/pci-bridge/simba.h
@@ -0,0 +1,38 @@
+/*
+ * QEMU Simba PCI bridge
+ *
+ * Copyright (c) 2006 Fabrice Bellard
+ * Copyright (c) 2012,2013 Artyom Tarasenko
+ * Copyright (c) 2017 Mark Cave-Ayland
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
+#include "hw/pci/pci_bridge.h"
+
+
+typedef struct PBMPCIBridge {
+    /*< private >*/
+    PCIBridge parent_obj;
+} PBMPCIBridge;
+
+#define TYPE_PBM_PCI_BRIDGE "pbm-bridge"
+#define PBM_PCI_BRIDGE(obj) \
+    OBJECT_CHECK(PBMPCIBridge, (obj), TYPE_PBM_PCI_BRIDGE)
diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
index 604d899b1e..5e28f3e1f3 100644
--- a/include/hw/pci-host/apb.h
+++ b/include/hw/pci-host/apb.h
@@ -42,13 +42,4 @@ typedef struct APBState {
     unsigned int nr_resets;
 } APBState;
 
-typedef struct PBMPCIBridge {
-    /*< private >*/
-    PCIBridge parent_obj;
-} PBMPCIBridge;
-
-#define TYPE_PBM_PCI_BRIDGE "pbm-bridge"
-#define PBM_PCI_BRIDGE(obj) \
-    OBJECT_CHECK(PBMPCIBridge, (obj), TYPE_PBM_PCI_BRIDGE)
-
 #endif
-- 
2.11.0
