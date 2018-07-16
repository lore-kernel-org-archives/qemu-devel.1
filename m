Received: from eggs.gnu.org ([2001:4830:134:3::10]:43344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36Q-000167-Mk
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 08:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36P-00023J-NW
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 08:59:46 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 16 Jul 2018 14:59:20 +0200
Message-Id: <1531745974-17187-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1531745974-17187-1-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/17] hw/arm/bcm2836: Fix crash with
 device_add bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

When trying to "device_add bcm2837" on a machine that is not suitable for
this device, you can quickly crash QEMU afterwards, e.g. with "info qtree":

echo "{'execute':'qmp_capabilities'} {'execute':'device_add', " \
 "'arguments':{'driver':'bcm2837'}} {'execute': 'human-monitor-command', " \
 "'arguments': {'command-line': 'info qtree'}}" | \
 aarch64-softmmu/qemu-system-aarch64 -M integratorcp,accel=qtest -S -qmp stdio

{"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": 2},
 "package": "build-all"}, "capabilities": []}}
{"return": {}}
{"error": {"class": "GenericError", "desc": "Device 'bcm2837' can not be
 hotplugged on this machine"}}
Segmentation fault (core dumped)

The qdev_set_parent_bus() from instance_init adds a link to the child devices
which is not valid anymore after the bcm2837 instance has been destroyed.
Unfortunately, the child devices do not get destroyed / unlinked correctly
because both object_initialize() and object_property_add_child() increase
the reference count of the child objects by one, but only one reference
is dropped when the parent gets removed. So let's use the new functions
object_initialize_child() and sysbus_init_child_obj() instead to create
the objects, which will take care of creating the child objects with the
correct reference count of one.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/bcm2836.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 6805a7d..2595d93 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -51,25 +51,19 @@ static void bcm2836_init(Object *obj)
     int n;
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
-        object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
-                          info->cpu_type);
-        object_property_add_child(obj, "cpu[*]", OBJECT(&s->cpus[n]),
-                                  &error_abort);
+        object_initialize_child(obj, "cpu[*]", &s->cpus[n], sizeof(s->cpus[n]),
+                                info->cpu_type, &error_abort, NULL);
     }
 
-    object_initialize(&s->control, sizeof(s->control), TYPE_BCM2836_CONTROL);
-    object_property_add_child(obj, "control", OBJECT(&s->control), NULL);
-    qdev_set_parent_bus(DEVICE(&s->control), sysbus_get_default());
+    sysbus_init_child_obj(obj, "control", &s->control, sizeof(s->control),
+                          TYPE_BCM2836_CONTROL);
 
-    object_initialize(&s->peripherals, sizeof(s->peripherals),
-                      TYPE_BCM2835_PERIPHERALS);
-    object_property_add_child(obj, "peripherals", OBJECT(&s->peripherals),
-                              &error_abort);
+    sysbus_init_child_obj(obj, "peripherals", &s->peripherals,
+                          sizeof(s->peripherals), TYPE_BCM2835_PERIPHERALS);
     object_property_add_alias(obj, "board-rev", OBJECT(&s->peripherals),
                               "board-rev", &error_abort);
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
                               "vcram-size", &error_abort);
-    qdev_set_parent_bus(DEVICE(&s->peripherals), sysbus_get_default());
 }
 
 static void bcm2836_realize(DeviceState *dev, Error **errp)
-- 
1.8.3.1
