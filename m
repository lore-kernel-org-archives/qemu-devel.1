Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B6EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6B422CF7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6B422CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GYl-00078a-Ae
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwU-0004Ha-V9
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwQ-0001Fq-77
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38120)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i5FwP-0001A5-CV
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 157923CA06;
 Tue,  3 Sep 2019 21:02:10 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37BEB19C78;
 Tue,  3 Sep 2019 21:02:09 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 18:01:51 -0300
Message-Id: <20190903210201.14627-4-ehabkost@redhat.com>
In-Reply-To: <20190903210201.14627-1-ehabkost@redhat.com>
References: <20190903210201.14627-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 03 Sep 2019 21:02:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 03/13] numa: move numa global variable
 nb_numa_nodes into MachineState
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Tao Xu <tao3.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tao Xu <tao3.xu@intel.com>

Add struct NumaState in MachineState and move existing numa global
nb_numa_nodes(renamed as "num_nodes") into NumaState. And add variable
numa_support into MachineClass to decide which submachines support NUMA.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20190809065731.9097-3-tao3.xu@intel.com>
[ehabkost: include hw/boards.h again to fix build failures]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/acpi/aml-build.h         |  2 +-
 include/hw/boards.h                 |  1 +
 include/sysemu/numa.h               | 10 ++++-
 exec.c                              |  5 ++-
 hw/acpi/aml-build.c                 |  4 +-
 hw/arm/boot.c                       |  4 +-
 hw/arm/sbsa-ref.c                   |  4 +-
 hw/arm/virt-acpi-build.c            | 10 +++--
 hw/arm/virt.c                       |  4 +-
 hw/core/machine-hmp-cmds.c          | 13 +++++--
 hw/core/machine.c                   | 14 +++++--
 hw/core/numa.c                      | 60 +++++++++++++++++------------
 hw/i386/acpi-build.c                |  2 +-
 hw/i386/pc.c                        |  9 +++--
 hw/mem/pc-dimm.c                    |  2 +
 hw/pci-bridge/pci_expander_bridge.c |  9 ++++-
 hw/ppc/spapr.c                      | 19 ++++-----
 17 files changed, 113 insertions(+), 59 deletions(-)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 1a563ad756..991cf05134 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -414,7 +414,7 @@ build_append_gas_from_struct(GArray *table, const str=
uct AcpiGenericAddress *s)
 void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags=
);
=20
-void build_slit(GArray *table_data, BIOSLinker *linker);
+void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms=
);
=20
 void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
                 const char *oem_id, const char *oem_table_id);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index ced86109ec..2289536e48 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -299,6 +299,7 @@ struct MachineState {
     CPUArchIdList *possible_cpus;
     CpuTopology smp;
     struct NVDIMMState *nvdimms_state;
+    struct NumaState *numa_state;
 };
=20
 #define DEFINE_MACHINE(namestr, machine_initfn) \
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 7a4ce89765..1786e861d0 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -14,7 +14,6 @@ struct CPUArchId;
 #define NUMA_DISTANCE_MAX         254
 #define NUMA_DISTANCE_UNREACHABLE 255
=20
-extern int nb_numa_nodes;   /* Number of NUMA nodes */
 extern bool have_numa_distance;
=20
 struct NodeInfo {
@@ -31,10 +30,17 @@ struct NumaNodeMem {
=20
 extern NodeInfo numa_info[MAX_NODES];
=20
+struct NumaState {
+    /* Number of NUMA nodes */
+    int num_nodes;
+
+};
+typedef struct NumaState NumaState;
+
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **err=
p);
 void parse_numa_opts(MachineState *ms);
 void numa_complete_configuration(MachineState *ms);
-void query_numa_node_mem(NumaNodeMem node_mem[]);
+void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms);
 extern QemuOptsList qemu_numa_opts;
 void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
                                  int nb_nodes, ram_addr_t size);
diff --git a/exec.c b/exec.c
index 1df966d17a..e813058b05 100644
--- a/exec.c
+++ b/exec.c
@@ -1750,6 +1750,7 @@ long qemu_minrampagesize(void)
     long hpsize =3D LONG_MAX;
     long mainrampagesize;
     Object *memdev_root;
