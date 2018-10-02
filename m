Received: from eggs.gnu.org ([2001:4830:134:3::10]:42828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAm-0003O3-KA
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAl-0007Jf-8D
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:40 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:45466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAl-0007JP-0H
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:39 -0400
Received: by mail-wr1-x434.google.com with SMTP id q5-v6so3791970wrw.12
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 14:25:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 23:25:12 +0200
Message-Id: <20181002212522.23303-4-f4bug@amsat.org>
In-Reply-To: <20181002212522.23303-1-f4bug@amsat.org>
References: <20181002212522.23303-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 03/12] hw/timer/sun4v-rtc: Use
 DeviceState::realize rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>

Move from the legacy SysBusDevice::init method to using DeviceState::realize.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/timer/sun4v-rtc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
index 13be94f8da..4e7f6a1eff 100644
--- a/hw/timer/sun4v-rtc.c
+++ b/hw/timer/sun4v-rtc.c
@@ -63,21 +63,21 @@ void sun4v_rtc_init(hwaddr addr)
     sysbus_mmio_map(s, 0, addr);
 }
 
-static int sun4v_rtc_init1(SysBusDevice *dev)
+static void sun4v_rtc_realize(DeviceState *dev, Error **errp)
 {
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     Sun4vRtc *s = SUN4V_RTC(dev);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &sun4v_rtc_ops, s,
                           "sun4v-rtc", 0x08ULL);
-    sysbus_init_mmio(dev, &s->iomem);
-    return 0;
+    sysbus_init_mmio(sbd, &s->iomem);
 }
 
 static void sun4v_rtc_class_init(ObjectClass *klass, void *data)
 {
-    SysBusDeviceClass *k = SYS_BUS_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
-    k->init = sun4v_rtc_init1;
+    dc->realize = sun4v_rtc_realize;
 }
 
 static const TypeInfo sun4v_rtc_info = {
-- 
2.19.0
