Received: from eggs.gnu.org ([2001:4830:134:3::10]:58463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gaNWS-0007sk-95
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gaNWN-00079q-Kc
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 11:19:36 -0500
Date: Fri, 21 Dec 2018 11:19:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181221111904-mutt-send-email-mst@kernel.org>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
	<154535253055.862554.10471167343589360987.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154535253055.862554.10471167343589360987.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 03/15] pci: allow cleanup/unregistration of
 PCI root buses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

On Fri, Dec 21, 2018 at 01:35:30AM +0100, Greg Kurz wrote:
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
> 
> This adds cleanup counterparts to pci_register_root_bus(),
> pci_root_bus_new(), and pci_bus_irqs().
> 
> These cleanup routines are needed in the case of hotpluggable
> PCIHostBridge implementations. Currently we can rely on the
> object_unparent()'ing of the PCIHostState recursively unparenting
> and cleaning up it's child buses, but we need explicit calls
> to also:
> 
>   1) remove the PCIHostState from pci_host_bridges global list.
>      otherwise, we risk accessing freed memory when we access
>      the list later
>   2) clean up memory allocated in pci_bus_irqs()
> 
> Both are handled outside the context of any particular bus or
> host bridge's init/realize functions, making it difficult to
> avoid the need for explicit cleanup functions without remodeling
> how PCIHostBridges are created. So keep it simple and just add
> them for now.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/pci/pci.c         |   33 +++++++++++++++++++++++++++++++++
>  include/hw/pci/pci.h |    3 +++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index efb5ce196ffb..16354f91206c 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -333,6 +333,13 @@ static void pci_host_bus_register(DeviceState *host)
>      QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
>  }
>  
> +static void pci_host_bus_unregister(DeviceState *host)
> +{
> +    PCIHostState *host_bridge = PCI_HOST_BRIDGE(host);
> +
> +    QLIST_REMOVE(host_bridge, next);
> +}
> +
>  PCIBus *pci_device_root_bus(const PCIDevice *d)
>  {
>      PCIBus *bus = pci_get_bus(d);
> @@ -379,6 +386,11 @@ static void pci_root_bus_init(PCIBus *bus, DeviceState *parent,
>      pci_host_bus_register(parent);
>  }
>  
> +static void pci_bus_uninit(PCIBus *bus)
> +{
> +    pci_host_bus_unregister(BUS(bus)->parent);
> +}
> +
>  bool pci_bus_is_express(PCIBus *bus)
>  {
>      return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
> @@ -413,6 +425,12 @@ PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
>      return bus;
>  }
>  
> +void pci_root_bus_cleanup(PCIBus *bus)
> +{
> +    pci_bus_uninit(bus);
> +    object_unparent(OBJECT(bus));
> +}
> +
>  void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
>                    void *irq_opaque, int nirq)
>  {
> @@ -423,6 +441,15 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
>      bus->irq_count = g_malloc0(nirq * sizeof(bus->irq_count[0]));
>  }
>  
> +void pci_bus_irqs_cleanup(PCIBus *bus)
> +{
> +    bus->set_irq = NULL;
> +    bus->map_irq = NULL;
> +    bus->irq_opaque = NULL;
> +    bus->nirq = 0;
> +    g_free(bus->irq_count);
> +}
> +
>  PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
>                                pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
>                                void *irq_opaque,
> @@ -439,6 +466,12 @@ PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
>      return bus;
>  }
>  
> +void pci_unregister_root_bus(PCIBus *bus)
> +{
> +    pci_bus_irqs_cleanup(bus);
> +    pci_root_bus_cleanup(bus);
> +}
> +
>  int pci_bus_num(PCIBus *s)
>  {
>      return PCI_BUS_GET_CLASS(s)->bus_num(s);
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index e6514bba23aa..8998e3be3390 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -405,8 +405,10 @@ PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
>                           MemoryRegion *address_space_mem,
>                           MemoryRegion *address_space_io,
>                           uint8_t devfn_min, const char *typename);
> +void pci_root_bus_cleanup(PCIBus *bus);
>  void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
>                    void *irq_opaque, int nirq);
> +void pci_bus_irqs_cleanup(PCIBus *bus);
>  int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
>  /* 0 <= pin <= 3 0 = INTA, 1 = INTB, 2 = INTC, 3 = INTD */
>  int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
> @@ -417,6 +419,7 @@ PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
>                                MemoryRegion *address_space_io,
>                                uint8_t devfn_min, int nirq,
>                                const char *typename);
> +void pci_unregister_root_bus(PCIBus *bus);
>  void pci_bus_set_route_irq_fn(PCIBus *, pci_route_irq_fn);
>  PCIINTxRoute pci_device_route_intx_to_irq(PCIDevice *dev, int pin);
>  bool pci_intx_route_changed(PCIINTxRoute *old, PCIINTxRoute *new);
