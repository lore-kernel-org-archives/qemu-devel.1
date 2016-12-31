Received: from eggs.gnu.org ([2001:4830:134:3::10]:54776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K5-0001QH-JB
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K3-0000Ku-5D
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:19:01 -0500
Received: from m12-14.163.com ([220.181.12.14]:45614)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8K2-0000K8-Is
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:18:59 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 31 Dec 2016 09:18:45 +0800
Message-Id: <20161231011847.4153-4-zxq_yx_007@163.com>
In-Reply-To: <20161231011847.4153-1-zxq_yx_007@163.com>
References: <20161231011847.4153-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH 3/5] hw/sd: QOM'ify milkymist-memcard.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: michael@walle.cc

split the old SysBus init function into an instance_init
and Device realize function

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/sd/milkymist-memcard.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 1f2f0ed44a..c5abcfe51f 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -30,6 +30,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "hw/sd/sd.h"
+#include "qapi/error.h"
 
 enum {
     ENABLE_CMD_TX   = (1<<0),
@@ -250,7 +251,17 @@ static void milkymist_memcard_reset(DeviceState *d)
     }
 }
 
-static int milkymist_memcard_init(SysBusDevice *dev)
+static void milkymist_memcard_init(Object *obj)
+{
+    MilkymistMemcardState *s = MILKYMIST_MEMCARD(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->regs_region, obj, &memcard_mmio_ops, s,
+            "milkymist-memcard", R_MAX * 4);
+    sysbus_init_mmio(dev, &s->regs_region);
+}
+
+static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
 {
     MilkymistMemcardState *s = MILKYMIST_MEMCARD(dev);
     DriveInfo *dinfo;
@@ -261,16 +272,10 @@ static int milkymist_memcard_init(SysBusDevice *dev)
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
     s->card = sd_init(blk, false);
     if (s->card == NULL) {
-        return -1;
+        error_setg(errp, "sd_init failed");
     }
 
     s->enabled = blk && blk_is_inserted(blk);
-
-    memory_region_init_io(&s->regs_region, OBJECT(s), &memcard_mmio_ops, s,
-            "milkymist-memcard", R_MAX * 4);
-    sysbus_init_mmio(dev, &s->regs_region);
-
-    return 0;
 }
 
 static const VMStateDescription vmstate_milkymist_memcard = {
@@ -293,19 +298,19 @@ static const VMStateDescription vmstate_milkymist_memcard = {
 static void milkymist_memcard_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = milkymist_memcard_init;
     dc->reset = milkymist_memcard_reset;
     dc->vmsd = &vmstate_milkymist_memcard;
     /* Reason: init() method uses drive_get_next() */
     dc->cannot_instantiate_with_device_add_yet = true;
+    dc->realize = milkymist_memcard_realize;
 }
 
 static const TypeInfo milkymist_memcard_info = {
     .name          = TYPE_MILKYMIST_MEMCARD,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MilkymistMemcardState),
+    .instance_init = milkymist_memcard_init,
     .class_init    = milkymist_memcard_class_init,
 };
 
-- 
2.11.0
