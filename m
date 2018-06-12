Received: from eggs.gnu.org ([2001:4830:134:3::10]:38415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSjZi-0002JH-MS
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSjZe-0007nB-LS
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:43:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fSjZe-0007mz-F0
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:43:02 -0400
Date: Tue, 12 Jun 2018 16:43:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180612163301-mutt-send-email-mst@kernel.org>
References: <1528794804-6289-1-git-send-email-whois.zihan.yang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528794804-6289-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: Re: [Qemu-devel] [RFC v2 1/3] pci_expander_bridge: add type
 TYPE_PXB_PCIE_HOST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Tue, Jun 12, 2018 at 05:13:22PM +0800, Zihan Yang wrote:
> The inner host bridge created by pxb-pcie is TYPE_PXB_PCI_HOST by default,
> add a new type TYPE_PXB_PCIE_HOST to better utilize the ECAM of PCIe
> 
> Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>

I have a concern that there are lots of new properties
added here, I'm not sure how are upper layers supposed to
manage them all.

E.g. bus_nr supplied in several places, domain_nr for which
it's not clear how it is supposed to be allocated, etc.

Can the management interface be simplified?
Ideally we wouldn't have to teach libvirt new tricks,
just generalize pxb support slightly.

> ---
>  hw/pci-bridge/pci_expander_bridge.c | 118 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 114 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index e62de42..448b9fb 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -15,10 +15,12 @@
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bus.h"
>  #include "hw/pci/pci_host.h"
> +#include "hw/pci/pcie_host.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "qemu/range.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/numa.h"
> +#include "qapi/visitor.h"
>  
>  #define TYPE_PXB_BUS "pxb-bus"
>  #define PXB_BUS(obj) OBJECT_CHECK(PXBBus, (obj), TYPE_PXB_BUS)
> @@ -45,7 +47,10 @@ typedef struct PXBDev {
>      PCIDevice parent_obj;
>      /*< public >*/
>  
> -    uint8_t bus_nr;
> +    bool sep_domain;    /* whether it resides in separate PCI segment */
> +    uint32_t domain_nr; /* PCI domain(segment) number, should be 0 if sep_domain is false */
> +    uint8_t max_bus;    /* max number of buses to use */
> +    uint8_t bus_nr;     /* should be 0 when in separate domain */
>      uint16_t numa_node;
>  } PXBDev;
>  
> @@ -58,6 +63,18 @@ static PXBDev *convert_to_pxb(PCIDevice *dev)
>  static GList *pxb_dev_list;
>  
>  #define TYPE_PXB_HOST "pxb-host"
> +#define TYPE_PXB_PCIE_HOST "pxb-pcie-host"
> +#define PXB_PCIE_HOST_DEVICE(obj) \
> +     OBJECT_CHECK(PXBPCIEHost, (obj), TYPE_PXB_PCIE_HOST)
> +
> +typedef struct PXBPCIEHost {
> +    PCIExpressHost parent_obj;
> +
> +    /* should only inherit from PXBDev */
> +    uint32_t domain_nr;
> +    uint8_t bus_nr;
> +    uint8_t max_bus;
> +} PXBPCIEHost;
>  
>  static int pxb_bus_num(PCIBus *bus)
>  {
> @@ -111,6 +128,31 @@ static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,
>      return bus->bus_path;
>  }
>  
> +/* Use a dedicated function for PCIe since pxb-host does
> + * not have a domain_nr field */
> +static const char *pxb_pcie_host_root_bus_path(PCIHostState *host_bridge,
> +                                          PCIBus *rootbus)
> +{
> +    if (!pci_bus_is_express(rootbus)) {
> +        /* pxb-pcie-host cannot reside on a PCI bus */
> +        return NULL;
> +    }
> +    PXBBus *bus = PXB_PCIE_BUS(rootbus);
> +
> +    snprintf(bus->bus_path, 8, "%04lx:%02x",
> +             object_property_get_uint((Object *)host_bridge, "domain_nr", NULL),
> +             pxb_bus_num(rootbus));
> +    return bus->bus_path;
> +}
> +
> +static void pxb_pcie_host_get_mmcfg_size(Object *obj, Visitor *v, const char *name,
> +                                    void *opaque, Error **errp)
> +{
> +    PCIExpressHost *e = PCIE_HOST_BRIDGE(obj);
> +
> +    visit_type_uint64(v, name, &e->size, errp);
> +}
> +
>  static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
>  {
>      const PCIHostState *pxb_host;
> @@ -142,6 +184,30 @@ static char *pxb_host_ofw_unit_address(const SysBusDevice *dev)
>      return NULL;
>  }
>  
> +static void pxb_pcie_host_initfn(Object *obj)
> +{
> +    PCIHostState *phb = PCI_HOST_BRIDGE(obj);
> +
> +    memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops, phb,
> +                          "pci-conf-idx", 4);
> +    memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops, phb,
> +                          "pci-conf-data", 4);
> +
> +    object_property_add(obj, PCIE_HOST_MCFG_SIZE, "uint64",
> +                         pxb_pcie_host_get_mmcfg_size,
> +                         NULL, NULL, NULL, NULL);
> +
> +}
> +
> +static Property pxb_pcie_host_props[] = {
> +    DEFINE_PROP_UINT64(PCIE_HOST_MCFG_BASE, PXBPCIEHost, parent_obj.base_addr,
> +                        PCIE_BASE_ADDR_UNMAPPED),
> +    DEFINE_PROP_UINT32("domain_nr", PXBPCIEHost, domain_nr, 0),
> +    DEFINE_PROP_UINT8("bus_nr", PXBPCIEHost, bus_nr, 0),
> +    DEFINE_PROP_UINT8("max_bus", PXBPCIEHost, max_bus, 255),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void pxb_host_class_init(ObjectClass *class, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(class);
> @@ -155,12 +221,34 @@ static void pxb_host_class_init(ObjectClass *class, void *data)
>      hc->root_bus_path = pxb_host_root_bus_path;
>  }
>  
> +static void pxb_pcie_host_class_init(ObjectClass *class, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(class);
> +    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_CLASS(class);
> +    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
> +
> +    dc->fw_name = "pci";
> +    dc->props = pxb_pcie_host_props;
> +    /* Reason: Internal part of the pxb/pxb-pcie device, not usable by itself */
> +    dc->user_creatable = false;
> +    sbc->explicit_ofw_unit_address = pxb_host_ofw_unit_address;
> +    hc->root_bus_path = pxb_pcie_host_root_bus_path;
> +}
> +
>  static const TypeInfo pxb_host_info = {
>      .name          = TYPE_PXB_HOST,
>      .parent        = TYPE_PCI_HOST_BRIDGE,
>      .class_init    = pxb_host_class_init,
>  };
>  
> +static const TypeInfo pxb_pcie_host_info = {
> +    .name          = TYPE_PXB_PCIE_HOST,
> +    .parent        = TYPE_PCIE_HOST_BRIDGE,
> +    .instance_size = sizeof(PXBPCIEHost),
> +    .instance_init = pxb_pcie_host_initfn,
> +    .class_init    = pxb_pcie_host_class_init,
> +};
> +
>  /*
>   * Registers the PXB bus as a child of pci host root bus.
>   */
> @@ -205,7 +293,10 @@ static gint pxb_compare(gconstpointer a, gconstpointer b)
>  {
>      const PXBDev *pxb_a = a, *pxb_b = b;
>  
> -    return pxb_a->bus_nr < pxb_b->bus_nr ? -1 :
> +    /* check domain_nr, then bus_nr */
> +    return pxb_a->domain_nr < pxb_b->domain_nr ? -1 :
> +           pxb_a->domain_nr > pxb_b->domain_nr ?  1 :
> +           pxb_a->bus_nr < pxb_b->bus_nr ? -1 :
>             pxb_a->bus_nr > pxb_b->bus_nr ?  1 :
>             0;
>  }
> @@ -228,10 +319,17 @@ static void pxb_dev_realize_common(PCIDevice *dev, bool pcie, Error **errp)
>          dev_name = dev->qdev.id;
>      }
>  
> -    ds = qdev_create(NULL, TYPE_PXB_HOST);
>      if (pcie) {
> +        /* either in sep_domain or stay in domain 0 */
> +        g_assert (pxb->sep_domain || pxb->domain_nr == 0);
> +        g_assert (pxb->max_bus >= pxb->bus_nr);
> +        ds = qdev_create(NULL, TYPE_PXB_PCIE_HOST);
> +        qdev_prop_set_uint8(ds, "bus_nr", pxb->bus_nr); //TODO.
> +        qdev_prop_set_uint8(ds, "max_bus", pxb->max_bus);
> +        qdev_prop_set_uint8(ds, "domain_nr", pxb->domain_nr);
>          bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
>      } else {
> +        ds = qdev_create(NULL, TYPE_PXB_HOST);
>          bus = pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PXB_BUS);
>          bds = qdev_create(BUS(bus), "pci-bridge");
>          bds->id = dev_name;
> @@ -294,6 +392,17 @@ static Property pxb_dev_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +static Property pxb_pcie_dev_properties[] = {
> +    /* Note: 0 is not a legal PXB bus number. */
> +    DEFINE_PROP_UINT8("bus_nr", PXBDev, bus_nr, 0),
> +    DEFINE_PROP_UINT16("numa_node", PXBDev, numa_node, NUMA_NODE_UNASSIGNED),
> +    DEFINE_PROP_BOOL("sep_domain", PXBDev, sep_domain, false),
> +    DEFINE_PROP_UINT32("domain_nr", PXBDev, domain_nr, 0),
> +    DEFINE_PROP_UINT8("max_bus", PXBDev, max_bus, 255),
> +
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void pxb_dev_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -344,7 +453,7 @@ static void pxb_pcie_dev_class_init(ObjectClass *klass, void *data)
>      k->class_id = PCI_CLASS_BRIDGE_HOST;
>  
>      dc->desc = "PCI Express Expander Bridge";
> -    dc->props = pxb_dev_properties;
> +    dc->props = pxb_pcie_dev_properties;
>      dc->hotpluggable = false;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>  }
> @@ -365,6 +474,7 @@ static void pxb_register_types(void)
>      type_register_static(&pxb_bus_info);
>      type_register_static(&pxb_pcie_bus_info);
>      type_register_static(&pxb_host_info);
> +    type_register_static(&pxb_pcie_host_info);
>      type_register_static(&pxb_dev_info);
>      type_register_static(&pxb_pcie_dev_info);
>  }
> -- 
> 2.7.4
