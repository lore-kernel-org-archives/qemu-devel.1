Received: from eggs.gnu.org ([2001:4830:134:3::10]:57084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70a-0001iN-TD
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70W-0004GT-SJ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:52 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:43:16 +1000
Message-Id: <20170927074316.4454-27-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 26/26] macio: use object link between MACIO_IDE
 and MAC_DBDMA object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Using a standard QOM object link we can pass a reference to the MAC_DBDMA
controller to the MACIO_IDE object which removes the last external parameter
to macio_ide_register_dma().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ide/macio.c        | 9 ++++++---
 hw/misc/macio/macio.c | 3 ++-
 hw/ppc/mac.h          | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 19d5f5a8b3..ce194c6cec 100644
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
index 41b377e7a0..9aa7e7559b 100644
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
index b3a26c49c1..b501af1653 100644
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
2.13.5
