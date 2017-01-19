Received: from eggs.gnu.org ([2001:4830:134:3::10]:47413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPq-0000xB-0J
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPo-00059D-Cc
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:13 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPo-000582-6J
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:12 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPn-0003FJ-9a
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:11 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:51 +0000
Message-Id: <1484834995-26826-33-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 32/36] hw/arm/virt: Support using SMC for PSCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If we are giving the guest a CPU with EL2, it is likely to
want to use the HVC instruction itself, for instance for
providing PSCI to inner guest VMs. This makes using HVC
as the PSCI conduit for the outer QEMU a bad idea. We will
want to use SMC instead is this case: this makes sense
because QEMU's PSCI implementation is effectively an
emulation of functionality provided by EL3 firmware.

Add code to support selecting the PSCI conduit to use,
rather than hardcoding use of HVC.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Message-id: 1483977924-14522-15-git-send-email-peter.maydell@linaro.org
---
 include/hw/arm/virt.h |  2 +-
 hw/arm/virt.c         | 27 +++++++++++++++++++++------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index b8a19ec..53507e6 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -103,7 +103,7 @@ typedef struct {
     uint32_t clock_phandle;
     uint32_t gic_phandle;
     uint32_t msi_phandle;
-    bool using_psci;
+    int psci_conduit;
 } VirtMachineState;
 
 #define TYPE_VIRT_MACHINE   MACHINE_TYPE_NAME("virt")
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d931d17..3a6f895 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -229,9 +229,19 @@ static void fdt_add_psci_node(const VirtMachineState *vms)
     uint32_t migrate_fn;
     void *fdt = vms->fdt;
     ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0));
+    const char *psci_method;
 
-    if (!vms->using_psci) {
+    switch (vms->psci_conduit) {
+    case QEMU_PSCI_CONDUIT_DISABLED:
         return;
+    case QEMU_PSCI_CONDUIT_HVC:
+        psci_method = "hvc";
+        break;
+    case QEMU_PSCI_CONDUIT_SMC:
+        psci_method = "smc";
+        break;
+    default:
+        g_assert_not_reached();
     }
 
     qemu_fdt_add_subnode(fdt, "/psci");
@@ -263,7 +273,7 @@ static void fdt_add_psci_node(const VirtMachineState *vms)
      * However, the device tree binding uses 'method' instead, so that is
      * what we should use here.
      */
-    qemu_fdt_setprop_string(fdt, "/psci", "method", "hvc");
+    qemu_fdt_setprop_string(fdt, "/psci", "method", psci_method);
 
     qemu_fdt_setprop_cell(fdt, "/psci", "cpu_suspend", cpu_suspend_fn);
     qemu_fdt_setprop_cell(fdt, "/psci", "cpu_off", cpu_off_fn);
@@ -365,7 +375,8 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
         qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
                                     armcpu->dtb_compatible);
 
-        if (vms->using_psci && vms->smp_cpus > 1) {
+        if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED
+            && vms->smp_cpus > 1) {
             qemu_fdt_setprop_string(vms->fdt, nodename,
                                         "enable-method", "psci");
         }
@@ -1230,7 +1241,11 @@ static void machvirt_init(MachineState *machine)
      * let the boot ROM sort them out.
      * The usual case is that we do use QEMU's PSCI implementation.
      */
-    vms->using_psci = !(vms->secure && firmware_loaded);
+    if (vms->secure && firmware_loaded) {
+        vms->psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
+    } else {
+        vms->psci_conduit = QEMU_PSCI_CONDUIT_HVC;
+    }
 
     /* The maximum number of CPUs depends on the GIC version, or on how
      * many redistributors we can fit into the memory map.
@@ -1313,8 +1328,8 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, false, "has_el3", NULL);
         }
 
-        if (vms->using_psci) {
-            object_property_set_int(cpuobj, QEMU_PSCI_CONDUIT_HVC,
+        if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
+            object_property_set_int(cpuobj, vms->psci_conduit,
                                     "psci-conduit", NULL);
 
             /* Secondary CPUs start in PSCI powered-down state */
-- 
2.7.4
