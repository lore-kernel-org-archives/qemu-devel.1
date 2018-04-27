Received: from eggs.gnu.org ([2001:4830:134:3::10]:60174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzb7-0002m5-OY
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzb5-0002X8-U1
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:23:21 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:23 +1000
Message-Id: <20180427092126.24812-47-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 46/49] spapr: Support ibm,
 dynamic-memory-v2 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

The new property ibm,dynamic-memory-v2 allows memory to be represented
in a more compact manner in device tree.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 docs/specs/ppc-spapr-hotplug.txt |  19 ++++
 hw/ppc/spapr.c                   | 230 +++++++++++++++++++++++++++++++--------
 include/hw/ppc/spapr_ovec.h      |   1 +
 3 files changed, 202 insertions(+), 48 deletions(-)

diff --git a/docs/specs/ppc-spapr-hotplug.txt b/docs/specs/ppc-spapr-hotplug.txt
index f57e2a09c6..cc7833108e 100644
--- a/docs/specs/ppc-spapr-hotplug.txt
+++ b/docs/specs/ppc-spapr-hotplug.txt
@@ -387,4 +387,23 @@ Each LMB list entry consists of the following elements:
 - A 32bit flags word. The bit at bit position 0x00000008 defines whether
   the LMB is assigned to the the partition as of boot time.
 
+ibm,dynamic-memory-v2
+
+This property describes the dynamically reconfigurable memory. This is
+an alternate and newer way to describe dyanamically reconfigurable memory.
+It is a property encoded array that has an integer N (the number of
+LMB set entries) followed by N LMB set entries. There is an LMB set entry
+for each sequential group of LMBs that share common attributes.
+
+Each LMB set entry consists of the following elements:
+
+- Number of sequential LMBs in the entry represented by a 32bit integer.
+- Logical address of the first LMB in the set encoded as a 64bit integer.
+- DRC index of the first LMB in the set.
+- Associativity list index that is used as an index into
+  ibm,associativity-lookup-arrays property described earlier. This
+  is used to retrieve the right associativity list to be used for all
+  the LMBs in this set.
+- A 32bit flags word that applies to all the LMBs in the set.
+
 [1] http://thread.gmane.org/gmane.linux.ports.ppc.embedded/75350/focus=106867
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2203b6f46d..b35aff5d81 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -668,63 +668,137 @@ static uint32_t spapr_pc_dimm_node(MemoryDeviceInfoList *list, ram_addr_t addr)
     return -1;
 }
 
-/*
- * Adds ibm,dynamic-reconfiguration-memory node.
- * Refer to docs/specs/ppc-spapr-hotplug.txt for the documentation
- * of this device tree node.
- */
-static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *fdt)
+struct sPAPRDrconfCellV2 {
+     uint32_t seq_lmbs;
+     uint64_t base_addr;
+     uint32_t drc_index;
+     uint32_t aa_index;
+     uint32_t flags;
+} QEMU_PACKED;
+
+typedef struct DrconfCellQueue {
+    struct sPAPRDrconfCellV2 cell;
+    QSIMPLEQ_ENTRY(DrconfCellQueue) entry;
+} DrconfCellQueue;
+
+static DrconfCellQueue *
+spapr_get_drconf_cell(uint32_t seq_lmbs, uint64_t base_addr,
+                      uint32_t drc_index, uint32_t aa_index,
+                      uint32_t flags)
 {
-    MachineState *machine = MACHINE(spapr);
-    int ret, i, offset;
-    uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
-    uint32_t prop_lmb_size[] = {0, cpu_to_be32(lmb_size)};
-    uint32_t hotplug_lmb_start = spapr->hotplug_memory.base / lmb_size;
-    uint32_t nr_lmbs = (spapr->hotplug_memory.base +
-                       memory_region_size(&spapr->hotplug_memory.mr)) /
-                       lmb_size;
-    uint32_t *int_buf, *cur_index, buf_len;
-    int nr_nodes = nb_numa_nodes ? nb_numa_nodes : 1;
-    MemoryDeviceInfoList *dimms = NULL;
+    DrconfCellQueue *elem;
 
-    /*
-     * Don't create the node if there is no hotpluggable memory
-     */
-    if (machine->ram_size == machine->maxram_size) {
-        return 0;
-    }
+    elem = g_malloc0(sizeof(*elem));
+    elem->cell.seq_lmbs = cpu_to_be32(seq_lmbs);
+    elem->cell.base_addr = cpu_to_be64(base_addr);
+    elem->cell.drc_index = cpu_to_be32(drc_index);
+    elem->cell.aa_index = cpu_to_be32(aa_index);
+    elem->cell.flags = cpu_to_be32(flags);
 
-    /*
-     * Allocate enough buffer size to fit in ibm,dynamic-memory
-     * or ibm,associativity-lookup-arrays
-     */
-    buf_len = MAX(nr_lmbs * SPAPR_DR_LMB_LIST_ENTRY_SIZE + 1, nr_nodes * 4 + 2)
-              * sizeof(uint32_t);
-    cur_index = int_buf = g_malloc0(buf_len);
+    return elem;
+}
 
