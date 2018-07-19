Received: from eggs.gnu.org ([208.118.235.92]:38282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fg8mZ-0001uF-Jp
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fg8mU-0000Ki-Su
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:15:47 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 19 Jul 2018 15:15:34 +0200
Message-Id: <1532006134-7701-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/arm/spitz: Move problematic nand_init()
 code to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>
Cc: qemu-arm@nongnu.org

nand_init() does not only create the NAND device, it also realizes
the device with qdev_init_nofail() already. So we must not call
nand_init() from an instance_init function like sl_nand_init(),
otherwise we get superfluous NAND devices in the QOM tree after
introspecting the 'sl-nand' device. So move the nand_init() to the
realize function of 'sl-nand' instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/spitz.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 3cc27a1..c4bc3de 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -169,16 +169,22 @@ static void sl_nand_init(Object *obj)
 {
     SLNANDState *s = SL_NAND(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
-    DriveInfo *nand;
 
     s->ctl = 0;
+
+    memory_region_init_io(&s->iomem, obj, &sl_ops, s, "sl", 0x40);
+    sysbus_init_mmio(dev, &s->iomem);
+}
+
+static void sl_nand_realize(DeviceState *dev, Error **errp)
+{
+    SLNANDState *s = SL_NAND(dev);
+    DriveInfo *nand;
+
     /* FIXME use a qdev drive property instead of drive_get() */
     nand = drive_get(IF_MTD, 0, 0);
     s->nand = nand_init(nand ? blk_by_legacy_dinfo(nand) : NULL,
                         s->manf_id, s->chip_id);
-
-    memory_region_init_io(&s->iomem, obj, &sl_ops, s, "sl", 0x40);
-    sysbus_init_mmio(dev, &s->iomem);
 }
 
 /* Spitz Keyboard */
@@ -1079,6 +1085,7 @@ static void sl_nand_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &vmstate_sl_nand_info;
     dc->props = sl_nand_properties;
+    dc->realize = sl_nand_realize;
     /* Reason: init() method uses drive_get() */
     dc->user_creatable = false;
 }
-- 
1.8.3.1
