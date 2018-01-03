Received: from eggs.gnu.org ([2001:4830:134:3::10]:44102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWlpv-00043S-Ga
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 11:24:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWlpu-0004yn-Km
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 11:24:15 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 13:23:56 -0300
Message-Id: <20180103162400.10396-3-f4bug@amsat.org>
In-Reply-To: <20180103162400.10396-1-f4bug@amsat.org>
References: <20180103162400.10396-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/6] hw/sd/milkymist-memcard: split realize()
 out of SysBusDevice init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Xiaoqiang Zhao <zxq_yx_007@163.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-arm@nongnu.org

Create the SDCard in the realize() function.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/milkymist-memcard.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 5de3e00e2f..5df3a0f815 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -255,24 +255,29 @@ static void milkymist_memcard_reset(DeviceState *d)
 static int milkymist_memcard_init(SysBusDevice *dev)
 {
     MilkymistMemcardState *s = MILKYMIST_MEMCARD(dev);
-    DriveInfo *dinfo;
+
+    memory_region_init_io(&s->regs_region, OBJECT(s), &memcard_mmio_ops, s,
+            "milkymist-memcard", R_MAX * 4);
+    sysbus_init_mmio(dev, &s->regs_region);
+
+    return 0;
+}
+
+static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
+{
+    MilkymistMemcardState *s = MILKYMIST_MEMCARD(dev);
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
@@ -298,6 +303,7 @@ static void milkymist_memcard_class_init(ObjectClass *klass, void *data)
     SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
     k->init = milkymist_memcard_init;
+    dc->realize = milkymist_memcard_realize;
     dc->reset = milkymist_memcard_reset;
     dc->vmsd = &vmstate_milkymist_memcard;
     /* Reason: init() method uses drive_get_next() */
-- 
2.15.1
