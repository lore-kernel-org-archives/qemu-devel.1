Received: from eggs.gnu.org ([2001:4830:134:3::10]:40323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQcS8-0007w3-Uh
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cQcS3-0003kK-6J
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:05:44 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Jan 2017 16:05:24 +0000
Message-Id: <1483977924-14522-19-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
References: <1483977924-14522-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 18/18] hw/arm/virt: Add board property to
 enable EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>

Add a board level property to the virt board which will
enable EL2 on the CPU if the user asks for it. The
default is not to provide EL2. If EL2 is enabled then
we will use SMC as our PSCI conduit, and report the
virtualization support in the GICv3 device tree node
and the ACPI tables.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>
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
index ec7f83b..32b660d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -607,6 +607,9 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
             gicc->performance_interrupt = cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
         }
+        if (vms->virt && vms->gic_version == 3) {
+            gicc->vgic_interrupt = cpu_to_le32(PPI(ARCH_GICV3_MAINT_IRQ));
+        }
     }
 
     if (vms->gic_version == 3) {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 46f19cd..709da40 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -444,6 +444,11 @@ static void fdt_add_gic_node(VirtMachineState *vms)
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
@@ -1240,10 +1245,15 @@ static void machvirt_init(MachineState *machine)
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
@@ -1273,6 +1283,12 @@ static void machvirt_init(MachineState *machine)
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
@@ -1329,7 +1345,7 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, false, "has_el3", NULL);
         }
 
-        if (object_property_find(cpuobj, "has_el2", NULL)) {
+        if (!vms->virt && object_property_find(cpuobj, "has_el2", NULL)) {
             object_property_set_bool(cpuobj, false, "has_el2", NULL);
         }
 
@@ -1435,6 +1451,20 @@ static void virt_set_secure(Object *obj, bool value, Error **errp)
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
@@ -1522,6 +1552,16 @@ static void virt_2_9_instance_init(Object *obj)
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
