Received: from eggs.gnu.org ([2001:4830:134:3::10]:44153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRFI4-0004bf-Tg
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRFI0-0006Ft-1D
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:33:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRFHz-0006FH-Rp
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:33:51 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Jan 2017 10:33:43 +0100
Message-Id: <1484127227-26496-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1484127227-26496-1-git-send-email-kraxel@redhat.com>
References: <1484127227-26496-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] hw/audio: QOM'ify marvell_88w8618.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xiaoqiang zhao <zxq_yx_007@163.com>, Gerd Hoffmann <kraxel@redhat.com>

From: xiaoqiang zhao <zxq_yx_007@163.com>

split the old SysBus init function into an instance_init
and Device realize function

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
Message-id: 20161231011720.3965-2-zxq_yx_007@163.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/marvell_88w8618.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index a6ca180..511b004 100644
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
1.8.3.1
