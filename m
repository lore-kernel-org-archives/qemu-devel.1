Received: from eggs.gnu.org ([2001:4830:134:3::10]:42415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d0T5w-0007qW-O7
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d0T5t-0001Vb-F8
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:23:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1d0T5t-0001VS-60
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:22:57 -0400
References: <20170417215916.12431-1-ehabkost@redhat.com>
	<20170417215916.12431-3-ehabkost@redhat.com>
	<20170418035101.GJ12235@umbus.fritz.box>
	<20170418114826.GI25239@thinpad.lan.raisama.net>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <ba7863c5-af0f-b8d4-fec6-4c9515317467@redhat.com>
Date: Tue, 18 Apr 2017 16:22:47 +0300
MIME-Version: 1.0
In-Reply-To: <20170418114826.GI25239@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 2/7] pci: Change pci_bus_init() 'parent'
 parameter to PCIHostState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 04/18/2017 02:48 PM, Eduardo Habkost wrote:
> On Tue, Apr 18, 2017 at 01:51:02PM +1000, David Gibson wrote:
>> On Mon, Apr 17, 2017 at 06:59:11PM -0300, Eduardo Habkost wrote:
>>> pci_bus_init() already requires 'parent' to be a PCI_HOST_BRIDGE object,
>>> so change the parameter type to reflect that.
>>>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Marcel Apfelbaum <marcel@redhat.com>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>>
>> I had to do some looking to convince myself this wouldn't break P2P
>> bridges.
>>
>> I wonder if we should rename pci_bus_init() / pci_bus_new() to make it
>> clearer that they're about creating a whole new PCI domain, and not
>> for a new bus within an existing domain.
>
> Good point. The current naming is confusing. I only knew the
> change was safe because pci_bus_new() would crash if 'parent'
> wasn't a PCI_HOST_BRIDGE. But I took some time to find the other
> places where PCI buses could be created, and I'm not sure yet if
> I found all of them.
>
> Is there any other code that creates TYPE_PCI_BUS objects, except
> for the ones touched by this series and pci_bridge_initfn()?
>

pxb and pxb-pcie devices have a built-in PCI/PCIe bus,
but I saw them handled by another patch.

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>


Thanks,
Marcel

>>
>>> ---
>>>  hw/pci/pci.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index 25118fb91d..d9535c0bdc 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -362,7 +362,7 @@ const char *pci_root_bus_path(PCIDevice *dev)
>>>      return rootbus->qbus.name;
>>>  }
>>>
>>> -static void pci_bus_init(PCIBus *bus, DeviceState *parent,
>>> +static void pci_bus_init(PCIBus *bus, PCIHostState *phb,
>>>                           MemoryRegion *address_space_mem,
>>>                           MemoryRegion *address_space_io,
>>>                           uint8_t devfn_min)
>>> @@ -375,7 +375,7 @@ static void pci_bus_init(PCIBus *bus, DeviceState *parent,
>>>      /* host bridge */
>>>      QLIST_INIT(&bus->child);
>>>
>>> -    pci_host_bus_register(PCI_HOST_BRIDGE(host));
>>> +    pci_host_bus_register(phb);
>>>  }
>>>
>>>  bool pci_bus_is_express(PCIBus *bus)
>>> @@ -394,8 +394,9 @@ void pci_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
>>>                           MemoryRegion *address_space_io,
>>>                           uint8_t devfn_min, const char *typename)
>>>  {
>>> +    PCIHostState *phb = PCI_HOST_BRIDGE(parent);
>>>      qbus_create_inplace(bus, bus_size, typename, parent, name);
>>> -    pci_bus_init(bus, parent, address_space_mem, address_space_io, devfn_min);
>>> +    pci_bus_init(bus, phb, address_space_mem, address_space_io, devfn_min);
>>>  }
>>>
>>>  PCIBus *pci_bus_new(DeviceState *parent, const char *name,
>>> @@ -403,10 +404,11 @@ PCIBus *pci_bus_new(DeviceState *parent, const char *name,
>>>                      MemoryRegion *address_space_io,
>>>                      uint8_t devfn_min, const char *typename)
>>>  {
>>> +    PCIHostState *phb = PCI_HOST_BRIDGE(parent);
>>>      PCIBus *bus;
>>>
>>>      bus = PCI_BUS(qbus_create(typename, parent, name));
>>> -    pci_bus_init(bus, parent, address_space_mem, address_space_io, devfn_min);
>>> +    pci_bus_init(bus, phb, address_space_mem, address_space_io, devfn_min);
>>>      return bus;
>>>  }
>>>
>>
>> --
>> David Gibson			| I'll have my music baroque, and my code
>> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
>> 				| _way_ _around_!
>> http://www.ozlabs.org/~dgibson
>
>
>
