Received: from eggs.gnu.org ([2001:4830:134:3::10]:47255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAwz-00023h-4f
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:03:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHAwg-0004Xh-W8
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:03:27 -0400
From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 29 Oct 2018 18:01:46 +0100
Message-Id: <20181029170159.3801-7-sameo@linux.intel.com>
In-Reply-To: <20181029170159.3801-1-sameo@linux.intel.com>
References: <20181029170159.3801-1-sameo@linux.intel.com>
Subject: [Qemu-devel] [PATCH v3 06/19] hw: acpi: Generalize AML build
 routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "open list:ARM ACPI Subsystem" <qemu-arm@nongnu.org>

From: Yang Zhong <yang.zhong@intel.com>

Most of the AML build routines under acpi-build are not even
architecture specific. They can be moved to the more generic hw/acpi
folder where they could be shared across machine types and
architectures.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 hw/acpi/aml-build.c         | 498 ++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c    |   4 +-
 hw/i386/acpi-build.c        | 516 +-----------------------------------
 include/hw/acpi/aml-build.h |  25 ++
 4 files changed, 528 insertions(+), 515 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 77eb17b113..43aec8dacd 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -25,6 +25,10 @@
 #include "qemu/bswap.h"
 #include "qemu/bitops.h"
 #include "sysemu/numa.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_bus.h"
+#include "qemu/range.h"
+#include "hw/pci/pci_bridge.h"
 
 static GArray *build_alloc_array(void)
 {
@@ -1597,6 +1601,500 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre)
     g_array_free(tables->vmgenid, mfre);
 }
 
