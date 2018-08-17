Received: from eggs.gnu.org ([2001:4830:134:3::10]:41664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqikL-0003Uw-EP
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fqikI-0000TM-28
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:41:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fqikG-0000Gu-14
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:41:09 -0400
Received: by mail-wr1-x444.google.com with SMTP id b15-v6so7726879wrv.10
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 10:41:07 -0700 (PDT)
References: <1533796423-21114-1-git-send-email-whois.zihan.yang@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <d07d57ed-12d0-f077-5d5a-5a8e44cb215f@gmail.com>
Date: Fri, 17 Aug 2018 20:41:03 +0300
MIME-Version: 1.0
In-Reply-To: <1533796423-21114-1-git-send-email-whois.zihan.yang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC v4 2/6] acpi-build: allocate mcfg for
 pxb-pcie host bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Hi Zihan,

On 08/09/2018 09:33 AM, Zihan Yang wrote:
> Allocate new segment for pxb-pcie host bridges in MCFG table, and reserve
> corresponding MCFG space for them. This allows user-defined pxb-pcie
> host bridges to be placed in different pci domain than q35 host.
>
> The pci_host_bridges list is changed to be tail list to ensure the q35 host
> is always the first element when traversing the list, because q35 host is
> inserted beofre pxb-pcie hosts
>
> Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
> ---
>   hw/i386/acpi-build.c                        | 116 +++++++++++++++++++++++-----
>   hw/i386/pc.c                                |  14 +++-
>   hw/pci-bridge/pci_expander_bridge.c         |  57 ++++++++++----
>   hw/pci-host/q35.c                           |   2 +
>   hw/pci/pci.c                                |   9 ++-
>   include/hw/i386/pc.h                        |   1 +
>   include/hw/pci-bridge/pci_expander_bridge.h |  11 +++
>   include/hw/pci-host/q35.h                   |   1 +
>   include/hw/pci/pci_host.h                   |   2 +-
>   9 files changed, 169 insertions(+), 44 deletions(-)
>   create mode 100644 include/hw/pci-bridge/pci_expander_bridge.h
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index e1ee8ae..c0fc2b4 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -55,6 +55,7 @@
>   #include "hw/i386/ich9.h"
>   #include "hw/pci/pci_bus.h"
>   #include "hw/pci-host/q35.h"
> +#include "hw/pci-bridge/pci_expander_bridge.h"
>   #include "hw/i386/x86-iommu.h"
>   
>   #include "hw/acpi/aml-build.h"
> @@ -89,6 +90,9 @@
>   typedef struct AcpiMcfgInfo {
>       uint64_t mcfg_base;
>       uint32_t mcfg_size;
> +    uint32_t domain_nr;
> +    uint8_t bus_nr; // start bus number
> +    struct AcpiMcfgInfo *next;
>   } AcpiMcfgInfo;
>   
>   typedef struct AcpiPmInfo {
> @@ -2431,14 +2435,16 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>   {
>       AcpiTableMcfg *mcfg;
>       const char *sig;
> -    int len = sizeof(*mcfg) + 1 * sizeof(mcfg->allocation[0]);
> +    int len, count = 0;
> +    AcpiMcfgInfo *cfg = info;
> +
> +    while (cfg) {
> +        ++count;
> +        cfg = cfg->next;
> +    }
> +    len = sizeof(*mcfg) + count * sizeof(mcfg->allocation[0]);
>   
>       mcfg = acpi_data_push(table_data, len);
> -    mcfg->allocation[0].address = cpu_to_le64(info->mcfg_base);
> -    /* Only a single allocation so no need to play with segments */

Now we do play :)

> -    mcfg->allocation[0].pci_segment = cpu_to_le16(0);
> -    mcfg->allocation[0].start_bus_number = 0;
> -    mcfg->allocation[0].end_bus_number = PCIE_MMCFG_BUS(info->mcfg_size - 1);
>   
>       /* MCFG is used for ECAM which can be enabled or disabled by guest.
>        * To avoid table size changes (which create migration issues),
> @@ -2452,6 +2458,17 @@ build_mcfg_q35(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info)
>       } else {
>           sig = "MCFG";
>       }
> +
> +    count = 0;
> +    while (info) {
> +        mcfg[0].allocation[count].address = cpu_to_le64(info->mcfg_base);
> +        mcfg[0].allocation[count].pci_segment = cpu_to_le16(info->domain_nr);
> +        mcfg[0].allocation[count].start_bus_number = info->bus_nr;
> +        mcfg[0].allocation[count++].end_bus_number = info->bus_nr + \
> +                                    PCIE_MMCFG_BUS(info->mcfg_size - 1);

I don't understand this. It appears we have a max_bus_nr property in pxb,
why don't we use it here? Or the mcfg_size is already computed based on 
that?

> +        info = info->next;
> +    }
> +
>       build_header(linker, table_data, (void *)mcfg, sig, len, 1, NULL, NULL);
>   }
>   
> @@ -2606,26 +2623,83 @@ struct AcpiBuildState {
>       MemoryRegion *linker_mr;
>   } AcpiBuildState;
>   
> -static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg)
> +static inline void cleanup_mcfg(AcpiMcfgInfo *mcfg)
> +{
> +    AcpiMcfgInfo *tmp;
> +    while (mcfg) {
> +        tmp = mcfg->next;
> +        g_free(mcfg);
> +        mcfg = tmp;
> +    }
> +}
> +
> +static AcpiMcfgInfo *acpi_get_mcfg(void)
>   {
>       Object *pci_host;
>       QObject *o;
> +    uint32_t domain_nr;
> +    AcpiMcfgInfo *head = NULL, *tail, *mcfg;
>   
>       pci_host = acpi_get_i386_pci_host();
>       g_assert(pci_host);
>   
> -    o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_BASE, NULL);
> -    if (!o) {
> -        return false;
> +    while (pci_host) {
> +        /* pxb-pcie-hosts does not have domain_nr property, but a link
> +         * to PXBDev. We first try to get pxbdev property, if NULL,
> +         * then it is q35 host, otherwise it is pxb-pcie-host */

I think it will be cleaner if you check for the pxb-pcie-host type,
then looking for a pxb device.

> +        Object *obj = object_property_get_link(pci_host,
> +                                           PROP_PXB_PCIE_DEV, NULL);
> +        if (!obj) {
> +            /* we are in q35 host */
> +            obj = pci_host;
> +        }
> +        o = object_property_get_qobject(obj, PROP_PXB_PCIE_DOMAIN_NR, NULL);

Now I understand why you need to link the pxb to the host.

> +        assert(o);
> +        domain_nr = qnum_get_uint(qobject_to(QNum, o));
> +        qobject_unref(o);
> +

Please add a function to the pci_host class that returns the pci_domain nr.
For Q35 host bridge (and others) will return 0, while for the PXB host 
will return the domain nr.
We don't want to pollute the apci building code with PXB specific internals.

> +        /* Skip bridges that reside in the same domain with q35 host.
> +         * Q35 always stays in pci domain 0, and is the first element
> +         * in the pci_host_bridges list */
> +        if (head && domain_nr == 0) {
> +            pci_host = OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host), next));
> +            continue;
> +        }
> +
> +        mcfg = g_new0(AcpiMcfgInfo, 1);
> +        mcfg->next = NULL;
> +        if (!head) {
> +            tail = head = mcfg;
> +        } else {
> +            tail->next = mcfg;
> +            tail = mcfg;
> +        }

