Received: from eggs.gnu.org ([2001:4830:134:3::10]:40245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cc8K9-0008OE-DR
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cc8K5-00060G-Bk
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 05:21:05 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 10 Feb 2017 11:20:57 +0100
Message-Id: <1486722057-180456-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
References: <1486638518-171446-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 8/7] machine: replace
 query_hotpluggable_cpus() callback with has_hotpluggable_cpus flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, ehabkost@redhat.com, drjones@redhat.com, Marcel Apfelbaum <marcel@redhat.com>

Generic helper machine_query_hotpluggable_cpus() replaced
target specific query_hotpluggable_cpus() callbacks so
there is no need in it anymore. However inon NULL callback
value is used to detect/report hotpluggable cpus support,
therefore it can be removed completely.
Replace it with MachineClass.has_hotpluggable_cpus boolean
which is sufficient for the task.

Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: David Gibson <david@gibson.dropbear.id.au> (supporter:sPAPR)
CC: Alexander Graf <agraf@suse.de> (supporter:sPAPR)
CC: qemu-ppc@nongnu.org 
CC: Bharata B Rao <bharata@linux.vnet.ibm.com>
CC: ehabkost@redhat.com
CC: drjones@redhat.com
CC: Marcel Apfelbaum <marcel@redhat.com>