+static void crs_range_insert(GPtrArray *ranges, uint64_t base, uint64_t limit)
+{
+    CrsRangeEntry *entry;
+
+    entry = g_malloc(sizeof(*entry));
+    entry->base = base;
+    entry->limit = limit;
+
+    g_ptr_array_add(ranges, entry);
+}
+
+static void crs_range_free(gpointer data)
+{
+    CrsRangeEntry *entry = (CrsRangeEntry *)data;
+    g_free(entry);
+}
+
+void crs_range_set_init(CrsRangeSet *range_set)
+{
+    range_set->io_ranges = g_ptr_array_new_with_free_func(crs_range_free);
+    range_set->mem_ranges = g_ptr_array_new_with_free_func(crs_range_free);
+    range_set->mem_64bit_ranges =
+            g_ptr_array_new_with_free_func(crs_range_free);
+}
+
+void crs_range_set_free(CrsRangeSet *range_set)
+{
+    g_ptr_array_free(range_set->io_ranges, true);
+    g_ptr_array_free(range_set->mem_ranges, true);
+    g_ptr_array_free(range_set->mem_64bit_ranges, true);
+}
+
+static gint crs_range_compare(gconstpointer a, gconstpointer b)
+{
+     CrsRangeEntry *entry_a = *(CrsRangeEntry **)a;
+     CrsRangeEntry *entry_b = *(CrsRangeEntry **)b;
+
+     return (int64_t)entry_a->base - (int64_t)entry_b->base;
+}
+
+/*
+ * crs_replace_with_free_ranges - given the 'used' ranges within [start - end]
+ * interval, computes the 'free' ranges from the same interval.
+ * Example: If the input array is { [a1 - a2],[b1 - b2] }, the function
+ * will return { [base - a1], [a2 - b1], [b2 - limit] }.
+ */
+void crs_replace_with_free_ranges(GPtrArray *ranges,
+                                         uint64_t start, uint64_t end)
+{
+    GPtrArray *free_ranges = g_ptr_array_new();
+    uint64_t free_base = start;
+    int i;
+
+    g_ptr_array_sort(ranges, crs_range_compare);
+    for (i = 0; i < ranges->len; i++) {
+        CrsRangeEntry *used = g_ptr_array_index(ranges, i);
+
+        if (free_base < used->base) {
+            crs_range_insert(free_ranges, free_base, used->base - 1);
+        }
+
+        free_base = used->limit + 1;
+    }
+
+    if (free_base < end) {
+        crs_range_insert(free_ranges, free_base, end);
+    }
+
+    g_ptr_array_set_size(ranges, 0);
+    for (i = 0; i < free_ranges->len; i++) {
+        g_ptr_array_add(ranges, g_ptr_array_index(free_ranges, i));
+    }
+
+    g_ptr_array_free(free_ranges, true);
+}
+
+/*
+ * crs_range_merge - merges adjacent ranges in the given array.
+ * Array elements are deleted and replaced with the merged ranges.
+ */
+static void crs_range_merge(GPtrArray *range)
+{
+    GPtrArray *tmp =  g_ptr_array_new_with_free_func(crs_range_free);
+    CrsRangeEntry *entry;
+    uint64_t range_base, range_limit;
+    int i;
+
+    if (!range->len) {
+        return;
+    }
+
+    g_ptr_array_sort(range, crs_range_compare);
+
+    entry = g_ptr_array_index(range, 0);
+    range_base = entry->base;
+    range_limit = entry->limit;
+    for (i = 1; i < range->len; i++) {
+        entry = g_ptr_array_index(range, i);
+        if (entry->base - 1 == range_limit) {
+            range_limit = entry->limit;
+        } else {
+            crs_range_insert(tmp, range_base, range_limit);
+            range_base = entry->base;
+            range_limit = entry->limit;
+        }
+    }
+    crs_range_insert(tmp, range_base, range_limit);
+
+    g_ptr_array_set_size(range, 0);
+    for (i = 0; i < tmp->len; i++) {
+        entry = g_ptr_array_index(tmp, i);
+        crs_range_insert(range, entry->base, entry->limit);
+    }
+    g_ptr_array_free(tmp, true);
+}
+
+Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
+{
+    Aml *crs = aml_resource_template();
+    CrsRangeSet temp_range_set;
+    CrsRangeEntry *entry;
+    uint8_t max_bus = pci_bus_num(host->bus);
+    uint8_t type;
+    int devfn;
+    int i;
+
+    crs_range_set_init(&temp_range_set);
+    for (devfn = 0; devfn < ARRAY_SIZE(host->bus->devices); devfn++) {
+        uint64_t range_base, range_limit;
+        PCIDevice *dev = host->bus->devices[devfn];
+
+        if (!dev) {
+            continue;
+        }
+
+        for (i = 0; i < PCI_NUM_REGIONS; i++) {
+            PCIIORegion *r = &dev->io_regions[i];
+
+            range_base = r->addr;
+            range_limit = r->addr + r->size - 1;
+
+            /*
+             * Work-around for old bioses
+             * that do not support multiple root buses
+             */
+            if (!range_base || range_base > range_limit) {
+                continue;
+            }
+
+            if (r->type & PCI_BASE_ADDRESS_SPACE_IO) {
+                crs_range_insert(temp_range_set.io_ranges,
+                                 range_base, range_limit);
+            } else { /* "memory" */
+                crs_range_insert(temp_range_set.mem_ranges,
+                                 range_base, range_limit);
+            }
+        }
+
+        type = dev->config[PCI_HEADER_TYPE] & ~PCI_HEADER_TYPE_MULTI_FUNCTION;
+        if (type == PCI_HEADER_TYPE_BRIDGE) {
+            uint8_t subordinate = dev->config[PCI_SUBORDINATE_BUS];
+            if (subordinate > max_bus) {
+                max_bus = subordinate;
+            }
+
+            range_base = pci_bridge_get_base(dev, PCI_BASE_ADDRESS_SPACE_IO);
+            range_limit = pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_SPACE_IO);
+
+            /*
+             * Work-around for old bioses
+             * that do not support multiple root buses
+             */
+            if (range_base && range_base <= range_limit) {
+                crs_range_insert(temp_range_set.io_ranges,
+                                 range_base, range_limit);
+            }
+
+            range_base =
+                pci_bridge_get_base(dev, PCI_BASE_ADDRESS_SPACE_MEMORY);
+            range_limit =
+                pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_SPACE_MEMORY);
+
+            /*
+             * Work-around for old bioses
+             * that do not support multiple root buses
+             */
+            if (range_base && range_base <= range_limit) {
+                uint64_t length = range_limit - range_base + 1;
+                if (range_limit <= UINT32_MAX && length <= UINT32_MAX)  {
+                    crs_range_insert(temp_range_set.mem_ranges,
+                                     range_base, range_limit);
+                } else {
+                    crs_range_insert(temp_range_set.mem_64bit_ranges,
+                                     range_base, range_limit);
+                }
+            }
+
+            range_base =
+                pci_bridge_get_base(dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
+            range_limit =
+                pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
+
+            /*
+             * Work-around for old bioses
+             * that do not support multiple root buses
+             */
+            if (range_base && range_base <= range_limit) {
+                uint64_t length = range_limit - range_base + 1;
+                if (range_limit <= UINT32_MAX && length <= UINT32_MAX) {
+                    crs_range_insert(temp_range_set.mem_ranges,
+                                     range_base, range_limit);
+                } else {
+                    crs_range_insert(temp_range_set.mem_64bit_ranges,
+                                     range_base, range_limit);
+                }
+            }
+        }
+    }
+
+    crs_range_merge(temp_range_set.io_ranges);
+    for (i = 0; i < temp_range_set.io_ranges->len; i++) {
+        entry = g_ptr_array_index(temp_range_set.io_ranges, i);
+        aml_append(crs,
+                   aml_word_io(AML_MIN_FIXED, AML_MAX_FIXED,
+                               AML_POS_DECODE, AML_ENTIRE_RANGE,
+                               0, entry->base, entry->limit, 0,
+                               entry->limit - entry->base + 1));
+        crs_range_insert(range_set->io_ranges, entry->base, entry->limit);
+    }
+
+    crs_range_merge(temp_range_set.mem_ranges);
+    for (i = 0; i < temp_range_set.mem_ranges->len; i++) {
+        entry = g_ptr_array_index(temp_range_set.mem_ranges, i);
+        aml_append(crs,
+                   aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
+                                    AML_MAX_FIXED, AML_NON_CACHEABLE,
+                                    AML_READ_WRITE,
+                                    0, entry->base, entry->limit, 0,
+                                    entry->limit - entry->base + 1));
+        crs_range_insert(range_set->mem_ranges, entry->base, entry->limit);
+    }
+
+    crs_range_merge(temp_range_set.mem_64bit_ranges);
+    for (i = 0; i < temp_range_set.mem_64bit_ranges->len; i++) {
+        entry = g_ptr_array_index(temp_range_set.mem_64bit_ranges, i);
+        aml_append(crs,
+                   aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
+                                    AML_MAX_FIXED, AML_NON_CACHEABLE,
+                                    AML_READ_WRITE,
+                                    0, entry->base, entry->limit, 0,
+                                    entry->limit - entry->base + 1));
+        crs_range_insert(range_set->mem_64bit_ranges,
+                         entry->base, entry->limit);
+    }
+
+    crs_range_set_free(&temp_range_set);
+
+    aml_append(crs,
+        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
+                            0,
+                            pci_bus_num(host->bus),
+                            max_bus,
+                            0,
+                            max_bus - pci_bus_num(host->bus) + 1));
+
+    return crs;
+}
+
+Aml *build_osc_method(void)
+{
+    Aml *if_ctx;
+    Aml *if_ctx2;
+    Aml *else_ctx;
+    Aml *method;
+    Aml *a_cwd1 = aml_name("CDW1");
+    Aml *a_ctrl = aml_local(0);
+
+    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
+    aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
+
+    if_ctx = aml_if(aml_equal(
+        aml_arg(0), aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766")));
+    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
+    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
+
+    aml_append(if_ctx, aml_store(aml_name("CDW3"), a_ctrl));
+
+    /*
+     * Always allow native PME, AER (no dependencies)
+     * Allow SHPC (PCI bridges can have SHPC controller)
+     */
+    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
+
+    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
+    /* Unknown revision */
+    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x08), a_cwd1));
+    aml_append(if_ctx, if_ctx2);
+
+    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), a_ctrl)));
+    /* Capabilities bits were masked */
+    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x10), a_cwd1));
+    aml_append(if_ctx, if_ctx2);
+
+    /* Update DWORD3 in the buffer */
+    aml_append(if_ctx, aml_store(a_ctrl, aml_name("CDW3")));
+    aml_append(method, if_ctx);
+
+    else_ctx = aml_else();
+    /* Unrecognized UUID */
+    aml_append(else_ctx, aml_or(a_cwd1, aml_int(4), a_cwd1));
+    aml_append(method, else_ctx);
+
+    aml_append(method, aml_return(aml_arg(3)));
+    return method;
+}
+
+void
+build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
+{
+    AcpiTableMcfg *mcfg;
+    const char *sig;
+    int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
+
+    mcfg = acpi_data_push(table_data, len);
+    mcfg->allocation[0].address = cpu_to_le64(info->mcfg_base);
+    /* Only a single allocation so no need to play with segments */
+    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
+    mcfg->allocation[0].start_bus_number = 0;
+    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->mcfg_size - 1);
+
+    /* MCFG is used for ECAM which can be enabled or disabled by guest.
+     * To avoid table size changes (which create migration issues),
+     * always create the table even if there are no allocations,
+     * but set the signature to a reserved value in this case.
+     * ACPI spec requires OSPMs to ignore such tables.
+     */
+    if (info->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
+        /* Reserved signature: ignored by OSPM */
+        sig = "QEMU";
+    } else {
+        sig = "MCFG";
+    }
+    build_header(linker, table_data, (void *)mcfg, sig, len, 1, NULL, NULL);
+}
+
+Aml *build_gsi_link_dev(const char *name, uint8_t uid, uint8_t gsi)
+{
+    Aml *dev;
+    Aml *crs;
+    Aml *method;
+    uint32_t irqs;
+
+    dev = aml_device("%s", name);
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0F")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
+
+    crs = aml_resource_template();
+    irqs = gsi;
+    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+                                  AML_SHARED, &irqs, 1));
+    aml_append(dev, aml_name_decl("_PRS", crs));
+
+    aml_append(dev, aml_name_decl("_CRS", crs));
+
+    /*
+     * _DIS can be no-op because the interrupt cannot be disabled.
+     */
+    method = aml_method("_DIS", 0, AML_NOTSERIALIZED);
+    aml_append(dev, method);
+
+    method = aml_method("_SRS", 1, AML_NOTSERIALIZED);
+    aml_append(dev, method);
+
+    return dev;
+}
+
+/**
+ * build_prt_entry:
+ * @link_name: link name for PCI route entry
+ *
+ * build AML package containing a PCI route entry for @link_name
+ */
+static Aml *build_prt_entry(const char *link_name)
+{
+    Aml *a_zero = aml_int(0);
+    Aml *pkg = aml_package(4);
+    aml_append(pkg, a_zero);
+    aml_append(pkg, a_zero);
+    aml_append(pkg, aml_name("%s", link_name));
+    aml_append(pkg, a_zero);
+    return pkg;
+}
+
+/*
+ * initialize_route - Initialize the interrupt routing rule
+ * through a specific LINK:
+ *  if (lnk_idx == idx)
+ *      route using link 'link_name'
+ */
+static Aml *initialize_route(Aml *route, const char *link_name,
+                             Aml *lnk_idx, int idx)
+{
+    Aml *if_ctx = aml_if(aml_equal(lnk_idx, aml_int(idx)));
+    Aml *pkg = build_prt_entry(link_name);
+
+    aml_append(if_ctx, aml_store(pkg, route));
+
+    return if_ctx;
+}
+
+/*
+ * build_prt - Define interrupt rounting rules
+ *
+ * Returns an array of 128 routes, one for each device,
+ * based on device location.
+ * The main goal is to equaly distribute the interrupts
+ * over the 4 existing ACPI links (works only for i440fx).
+ * The hash function is  (slot + pin) & 3 -> "LNK[D|A|B|C]".
+ *
+ */
+Aml *build_prt(bool is_pci0_prt)
+{
+    Aml *method, *while_ctx, *pin, *res;
+
+    method = aml_method("_PRT", 0, AML_NOTSERIALIZED);
+    res = aml_local(0);
+    pin = aml_local(1);
+    aml_append(method, aml_store(aml_package(128), res));
+    aml_append(method, aml_store(aml_int(0), pin));
+
+    /* while (pin < 128) */
+    while_ctx = aml_while(aml_lless(pin, aml_int(128)));
+    {
+        Aml *slot = aml_local(2);
+        Aml *lnk_idx = aml_local(3);
+        Aml *route = aml_local(4);
+
+        /* slot = pin >> 2 */
+        aml_append(while_ctx,
+                   aml_store(aml_shiftright(pin, aml_int(2), NULL), slot));
+        /* lnk_idx = (slot + pin) & 3 */
+        aml_append(while_ctx,
+            aml_store(aml_and(aml_add(pin, slot, NULL), aml_int(3), NULL),
+                      lnk_idx));
+
+        /* route[2] = "LNK[D|A|B|C]", selection based on pin % 3  */
+        aml_append(while_ctx, initialize_route(route, "LNKD", lnk_idx, 0));
+        if (is_pci0_prt) {
+            Aml *if_device_1, *if_pin_4, *else_pin_4;
+
+            /* device 1 is the power-management device, needs SCI */
+            if_device_1 = aml_if(aml_equal(lnk_idx, aml_int(1)));
+            {
+                if_pin_4 = aml_if(aml_equal(pin, aml_int(4)));
+                {
+                    aml_append(if_pin_4,
+                        aml_store(build_prt_entry("LNKS"), route));
+                }
+                aml_append(if_device_1, if_pin_4);
+                else_pin_4 = aml_else();
+                {
+                    aml_append(else_pin_4,
+                        aml_store(build_prt_entry("LNKA"), route));
+                }
+                aml_append(if_device_1, else_pin_4);
+            }
+            aml_append(while_ctx, if_device_1);
+        } else {
+            aml_append(while_ctx, initialize_route(route, "LNKA", lnk_idx, 1));
+        }
+        aml_append(while_ctx, initialize_route(route, "LNKB", lnk_idx, 2));
+        aml_append(while_ctx, initialize_route(route, "LNKC", lnk_idx, 3));
+
+        /* route[0] = 0x[slot]FFFF */
+        aml_append(while_ctx,
+            aml_store(aml_or(aml_shiftleft(slot, aml_int(16)), aml_int(0xFFFF),
+                             NULL),
+                      aml_index(route, aml_int(0))));
+        /* route[1] = pin & 3 */
+        aml_append(while_ctx,
+            aml_store(aml_and(pin, aml_int(3), NULL),
+                      aml_index(route, aml_int(1))));
+        /* res[pin] = route */
+        aml_append(while_ctx, aml_store(route, aml_index(res, pin)));
+        /* pin++ */
+        aml_append(while_ctx, aml_increment(pin));
+    }
+    aml_append(method, while_ctx);
+    /* return res*/
+    aml_append(method, aml_return(res));
+
+    return method;
+}
+
 /* Build rsdt table */
 void
 build_rsdt(GArray *table_data, BIOSLinker *linker, GArray *table_offsets,
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 0a6a88380a..6822ee4eaa 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -546,7 +546,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 }
 
 static void
