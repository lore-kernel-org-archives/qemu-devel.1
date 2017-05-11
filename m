Received: from eggs.gnu.org ([2001:4830:134:3::10]:37743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tc0-0002HL-07
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d8tby-0007ku-B1
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:18:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d8tby-0007kg-1v
	for qemu-devel@nongnu.org; Thu, 11 May 2017 15:18:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 11 May 2017 16:18:17 -0300
Message-Id: <20170511191843.13784-4-ehabkost@redhat.com>
In-Reply-To: <20170511191843.13784-1-ehabkost@redhat.com>
References: <20170511191843.13784-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 03/29] numa: equally distribute memory on nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>

From: Laurent Vivier <lvivier@redhat.com>

When there are more nodes than available memory to put the minimum
allowed memory by node, all the memory is put on the last node.

This is because we put (ram_size / nb_numa_nodes) &
~((1 << mc->numa_mem_align_shift) - 1); on each node, and in this
case the value is 0. This is particularly true with pseries,
as the memory must be aligned to 256MB.

To avoid this problem, this patch uses an error diffusion algorithm [1]
to distribute equally the memory on nodes.

We introduce numa_auto_assign_ram() function in MachineClass
to keep compatibility between machine type versions.
The legacy function is used with pseries-2.9, pc-q35-2.9 and
pc-i440fx-2.9 (and previous), the new one with all others.

Example:

qemu-system-ppc64 -S -nographic  -nodefaults -monitor stdio -m 1G -smp 8 \
                  -numa node -numa node -numa node \
                  -numa node -numa node -numa node

Before:

(qemu) info numa
6 nodes
node 0 cpus: 0 6
node 0 size: 0 MB
node 1 cpus: 1 7
node 1 size: 0 MB
node 2 cpus: 2
node 2 size: 0 MB
node 3 cpus: 3
node 3 size: 0 MB
node 4 cpus: 4
node 4 size: 0 MB
node 5 cpus: 5
node 5 size: 1024 MB

After:
(qemu) info numa
6 nodes
node 0 cpus: 0 6
node 0 size: 0 MB
node 1 cpus: 1 7
node 1 size: 256 MB
node 2 cpus: 2
node 2 size: 0 MB
node 3 cpus: 3
node 3 size: 256 MB
node 4 cpus: 4
node 4 size: 256 MB
node 5 cpus: 5
node 5 size: 256 MB

[1] https://en.wikipedia.org/wiki/Error_diffusion

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20170502162955.1610-2-lvivier@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
[ehabkost: s/ram_size/size/ at numa_default_auto_assign_ram()]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h     |  2 ++
 include/qemu/typedefs.h |  1 +
 include/sysemu/numa.h   |  9 +++++++--
 hw/core/machine.c       |  2 ++
 hw/i386/pc_piix.c       |  2 ++
 hw/i386/pc_q35.c        |  2 ++
 hw/ppc/spapr.c          |  1 +
 numa.c                  | 49 ++++++++++++++++++++++++++++++++++++++-----------
 8 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 31d9c72fb0..99458eb859 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -136,6 +136,8 @@ struct MachineClass {
     int minimum_page_bits;
     bool has_hotpluggable_cpus;
     int numa_mem_align_shift;
+    void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
+                                 int nb_nodes, ram_addr_t size);
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index f08d327aec..7d8505730c 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -97,5 +97,6 @@ typedef struct SSIBus SSIBus;
 typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
+typedef struct node_info NodeInfo;
 
 #endif /* QEMU_TYPEDEFS_H */
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 0ea1bc086e..70e56214e5 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -16,14 +16,14 @@ struct numa_addr_range {
     QLIST_ENTRY(numa_addr_range) entry;
 };
 
-typedef struct node_info {
+struct node_info {
     uint64_t node_mem;
     unsigned long *node_cpu;
     struct HostMemoryBackend *node_memdev;
     bool present;
     QLIST_HEAD(, numa_addr_range) addr; /* List to store address ranges */
     uint8_t distance[MAX_NODES];
-} NodeInfo;
+};
 
 extern NodeInfo numa_info[MAX_NODES];
 void parse_numa_opts(MachineClass *mc);
