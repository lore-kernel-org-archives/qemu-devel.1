Received: from eggs.gnu.org ([2001:4830:134:3::10]:43003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1enfAW-0004lR-OI
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1enfAT-0001eS-Vh
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:43:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38558
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1enfAT-0001e6-Py
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:43:17 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1J6d7Er028404
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 01:43:17 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g7ppkmx2f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 01:43:16 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 06:43:14 -0000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 12:12:54 +0530
In-Reply-To: <1519022574-6817-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1519022574-6817-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1519022574-6817-3-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v0 2/2] spapr: Support ibm,
 dynamic-memory-v2 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, imammedo@redhat.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

The new property ibm,dynamic-memory-v2 allows memory to be represented
in a more compact manner in device tree.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 docs/specs/ppc-spapr-hotplug.txt |  19 +++
 hw/ppc/spapr.c                   | 254 +++++++++++++++++++++++++++++++++------
 include/hw/ppc/spapr.h           |   1 +
 include/hw/ppc/spapr_ovec.h      |   1 +
 4 files changed, 235 insertions(+), 40 deletions(-)

diff --git a/docs/specs/ppc-spapr-hotplug.txt b/docs/specs/ppc-spapr-hotplug.txt
index f57e2a0..cc78331 100644
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
index 83c9d66..e45d127 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -678,64 +678,148 @@ static uint32_t spapr_pc_dimm_node(MemoryDeviceInfoList *list, ram_addr_t addr)
     return -1;
 }
 
-/*
- * Adds ibm,dynamic-reconfiguration-memory node.
- * Refer to docs/specs/ppc-spapr-hotplug.txt for the documentation
- * of this device tree node.
- */
-static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *fdt)
+struct of_drconf_cell_v2 {
+     uint32_t seq_lmbs;
+     uint64_t base_addr;
+     uint32_t drc_index;
+     uint32_t aa_index;
+     uint32_t flags;
+} __attribute__((packed));
+
+#define SPAPR_DRCONF_CELL_SIZE 6
+
+/* ibm,dynamic-memory-v2 */
+static int spapr_populate_drmem_v2(sPAPRMachineState *spapr, void *fdt,
+                                   int offset)
 {
-    MachineState *machine = MACHINE(spapr);
-    int ret, i, offset;
-    uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
-    uint32_t prop_lmb_size[] = {0, cpu_to_be32(lmb_size)};
-    uint32_t hotplug_lmb_start = spapr->hotplug_memory.base / lmb_size;
-    uint32_t nr_lmbs = (spapr->hotplug_memory.base +
-                       memory_region_size(&spapr->hotplug_memory.mr)) /
-                       lmb_size;
     uint32_t *int_buf, *cur_index, buf_len;
-    int nr_nodes = nb_numa_nodes ? nb_numa_nodes : 1;
-    MemoryDeviceInfoList *dimms = NULL;
+    int ret;
+    uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
+    uint64_t addr, cur_addr, size;
+    uint32_t nr_boot_lmbs = (spapr->hotplug_memory.base / lmb_size);
+    uint64_t mem_end = spapr->hotplug_memory.base +
+                       memory_region_size(&spapr->hotplug_memory.mr);
+    uint32_t node, nr_entries = 0;
+    sPAPRDRConnector *drc;
+    GSList *list = NULL, *item;
+    typedef struct drconf_cell_queue {
+        struct of_drconf_cell_v2 cell;
+        QSIMPLEQ_ENTRY(drconf_cell_queue) entry;
+    } drconf_cell_queue;
+    QSIMPLEQ_HEAD(, drconf_cell_queue) drconf_queue
+        = QSIMPLEQ_HEAD_INITIALIZER(drconf_queue);
+    drconf_cell_queue *elem, *next;
+
+    /* Entry to cover RAM and the gap area */
+    elem = g_malloc0(sizeof(drconf_cell_queue));
+    elem->cell.seq_lmbs = cpu_to_be32(nr_boot_lmbs);
+    elem->cell.base_addr = cpu_to_be64(0);
+    elem->cell.drc_index = cpu_to_be32(0);
+    elem->cell.aa_index = cpu_to_be32(-1);
+    elem->cell.flags = cpu_to_be32(SPAPR_LMB_FLAGS_RESERVED |
+                                   SPAPR_LMB_FLAGS_DRC_INVALID);
+    QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
+    nr_entries++;
+
+    object_child_foreach(qdev_get_machine(), pc_dimm_built_list, &list);
+    cur_addr = spapr->hotplug_memory.base;
+    for (item = list; item; item = g_slist_next(item)) {
+        PCDIMMDevice *dimm = item->data;
+
+        addr = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
+                                        &error_abort);
+        size = object_property_get_uint(OBJECT(dimm), PC_DIMM_SIZE_PROP,
+                                        &error_abort);
+        node = object_property_get_uint(OBJECT(dimm), PC_DIMM_NODE_PROP,
+                                        &error_abort);
+        /* Entry for hot-pluggable area */
+        if (cur_addr < addr) {
+            drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, cur_addr / lmb_size);
+            g_assert(drc);
 
-    /*
-     * Don't create the node if there is no hotpluggable memory
-     */
-    if (machine->ram_size == machine->maxram_size) {
-        return 0;
-    }
+            elem = g_malloc0(sizeof(drconf_cell_queue));
+            elem->cell.seq_lmbs = cpu_to_be32((addr - cur_addr) / lmb_size);
+            elem->cell.base_addr = cpu_to_be64(cur_addr);
+            elem->cell.drc_index = cpu_to_be32(spapr_drc_index(drc));
+            elem->cell.aa_index = cpu_to_be32(-1);
+            elem->cell.flags = cpu_to_be32(0);
+            QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
+            nr_entries++;
+        }
 
