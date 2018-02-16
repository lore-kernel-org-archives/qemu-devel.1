Received: from eggs.gnu.org ([2001:4830:134:3::10]:60338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emVmg-0005OO-PH
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:30:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emVmf-0002U8-Oz
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:29:58 -0500
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:36208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emVmf-0002Tw-KN
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 21:29:57 -0500
Received: by mail-vk0-x244.google.com with SMTP id m197so1063951vka.3
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 18:29:57 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 23:29:27 -0300
Message-Id: <20180216022933.10945-3-f4bug@amsat.org>
In-Reply-To: <20180216022933.10945-1-f4bug@amsat.org>
References: <20180216022933.10945-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 2/7] hw/sd/milkymist-memcard: split
 realize() out of SysBusDevice init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrzej Zaborowski <balrogg@gmail.com>, Michael Walle <michael@walle.cc>, Stefan Weil <sw@weilnetz.de>

Create the SDCard in the realize() function.

Suggested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Acked-by: Michael Walle <michael@walle.cc>
---
 hw/sd/milkymist-memcard.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 1292c0c099..a8e65892c7 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -257,27 +257,31 @@ static void milkymist_memcard_reset(DeviceState *d)
     device_reset(DEVICE(s->card));
 }
 
-static int milkymist_memcard_init(SysBusDevice *dev)
+static void milkymist_memcard_init(Object *obj)
+{
+    MilkymistMemcardState *s = MILKYMIST_MEMCARD(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->regs_region, OBJECT(s), &memcard_mmio_ops, s,
+            "milkymist-memcard", R_MAX * 4);
+    sysbus_init_mmio(dev, &s->regs_region);
+}
+
+static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
 {
     MilkymistMemcardState *s = MILKYMIST_MEMCARD(dev);
-    DriveInfo *dinfo;
     BlockBackend *blk;
+    DriveInfo *dinfo;
 
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo = drive_get_next(IF_SD);
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
     s->card = sd_init(blk, false);
     if (s->card == NULL) {
-        return -1;
+        error_setg(errp, "failed to init SD card");
+        return;
     }
-
     s->enabled = blk && blk_is_inserted(blk);
-
-    memory_region_init_io(&s->regs_region, OBJECT(s), &memcard_mmio_ops, s,
-            "milkymist-memcard", R_MAX * 4);
-    sysbus_init_mmio(dev, &s->regs_region);
-
-    return 0;
 }
 
 static const VMStateDescription vmstate_milkymist_memcard = {
@@ -300,9 +304,8 @@ static const VMStateDescription vmstate_milkymist_memcard = {
 static void milkymist_memcard_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = milkymist_memcard_init;
+    dc->realize = milkymist_memcard_realize;
     dc->reset = milkymist_memcard_reset;
     dc->vmsd = &vmstate_milkymist_memcard;
     /* Reason: init() method uses drive_get_next() */
@@ -313,6 +316,7 @@ static const TypeInfo milkymist_memcard_info = {
     .name          = TYPE_MILKYMIST_MEMCARD,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MilkymistMemcardState),
+    .instance_init = milkymist_memcard_init,
     .class_init    = milkymist_memcard_class_init,
 };
 
-- 
2.16.1
