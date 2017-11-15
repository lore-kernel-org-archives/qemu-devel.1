Received: from eggs.gnu.org ([2001:4830:134:3::10]:58981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2HD-0003nx-SP
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eF2H9-0003XN-RL
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:19:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eF2H9-0003WR-Hd
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 13:19:03 -0500
Date: Wed, 15 Nov 2017 20:18:50 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1510769835-31902-9-git-send-email-mst@redhat.com>
References: <1510769835-31902-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510769835-31902-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 08/10] NUMA: Enable adding NUMA node implicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Dou Liyang <douly.fnst@cn.fujitsu.com>, Thadeu Lima de Souza Cascardo <cascardo@canonical.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair23@gmail.com>, Takao Indoh <indou.takao@jp.fujitsu.com>, Izumi Taku <izumi.taku@jp.fujitsu.com>

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

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
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: Izumi Taku <izumi.taku@jp.fujitsu.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/boards.h |  1 +
 hw/i386/pc.c        |  1 +
 hw/i386/pc_piix.c   |  1 +
 hw/i386/pc_q35.c    |  1 +
 numa.c              | 21 ++++++++++++++++++++-
 vl.c                |  3 +--
 6 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 62f160e..156b16f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -197,6 +197,7 @@ struct MachineClass {
     bool ignore_memory_transaction_failures;
     int numa_mem_align_shift;
     const char **valid_cpu_types;
+    bool auto_enable_numa_with_memhp;
     void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
                                  int nb_nodes, ram_addr_t size);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index fafe5ba..c3afe5b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2347,6 +2347,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
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
diff --git a/numa.c b/numa.c
index 8d78d95..7151b24 100644
--- a/numa.c
+++ b/numa.c
@@ -216,6 +216,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
     }
     numa_info[nodenr].present = true;
     max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
+    nb_numa_nodes++;
 }
 
 static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
@@ -282,7 +283,6 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
         if (err) {
             goto end;
         }
-        nb_numa_nodes++;
         break;
     case NUMA_OPTIONS_TYPE_DIST:
         parse_numa_distance(&object->u.dist, &err);
@@ -433,6 +433,25 @@ void parse_numa_opts(MachineState *ms)
         exit(1);
     }
 
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
+    if (ms->ram_slots > 0 && nb_numa_nodes == 0 &&
+        mc->auto_enable_numa_with_memhp) {
+            NumaNodeOptions node = { };
+            parse_numa_node(ms, &node, NULL);
+    }
+
     assert(max_numa_nodeid <= MAX_NODES);
 
     /* No support for sparse NUMA node IDs yet: */
diff --git a/vl.c b/vl.c
index 7372424..1ad1c04 100644
--- a/vl.c
+++ b/vl.c
@@ -4690,8 +4690,6 @@ int main(int argc, char **argv, char **envp)
     default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
     default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
 
-    parse_numa_opts(current_machine);
-
     if (qemu_opts_foreach(qemu_find_opts("mon"),
                           mon_init_func, NULL, NULL)) {
         exit(1);
@@ -4741,6 +4739,7 @@ int main(int argc, char **argv, char **envp)
     current_machine->boot_order = boot_order;
     current_machine->cpu_model = cpu_model;
 
+    parse_numa_opts(current_machine);
 
     /* parse features once if machine provides default cpu_type */
     if (machine_class->default_cpu_type) {
-- 
MST