-    /*
-     * Allocate enough buffer size to fit in ibm,dynamic-memory
-     * or ibm,associativity-lookup-arrays
-     */
-    buf_len = MAX(nr_lmbs * SPAPR_DR_LMB_LIST_ENTRY_SIZE + 1, nr_nodes * 4 + 2)
-              * sizeof(uint32_t);
-    cur_index = int_buf = g_malloc0(buf_len);
+        /* Entry for DIMM */
+        drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, addr / lmb_size);
+        g_assert(drc);
 
-    offset = fdt_add_subnode(fdt, 0, "ibm,dynamic-reconfiguration-memory");
+        elem = g_malloc0(sizeof(drconf_cell_queue));
+        elem->cell.seq_lmbs = cpu_to_be32(size / lmb_size);
+        elem->cell.base_addr = cpu_to_be64(addr);
+        elem->cell.drc_index = cpu_to_be32(spapr_drc_index(drc));
+        elem->cell.aa_index = cpu_to_be32(node);
+        elem->cell.flags = cpu_to_be32(SPAPR_LMB_FLAGS_ASSIGNED);
+        QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
+        nr_entries++;
+        cur_addr = (addr + size);
+    }
+    g_slist_free(list);
+
+    /* Entry for remaining hotpluggable area */
+    if (cur_addr < mem_end) {
+        drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB, cur_addr / lmb_size);
+        g_assert(drc);
 
-    ret = fdt_setprop(fdt, offset, "ibm,lmb-size", prop_lmb_size,
-                    sizeof(prop_lmb_size));
-    if (ret < 0) {
-        goto out;
+        elem = g_malloc0(sizeof(drconf_cell_queue));
+        elem->cell.seq_lmbs = cpu_to_be32((mem_end - cur_addr) / lmb_size);
+        elem->cell.base_addr = cpu_to_be64(cur_addr);
+        elem->cell.drc_index = cpu_to_be32(spapr_drc_index(drc));
+        elem->cell.aa_index = cpu_to_be32(-1);
+        elem->cell.flags = cpu_to_be32(0);
+        QSIMPLEQ_INSERT_TAIL(&drconf_queue, elem, entry);
+        nr_entries++;
     }
 
