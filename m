Received: from eggs.gnu.org ([2001:4830:134:3::10]:34372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1fj3sH-0003FE-SQ
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1fj3sG-0008Ib-IY
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:37:45 -0400
From: Damien Hedde <damien.hedde@greensocs.com>
Date: Fri, 27 Jul 2018 16:37:20 +0200
Message-Id: <0379e54aecc5534d68e1ac3bdf61fda79916396e.1532701430.git.damien.hedde@greensocs.com>
In-Reply-To: <cover.1532701430.git.damien.hedde@greensocs.com>
References: <cover.1532701430.git.damien.hedde@greensocs.com>
Subject: [Qemu-devel] [RFC PATCH 1/6] qdev: add a power and clock gating
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org, edgar.iglesias@xilinx.com, mark.burton@greensocs.com, saipava@xilinx.com, luc.michel@greensocs.com, alistair@alistair23.me, Damien Hedde <damien.hedde@greensocs.com>

Add two boolean new fields _powered_ and _clocked_ to hold the gating
state. Also add methods to act on each gating change.
The power/clock gating is controlled by 2 functions *device_set_power* and
*device_set_clock*.

Add a default behavior to do a device_reset at power-up.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 include/hw/qdev-core.h | 30 ++++++++++++++++++++++++
 hw/core/qdev.c         | 52 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index f1fd0f8736..659287e185 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -34,6 +34,7 @@ typedef void (*DeviceUnrealize)(DeviceState *dev, Error **errp);
 typedef void (*DeviceReset)(DeviceState *dev);
 typedef void (*BusRealize)(BusState *bus, Error **errp);
 typedef void (*BusUnrealize)(BusState *bus, Error **errp);
+typedef void (*DeviceGatingUpdate)(DeviceState *dev);
 
 struct VMStateDescription;
 
@@ -109,6 +110,8 @@ typedef struct DeviceClass {
     DeviceReset reset;
     DeviceRealize realize;
     DeviceUnrealize unrealize;
+    DeviceGatingUpdate power_update;
+    DeviceGatingUpdate clock_update;
 
     /* device state */
     const struct VMStateDescription *vmsd;
@@ -151,6 +154,9 @@ struct DeviceState {
     int num_child_bus;
     int instance_id_alias;
     int alias_required_for_version;
+
+    bool powered;
+    bool clocked;
 };
 
 struct DeviceListener {
@@ -404,6 +410,12 @@ void device_class_set_parent_realize(DeviceClass *dc,
 void device_class_set_parent_unrealize(DeviceClass *dc,
                                        DeviceUnrealize dev_unrealize,
                                        DeviceUnrealize *parent_unrealize);
+void device_class_set_parent_power_update(DeviceClass *dc,
+                                          DeviceGatingUpdate dev_power_update,
+                                          DeviceGatingUpdate *parent_power_update);
+void device_class_set_parent_clock_update(DeviceClass *dc,
+                                          DeviceGatingUpdate dev_clock_update,
+                                          DeviceGatingUpdate *parent_clock_update);
 
 const struct VMStateDescription *qdev_get_vmsd(DeviceState *dev);
 
@@ -434,4 +446,22 @@ static inline bool qbus_is_hotpluggable(BusState *bus)
 void device_listener_register(DeviceListener *listener);
 void device_listener_unregister(DeviceListener *listener);
 
+/**
+ * device_set_power:
+ * Enable/Disable the power of a device
+ *
+ * @dev: device to update
+ * @en: true to enable, false to disable
+ */
+void device_set_power(DeviceState *dev, bool en);
+
+/**
+ * device_set_clock:
+ * Enable/Disable the clock of a device
+ *
+ * @dev: device to update
+ * @en: true to enable, false to disable
+ */
+void device_set_clock(DeviceState *dev, bool en);
+
 #endif
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 529b82de18..bb6d36eab9 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -950,6 +950,8 @@ static void device_initfn(Object *obj)
 
     dev->instance_id_alias = -1;
     dev->realized = false;
+    dev->powered = true;
+    dev->clocked = true;
 
     object_property_add_bool(obj, "realized",
                              device_get_realized, device_set_realized, NULL);
@@ -1038,6 +1040,13 @@ static void device_unparent(Object *obj)
     }
 }
 
+static void device_power_update(DeviceState *dev)
+{
+    if (dev->powered) {
+        device_reset(dev);
+    }
+}
+
 static void device_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
@@ -1052,6 +1061,8 @@ static void device_class_init(ObjectClass *class, void *data)
      */
     dc->hotpluggable = true;
     dc->user_creatable = true;
+
+    dc->power_update = device_power_update;
 }
 
 void device_class_set_parent_reset(DeviceClass *dc,
@@ -1078,6 +1089,22 @@ void device_class_set_parent_unrealize(DeviceClass *dc,
     dc->unrealize = dev_unrealize;
 }
 
+void device_class_set_parent_power_update(DeviceClass *dc,
+                                       DeviceGatingUpdate dev_power_update,
+                                       DeviceGatingUpdate *parent_power_update)
+{
+    *parent_power_update = dc->power_update;
+    dc->power_update = dev_power_update;
+}
+
+void device_class_set_parent_clock_update(DeviceClass *dc,
+                                       DeviceGatingUpdate dev_clock_update,
+                                       DeviceGatingUpdate *parent_clock_update)
+{
+    *parent_clock_update = dc->clock_update;
+    dc->clock_update = dev_clock_update;
+}
+
 void device_reset(DeviceState *dev)
 {
     DeviceClass *klass = DEVICE_GET_CLASS(dev);
@@ -1087,6 +1114,31 @@ void device_reset(DeviceState *dev)
     }
 }
 
+void device_set_power(DeviceState *dev, bool en)
+{
+    DeviceClass *klass = DEVICE_GET_CLASS(dev);
+
+    if (en != dev->powered) {
+        dev->powered = en;
+        if (klass->power_update) {
+            klass->power_update(dev);
+        }
+    }
+}
+
+void device_set_clock(DeviceState *dev, bool en)
+{
+    DeviceClass *klass = DEVICE_GET_CLASS(dev);
+
+    if (en != dev->clocked) {
+        dev->clocked = en;
+        if (klass->clock_update) {
+            klass->clock_update(dev);
+        }
+    }
+}
+
+
 Object *qdev_get_machine(void)
 {
     static Object *dev;
-- 
2.18.0
