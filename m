Received: from eggs.gnu.org ([2001:4830:134:3::10]:57753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDC3-00034p-OM
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDBy-0005eq-Pk
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:59:51 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:45715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDBy-0005eb-LY
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 14:59:46 -0500
Received: by mail-qt0-x242.google.com with SMTP id g10so5180863qtj.12
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 11:59:46 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 16:58:47 -0300
Message-Id: <20171213195852.30439-10-f4bug@amsat.org>
In-Reply-To: <20171213195852.30439-1-f4bug@amsat.org>
References: <20171213195852.30439-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/14] sdhci: refactor common sysbus/pci
 unrealize() into sdhci_unrealizefn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 893be0e606..044e3d62f1 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -31,6 +31,7 @@
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
 #include "sd-internal.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 
 /* host controller debug messages */
@@ -1191,17 +1192,21 @@ static void sdhci_realizefn(SDHCIState *s, Error **errp)
                           SDHC_REGISTERS_MAP_SIZE);
 }
 
+static void sdhci_unrealizefn(SDHCIState *s, Error **errp)
+{
+    g_free(s->fifo_buffer);
+    s->fifo_buffer = NULL;
+}
+
 static void sdhci_uninitfn(SDHCIState *s)
 {
     timer_del(s->insert_timer);
     timer_free(s->insert_timer);
     timer_del(s->transfer_timer);
     timer_free(s->transfer_timer);
+
     qemu_free_irq(s->eject_cb);
     qemu_free_irq(s->ro_cb);
-
-    g_free(s->fifo_buffer);
-    s->fifo_buffer = NULL;
 }
 
 static bool sdhci_pending_insert_vmstate_needed(void *opaque)
@@ -1302,6 +1307,8 @@ static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
 static void sdhci_pci_exit(PCIDevice *dev)
 {
     SDHCIState *s = PCI_SDHCI(dev);
+
+    sdhci_unrealizefn(s, &error_abort);
     sdhci_uninitfn(s);
 }
 
@@ -1355,11 +1362,19 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
+static void sdhci_sysbus_unrealize(DeviceState *dev, Error **errp)
+{
+    SDHCIState *s = SYSBUS_SDHCI(dev);
+
+    sdhci_unrealizefn(s, errp);
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
