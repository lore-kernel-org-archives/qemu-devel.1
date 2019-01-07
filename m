Received: from eggs.gnu.org ([209.51.188.92]:46369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoa-00050c-Mk
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXoY-00024x-BH
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:48 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:38980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXoX-0001zh-Ta
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:31:46 -0500
Received: by mail-wr1-x436.google.com with SMTP id t27so1065564wra.6
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:31:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.31.41 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:31:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:30:58 +0000
Message-Id: <20190107163117.16269-19-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/37] arm/xlnx-zynqmp: put APUs and RPUs in
 separate CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Luc Michel <luc.michel@greensocs.com>

Create two separate CPU clusters for APUs and RPUs.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20181207090135.7651-17-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-zynqmp.h |  3 +++
 hw/arm/xlnx-zynqmp.c         | 23 +++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 98f925ab84a..591515c7600 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -31,6 +31,7 @@
 #include "hw/display/xlnx_dp.h"
 #include "hw/intc/xlnx-zynqmp-ipi.h"
 #include "hw/timer/xlnx-zynqmp-rtc.h"
+#include "hw/cpu/cluster.h"
 
 #define TYPE_XLNX_ZYNQMP "xlnx,zynqmp"
 #define XLNX_ZYNQMP(obj) OBJECT_CHECK(XlnxZynqMPState, (obj), \
@@ -77,6 +78,8 @@ typedef struct XlnxZynqMPState {
     DeviceState parent_obj;
 
     /*< public >*/
+    CPUClusterState apu_cluster;
+    CPUClusterState rpu_cluster;
     ARMCPU apu_cpu[XLNX_ZYNQMP_NUM_APU_CPUS];
     ARMCPU rpu_cpu[XLNX_ZYNQMP_NUM_RPU_CPUS];
     GICState gic;
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index c1950403505..c67ac2e64ac 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -178,12 +178,19 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
     int i;
     int num_rpus = MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQMP_NUM_RPU_CPUS);
 
+    object_initialize_child(OBJECT(s), "rpu-cluster", &s->rpu_cluster,
+                            sizeof(s->rpu_cluster), TYPE_CPU_CLUSTER,
+                            &error_abort, NULL);
+    qdev_prop_set_uint32(DEVICE(&s->rpu_cluster), "cluster-id", 1);
+
+    qdev_init_nofail(DEVICE(&s->rpu_cluster));
+
     for (i = 0; i < num_rpus; i++) {
         char *name;
 
         object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
                           "cortex-r5f-" TYPE_ARM_CPU);
-        object_property_add_child(OBJECT(s), "rpu-cpu[*]",
+        object_property_add_child(OBJECT(&s->rpu_cluster), "rpu-cpu[*]",
                                   OBJECT(&s->rpu_cpu[i]), &error_abort);
 
         name = object_get_canonical_path_component(OBJECT(&s->rpu_cpu[i]));
@@ -213,10 +220,16 @@ static void xlnx_zynqmp_init(Object *obj)
     int i;
     int num_apus = MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
 
+    object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
+                            sizeof(s->apu_cluster), TYPE_CPU_CLUSTER,
+                            &error_abort, NULL);
+    qdev_prop_set_uint32(DEVICE(&s->apu_cluster), "cluster-id", 0);
+
     for (i = 0; i < num_apus; i++) {
-        object_initialize_child(obj, "apu-cpu[*]", &s->apu_cpu[i],
-                                sizeof(s->apu_cpu[i]),
-                                "cortex-a53-" TYPE_ARM_CPU, &error_abort, NULL);
+        object_initialize_child(OBJECT(&s->apu_cluster), "apu-cpu[*]",
+                                &s->apu_cpu[i], sizeof(s->apu_cpu[i]),
+                                "cortex-a53-" TYPE_ARM_CPU, &error_abort,
+                                NULL);
     }
 
     sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
@@ -333,6 +346,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     qdev_prop_set_bit(DEVICE(&s->gic),
                       "has-virtualization-extensions", s->virt);
 
+    qdev_init_nofail(DEVICE(&s->apu_cluster));
+
     /* Realize APUs before realizing the GIC. KVM requires this.  */
     for (i = 0; i < num_apus; i++) {
         char *name;
-- 
2.19.2