-    offset = fdt_add_subnode(fdt, 0, "ibm,dynamic-reconfiguration-memory");
+/* ibm,dynamic-memory-v2 */
+static int spapr_populate_drmem_v2(sPAPRMachineState *spapr, void *fdt,
+                                   int offset, MemoryDeviceInfoList *dimms)
+{
+    uint8_t *int_buf, *cur_index, buf_len;
+    int ret;
+    uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
+    uint64_t addr, cur_addr, size;
+    uint32_t nr_boot_lmbs = (spapr->hotplug_memory.base / lmb_size);
+    uint64_t mem_end = spapr->hotplug_memory.base +
+                       memory_region_size(&spapr->hotplug_memory.mr);
+    uint32_t node, nr_entries = 0;
+    sPAPRDRConnector *drc;
+    DrconfCellQueue *elem, *next;
+    MemoryDeviceInfoList *info;
+    QSIMPLEQ_HEAD(, DrconfCellQueue) drconf_queue
+        = QSIMPLEQ_HEAD_INITIALIZER(drconf_queue);
+
+    /* Entry to cover RAM and the gap area */
+    elem = spapr_get_drconf_cell(nr_boot_lmbs, 0, 0, -1,
+                                 SPAPR_LMB_FLAGS_RESERVED |
+                                 SPAPR_LMB_FLAGS_DRC_INVALID);
+    QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
+    nr_entries++;
+
+    cur_addr = spapr->hotplug_memory.base;
+    for (info = dimms; info; info = info->next) {
+        PCDIMMDeviceInfo *di = info->value->u.dimm.data;
+
+        addr = di->addr;
+        size = di->size;
+        node = di->node;
+
+        /* Entry for hot-pluggable area */
+        if (cur_addr < addr) {
+            drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, cur_addr / lmb_size);
+            g_assert(drc);
+            elem = spapr_get_drconf_cell((addr - cur_addr) / lmb_size,
+                                         cur_addr, spapr_drc_index(drc), -1, 0);
+            QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
+            nr_entries++;
+        }
 
-    ret = fdt_setprop(fdt, offset, "ibm,lmb-size", prop_lmb_size,
-                    sizeof(prop_lmb_size));
-    if (ret < 0) {
-        goto out;
+        /* Entry for DIMM */
+        drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
+        g_assert(drc);
+        elem = spapr_get_drconf_cell(size / lmb_size, addr,
+                                     spapr_drc_index(drc), node,
+                                     SPAPR_LMB_FLAGS_ASSIGNED);
+        QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
+        nr_entries++;
+        cur_addr = addr + size;
     }
 
-    ret = fdt_setprop_cell(fdt, offset, "ibm,memory-flags-mask", 0xff);
-    if (ret < 0) {
-        goto out;
+    /* Entry for remaining hotpluggable area */
+    if (cur_addr < mem_end) {
+        drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, cur_addr / lmb_size);
+        g_assert(drc);
+        elem = spapr_get_drconf_cell((mem_end - cur_addr) / lmb_size,
+                                     cur_addr, spapr_drc_index(drc), -1, 0);
+        QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
+        nr_entries++;
     }
 
-    ret = fdt_setprop_cell(fdt, offset, "ibm,memory-preservation-time", 0x0);
-    if (ret < 0) {
-        goto out;
+    buf_len = nr_entries * sizeof(struct sPAPRDrconfCellV2) + sizeof(uint32_t);
+    int_buf = cur_index = g_malloc0(buf_len);
+    *(uint32_t *)int_buf = cpu_to_be32(nr_entries);
+    cur_index += sizeof(nr_entries);
+
+    QSIMPLEQ_FOREACH_SAFE(elem, &drconf_queue, entry, next) {
+        memcpy(cur_index, &elem->cell, sizeof(elem->cell));
+        cur_index += sizeof(elem->cell);
+        QSIMPLEQ_REMOVE(&drconf_queue, elem, DrconfCellQueue, entry);
+        g_free(elem);
     }
 
-    if (hotplug_lmb_start) {
-        dimms = qmp_pc_dimm_device_list();
+    ret = fdt_setprop(fdt, offset, "ibm,dynamic-memory-v2", int_buf, buf_len);
+    g_free(int_buf);
+    if (ret < 0) {
+        return -1;
     }
+    return 0;
+}
+
+/* ibm,dynamic-memory */
+static int spapr_populate_drmem_v1(sPAPRMachineState *spapr, void *fdt,
+                                   int offset, MemoryDeviceInfoList *dimms)
+{
+    int i, ret;
+    uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
+    uint32_t hotplug_lmb_start = spapr->hotplug_memory.base / lmb_size;
+    uint32_t nr_lmbs = (spapr->hotplug_memory.base +
+                       memory_region_size(&spapr->hotplug_memory.mr)) /
+                       lmb_size;
+    uint32_t *int_buf, *cur_index, buf_len;
 
-    /* ibm,dynamic-memory */
+    /*
+     * Allocate enough buffer size to fit in ibm,dynamic-memory
+     */
+    buf_len = (nr_lmbs * SPAPR_DR_LMB_LIST_ENTRY_SIZE + 1) * sizeof(uint32_t);
+    cur_index = int_buf = g_malloc0(buf_len);
     int_buf[0] = cpu_to_be32(nr_lmbs);
     cur_index++;
     for (i = 0; i < nr_lmbs; i++) {
@@ -764,13 +838,71 @@ static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *fdt)
 
         cur_index += SPAPR_DR_LMB_LIST_ENTRY_SIZE;
     }
-    qapi_free_MemoryDeviceInfoList(dimms);
     ret = fdt_setprop(fdt, offset, "ibm,dynamic-memory", int_buf, buf_len);
+    g_free(int_buf);
     if (ret < 0) {
-        goto out;
+        return -1;
+    }
+    return 0;
+}
+
+/*
+ * Adds ibm,dynamic-reconfiguration-memory node.
+ * Refer to docs/specs/ppc-spapr-hotplug.txt for the documentation
+ * of this device tree node.
+ */
+static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *fdt)
+{
+    MachineState *machine = MACHINE(spapr);
+    int ret, i, offset;
+    uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
+    uint32_t prop_lmb_size[] = {0, cpu_to_be32(lmb_size)};
+    uint32_t *int_buf, *cur_index, buf_len;
+    int nr_nodes = nb_numa_nodes ? nb_numa_nodes : 1;
+    MemoryDeviceInfoList *dimms = NULL;
+
+    /*
+     * Don't create the node if there is no hotpluggable memory
+     */
+    if (machine->ram_size == machine->maxram_size) {
+        return 0;
+    }
+
+    offset = fdt_add_subnode(fdt, 0, "ibm,dynamic-reconfiguration-memory");
+
+    ret = fdt_setprop(fdt, offset, "ibm,lmb-size", prop_lmb_size,
+                    sizeof(prop_lmb_size));
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = fdt_setprop_cell(fdt, offset, "ibm,memory-flags-mask", 0xff);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = fdt_setprop_cell(fdt, offset, "ibm,memory-preservation-time", 0x0);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /* ibm,dynamic-memory or ibm,dynamic-memory-v2 */
+    dimms = qmp_pc_dimm_device_list();
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_DRMEM_V2)) {
+        ret = spapr_populate_drmem_v2(spapr, fdt, offset, dimms);
+    } else {
+        ret = spapr_populate_drmem_v1(spapr, fdt, offset, dimms);
+    }
+    qapi_free_MemoryDeviceInfoList(dimms);
+
+    if (ret < 0) {
+        return ret;
     }
 
     /* ibm,associativity-lookup-arrays */
