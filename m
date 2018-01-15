Received: from eggs.gnu.org ([2001:4830:134:3::10]:60332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9Rz-0000Oo-SO
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9Rw-0003LS-Mx
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:25:39 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9Rw-0003L3-6w
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:25:36 -0500
Received: by mail-qk0-x241.google.com with SMTP id i141so17926003qke.0
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:25:36 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 15 Jan 2018 15:24:36 -0300
Message-Id: <20180115182436.2066-15-f4bug@amsat.org>
In-Reply-To: <20180115182436.2066-1-f4bug@amsat.org>
References: <20180115182436.2066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 14/14] sdhci: add a 'dma' property to the
 sysbus devices
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

Add a 'dma' property allowing machine creation to provide the address-space
SDHCI DMA operates on.

[based on a patch from Alistair Francis <alistair.francis@xilinx.com>
 from qemu/xilinx tag xilinx-v2016.1]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sdhci.h |  1 +
 hw/sd/sdhci.c         | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 4a102b86ce..cb37182536 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -42,6 +42,7 @@ typedef struct SDHCIState {
     SDBus sdbus;
     MemoryRegion iomem;
     AddressSpace *dma_as;
+    MemoryRegion *dma_mr;
 
     QEMUTimer *insert_timer;       /* timer for 'changing' sd card. */
     QEMUTimer *transfer_timer;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index dd400695e4..f9264d3be5 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1354,6 +1354,8 @@ static Property sdhci_sysbus_properties[] = {
     DEFINE_SDHCI_COMMON_PROPERTIES(SDHCIState),
     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
                      false),
+    DEFINE_PROP_LINK("dma", SDHCIState,
+                     dma_mr, TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1367,6 +1369,11 @@ static void sdhci_sysbus_init(Object *obj)
 static void sdhci_sysbus_finalize(Object *obj)
 {
     SDHCIState *s = SYSBUS_SDHCI(obj);
+
+    if (s->dma_mr) {
+        object_unparent(OBJECT(s->dma_mr));
+    }
+
     sdhci_uninitfn(s);
 }
 
@@ -1380,7 +1387,12 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
         return;
     }
 
-    s->dma_as = &address_space_memory;
+    if (s->dma_mr) {
+        address_space_init(s->dma_as, s->dma_mr, "sdhci-dma");
+    } else {
+        /* use system_memory() if property "dma" not set */
+        s->dma_as = &address_space_memory;
+    }
 
     sysbus_init_irq(sbd, &s->irq);
     sysbus_init_mmio(sbd, &s->iomem);
@@ -1391,6 +1403,10 @@ static void sdhci_sysbus_unrealize(DeviceState *dev, Error **errp)
     SDHCIState *s = SYSBUS_SDHCI(dev);
 
     sdhci_common_unrealize(s, &error_abort);
+
+     if (s->dma_mr) {
+        address_space_destroy(s->dma_as);
+    }
 }
 
 static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
-- 
2.15.1