-build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
+virt_build_mcfg(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
     AcpiTableMcfg *mcfg;
     const MemMapEntry *memmap = vms->memmap;
@@ -791,7 +791,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     build_gtdt(tables_blob, tables->linker, vms);
 
     acpi_add_table(table_offsets, tables_blob);
-    build_mcfg(tables_blob, tables->linker, vms);
+    virt_build_mcfg(tables_blob, tables->linker, vms);
 
     acpi_add_table(table_offsets, tables_blob);
     build_spcr(tables_blob, tables->linker, vms);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index eee2eb3ed2..3ab68fd24d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -86,11 +86,6 @@
 /* Default IOAPIC ID */
 #define ACPI_BUILD_IOAPIC_ID 0x0
 
-typedef struct AcpiMcfgInfo {
-    uint64_t mcfg_base;
-    uint32_t mcfg_size;
-} AcpiMcfgInfo;
-
 typedef struct AcpiPmInfo {
     bool s3_disabled;
     bool s4_disabled;
@@ -567,403 +562,6 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
     qobject_unref(bsel);
 }
 
-/**
- * build_prt_entry:
- * @link_name: link name for PCI route entry
- *
- * build AML package containing a PCI route entry for @link_name
- */
-static Aml *build_prt_entry(const char *link_name)
-{
-    Aml *a_zero = aml_int(0);
-    Aml *pkg = aml_package(4);
-    aml_append(pkg, a_zero);
-    aml_append(pkg, a_zero);
-    aml_append(pkg, aml_name("%s", link_name));
-    aml_append(pkg, a_zero);
-    return pkg;
-}
-
-/*
- * initialize_route - Initialize the interrupt routing rule
- * through a specific LINK:
- *  if (lnk_idx == idx)
- *      route using link 'link_name'
- */
-static Aml *initialize_route(Aml *route, const char *link_name,
-                             Aml *lnk_idx, int idx)
-{
-    Aml *if_ctx = aml_if(aml_equal(lnk_idx, aml_int(idx)));
-    Aml *pkg = build_prt_entry(link_name);
-
-    aml_append(if_ctx, aml_store(pkg, route));
-
-    return if_ctx;
-}
-
-/*
- * build_prt - Define interrupt rounting rules
- *
- * Returns an array of 128 routes, one for each device,
- * based on device location.
- * The main goal is to equaly distribute the interrupts
- * over the 4 existing ACPI links (works only for i440fx).
- * The hash function is  (slot + pin) & 3 -> "LNK[D|A|B|C]".
- *
- */
-static Aml *build_prt(bool is_pci0_prt)
-{
-    Aml *method, *while_ctx, *pin, *res;
-
-    method = aml_method("_PRT", 0, AML_NOTSERIALIZED);
-    res = aml_local(0);
-    pin = aml_local(1);
-    aml_append(method, aml_store(aml_package(128), res));
-    aml_append(method, aml_store(aml_int(0), pin));
-
-    /* while (pin < 128) */
-    while_ctx = aml_while(aml_lless(pin, aml_int(128)));
-    {
-        Aml *slot = aml_local(2);
-        Aml *lnk_idx = aml_local(3);
-        Aml *route = aml_local(4);
-
-        /* slot = pin >> 2 */
-        aml_append(while_ctx,
-                   aml_store(aml_shiftright(pin, aml_int(2), NULL), slot));
-        /* lnk_idx = (slot + pin) & 3 */
-        aml_append(while_ctx,
-            aml_store(aml_and(aml_add(pin, slot, NULL), aml_int(3), NULL),
-                      lnk_idx));
-
-        /* route[2] = "LNK[D|A|B|C]", selection based on pin % 3  */
-        aml_append(while_ctx, initialize_route(route, "LNKD", lnk_idx, 0));
-        if (is_pci0_prt) {
-            Aml *if_device_1, *if_pin_4, *else_pin_4;
-
-            /* device 1 is the power-management device, needs SCI */
-            if_device_1 = aml_if(aml_equal(lnk_idx, aml_int(1)));
-            {
-                if_pin_4 = aml_if(aml_equal(pin, aml_int(4)));
-                {
-                    aml_append(if_pin_4,
-                        aml_store(build_prt_entry("LNKS"), route));
-                }
-                aml_append(if_device_1, if_pin_4);
-                else_pin_4 = aml_else();
-                {
-                    aml_append(else_pin_4,
-                        aml_store(build_prt_entry("LNKA"), route));
-                }
-                aml_append(if_device_1, else_pin_4);
-            }
-            aml_append(while_ctx, if_device_1);
-        } else {
-            aml_append(while_ctx, initialize_route(route, "LNKA", lnk_idx, 1));
-        }
-        aml_append(while_ctx, initialize_route(route, "LNKB", lnk_idx, 2));
-        aml_append(while_ctx, initialize_route(route, "LNKC", lnk_idx, 3));
-
-        /* route[0] = 0x[slot]FFFF */
-        aml_append(while_ctx,
-            aml_store(aml_or(aml_shiftleft(slot, aml_int(16)), aml_int(0xFFFF),
-                             NULL),
-                      aml_index(route, aml_int(0))));
-        /* route[1] = pin & 3 */
-        aml_append(while_ctx,
-            aml_store(aml_and(pin, aml_int(3), NULL),
-                      aml_index(route, aml_int(1))));
-        /* res[pin] = route */
-        aml_append(while_ctx, aml_store(route, aml_index(res, pin)));
-        /* pin++ */
-        aml_append(while_ctx, aml_increment(pin));
-    }
-    aml_append(method, while_ctx);
-    /* return res*/
-    aml_append(method, aml_return(res));
-
-    return method;
-}
-
-typedef struct CrsRangeEntry {
-    uint64_t base;
-    uint64_t limit;
-} CrsRangeEntry;
-
-static void crs_range_insert(GPtrArray *ranges, uint64_t base, uint64_t limit)
-{
-    CrsRangeEntry *entry;
-
-    entry = g_malloc(sizeof(*entry));
-    entry->base = base;
-    entry->limit = limit;
-
-    g_ptr_array_add(ranges, entry);
-}
-
-static void crs_range_free(gpointer data)
-{
-    CrsRangeEntry *entry = (CrsRangeEntry *)data;
-    g_free(entry);
-}
-
-typedef struct CrsRangeSet {
-    GPtrArray *io_ranges;
-    GPtrArray *mem_ranges;
-    GPtrArray *mem_64bit_ranges;
- } CrsRangeSet;
-
-static void crs_range_set_init(CrsRangeSet *range_set)
-{
-    range_set->io_ranges = g_ptr_array_new_with_free_func(crs_range_free);
-    range_set->mem_ranges = g_ptr_array_new_with_free_func(crs_range_free);
-    range_set->mem_64bit_ranges =
-            g_ptr_array_new_with_free_func(crs_range_free);
-}
-
-static void crs_range_set_free(CrsRangeSet *range_set)
-{
-    g_ptr_array_free(range_set->io_ranges, true);
-    g_ptr_array_free(range_set->mem_ranges, true);
-    g_ptr_array_free(range_set->mem_64bit_ranges, true);
-}
-
-static gint crs_range_compare(gconstpointer a, gconstpointer b)
-{
-     CrsRangeEntry *entry_a = *(CrsRangeEntry **)a;
-     CrsRangeEntry *entry_b = *(CrsRangeEntry **)b;
-
-     return (int64_t)entry_a->base - (int64_t)entry_b->base;
-}
-
-/*
- * crs_replace_with_free_ranges - given the 'used' ranges within [start - end]
- * interval, computes the 'free' ranges from the same interval.
- * Example: If the input array is { [a1 - a2],[b1 - b2] }, the function
- * will return { [base - a1], [a2 - b1], [b2 - limit] }.
- */
-static void crs_replace_with_free_ranges(GPtrArray *ranges,
-                                         uint64_t start, uint64_t end)
-{
-    GPtrArray *free_ranges = g_ptr_array_new();
-    uint64_t free_base = start;
-    int i;
-
-    g_ptr_array_sort(ranges, crs_range_compare);
-    for (i = 0; i < ranges->len; i++) {
-        CrsRangeEntry *used = g_ptr_array_index(ranges, i);
-
-        if (free_base < used->base) {
-            crs_range_insert(free_ranges, free_base, used->base - 1);
-        }
-
-        free_base = used->limit + 1;
-    }
-
-    if (free_base < end) {
-        crs_range_insert(free_ranges, free_base, end);
-    }
-
-    g_ptr_array_set_size(ranges, 0);
-    for (i = 0; i < free_ranges->len; i++) {
-        g_ptr_array_add(ranges, g_ptr_array_index(free_ranges, i));
-    }
-
-    g_ptr_array_free(free_ranges, true);
-}
-
-/*
- * crs_range_merge - merges adjacent ranges in the given array.
- * Array elements are deleted and replaced with the merged ranges.
- */
-static void crs_range_merge(GPtrArray *range)
-{
-    GPtrArray *tmp =  g_ptr_array_new_with_free_func(crs_range_free);
-    CrsRangeEntry *entry;
-    uint64_t range_base, range_limit;
-    int i;
-
-    if (!range->len) {
-        return;
-    }
-
-    g_ptr_array_sort(range, crs_range_compare);
-
-    entry = g_ptr_array_index(range, 0);
-    range_base = entry->base;
-    range_limit = entry->limit;
-    for (i = 1; i < range->len; i++) {
-        entry = g_ptr_array_index(range, i);
-        if (entry->base - 1 == range_limit) {
-            range_limit = entry->limit;
-        } else {
-            crs_range_insert(tmp, range_base, range_limit);
-            range_base = entry->base;
-            range_limit = entry->limit;
-        }
-    }
-    crs_range_insert(tmp, range_base, range_limit);
-
-    g_ptr_array_set_size(range, 0);
-    for (i = 0; i < tmp->len; i++) {
-        entry = g_ptr_array_index(tmp, i);
-        crs_range_insert(range, entry->base, entry->limit);
-    }
-    g_ptr_array_free(tmp, true);
-}
-
-static Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
-{
-    Aml *crs = aml_resource_template();
-    CrsRangeSet temp_range_set;
-    CrsRangeEntry *entry;
-    uint8_t max_bus = pci_bus_num(host->bus);
-    uint8_t type;
-    int devfn;
-    int i;
-
-    crs_range_set_init(&temp_range_set);
-    for (devfn = 0; devfn < ARRAY_SIZE(host->bus->devices); devfn++) {
-        uint64_t range_base, range_limit;
-        PCIDevice *dev = host->bus->devices[devfn];
-
-        if (!dev) {
-            continue;
-        }
-
-        for (i = 0; i < PCI_NUM_REGIONS; i++) {
-            PCIIORegion *r = &dev->io_regions[i];
-
-            range_base = r->addr;
-            range_limit = r->addr + r->size - 1;
-
-            /*
-             * Work-around for old bioses
-             * that do not support multiple root buses
-             */
-            if (!range_base || range_base > range_limit) {
-                continue;
-            }
-
-            if (r->type & PCI_BASE_ADDRESS_SPACE_IO) {
-                crs_range_insert(temp_range_set.io_ranges,
-                                 range_base, range_limit);
-            } else { /* "memory" */
-                crs_range_insert(temp_range_set.mem_ranges,
-                                 range_base, range_limit);
-            }
-        }
-
-        type = dev->config[PCI_HEADER_TYPE] & ~PCI_HEADER_TYPE_MULTI_FUNCTION;
-        if (type == PCI_HEADER_TYPE_BRIDGE) {
-            uint8_t subordinate = dev->config[PCI_SUBORDINATE_BUS];
-            if (subordinate > max_bus) {
-                max_bus = subordinate;
-            }
-
-            range_base = pci_bridge_get_base(dev, PCI_BASE_ADDRESS_SPACE_IO);
-            range_limit = pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_SPACE_IO);
-
-            /*
-             * Work-around for old bioses
-             * that do not support multiple root buses
-             */
-            if (range_base && range_base <= range_limit) {
-                crs_range_insert(temp_range_set.io_ranges,
-                                 range_base, range_limit);
-            }
-
-            range_base =
-                pci_bridge_get_base(dev, PCI_BASE_ADDRESS_SPACE_MEMORY);
-            range_limit =
-                pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_SPACE_MEMORY);
-
-            /*
-             * Work-around for old bioses
-             * that do not support multiple root buses
-             */
-            if (range_base && range_base <= range_limit) {
-                uint64_t length = range_limit - range_base + 1;
-                if (range_limit <= UINT32_MAX && length <= UINT32_MAX) {
-                    crs_range_insert(temp_range_set.mem_ranges,
-                                     range_base, range_limit);
-                } else {
-                    crs_range_insert(temp_range_set.mem_64bit_ranges,
-                                     range_base, range_limit);
-                }
-            }
-
-            range_base =
-                pci_bridge_get_base(dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
-            range_limit =
-                pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
-
-            /*
-             * Work-around for old bioses
-             * that do not support multiple root buses
-             */
-            if (range_base && range_base <= range_limit) {
-                uint64_t length = range_limit - range_base + 1;
-                if (range_limit <= UINT32_MAX && length <= UINT32_MAX) {
-                    crs_range_insert(temp_range_set.mem_ranges,
-                                     range_base, range_limit);
-                } else {
-                    crs_range_insert(temp_range_set.mem_64bit_ranges,
-                                     range_base, range_limit);
-                }
-            }
-        }
-    }
-
-    crs_range_merge(temp_range_set.io_ranges);
-    for (i = 0; i < temp_range_set.io_ranges->len; i++) {
-        entry = g_ptr_array_index(temp_range_set.io_ranges, i);
-        aml_append(crs,
-                   aml_word_io(AML_MIN_FIXED, AML_MAX_FIXED,
-                               AML_POS_DECODE, AML_ENTIRE_RANGE,
-                               0, entry->base, entry->limit, 0,
-                               entry->limit - entry->base + 1));
-        crs_range_insert(range_set->io_ranges, entry->base, entry->limit);
-    }
-
-    crs_range_merge(temp_range_set.mem_ranges);
-    for (i = 0; i < temp_range_set.mem_ranges->len; i++) {
-        entry = g_ptr_array_index(temp_range_set.mem_ranges, i);
-        aml_append(crs,
-                   aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
-                                    AML_MAX_FIXED, AML_NON_CACHEABLE,
-                                    AML_READ_WRITE,
-                                    0, entry->base, entry->limit, 0,
-                                    entry->limit - entry->base + 1));
-        crs_range_insert(range_set->mem_ranges, entry->base, entry->limit);
-    }
-
-    crs_range_merge(temp_range_set.mem_64bit_ranges);
-    for (i = 0; i < temp_range_set.mem_64bit_ranges->len; i++) {
-        entry = g_ptr_array_index(temp_range_set.mem_64bit_ranges, i);
-        aml_append(crs,
-                   aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
-                                    AML_MAX_FIXED, AML_NON_CACHEABLE,
-                                    AML_READ_WRITE,
-                                    0, entry->base, entry->limit, 0,
-                                    entry->limit - entry->base + 1));
-        crs_range_insert(range_set->mem_64bit_ranges,
-                         entry->base, entry->limit);
-    }
-
-    crs_range_set_free(&temp_range_set);
-
-    aml_append(crs,
-        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
-                            0,
-                            pci_bus_num(host->bus),
-                            max_bus,
-                            0,
-                            max_bus - pci_bus_num(host->bus) + 1));
-
-    return crs;
-}
-
 static void build_hpet_aml(Aml *table)
 {
     Aml *crs;
@@ -1334,37 +932,6 @@ static Aml *build_link_dev(const char *name, uint8_t uid, Aml *reg)
     return dev;
  }
 