+    buf_len = (nr_nodes * 4 + 2) * sizeof(uint32_t);
+    cur_index = int_buf = g_malloc0(buf_len);
+
     cur_index = int_buf;
     int_buf[0] = cpu_to_be32(nr_nodes);
     int_buf[1] = cpu_to_be32(4); /* Number of entries per associativity list */
@@ -787,8 +919,8 @@ static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *fdt)
     }
     ret = fdt_setprop(fdt, offset, "ibm,associativity-lookup-arrays", int_buf,
             (cur_index - int_buf) * sizeof(uint32_t));
-out:
     g_free(int_buf);
+
     return ret;
 }
 
@@ -2491,6 +2623,9 @@ static void spapr_machine_init(MachineState *machine)
         spapr_ovec_set(spapr->ov5, OV5_HPT_RESIZE);
     }
 
+    /* advertise support for ibm,dyamic-memory-v2 */
+    spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
+
     /* init CPUs */
     spapr_init_cpus(spapr);
 
@@ -2918,7 +3053,6 @@ static void spapr_instance_init(Object *obj)
                                     " place of standard EPOW events when possible"
                                     " (required for memory hot-unplug support)",
                                     NULL);
-
     ppc_compat_add_property(obj, "max-cpu-compat", &spapr->max_compat_pvr,
                             "Maximum permitted CPU compatibility mode",
                             &error_fatal);
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index bf25e5d954..0f2d8d715d 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -51,6 +51,7 @@ typedef struct sPAPROptionVector sPAPROptionVector;
 #define OV5_FORM1_AFFINITY      OV_BIT(5, 0)
 #define OV5_HP_EVT              OV_BIT(6, 5)
 #define OV5_HPT_RESIZE          OV_BIT(6, 7)
+#define OV5_DRMEM_V2            OV_BIT(22, 0)
 #define OV5_XIVE_BOTH           OV_BIT(23, 0)
 #define OV5_XIVE_EXPLOIT        OV_BIT(23, 1) /* 1=exploitation 0=legacy */
 
-- 
2.14.3