Don't we have some "insert/add" macros? (I am not sure we have)

> +        mcfg->domain_nr = domain_nr;
> +
> +        o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_BASE, NULL);
> +        assert(o);
> +        mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
> +        qobject_unref(o);
> +
> +        /* firmware will overwrite it */

What do you mean?

> +        o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NULL);
> +        assert(o);
> +        mcfg->mcfg_size = qnum_get_uint(qobject_to(QNum, o));
> +        qobject_unref(o);
> +
> +        o = object_property_get_qobject(obj, PROP_PXB_BUS_NR, NULL);
> +        if (!o) {
> +            /* we are in q35 host again */
> +            mcfg->bus_nr = 0;
> +        } else {
> +            mcfg->bus_nr = qnum_get_uint(qobject_to(QNum, o));
> +            qobject_unref(o);
> +        }
> +
> +        pci_host = OBJECT(QTAILQ_NEXT(PCI_HOST_BRIDGE(pci_host), next));
>       }
> -    mcfg->mcfg_base = qnum_get_uint(qobject_to(QNum, o));
> -    qobject_unref(o);
>   
> -    o = object_property_get_qobject(pci_host, PCIE_HOST_MCFG_SIZE, NULL);
> -    assert(o);
> -    mcfg->mcfg_size = qnum_get_uint(qobject_to(QNum, o));
> -    qobject_unref(o);
> -    return true;
> +    return head;
>   }
>   
>   static
> @@ -2637,7 +2711,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>       unsigned facs, dsdt, rsdt, fadt;
>       AcpiPmInfo pm;
>       AcpiMiscInfo misc;
> -    AcpiMcfgInfo mcfg;
> +    AcpiMcfgInfo *mcfg;
>       Range pci_hole, pci_hole64;
>       uint8_t *u;
>       size_t aml_len = 0;
> @@ -2718,10 +2792,12 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>               build_slit(tables_blob, tables->linker);
>           }
>       }
> -    if (acpi_get_mcfg(&mcfg)) {
> +    if ((mcfg = acpi_get_mcfg()) != NULL) {
>           acpi_add_table(table_offsets, tables_blob);
> -        build_mcfg_q35(tables_blob, tables->linker, &mcfg);
> +        build_mcfg_q35(tables_blob, tables->linker, mcfg);
>       }
> +    cleanup_mcfg(mcfg);
> +
>       if (x86_iommu_get_default()) {
>           IommuType IOMMUType = x86_iommu_get_type();
>           if (IOMMUType == TYPE_AMD) {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 83a4444..a7e51af 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -35,6 +35,7 @@
>   #include "hw/ide.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pci_bus.h"
> +#include "hw/pci-bridge/pci_expander_bridge.h"
>   #include "hw/nvram/fw_cfg.h"
>   #include "hw/timer/hpet.h"
>   #include "hw/smbios/smbios.h"
> @@ -1470,15 +1471,24 @@ uint64_t pc_pci_hole64_start(void)
>       if (pcmc->has_reserved_memory && ms->device_memory->base) {
>           hole64_start = ms->device_memory->base;
>           if (!pcmc->broken_reserved_end) {
> -            hole64_start += memory_region_size(&ms->device_memory->mr);
> +            hole64_start += (memory_region_size(&ms->device_memory->mr) + \
> +                             pxb_pcie_mcfg_hole());
>           }
>       } else {
> -        hole64_start = 0x100000000ULL + pcms->above_4g_mem_size;
> +        /* memory layout [RAM Hotplug][MCFG][..ROUND UP..][PCI HOLE] */

The layout looks OK

> +        hole64_start = pc_pci_mcfg_start() + pxb_pcie_mcfg_hole();
>       }
>   
>       return ROUND_UP(hole64_start, 1 * GiB);
>   }
>   
> +uint64_t pc_pci_mcfg_start(void)
> +{
> +    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
> +
> +    return ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 4 * KiB);

Why do you round it up? (I am not saying is wrong)

> +}
> +
>   qemu_irq pc_allocate_cpu_irq(void)
>   {
>       return qemu_allocate_irq(pic_irq_request, NULL, 0);
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 6dd38de..f50938f 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -12,15 +12,19 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> +#include "hw/i386/pc.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pci_bus.h"
>   #include "hw/pci/pci_host.h"
>   #include "hw/pci/pcie_host.h"
>   #include "hw/pci/pci_bridge.h"
> +#include "hw/pci-host/q35.h"
> +#include "hw/pci-bridge/pci_expander_bridge.h"
>   #include "qemu/range.h"
>   #include "qemu/error-report.h"
>   #include "sysemu/numa.h"
>   #include "qapi/visitor.h"
> +#include "qemu/units.h"
>   
>   #define TYPE_PXB_BUS "pxb-bus"
>   #define PXB_BUS(obj) OBJECT_CHECK(PXBBus, (obj), TYPE_PXB_BUS)
> @@ -42,11 +46,7 @@ typedef struct PXBBus {
>   #define TYPE_PXB_PCIE_DEVICE "pxb-pcie"
>   #define PXB_PCIE_DEV(obj) OBJECT_CHECK(PXBDev, (obj), TYPE_PXB_PCIE_DEVICE)
>   
> -#define PROP_PXB_PCIE_DEV "pxbdev"
> -
> -#define PROP_PXB_PCIE_DOMAIN_NR "domain_nr"
>   #define PROP_PXB_PCIE_MAX_BUS "max_bus"
> -#define PROP_PXB_BUS_NR "bus_nr"
>   #define PROP_PXB_NUMA_NODE "numa_node"
>   
>   typedef struct PXBDev {
> @@ -122,6 +122,26 @@ static const TypeInfo pxb_pcie_bus_info = {
>       .class_init    = pxb_bus_class_init,
>   };
>   
> +static uint64_t pxb_mcfg_hole_size = 0;
> +
> +static void pxb_pcie_foreach(gpointer data, gpointer user_data)
> +{
> +    PXBDev *pxb = (PXBDev *)data;
> +
> +    if (pxb->domain_nr > 0) {
> +        /* only reserve what users ask for to reduce memory cost. Plus one
> +         * as the interval [bus_nr, max_bus] has (max_bus-bus_nr+1) buses */
> +        pxb_mcfg_hole_size += ((pxb->max_bus - pxb->bus_nr + 1ULL) * MiB);

Please find a way to do it without the global pxb_ncfg_hole_size.
Do we really need it?

> +    }
> +}
> +
> +uint64_t pxb_pcie_mcfg_hole(void)
> +{
> +    /* foreach is necessary as some pxb still reside in domain 0 */
> +    g_list_foreach(pxb_dev_list, pxb_pcie_foreach, NULL);
> +    return pxb_mcfg_hole_size;
> +}
> +
>   static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,
>                                             PCIBus *rootbus)
>   {
> @@ -153,14 +173,6 @@ static const char *pxb_pcie_host_root_bus_path(PCIHostState *host_bridge,
>       return bus->bus_path;
>   }
>   
> -static void pxb_pcie_host_get_mmcfg_size(Object *obj, Visitor *v, const char *name,
> -                                    void *opaque, Error **errp)
> -{
> -    PCIExpressHost *e = PCIE_HOST_BRIDGE(obj);
> -
> -    visit_type_uint64(v, name, &e->size, errp);
> -}

Wasn't this function added in the prev patch?

> -
>   static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
>   {
>       const PCIHostState *pxb_host;
> @@ -202,10 +214,6 @@ static void pxb_pcie_host_initfn(Object *obj)
>       memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops, phb,
>                             "pci-conf-data", 4);
>   
> -    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint64",
> -                         pxb_pcie_host_get_mmcfg_size,
> -                         NULL, NULL, NULL, NULL);

Same question

> -
>       object_property_add_link(obj, PROP_PXB_PCIE_DEV, TYPE_PXB_PCIE_DEVICE,
>                            (Object **)&s->pxbdev,
>                            qdev_prop_allow_set_link_before_realize, 0, NULL);
> @@ -214,6 +222,7 @@ static void pxb_pcie_host_initfn(Object *obj)
>   static Property pxb_pcie_host_props[] = {
>       DEFINE_PROP_UINT64(PCIE_HOST_MCFG_BASE, PXBPCIEHost, parent_obj.base_addr,
>                           PCIE_BASE_ADDR_UNMAPPED),
> +    DEFINE_PROP_UINT64(PCIE_HOST_MCFG_SIZE, PXBPCIEHost, parent_obj.size, 0),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> @@ -310,6 +319,8 @@ static gint pxb_compare(gconstpointer a, gconstpointer b)
>              0;
>   }
>   
> +static uint64_t pxb_pcie_mcfg_base;
> +
>   static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
>   {
>       PXBDev *pxb = convert_to_pxb(dev);
> @@ -333,7 +344,16 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
>           ds = qdev_create(NULL, TYPE_PXB_PCIE_HOST);
>   
>           object_property_set_link(OBJECT(ds), OBJECT(pxb),
> -                                 PROP_PXB_PCIE_DEV, NULL);
> +                                 PROP_PXB_PCIE_DEV, errp);
> +
> +        /* will be overwritten by firmware, but kept for readability */

Why bother the users to add this property if is the firmware responsibility
  to provide it?

> +        qdev_prop_set_uint64(ds, PCIE_HOST_MCFG_BASE,
> +            pxb->domain_nr ? pxb_pcie_mcfg_base : MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT);

We can't take Q35 PCIEXBAR address for "no domain" case. In this case put
some "none" value. 0 ?

> +        /* +1 because [bus_nr, max_bus] has (max_bus-bus_nr+1) buses */
> +        qdev_prop_set_uint64(ds, PCIE_HOST_MCFG_SIZE,
> +            pxb->domain_nr ? (pxb->max_bus - pxb->bus_nr + 1ULL) * MiB : 0);
> +        if (pxb->domain_nr)
> +            pxb_pcie_mcfg_base += ((pxb->max_bus + 1ULL) * MiB);
Can you provide the explanation for the computation? Why do we multiply
by Mib?

>   
>           bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
>       } else {
> @@ -445,6 +465,9 @@ static void pxb_pcie_dev_realize(PCIDevice *dev, Error **errp)
>           return;
>       }
>   
> +    if (0 == pxb_pcie_mcfg_base)

Please run scripts/checkpatch on the patches.

> +        pxb_pcie_mcfg_base = pc_pci_mcfg_start();
> +
>       pxb_dev_realize_common(dev, true, errp);
>   }
>   
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 02f9576..10e4801 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -177,6 +177,8 @@ static Property q35_host_props[] = {
>                        mch.below_4g_mem_size, 0),
>       DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, Q35PCIHost,
>                        mch.above_4g_mem_size, 0),
> +    /* q35 host bridge should always stay in pci domain 0 */
> +    DEFINE_PROP_UINT32("domain_nr", Q35PCIHost, domain_nr, 0),

