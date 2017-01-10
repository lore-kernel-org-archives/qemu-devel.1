Received: from eggs.gnu.org ([2001:4830:134:3::10]:46315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cR3Ws-0002pI-0q
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 16:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cR3Wp-0002Bb-0p
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 16:00:26 -0500
References: <1483049536-21548-1-git-send-email-hpoussin@reactos.org>
	<1483049536-21548-2-git-send-email-hpoussin@reactos.org>
	<20170102230125.GE12761@umbus.fritz.box>
	<20170110051358-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <e8bfb20d-f912-1079-83e8-0791e6bca8cb@reactos.org>
Date: Tue, 10 Jan 2017 22:00:01 +0100
MIME-Version: 1.0
In-Reply-To: <20170110051358-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6] pci: add pci_vga_type(),
 giving the device name of the chosen VGA device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Giancarlo Teodori <gteodori@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

Le 10/01/2017 =E0 04:14, Michael S. Tsirkin a =E9crit :
> On Tue, Jan 03, 2017 at 10:01:25AM +1100, David Gibson wrote:
>> On Thu, Dec 29, 2016 at 11:12:11PM +0100, Herv=E9 Poussineau wrote:
>>> This is in fact a split of pci_vga_init() function in two parts.
>>>
>>> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>
>>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>>
>> I think it needs Michael or someone to merge it though.
>
> Do we have to keep poking at pci_vga_type?
> I'd rather people just used -device for everything.

On some machine, I want to be able to specify on which PCI slot is added =
the graphic card.
- Either the machine code is able to get the pci_vga_type, to be able to =
do itself a pci_create_simple(bus, PCI_DEVFN(...), vga_type) [this patch]
- Or we need to add a pci_vga_init_with_address(int devfn)

What do you prefer?

Herv=E9

>
>>> ---
>>>  hw/pci/pci.c         | 22 ++++++++++++++++------
>>>  include/hw/pci/pci.h |  1 +
>>>  2 files changed, 17 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index 24fae16..0d5a862 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -1816,19 +1816,19 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, P=
CIBus *rootbus,
>>>      return pci_dev;
>>>  }
>>>
>>> -PCIDevice *pci_vga_init(PCIBus *bus)
>>> +const char *pci_vga_type(void)
>>>  {
>>>      switch (vga_interface_type) {
>>>      case VGA_CIRRUS:
>>> -        return pci_create_simple(bus, -1, "cirrus-vga");
>>> +        return "cirrus-vga";
>>>      case VGA_QXL:
>>> -        return pci_create_simple(bus, -1, "qxl-vga");
>>> +        return "qxl-vga";
>>>      case VGA_STD:
>>> -        return pci_create_simple(bus, -1, "VGA");
>>> +        return "VGA";
>>>      case VGA_VMWARE:
>>> -        return pci_create_simple(bus, -1, "vmware-svga");
>>> +        return "vmware-svga";
>>>      case VGA_VIRTIO:
>>> -        return pci_create_simple(bus, -1, "virtio-vga");
>>> +        return "virtio-vga";
>>>      case VGA_NONE:
>>>      default: /* Other non-PCI types. Checking for unsupported types =
is already
>>>                  done in vl.c. */
>>> @@ -1836,6 +1836,16 @@ PCIDevice *pci_vga_init(PCIBus *bus)
>>>      }
>>>  }
>>>
>>> +PCIDevice *pci_vga_init(PCIBus *bus)
>>> +{
>>> +    const char *vga_type =3D pci_vga_type();
>>> +    if (vga_type) {
>>> +        return pci_create_simple(bus, -1, vga_type);
>>> +    } else {
>>> +        return NULL;
>>> +    }
>>> +}
>>> +
>>>  /* Whether a given bus number is in range of the secondary
>>>   * bus of the given bridge device. */
>>>  static bool pci_secondary_bus_in_range(PCIDevice *dev, int bus_num)
>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>> index 772692f..aa8d014 100644
>>> --- a/include/hw/pci/pci.h
>>> +++ b/include/hw/pci/pci.h
>>> @@ -420,6 +420,7 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBu=
s *rootbus,
>>>                                 const char *default_model,
>>>                                 const char *default_devaddr);
>>>
>>> +const char *pci_vga_type(void);
>>>  PCIDevice *pci_vga_init(PCIBus *bus);
>>>
>>>  int pci_bus_num(PCIBus *s);
>>
>> --
>> David Gibson			| I'll have my music baroque, and my code
>> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _ot=
her_
>> 				| _way_ _around_!
>> http://www.ozlabs.org/~dgibson
>
>
>
