Received: from eggs.gnu.org ([2001:4830:134:3::10]:55042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e6Rd1-0002Ko-7Q
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 21:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e6Rcx-0007XJ-BU
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 21:34:07 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:4851
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e6Rcw-0007UJ-EY
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 21:34:03 -0400
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Mon, 23 Oct 2017 09:33:42 +0800
Message-ID: <1508722422-3861-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4] NUMA: Enable adding NUMA node implicitly
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
changelog V3 --> V4:
  -Move the parse_numa_opts behind the setup of current_machine
   for safety suggested by Igor
 hw/i386/pc.c          |  1 +
 hw/i386/pc_piix.c     |  1 +
 hw/i386/pc_q35.c      |  1 +
 include/hw/boards.h   |  1 +
 include/sysemu/numa.h |  2 +-
 numa.c                | 24 ++++++++++++++++++++++--
 vl.c                  |  3 +--
 7 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8e307f7..ec4eb97 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2325,6 +2325,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
     mc->get_default_cpu_node_id = pc_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
+    mc->auto_enable_numa_with_memhp = true;
     mc->has_hotpluggable_cpus = true;
     mc->default_boot_order = "cad";
     mc->hot_add_cpu = pc_hot_add_cpu;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index f79d5cb..5e47528 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -446,6 +446,7 @@ static void pc_i440fx_2_10_machine_options(MachineClass *m)
     m->is_default = 0;
     m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
+    m->auto_enable_numa_with_memhp = false;
 }
 
 DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index da3ea60..d606004 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -318,6 +318,7 @@ static void pc_q35_2_10_machine_options(MachineClass *m)
     m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
     m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
+    m->auto_enable_numa_with_memhp = false;
 }
 
 DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 191a5b3..f1077f1 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -192,6 +192,7 @@ struct MachineClass {
     bool ignore_memory_transaction_failures;
     int numa_mem_align_shift;
     const char **valid_cpu_types;
+    bool auto_enable_numa_with_memhp;
     void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
                                  int nb_nodes, ram_addr_t size);
 
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 5c6df28..31d3ac0 100644
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
diff --git a/numa.c b/numa.c
index 100a67f..ba8d813 100644
--- a/numa.c
+++ b/numa.c
@@ -423,12 +423,32 @@ void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
     nodes[i].node_mem = size - usedmem;
 }
 
-void parse_numa_opts(MachineState *ms)
+void parse_numa_opts(MachineState *ms, uint64_t ram_slots)
 {
     int i;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
+    QemuOptsList *numa_opts = qemu_find_opts("numa");
 
-    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL)) {
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
+     * Enable NUMA implicitly by adding a new NUMA node automatically.
+     */
+    if (ram_slots > 0 && QTAILQ_EMPTY(&numa_opts->head)) {
+        if (mc->auto_enable_numa_with_memhp) {
+            qemu_opts_parse_noisily(numa_opts, "node", true);
+        }
+    }
+
+    if (qemu_opts_foreach(numa_opts, parse_numa, ms, NULL)) {
         exit(1);
     }
 
diff --git a/vl.c b/vl.c
index 0723835..516d0c9 100644
--- a/vl.c
+++ b/vl.c
@@ -4677,8 +4677,6 @@ int main(int argc, char **argv, char **envp)
     default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
     default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
 
-    parse_numa_opts(current_machine);
-
     if (qemu_opts_foreach(qemu_find_opts("mon"),
                           mon_init_func, NULL, NULL)) {
         exit(1);
@@ -4728,6 +4726,7 @@ int main(int argc, char **argv, char **envp)
     current_machine->boot_order = boot_order;
     current_machine->cpu_model = cpu_model;
 
+    parse_numa_opts(current_machine, ram_slots);
 
     /* parse features once if machine provides default cpu_type */
     if (machine_class->default_cpu_type) {
-- 
2.5.5