---
 include/hw/boards.h |  8 +++-----
 hw/i386/pc.c        |  4 ++--
 hw/ppc/spapr.c      | 20 ++++++++++----------
 monitor.c           |  4 ++--
 vl.c                |  2 +-
 5 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 9040dbb..269d0ba 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -87,10 +87,8 @@ typedef struct {
  *    Returns an array of @CPUArchId architecture-dependent CPU IDs
  *    which includes CPU IDs for present and possible to hotplug CPUs.
  *    Caller is responsible for freeing returned list.
- * @query_hotpluggable_cpus:
- *    Returns a @HotpluggableCPUList, which describes CPUs objects which
- *    could be added with -device/device_add.
- *    Caller is responsible for freeing returned list.
+ * @has_hotpluggable_cpus:
+ *    If true, board supports CPUs creation with -device/device_add.
  * @minimum_page_bits:
  *    If non-zero, the board promises never to create a CPU with a page size
  *    smaller than this, so QEMU can use a more efficient larger page
@@ -136,12 +134,12 @@ struct MachineClass {
     bool option_rom_has_mr;
     bool rom_file_has_mr;
     int minimum_page_bits;
+    bool has_hotpluggable_cpus;
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
     unsigned (*cpu_index_to_socket_id)(unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
-    HotpluggableCPUList *(*query_hotpluggable_cpus)(MachineState *machine);
 };
 
 /**
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 548628f..a8660d4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1949,7 +1949,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
     }
 
     /* if 'address' properties socket-id/core-id/thread-id are not set, set them
-     * so that query_hotpluggable_cpus would show correct values
+     * so that machine_query_hotpluggable_cpus would show correct values
      */
     /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
      * once -smp refactoring is complete and there will be CPU private
@@ -2320,7 +2320,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->get_hotplug_handler = pc_get_hotpug_handler;
     mc->cpu_index_to_socket_id = pc_cpu_index_to_socket_id;
     mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
-    mc->query_hotpluggable_cpus = machine_query_hotpluggable_cpus;
+    mc->has_hotpluggable_cpus = true;
     mc->default_boot_order = "cad";
     mc->hot_add_cpu = pc_hot_add_cpu;
     mc->max_cpus = 255;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 49768eb..6f37288 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -958,7 +958,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
         _FDT(spapr_drc_populate_dt(fdt, 0, NULL, SPAPR_DR_CONNECTOR_TYPE_LMB));
     }
 
-    if (mc->query_hotpluggable_cpus) {
+    if (mc->has_hotpluggable_cpus) {
         int offset = fdt_path_offset(fdt, "/cpus");
         ret = spapr_drc_populate_dt(fdt, offset, NULL,
                                     SPAPR_DR_CONNECTOR_TYPE_CPU);
@@ -1781,7 +1781,7 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
     }
 
     possible_cpus = mc->possible_cpu_arch_ids(machine);
-    if (mc->query_hotpluggable_cpus) {
+    if (mc->has_hotpluggable_cpus) {
         if (smp_cpus % smp_threads) {
             error_report("smp_cpus (%u) must be multiple of threads (%u)",
                          smp_cpus, smp_threads);
@@ -1803,7 +1803,7 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
     for (i = 0; i < possible_cpus->len; i++) {
         int core_id = i * smp_threads;
 
-        if (mc->query_hotpluggable_cpus) {
+        if (mc->has_hotpluggable_cpus) {
             sPAPRDRConnector *drc =
                 spapr_dr_connector_new(OBJECT(spapr),
                                        SPAPR_DR_CONNECTOR_TYPE_CPU,
@@ -2575,7 +2575,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
     drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_CPU, index * smt);
 
-    g_assert(drc || !mc->query_hotpluggable_cpus);
+    g_assert(drc || !mc->has_hotpluggable_cpus);
 
     /*
      * Setup CPU DT entries only for hotplugged CPUs. For boot time or
@@ -2626,7 +2626,7 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     CPUArchId *core_slot;
     int index;
 
-    if (dev->hotplugged && !mc->query_hotpluggable_cpus) {
+    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
         error_setg(&local_err, "CPU hotplug not supported for this machine");
         goto out;
     }
@@ -2719,7 +2719,7 @@ static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
             error_setg(errp, "Memory hot unplug not supported for this guest");
         }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
-        if (!mc->query_hotpluggable_cpus) {
+        if (!mc->has_hotpluggable_cpus) {
             error_setg(errp, "CPU hot unplug not supported on this machine");
             return;
         }
@@ -2746,7 +2746,7 @@ static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
             error_setg(errp, "Memory hot unplug not supported for this guest");
         }
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
-        if (!mc->query_hotpluggable_cpus) {
+        if (!mc->has_hotpluggable_cpus) {
             error_setg(errp, "CPU hot unplug not supported on this machine");
             return;
         }
@@ -2785,7 +2785,7 @@ static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *machine)
     int spapr_max_cores = max_cpus / smp_threads;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
-    if (!mc->query_hotpluggable_cpus) {
+    if (!mc->has_hotpluggable_cpus) {
         spapr_max_cores = QEMU_ALIGN_UP(smp_cpus, smp_threads) / smp_threads;
     }
     if (machine->possible_cpus) {
@@ -2897,7 +2897,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
 
     smc->dr_lmb_enabled = true;
     smc->tcg_default_cpu = "POWER8";
-    mc->query_hotpluggable_cpus = machine_query_hotpluggable_cpus;
+    mc->has_hotpluggable_cpus = true;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
     smc->phb_placement = spapr_phb_placement;
@@ -3097,7 +3097,7 @@ static void spapr_machine_2_6_instance_options(MachineState *machine)
 static void spapr_machine_2_6_class_options(MachineClass *mc)
 {
     spapr_machine_2_7_class_options(mc);
-    mc->query_hotpluggable_cpus = NULL;
+    mc->has_hotpluggable_cpus = false;
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_6);
 }
 
diff --git a/monitor.c b/monitor.c
index 3cd72a9..18bf2f8 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4155,10 +4155,10 @@ HotpluggableCPUList *qmp_query_hotpluggable_cpus(Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
-    if (!mc->query_hotpluggable_cpus) {
+    if (!mc->has_hotpluggable_cpus) {
         error_setg(errp, QERR_FEATURE_DISABLED, "query-hotpluggable-cpus");
         return NULL;
     }
 
-    return mc->query_hotpluggable_cpus(ms);
+    return machine_query_hotpluggable_cpus(ms);
 }
diff --git a/vl.c b/vl.c
index b4eaf03..93406ba 100644
--- a/vl.c
+++ b/vl.c
@@ -1519,7 +1519,7 @@ MachineInfoList *qmp_query_machines(Error **errp)
 
         info->name = g_strdup(mc->name);
         info->cpu_max = !mc->max_cpus ? 1 : mc->max_cpus;
-        info->hotpluggable_cpus = !!mc->query_hotpluggable_cpus;
+        info->hotpluggable_cpus = mc->has_hotpluggable_cpus;
 
         entry = g_malloc0(sizeof(*entry));
         entry->value = info;
-- 
2.7.4
