Received: from eggs.gnu.org ([2001:4830:134:3::10]:58001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fcdJT-0005p1-Sl
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:03:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fcdJS-0003kr-M6
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 17:03:15 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  9 Jul 2018 23:03:00 +0200
Message-Id: <1531170180-21199-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/arm/bcm283x: Fix crash with device_add
 bcm2837 on unsupported machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

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

The problem is that qdev_set_parent_bus() from instance_init adds a link
to the child devices which is not valid anymore after the device init
failed. Thus the qdev_set_parent_bus() must rather be done in the realize
function instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/bcm2835_peripherals.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 6be7660..4724a29 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -43,22 +43,18 @@ static void bcm2835_peripherals_init(Object *obj)
     /* Interrupt Controller */
     object_initialize(&s->ic, sizeof(s->ic), TYPE_BCM2835_IC);
     object_property_add_child(obj, "ic", OBJECT(&s->ic), NULL);
-    qdev_set_parent_bus(DEVICE(&s->ic), sysbus_get_default());
 
     /* UART0 */
     s->uart0 = SYS_BUS_DEVICE(object_new("pl011"));
     object_property_add_child(obj, "uart0", OBJECT(s->uart0), NULL);
-    qdev_set_parent_bus(DEVICE(s->uart0), sysbus_get_default());
 
     /* AUX / UART1 */
     object_initialize(&s->aux, sizeof(s->aux), TYPE_BCM2835_AUX);
     object_property_add_child(obj, "aux", OBJECT(&s->aux), NULL);
-    qdev_set_parent_bus(DEVICE(&s->aux), sysbus_get_default());
 
     /* Mailboxes */
     object_initialize(&s->mboxes, sizeof(s->mboxes), TYPE_BCM2835_MBOX);
     object_property_add_child(obj, "mbox", OBJECT(&s->mboxes), NULL);
-    qdev_set_parent_bus(DEVICE(&s->mboxes), sysbus_get_default());
 
     object_property_add_const_link(OBJECT(&s->mboxes), "mbox-mr",
                                    OBJECT(&s->mbox_mr), &error_abort);
@@ -68,7 +64,6 @@ static void bcm2835_peripherals_init(Object *obj)
     object_property_add_child(obj, "fb", OBJECT(&s->fb), NULL);
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->fb), "vcram-size",
                               &error_abort);
-    qdev_set_parent_bus(DEVICE(&s->fb), sysbus_get_default());
 
     object_property_add_const_link(OBJECT(&s->fb), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr), &error_abort);
@@ -78,7 +73,6 @@ static void bcm2835_peripherals_init(Object *obj)
     object_property_add_child(obj, "property", OBJECT(&s->property), NULL);
     object_property_add_alias(obj, "board-rev", OBJECT(&s->property),
                               "board-rev", &error_abort);
-    qdev_set_parent_bus(DEVICE(&s->property), sysbus_get_default());
 
     object_property_add_const_link(OBJECT(&s->property), "fb",
                                    OBJECT(&s->fb), &error_abort);
@@ -88,22 +82,18 @@ static void bcm2835_peripherals_init(Object *obj)
     /* Random Number Generator */
     object_initialize(&s->rng, sizeof(s->rng), TYPE_BCM2835_RNG);
     object_property_add_child(obj, "rng", OBJECT(&s->rng), NULL);
-    qdev_set_parent_bus(DEVICE(&s->rng), sysbus_get_default());
 
     /* Extended Mass Media Controller */
     object_initialize(&s->sdhci, sizeof(s->sdhci), TYPE_SYSBUS_SDHCI);
     object_property_add_child(obj, "sdhci", OBJECT(&s->sdhci), NULL);
-    qdev_set_parent_bus(DEVICE(&s->sdhci), sysbus_get_default());
 
     /* SDHOST */
     object_initialize(&s->sdhost, sizeof(s->sdhost), TYPE_BCM2835_SDHOST);
     object_property_add_child(obj, "sdhost", OBJECT(&s->sdhost), NULL);
-    qdev_set_parent_bus(DEVICE(&s->sdhost), sysbus_get_default());
 
     /* DMA Channels */
     object_initialize(&s->dma, sizeof(s->dma), TYPE_BCM2835_DMA);
     object_property_add_child(obj, "dma", OBJECT(&s->dma), NULL);
-    qdev_set_parent_bus(DEVICE(&s->dma), sysbus_get_default());
 
     object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr), &error_abort);
@@ -111,7 +101,6 @@ static void bcm2835_peripherals_init(Object *obj)
     /* GPIO */
     object_initialize(&s->gpio, sizeof(s->gpio), TYPE_BCM2835_GPIO);
     object_property_add_child(obj, "gpio", OBJECT(&s->gpio), NULL);
-    qdev_set_parent_bus(DEVICE(&s->gpio), sysbus_get_default());
 
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
                                    OBJECT(&s->sdhci.sdbus), &error_abort);
@@ -126,8 +115,22 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     MemoryRegion *ram;
     Error *err = NULL;
     uint64_t ram_size, vcram_size;
+    BusState *sysbus;
     int n;
 
+    sysbus = sysbus_get_default();
+    qdev_set_parent_bus(DEVICE(&s->ic), sysbus);
+    qdev_set_parent_bus(DEVICE(s->uart0), sysbus);
+    qdev_set_parent_bus(DEVICE(&s->aux), sysbus);
+    qdev_set_parent_bus(DEVICE(&s->mboxes), sysbus);
+    qdev_set_parent_bus(DEVICE(&s->fb), sysbus);
+    qdev_set_parent_bus(DEVICE(&s->property), sysbus);
+    qdev_set_parent_bus(DEVICE(&s->rng), sysbus);
+    qdev_set_parent_bus(DEVICE(&s->sdhci), sysbus);
+    qdev_set_parent_bus(DEVICE(&s->sdhost), sysbus);
+    qdev_set_parent_bus(DEVICE(&s->dma), sysbus);
+    qdev_set_parent_bus(DEVICE(&s->gpio), sysbus);
+
     obj = object_property_get_link(OBJECT(dev), "ram", &err);
     if (obj == NULL) {
         error_setg(errp, "%s: required ram link not found: %s",
-- 
1.8.3.1
