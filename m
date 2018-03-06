Received: from eggs.gnu.org ([2001:4830:134:3::10]:49514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nz-0001YM-1v
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nx-0004WM-PB
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:23 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:43 +1100
Message-Id: <20180306040154.3669-20-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 19/30] macio: move setting of CUDA timebase
 frequency to macio_common_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, groug@kaod.org
Cc: agraf@suse.de, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This removes the last of the functionality from macio_init() in preparation
for its subsequent removal.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
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
2.14.3
