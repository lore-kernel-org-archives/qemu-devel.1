Received: from eggs.gnu.org ([2001:4830:134:3::10]:57196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dw8Cc-0002hu-LR
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 10:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dw8Cb-0002Iz-Sl
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 10:48:14 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 24 Sep 2017 15:47:44 +0100
Message-Id: <1506264466-28252-6-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1506264466-28252-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 5/7] macio: use object link between MACIO_IDE
 and MAC_DBDMA object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

Using a standard QOM object link we can pass a reference to the MAC_DBDMA
controller to the MACIO_IDE object which removes the last external parameter
to macio_ide_register_dma().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/macio.c        |    9 ++++++---
 hw/misc/macio/macio.c |    3 ++-
 hw/ppc/mac.h          |    2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 19d5f5a..ce194c6 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -450,6 +450,10 @@ static void macio_ide_initfn(Object *obj)
     sysbus_init_irq(d, &s->real_dma_irq);
     s->dma_irq = qemu_allocate_irq(pmac_ide_irq, s, 0);
     s->ide_irq = qemu_allocate_irq(pmac_ide_irq, s, 1);
+
+    object_property_add_link(obj, "dbdma", TYPE_MAC_DBDMA,
+                             (Object **) &s->dbdma,
+                             qdev_prop_allow_set_link_before_realize, 0, NULL);
 }
 
 static Property macio_ide_properties[] = {
@@ -493,10 +497,9 @@ void macio_ide_init_drives(MACIOIDEState *s, DriveInfo **hd_table)
     }
 }
 
-void macio_ide_register_dma(MACIOIDEState *s, void *dbdma)
+void macio_ide_register_dma(MACIOIDEState *s)
 {
-    s->dbdma = dbdma;
-    DBDMA_register_channel(dbdma, s->channel, s->dma_irq,
+    DBDMA_register_channel(s->dbdma, s->channel, s->dma_irq,
                            pmac_ide_transfer, pmac_ide_flush, s);
 }
 
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 41b377e..9aa7e75 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -160,7 +160,8 @@ static void macio_realize_ide(MacIOState *s, MACIOIDEState *ide,
     sysbus_connect_irq(sysbus_dev, 0, irq0);
     sysbus_connect_irq(sysbus_dev, 1, irq1);
     qdev_prop_set_uint32(DEVICE(ide), "channel", dmaid);
-    macio_ide_register_dma(ide, s->dbdma);
+    object_property_set_link(OBJECT(ide), OBJECT(s->dbdma), "dbdma", errp);
+    macio_ide_register_dma(ide);
 
     object_property_set_bool(OBJECT(ide), true, "realized", errp);
 }
diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index b3a26c4..b501af1 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -147,7 +147,7 @@ typedef struct MACIOIDEState {
 } MACIOIDEState;
 
 void macio_ide_init_drives(MACIOIDEState *ide, DriveInfo **hd_table);
-void macio_ide_register_dma(MACIOIDEState *ide, void *dbdma);
+void macio_ide_register_dma(MACIOIDEState *ide);
 
 void macio_init(PCIDevice *dev,
                 MemoryRegion *pic_mem,
-- 
1.7.10.4