-    ret = fdt_setprop_cell(fdt, offset, "ibm,memory-flags-mask", 0xff);
-    if (ret < 0) {
-        goto out;
+    buf_len = (nr_entries * SPAPR_DRCONF_CELL_SIZE + 1) * sizeof(uint32_t);
+    int_buf = cur_index = g_malloc0(buf_len);
+    int_buf[0] = cpu_to_be32(nr_entries);
+    cur_index++;
+    QSIMPLEQ_FOREACH_SAFE(elem, &drconf_queue, entry, next) {
+        memcpy(cur_index, &elem->cell,
+               SPAPR_DRCONF_CELL_SIZE * sizeof(uint32_t));
+        cur_index += SPAPR_DRCONF_CELL_SIZE;
+        QSIMPLEQ_REMOVE(&drconf_queue, elem, drconf_cell_queue, entry);
+        g_free(elem);
     }
 
-    ret = fdt_setprop_cell(fdt, offset, "ibm,memory-preservation-time", 0x0);
+    ret = fdt_setprop(fdt, offset, "ibm,dynamic-memory-v2", int_buf, buf_len);
     if (ret < 0) {
-        goto out;
+        return -1;
     }
+    return 0;
+}
+
+/* ibm,dynamic-memory */
+static int spapr_populate_drmem_v1(sPAPRMachineState *spapr, void *fdt,
+                                   int offset)
+{
+    int i, ret;
+    uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
+    uint32_t hotplug_lmb_start = spapr->hotplug_memory.base / lmb_size;
+    uint32_t nr_lmbs = (spapr->hotplug_memory.base +
+                       memory_region_size(&spapr->hotplug_memory.mr)) /
+                       lmb_size;
+    uint32_t *int_buf, *cur_index, buf_len;
+    MemoryDeviceInfoList *dimms = NULL;
 
     if (hotplug_lmb_start) {
         MemoryDeviceInfoList **prev = &dimms;
         qmp_pc_dimm_device_list(qdev_get_machine(), &prev);
     }
 
-    /* ibm,dynamic-memory */
+    /*
+     * Allocate enough buffer size to fit in ibm,dynamic-memory
+     */
+    buf_len = (nr_lmbs * SPAPR_DR_LMB_LIST_ENTRY_SIZE + 1) * sizeof(uint32_t);
+    cur_index = int_buf = g_malloc0(buf_len);
     int_buf[0] = cpu_to_be32(nr_lmbs);
     cur_index++;
     for (i = 0; i < nr_lmbs; i++) {
@@ -778,6 +862,64 @@ static int spapr_populate_drconf_memory(sPAPRMachineState *spapr, void *fdt)
     qapi_free_MemoryDeviceInfoList(dimms);
     ret = fdt_setprop(fdt, offset, "ibm,dynamic-memory", int_buf, buf_len);
     if (ret < 0) {
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
+
+    /*
+     * Don't create the node if there is no hotpluggable memory
+     */
+    if (machine->ram_size == machine->maxram_size) {
+        return 0;
+    }
+
+    /*
+     * Allocate enough buffer size to fit in ibm,dynamic-memory
+     * or ibm,associativity-lookup-arrays
+     */
+    buf_len = (nr_nodes * 4 + 2) * sizeof(uint32_t);
+    cur_index = int_buf = g_malloc0(buf_len);
+
+    offset = fdt_add_subnode(fdt, 0, "ibm,dynamic-reconfiguration-memory");
+
+    ret = fdt_setprop(fdt, offset, "ibm,lmb-size", prop_lmb_size,
+                    sizeof(prop_lmb_size));
+    if (ret < 0) {
+        goto out;
+    }
+
+    ret = fdt_setprop_cell(fdt, offset, "ibm,memory-flags-mask", 0xff);
+    if (ret < 0) {
+        goto out;
+    }
+
+    ret = fdt_setprop_cell(fdt, offset, "ibm,memory-preservation-time", 0x0);
+    if (ret < 0) {
+        goto out;
+    }
+
+    /* ibm,dynamic-memory or ibm,dynamic-memory-v2 */
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_DRMEM_V2)) {
+        ret = spapr_populate_drmem_v2(spapr, fdt, offset);
+    } else {
+        ret = spapr_populate_drmem_v1(spapr, fdt, offset);
+    }
+    if (ret < 0) {
         goto out;
     }
 
@@ -2485,6 +2627,11 @@ static void spapr_machine_init(MachineState *machine)
         spapr_ovec_set(spapr->ov5, OV5_HPT_RESIZE);
     }
 
