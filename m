Received: from eggs.gnu.org ([2001:4830:134:3::10]:44743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffROI-0006bK-9A
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffROD-0007hY-FC
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:55:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43598 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffROD-0007g5-AL
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:55:45 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 17 Jul 2018 16:55:43 +0200
Message-Id: <1531839343-13828-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/microblaze/xlnx-zynqmp-pmu: Fix
 introspection problem in 'xlnx, zynqmp-pmu-soc'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>

Valgrind complains:

echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
 "'arguments':{'typename':'xlnx,zynqmp-pmu-soc'}}" \
 "{'execute': 'human-monitor-command', " \
 "'arguments': {'command-line': 'info qtree'}}" | \
 valgrind -q microblazeel-softmmu/qemu-system-microblazeel -M none,accel=qtest -qmp stdio
[...]
==13605== Invalid read of size 8
==13605==    at 0x2AC69A: qdev_print (qdev-monitor.c:686)
==13605==    by 0x2AC69A: qbus_print (qdev-monitor.c:719)
==13605==    by 0x2591E8: handle_hmp_command (monitor.c:3446)

Use the new object_initialize_child() and sysbus_init_child_obj() to
fix the issue.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/microblaze/xlnx-zynqmp-pmu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 999a565..57dc1cc 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -62,13 +62,11 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
 {
     XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(obj);
 
-    object_initialize(&s->cpu, sizeof(s->cpu),
-                      TYPE_MICROBLAZE_CPU);
-    object_property_add_child(obj, "pmu-cpu", OBJECT(&s->cpu),
-                              &error_abort);
+    object_initialize_child(obj, "pmu-cpu", &s->cpu, sizeof(s->cpu),
+                            TYPE_MICROBLAZE_CPU, &error_abort, NULL);
 
-    object_initialize(&s->intc, sizeof(s->intc), TYPE_XLNX_PMU_IO_INTC);
-    qdev_set_parent_bus(DEVICE(&s->intc), sysbus_get_default());
+    sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
+                          TYPE_XLNX_PMU_IO_INTC);
 }
 
 static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
-- 
1.8.3.1
