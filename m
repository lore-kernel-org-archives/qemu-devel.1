Received: from eggs.gnu.org ([2001:4830:134:3::10]:44151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRFI4-0004bd-T9
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRFI0-0006Fo-10
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:33:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRFHz-0006F6-RB
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 04:33:51 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 11 Jan 2017 10:33:44 +0100
Message-Id: <1484127227-26496-3-git-send-email-kraxel@redhat.com>
In-Reply-To: <1484127227-26496-1-git-send-email-kraxel@redhat.com>
References: <1484127227-26496-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] hw/audio: QOM'ify pl041.c
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
Message-id: 20161231011720.3965-3-zxq_yx_007@163.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/pl041.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index 6e9c104..c8cc503 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -521,12 +521,23 @@ static const MemoryRegionOps pl041_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static int pl041_init(SysBusDevice *dev)
+static void pl041_init(Object *obj)
 {
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
     PL041State *s = PL041(dev);
 
     DBG_L1("pl041_init 0x%08x\n", (uint32_t)s);
 
+    /* Connect the device to the sysbus */
+    memory_region_init_io(&s->iomem, obj, &pl041_ops, s, "pl041", 0x1000);
+    sysbus_init_mmio(dev, &s->iomem);
+    sysbus_init_irq(dev, &s->irq);
+}
+
+static void pl041_realize(DeviceState *dev, Error **errp)
+{
+    PL041State *s = PL041(dev);
+
     /* Check the device properties */
     switch (s->fifo_depth) {
     case 8:
@@ -545,18 +556,10 @@ static int pl041_init(SysBusDevice *dev)
         qemu_log_mask(LOG_UNIMP,
                       "pl041: unsupported non-compact fifo depth [%i]\n",
                       s->fifo_depth);
-        return -1;
     }
 
-    /* Connect the device to the sysbus */
-    memory_region_init_io(&s->iomem, OBJECT(s), &pl041_ops, s, "pl041", 0x1000);
-    sysbus_init_mmio(dev, &s->iomem);
-    sysbus_init_irq(dev, &s->irq);
-
     /* Init the codec */
     lm4549_init(&s->codec, &pl041_request_data, (void *)s);
-
-    return 0;
 }
 
 static const VMStateDescription vmstate_pl041_regfile = {
@@ -627,9 +630,8 @@ static Property pl041_device_properties[] = {
 static void pl041_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
 
-    k->init = pl041_init;
+    dc->realize = pl041_realize;
     set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
     dc->reset = pl041_device_reset;
     dc->vmsd = &vmstate_pl041;
@@ -640,6 +642,7 @@ static const TypeInfo pl041_device_info = {
     .name          = TYPE_PL041,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(PL041State),
+    .instance_init = pl041_init,
     .class_init    = pl041_device_class_init,
 };
 
-- 
1.8.3.1
