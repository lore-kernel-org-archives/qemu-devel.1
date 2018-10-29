Received: from eggs.gnu.org ([2001:4830:134:3::10]:40881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHDER-0000MW-6t
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHDEN-0006Iw-SW
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:29:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHDEN-0006Hz-IT
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:29:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id f1-v6so10265486wmg.1
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 12:29:43 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-10-sameo@linux.intel.com>
	<ec47ae4b-5dce-9b21-0126-04f302b701eb@redhat.com>
Message-ID: <6df32467-fe8f-8821-aa20-cf8e1a7dab29@redhat.com>
Date: Mon, 29 Oct 2018 20:29:38 +0100
MIME-Version: 1.0
In-Reply-To: <ec47ae4b-5dce-9b21-0126-04f302b701eb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 09/19] hw: acpi: Export and generalize
 the PCI host AML API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Rob Bradford <robert.bradford@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 29/10/18 20:23, Philippe Mathieu-Daudé wrote:
> On 29/10/18 18:01, Samuel Ortiz wrote:
>> From: Yang Zhong <yang.zhong@intel.com>
>>
>> The AML build routines for the PCI host bridge and the corresponding
>> DSDT addition are neither x86 nor PC machine type specific.
>> We can move them to the architecture agnostic hw/acpi folder, and by
>> carrying all the needed information through a new AcpiPciBus structure,
>> we can make them PC machine type independent.
>>
>> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
>> Signed-off-by: Rob Bradford <robert.bradford@intel.com>
>> ---
>>   hw/acpi/aml-build.c         | 208 ++++++++++++++++++++++++++++++++++++
>>   hw/i386/acpi-build.c        | 167 ++---------------------------
>>   include/hw/acpi/aml-build.h |  10 ++
>>   3 files changed, 226 insertions(+), 159 deletions(-)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 52ac39acdb..aa72b5459c 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -29,6 +29,25 @@
>>   #include "hw/pci/pci_bus.h"
>>   #include "qemu/range.h"
>>   #include "hw/pci/pci_bridge.h"
>> +#include "hw/i386/pc.h"

Err I just missed that, this include doesn't belong here, ...

