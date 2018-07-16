Received: from eggs.gnu.org ([2001:4830:134:3::10]:43753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36z-0001i1-Fm
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff36t-0002SM-RN
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:00:21 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 16 Jul 2018 14:59:30 +0200
Message-Id: <1531745974-17187-14-git-send-email-thuth@redhat.com>
In-Reply-To: <1531745974-17187-1-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 13/17] hw/*/realview: Fix introspection
 problem with 'realview_mpcore' & 'realview_gic'
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

echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
 "'arguments':{'typename':'realview_mpcore'}}" \
 "{'execute': 'human-monitor-command', " \
 "'arguments': {'command-line': 'info qtree'}}" | \
 valgrind -q aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
[...]
==2654== Invalid read of size 8
==2654==    at 0x61878A: qdev_print (qdev-monitor.c:686)
==2654==    by 0x61878A: qbus_print (qdev-monitor.c:719)
==2654==    by 0x452B38: handle_hmp_command (monitor.c:3446)
==2654==    by 0x452D70: qmp_human_monitor_command (monitor.c:821)
[...]

Use sysbus_init_child_obj() to fix it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/cpu/realview_mpcore.c | 8 ++++----
 hw/intc/realview_gic.c   | 7 ++-----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index 39d4ebe..9d3f837 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -101,14 +101,14 @@ static void mpcore_rirq_init(Object *obj)
     SysBusDevice *privbusdev;
     int i;
 
-    object_initialize(&s->priv, sizeof(s->priv), TYPE_ARM11MPCORE_PRIV);
-    qdev_set_parent_bus(DEVICE(&s->priv), sysbus_get_default());
+    sysbus_init_child_obj(obj, "a11priv", &s->priv, sizeof(s->priv),
+                          TYPE_ARM11MPCORE_PRIV);
     privbusdev = SYS_BUS_DEVICE(&s->priv);
     sysbus_init_mmio(sbd, sysbus_mmio_get_region(privbusdev, 0));
 
     for (i = 0; i < 4; i++) {
-        object_initialize(&s->gic[i], sizeof(s->gic[i]), TYPE_REALVIEW_GIC);
-        qdev_set_parent_bus(DEVICE(&s->gic[i]), sysbus_get_default());
+        sysbus_init_child_obj(obj, "gic[*]", &s->gic[i], sizeof(s->gic[i]),
+                              TYPE_REALVIEW_GIC);
     }
 }
 
diff --git a/hw/intc/realview_gic.c b/hw/intc/realview_gic.c
index 50bbab6..7f2ff85 100644
--- a/hw/intc/realview_gic.c
+++ b/hw/intc/realview_gic.c
@@ -54,16 +54,13 @@ static void realview_gic_init(Object *obj)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     RealViewGICState *s = REALVIEW_GIC(obj);
-    DeviceState *gicdev;
 
     memory_region_init(&s->container, OBJECT(s),
                        "realview-gic-container", 0x2000);
     sysbus_init_mmio(sbd, &s->container);
 
-    object_initialize(&s->gic, sizeof(s->gic), TYPE_ARM_GIC);
-    gicdev = DEVICE(&s->gic);
-    qdev_set_parent_bus(gicdev, sysbus_get_default());
-    qdev_prop_set_uint32(gicdev, "num-cpu", 1);
+    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic), TYPE_ARM_GIC);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", 1);
 }
 
 static void realview_gic_class_init(ObjectClass *oc, void *data)
-- 
1.8.3.1
