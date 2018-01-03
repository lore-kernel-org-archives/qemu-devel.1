Received: from eggs.gnu.org ([2001:4830:134:3::10]:47807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWgo0-00036c-Ad
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 06:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWgnz-0005sm-EO
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 06:01:56 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:39877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWgnz-0005sE-B4
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 06:01:55 -0500
Received: by mail-qt0-x241.google.com with SMTP id k19so1630924qtj.6
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 03:01:55 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 08:01:16 -0300
Message-Id: <20180103110126.29209-8-f4bug@amsat.org>
In-Reply-To: <20180103110126.29209-1-f4bug@amsat.org>
References: <20180103110126.29209-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 07/17] sdhci: refactor common sysbus/pci
 unrealize() into sdhci_unrealizefn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index d5c6d8ab0b..967521d347 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -32,6 +32,7 @@
 #include "qapi/error.h"
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 
 /* host controller debug messages */
@@ -1204,15 +1205,23 @@ static void sdhci_realizefn(SDHCIState *s, Error **errp)
                           SDHC_REGISTERS_MAP_SIZE);
 }
 
+static void sdhci_unrealizefn(SDHCIState *s, Error **errp)
+{
+    g_free(s->fifo_buffer);
+    /* This function is expected to be called only once for each class:
+     * - SysBus:    via DeviceClass->unrealize(),
+     * - PCI:       via PCIDeviceClass->exit().
+     * However to avoid double-free and/or use-after-free we still nullify
+     * this variable (better safe than sorry!). */
+    s->fifo_buffer = NULL;
+}
+
 static void sdhci_uninitfn(SDHCIState *s)
 {
     timer_del(s->insert_timer);
     timer_free(s->insert_timer);
     timer_del(s->transfer_timer);
     timer_free(s->transfer_timer);
-
-    g_free(s->fifo_buffer);
-    s->fifo_buffer = NULL;
 }
 
 static bool sdhci_pending_insert_vmstate_needed(void *opaque)
@@ -1318,6 +1327,8 @@ static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
 static void sdhci_pci_exit(PCIDevice *dev)
 {
     SDHCIState *s = PCI_SDHCI(dev);
+
+    sdhci_unrealizefn(s, &error_abort);
     sdhci_uninitfn(s);
 }
 
@@ -1376,11 +1387,19 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
+static void sdhci_sysbus_unrealize(DeviceState *dev, Error **errp)
+{
+    SDHCIState *s = SYSBUS_SDHCI(dev);
+
+    sdhci_unrealizefn(s, &error_abort);
+}
+
 static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = sdhci_sysbus_realize;
+    dc->unrealize = sdhci_sysbus_unrealize;
 
     sdhci_class_init(klass, data);
 }
-- 
2.15.1
