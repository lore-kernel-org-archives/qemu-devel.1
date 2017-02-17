Received: from eggs.gnu.org ([2001:4830:134:3::10]:59198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceniB-0003HP-0W
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:56:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceni9-0007Xu-Eg
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:56:55 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 17 Feb 2017 19:56:35 +0100
Message-Id: <1487357795-52614-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
References: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 3/3] machine: generilize cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, patches@linaro.org, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

Parse cpu_model string into cpu_type and
[=-]foo features in common machine code
instead of doing the same on every board.

TODO:
patch handles only virt-arm/spapr/pc boards,
but to avoid bisection breakage it should take
care of all boards.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/boards.h  |  3 +++
 include/hw/ppc/ppc.h |  2 --
 hw/arm/virt.c        | 36 ++++--------------------------------
 hw/core/machine.c    | 44 +++++++++++++++++++++++++++++++++++++++++++-
 hw/i386/pc.c         | 24 +++---------------------
 hw/ppc/ppc.c         | 25 -------------------------
 hw/ppc/spapr.c       |  3 +--
 7 files changed, 54 insertions(+), 83 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 9f2dbfd..3374a49 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -136,12 +136,14 @@ struct MachineClass {
     bool rom_file_has_mr;
     int minimum_page_bits;
     bool has_hotpluggable_cpus;
+    const char *base_cpu_type;
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
     unsigned (*cpu_index_to_socket_id)(unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     const char *(*default_cpu_model)(MachineState *machine);
+    bool (*cpu_model_valid)(MachineState *machine, const char *cpu_model);
 };
 
 /**
@@ -182,6 +184,7 @@ struct MachineState {
     char *kernel_cmdline;
     char *initrd_filename;
     const char *cpu_model;
+    const char *cpu_typename;
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
 };
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 4e7fe11..ff0ac30 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -105,6 +105,4 @@ enum {
 
 /* ppc_booke.c */
 void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t flags);
-
-void ppc_cpu_parse_features(const char *cpu_model);
 #endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8380540..d767200 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -169,7 +169,7 @@ static const char *valid_cpus[] = {
     "host",
 };
 
-static bool cpuname_valid(const char *cpu)
+static bool cpuname_valid(MachineState *machine, const char *cpu)
 {
     int i;
 
@@ -1244,12 +1244,6 @@ static void machvirt_init(MachineState *machine)
     MemoryRegion *secure_sysmem = NULL;
     int n, virt_max_cpus;
     MemoryRegion *ram = g_new(MemoryRegion, 1);
-    const char *cpu_model = machine->cpu_model;
-    char **cpustr;
-    ObjectClass *oc;
-    const char *typename;
-    CPUClass *cc;
-    Error *err = NULL;
     bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
 
     /* We can probe only here because during property set
@@ -1268,14 +1262,6 @@ static void machvirt_init(MachineState *machine)
         }
     }
 
-    /* Separate the actual CPU model name from any appended features */
-    cpustr = g_strsplit(cpu_model, ",", 2);
-
-    if (!cpuname_valid(cpustr[0])) {
-        error_report("mach-virt: CPU %s not supported", cpustr[0]);
-        exit(1);
-    }
-
     /* If we have an EL3 boot ROM then the assumption is that it will
      * implement PSCI itself, so disable QEMU's internal implementation
      * so it doesn't get in the way. Instead of starting secondary
@@ -1342,22 +1328,6 @@ static void machvirt_init(MachineState *machine)
 
     create_fdt(vms);
 
-    oc = cpu_class_by_name(TYPE_ARM_CPU, cpustr[0]);
-    if (!oc) {
-        error_report("Unable to find CPU definition");
-        exit(1);
-    }
-    typename = object_class_get_name(oc);
-
-    /* convert -smp CPU options specified by the user into global props */
-    cc = CPU_CLASS(oc);
-    cc->parse_features(typename, cpustr[1], &err);
-    g_strfreev(cpustr);
-    if (err) {
-        error_report_err(err);
-        exit(1);
-    }
-
     mc->possible_cpu_arch_ids(machine);
     for (n = 0; n < machine->possible_cpus->len; n++) {
         Object *cpuobj;
@@ -1367,7 +1337,7 @@ static void machvirt_init(MachineState *machine)
             break;
         }
 
-        cpuobj = object_new(typename);
+        cpuobj = object_new(machine->cpu_typename);
         object_property_set_int(cpuobj, machine->possible_cpus->cpus[n].arch_id,
                                 "mp-affinity", NULL);
 
@@ -1583,6 +1553,8 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->minimum_page_bits = 12;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->default_cpu_model = virt_default_cpu_model;
+    mc->cpu_model_valid = cpuname_valid;
+    mc->base_cpu_type = TYPE_ARM_CPU;
 }
 
 static const TypeInfo virt_machine_info = {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2a954f0..42923b1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -575,8 +575,12 @@ bool machine_mem_merge(MachineState *machine)
     return machine->mem_merge;
 }
 
-void machine_run_board_init(MachineState *machine)
+static void machine_parse_cpu_model(MachineState *machine)
 {
+    ObjectClass *oc;
+    char **cpustr;
+    CPUClass *cc;
+    Error *err = NULL;
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
 
     /* Force all boards to provide default_cpu_model callback */
@@ -585,6 +589,44 @@ void machine_run_board_init(MachineState *machine)
         machine->cpu_model = machine_class->default_cpu_model(machine);
     }
 