@@ -33,6 +33,11 @@ extern QemuOptsList qemu_numa_opts;
 void numa_set_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
 void numa_unset_mem_node_id(ram_addr_t addr, uint64_t size, uint32_t node);
 uint32_t numa_get_node(ram_addr_t addr, Error **errp);
+void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
+                                 int nb_nodes, ram_addr_t size);
+void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
+                                  int nb_nodes, ram_addr_t size);
+
 
 /* on success returns node index in numa_info,
  * on failure returns nb_numa_nodes */
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ada9eea483..2482c630c1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -17,6 +17,7 @@
 #include "qapi/visitor.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/numa.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 
@@ -400,6 +401,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
      * On Linux, each node's border has to be 8MB aligned
      */
     mc->numa_mem_align_shift = 23;
+    mc->numa_auto_assign_ram = numa_default_auto_assign_ram;
 
     object_class_property_add_str(oc, "accel",
         machine_get_accel, machine_set_accel, &error_abort);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9f102aa388..d468b963fb 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -54,6 +54,7 @@
 #endif
 #include "migration/migration.h"
 #include "kvm_i386.h"
+#include "sysemu/numa.h"
 
 #define MAX_IDE_BUS 2
 
@@ -442,6 +443,7 @@ static void pc_i440fx_2_9_machine_options(MachineClass *m)
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
+    m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
 }
 
 DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index dd792a8547..66303a78cf 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -47,6 +47,7 @@
 #include "hw/usb.h"
 #include "qemu/error-report.h"
 #include "migration/migration.h"
+#include "sysemu/numa.h"
 
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
@@ -305,6 +306,7 @@ static void pc_q35_2_9_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
+    m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
 }
 
 DEFINE_Q35_MACHINE(v2_9, "pc-q35-2.9", NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 80d12d005c..bdc31ce56c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3242,6 +3242,7 @@ static void spapr_machine_2_9_class_options(MachineClass *mc)
 {
     spapr_machine_2_10_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
+    mc->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
 }
 
 DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
diff --git a/numa.c b/numa.c
index 2b3fc69915..d753687dec 100644
--- a/numa.c
+++ b/numa.c
@@ -407,6 +407,42 @@ static void complete_init_numa_distance(void)
     }
 }
 
+void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
+                                 int nb_nodes, ram_addr_t size)
+{
+    int i;
+    uint64_t usedmem = 0;
+
+    /* Align each node according to the alignment
+     * requirements of the machine class
+     */
+
+    for (i = 0; i < nb_nodes - 1; i++) {
+        nodes[i].node_mem = (size / nb_nodes) &
+                            ~((1 << mc->numa_mem_align_shift) - 1);
+        usedmem += nodes[i].node_mem;
+    }
+    nodes[i].node_mem = size - usedmem;
+}
+
+void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
+                                  int nb_nodes, ram_addr_t size)
+{
+    int i;
+    uint64_t usedmem = 0, node_mem;
+    uint64_t granularity = size / nb_nodes;
+    uint64_t propagate = 0;
+
+    for (i = 0; i < nb_nodes - 1; i++) {
+        node_mem = (granularity + propagate) &
+                   ~((1 << mc->numa_mem_align_shift) - 1);
+        propagate = granularity + propagate - node_mem;
+        nodes[i].node_mem = node_mem;
+        usedmem += node_mem;
+    }
+    nodes[i].node_mem = size - usedmem;
+}
+
 void parse_numa_opts(MachineClass *mc)
 {
     int i;
@@ -449,17 +485,8 @@ void parse_numa_opts(MachineClass *mc)
             }
         }
         if (i == nb_numa_nodes) {
-            uint64_t usedmem = 0;
-
-            /* Align each node according to the alignment
-             * requirements of the machine class
-             */
-            for (i = 0; i < nb_numa_nodes - 1; i++) {
-                numa_info[i].node_mem = (ram_size / nb_numa_nodes) &
-                                        ~((1 << mc->numa_mem_align_shift) - 1);
-                usedmem += numa_info[i].node_mem;
-            }
-            numa_info[i].node_mem = ram_size - usedmem;
+            assert(mc->numa_auto_assign_ram);
+            mc->numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram_size);
         }
 
         numa_total = 0;
-- 
2.11.0.259.g40922b1
