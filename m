Received: from eggs.gnu.org ([2001:4830:134:3::10]:59139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceni4-0003BS-JV
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceni3-0007UV-Mf
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 13:56:48 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 17 Feb 2017 19:56:34 +0100
Message-Id: <1487357795-52614-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
References: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC 2/3] machine: generalize handling of default
 cpu_model
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

currently all boards have opencoded default cpu_model
selection. I most cases it's just a string and in others
it's a 'function'. Add to machine callback
that returns default cpu_model and make boards return
it as const string.

That allows to move detection of non specified cpu_model
i.e. missing CLI '-cpu' option and move detection
to generic machine code. And would allow to generalize
parsing cpu features in follow up patch.

TODO:
 complete conversion for all boards

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/boards.h |  1 +
 hw/arm/virt.c       | 10 ++++++----
 hw/core/machine.c   |  7 +++++++
 hw/i386/pc.c        | 18 ++++++++++--------
 hw/ppc/spapr.c      | 11 +++++++----
 5 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 04f5352..9f2dbfd 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -141,6 +141,7 @@ struct MachineClass {
                                            DeviceState *dev);
     unsigned (*cpu_index_to_socket_id)(unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
+    const char *(*default_cpu_model)(MachineState *machine);
 };
 
 /**
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a98cb91..8380540 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1252,10 +1252,6 @@ static void machvirt_init(MachineState *machine)
     Error *err = NULL;
     bool firmware_loaded = bios_name || drive_get(IF_PFLASH, 0, 0);
 
-    if (!cpu_model) {
-        cpu_model = "cortex-a15";
-    }
-
     /* We can probe only here because during property set
      * KVM is not available yet
      */
@@ -1564,6 +1560,11 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
+static const char *virt_default_cpu_model(MachineState *machine)
+{
+    return "cortex-a15";
+}
+
 static void virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1581,6 +1582,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     /* We know we will never create a pre-ARMv7 CPU which needs 1K pages */
     mc->minimum_page_bits = 12;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
+    mc->default_cpu_model = virt_default_cpu_model;
 }
 
 static const TypeInfo virt_machine_info = {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index fe82529..2a954f0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -578,6 +578,13 @@ bool machine_mem_merge(MachineState *machine)
 void machine_run_board_init(MachineState *machine)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
+
+    /* Force all boards to provide default_cpu_model callback */
+    assert(machine_class->default_cpu_model);
+    if (machine->cpu_model == NULL) {
+        machine->cpu_model = machine_class->default_cpu_model(machine);
+    }
+
     machine_class->init(machine);
 }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a8660d4..0073469 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1149,14 +1149,6 @@ void pc_cpus_init(PCMachineState *pcms)
     MachineClass *mc = MACHINE_GET_CLASS(pcms);
 
     /* init CPUs */
-    if (machine->cpu_model == NULL) {
-#ifdef TARGET_X86_64
-        machine->cpu_model = "qemu64";
-#else
-        machine->cpu_model = "qemu32";
-#endif
-    }
-
     model_pieces = g_strsplit(machine->cpu_model, ",", 2);
     if (!model_pieces[0]) {
         error_report("Invalid/empty CPU model name");
@@ -2296,6 +2288,15 @@ static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+static const char *pc_default_cpu_model(MachineState *machine)
+{
+#ifdef TARGET_X86_64
+        return "qemu64";
+#else
+        return "qemu32";
+#endif
+}
+
 static void pc_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -2324,6 +2325,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cad";
     mc->hot_add_cpu = pc_hot_add_cpu;
     mc->max_cpus = 255;
+    mc->default_cpu_model = pc_default_cpu_model;
     mc->reset = pc_machine_reset;
     hc->pre_plug = pc_machine_device_pre_plug_cb;
     hc->plug = pc_machine_device_plug_cb;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6f37288..8f30765 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1920,10 +1920,6 @@ static void ppc_spapr_init(MachineState *machine)
     }
 
     /* init CPUs */
-    if (machine->cpu_model == NULL) {
-        machine->cpu_model = kvm_enabled() ? "host" : smc->tcg_default_cpu;
-    }
-
     ppc_cpu_parse_features(machine->cpu_model);
 
     spapr_init_cpus(spapr);
@@ -2861,6 +2857,12 @@ static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
     *mmio64 = SPAPR_PCI_BASE + (index + 1) * SPAPR_PCI_MEM64_WIN_SIZE;
 }
 
+static const char *spapr_default_cpu_model(MachineState *machine)
+{
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
+    return machine->cpu_model = kvm_enabled() ? "host" : smc->tcg_default_cpu;
+}
+
 static void spapr_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -2893,6 +2895,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug = spapr_machine_device_unplug;
     mc->cpu_index_to_socket_id = spapr_cpu_index_to_socket_id;
     mc->possible_cpu_arch_ids = spapr_possible_cpu_arch_ids;
+    mc->default_cpu_model = spapr_default_cpu_model;
     hc->unplug_request = spapr_machine_device_unplug_request;
 
     smc->dr_lmb_enabled = true;
-- 
2.7.4
