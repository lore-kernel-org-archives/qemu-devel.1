Received: from eggs.gnu.org ([2001:4830:134:3::10]:54314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8Is-0000ZT-M1
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8Ip-0008H1-IV
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:17:46 -0500
Received: from m12-14.163.com ([220.181.12.14]:42332)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zxq_yx_007@163.com>) id 1cN8Io-0008G4-Lt
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 20:17:43 -0500
From: xiaoqiang zhao <zxq_yx_007@163.com>
Date: Sat, 31 Dec 2016 09:17:19 +0800
Message-Id: <20161231011720.3965-2-zxq_yx_007@163.com>
In-Reply-To: <20161231011720.3965-1-zxq_yx_007@163.com>
References: <20161231011720.3965-1-zxq_yx_007@163.com>
Subject: [Qemu-devel] [PATCH 1/2] hw/audio: QOM'ify marvell_88w8618.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

split the old SysBus init function into an instance_init
and Device realize function

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/audio/marvell_88w8618.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index a6ca1806be..511b004287 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -241,19 +241,23 @@ static const MemoryRegionOps mv88w8618_audio_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int mv88w8618_audio_init(SysBusDevice *dev)
+static void mv88w8618_audio_init(Object *obj)
 {
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
     mv88w8618_audio_state *s = MV88W8618_AUDIO(dev);
 
     sysbus_init_irq(dev, &s->irq);
 
-    wm8750_data_req_set(s->wm, mv88w8618_audio_callback, s);
-
-    memory_region_init_io(&s->iomem, OBJECT(s), &mv88w8618_audio_ops, s,
+    memory_region_init_io(&s->iomem, obj, &mv88w8618_audio_ops, s,
                           "audio", MP_AUDIO_SIZE);
     sysbus_init_mmio(dev, &s->iomem);
+}
 
-    return 0;
+static void mv88w8618_audio_realize(DeviceState *dev, Error **errp)
+{
+    mv88w8618_audio_state *s = MV88W8618_AUDIO(dev);
+
+    wm8750_data_req_set(s->wm, mv88w8618_audio_callback, s);
 }
 
 static const VMStateDescription mv88w8618_audio_vmsd = {
@@ -282,9 +286,8 @@ static Property mv88w8618_audio_properties[] = {
 static void mv88w8618_audio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = mv88w8618_audio_init;
+    dc->realize = mv88w8618_audio_realize;
     dc->reset = mv88w8618_audio_reset;
     dc->vmsd = &mv88w8618_audio_vmsd;
     dc->props = mv88w8618_audio_properties;
@@ -296,6 +299,7 @@ static const TypeInfo mv88w8618_audio_info = {
     .name          = TYPE_MV88W8618_AUDIO,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(mv88w8618_audio_state),
+    .instance_init = mv88w8618_audio_init,
     .class_init    = mv88w8618_audio_class_init,
 };
 
-- 
2.11.0