-static Aml *build_gsi_link_dev(const char *name, uint8_t uid, uint8_t gsi)
-{
-    Aml *dev;
-    Aml *crs;
-    Aml *method;
-    uint32_t irqs;
-
-    dev = aml_device("%s", name);
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0F")));
-    aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
-
-    crs = aml_resource_template();
-    irqs = gsi;
-    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
-                                  AML_SHARED, &irqs, 1));
-    aml_append(dev, aml_name_decl("_PRS", crs));
-
-    aml_append(dev, aml_name_decl("_CRS", crs));
-
-    /*
-     * _DIS can be no-op because the interrupt cannot be disabled.
-     */
-    method = aml_method("_DIS", 0, AML_NOTSERIALIZED);
-    aml_append(dev, method);
-
-    method = aml_method("_SRS", 1, AML_NOTSERIALIZED);
-    aml_append(dev, method);
-
-    return dev;
-}
-
 /* _CRS method - get current settings */
 static Aml *build_iqcr_method(bool is_piix4)
 {
@@ -1728,54 +1295,6 @@ static void build_piix4_pci_hotplug(Aml *table)
     aml_append(table, scope);
 }
 
-static Aml *build_q35_osc_method(void)
-{
-    Aml *if_ctx;
-    Aml *if_ctx2;
-    Aml *else_ctx;
-    Aml *method;
-    Aml *a_cwd1 = aml_name("CDW1");
-    Aml *a_ctrl = aml_local(0);
-
-    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
-    aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
-
-    if_ctx = aml_if(aml_equal(
-        aml_arg(0), aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766")));
-    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
-    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
-
-    aml_append(if_ctx, aml_store(aml_name("CDW3"), a_ctrl));
-
-    /*
-     * Always allow native PME, AER (no dependencies)
-     * Allow SHPC (PCI bridges can have SHPC controller)
-     */
-    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
-
-    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
-    /* Unknown revision */
-    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x08), a_cwd1));
-    aml_append(if_ctx, if_ctx2);
-
-    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), a_ctrl)));
-    /* Capabilities bits were masked */
-    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x10), a_cwd1));
-    aml_append(if_ctx, if_ctx2);
-
-    /* Update DWORD3 in the buffer */
-    aml_append(if_ctx, aml_store(a_ctrl, aml_name("CDW3")));
-    aml_append(method, if_ctx);
-
-    else_ctx = aml_else();
-    /* Unrecognized UUID */
-    aml_append(else_ctx, aml_or(a_cwd1, aml_int(4), a_cwd1));
-    aml_append(method, else_ctx);
-
-    aml_append(method, aml_return(aml_arg(3)));
-    return method;
-}
-
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker,
            AcpiPmInfo *pm, AcpiMiscInfo *misc,
