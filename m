Received: from eggs.gnu.org ([2001:4830:134:3::10]:43765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhc2B-0007Xn-H5
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhc2A-00084D-MA
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:41:59 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fhc2A-00081L-EG
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:41:58 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fhc26-0007ha-7Q
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 15:41:54 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 15:41:48 +0100
Message-Id: <20180723144152.13885-2-peter.maydell@linaro.org>
In-Reply-To: <20180723144152.13885-1-peter.maydell@linaro.org>
References: <20180723144152.13885-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 1/5] hw/microblaze/xlnx-zynqmp-pmu: Fix
 introspection problem in 'xlnx, zynqmp-pmu-soc'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 1531839343-13828-1-git-send-email-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/microblaze/xlnx-zynqmp-pmu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 999a5657cff..57dc1ccd429 100644
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
2.17.1
