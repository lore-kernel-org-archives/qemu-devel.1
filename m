Received: from eggs.gnu.org ([2001:4830:134:3::10]:35187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cqzhw-0004ic-Id
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:11:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cqzhq-000698-9h
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:11:04 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 23 Mar 2017 21:10:48 +1100
Message-Id: <20170323101048.24848-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170323101048.24848-1-david@gibson.dropbear.id.au>
References: <20170323101048.24848-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 1/1] numa,
 spapr: align default numa node memory size to 256MB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

Since commit 224245b ("spapr: Add LMB DR connectors"), NUMA node
memory size must be aligned to 256MB (SPAPR_MEMORY_BLOCK_SIZE).

But when "-numa" option is provided without "mem" parameter,
the memory is equally divided between nodes, but 8MB aligned.
This can be not valid for pseries.

In that case we can have:
$ ./ppc64-softmmu/qemu-system-ppc64 -m 4G -numa node -numa node -numa node
qemu-system-ppc64: Node 0 memory size 0x55000000 is not aligned to 256 MiB

With this patch, we have:
(qemu) info numa
3 nodes
node 0 cpus: 0
node 0 size: 1280 MB
node 1 cpus:
node 1 size: 1280 MB
node 2 cpus:
node 2 size: 1536 MB

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/core/machine.c   | 5 +++++
 hw/ppc/spapr.c      | 6 ++++++
 include/hw/boards.h | 1 +
 numa.c              | 6 +++---
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0d92672..ada9eea 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -396,6 +396,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 128 * M_BYTE;
     mc->rom_file_has_mr = true;
 
+    /* numa node memory size aligned on 8MB by default.
+     * On Linux, each node's border has to be 8MB aligned
+     */
+    mc->numa_mem_align_shift = 23;
+
     object_class_property_add_str(oc, "accel",
         machine_get_accel, machine_set_accel, &error_abort);
     object_class_property_set_description(oc, "accel",
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6ee566d..8aecea3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3096,6 +3096,11 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     xic->ics_resend = spapr_ics_resend;
     xic->icp_get = spapr_icp_get;
     ispc->print_info = spapr_pic_print_info;
+    /* Force NUMA node memory size to be a multiple of
+     * SPAPR_MEMORY_BLOCK_SIZE (256M) since that's the granularity
+     * in which LMBs are represented and hot-added
+     */
+    mc->numa_mem_align_shift = 28;
 }
 
 static const TypeInfo spapr_machine_info = {
@@ -3180,6 +3185,7 @@ static void spapr_machine_2_8_class_options(MachineClass *mc)
 {
     spapr_machine_2_9_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_8);
+    mc->numa_mem_align_shift = 23;
 }
 
 DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 269d0ba..31d9c72 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -135,6 +135,7 @@ struct MachineClass {
     bool rom_file_has_mr;
     int minimum_page_bits;
     bool has_hotpluggable_cpus;
+    int numa_mem_align_shift;
 
     HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
                                            DeviceState *dev);
diff --git a/numa.c b/numa.c
index e01cb54..6fc2393 100644
--- a/numa.c
+++ b/numa.c
@@ -338,12 +338,12 @@ void parse_numa_opts(MachineClass *mc)
         if (i == nb_numa_nodes) {
             uint64_t usedmem = 0;
 
-            /* On Linux, each node's border has to be 8MB aligned,
-             * the final node gets the rest.
+            /* Align each node according to the alignment
+             * requirements of the machine class
              */
             for (i = 0; i < nb_numa_nodes - 1; i++) {
                 numa_info[i].node_mem = (ram_size / nb_numa_nodes) &
-                                        ~((1 << 23UL) - 1);
+                                        ~((1 << mc->numa_mem_align_shift) - 1);
                 usedmem += numa_info[i].node_mem;
             }
             numa_info[i].node_mem = ram_size - usedmem;
-- 
2.9.3
