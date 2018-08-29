Received: from eggs.gnu.org ([2001:4830:134:3::10]:52598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fv3wb-0005L7-Ng
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fv3oa-0004MI-3O
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:59:33 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 29 Aug 2018 17:59:07 +0100
Message-Id: <20180829165911.30106-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180829165911.30106-1-mark.cave-ayland@ilande.co.uk>
References: <20180829165911.30106-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 3/7] macio: add addr property to macio IDE
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This contains the offset of the IDE controller within the macio address space
and is required to allow the address to be included within the fw path.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/macio.c                | 1 +
 hw/misc/macio/macio.c         | 5 +++--
 include/hw/misc/macio/macio.h | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index f23961e241..bab8c45a43 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -461,6 +461,7 @@ static void macio_ide_initfn(Object *obj)
 
 static Property macio_ide_properties[] = {
     DEFINE_PROP_UINT32("channel", MACIOIDEState, channel, 0),
+    DEFINE_PROP_UINT32("addr", MACIOIDEState, addr, -1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 229bfddb90..94da85c8d7 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -219,10 +219,11 @@ static void macio_init_ide(MacIOState *s, MACIOIDEState *ide, size_t ide_size,
                            int index)
 {
     gchar *name = g_strdup_printf("ide[%i]", index);
+    uint32_t addr = 0x1f000 + ((index + 1) * 0x1000);
 
     macio_init_child_obj(s, name, ide, ide_size, TYPE_MACIO_IDE);
-    memory_region_add_subregion(&s->bar, 0x1f000 + ((index + 1) * 0x1000),
-                                &ide->mem);
+    qdev_prop_set_uint32(DEVICE(ide), "addr", addr);
+    memory_region_add_subregion(&s->bar, addr, &ide->mem);
     g_free(name);
 }
 
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index 3189973ee6..970058b6ed 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -51,6 +51,7 @@ typedef struct MACIOIDEState {
     /*< private >*/
     SysBusDevice parent_obj;
     /*< public >*/
+    uint32_t addr;
     uint32_t channel;
     qemu_irq real_ide_irq;
     qemu_irq real_dma_irq;
-- 
2.11.0