Why do you need the property, if is always 0 ?

>       DEFINE_PROP_BOOL("x-pci-hole64-fix", Q35PCIHost, pci_hole64_fix, true),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 80bc459..ddc27ba 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -196,7 +196,8 @@ static void pci_del_option_rom(PCIDevice *pdev);
>   static uint16_t pci_default_sub_vendor_id = PCI_SUBVENDOR_ID_REDHAT_QUMRANET;
>   static uint16_t pci_default_sub_device_id = PCI_SUBDEVICE_ID_QEMU;
>   
> -static QLIST_HEAD(, PCIHostState) pci_host_bridges;
> +static QTAILQ_HEAD(, PCIHostState) pci_host_bridges =
> +    QTAILQ_HEAD_INITIALIZER(pci_host_bridges);
>   
>   int pci_bar(PCIDevice *d, int reg)
>   {
> @@ -330,7 +331,7 @@ static void pci_host_bus_register(DeviceState *host)
>   {
>       PCIHostState *host_bridge = PCI_HOST_BRIDGE(host);
>   
> -    QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
> +    QTAILQ_INSERT_TAIL(&pci_host_bridges, host_bridge, next);
>   }
>   
>   PCIBus *pci_device_root_bus(const PCIDevice *d)
> @@ -1798,7 +1799,7 @@ PciInfoList *qmp_query_pci(Error **errp)
>       PciInfoList *info, *head = NULL, *cur_item = NULL;
>       PCIHostState *host_bridge;
>   
> -    QLIST_FOREACH(host_bridge, &pci_host_bridges, next) {
> +    QTAILQ_FOREACH(host_bridge, &pci_host_bridges, next) {
>           info = g_malloc0(sizeof(*info));
>           info->value = qmp_query_pci_bus(host_bridge->bus,
>                                           pci_bus_num(host_bridge->bus));
> @@ -2493,7 +2494,7 @@ int pci_qdev_find_device(const char *id, PCIDevice **pdev)
>       PCIHostState *host_bridge;
>       int rc = -ENODEV;
>   
> -    QLIST_FOREACH(host_bridge, &pci_host_bridges, next) {
> +    QTAILQ_FOREACH(host_bridge, &pci_host_bridges, next) {
>           int tmp = pci_qdev_find_recursive(host_bridge->bus, id, pdev);
>           if (!tmp) {
>               rc = 0;
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 6894f37..7955ef9 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -209,6 +209,7 @@ void pc_memory_init(PCMachineState *pcms,
>                       MemoryRegion *rom_memory,
>                       MemoryRegion **ram_memory);
>   uint64_t pc_pci_hole64_start(void);
> +uint64_t pc_pci_mcfg_start(void);
>   qemu_irq pc_allocate_cpu_irq(void);
>   DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
>   void pc_basic_device_init(ISABus *isa_bus, qemu_irq *gsi,
> diff --git a/include/hw/pci-bridge/pci_expander_bridge.h b/include/hw/pci-bridge/pci_expander_bridge.h
> new file mode 100644
> index 0000000..870c4cd
> --- /dev/null
> +++ b/include/hw/pci-bridge/pci_expander_bridge.h
> @@ -0,0 +1,11 @@
> +#ifndef HW_PCI_EXPANDER_H
> +#define HW_PCI_EXPANDER_H
> +
> +#define PROP_PXB_PCIE_DEV "pxbdev"
> +
> +#define PROP_PXB_PCIE_DOMAIN_NR "domain_nr"
> +#define PROP_PXB_BUS_NR "bus_nr"
> +
> +uint64_t pxb_pcie_mcfg_hole(void);
> +
> +#endif
> diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
> index 8f4ddde..432e569 100644
> --- a/include/hw/pci-host/q35.h
> +++ b/include/hw/pci-host/q35.h
> @@ -69,6 +69,7 @@ typedef struct Q35PCIHost {
>       /*< public >*/
>   
>       bool pci_hole64_fix;
> +    uint32_t domain_nr;
>       MCHPCIState mch;
>   } Q35PCIHost;
>   
> diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
> index ba31595..a5617cf 100644
> --- a/include/hw/pci/pci_host.h
> +++ b/include/hw/pci/pci_host.h
> @@ -47,7 +47,7 @@ struct PCIHostState {
>       uint32_t config_reg;
>       PCIBus *bus;
>   
> -    QLIST_ENTRY(PCIHostState) next;
> +    QTAILQ_ENTRY(PCIHostState) next;
>   };
>   
>   typedef struct PCIHostBridgeClass {

Please see if you can split this patch into several for the next version.

Thanks,
Marcel
