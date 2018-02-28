Received: from eggs.gnu.org ([2001:4830:134:3::10]:60321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1er8So-0003Uh-8x
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1er8Sn-0003mj-Hp
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:36:34 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed, 28 Feb 2018 20:32:42 +0000
Message-Id: <20180228203243.1413-12-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180228203243.1413-1-mark.cave-ayland@ilande.co.uk>
References: <20180228203243.1413-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv3 11/12] macio: move setting of CUDA timebase
 frequency to macio_common_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This removes the last of the functionality from macio_init() in preparation
for its subsequent removal.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/macio.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index e5288f1084..f71ed61819 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -101,6 +101,8 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
     memory_region_add_subregion(&s->bar, 0x08000,
                                 sysbus_mmio_get_region(sysbus_dev, 0));
 
+    qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
+                         s->frequency);
     object_property_set_bool(OBJECT(&s->cuda), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -444,12 +446,7 @@ type_init(macio_register_types)
 void macio_init(PCIDevice *d,
                 MemoryRegion *pic_mem)
 {
-    MacIOState *macio_state = MACIO(d);
-
     /* Note: this code is strongly inspirated from the corresponding code
        in PearPC */
-    qdev_prop_set_uint64(DEVICE(&macio_state->cuda), "timebase-frequency",
-                         macio_state->frequency);
-
     qdev_init_nofail(DEVICE(d));
 }
-- 
2.11.0
