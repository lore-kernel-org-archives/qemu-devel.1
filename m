Received: from eggs.gnu.org ([2001:4830:134:3::10]:50821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOe-0008Tx-5R
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOa-0007BT-P8
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:43 +1100
Message-Id: <20171017042152.29443-26-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 25/34] ppc: spapr: use generic cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

use generic cpu_model parsing introduced by
 (6063d4c0f vl.c: convert cpu_model to cpu type and set of global properties before machine_init())

it allows to:
  * replace sPAPRMachineClass::tcg_default_cpu with
    MachineClass::default_cpu_type
  * drop cpu_parse_cpu_model() from hw/ppc/spapr.c and reuse
    one in vl.c
  * simplify spapr_get_cpu_core_type() by removing
    not needed anymore recurrsion since alias look up
    happens earlier at vl.c and spapr_get_cpu_core_type()
    works only with resulted from that cpu type.
  * spapr no more needs to parse/depend on being phased out
    MachineState::cpu_model, all tha parsing done by generic
    code and target specific callback.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
[dwg: Correct minor compile error]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c                  | 16 ++++------------
 hw/ppc/spapr_cpu_core.c         | 30 ++++++++++--------------------
 include/hw/ppc/spapr.h          |  1 -
 include/hw/ppc/spapr_cpu_core.h |  2 +-
 target/ppc/cpu.h                |  1 -
 target/ppc/kvm.c                | 11 ++++++++---
 target/ppc/translate_init.c     |  2 +-
 7 files changed, 24 insertions(+), 39 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f7c5df3832..d682f013d4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2129,7 +2129,7 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
 {
     MachineState *machine = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    char *type = spapr_get_cpu_core_type(machine->cpu_model);
+    const char *type = spapr_get_cpu_core_type(machine->cpu_type);
     int smt = kvmppc_smt_threads();
     const CPUArchIdList *possible_cpus;
     int boot_cores_nr = smp_cpus / smp_threads;
@@ -2184,7 +2184,6 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
             object_property_set_bool(core, true, "realized", &error_fatal);
         }
     }
-    g_free(type);
 }
 
 static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
@@ -2369,12 +2368,6 @@ static void ppc_spapr_init(MachineState *machine)
     }
 
     /* init CPUs */
-    if (machine->cpu_model == NULL) {
-        machine->cpu_model = kvm_enabled() ? "host" : smc->tcg_default_cpu;
-    }
-
-    cpu_parse_cpu_model(TYPE_POWERPC_CPU, machine->cpu_model);
-
     spapr_set_vsmt_mode(spapr, &error_fatal);
 
     spapr_init_cpus(spapr);
@@ -3277,7 +3270,7 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
     Error *local_err = NULL;
     CPUCore *cc = CPU_CORE(dev);
-    char *base_core_type = spapr_get_cpu_core_type(machine->cpu_model);
+    const char *base_core_type = spapr_get_cpu_core_type(machine->cpu_type);
     const char *type = object_get_typename(OBJECT(dev));
     CPUArchId *core_slot;
     int index;
@@ -3323,7 +3316,6 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     numa_cpu_pre_plug(core_slot, dev, &local_err);
 
 out:
-    g_free(base_core_type);
     error_propagate(errp, local_err);
 }
 
@@ -3622,7 +3614,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug_request = spapr_machine_device_unplug_request;
 
     smc->dr_lmb_enabled = true;
-    smc->tcg_default_cpu = "power8_v2.0";
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
     mc->has_hotpluggable_cpus = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
@@ -3868,7 +3860,7 @@ static void spapr_machine_2_7_class_options(MachineClass *mc)
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
 
     spapr_machine_2_8_class_options(mc);
-    smc->tcg_default_cpu = "power7_v2.3";
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power7_v2.3");
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_7);
     smc->phb_placement = phb_placement_2_7;
 }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 7dbf9c31c5..195762d8d2 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -61,29 +61,19 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, PowerPCCPU *cpu,
  * Return the sPAPR CPU core type for @model which essentially is the CPU
  * model specified with -cpu cmdline option.
  */
