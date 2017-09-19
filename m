Received: from eggs.gnu.org ([2001:4830:134:3::10]:43169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1du8sx-0006x7-UC
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 23:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1du8su-0001Ce-Nb
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 23:07:43 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:57741
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1du8st-0001Bp-Tb
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 23:07:40 -0400
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Tue, 19 Sep 2017 11:07:02 +0800
Message-ID: <1505790422-22272-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] NUMA: Enable adding NUMA node implicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair23@gmail.com>, f4bug@amsat.org, Takao Indoh <indou.takao@jp.fujitsu.com>, Izumi Taku <izumi.taku@jp.fujitsu.com>

Linux and Windows need ACPI SRAT table to make memory hotplug work properly,
however currently QEMU doesn't create SRAT table if numa options aren't present
on CLI.

Which breaks both linux and windows guests in certain conditions:
 * Windows: won't enable memory hotplug without SRAT table at all
 * Linux: if QEMU is started with initial memory all below 4Gb and no SRAT table
   present, guest kernel will use nommu DMA ops, which breaks 32bit hw drivers
   when memory is hotplugged and guest tries to use it with that drivers.

Fix above issues by automatically creating a numa node when QEMU is started with
memory hotplug enabled but without '-numa' options on CLI. 
(PS: auto-create numa node only for new machine types so not to break migration).

Which would provide SRAT table to guests without explicit -numa options on CLI
and would allow:
 * Windows: to enable memory hotplug
 * Linux: switch to SWIOTLB DMA ops, to bounce DMA transfers to 32bit allocated
   buffers that legacy drivers/hw can handle.

[Rewritten by Igor]

Reported-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>
Cc: f4bug@amsat.org
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: Izumi Taku <izumi.taku@jp.fujitsu.com>
---
changelog V1 --> V2:
  -Move the logic from vl.c to numa.c suggested by Igor
  -Fix the guest ABI problem reported by Daniel
  -make the function name more understandable

 hw/i386/pc.c          |  1 +
 hw/i386/pc_piix.c     |  1 +
 hw/i386/pc_q35.c      |  1 +
 include/hw/boards.h   |  4 ++++
 include/sysemu/numa.h |  3 ++-
 numa.c                | 29 +++++++++++++++++++++++++++--
 vl.c                  |  9 +++++----
 7 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2108104..7a753ee 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2349,6 +2349,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->get_hotplug_handler = pc_get_hotpug_handler;
     mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
     mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
+    mc->add_numa_node_implicitly = numa_add_node_implicitly;
     mc->has_hotpluggable_cpus = true;
     mc->default_boot_order = "cad";
     mc->hot_add_cpu = pc_hot_add_cpu;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index b03cc04..cc94334 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -452,6 +452,7 @@ static void pc_i440fx_2_10_machine_options(MachineClass *m)
     m->is_default = 0;
     m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
+    m->add_numa_node_implicitly = NULL;
 }
 
 DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index c1cba58..7329819 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -317,6 +317,7 @@ static void pc_q35_2_10_machine_options(MachineClass *m)
     m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
     m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
+    m->add_numa_node_implicitly = NULL;
 }
 
 DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 7f044d1..c8c4f25 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -141,6 +141,8 @@ typedef struct {
  *    should instead use "unimplemented-device" for all memory ranges where
  *    the guest will attempt to probe for a device that QEMU doesn't
  *    implement and a stub device is required.
+ * @add_numa_node_implicitly:
+ *    Enable NUMA implicitly by add a new NUMA node automatically.
  */
 struct MachineClass {
     /*< private >*/
@@ -191,6 +193,8 @@ struct MachineClass {
     CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *machine,
                                                          unsigned cpu_index);
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
+
+    void (*add_numa_node_implicitly)(QemuOptsList *list);
 };
 
 /**
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 5c6df28..1660249 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -30,7 +30,7 @@ struct NumaNodeMem {
 };
 
 extern NodeInfo numa_info[MAX_NODES];
-void parse_numa_opts(MachineState *ms);
+void parse_numa_opts(MachineState *ms, uint64_t ram_slots);
 void query_numa_node_mem(NumaNodeMem node_mem[]);
 extern QemuOptsList qemu_numa_opts;
 void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
@@ -41,4 +41,5 @@ void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
 void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
                                   int nb_nodes, ram_addr_t size);
 void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp);
+void numa_add_node_implicitly(QemuOptsList *list);
 #endif
diff --git a/numa.c b/numa.c
index fe066ad..470204d 100644
--- a/numa.c
+++ b/numa.c
@@ -423,12 +423,37 @@ void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
     nodes[i].node_mem = size - usedmem;
 }
 
-void parse_numa_opts(MachineState *ms)
+void numa_add_node_implicitly(QemuOptsList *list)
+{
+    qemu_opts_parse_noisily(list, "node", true);
+}
+
+void parse_numa_opts(MachineState *ms, uint64_t ram_slots)
 {
     int i;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
+    QemuOptsList *numa_opts = qemu_find_opts("numa");
+
+    /*
+     * If memory hotplug is enabled (slots > 0) but without '-numa'
+     * options explicitly on CLI, guestes will break.
+     *
+     *   Windows: won't enable memory hotplug without SRAT table at all
+     *
+     *   Linux: if QEMU is started with initial memory all below 4Gb
+     *   and no SRAT table present, guest kernel will use nommu DMA ops,
+     *   which breaks 32bit hw drivers when memory is hotplugged and
+     *   guest tries to use it with that drivers.
+     *
+     * Enable NUMA implicitly by adding a new NUMA node manually.
+     */
+    if (ram_slots > 0 && numa_opts->head.tqh_first == NULL) {
+        if (mc->add_numa_node_implicitly) {
+            mc->add_numa_node_implicitly(numa_opts);
+        }
+    }
 
-    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL)) {
+    if (qemu_opts_foreach(numa_opts, parse_numa, ms, NULL)) {
         exit(1);
     }
 
diff --git a/vl.c b/vl.c
index 9e62e92..1bd8eaf 100644
--- a/vl.c
+++ b/vl.c
@@ -4665,7 +4665,11 @@ int main(int argc, char **argv, char **envp)
     default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
     default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
 
-    parse_numa_opts(current_machine);
+    current_machine->ram_size = ram_size;
+    current_machine->maxram_size = maxram_size;
+    current_machine->ram_slots = ram_slots;
+
+    parse_numa_opts(current_machine, ram_slots);
 
     if (qemu_opts_foreach(qemu_find_opts("mon"),
                           mon_init_func, NULL, NULL)) {
@@ -4710,9 +4714,6 @@ int main(int argc, char **argv, char **envp)
     replay_checkpoint(CHECKPOINT_INIT);
     qdev_machine_init();
 
-    current_machine->ram_size = ram_size;
-    current_machine->maxram_size = maxram_size;
-    current_machine->ram_slots = ram_slots;
     current_machine->boot_order = boot_order;
     current_machine->cpu_model = cpu_model;
 
-- 
2.5.5
