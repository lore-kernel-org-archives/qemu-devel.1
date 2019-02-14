Received: from eggs.gnu.org ([209.51.188.92]:34905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1guA8B-0004zh-Fq
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 01:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1guA8A-0004J1-5r
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 01:04:19 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1guA89-0004DP-Cc
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 01:04:18 -0500
Received: by mail-pg1-x541.google.com with SMTP id q206so2483694pgq.4
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 22:04:09 -0800 (PST)
References: <20190214050808.16653-1-david@gibson.dropbear.id.au>
	<20190214050808.16653-3-david@gibson.dropbear.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <a7779d7b-f83f-d681-b210-823b66e0f035@ozlabs.ru>
Date: Thu, 14 Feb 2019 17:04:03 +1100
MIME-Version: 1.0
In-Reply-To: <20190214050808.16653-3-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] pcie: Don't allow extended config
 space access via conventional PCI bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, mst@redhat.com, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com



On 14/02/2019 16:08, David Gibson wrote:
> In hardware it's possible, if odd, to have a configuration like:
> 
> PCIe host bridge
> \- PCIe to PCI bridge
>    \- PCI to PCIe bridge
>       \- PCIe device
> 
> The PCIe extended configuration space on the device won't be
> accessible to the host, because the cycles can't traverse the
> conventional PCI bus on the way there.
> 
> However, if we attempt to model that configuration under qemu,
> extended config access on the device *will* work, because
> pci_config_size() depends only on whether the device itself is PCIe
> capable.
> 
> This patch fixes that modelling error by adding a flag to each
> PCI/PCIe bus instance indicating whether extended config space
> accesses are possible on it.  It will always be false for conventional
> PCI buses, for PCIe buses it will be true if and only if the parent
> bus also has the flag set.
> 
> AIUI earlier attempts to correct this have been rejected, because they
> involved expensively traversing the whole bus hierarchy on each config
> access.  This approach avoids that by computing the value as the bus
> hierarchy is constructed, meaning we only need a single bit check when
> we actually attempt the config access.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/pci/pci.c             | 32 ++++++++++++++++++++++++++++++++
>  include/hw/pci/pci.h     |  4 +++-
>  include/hw/pci/pci_bus.h |  2 ++
>  3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index f6d8b337db..f2d9dff9ee 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -120,6 +120,25 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
>      vmstate_register(NULL, -1, &vmstate_pcibus, bus);
>  }
>  
> +static void pcie_bus_realize(BusState *qbus, Error **errp)
> +{
> +    PCIBus *bus = PCI_BUS(qbus);
> +
> +    pci_bus_realize(qbus, errp);
> +
> +    /* a PCI-E bus can supported extended config space if it's the
> +     * root bus, or if the bus/bridge above it does as well */
> +    if (pci_bus_is_root(bus)) {
> +        bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
> +    } else {
> +        PCIBus *parent_bus = pci_get_bus(bus->parent_dev);
> +
> +        if (pci_bus_extended_config_space(parent_bus)) {
> +            bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
> +        }
> +    }
> +}
> +
>  static void pci_bus_unrealize(BusState *qbus, Error **errp)
>  {
>      PCIBus *bus = PCI_BUS(qbus);
> @@ -166,6 +185,13 @@ static const TypeInfo pci_bus_info = {
>      .class_init = pci_bus_class_init,
>  };
>  
> +static void pcie_bus_class_init(ObjectClass *klass, void *data)
> +{
> +    BusClass *k = BUS_CLASS(klass);
> +
> +    k->realize = pcie_bus_realize;
> +}
> +
>  static const TypeInfo pcie_interface_info = {
>      .name          = INTERFACE_PCIE_DEVICE,
>      .parent        = TYPE_INTERFACE,
> @@ -174,6 +200,7 @@ static const TypeInfo pcie_interface_info = {
>  static const TypeInfo conventional_pci_interface_info = {
>      .name          = INTERFACE_CONVENTIONAL_PCI_DEVICE,
>      .parent        = TYPE_INTERFACE,
> +    .class_init    = pcie_bus_class_init,
>  };
>  
>  static const TypeInfo pcie_bus_info = {
> @@ -391,6 +418,11 @@ bool pci_bus_is_express(PCIBus *bus)
>      return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
>  }
>  
> +bool pci_bus_extended_config_space(PCIBus *bus)
> +{
> +    return !!(bus->flags & PCI_BUS_EXTENDED_CONFIG_SPACE);
> +}
> +
>  void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
>                                const char *name,
>                                MemoryRegion *address_space_mem,
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 1273deb740..919e8a6f5f 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -395,6 +395,7 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque, int pin);
>  #define TYPE_PCIE_BUS "PCIE"
>  
>  bool pci_bus_is_express(PCIBus *bus);
> +bool pci_bus_extended_config_space(PCIBus *bus);
>  void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
>                                const char *name,
>                                MemoryRegion *address_space_mem,
> @@ -754,7 +755,8 @@ static inline int pci_is_express_downstream_port(const PCIDevice *d)
>  
>  static inline uint32_t pci_config_size(const PCIDevice *d)
>  {
> -    return pci_is_express(d) ? PCIE_CONFIG_SPACE_SIZE : PCI_CONFIG_SPACE_SIZE;
> +    return (pci_is_express(d) && pci_bus_extended_config_space(pci_get_bus(d)))
> +        ? PCIE_CONFIG_SPACE_SIZE : PCI_CONFIG_SPACE_SIZE;


Since there is a selfnack anyway, I'll ask out of curiosity - can a
device sit on PCIe bus and not be PCIe itself?

The pci_is_express(d) check above just seems a little redundant,
g_assert() could probably do just that.




>  }
>  
>  static inline uint16_t pci_get_bdf(PCIDevice *dev)
> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> index 3a4d599da3..8b1e849c34 100644
> --- a/include/hw/pci/pci_bus.h
> +++ b/include/hw/pci/pci_bus.h
> @@ -23,6 +23,8 @@ typedef struct PCIBusClass {
>  enum PCIBusFlags {
>      /* This bus is the root of a PCI domain */
>      PCI_BUS_IS_ROOT                                         = 0x0001,
> +    /* PCIe extended configuration space is accessible on this bus */
> +    PCI_BUS_EXTENDED_CONFIG_SPACE                           = 0x0002,
>  };
>  
>  struct PCIBus {
> 

-- 
Alexey
