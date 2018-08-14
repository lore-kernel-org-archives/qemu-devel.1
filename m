Received: from eggs.gnu.org ([2001:4830:134:3::10]:49339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpabM-0000qk-DA
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpabL-0005Kx-GJ
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fpabL-0005Ki-9b
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 10:47:15 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 14 Aug 2018 16:46:56 +0200
Message-Id: <1534258018-22859-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1534258018-22859-1-git-send-email-thuth@redhat.com>
References: <1534258018-22859-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] hw/timer/mc146818rtc: Fix introspection
 problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

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
"rtc-time" property instead. And second, it should have been done in an
unrealize function, not in a finalize function, to avoid that this causes
problems during introspection.

But since adding aliases to the global machine state should not be done
from a device's realize function anyway, let's rather fix this issue
by moving the creation of the alias to the code that creates the device
(and thus is run from the machine init functions instead). We can then
remove the object_property_del() completely. In prep.c, the code for
setting up the alias is added to the function which deals already with
the rtc device for the "40p" machine. The "prep" machine is ignored
here since it is scheduled for removal anyway.

Fixes: 654a36d857ff949e0d1989904b76f53fded9dc83
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/prep.c          |  3 +++
 hw/timer/mc146818rtc.c | 12 +++---------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 3401570..91a8f42 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -696,6 +696,9 @@ static int prep_set_cmos_checksum(DeviceState *dev, void *opaque)
         rtc_set_memory(rtc, 0x3e, checksum & 0xff);
         rtc_set_memory(rtc, 0x2f, checksum >> 8);
         rtc_set_memory(rtc, 0x3f, checksum >> 8);
+
+        object_property_add_alias(qdev_get_machine(), "rtc-time", OBJECT(rtc),
+                                  "date", NULL);
     }
     return 0;
 }
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 3a14075..a504f03 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -995,9 +995,6 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
 
     object_property_add_tm(OBJECT(s), "date", rtc_get_date, NULL);
 
-    object_property_add_alias(qdev_get_machine(), "rtc-time",
-                              OBJECT(s), "date", NULL);
-
     qdev_init_gpio_out(dev, &s->irq, 1);
 }
 
@@ -1019,6 +1016,9 @@ ISADevice *mc146818_rtc_init(ISABus *bus, int base_year, qemu_irq intercept_irq)
     }
     QLIST_INSERT_HEAD(&rtc_devices, s, link);
 
+    object_property_add_alias(qdev_get_machine(), "rtc-time", OBJECT(s),
+                              "date", NULL);
+
     return isadev;
 }
 
@@ -1052,17 +1052,11 @@ static void rtc_class_initfn(ObjectClass *klass, void *data)
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
