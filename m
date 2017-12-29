Received: from eggs.gnu.org ([2001:4830:134:3::10]:56844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynO-00032q-9X
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynL-0005qH-2r
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:14 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:43331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynK-0005pj-Uz
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:11 -0500
Received: by mail-qk0-x241.google.com with SMTP id j137so35733253qke.10
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 09:50:10 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 Dec 2017 14:48:58 -0300
Message-Id: <20171229174933.1781-8-f4bug@amsat.org>
In-Reply-To: <20171229174933.1781-1-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 07/42] sdhci: refactor common sysbus/pci
 unrealize() into sdhci_unrealizefn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Xiaoqiang Zhao <zxq_yx_007@163.com>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ad5853d527..06a1ec6f91 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -31,6 +31,7 @@
 #include "qemu/bitops.h"
 #include "hw/sd/sdhci.h"
 #include "sdhci-internal.h"
+#include "qapi/error.h"
 #include "qemu/log.h"
 
 /* host controller debug messages */
@@ -1203,15 +1204,17 @@ static void sdhci_realizefn(SDHCIState *s, Error **errp)
                           SDHC_REGISTERS_MAP_SIZE);
 }
 
+static void sdhci_unrealizefn(SDHCIState *s, Error **errp)
+{
+    g_free(s->fifo_buffer);
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
@@ -1312,6 +1315,8 @@ static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
 static void sdhci_pci_exit(PCIDevice *dev)
 {
     SDHCIState *s = PCI_SDHCI(dev);
+
+    sdhci_unrealizefn(s, &error_abort);
     sdhci_uninitfn(s);
 }
 
@@ -1365,11 +1370,19 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
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