+    /* advertise support for ibm,dyamic-memory-v2 */
+    if (spapr->use_ibm_dynamic_memory_v2) {
+        spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
+    }
+
     /* init CPUs */
     spapr_set_vsmt_mode(spapr, &error_fatal);
 
@@ -2888,12 +3035,27 @@ static void spapr_set_vsmt(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, (uint32_t *)opaque, errp);
 }
 
+static bool spapr_get_drmem_v2(Object *obj, Error **errp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+
+    return spapr->use_ibm_dynamic_memory_v2;
+}
+
+static void spapr_set_drmem_v2(Object *obj, bool value, Error **errp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+
+    spapr->use_ibm_dynamic_memory_v2 = value;
+}
+
 static void spapr_instance_init(Object *obj)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
 
     spapr->htab_fd = -1;
     spapr->use_hotplug_event_source = true;
+    spapr->use_ibm_dynamic_memory_v2 = true;
     object_property_add_str(obj, "kvm-type",
                             spapr_get_kvm_type, spapr_set_kvm_type, NULL);
     object_property_set_description(obj, "kvm-type",
@@ -2908,6 +3070,15 @@ static void spapr_instance_init(Object *obj)
                                     " place of standard EPOW events when possible"
                                     " (required for memory hot-unplug support)",
                                     NULL);
+    object_property_add_bool(obj, "drmem-v2",
+                             spapr_get_drmem_v2,
+                             spapr_set_drmem_v2,
+                             NULL);
+    object_property_set_description(obj, "ibm-dynamic-memory-v2",
+                                    "Use ibm-dynamic-memory-v2 representation"
+                                    " in place of ibm-dynamic-memory when"
+                                    " possible",
+                                    NULL);
 
     ppc_compat_add_property(obj, "max-cpu-compat", &spapr->max_compat_pvr,
                             "Maximum permitted CPU compatibility mode",
@@ -3991,7 +4162,10 @@ DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
 
 static void spapr_machine_2_11_instance_options(MachineState *machine)
 {
+    sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
+
     spapr_machine_2_12_instance_options(machine);
+    spapr->use_ibm_dynamic_memory_v2 = false;
 }
 
 static void spapr_machine_2_11_class_options(MachineClass *mc)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 36942b3..f212119 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -147,6 +147,7 @@ struct sPAPRMachineState {
     sPAPROptionVector *ov5;         /* QEMU-supported option vectors */
     sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vectors */
     uint32_t max_compat_pvr;
+    bool use_ibm_dynamic_memory_v2;
 
     /* Migration state */
     int htab_save_index;
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index bf25e5d..a3a8739 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -51,6 +51,7 @@ typedef struct sPAPROptionVector sPAPROptionVector;
 #define OV5_FORM1_AFFINITY      OV_BIT(5, 0)
 #define OV5_HP_EVT              OV_BIT(6, 5)
 #define OV5_HPT_RESIZE          OV_BIT(6, 7)
+#define OV5_DRMEM_V2            OV_BIT(22, 1)
 #define OV5_XIVE_BOTH           OV_BIT(23, 0)
 #define OV5_XIVE_EXPLOIT        OV_BIT(23, 1) /* 1=exploitation 0=legacy */
 
-- 
2.7.4