+    /* Separate the actual CPU model name from any appended features */
+    cpustr = g_strsplit(machine->cpu_model, ",", 2);
+    if (!cpustr[0]) {
+        error_setg(&err, "Invalid/empty CPU model name");
+        goto out;
+    }
+
+    if (machine_class->cpu_model_valid &&
+        !machine_class->cpu_model_valid(machine, cpustr[0])) {
+        error_report("CPU %s not supported", cpustr[0]);
+        exit(1);
+    }
+
+    /* Force all boards to provide base_cpu_type */
+    assert(machine_class->base_cpu_type);
+    oc = cpu_class_by_name(machine_class->base_cpu_type, cpustr[0]);
+    if (!oc) {
+        error_report("Unable to find CPU definition: %s", cpustr[0]);
+        exit(1);
+    }
+    machine->cpu_typename = object_class_get_name(oc);
+
+    /* convert -smp CPU options specified by the user into global props */
+    cc = CPU_CLASS(oc);
+    cc->parse_features(machine->cpu_typename, cpustr[1], &err);
+out:
+    g_strfreev(cpustr);
+    if (err) {
+        error_report_err(err);
+        exit(1);
+    }
+}
+
+void machine_run_board_init(MachineState *machine)
+{
+    MachineClass *machine_class = MACHINE_GET_CLASS(machine);
+
+    machine_parse_cpu_model(machine);
     machine_class->init(machine);
 }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0073469..9e6149f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1140,31 +1140,11 @@ void pc_hot_add_cpu(const int64_t id, Error **errp)
 void pc_cpus_init(PCMachineState *pcms)
 {
     int i;
-    CPUClass *cc;
-    ObjectClass *oc;
-    const char *typename;
-    gchar **model_pieces;
     const CPUArchIdList *possible_cpus;
     MachineState *machine = MACHINE(pcms);
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
 
     /* init CPUs */
-    model_pieces = g_strsplit(machine->cpu_model, ",", 2);
-    if (!model_pieces[0]) {
-        error_report("Invalid/empty CPU model name");
-        exit(1);
-    }
-
-    oc = cpu_class_by_name(TYPE_X86_CPU, model_pieces[0]);
-    if (oc == NULL) {
-        error_report("Unable to find CPU definition: %s", model_pieces[0]);
-        exit(1);
-    }
-    typename = object_class_get_name(oc);
-    cc = CPU_CLASS(oc);
-    cc->parse_features(typename, model_pieces[1], &error_fatal);
-    g_strfreev(model_pieces);
-
     /* Calculates the limit to CPU APIC ID values
      *
      * Limit for the APIC ID value, so that all
@@ -1175,7 +1155,8 @@ void pc_cpus_init(PCMachineState *pcms)
     pcms->apic_id_limit = x86_cpu_apic_id_from_index(max_cpus - 1) + 1;
     possible_cpus = mc->possible_cpu_arch_ids(machine);
     for (i = 0; i < smp_cpus; i++) {
-        pc_new_cpu(typename, possible_cpus->cpus[i].arch_id, &error_fatal);
+        pc_new_cpu(machine->cpu_typename,
+                   possible_cpus->cpus[i].arch_id, &error_fatal);
     }
 }
 
@@ -2326,6 +2307,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->hot_add_cpu = pc_hot_add_cpu;
     mc->max_cpus = 255;
     mc->default_cpu_model = pc_default_cpu_model;
+    mc->base_cpu_type = TYPE_X86_CPU;
     mc->reset = pc_machine_reset;
     hc->pre_plug = pc_machine_device_pre_plug_cb;
     hc->plug = pc_machine_device_plug_cb;
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index d171e60..8587173 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1364,28 +1364,3 @@ PowerPCCPU *ppc_get_vcpu_by_dt_id(int cpu_dt_id)
 
     return NULL;
 }
-
-void ppc_cpu_parse_features(const char *cpu_model)
-{
-    CPUClass *cc;
-    ObjectClass *oc;
-    const char *typename;
-    gchar **model_pieces;
-
-    model_pieces = g_strsplit(cpu_model, ",", 2);
-    if (!model_pieces[0]) {
-        error_report("Invalid/empty CPU model name");
-        exit(1);
-    }
-
-    oc = cpu_class_by_name(TYPE_POWERPC_CPU, model_pieces[0]);
-    if (oc == NULL) {
-        error_report("Unable to find CPU definition: %s", model_pieces[0]);
-        exit(1);
-    }
-
-    typename = object_class_get_name(oc);
-    cc = CPU_CLASS(oc);
-    cc->parse_features(typename, model_pieces[1], &error_fatal);
-    g_strfreev(model_pieces);
-}
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8f30765..181ea9b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1920,8 +1920,6 @@ static void ppc_spapr_init(MachineState *machine)
     }
 
     /* init CPUs */
-    ppc_cpu_parse_features(machine->cpu_model);
-
     spapr_init_cpus(spapr);
 
     if (kvm_enabled()) {
@@ -2896,6 +2894,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_socket_id = spapr_cpu_index_to_socket_id;
     mc->possible_cpu_arch_ids = spapr_possible_cpu_arch_ids;
     mc->default_cpu_model = spapr_default_cpu_model;
+    mc->base_cpu_type = TYPE_POWERPC_CPU;
     hc->unplug_request = spapr_machine_device_unplug_request;
 
     smc->dr_lmb_enabled = true;
-- 
2.7.4
