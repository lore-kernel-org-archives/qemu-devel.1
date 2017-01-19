Received: from eggs.gnu.org ([2001:4830:134:3::10]:47654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPv-00012p-OF
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPq-0005CF-Df
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:19 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPq-00055o-2f
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:14 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPp-0003Go-7W
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:13 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:55 +0000
Message-Id: <1484834995-26826-37-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 36/36] hw/arm/virt: Add board property to enable
 EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add a board level property to the virt board which will
enable EL2 on the CPU if the user asks for it. The
default is not to provide EL2. If EL2 is enabled then
we will use SMC as our PSCI conduit, and report the
virtualization support in the GICv3 device tree node
and the ACPI tables.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 1483977924-14522-19-git-send-email-peter.maydell@linaro.org
---
 include/hw/arm/virt.h    |  1 +
 hw/arm/virt-acpi-build.c |  3 +++
 hw/arm/virt.c            | 44 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 53507e6..58ce74e 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -93,6 +93,7 @@ typedef struct {
     FWCfgState *fw_cfg;
     bool secure;
     bool highmem;
+    bool virt;
     int32_t gic_version;
     struct arm_boot_info bootinfo;
     const MemMapEntry *memmap;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 73aca9e..d0a8a0f 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -614,6 +614,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
             gicc->performance_interrupt = cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
         }
+        if (vms->virt && vms->gic_version == 3) {
+            gicc->vgic_interrupt = cpu_to_le32(PPI(ARCH_GICV3_MAINT_IRQ));
+        }
     }
 
     if (vms->gic_version == 3) {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 769afa0..6c9e898 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -443,6 +443,11 @@ static void fdt_add_gic_node(VirtMachineState *vms)
                                      2, vms->memmap[VIRT_GIC_DIST].size,
                                      2, vms->memmap[VIRT_GIC_REDIST].base,
                                      2, vms->memmap[VIRT_GIC_REDIST].size);
+        if (vms->virt) {
+            qemu_fdt_setprop_cells(vms->fdt, "/intc", "interrupts",
+                                   GIC_FDT_IRQ_TYPE_PPI, ARCH_GICV3_MAINT_IRQ,
+                                   GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+        }
     } else {
         /* 'cortex-a15-gic' means 'GIC v2' */
         qemu_fdt_setprop_string(vms->fdt, "/intc", "compatible",
@@ -1239,10 +1244,15 @@ static void machvirt_init(MachineState *machine)
      * so it doesn't get in the way. Instead of starting secondary
      * CPUs in PSCI powerdown state we will start them all running and
      * let the boot ROM sort them out.
-     * The usual case is that we do use QEMU's PSCI implementation.
+     * The usual case is that we do use QEMU's PSCI implementation;
+     * if the guest has EL2 then we will use SMC as the conduit,
+     * and otherwise we will use HVC (for backwards compatibility and
+     * because if we're using KVM then we must use HVC).
      */
     if (vms->secure && firmware_loaded) {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
+    } else if (vms->virt) {
+        vms->psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     } else {
         vms->psci_conduit = QEMU_PSCI_CONDUIT_HVC;
     }
@@ -1272,6 +1282,12 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
+    if (vms->virt && kvm_enabled()) {
+        error_report("mach-virt: KVM does not support providing "
+                     "Virtualization extensions to the guest CPU");
+        exit(1);
+    }
+
     if (vms->secure) {
         if (kvm_enabled()) {
             error_report("mach-virt: KVM does not support Security extensions");
@@ -1328,7 +1344,7 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, false, "has_el3", NULL);
         }
 
-        if (object_property_find(cpuobj, "has_el2", NULL)) {
+        if (!vms->virt && object_property_find(cpuobj, "has_el2", NULL)) {
             object_property_set_bool(cpuobj, false, "has_el2", NULL);
         }
 
@@ -1434,6 +1450,20 @@ static void virt_set_secure(Object *obj, bool value, Error **errp)
     vms->secure = value;
 }
 
+static bool virt_get_virt(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->virt;
+}
+
+static void virt_set_virt(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->virt = value;
+}
+
 static bool virt_get_highmem(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -1521,6 +1551,16 @@ static void virt_2_9_instance_init(Object *obj)
                                     "Security Extensions (TrustZone)",
                                     NULL);
 
+    /* EL2 is also disabled by default, for similar reasons */
+    vms->virt = false;
+    object_property_add_bool(obj, "virtualization", virt_get_virt,
+                             virt_set_virt, NULL);
+    object_property_set_description(obj, "virtualization",
+                                    "Set on/off to enable/disable emulating a "
+                                    "guest CPU which implements the ARM "
+                                    "Virtualization Extensions",
+                                    NULL);
+
     /* High memory is enabled by default */
     vms->highmem = true;
     object_property_add_bool(obj, "highmem", virt_get_highmem,
-- 
2.7.4