-char *spapr_get_cpu_core_type(const char *model)
+const char *spapr_get_cpu_core_type(const char *cpu_type)
 {
-    char *core_type;
-    gchar **model_pieces = g_strsplit(model, ",", 2);
-    gchar *cpu_model = g_ascii_strdown(model_pieces[0], -1);
-    g_strfreev(model_pieces);
-
-    core_type = g_strdup_printf("%s-" TYPE_SPAPR_CPU_CORE, cpu_model);
-
-    /* Check whether it exists or whether we have to look up an alias name */
-    if (!object_class_by_name(core_type)) {
-        const char *realmodel;
-
-        g_free(core_type);
-        core_type = NULL;
-        realmodel = ppc_cpu_lookup_alias(cpu_model);
-        if (realmodel) {
-            core_type = spapr_get_cpu_core_type(realmodel);
-        }
+    int len = strlen(cpu_type) - strlen(POWERPC_CPU_TYPE_SUFFIX);
+    char *core_type = g_strdup_printf(SPAPR_CPU_CORE_TYPE_NAME("%.*s"),
+                                      len, cpu_type);
+    ObjectClass *oc = object_class_by_name(core_type);
+
+    g_free(core_type);
+    if (!oc) {
+        return NULL;
     }
-    g_free(cpu_model);
 
-    return core_type;
+    return object_class_get_name(oc);
 }
 
 static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 8ca4f9498f..9d21ca9bde 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -60,7 +60,6 @@ struct sPAPRMachineClass {
     /*< public >*/
     bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMBs */
     bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
-    const char *tcg_default_cpu; /* which (TCG) CPU to simulate by default */
     bool pre_2_10_has_unused_icps;
     void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
                           uint64_t *buid, hwaddr *pio, 
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 42765de392..f2d48d6a67 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -37,5 +37,5 @@ typedef struct sPAPRCPUCoreClass {
     const char *cpu_type;
 } sPAPRCPUCoreClass;
 
-char *spapr_get_cpu_core_type(const char *model);
+const char *spapr_get_cpu_core_type(const char *cpu_type);
 #endif
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 64aef17f6f..989761b795 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1278,7 +1278,6 @@ extern const struct VMStateDescription vmstate_ppc_cpu;
 
 /*****************************************************************************/
 void ppc_translate_init(void);
-const char *ppc_cpu_lookup_alias(const char *alias);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
    is returned if the signal was handled by the virtual CPU.  */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index cb5777afa0..9d57debf0e 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -123,7 +123,7 @@ static bool kvmppc_is_pr(KVMState *ks)
     return kvm_vm_check_extension(ks, KVM_CAP_PPC_GET_PVINFO) != 0;
 }
 
-static int kvm_ppc_register_host_cpu_type(void);
+static int kvm_ppc_register_host_cpu_type(MachineState *ms);
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
@@ -163,7 +163,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
                         "VM to stall at times!\n");
     }
 
-    kvm_ppc_register_host_cpu_type();
+    kvm_ppc_register_host_cpu_type(ms);
 
     return 0;
 }
@@ -2487,12 +2487,13 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
     return pvr_pcc;
 }
 
-static int kvm_ppc_register_host_cpu_type(void)
+static int kvm_ppc_register_host_cpu_type(MachineState *ms)
 {
     TypeInfo type_info = {
         .name = TYPE_HOST_POWERPC_CPU,
         .class_init = kvmppc_host_cpu_class_init,
     };
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     PowerPCCPUClass *pvr_pcc;
     ObjectClass *oc;
     DeviceClass *dc;
@@ -2504,6 +2505,10 @@ static int kvm_ppc_register_host_cpu_type(void)
     }
     type_info.parent = object_class_get_name(OBJECT_CLASS(pvr_pcc));
     type_register(&type_info);
+    if (object_dynamic_cast(OBJECT(ms), TYPE_SPAPR_MACHINE)) {
+        /* override TCG default cpu type with 'host' cpu model */
+        mc->default_cpu_type = TYPE_HOST_POWERPC_CPU;
+    }
 
     oc = object_class_by_name(type_info.name);
     g_assert(oc);
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 17ac95b732..7b9bf6a773 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10060,7 +10060,7 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr)
     return pcc;
 }
 
-const char *ppc_cpu_lookup_alias(const char *alias)
+static const char *ppc_cpu_lookup_alias(const char *alias)
 {
     int ai;
 
-- 
2.13.6