+    MachineState *ms =3D MACHINE(qdev_get_machine());
=20
     mainrampagesize =3D qemu_mempath_getpagesize(mem_path);
=20
@@ -1777,7 +1778,9 @@ long qemu_minrampagesize(void)
      * so if its page size is smaller we have got to report that size in=
stead.
      */
     if (hpsize > mainrampagesize &&
-        (nb_numa_nodes =3D=3D 0 || numa_info[0].node_memdev =3D=3D NULL)=
) {
+        (ms->numa_state =3D=3D NULL ||
+         ms->numa_state->num_nodes =3D=3D 0 ||
+         numa_info[0].node_memdev =3D=3D NULL)) {
         static bool warned;
         if (!warned) {
             error_report("Huge page support disabled (n/a for main memor=
y).");
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 555c24f21d..043b47694c 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -25,6 +25,7 @@
 #include "qemu/bswap.h"
 #include "qemu/bitops.h"
 #include "sysemu/numa.h"
+#include "hw/boards.h"
=20
 static GArray *build_alloc_array(void)
 {
@@ -1726,10 +1727,11 @@ void build_srat_memory(AcpiSratMemoryAffinity *nu=
mamem, uint64_t base,
  * ACPI spec 5.2.17 System Locality Distance Information Table
  * (Revision 2.0 or later)
  */
-void build_slit(GArray *table_data, BIOSLinker *linker)
+void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms=
)
 {
     int slit_start, i, j;
     slit_start =3D table_data->len;
+    int nb_numa_nodes =3D ms->numa_state->num_nodes;
=20
     acpi_data_push(table_data, sizeof(AcpiTableHeader));
=20
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index b46eaefa2d..d3e88626c4 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -598,9 +598,9 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_i=
nfo *binfo,
     }
     g_strfreev(node_path);
=20
-    if (nb_numa_nodes > 0) {
+    if (ms->numa_state !=3D NULL && ms->numa_state->num_nodes > 0) {
         mem_base =3D binfo->loader_start;
-        for (i =3D 0; i < nb_numa_nodes; i++) {
+        for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
             mem_len =3D numa_info[i].node_mem;
             rc =3D fdt_add_memory_node(fdt, acells, mem_base,
                                      scells, mem_len, i);
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 1c1a2b662d..d15e5aebbd 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -146,6 +146,7 @@ static void create_fdt(SBSAMachineState *sms)
 {
     void *fdt =3D create_device_tree(&sms->fdt_size);
     const MachineState *ms =3D MACHINE(sms);
+    int nb_numa_nodes =3D ms->numa_state->num_nodes;
     int cpu;
=20
     if (!fdt) {
@@ -762,7 +763,7 @@ sbsa_ref_cpu_index_to_props(MachineState *ms, unsigne=
d cpu_index)
 static int64_t
 sbsa_ref_get_default_cpu_node_id(const MachineState *ms, int idx)
 {
-    return idx % nb_numa_nodes;
+    return idx % ms->numa_state->num_nodes;
 }
=20
 static void sbsa_ref_instance_init(Object *obj)
@@ -789,6 +790,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void=
 *data)
     mc->possible_cpu_arch_ids =3D sbsa_ref_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props =3D sbsa_ref_cpu_index_to_props;
     mc->get_default_cpu_node_id =3D sbsa_ref_get_default_cpu_node_id;
+    mc->numa_mem_supported =3D true;
 }
=20
 static const TypeInfo sbsa_ref_info =3D {
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index a8b2d97fe9..9e6cfe65b5 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -517,7 +517,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
     int i, srat_start;
     uint64_t mem_base;
     MachineClass *mc =3D MACHINE_GET_CLASS(vms);
-    const CPUArchIdList *cpu_list =3D mc->possible_cpu_arch_ids(MACHINE(=
vms));
+    MachineState *ms =3D MACHINE(vms);
+    const CPUArchIdList *cpu_list =3D mc->possible_cpu_arch_ids(ms);
=20
     srat_start =3D table_data->len;
     srat =3D acpi_data_push(table_data, sizeof(*srat));
@@ -533,7 +534,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
     }
=20
     mem_base =3D vms->memmap[VIRT_MEM].base;
-    for (i =3D 0; i < nb_numa_nodes; ++i) {
+    for (i =3D 0; i < ms->numa_state->num_nodes; ++i) {
         if (numa_info[i].node_mem > 0) {
             numamem =3D acpi_data_push(table_data, sizeof(*numamem));
             build_srat_memory(numamem, mem_base, numa_info[i].node_mem, =
i,
@@ -759,6 +760,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuild=
Tables *tables)
     GArray *table_offsets;
     unsigned dsdt, xsdt;
     GArray *tables_blob =3D tables->table_data;
+    MachineState *ms =3D MACHINE(vms);
=20
     table_offsets =3D g_array_new(false, true /* clear */,
                                         sizeof(uint32_t));
@@ -793,12 +795,12 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBui=
ldTables *tables)
     acpi_add_table(table_offsets, tables_blob);
     build_spcr(tables_blob, tables->linker, vms);
=20
-    if (nb_numa_nodes > 0) {
+    if (ms->numa_state->num_nodes > 0) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, vms);
         if (have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
-            build_slit(tables_blob, tables->linker);
+            build_slit(tables_blob, tables->linker, ms);
         }
     }
=20
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3796aa70f8..8d36b37f8e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -203,6 +203,8 @@ static bool cpu_type_valid(const char *cpu)
=20
 static void create_fdt(VirtMachineState *vms)
 {
+    MachineState *ms =3D MACHINE(vms);
+    int nb_numa_nodes =3D ms->numa_state->num_nodes;
     void *fdt =3D create_device_tree(&vms->fdt_size);
=20
     if (!fdt) {
@@ -1846,7 +1848,7 @@ virt_cpu_index_to_props(MachineState *ms, unsigned =
cpu_index)
=20
 static int64_t virt_get_default_cpu_node_id(const MachineState *ms, int =
idx)
 {
-    return idx % nb_numa_nodes;
+    return idx % ms->numa_state->num_nodes;
 }
=20
 static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 1f66bda346..cd970cc4c5 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -23,6 +23,7 @@
 #include "qapi/string-output-visitor.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
+#include "hw/boards.h"
=20
 void hmp_info_cpus(Monitor *mon, const QDict *qdict)
 {
@@ -139,15 +140,21 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdi=
ct)
=20
 void hmp_info_numa(Monitor *mon, const QDict *qdict)
 {
-    int i;
+    int i, nb_numa_nodes;
     NumaNodeMem *node_mem;
     CpuInfoList *cpu_list, *cpu;
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+
+    nb_numa_nodes =3D ms->numa_state ? ms->numa_state->num_nodes : 0;
+    monitor_printf(mon, "%d nodes\n", nb_numa_nodes);
+    if (!nb_numa_nodes) {
+        return;
+    }
=20
     cpu_list =3D qmp_query_cpus(&error_abort);
     node_mem =3D g_new0(NumaNodeMem, nb_numa_nodes);
=20
-    query_numa_node_mem(node_mem);
-    monitor_printf(mon, "%d nodes\n", nb_numa_nodes);
+    query_numa_node_mem(node_mem, ms);
     for (i =3D 0; i < nb_numa_nodes; i++) {
         monitor_printf(mon, "node %d cpus:", i);
         for (cpu =3D cpu_list; cpu; cpu =3D cpu->next) {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 83cd1bfeec..c5e0d52fbc 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -956,6 +956,9 @@ static void machine_initfn(Object *obj)
                                         NULL);
     }
=20
+    if (mc->numa_mem_supported) {
+        ms->numa_state =3D g_new0(NumaState, 1);
+    }
=20
     /* Register notifier when init is done for sysbus sanity checks */
     ms->sysbus_notifier.notify =3D machine_init_notify;
@@ -976,6 +979,7 @@ static void machine_finalize(Object *obj)
     g_free(ms->firmware);
     g_free(ms->device_memory);
     g_free(ms->nvdimms_state);
+    g_free(ms->numa_state);
 }
=20
 bool machine_usb(MachineState *machine)
@@ -1050,7 +1054,7 @@ static void machine_numa_finish_cpu_init(MachineSta=
te *machine)
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     const CPUArchIdList *possible_cpus =3D mc->possible_cpu_arch_ids(mac=
hine);
=20
-    assert(nb_numa_nodes);
+    assert(machine->numa_state->num_nodes);
     for (i =3D 0; i < possible_cpus->len; i++) {
         if (possible_cpus->cpus[i].props.has_node_id) {
             break;
@@ -1096,9 +1100,11 @@ void machine_run_board_init(MachineState *machine)
 {
     MachineClass *machine_class =3D MACHINE_GET_CLASS(machine);
=20
-    numa_complete_configuration(machine);
-    if (nb_numa_nodes) {
-        machine_numa_finish_cpu_init(machine);
+    if (machine_class->numa_mem_supported) {
+        numa_complete_configuration(machine);
+        if (machine->numa_state->num_nodes) {
+            machine_numa_finish_cpu_init(machine);
+        }
     }
=20
     /* If the machine supports the valid_cpu_types check and the user
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 4f7e4628a0..2712c78adb 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -55,7 +55,6 @@ static int have_mem;
 static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
                              * For all nodes, nodeid < max_numa_nodeid
                              */
-int nb_numa_nodes;
 bool have_numa_distance;
 NodeInfo numa_info[MAX_NODES];
=20
@@ -72,7 +71,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeO=
ptions *node,
     if (node->has_nodeid) {
         nodenr =3D node->nodeid;
     } else {
-        nodenr =3D nb_numa_nodes;
+        nodenr =3D ms->numa_state->num_nodes;
     }
=20
     if (nodenr >=3D MAX_NODES) {
@@ -138,10 +137,11 @@ static void parse_numa_node(MachineState *ms, NumaN=
odeOptions *node,
     }
     numa_info[nodenr].present =3D true;
     max_numa_nodeid =3D MAX(max_numa_nodeid, nodenr + 1);
-    nb_numa_nodes++;
+    ms->numa_state->num_nodes++;
 }
=20
-static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
+static
+void parse_numa_distance(MachineState *ms, NumaDistOptions *dist, Error =
**errp)
 {
     uint16_t src =3D dist->src;
     uint16_t dst =3D dist->dst;
@@ -179,6 +179,12 @@ static void parse_numa_distance(NumaDistOptions *dis=
t, Error **errp)
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **err=
p)
 {
     Error *err =3D NULL;
+    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
+
+    if (!mc->numa_mem_supported) {
+        error_setg(errp, "NUMA is not supported by this machine-type");
+        goto end;
+    }
=20
     switch (object->type) {
     case NUMA_OPTIONS_TYPE_NODE:
@@ -188,7 +194,7 @@ void set_numa_options(MachineState *ms, NumaOptions *=
object, Error **errp)
         }
         break;
     case NUMA_OPTIONS_TYPE_DIST:
-        parse_numa_distance(&object->u.dist, &err);
+        parse_numa_distance(ms, &object->u.dist, &err);
         if (err) {
             goto end;
         }
@@ -253,10 +259,11 @@ end:
  * distance from a node to itself is always NUMA_DISTANCE_MIN,
  * so providing it is never necessary.
  */
-static void validate_numa_distance(void)
+static void validate_numa_distance(MachineState *ms)
 {
     int src, dst;
     bool is_asymmetrical =3D false;
+    int nb_numa_nodes =3D ms->numa_state->num_nodes;
=20
     for (src =3D 0; src < nb_numa_nodes; src++) {
         for (dst =3D src; dst < nb_numa_nodes; dst++) {
@@ -294,7 +301,7 @@ static void validate_numa_distance(void)
     }
 }
=20
-static void complete_init_numa_distance(void)
+static void complete_init_numa_distance(MachineState *ms)
 {
     int src, dst;
=20
@@ -303,8 +310,8 @@ static void complete_init_numa_distance(void)
      * there would not be any missing distance except local node, which
      * is verified by validate_numa_distance above.
      */
-    for (src =3D 0; src < nb_numa_nodes; src++) {
-        for (dst =3D 0; dst < nb_numa_nodes; dst++) {
+    for (src =3D 0; src < ms->numa_state->num_nodes; src++) {
+        for (dst =3D 0; dst < ms->numa_state->num_nodes; dst++) {
             if (numa_info[src].distance[dst] =3D=3D 0) {
                 if (src =3D=3D dst) {
                     numa_info[src].distance[dst] =3D NUMA_DISTANCE_MIN;
@@ -370,7 +377,7 @@ void numa_complete_configuration(MachineState *ms)
      *
      * Enable NUMA implicitly by adding a new NUMA node automatically.
      */
-    if (ms->ram_slots > 0 && nb_numa_nodes =3D=3D 0 &&
+    if (ms->ram_slots > 0 && ms->numa_state->num_nodes =3D=3D 0 &&
         mc->auto_enable_numa_with_memhp) {
             NumaNodeOptions node =3D { };
             parse_numa_node(ms, &node, &error_abort);
@@ -388,26 +395,27 @@ void numa_complete_configuration(MachineState *ms)
     }
=20
     /* This must be always true if all nodes are present: */
-    assert(nb_numa_nodes =3D=3D max_numa_nodeid);
+    assert(ms->numa_state->num_nodes =3D=3D max_numa_nodeid);
=20
-    if (nb_numa_nodes > 0) {
+    if (ms->numa_state->num_nodes > 0) {
         uint64_t numa_total;
=20
-        if (nb_numa_nodes > MAX_NODES) {
-            nb_numa_nodes =3D MAX_NODES;
+        if (ms->numa_state->num_nodes > MAX_NODES) {
+            ms->numa_state->num_nodes =3D MAX_NODES;
         }
=20
         /* If no memory size is given for any node, assume the default c=
ase
          * and distribute the available memory equally across all nodes
          */
-        for (i =3D 0; i < nb_numa_nodes; i++) {
+        for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
             if (numa_info[i].node_mem !=3D 0) {
                 break;
             }
         }
-        if (i =3D=3D nb_numa_nodes) {
+        if (i =3D=3D ms->numa_state->num_nodes) {
             assert(mc->numa_auto_assign_ram);
-            mc->numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram_s=
ize);
+            mc->numa_auto_assign_ram(mc, numa_info,
+                                     ms->numa_state->num_nodes, ram_size=
);
             if (!qtest_enabled()) {
                 warn_report("Default splitting of RAM between nodes is d=
eprecated,"
                             " Use '-numa node,memdev' to explictly defin=
e RAM"
@@ -416,7 +424,7 @@ void numa_complete_configuration(MachineState *ms)
         }
=20
         numa_total =3D 0;
-        for (i =3D 0; i < nb_numa_nodes; i++) {
+        for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
             numa_total +=3D numa_info[i].node_mem;
         }
         if (numa_total !=3D ram_size) {
@@ -440,10 +448,10 @@ void numa_complete_configuration(MachineState *ms)
          */
         if (have_numa_distance) {
             /* Validate enough NUMA distance information was provided. *=
/
-            validate_numa_distance();
+            validate_numa_distance(ms);
=20
             /* Validation succeeded, now fill in any missing distances. =
*/
-            complete_init_numa_distance();
+            complete_init_numa_distance(ms);
         }
     }
 }
@@ -510,14 +518,16 @@ void memory_region_allocate_system_memory(MemoryReg=
ion *mr, Object *owner,
 {
     uint64_t addr =3D 0;
     int i;
+    MachineState *ms =3D MACHINE(qdev_get_machine());
=20
-    if (nb_numa_nodes =3D=3D 0 || !have_memdevs) {
+    if (ms->numa_state =3D=3D NULL ||
+        ms->numa_state->num_nodes =3D=3D 0 || !have_memdevs) {
         allocate_system_memory_nonnuma(mr, owner, name, ram_size);
         return;
     }
=20
     memory_region_init(mr, owner, name, ram_size);
-    for (i =3D 0; i < nb_numa_nodes; i++) {
+    for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
         uint64_t size =3D numa_info[i].node_mem;
         HostMemoryBackend *backend =3D numa_info[i].node_memdev;
         if (!backend) {
@@ -575,16 +585,16 @@ static void numa_stat_memory_devices(NumaNodeMem no=
de_mem[])
     qapi_free_MemoryDeviceInfoList(info_list);
 }
=20
-void query_numa_node_mem(NumaNodeMem node_mem[])
+void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms)
 {
     int i;
=20
-    if (nb_numa_nodes <=3D 0) {
+    if (ms->numa_state =3D=3D NULL || ms->numa_state->num_nodes <=3D 0) =
{
         return;
     }
=20
     numa_stat_memory_devices(node_mem);
-    for (i =3D 0; i < nb_numa_nodes; i++) {
+    for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
         node_mem[i].node_mem +=3D numa_info[i].node_mem;
     }
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 034e413fd0..3c5868322b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2696,7 +2696,7 @@ void acpi_build(AcpiBuildTables *tables, MachineSta=
te *machine)
         build_srat(tables_blob, tables->linker, machine);
         if (have_numa_distance) {
             acpi_add_table(table_offsets, tables_blob);
-            build_slit(tables_blob, tables->linker);
+            build_slit(tables_blob, tables->linker, machine);
         }
     }
     if (acpi_get_mcfg(&mcfg)) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c14ed86439..5fba29c10b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1002,6 +1002,8 @@ static FWCfgState *bochs_bios_init(AddressSpace *as=
, PCMachineState *pcms)
     int i;
     const CPUArchIdList *cpus;
     MachineClass *mc =3D MACHINE_GET_CLASS(pcms);
+    MachineState *ms =3D MACHINE(pcms);
+    int nb_numa_nodes =3D ms->numa_state->num_nodes;
=20
     fw_cfg =3D fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4, as=
);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
@@ -1774,12 +1776,13 @@ void pc_machine_done(Notifier *notifier, void *da=
ta)
 void pc_guest_info_init(PCMachineState *pcms)
 {
     int i;
+    MachineState *ms =3D MACHINE(pcms);
=20
     pcms->apic_xrupt_override =3D kvm_allows_irq0_override();
-    pcms->numa_nodes =3D nb_numa_nodes;
+    pcms->numa_nodes =3D ms->numa_state->num_nodes;
     pcms->node_mem =3D g_malloc0(pcms->numa_nodes *
                                     sizeof *pcms->node_mem);
-    for (i =3D 0; i < nb_numa_nodes; i++) {
+    for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
         pcms->node_mem[i] =3D numa_info[i].node_mem;
     }
=20
@@ -2869,7 +2872,7 @@ static int64_t pc_get_default_cpu_node_id(const Mac=
hineState *ms, int idx)
    x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
                             pcms->smp_dies, ms->smp.cores,
                             ms->smp.threads, &topo);
-   return topo.pkg_id % nb_numa_nodes;
+   return topo.pkg_id % ms->numa_state->num_nodes;
 }
=20
 static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 7c324a1329..99e2faf01b 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -172,6 +172,8 @@ static void pc_dimm_realize(DeviceState *dev, Error *=
*errp)
 {
     PCDIMMDevice *dimm =3D PC_DIMM(dev);
     PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    int nb_numa_nodes =3D ms->numa_state->num_nodes;
=20
     if (!dimm->hostmem) {
         error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property is not set"=
);
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expa=
nder_bridge.c
index 06a7c018d7..0592818447 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -21,6 +21,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "sysemu/numa.h"
+#include "hw/boards.h"
=20
 #define TYPE_PXB_BUS "pxb-bus"
 #define PXB_BUS(obj) OBJECT_CHECK(PXBBus, (obj), TYPE_PXB_BUS)
@@ -213,9 +214,15 @@ static void pxb_dev_realize_common(PCIDevice *dev, b=
ool pcie, Error **errp)
     PCIBus *bus;
     const char *dev_name =3D NULL;
     Error *local_err =3D NULL;
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+
+    if (ms->numa_state =3D=3D NULL) {
+        error_setg(errp, "NUMA is not supported by this machine-type");
+        return;
+    }
=20
     if (pxb->numa_node !=3D NUMA_NODE_UNASSIGNED &&
-        pxb->numa_node >=3D nb_numa_nodes) {
+        pxb->numa_node >=3D ms->numa_state->num_nodes) {
         error_setg(errp, "Illegal numa node %d", pxb->numa_node);
         return;
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index baedadf20b..a7eb87feb6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -336,7 +336,7 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachine=
State *spapr)
             return ret;
         }
=20
-        if (nb_numa_nodes > 1) {
+        if (ms->numa_state->num_nodes > 1) {
             ret =3D spapr_fixup_cpu_numa_dt(fdt, offset, cpu);
             if (ret < 0) {
                 return ret;
@@ -356,9 +356,9 @@ static int spapr_fixup_cpu_dt(void *fdt, SpaprMachine=
State *spapr)
=20
 static hwaddr spapr_node0_size(MachineState *machine)
 {
-    if (nb_numa_nodes) {
+    if (machine->numa_state->num_nodes) {
         int i;
-        for (i =3D 0; i < nb_numa_nodes; ++i) {
+        for (i =3D 0; i < machine->numa_state->num_nodes; ++i) {
             if (numa_info[i].node_mem) {
                 return MIN(pow2floor(numa_info[i].node_mem),
                            machine->ram_size);
@@ -403,12 +403,12 @@ static int spapr_populate_memory(SpaprMachineState =
*spapr, void *fdt)
 {
     MachineState *machine =3D MACHINE(spapr);
     hwaddr mem_start, node_size;
-    int i, nb_nodes =3D nb_numa_nodes;
+    int i, nb_nodes =3D machine->numa_state->num_nodes;
     NodeInfo *nodes =3D numa_info;
     NodeInfo ramnode;
=20
     /* No NUMA nodes, assume there is just one node with whole RAM */
-    if (!nb_numa_nodes) {
+    if (!nb_nodes) {
         nb_nodes =3D 1;
         ramnode.node_mem =3D machine->ram_size;
         nodes =3D &ramnode;
@@ -559,7 +559,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
     _FDT((fdt_setprop(fdt, offset, "ibm,pft-size",
                       pft_size_prop, sizeof(pft_size_prop))));
=20
-    if (nb_numa_nodes > 1) {
+    if (ms->numa_state->num_nodes > 1) {
         _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu));
     }
=20
@@ -866,6 +866,7 @@ static int spapr_populate_drmem_v1(SpaprMachineState =
*spapr, void *fdt,
 static int spapr_populate_drconf_memory(SpaprMachineState *spapr, void *=
fdt)
 {
     MachineState *machine =3D MACHINE(spapr);
+    int nb_numa_nodes =3D machine->numa_state->num_nodes;
     int ret, i, offset;
     uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
     uint32_t prop_lmb_size[] =3D {0, cpu_to_be32(lmb_size)};
@@ -1741,7 +1742,7 @@ static void spapr_machine_reset(MachineState *machi=
ne)
      * The final value of spapr->gpu_numa_id is going to be written to
      * max-associativity-domains in spapr_build_fdt().
      */
-    spapr->gpu_numa_id =3D MAX(1, nb_numa_nodes);
+    spapr->gpu_numa_id =3D MAX(1, machine->numa_state->num_nodes);
     qemu_devices_reset();
=20
     /*
@@ -2539,7 +2540,7 @@ static void spapr_validate_node_memory(MachineState=
 *machine, Error **errp)
         return;
     }
=20
-    for (i =3D 0; i < nb_numa_nodes; i++) {
+    for (i =3D 0; i < machine->numa_state->num_nodes; i++) {
         if (numa_info[i].node_mem % SPAPR_MEMORY_BLOCK_SIZE) {
             error_setg(errp,
                        "Node %d memory size 0x%" PRIx64
@@ -4178,7 +4179,7 @@ spapr_cpu_index_to_props(MachineState *machine, uns=
igned cpu_index)
=20
 static int64_t spapr_get_default_cpu_node_id(const MachineState *ms, int=
 idx)
 {
-    return idx / ms->smp.cores % nb_numa_nodes;
+    return idx / ms->smp.cores % ms->numa_state->num_nodes;
 }
=20
 static const CPUArchIdList *spapr_possible_cpu_arch_ids(MachineState *ma=
chine)
--=20
2.21.0