@@ -1818,7 +1337,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
         aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
         aml_append(dev, aml_name_decl("_UID", aml_int(1)));
-        aml_append(dev, build_q35_osc_method());
+        aml_append(dev, build_osc_method());
         aml_append(sb_scope, dev);
         aml_append(dsdt, sb_scope);
 
@@ -1883,7 +1402,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
             if (pci_bus_is_express(bus)) {
-                aml_append(dev, build_q35_osc_method());
+                aml_append(dev, build_osc_method());
             }
 
             if (numa_node != NUMA_NODE_UNASSIGNED) {
@@ -2369,35 +1888,6 @@ build_srat(GArray *table_data, BIOSLinker *linker,
                  table_data->len - srat_start, 1, NULL, NULL);
 }
 
-static void
-build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
-{
-    AcpiTableMcfg *mcfg;
-    const char *sig;
-    int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
-
-    mcfg = acpi_data_push(table_data, len);
-    mcfg->allocation[0].address = cpu_to_le64(info->mcfg_base);
-    /* Only a single allocation so no need to play with segments */
-    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
-    mcfg->allocation[0].start_bus_number = 0;
-    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->mcfg_size - 1);
-
-    /* MCFG is used for ECAM which can be enabled or disabled by guest.
-     * To avoid table size changes (which create migration issues),
-     * always create the table even if there are no allocations,
-     * but set the signature to a reserved value in this case.
-     * ACPI spec requires OSPMs to ignore such tables.
-     */
-    if (info->mcfg_base == PCIE_BASE_ADDR_UNMAPPED) {
-        /* Reserved signature: ignored by OSPM */
-        sig = "QEMU";
-    } else {
-        sig = "MCFG";
-    }
-    build_header(linker, table_data, (void *)mcfg, sig, len, 1, NULL, NULL);
-}
-
 /*
  * VT-d spec 8.1 DMA Remapping Reporting Structure
  * (version Oct. 2014 or later)
@@ -2625,7 +2115,7 @@ void acpi_build(AcpiBuildTables *tables,
     }
     if (acpi_get_mcfg(&mcfg)) {
         acpi_add_table(table_offsets, tables_blob);
-        build_mcfg_q35(tables_blob, tables->linker, &mcfg);
+        build_mcfg(tables_blob, tables->linker, &mcfg);
     }
     if (x86_iommu_get_default()) {
         IommuType IOMMUType = x86_iommu_get_type();
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 8d1063a40b..cd744e9472 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -3,6 +3,7 @@
 
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/bios-linker-loader.h"
+#include "hw/pci/pcie_host.h"
 
 /* Reserve RAM space for tables: add another order of magnitude. */
 #define ACPI_BUILD_TABLE_MAX_SIZE         0x200000
