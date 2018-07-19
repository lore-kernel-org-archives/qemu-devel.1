Received: from eggs.gnu.org ([2001:4830:134:3::10]:57583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fg9q7-0006U9-65
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 10:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fg9q3-0005nC-6Q
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 10:23:31 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 19 Jul 2018 16:23:23 +0200
Message-Id: <1532010203-21331-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/timer/mc146818rtc: Fix introspection problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org

There is currently a funny problem with the "mc146818rtc" device:
1) Start QEMU like this:
   qemu-system-ppc64 -M pseries -S
2) At the HMP monitor, enter "info qom-tree". Note that there is an
   entry for "/rtc (spapr-rtc)".
3) Introspect the mc146818rtc device like this:
   device_add mc146818rtc,help
4) Run "info qom-tree" again. The "/rtc" entry is gone now!

The rtc_finalize() function of the mc146818rtc device has two bugs: First,
it tries to remove a "rtc" property, while the rtc_realizefn() added a
"rtc-time" property instead. And second, it should be done in an unrealize
function, not in a finalize function, to avoid that this causes problems
during introspection.

Fixes: 654a36d857ff949e0d1989904b76f53fded9dc83
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/timer/mc146818rtc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 6f1f723..c0c6a72 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -1001,6 +1001,11 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     qdev_init_gpio_out(dev, &s->irq, 1);
 }
 
+static void rtc_unrealize(DeviceState *dev, Error **errp)
+{
+    object_property_del(qdev_get_machine(), "rtc-time", errp);
+}
+
 ISADevice *mc146818_rtc_init(ISABus *bus, int base_year, qemu_irq intercept_irq)
 {
     DeviceState *dev;
@@ -1045,6 +1050,7 @@ static void rtc_class_initfn(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = rtc_realizefn;
+    dc->unrealize = rtc_unrealize;
     dc->reset = rtc_resetdev;
     dc->vmsd = &vmstate_rtc;
     dc->props = mc146818rtc_properties;
@@ -1052,17 +1058,11 @@ static void rtc_class_initfn(ObjectClass *klass, void *data)
     dc->user_creatable = false;
 }
 
-static void rtc_finalize(Object *obj)
-{
-    object_property_del(qdev_get_machine(), "rtc", NULL);
-}
-
 static const TypeInfo mc146818rtc_info = {
     .name          = TYPE_MC146818_RTC,
     .parent        = TYPE_ISA_DEVICE,
     .instance_size = sizeof(RTCState),
     .class_init    = rtc_class_initfn,
-    .instance_finalize = rtc_finalize,
 };
 
 static void mc146818rtc_register_types(void)
-- 
1.8.3.1
