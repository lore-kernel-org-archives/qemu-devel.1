Received: from eggs.gnu.org ([2001:4830:134:3::10]:60673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fKib7-0003gt-Ol
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fKib4-0004As-J8
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:03:25 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:39070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fKib4-00049x-91
	for qemu-devel@nongnu.org; Mon, 21 May 2018 07:03:22 -0400
Received: by mail-wm0-x234.google.com with SMTP id f8-v6so25921140wmc.4
	for <qemu-devel@nongnu.org>; Mon, 21 May 2018 04:03:21 -0700 (PDT)
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-2-git-send-email-whois.zihan.yang@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <aa70021d-242e-5923-9e37-154a93d36e95@gmail.com>
Date: Mon, 21 May 2018 14:03:17 +0300
MIME-Version: 1.0
In-Reply-To: <1526801333-30613-2-git-send-email-whois.zihan.yang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC 1/3] pci_expander_bridge: reserve enough mcfg
 space for pxb host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi Zihan,
On 05/20/2018 10:28 AM, Zihan Yang wrote:


Thank you for posting the patches!
For the next version please add a cover letter so we can discuss cross 
patchesideas.

> To put each pxb into separate pci domain, we need to reserve enough MCFG space
> for each pxb host in the main memory.

Right

>   First try to put them under 4G, before
> pci_hole_start, if there are too many hosts, try to put them into main memory
> above 4G, before pci_hole64_start. We should check if there is enough memory
> to reserve for them

I don't think we should try to place the MMCFGs before 4G even if there
is enough room. Is better to place them always after 4G.

>
> Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
> ---
>   hw/i386/pc.c                                |  5 ++
>   hw/pci-bridge/pci_expander_bridge.c         | 96 ++++++++++++++++++++++++++++-
>   include/hw/pci-bridge/pci_expander_bridge.h |  7 +++
>   3 files changed, 107 insertions(+), 1 deletion(-)
>   create mode 100644 include/hw/pci-bridge/pci_expander_bridge.h
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d768930..98097fd 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -34,6 +34,7 @@
>   #include "hw/ide.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pci_bus.h"
> +#include "hw/pci-bridge/pci_expander_bridge.h"
>   #include "hw/nvram/fw_cfg.h"
>   #include "hw/timer/hpet.h"
>   #include "hw/smbios/smbios.h"
> @@ -1466,6 +1467,7 @@ uint64_t pc_pci_hole64_start(void)
>       PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>       MachineState *ms = MACHINE(pcms);
>       uint64_t hole64_start = 0;
> +    int pxb_hosts;
>   
>       if (pcmc->has_reserved_memory && ms->device_memory->base) {
>           hole64_start = ms->device_memory->base;
> @@ -1473,6 +1475,9 @@ uint64_t pc_pci_hole64_start(void)
>               hole64_start += memory_region_size(&ms->device_memory->mr);
>           }
>       } else {
> +        /* make sure enough space is left for pxb host, otherwise fail */
> +        pxb_hosts = pxb_get_expander_hosts();
> +        g_assert (pxb_hosts <= 0 || pcms->above_4g_mem_size >= (pxb_hosts << 28ULL));

"above_4g_mem" PCI hole it is reserved for PCI devices hotplug. We 
cannot use if for
MMCFGs. What I think we can do is to "move" the 64 bit PCI hole after 
the MMCFGs.
So the layout of over 4G space will be:

[RAM hotplug][MMCFGs][PCI hotplug]...

>           hole64_start = 0x100000000ULL + pcms->above_4g_mem_size;
>       }
>   
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index e62de42..8409c87 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -12,10 +12,13 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> +#include "qapi/visitor.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pci_bus.h"
>   #include "hw/pci/pci_host.h"
>   #include "hw/pci/pci_bridge.h"
> +#include "hw/pci-host/q35.h"
> +#include "hw/pci-bridge/pci_expander_bridge.h"
>   #include "qemu/range.h"
>   #include "qemu/error-report.h"
>   #include "sysemu/numa.h"
> @@ -57,7 +60,13 @@ static PXBDev *convert_to_pxb(PCIDevice *dev)
>   
>   static GList *pxb_dev_list;
>   
> +typedef struct PXBPCIHost {
> +    PCIExpressHost parent_obj;
> +} PXBPCIHost;
> +
>   #define TYPE_PXB_HOST "pxb-host"
> +#define PXB_HOST_DEVICE(obj) \
> +     OBJECT_CHECK(PXBPCIHost, (obj), TYPE_PXB_HOST)
>   
>   static int pxb_bus_num(PCIBus *bus)
>   {
> @@ -111,6 +120,14 @@ static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,
>       return bus->bus_path;
>   }
>   
> +static void pxb_host_get_mmcfg_size(Object *obj, Visitor *v, const char *name,
> +                                    void *opaque, Error **errp)
> +{
> +    PCIExpressHost *e = PCIE_HOST_BRIDGE(obj);
> +
> +    visit_type_uint64(v, name, &e->size, errp);
> +}
> +
>   static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
>   {
>       const PCIHostState *pxb_host;
> @@ -142,6 +159,80 @@ static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
>       return NULL;
>   }
>   
> +static Object *pxb_get_i386_pci_host(void)
> +{
> +    PCIHostState *host;
> +
> +    host = OBJECT_CHECK(PCIHostState,
> +                        object_resolve_path("/machine/i440fx", NULL),
> +                        TYPE_PCI_HOST_BRIDGE);
> +    if (!host) {
> +        host = OBJECT_CHECK(PCIHostState,
> +                            object_resolve_path("/machine/q35", NULL),
> +                            TYPE_PCI_HOST_BRIDGE);
> +    }
> +
> +    return OBJECT(host);
> +}
> +

