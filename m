Received: from eggs.gnu.org ([2001:4830:134:3::10]:47266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE3I-0000ux-WD
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE3I-0004eA-2A
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:08:20 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE3H-0004dN-UG
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:08:19 -0500
Received: by mail-qt0-x243.google.com with SMTP id k19so8563908qtj.6
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 21:08:19 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Jan 2018 02:07:17 -0300
Message-Id: <20180113050717.22969-15-f4bug@amsat.org>
In-Reply-To: <20180113050717.22969-1-f4bug@amsat.org>
References: <20180113050717.22969-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 14/14] sdhci: add a 'dma' property to the
 sysbus devices
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

Add a 'dma' property allowing machine creation to provide the address-space
SDHCI DMA operates on.

[based on a patch from Alistair Francis <alistair.francis@xilinx.com>
 from qemu/xilinx tag xilinx-v2016.1]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sd/sdhci.h |  1 +
 hw/sd/sdhci.c         | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

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
index 024b559f14..cfb4320509 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1354,6 +1354,10 @@ static Property sdhci_sysbus_pending_insert_quirk_property =
      DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState,
                       pending_insert_quirk, false);
 
+static Property sdhci_sysbus_dma_mr_property =
+    DEFINE_PROP_LINK("dma", SDHCIState,
+                     dma_mr, TYPE_MEMORY_REGION, MemoryRegion *);
+
 static void sdhci_sysbus_init(Object *obj)
 {
     SDHCIState *s = SYSBUS_SDHCI(obj);
@@ -1363,11 +1367,19 @@ static void sdhci_sysbus_init(Object *obj)
     qdev_property_add_static(DEVICE(obj),
                              &sdhci_sysbus_pending_insert_quirk_property,
                              &error_abort);
+    qdev_property_add_static(DEVICE(obj),
+                             &sdhci_sysbus_dma_mr_property,
+                             &error_abort);
 }
 
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
 
@@ -1382,7 +1394,10 @@ static void sdhci_sysbus_realize(DeviceState *dev, Error ** errp)
     }
 
     s->dma_as = g_new0(AddressSpace, 1);
-    address_space_init(s->dma_as, get_system_memory(), "sdhci-dma");
+    /* use system_memory() if property "dma" not set */
+    address_space_init(s->dma_as,
+                       s->dma_mr ? s->dma_mr : get_system_memory(),
+                       "sdhci-dma");
 
     sysbus_init_irq(sbd, &s->irq);
     sysbus_init_mmio(sbd, &s->iomem);
-- 
2.15.1
