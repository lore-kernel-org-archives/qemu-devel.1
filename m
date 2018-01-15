Received: from eggs.gnu.org ([2001:4830:134:3::10]:60126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9RY-0008PG-8b
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9RV-00035v-4A
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:25:12 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:43900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9RU-00035m-W3
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:25:09 -0500
Received: by mail-qk0-x242.google.com with SMTP id a5so15079274qkg.10
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:25:08 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 15 Jan 2018 15:24:28 -0300
Message-Id: <20180115182436.2066-7-f4bug@amsat.org>
In-Reply-To: <20180115182436.2066-1-f4bug@amsat.org>
References: <20180115182436.2066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 06/14] sdhci: refactor common sysbus/pci
 unrealize() into sdhci_common_unrealize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index cf0c079990..bbe4570326 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -32,6 +32,7 @@
 #include "qemu/bitops.h"
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 
 /* host controller debug messages */
@@ -1223,6 +1224,17 @@ static void sdhci_common_realize(SDHCIState *s, Error **errp)
                           SDHC_REGISTERS_MAP_SIZE);
 }
 
+static void sdhci_common_unrealize(SDHCIState *s, Error **errp)
+{
+    /* This function is expected to be called only once for each class:
+     * - SysBus:    via DeviceClass->unrealize(),
+     * - PCI:       via PCIDeviceClass->exit().
+     * However to avoid double-free and/or use-after-free we still nullify
+     * this variable (better safe than sorry!). */
+    g_free(s->fifo_buffer);
+    s->fifo_buffer = NULL;
+}
+
 static bool sdhci_pending_insert_vmstate_needed(void *opaque)
 {
     SDHCIState *s = opaque;
@@ -1317,6 +1329,8 @@ static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
 static void sdhci_pci_exit(PCIDevice *dev)
 {
     SDHCIState *s = PCI_SDHCI(dev);
+
+    sdhci_common_unrealize(s, &error_abort);
     sdhci_uninitfn(s);
 }
 
@@ -1382,12 +1396,20 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
+static void sdhci_sysbus_unrealize(DeviceState *dev, Error **errp)
+{
+    SDHCIState *s = SYSBUS_SDHCI(dev);
+
+    sdhci_common_unrealize(s, &error_abort);
+}
+
 static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->props = sdhci_sysbus_properties;
     dc->realize = sdhci_sysbus_realize;
+    dc->unrealize = sdhci_sysbus_unrealize;
 
     sdhci_common_class_init(klass, data);
 }
-- 
2.15.1
