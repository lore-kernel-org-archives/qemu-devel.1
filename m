Received: from eggs.gnu.org ([2001:4830:134:3::10]:47369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSJ-000485-6m
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFSE-0007ge-P7
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:19 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eEFSE-0007Yd-I0
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:11:14 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eEFS6-00023s-40
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 14:11:06 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 14:11:40 +0000
Message-Id: <1510582304-27058-6-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
References: <1510582304-27058-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 5/9] xlnx-zynqmp: Properly support the smp
 command line option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

Allow the -smp command line option to control the number of CPUs we
create.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Tested-by: Emilio G. Cota <cota@braap.org>
Message-id: 1510343626-25861-3-git-send-email-cota@braap.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-zcu102.c |  3 ++-
 hw/arm/xlnx-zynqmp.c | 26 ++++++++++++++++----------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index e2d15a1..7ec03da 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -235,7 +235,8 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "Xilinx ZynqMP ZCU102 board";
+    mc->desc = "Xilinx ZynqMP ZCU102 board with 4xA53s and 2xR5s based on " \
+               "the value of smp";
     mc->init = xlnx_zcu102_init;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index d4b6560..c707c66 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -98,8 +98,9 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
 {
     Error *err = NULL;
     int i;
+    int num_rpus = MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQMP_NUM_RPU_CPUS);
 
-    for (i = 0; i < XLNX_ZYNQMP_NUM_RPU_CPUS; i++) {
+    for (i = 0; i < num_rpus; i++) {
         char *name;
 
         object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
@@ -132,8 +133,9 @@ static void xlnx_zynqmp_init(Object *obj)
 {
     XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
     int i;
+    int num_apus = MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
 
-    for (i = 0; i < XLNX_ZYNQMP_NUM_APU_CPUS; i++) {
+    for (i = 0; i < num_apus; i++) {
         object_initialize(&s->apu_cpu[i], sizeof(s->apu_cpu[i]),
                           "cortex-a53-" TYPE_ARM_CPU);
         object_property_add_child(obj, "apu-cpu[*]", OBJECT(&s->apu_cpu[i]),
@@ -182,6 +184,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     MemoryRegion *system_memory = get_system_memory();
     uint8_t i;
     uint64_t ram_size;
+    int num_apus = MIN(smp_cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
     const char *boot_cpu = s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
     ram_addr_t ddr_low_size, ddr_high_size;
     qemu_irq gic_spi[GIC_NUM_SPI_INTR];
@@ -233,10 +236,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", GIC_NUM_SPI_INTR + 32);
     qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
-    qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", XLNX_ZYNQMP_NUM_APU_CPUS);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", num_apus);
 
     /* Realize APUs before realizing the GIC. KVM requires this.  */
-    for (i = 0; i < XLNX_ZYNQMP_NUM_APU_CPUS; i++) {
+    for (i = 0; i < num_apus; i++) {
         char *name;
 
         object_property_set_int(OBJECT(&s->apu_cpu[i]), QEMU_PSCI_CONDUIT_SMC,
@@ -292,7 +295,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    for (i = 0; i < XLNX_ZYNQMP_NUM_APU_CPUS; i++) {
+    for (i = 0; i < num_apus; i++) {
         qemu_irq irq;
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i,
@@ -307,11 +310,14 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
 
     if (s->has_rpu) {
-        xlnx_zynqmp_create_rpu(s, boot_cpu, &err);
-        if (err) {
-            error_propagate(errp, err);
-            return;
-        }
+        info_report("The 'has_rpu' property is no longer required, to use the "
+                    "RPUs just use -smp 6.");
+    }
+
+    xlnx_zynqmp_create_rpu(s, boot_cpu, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
     }
 
     if (!s->boot_cpu_ptr) {
-- 
2.7.4
