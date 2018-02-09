Received: from eggs.gnu.org ([2001:4830:134:3::10]:39963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sx-00017x-3L
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sq-0001zz-S9
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:39 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ek6Sq-0001zI-I9
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 06:03:32 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ek6Sp-0002d8-HA
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 11:03:31 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  9 Feb 2018 11:03:06 +0000
Message-Id: <20180209110314.11766-23-peter.maydell@linaro.org>
In-Reply-To: <20180209110314.11766-1-peter.maydell@linaro.org>
References: <20180209110314.11766-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/30] hw/arm: Move virt's PSCI DT fixup code to
 arm/boot.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Move virt's PSCI DT fixup code to arm/boot.c and set this fixup to
happen automatically for every board that doesn't mark "psci-conduit"
as disabled. This way emulated boards other than "virt" that rely on
PSIC for SMP could benefit from that code.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Cc: Marcel Apfelbaum <marcel.apfelbaum@zoho.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: yurovsky@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/virt.c | 61 -------------------------------------------------------
 2 files changed, 65 insertions(+), 61 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index bb244ec359..9b174b982c 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -385,6 +385,69 @@ static void set_kernel_args_old(const struct arm_boot_info *info)
     }
 }
 
+static void fdt_add_psci_node(void *fdt)
+{
+    uint32_t cpu_suspend_fn;
+    uint32_t cpu_off_fn;
+    uint32_t cpu_on_fn;
+    uint32_t migrate_fn;
+    ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0));
+    const char *psci_method;
+    int64_t psci_conduit;
+
+    psci_conduit = object_property_get_int(OBJECT(armcpu),
+                                           "psci-conduit",
+                                           &error_abort);
+    switch (psci_conduit) {
+    case QEMU_PSCI_CONDUIT_DISABLED:
+        return;
+    case QEMU_PSCI_CONDUIT_HVC:
+        psci_method = "hvc";
+        break;
+    case QEMU_PSCI_CONDUIT_SMC:
+        psci_method = "smc";
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    qemu_fdt_add_subnode(fdt, "/psci");
+    if (armcpu->psci_version == 2) {
+        const char comp[] = "arm,psci-0.2\0arm,psci";
+        qemu_fdt_setprop(fdt, "/psci", "compatible", comp, sizeof(comp));
+
+        cpu_off_fn = QEMU_PSCI_0_2_FN_CPU_OFF;
+        if (arm_feature(&armcpu->env, ARM_FEATURE_AARCH64)) {
+            cpu_suspend_fn = QEMU_PSCI_0_2_FN64_CPU_SUSPEND;
+            cpu_on_fn = QEMU_PSCI_0_2_FN64_CPU_ON;
+            migrate_fn = QEMU_PSCI_0_2_FN64_MIGRATE;
+        } else {
+            cpu_suspend_fn = QEMU_PSCI_0_2_FN_CPU_SUSPEND;
+            cpu_on_fn = QEMU_PSCI_0_2_FN_CPU_ON;
+            migrate_fn = QEMU_PSCI_0_2_FN_MIGRATE;
+        }
+    } else {
+        qemu_fdt_setprop_string(fdt, "/psci", "compatible", "arm,psci");
+
+        cpu_suspend_fn = QEMU_PSCI_0_1_FN_CPU_SUSPEND;
+        cpu_off_fn = QEMU_PSCI_0_1_FN_CPU_OFF;
+        cpu_on_fn = QEMU_PSCI_0_1_FN_CPU_ON;
+        migrate_fn = QEMU_PSCI_0_1_FN_MIGRATE;
+    }
+
+    /* We adopt the PSCI spec's nomenclature, and use 'conduit' to refer
+     * to the instruction that should be used to invoke PSCI functions.
+     * However, the device tree binding uses 'method' instead, so that is
+     * what we should use here.
+     */
+    qemu_fdt_setprop_string(fdt, "/psci", "method", psci_method);
+
+    qemu_fdt_setprop_cell(fdt, "/psci", "cpu_suspend", cpu_suspend_fn);
+    qemu_fdt_setprop_cell(fdt, "/psci", "cpu_off", cpu_off_fn);
+    qemu_fdt_setprop_cell(fdt, "/psci", "cpu_on", cpu_on_fn);
+    qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
+}
+
 /**
  * load_dtb() - load a device tree binary image into memory
  * @addr:       the address to load the image at
@@ -541,6 +604,8 @@ static int load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         }
     }
 
+    fdt_add_psci_node(fdt);
+
     if (binfo->modify_dtb) {
         binfo->modify_dtb(binfo, fdt);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b334c82eda..dbb3c8036a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -244,66 +244,6 @@ static void create_fdt(VirtMachineState *vms)
     }
 }
 
-static void fdt_add_psci_node(const VirtMachineState *vms)
-{
-    uint32_t cpu_suspend_fn;
-    uint32_t cpu_off_fn;
-    uint32_t cpu_on_fn;
-    uint32_t migrate_fn;
-    void *fdt = vms->fdt;
-    ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0));
-    const char *psci_method;
-
-    switch (vms->psci_conduit) {
-    case QEMU_PSCI_CONDUIT_DISABLED:
-        return;
-    case QEMU_PSCI_CONDUIT_HVC:
-        psci_method = "hvc";
-        break;
-    case QEMU_PSCI_CONDUIT_SMC:
-        psci_method = "smc";
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    qemu_fdt_add_subnode(fdt, "/psci");
-    if (armcpu->psci_version == 2) {
-        const char comp[] = "arm,psci-0.2\0arm,psci";
-        qemu_fdt_setprop(fdt, "/psci", "compatible", comp, sizeof(comp));
-
-        cpu_off_fn = QEMU_PSCI_0_2_FN_CPU_OFF;
-        if (arm_feature(&armcpu->env, ARM_FEATURE_AARCH64)) {
-            cpu_suspend_fn = QEMU_PSCI_0_2_FN64_CPU_SUSPEND;
-            cpu_on_fn = QEMU_PSCI_0_2_FN64_CPU_ON;
-            migrate_fn = QEMU_PSCI_0_2_FN64_MIGRATE;
-        } else {
-            cpu_suspend_fn = QEMU_PSCI_0_2_FN_CPU_SUSPEND;
-            cpu_on_fn = QEMU_PSCI_0_2_FN_CPU_ON;
-            migrate_fn = QEMU_PSCI_0_2_FN_MIGRATE;
-        }
-    } else {
-        qemu_fdt_setprop_string(fdt, "/psci", "compatible", "arm,psci");
-
-        cpu_suspend_fn = QEMU_PSCI_0_1_FN_CPU_SUSPEND;
-        cpu_off_fn = QEMU_PSCI_0_1_FN_CPU_OFF;
-        cpu_on_fn = QEMU_PSCI_0_1_FN_CPU_ON;
-        migrate_fn = QEMU_PSCI_0_1_FN_MIGRATE;
-    }
-
-    /* We adopt the PSCI spec's nomenclature, and use 'conduit' to refer
-     * to the instruction that should be used to invoke PSCI functions.
-     * However, the device tree binding uses 'method' instead, so that is
-     * what we should use here.
-     */
-    qemu_fdt_setprop_string(fdt, "/psci", "method", psci_method);
-
-    qemu_fdt_setprop_cell(fdt, "/psci", "cpu_suspend", cpu_suspend_fn);
-    qemu_fdt_setprop_cell(fdt, "/psci", "cpu_off", cpu_off_fn);
-    qemu_fdt_setprop_cell(fdt, "/psci", "cpu_on", cpu_on_fn);
-    qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
-}
-
 static void fdt_add_timer_nodes(const VirtMachineState *vms)
 {
     /* On real hardware these interrupts are level-triggered.
@@ -1409,7 +1349,6 @@ static void machvirt_init(MachineState *machine)
     }
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
-    fdt_add_psci_node(vms);
 
     memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
                                          machine->ram_size);
-- 
2.16.1
