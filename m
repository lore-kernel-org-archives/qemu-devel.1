Received: from eggs.gnu.org ([2001:4830:134:3::10]:60129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d0uOo-0004Jh-AH
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 14:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d0uOl-00005p-5X
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 14:32:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1d0uOk-00005T-T9
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 14:32:15 -0400
References: <20170418221724.5707-1-ehabkost@redhat.com>
	<20170418221724.5707-3-ehabkost@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <81474c63-c8b2-b62c-68f1-b9aca22bd0a5@redhat.com>
Date: Wed, 19 Apr 2017 21:31:57 +0300
MIME-Version: 1.0
In-Reply-To: <20170418221724.5707-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 2/6] pci: Move pci_bus_init() logic to
 pci_bus_new_inplace()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 04/19/2017 01:17 AM, Eduardo Habkost wrote:
> Instead of having 3 separate functions, just make pci_bus_new() a
> wrapper that allocates the object and calls pci_bus_new_inplace().
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/pci/pci.c | 39 +++++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 22 deletions(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 328f36cd21..0d28ee4e3f 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -357,24 +357,6 @@ const char *pci_root_bus_path(PCIDevice *dev)
>      return rootbus->qbus.name;
>  }
>
> -static void pci_bus_init(PCIBus *bus, DeviceState *parent,
> -                         MemoryRegion *address_space_mem,
> -                         MemoryRegion *address_space_io,
> -                         uint8_t devfn_min)
> -{
> -    PCIHostState *phb = PCI_HOST_BRIDGE(parent);
> -
> -    assert(PCI_FUNC(devfn_min) == 0);
> -    bus->devfn_min = devfn_min;
> -    bus->address_space_mem = address_space_mem;
> -    bus->address_space_io = address_space_io;
> -
> -    /* host bridge */
> -    QLIST_INIT(&bus->child);
> -
> -    QLIST_INSERT_HEAD(&pci_host_bridges, phb, next);
> -}
> -
>  bool pci_bus_is_express(PCIBus *bus)
>  {
>      return object_dynamic_cast(OBJECT(bus), TYPE_PCIE_BUS);
> @@ -391,8 +373,20 @@ void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
>                           MemoryRegion *address_space_io,
>                           uint8_t devfn_min, const char *typename)
>  {
> +    PCIHostState *phb = PCI_HOST_BRIDGE(parent);
> +
>      qbus_create_inplace(bus, bus_size, typename, parent, name);
> -    pci_bus_init(bus, parent, address_space_mem, address_space_io, devfn_min);
> +
> +    assert(PCI_FUNC(devfn_min) == 0);
> +    bus->devfn_min = devfn_min;
> +    bus->address_space_mem = address_space_mem;
> +    bus->address_space_io = address_space_io;
> +
> +    /* host bridge */
> +    QLIST_INIT(&bus->child);
> +
> +    QLIST_INSERT_HEAD(&pci_host_bridges, phb, next);
> +
>  }
>
>  PCIBus *pci_bus_new(DeviceState *parent, const char *name,
> @@ -400,10 +394,11 @@ PCIBus *pci_bus_new(DeviceState *parent, const char *name,
>                      MemoryRegion *address_space_io,
>                      uint8_t devfn_min, const char *typename)
>  {
> -    PCIBus *bus;
> +    size_t bus_size = object_type_get_instance_size(typename);
> +    PCIBus *bus = g_malloc(bus_size);

I am not sure what is the "win" here. Maybe because I don't personally
like the 2 "low level" lines above. Maybe we have some QOM primitive to do that for us?
At least we should use g_malloc0?

Thanks,
Marcel

>
> -    bus = PCI_BUS(qbus_create(typename, parent, name));
> -    pci_bus_init(bus, parent, address_space_mem, address_space_io, devfn_min);
> +    pci_bus_new_inplace(bus, bus_size, parent, name, address_space_mem,
> +                        address_space_io, devfn_min, typename);
>      return bus;
>  }
>
>
