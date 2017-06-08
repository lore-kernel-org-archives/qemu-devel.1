Received: from eggs.gnu.org ([2001:4830:134:3::10]:57356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIrUa-0000Yh-QA
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dIrUZ-0007gj-LZ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:04:28 -0400
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Thu,  8 Jun 2017 17:03:51 +1000
Message-Id: <20170608070351.1434-6-sjitindarsingh@gmail.com>
In-Reply-To: <20170608070351.1434-1-sjitindarsingh@gmail.com>
References: <20170608070351.1434-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [PATCH 5/5] target/ppc: Add cmd line option to disable
 the large decrementer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, agraf@suse.de, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Given there is no way to tell the guest if the size of the large
decrementer changes, it is not possible to migrate a guest between
machines where the decrementer size differs.

Add a command line option to disable the large decrementer for a guest
on boot. This means we will not advertise the availability of the large
decrementer to the guest and thus it won't try to use it.

This allows for a way for a guest to be started which will be compatible
with live migration to a system with a differing decrementer size
(assuming that system still implements the basic 32-bit decrementer
mode).

A required option is supplied to force large decrementer, qemu will fail
to start if the host doesn't support it. There is also a default option
where the large decrementer will be enabled/disabled based on the
capabilities of the hypervisor.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c         | 59 +++++++++++++++++++++++++++++++++++++++++++++-----
 hw/ppc/spapr_hcall.c   |  4 +++-
 include/hw/ppc/spapr.h |  1 +
 3 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6f38939..4290dd8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -558,12 +558,12 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     /*
      * We set this property to let the guest know that it can use the large
      * decrementer and its width in bits. This means we must be on a processor
-     * with a large decrementer and the hypervisor must support it. In TCG the
-     * large decrementer is always supported, in KVM we check the hypervisor
-     * capability.
+     * with a large decrementer, it must not have been disabled and the
+     * hypervisor must support it. In TCG the large decrementer is always
+     * supported, in KVM we check the hypervisor capability.
      */
-    if (pcc->large_decr_bits && ((!kvm_enabled()) ||
-                                 kvmppc_has_cap_large_decr())) {
+    if (pcc->large_decr_bits && (spapr->large_decr_support != -1) &&
+            ((!kvm_enabled()) || kvmppc_has_cap_large_decr())) {
         _FDT((fdt_setprop_u32(fdt, offset, "ibm,dec-bits",
                               pcc->large_decr_bits)));
     }
@@ -1344,6 +1344,11 @@ static void ppc_spapr_reset(void)
     /* We have to do this after vcpus are created since it calls ioctls */
     if (kvm_enabled()) {
         kvmppc_check_cap_large_decr();
+
+        if ((spapr->large_decr_support == 1) && !kvmppc_has_cap_large_decr()) {
+            error_report("Large decrementer unsupported by hypervisor");
+            exit(1);
+        }
     }
 
     qemu_devices_reset();
@@ -1451,7 +1456,9 @@ static int spapr_import_large_decr_bits(sPAPRMachineState *spapr)
         CPUState *cs = CPU(cpu);
         PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cs);
 
-        if (kvm_enabled()) {
+        if (spapr->large_decr_support == -1) {
+            /* Large decrementer disabled on the command line */
+        } else if (kvm_enabled()) {
             if (!kvmppc_has_cap_large_decr()) {
                 error_report("Host doesn't support large decrementer and guest requires it");
                 return -EINVAL;
@@ -2554,6 +2561,37 @@ static void spapr_set_modern_hotplug_events(Object *obj, bool value,
     spapr->use_hotplug_event_source = value;
 }
 
+static char *spapr_get_large_decr_support(Object *obj, Error **errp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+
+    switch (spapr->large_decr_support) {
+    case -1:
+        return g_strdup("disabled");
+    case 1:
+        return g_strdup("required");
+    default:
+        return g_strdup("default");
+    }
+}
+
+static void spapr_set_large_decr_support(Object *obj, const char *value,
+                                         Error **errp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+
+    if (!strncmp(value, "disabled", strlen("disabled"))) {
+        spapr->large_decr_support = -1;
+    } else if (!strncmp(value, "required", strlen("required"))) {
+        spapr->large_decr_support = 1;
+    } else if (!strncmp(value, "default", strlen("default"))) {
+        spapr->large_decr_support = 0;
+    } else {
+        error_report("Unknown large-decr-support specified '%s'", value);
+        exit(1);
+    }
+}
+
 static void spapr_machine_initfn(Object *obj)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
@@ -2574,6 +2612,15 @@ static void spapr_machine_initfn(Object *obj)
                                     " place of standard EPOW events when possible"
                                     " (required for memory hot-unplug support)",
                                     NULL);
+    object_property_add_str(obj, "large-decr-support",
+                            spapr_get_large_decr_support,
+                            spapr_set_large_decr_support, NULL);
+    object_property_set_description(obj, "large-decr-support",
+                                    "Specifies the level of large decrementer support"
+                                    " {required - don't start if not available "
+                                    "| disabled - disable the large decrementer"
+                                    " | default - depend on hypervisor support}"
+                                    , NULL);
 }
 
 static void spapr_machine_finalizefn(Object *obj)
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index c06421b..b4b22cb 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1096,7 +1096,9 @@ static void cas_enable_large_decr(PowerPCCPU *cpu, sPAPRMachineState *spapr)
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     bool guest_large_decr = false;
 
-    if (cpu->compat_pvr) {
+    if (spapr->large_decr_support == -1) {
+        /* Large decrementer disabled on the command line */
+    } else if (cpu->compat_pvr) {
         guest_large_decr = cpu->compat_pvr >= CPU_POWERPC_LOGICAL_3_00;
     } else {
         guest_large_decr = (cpu->env.spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 4ba9b89..65c5659 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -114,6 +114,7 @@ struct sPAPRMachineState {
     /*< public >*/
     char *kvm_type;
     MemoryHotplugState hotplug_memory;
+    int large_decr_support; /* 1 -> required | 0 -> default | -1 -> disable */
 
     const char *icp_type;
 };
-- 
2.9.4