>> +#include "sysemu/tpm.h"
>> +#include "hw/acpi/tpm.h"
>> +
>> +#define PCI_HOST_BRIDGE_CONFIG_ADDR        0xcf8
>> +#define PCI_HOST_BRIDGE_IO_0_MIN_ADDR      0x0000
>> +#define PCI_HOST_BRIDGE_IO_0_MAX_ADDR      0x0cf7
>> +#define PCI_HOST_BRIDGE_IO_1_MIN_ADDR      0x0d00
>> +#define PCI_HOST_BRIDGE_IO_1_MAX_ADDR      0xffff
>> +#define PCI_VGA_MEM_BASE_ADDR              0x000a0000
>> +#define PCI_VGA_MEM_MAX_ADDR               0x000bffff
>> +#define IO_0_LEN                           0xcf8
>> +#define VGA_MEM_LEN                        0x20000
>> +
>> +static const char *pci_hosts[] = {
> 
> This array should stay in hw/i386/acpi-build.c.
> 
>> +   "/machine/i440fx",
>> +   "/machine/q35",
>> +   NULL,
>> +};
>>   static GArray *build_alloc_array(void)
>>   {
>> @@ -1601,6 +1620,51 @@ void acpi_build_tables_cleanup(AcpiBuildTables 
>> *tables, bool mfre)
>>       g_array_free(tables->vmgenid, mfre);
>>   }
>> +/*
>> + * Because of the PXB hosts we cannot simply query TYPE_PCI_HOST_BRIDGE.
>> + */
>> +Object *acpi_get_pci_host(void)
> 
> This function should take the machine_paths as argument.
> 
>> +{
>> +    PCIHostState *host;
>> +    int i = 0;
>> +
>> +    while (pci_hosts[i]) {
>> +        host = OBJECT_CHECK(PCIHostState,
>> +                            object_resolve_path(pci_hosts[i], NULL),
>> +                            TYPE_PCI_HOST_BRIDGE);
>> +        if (host) {
>> +            return OBJECT(host);
>> +        }
>> +
>> +        i++;
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +void acpi_get_pci_holes(Range *hole, Range *hole64)

... and this function neither, it should stay in hw/i386/acpi-build.c, 
thus you don't need to modify the prototype and can call 
acpi_get_pci_host(x86_machine_paths) directly.

> 
> Ditto.
> 
>> +{
>> +    Object *pci_host;
>> +
>> +    pci_host = acpi_get_pci_host();
>> +    g_assert(pci_host);
>> +
>> +    range_set_bounds1(hole,
>> +                      object_property_get_uint(pci_host,
>> +                                               
>> PCI_HOST_PROP_PCI_HOLE_START,
>> +                                               NULL),
>> +                      object_property_get_uint(pci_host,
>> +                                               
>> PCI_HOST_PROP_PCI_HOLE_END,
>> +                                               NULL));
>> +    range_set_bounds1(hole64,
>> +                      object_property_get_uint(pci_host,
>> +                                               
>> PCI_HOST_PROP_PCI_HOLE64_START,
>> +                                               NULL),
>> +                      object_property_get_uint(pci_host,
>> +                                               
>> PCI_HOST_PROP_PCI_HOLE64_END,
>> +                                               NULL));
>> +}
>> +
>>   static void crs_range_insert(GPtrArray *ranges, uint64_t base, 
>> uint64_t limit)
>>   {
>>       CrsRangeEntry *entry;
>> @@ -2099,6 +2163,150 @@ Aml *build_prt(bool is_pci0_prt)
>>       return method;
>>   }
>> +Aml *build_pci_host_bridge(Aml *table, AcpiPciBus *pci_host)
>> +{
>> +    CrsRangeEntry *entry;
>> +    Aml *scope, *dev, *crs;
>> +    CrsRangeSet crs_range_set;
>> +    Range *pci_hole = NULL;
>> +    Range *pci_hole64 = NULL;
>> +    PCIBus *bus = NULL;
>> +    int root_bus_limit = 0xFF;
>> +    int i;
>> +
>> +    bus = pci_host->pci_bus;
>> +    assert(bus);
>> +    pci_hole = pci_host->pci_hole;
>> +    pci_hole64 = pci_host->pci_hole64;
>> +
>> +    crs_range_set_init(&crs_range_set);
>> +    QLIST_FOREACH(bus, &bus->child, sibling) {
>> +        uint8_t bus_num = pci_bus_num(bus);
>> +        uint8_t numa_node = pci_bus_numa_node(bus);
>> +
>> +        /* look only for expander root buses */
>> +        if (!pci_bus_is_root(bus)) {
>> +            continue;
>> +        }
>> +
>> +        if (bus_num < root_bus_limit) {
>> +            root_bus_limit = bus_num - 1;
>> +        }
>> +
>> +        scope = aml_scope("\\_SB");
>> +        dev = aml_device("PC%.02X", bus_num);
>> +        aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
>> +        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
>> +        aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
>> +        if (pci_bus_is_express(bus)) {
>> +            aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>> +            aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>> +            aml_append(dev, build_osc_method(0x1F));
>> +        }
>> +        if (numa_node != NUMA_NODE_UNASSIGNED) {
>> +            aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));
>> +        }
>> +
>> +        aml_append(dev, build_prt(false));
>> +        crs = build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent), 
>> &crs_range_set);
>> +        aml_append(dev, aml_name_decl("_CRS", crs));
>> +        aml_append(scope, dev);
>> +        aml_append(table, scope);
>> +    }
>> +    scope = aml_scope("\\_SB.PCI0");
>> +    /* build PCI0._CRS */
>> +    crs = aml_resource_template();
>> +    /* set the pcie bus num */
>> +    aml_append(crs,
>> +        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, 
>> AML_POS_DECODE,
>> +                            0x0000, 0x0, root_bus_limit,
>> +                            0x0000, root_bus_limit + 1));
>> +    aml_append(crs, aml_io(AML_DECODE16, PCI_HOST_BRIDGE_CONFIG_ADDR,
>> +                           PCI_HOST_BRIDGE_CONFIG_ADDR, 0x01, 0x08));
>> +    /* set the io region 0 in pci host bridge */
>> +    aml_append(crs,
>> +        aml_word_io(AML_MIN_FIXED, AML_MAX_FIXED,
>> +                    AML_POS_DECODE, AML_ENTIRE_RANGE,
>> +                    0x0000, PCI_HOST_BRIDGE_IO_0_MIN_ADDR,
>> +                    PCI_HOST_BRIDGE_IO_0_MAX_ADDR, 0x0000, IO_0_LEN));
>> +
>> +    /* set the io region 1 in pci host bridge */
>> +    crs_replace_with_free_ranges(crs_range_set.io_ranges,
>> +                                 PCI_HOST_BRIDGE_IO_1_MIN_ADDR,
>> +                                 PCI_HOST_BRIDGE_IO_1_MAX_ADDR);
>> +    for (i = 0; i < crs_range_set.io_ranges->len; i++) {
>> +        entry = g_ptr_array_index(crs_range_set.io_ranges, i);
>> +        aml_append(crs,
>> +            aml_word_io(AML_MIN_FIXED, AML_MAX_FIXED,
>> +                        AML_POS_DECODE, AML_ENTIRE_RANGE,
>> +                        0x0000, entry->base, entry->limit,
>> +                        0x0000, entry->limit - entry->base + 1));
>> +    }
>> +
>> +    /* set the vga mem region(0) in pci host bridge */
>> +    aml_append(crs,
>> +        aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
>> +                         AML_CACHEABLE, AML_READ_WRITE,
>> +                         0, PCI_VGA_MEM_BASE_ADDR, PCI_VGA_MEM_MAX_ADDR,
>> +                         0, VGA_MEM_LEN));
>> +
>> +    /* set the mem region 1 in pci host bridge */
>> +    crs_replace_with_free_ranges(crs_range_set.mem_ranges,
>> +                                 range_lob(pci_hole),
>> +                                 range_upb(pci_hole));
>> +    for (i = 0; i < crs_range_set.mem_ranges->len; i++) {
>> +        entry = g_ptr_array_index(crs_range_set.mem_ranges, i);
>> +        aml_append(crs,
>> +            aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, 
>> AML_MAX_FIXED,
>> +                             AML_NON_CACHEABLE, AML_READ_WRITE,
>> +                             0, entry->base, entry->limit,
>> +                             0, entry->limit - entry->base + 1));
>> +    }
>> +
>> +    /* set the mem region 2 in pci host bridge */
>> +    if (!range_is_empty(pci_hole64)) {
>> +        crs_replace_with_free_ranges(crs_range_set.mem_64bit_ranges,
>> +                                     range_lob(pci_hole64),
>> +                                     range_upb(pci_hole64));
>> +        for (i = 0; i < crs_range_set.mem_64bit_ranges->len; i++) {
>> +            entry = g_ptr_array_index(crs_range_set.mem_64bit_ranges, 
>> i);
>> +            aml_append(crs,
>> +                       aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
>> +                                        AML_MAX_FIXED,
>> +                                        AML_CACHEABLE, AML_READ_WRITE,
>> +                                        0, entry->base, entry->limit,
>> +                                        0, entry->limit - entry->base 
>> + 1));
>> +        }
>> +    }
>> +
>> +    if (TPM_IS_TIS(tpm_find())) {
>> +        aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
>> +                   TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
>> +    }
>> +
>> +    aml_append(scope, aml_name_decl("_CRS", crs));
>> +    crs_range_set_free(&crs_range_set);
>> +    return scope;
>> +}
>> +
>> +void acpi_dsdt_add_pci_bus(Aml *dsdt, AcpiPciBus *pci_host)
>> +{
>> +    Aml *dev, *pci_scope;
>> +
>> +    dev = aml_device("\\_SB.PCI0");
>> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
>> +    aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>> +    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
>> +    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
>> +    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>> +    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>> +    aml_append(dev, build_osc_method(0x1F));
>> +    aml_append(dsdt, dev);
>> +
>> +    pci_scope = build_pci_host_bridge(dsdt, pci_host);
>> +    aml_append(dsdt, pci_scope);
>> +}
>> +
>>   /* Build rsdt table */
>>   void
>>   build_rsdt(GArray *table_data, BIOSLinker *linker, GArray 
>> *table_offsets,
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 35f95baca7..12a8d8210a 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -114,12 +114,6 @@ typedef struct AcpiBuildPciBusHotplugState {
>>       bool pcihp_bridge_en;
>>   } AcpiBuildPciBusHotplugState;
>> -static const char *pci_hosts[] = {
>> -   "/machine/i440fx",
>> -   "/machine/q35",
>> -   NULL,
>> -};
>> -
>>   static void init_common_fadt_data(Object *o, AcpiFadtData *data)
>>   {
>>       uint32_t io = object_property_get_uint(o, 
>> ACPI_PM_PROP_PM_IO_BASE, NULL);
>> @@ -240,52 +234,6 @@ static void acpi_get_misc_info(AcpiMiscInfo *info)
>>       info->applesmc_io_base = applesmc_port();
>>   }
>> -/*
>> - * Because of the PXB hosts we cannot simply query TYPE_PCI_HOST_BRIDGE.
>> - * On i386 arch we only have two pci hosts, so we can look only for 
>> them.
>> - */
>> -static Object *acpi_get_pci_host(void)
>> -{
>> -    PCIHostState *host;
>> -    int i = 0;
>> -
>> -    while (pci_hosts[i]) {
>> -        host = OBJECT_CHECK(PCIHostState,
>> -                            object_resolve_path(pci_hosts[i], NULL),
>> -                            TYPE_PCI_HOST_BRIDGE);
>> -        if (host) {
>> -            return OBJECT(host);
>> -        }
>> -
>> -        i++;
>> -    }
>> -
>> -    return NULL;
>> -}
>> -
>> -static void acpi_get_pci_holes(Range *hole, Range *hole64)
>> -{
>> -    Object *pci_host;
>> -
>> -    pci_host = acpi_get_pci_host();
>> -    g_assert(pci_host);
>> -
>> -    range_set_bounds1(hole,
>> -                      object_property_get_uint(pci_host,
>> -                                               
>> PCI_HOST_PROP_PCI_HOLE_START,
>> -                                               NULL),
>> -                      object_property_get_uint(pci_host,
>> -                                               
>> PCI_HOST_PROP_PCI_HOLE_END,
>> -                                               NULL));
>> -    range_set_bounds1(hole64,
>> -                      object_property_get_uint(pci_host,
>> -                                               
>> PCI_HOST_PROP_PCI_HOLE64_START,
>> -                                               NULL),
>> -                      object_property_get_uint(pci_host,
>> -                                               
>> PCI_HOST_PROP_PCI_HOLE64_END,
>> -                                               NULL));
>> -}
>> -
>>   /* FACS */
>>   static void
>>   build_facs(GArray *table_data, BIOSLinker *linker)
>> @@ -1307,16 +1255,11 @@ static void build_piix4_pci_hotplug(Aml *table)
>>   static void
>>   build_dsdt(GArray *table_data, BIOSLinker *linker,
>>              AcpiPmInfo *pm, AcpiMiscInfo *misc,
>> -           Range *pci_hole, Range *pci_hole64,
>> +           AcpiPciBus *pci_host,
>>              MachineState *machine, AcpiConfiguration *conf)
>>   {
>> -    CrsRangeEntry *entry;
>>       Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs;
>> -    CrsRangeSet crs_range_set;
>>       uint32_t nr_mem = machine->ram_slots;
>> -    int root_bus_limit = 0xFF;
>> -    PCIBus *bus = NULL;
>> -    int i;
>>       dsdt = init_aml_allocator();
>> @@ -1391,104 +1334,7 @@ build_dsdt(GArray *table_data, BIOSLinker 
>> *linker,
>>       }
>>       aml_append(dsdt, scope);
>> -    crs_range_set_init(&crs_range_set);
>> -    bus = PC_MACHINE(machine)->bus;
>> -    if (bus) {
>> -        QLIST_FOREACH(bus, &bus->child, sibling) {
>> -            uint8_t bus_num = pci_bus_num(bus);
>> -            uint8_t numa_node = pci_bus_numa_node(bus);
>> -
>> -            /* look only for expander root buses */
>> -            if (!pci_bus_is_root(bus)) {
>> -                continue;
>> -            }
>> -
>> -            if (bus_num < root_bus_limit) {
>> -                root_bus_limit = bus_num - 1;
>> -            }
>> -
>> -            scope = aml_scope("\\_SB");
>> -            dev = aml_device("PC%.02X", bus_num);
>> -            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
>> -            aml_append(dev, aml_name_decl("_HID", 
>> aml_eisaid("PNP0A03")));
>> -            aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
>> -            if (pci_bus_is_express(bus)) {
>> -                aml_append(dev, 
>> build_osc_method(ACPI_OSC_CTRL_PCI_ALL));
>> -            }
>> -
>> -            if (numa_node != NUMA_NODE_UNASSIGNED) {
>> -                aml_append(dev, aml_name_decl("_PXM", 
>> aml_int(numa_node)));
>> -            }
>> -
>> -            aml_append(dev, build_prt(false));
>> -            crs = build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent), 
>> &crs_range_set);
>> -            aml_append(dev, aml_name_decl("_CRS", crs));
>> -            aml_append(scope, dev);
>> -            aml_append(dsdt, scope);
>> -        }
>> -    }
>> -
>> -    scope = aml_scope("\\_SB.PCI0");
>> -    /* build PCI0._CRS */
>> -    crs = aml_resource_template();
>> -    aml_append(crs,
>> -        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, 
>> AML_POS_DECODE,
>> -                            0x0000, 0x0, root_bus_limit,
>> -                            0x0000, root_bus_limit + 1));
>> -    aml_append(crs, aml_io(AML_DECODE16, 0x0CF8, 0x0CF8, 0x01, 0x08));
>> -
>> -    aml_append(crs,
>> -        aml_word_io(AML_MIN_FIXED, AML_MAX_FIXED,
>> -                    AML_POS_DECODE, AML_ENTIRE_RANGE,
>> -                    0x0000, 0x0000, 0x0CF7, 0x0000, 0x0CF8));
>> -
>> -    crs_replace_with_free_ranges(crs_range_set.io_ranges, 0x0D00, 
>> 0xFFFF);
>> -    for (i = 0; i < crs_range_set.io_ranges->len; i++) {
>> -        entry = g_ptr_array_index(crs_range_set.io_ranges, i);
>> -        aml_append(crs,
>> -            aml_word_io(AML_MIN_FIXED, AML_MAX_FIXED,
>> -                        AML_POS_DECODE, AML_ENTIRE_RANGE,
>> -                        0x0000, entry->base, entry->limit,
>> -                        0x0000, entry->limit - entry->base + 1));
>> -    }
>> -
>> -    aml_append(crs,
>> -        aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
>> -                         AML_CACHEABLE, AML_READ_WRITE,
>> -                         0, 0x000A0000, 0x000BFFFF, 0, 0x00020000));
>> -
>> -    crs_replace_with_free_ranges(crs_range_set.mem_ranges,
>> -                                 range_lob(pci_hole),
>> -                                 range_upb(pci_hole));
>> -    for (i = 0; i < crs_range_set.mem_ranges->len; i++) {
>> -        entry = g_ptr_array_index(crs_range_set.mem_ranges, i);
>> -        aml_append(crs,
>> -            aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, 
>> AML_MAX_FIXED,
>> -                             AML_NON_CACHEABLE, AML_READ_WRITE,
>> -                             0, entry->base, entry->limit,
>> -                             0, entry->limit - entry->base + 1));
>> -    }
>> -
>> -    if (!range_is_empty(pci_hole64)) {
>> -        crs_replace_with_free_ranges(crs_range_set.mem_64bit_ranges,
>> -                                     range_lob(pci_hole64),
>> -                                     range_upb(pci_hole64));
>> -        for (i = 0; i < crs_range_set.mem_64bit_ranges->len; i++) {
>> -            entry = g_ptr_array_index(crs_range_set.mem_64bit_ranges, 
>> i);
>> -            aml_append(crs,
>> -                       aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
>> -                                        AML_MAX_FIXED,
>> -                                        AML_CACHEABLE, AML_READ_WRITE,
>> -                                        0, entry->base, entry->limit,
>> -                                        0, entry->limit - entry->base 
>> + 1));
>> -        }
>> -    }
>> -
>> -    if (TPM_IS_TIS(tpm_find())) {
>> -        aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
>> -                   TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
>> -    }
>> -    aml_append(scope, aml_name_decl("_CRS", crs));
>> +    scope = build_pci_host_bridge(dsdt, pci_host);
> 
> Can we have the build_pci_host_bridge() extraction in a previous 
> separated patch?
> 
> Otherwise patch looks good, nice refactor.
> 
>>       /* reserve GPE0 block resources */
>>       dev = aml_device("GPE0");
>> @@ -1508,8 +1354,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>       aml_append(dev, aml_name_decl("_CRS", crs));
>>       aml_append(scope, dev);
>> -    crs_range_set_free(&crs_range_set);
>> -
>>       /* reserve PCIHP resources */
>>       if (pm->pcihp_io_len) {
>>           dev = aml_device("PHPR");
>> @@ -2065,6 +1909,11 @@ void acpi_build(AcpiBuildTables *tables,
>>                                64 /* Ensure FACS is aligned */,
>>                                false /* high memory */);
>> +    AcpiPciBus pci_host = {
>> +        .pci_bus    = PC_MACHINE(machine)->bus,
>> +        .pci_hole   = &pci_hole,
>> +        .pci_hole64 = &pci_hole64,
>> +    };
>>       /*
>>        * FACS is pointed to by FADT.
>>        * We place it first since it's the only table that has alignment
>> @@ -2076,7 +1925,7 @@ void acpi_build(AcpiBuildTables *tables,
>>       /* DSDT is pointed to by FADT */
>>       dsdt = tables_blob->len;
>>       build_dsdt(tables_blob, tables->linker, &pm, &misc,
>> -               &pci_hole, &pci_hole64, machine, conf);
>> +               &pci_host, machine, conf);
>>       /* Count the size of the DSDT and SSDT, we will need it for legacy
>>        * sizing of ACPI tables.
>> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
>> index 40b307c97d..cdd290dd70 100644
>> --- a/include/hw/acpi/aml-build.h
>> +++ b/include/hw/acpi/aml-build.h
>> @@ -230,6 +230,12 @@ typedef struct AcpiMcfgInfo {
>>       uint32_t mcfg_size;
>>   } AcpiMcfgInfo;
>> +typedef struct AcpiPciBus {
>> +    PCIBus *pci_bus;
>> +    Range *pci_hole;
>> +    Range *pci_hole64;
>> +} AcpiPciBus;
>> +
>>   typedef struct CrsRangeEntry {
>>       uint64_t base;
>>       uint64_t limit;
>> @@ -401,6 +407,8 @@ build_header(BIOSLinker *linker, GArray *table_data,
>>                const char *oem_id, const char *oem_table_id);
>>   void *acpi_data_push(GArray *table_data, unsigned size);
>>   unsigned acpi_data_len(GArray *table);
>> +Object *acpi_get_pci_host(void);
>> +void acpi_get_pci_holes(Range *hole, Range *hole64);
>>   void acpi_align_size(GArray *blob, unsigned align);
>>   void acpi_add_table(GArray *table_offsets, GArray *table_data);
>>   void acpi_build_tables_init(AcpiBuildTables *tables);
>> @@ -409,6 +417,8 @@ Aml *build_osc_method(uint32_t value);
>>   void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo 
>> *info);
>>   Aml *build_gsi_link_dev(const char *name, uint8_t uid, uint8_t gsi);
>>   Aml *build_prt(bool is_pci0_prt);
>> +void acpi_dsdt_add_pci_bus(Aml *dsdt, AcpiPciBus *pci_host);
>> +Aml *build_pci_host_bridge(Aml *table, AcpiPciBus *pci_host);
>>   void crs_range_set_init(CrsRangeSet *range_set);
>>   Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set);
>>   void crs_replace_with_free_ranges(GPtrArray *ranges,
>>
