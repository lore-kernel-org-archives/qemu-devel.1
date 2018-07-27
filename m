Received: from eggs.gnu.org ([2001:4830:134:3::10]:34365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1fj3sH-0003FB-Ma
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1fj3sG-0008Ih-Nt
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:37:45 -0400
From: Damien Hedde <damien.hedde@greensocs.com>
Date: Fri, 27 Jul 2018 16:37:21 +0200
Message-Id: <2b92ae960dfc47149945c9e47f90b4433d8eee35.1532701430.git.damien.hedde@greensocs.com>
In-Reply-To: <cover.1532701430.git.damien.hedde@greensocs.com>
References: <cover.1532701430.git.damien.hedde@greensocs.com>
Subject: [Qemu-devel] [RFC PATCH 2/6] qdev: add power/clock gating control
 on bus tree
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

Add functions [qdev|qbus]_set_[power|clock]_all(_fn).
Theses allow to control power and clock gating along a bus hierarchy.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 include/hw/qdev-core.h | 20 +++++++++++++++++
 hw/core/qdev.c         | 51 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 659287e185..607c367738 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -464,4 +464,24 @@ void device_set_power(DeviceState *dev, bool en);
  */
 void device_set_clock(DeviceState *dev, bool en);
 
+/**
+ * qdev/qbus_set_power_all(_fn)
+ * Enable/Disable the power of a tree starting
+ * at given device or bus
+ */
+void qdev_set_power_all(DeviceState *dev, bool en);
+void qdev_set_power_all_fn(void *opaque, bool en);
+void qbus_set_power_all(BusState *bus, bool en);
+void qbus_set_power_all_fn(void *opaque, bool en);
+
+/**
+ * qdev/qbus_set_clock_all(_fn)
+ * Enable/Disable the clock of a tree starting
+ * at given device or bus
+ */
+void qdev_set_clock_all(DeviceState *dev, bool en);
+void qdev_set_clock_all_fn(void *opaque, bool en);
+void qbus_set_clock_all(BusState *bus, bool en);
+void qbus_set_clock_all_fn(void *opaque, bool en);
+
 #endif
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index bb6d36eab9..24b90bd45f 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1138,6 +1138,57 @@ void device_set_clock(DeviceState *dev, bool en)
     }
 }
 
+static int qdev_set_power_one(DeviceState *dev, void *opaque)
+{
+    device_set_power(dev, *((bool *)opaque));
+    return 0;
+}
+
+void qdev_set_power_all(DeviceState *dev, bool en)
+{
+    qdev_walk_children(dev, NULL, NULL, qdev_set_power_one, NULL, &en);
+}
+
+void qdev_set_power_all_fn(void *opaque, bool en)
+{
+    qdev_set_power_all(DEVICE(opaque), en);
+}
+
+void qbus_set_power_all(BusState *bus, bool en)
+{
+    qbus_walk_children(bus, NULL, NULL, qdev_set_power_one, NULL, &en);
+}
+
+void qbus_set_power_all_fn(void *opaque, bool en)
+{
+    qbus_set_power_all(BUS(opaque), en);
+}
+
+static int qdev_set_clock_one(DeviceState *dev, void *opaque)
+{
+    device_set_clock(dev, *((bool *)opaque));
+    return 0;
+}
+
+void qdev_set_clock_all(DeviceState *dev, bool en)
+{
+    qdev_walk_children(dev, NULL, NULL, qdev_set_clock_one, NULL, &en);
+}
+
+void qdev_set_clock_all_fn(void *opaque, bool en)
+{
+    qdev_set_clock_all(DEVICE(opaque), en);
+}
+
+void qbus_set_clock_all(BusState *bus, bool en)
+{
+    qbus_walk_children(bus, NULL, NULL, qdev_set_clock_one, NULL, &en);
+}
+
+void qbus_set_clock_all_fn(void *opaque, bool en)
+{
+    qbus_set_clock_all(BUS(opaque), en);
+}
 
 Object *qdev_get_machine(void)
 {
-- 
2.18.0