@@ -224,6 +225,21 @@ struct AcpiBuildTables {
     BIOSLinker *linker;
 } AcpiBuildTables;
 
+typedef struct AcpiMcfgInfo {
+    uint64_t mcfg_base;
+    uint32_t mcfg_size;
+} AcpiMcfgInfo;
+
+typedef struct CrsRangeEntry {
+    uint64_t base;
+    uint64_t limit;
+} CrsRangeEntry;
+
+typedef struct CrsRangeSet {
+    GPtrArray *io_ranges;
+    GPtrArray *mem_ranges;
+    GPtrArray *mem_64bit_ranges;
+} CrsRangeSet;
 /**
  * init_aml_allocator:
  *
@@ -389,6 +405,15 @@ void acpi_align_size(GArray *blob, unsigned align);
 void acpi_add_table(GArray *table_offsets, GArray *table_data);
 void acpi_build_tables_init(AcpiBuildTables *tables);
 void acpi_build_tables_cleanup(AcpiBuildTables *tables, bool mfre);
+Aml *build_osc_method(void);
+void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info);
+Aml *build_gsi_link_dev(const char *name, uint8_t uid, uint8_t gsi);
+Aml *build_prt(bool is_pci0_prt);
+void crs_range_set_init(CrsRangeSet *range_set);
+Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set);
+void crs_replace_with_free_ranges(GPtrArray *ranges,
+                                  uint64_t start, uint64_t end);
+void crs_range_set_free(CrsRangeSet *range_set);
 void
 build_rsdp_rsdt(GArray *table_data,
                 BIOSLinker *linker, unsigned rsdt_tbl_offset);
-- 
2.17.2
