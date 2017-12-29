Received: from eggs.gnu.org ([2001:4830:134:3::10]:39262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eUvg7-0000Db-4H
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eUvg6-0006HF-CG
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:31 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:38292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1eUvg6-0006Bb-6V
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 09:30:30 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Fri, 29 Dec 2017 15:29:10 +0100
Message-Id: <20171229142922.31701-5-hpoussin@reactos.org>
In-Reply-To: <20171229142922.31701-1-hpoussin@reactos.org>
References: <20171229142922.31701-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 04/16] mc146818rtc: always register rtc to
 rtc list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

We are not required anymore to use rtc_init() function.

Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/timer/mc146818rtc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 3e8c0b7d33..0b0da691cc 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -905,6 +905,13 @@ static void rtc_get_date(Object *obj, struct tm *current_tm, Error **errp)
     rtc_get_time(s, current_tm);
 }
 
+static int rtc_initfn(DeviceState *dev)
+{
+    RTCState *s = MC146818_RTC(dev);
+    QLIST_INSERT_HEAD(&rtc_devices, s, link);
+    return 0;
+}
+
 static void rtc_realizefn(DeviceState *dev, Error **errp)
 {
     ISADevice *isadev = ISA_DEVICE(dev);
@@ -973,11 +980,9 @@ ISADevice *mc146818_rtc_init(ISABus *bus, int base_year, qemu_irq intercept_irq)
 {
     DeviceState *dev;
     ISADevice *isadev;
-    RTCState *s;
 
     isadev = isa_create(bus, TYPE_MC146818_RTC);
     dev = DEVICE(isadev);
-    s = MC146818_RTC(isadev);
     qdev_prop_set_int32(dev, "base_year", base_year);
     qdev_init_nofail(dev);
     if (intercept_irq) {
@@ -985,7 +990,6 @@ ISADevice *mc146818_rtc_init(ISABus *bus, int base_year, qemu_irq intercept_irq)
     } else {
         isa_connect_gpio_out(isadev, 0, RTC_ISA_IRQ);
     }
-    QLIST_INSERT_HEAD(&rtc_devices, s, link);
 
     return isadev;
 }
@@ -1012,12 +1016,11 @@ static void rtc_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->init = rtc_initfn;
     dc->realize = rtc_realizefn;
     dc->reset = rtc_resetdev;
     dc->vmsd = &vmstate_rtc;
     dc->props = mc146818rtc_properties;
-    /* Reason: needs to be wired up by rtc_init() */
-    dc->user_creatable = false;
 }
 
 static void rtc_finalize(Object *obj)
-- 
2.11.0
