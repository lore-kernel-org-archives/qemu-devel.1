Received: from eggs.gnu.org ([2001:4830:134:3::10]:47108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE2s-0000ak-TL
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE2r-00046p-S4
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:07:54 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:37871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE2r-00046S-Md
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:07:53 -0500
Received: by mail-qt0-x242.google.com with SMTP id f2so8558406qtj.4
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 21:07:53 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Jan 2018 02:07:09 -0300
Message-Id: <20180113050717.22969-7-f4bug@amsat.org>
In-Reply-To: <20180113050717.22969-1-f4bug@amsat.org>
References: <20180113050717.22969-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 06/14] sdhci: refactor common sysbus/pci
 unrealize() into sdhci_common_unrealize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index b464143959..ded4fa4885 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -32,6 +32,7 @@
 #include "qemu/bitops.h"
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 
 /* host controller debug messages */
@@ -1230,6 +1231,17 @@ static void sdhci_common_realize(SDHCIState *s, Error **errp)
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
@@ -1319,6 +1331,8 @@ static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
 static void sdhci_pci_exit(PCIDevice *dev)
 {
     SDHCIState *s = PCI_SDHCI(dev);
+
+    sdhci_common_unrealize(s, &error_abort);
     sdhci_uninitfn(s);
 }
 
@@ -1383,11 +1397,19 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
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
 
     dc->realize = sdhci_sysbus_realize;
+    dc->unrealize = sdhci_sysbus_unrealize;
 
     sdhci_common_class_init(klass, data);
 }
-- 
2.15.1
