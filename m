Received: from eggs.gnu.org ([2001:4830:134:3::10]:53761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d0tyV-0006uj-N7
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 14:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1d0tyR-0006A0-L6
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 14:05:07 -0400
References: <20170328021651.19350-1-david@gibson.dropbear.id.au>
	<20170328021651.19350-3-david@gibson.dropbear.id.au>
	<20170417183045.GA7078@thinpad.lan.raisama.net>
	<20170418022151.GD12235@umbus.fritz.box>
	<20170418143312.GN25239@thinpad.lan.raisama.net>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <8d11bfb6-da4a-9972-112e-311859e0bc5b@redhat.com>
Date: Wed, 19 Apr 2017 21:04:55 +0300
MIME-Version: 1.0
In-Reply-To: <20170418143312.GN25239@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.10 2/3] pci: Allow host bridges to
 override PCI/PCIe hybrid device behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: aik@ozlabs.ru, lersek@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com

On 04/18/2017 05:33 PM, Eduardo Habkost wrote:
> On Tue, Apr 18, 2017 at 12:21:51PM +1000, David Gibson wrote:
>> On Mon, Apr 17, 2017 at 03:30:46PM -0300, Eduardo Habkost wrote:
>>> On Tue, Mar 28, 2017 at 01:16:50PM +1100, David Gibson wrote:
>>>> Currently PCI/PCIe hybrid devices - that is, devices which can appear as
>>>> either plain PCI or PCIe depending on where they're attached - will only
>>>> appear in PCIe mode if they're attached to a PCIe bus via a root port or
>>>> downstream port.
>>>>
>>>> This is correct for "standard" PCIe setups, but there are some platforms
>>>> which need different behaviour (notably "pseries" whose paravirtualized
>>>> PCI host bridges have some idiosyncracies).
>>>>
>>>> This patch allows the host bridge to override the normal behaviour.
>>>>
>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>> ---
>>>>  hw/pci/pci.c              | 11 +++++++++--
>>>>  include/hw/pci/pci_host.h |  1 +
>>>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>> index 779787b..ac68065 100644
>>>> --- a/hw/pci/pci.c
>>>> +++ b/hw/pci/pci.c
>>>> @@ -392,9 +392,16 @@ bool pci_bus_is_root(PCIBus *bus)
>>>>
>>>>  bool pci_allow_hybrid_pcie(PCIDevice *pci_dev)
>>>
>>> Why are we asking the device about allowing hybrid pcie, and not
>>> the bus itself? Shouldn't we be able to query this before the
>>> device is plugged, and before pci_dev->bus is even set?
>>>
>>> In other words, why pci_allow_hyberid_pcie() and
>>> pci_device_get_bus() get a PCIDevice* argument instead of a
>>> PCIBus* argument?
>>
>> Ah good point.  I made it a PCIDevice simply for convenience, but
>> you're right we should be able to query before the device is plugged.
>
> Understood.
>
>>
>>>
>>>>  {
>>>> -    PCIBus *bus = pci_dev->bus;
>>>> +    PCIHostState *host_bridge = PCI_HOST_BRIDGE(pci_device_root_bus(pci_dev)->qbus.parent);
>>>
>>> There's something I don't understand completely: what exactly
>>> guarantees that pci_device_root_bus(...)->qbus.parent is always
>>> going to be a PCI_HOST_BRIDGE?
>>
>> Well, by definition whatever is above the root bus isn't PCI, which
>> pretty much means it has to be a PCI host bridge.  A machine could
>> break this assumption, but I think that would be a bug.  We use this
>> same pattern to find a PCI device's (or bus's) host bridge in other
>> places - there doesn't appear to be another way.
>

Agreed, the root bus is always exposed by (some kind of) a host bridge.

> After taking a better look at the way PCI buses are created, I
> agree it's OK. Maybe a
>   PCIHostState *pci_host_bridge(PCIBus *bus)
> helper would be useful?
>

For sure.

> Anyway, both pci_bus_root_bus() and pci_host_bridge() could be
> implemented as follow-ups if you prefer, so:
>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>

Thanks,
Marcel

> But I still have another suggestion:
>
>>
>>>> +    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_GET_CLASS(host_bridge);
>>>> +
>>>> +    if (hc->allow_hybrid_pcie) {
>>>> +        return hc->allow_hybrid_pcie(host_bridge, pci_dev);
>>>> +    } else {
>>>> +        PCIBus *bus = pci_dev->bus;
>>>>
>>>> -    return pci_bus_is_express(bus) && !pci_bus_is_root(bus);
>>>> +        return pci_bus_is_express(bus) && !pci_bus_is_root(bus);
>
> Maybe it's a matter of personal taste, but instead of requiring
> an explicit check for NULL hc->allow_hybrid_pcie, why not set a
> default hc->allow_hybrid_pcie() implementation on
> TYPE_PCI_HOST_BRIDGE that returns
> (pci_bus_is_express(bus) && !pci_bus_is_root(bus))?
>
