Received: from eggs.gnu.org ([2001:4830:134:3::10]:54372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dJ1Dr-00074G-0i
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dJ1Dp-00063n-NA
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:27:51 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu,  8 Jun 2017 19:27:42 +0200
Message-Id: <20170608172743.10132-2-lvivier@redhat.com>
In-Reply-To: <20170608172743.10132-1-lvivier@redhat.com>
References: <20170608172743.10132-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] spapr: disable hotplugging without OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>

If the OS is not started, QEMU sends an event to the OS
that is lost and cannot be recovered. An unplug is not
able to restore QEMU in a coherent state.
So, while the OS is not started, disable CPU and memory hotplug.
We guess the OS is started if the CAS has been negotiated.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr.c         | 51 +++++++++++++++++++++++++++++++++++++++++++++++---
 hw/ppc/spapr_hcall.c   |  1 +
 include/hw/ppc/spapr.h |  2 ++
 3 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 91b4057..4c979d5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1308,6 +1308,7 @@ static void ppc_spapr_reset(void)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
     sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     PowerPCCPU *first_ppc_cpu;
     uint32_t rtas_limit;
     hwaddr rtas_addr, fdt_addr;
@@ -1373,6 +1374,7 @@ static void ppc_spapr_reset(void)
     first_ppc_cpu->env.nip = SPAPR_ENTRY_POINT;
 
     spapr->cas_reboot = false;
+    spapr->cas_completed = smc->cas_completed_default;
 }
 
 static void spapr_create_nvram(sPAPRMachineState *spapr)
@@ -1528,6 +1530,27 @@ static const VMStateDescription vmstate_spapr_patb_entry = {
     },
 };
 
+static bool spapr_cas_completed_needed(void *opaque)
+{
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(opaque);
+
+    /* we need to migrate cas_completed only if it is
+     * not set by default
+     */
+    return !smc->cas_completed_default;
+}
+
+static const VMStateDescription vmstate_spapr_cas_completed = {
+    .name = "spapr_cas_completed",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_cas_completed_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(cas_completed, sPAPRMachineState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_spapr = {
     .name = "spapr",
     .version_id = 3,
@@ -1546,6 +1569,7 @@ static const VMStateDescription vmstate_spapr = {
     .subsections = (const VMStateDescription*[]) {
         &vmstate_spapr_ov5_cas,
         &vmstate_spapr_patb_entry,
+        &vmstate_spapr_cas_completed,
         NULL
     }
 };
@@ -2599,6 +2623,7 @@ out:
 static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                   Error **errp)
 {
+    sPAPRMachineState *ms = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr = ddc->get_memory_region(dimm);
@@ -2617,6 +2642,14 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                    "Use 'memory-backend-file' with correct mem-path.");
         return;
     }
+    if (dev->hotplugged) {
+        if (!runstate_check(RUN_STATE_PRELAUNCH) &&
+            !runstate_check(RUN_STATE_INMIGRATE) &&
+            !ms->cas_completed) {
+            error_setg(errp, "Memory hotplug not supported without OS");
+            return;
+        }
+    }
 }
 
 struct sPAPRDIMMState {
@@ -2915,6 +2948,7 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
     MachineState *machine = MACHINE(OBJECT(hotplug_dev));
+    sPAPRMachineState *ms = SPAPR_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
     Error *local_err = NULL;
     CPUCore *cc = CPU_CORE(dev);
@@ -2923,9 +2957,18 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     CPUArchId *core_slot;
     int index;
 
-    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
-        error_setg(&local_err, "CPU hotplug not supported for this machine");
-        goto out;
+    if (dev->hotplugged) {
+        if (!mc->has_hotpluggable_cpus) {
+            error_setg(&local_err,
+                       "CPU hotplug not supported for this machine");
+            goto out;
+        }
+        if (!runstate_check(RUN_STATE_PRELAUNCH) &&
+            !runstate_check(RUN_STATE_INMIGRATE) &&
+            !ms->cas_completed) {
+            error_setg(&local_err, "CPU hotplug not supported without OS");
+            goto out;
+        }
     }
 
     if (strcmp(base_core_type, type)) {
@@ -3358,9 +3401,11 @@ static void spapr_machine_2_9_instance_options(MachineState *machine)
 
 static void spapr_machine_2_9_class_options(MachineClass *mc)
 {
+    sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
     spapr_machine_2_10_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
     mc->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
+    smc->cas_completed_default = true;
 }
 
 DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index aa1ffea..d561a00 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1185,6 +1185,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
         }
     }
 
+    spapr->cas_completed = true;
     return H_SUCCESS;
 }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f973b02..f5835db 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -57,6 +57,7 @@ struct sPAPRMachineClass {
                           uint64_t *buid, hwaddr *pio, 
                           hwaddr *mmio32, hwaddr *mmio64,
                           unsigned n_dma, uint32_t *liobns, Error **errp);
+    bool cas_completed_default;
 };
 
 /**
@@ -90,6 +91,7 @@ struct sPAPRMachineState {
     sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vectors */
     bool cas_reboot;
     bool cas_legacy_guest_workaround;
+    bool cas_completed;
 
     Notifier epow_notifier;
     QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
-- 
2.9.4
