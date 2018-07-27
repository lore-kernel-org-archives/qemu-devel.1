Received: from eggs.gnu.org ([2001:4830:134:3::10]:34360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1fj3sH-0003F8-GU
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1fj3sG-0008IN-EZ
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:37:45 -0400
From: Damien Hedde <damien.hedde@greensocs.com>
Date: Fri, 27 Jul 2018 16:37:22 +0200
Message-Id: <09041c553fbe1d78bf282513bffdb981e7a1d201.1532701430.git.damien.hedde@greensocs.com>
In-Reply-To: <cover.1532701430.git.damien.hedde@greensocs.com>
References: <cover.1532701430.git.damien.hedde@greensocs.com>
Subject: [Qemu-devel] [RFC PATCH 3/6] sysbus: Specialize gating_update to
 enable/disable memory regions
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

The default methods are overriden to add the activation/deactivation
of the memory regions according to the gating state: Regions are
enabled only when powered and clocked.
As powering-up triggers a reset call, memory regions should
be reset in specialized sysbus devices.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 include/hw/sysbus.h |  3 +++
 hw/core/sysbus.c    | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 0b59a3b8d6..e17165e78f 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -59,6 +59,9 @@ typedef struct SysBusDeviceClass {
      */
     char *(*explicit_ofw_unit_address)(const SysBusDevice *dev);
     void (*connect_irq_notifier)(SysBusDevice *dev, qemu_irq irq);
+
+    DeviceGatingUpdate parent_power_update;
+    DeviceGatingUpdate parent_clock_update;
 } SysBusDeviceClass;
 
 struct SysBusDevice {
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 3c8e53b188..4a2dfbe907 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -325,6 +325,39 @@ MemoryRegion *sysbus_address_space(SysBusDevice *dev)
     return get_system_memory();
 }
 
+/*
+ * Action take on power or clock update.
+ */
+static void sysbus_device_gating_update(DeviceState *dev)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    int i;
+
+    for (i = 0;; i++) {
+        MemoryRegion *mr = sysbus_mmio_get_region(sbd, i);
+        if (!mr) {
+            break;
+        }
+        memory_region_set_enabled(mr, dev->powered && dev->clocked);
+    }
+}
+
+/*
+ * Action take on power update.
+ *
+ * Call parent method before doing local action.
+ * So that we override any action taken in parent method (eg if reset
+ * is called due to leaving OFF state)
+ */
+static void sysbus_device_power_update(DeviceState *dev)
+{
+    SysBusDeviceClass *sbdk = SYS_BUS_DEVICE_GET_CLASS(dev);
+
+    sbdk->parent_power_update(dev);
+
+    sysbus_device_gating_update(dev);
+}
+
 static void sysbus_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
@@ -341,6 +374,12 @@ static void sysbus_device_class_init(ObjectClass *klass, void *data)
      * subclass needs to override it and set user_creatable=true.
      */
     k->user_creatable = false;
+
+    SysBusDeviceClass *sbdk = SYS_BUS_DEVICE_CLASS(klass);
+    device_class_set_parent_power_update(k,
+            sysbus_device_power_update, &sbdk->parent_power_update);
+    device_class_set_parent_clock_update(k,
+            sysbus_device_gating_update, &sbdk->parent_clock_update);
 }
 
 static const TypeInfo sysbus_device_type_info = {
-- 
2.18.0
