Received: from eggs.gnu.org ([2001:4830:134:3::10]:35638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JZ-00068K-5B
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fw5JY-0007yN-73
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 08:47:45 -0400
From: Luc Michel <luc.michel@greensocs.com>
Date: Sat,  1 Sep 2018 14:46:39 +0200
Message-Id: <20180901124639.19735-16-luc.michel@greensocs.com>
In-Reply-To: <20180901124639.19735-1-luc.michel@greensocs.com>
References: <20180901124639.19735-1-luc.michel@greensocs.com>
Subject: [Qemu-devel] [PATCH 15/15] arm/xlnx-zynqmp: put APUs and RPUs in
 separate GDB groups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, saipava@xilinx.com, edgari@xilinx.com, alistair@alistair23.me, mark.burton@greensocs.com

Create two separate QOM containers for APUs and RPUs to indicate to the
GDB stub that those CPUs should be put in different processes.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
 hw/arm/xlnx-zynqmp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index c195040350..5e92adbc71 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -22,10 +22,11 @@
 #include "hw/arm/xlnx-zynqmp.h"
 #include "hw/intc/arm_gic_common.h"
 #include "exec/address-spaces.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
+#include "exec/gdbstub.h"
 
 #define GIC_NUM_SPI_INTR 160
 
 #define ARM_PHYS_TIMER_PPI  30
 #define ARM_VIRT_TIMER_PPI  27
@@ -175,17 +176,18 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
                                    Error **errp)
 {
     Error *err = NULL;
     int i;
     int num_rpus = MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQMP_NUM_RPU_CPUS);
+    Object *rpu_group = gdb_cpu_group_container_get(OBJECT(s));
 
     for (i = 0; i < num_rpus; i++) {
         char *name;
 
         object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
                           "cortex-r5f-" TYPE_ARM_CPU);
-        object_property_add_child(OBJECT(s), "rpu-cpu[*]",
+        object_property_add_child(rpu_group, "rpu-cpu[*]",
                                   OBJECT(&s->rpu_cpu[i]), &error_abort);
 
         name = object_get_canonical_path_component(OBJECT(&s->rpu_cpu[i]));
         if (strcmp(name, boot_cpu)) {
             /* Secondary CPUs start in PSCI powered-down state */
@@ -210,13 +212,14 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
 static void xlnx_zynqmp_init(Object *obj)
 {
     XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
     int i;
     int num_apus = MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    Object *apu_group = gdb_cpu_group_container_get(obj);
 
     for (i = 0; i < num_apus; i++) {
-        object_initialize_child(obj, "apu-cpu[*]", &s->apu_cpu[i],
+        object_initialize_child(apu_group, "apu-cpu[*]", &s->apu_cpu[i],
                                 sizeof(s->apu_cpu[i]),
                                 "cortex-a53-" TYPE_ARM_CPU, &error_abort, NULL);
     }
 
     sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
-- 
2.18.0