The about function appears also in  hw/i386/acpi-build.c, you may wantto 
re-use.

> +int pxhb_cnt = 0;
> +
> +/* -1 means to exclude q35 host */
> +#define MCFG_IN_PCI_HOLE (((IO_APIC_DEFAULT_ADDRESS - MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT) >> 28) - 1)
> +
I don't understand the above. If you need  a single MMCFG size you can 
use MCH_HOST_BRIDGE_PCIEXBAR_MAX.

> +int pxb_get_expander_hosts(void)
> +{
> +    return pxhb_cnt - MCFG_IN_PCI_HOLE;
> +}

Do you need the  number of existing expander hosts? We have a 
pxbdev_list, just query it.

> +
> +/* Dirty workaround */
> +static void modify_q35_pci_hole(void)
> +{
> +    Object *pci_host;
> +    Q35PCIHost *s;
> +
> +    pci_host = pxb_get_i386_pci_host();
> +    g_assert(pci_host);
> +    s = Q35_HOST_DEVICE(pci_host);
> +
> +    ++pxhb_cnt;
> +    if (pxhb_cnt <= MCFG_IN_PCI_HOLE) {
> +        range_set_bounds(&s->mch.pci_hole,
> +            MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT + ((1 + pxhb_cnt) << 28),
> +            IO_APIC_DEFAULT_ADDRESS - 1);
> +    }
> +
> +    // leave pci hole64 to acpi build part
> +}
> +
> +static void pxb_host_initfn(Object *obj)
> +{
> +    PCIHostState *phb = PCI_HOST_BRIDGE(obj);
> +
> +    memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops, phb,
> +                          "pci-conf-idx", 4);
> +    memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops, phb,
> +                          "pci-conf-data", 4);
> +
> +    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint64",
> +                         pxb_host_get_mmcfg_size,
> +                         NULL, NULL, NULL, NULL);
> +
> +    /* Leave enough space for the biggest MCFG BAR */
> +    /* TODO. Since pxb host is just an expander bridge without an mch,
> +     * we modify the range in q35 host. It should be workable as it is
> +     * before acpi build, although it is dirty
> +     */
> +    modify_q35_pci_hole();

The above will need to change. We move the pci hole, not resize it.
I am not sure this is the right place to handle it, maybe we add a new 
property
right beside pci_hole ones (extra-mmcfg?) and default it to 0.

> +}
> +
> +/* default value does not matter as guest firmware will overwrite it */
> +static Property pxb_host_props[] = {
> +    DEFINE_PROP_UINT64(PCIE_HOST_MCFG_BASE, PXBPCIHost, parent_obj.base_addr,
> +                        MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT),

You cannot use the MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT as it is in use
by the "main" root complex MMCFG. Actually I don't think we can come up
with a valid default.


> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>   static void pxb_host_class_init(ObjectClass *class, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(class);
> @@ -149,6 +240,7 @@ static void pxb_host_class_init(ObjectClass *class, void *data)
>       PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
>   
>       dc->fw_name = "pci";
> +    dc->props = pxb_host_props;
>       /* Reason: Internal part of the pxb/pxb-pcie device, not usable by itself */
>       dc->user_creatable = false;
>       sbc->explicit_ofw_unit_address = pxb_host_ofw_unit_address;
> @@ -157,7 +249,9 @@ static void pxb_host_class_init(ObjectClass *class, void *data)
>   
>   static const TypeInfo pxb_host_info = {
>       .name          = TYPE_PXB_HOST,
> -    .parent        = TYPE_PCI_HOST_BRIDGE,
> +    .parent        = TYPE_PCIE_HOST_BRIDGE,

Be aware this is used by both pxb and pxb-pcie devices, I think you 
should split the type
for each one and let the pxb's one as before.

> +    .instance_size = sizeof(PXBPCIHost),
> +    .instance_init = pxb_host_initfn,
>       .class_init    = pxb_host_class_init,
>   };
>   
> diff --git a/include/hw/pci-bridge/pci_expander_bridge.h b/include/hw/pci-bridge/pci_expander_bridge.h
> new file mode 100644
> index 0000000..d48ddb1
> --- /dev/null
> +++ b/include/hw/pci-bridge/pci_expander_bridge.h
> @@ -0,0 +1,7 @@
> +#ifndef HW_PCI_EXPANDER_H
> +#define HW_PCI_EXPANDER_H
> +
> +/* return the number of pxb hosts that resides in the main memory above 4G */
> +int pxb_get_expander_hosts(void);
> +
> +#endif

Thanks,
Marcel
