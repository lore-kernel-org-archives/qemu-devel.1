Received: from eggs.gnu.org ([209.51.188.92]:33553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmGvg-00059Z-ON
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:42:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gmGvf-0003WK-9g
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:42:48 -0500
References: <20190122125133.1191-1-david@redhat.com>
	<20190122125133.1191-3-david@redhat.com>
	<17de6f00-2c91-4654-cc8f-d07ef85c48de@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <29d0a220-e814-6b91-ae4e-835326e91fcb@redhat.com>
Date: Wed, 23 Jan 2019 12:42:32 +0100
MIME-Version: 1.0
In-Reply-To: <17de6f00-2c91-4654-cc8f-d07ef85c48de@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/2] s390x/pci: Fix hotplugging of PCI
 bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 23.01.19 12:16, Thomas Huth wrote:
> On 2019-01-22 13:51, David Hildenbrand wrote:
>> When hotplugging a PCI bridge right now to the root port, we resolve
>> pci_get_bus(pdev)->parent_dev, which results in a SEGFAULT. Hotpluggin=
g
>> really only works right now when hotplugging to another bridge.
>>
>> Instead, we have to properly check if we are already at the root.
>>
>> Let's cleanup the code while at it a bit and factor out updating the
>> subordiante bus number into a separate function. The check for
>> "old_nr < nr" is right now not strictly necessary, but makes it more
>> obvious what is actually going on.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/s390-pci-bus.c | 28 +++++++++++++++++++---------
>>  1 file changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index b7c4613fde..9b5c5fff60 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -843,6 +843,21 @@ static void s390_pcihost_pre_plug(HotplugHandler =
*hotplug_dev, DeviceState *dev,
>>      }
>>  }
>> =20
>> +static void s390_pci_update_subordinate(PCIDevice *dev, uint32_t nr)
>> +{
>> +    uint32_t old_nr;
>> +
>> +    pci_default_write_config(dev, PCI_SUBORDINATE_BUS, nr, 1);
>> +    while (!pci_bus_is_root(pci_get_bus(dev))) {
>> +        dev =3D pci_get_bus(dev)->parent_dev;
>> +
>> +        old_nr =3D pci_default_read_config(dev, PCI_SUBORDINATE_BUS, =
1);
>> +        if (old_nr < nr) {
>> +            pci_default_write_config(dev, PCI_SUBORDINATE_BUS, nr, 1)=
;
>> +        }
>> +    }
>> +}
>> +
>>  static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceStat=
e *dev,
>>                                Error **errp)
>>  {
>> @@ -851,26 +866,21 @@ static void s390_pcihost_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
>>      S390PCIBusDevice *pbdev =3D NULL;
>> =20
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>> -        BusState *bus;
>>          PCIBridge *pb =3D PCI_BRIDGE(dev);
>> -        PCIDevice *pdev =3D PCI_DEVICE(dev);
>> =20
>> +        pdev =3D PCI_DEVICE(dev);
>=20
> Why not keep the direct assignment?

We have the same local variable in that function already. I'm just
reusing it.

>=20
>>          pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
>>          pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
>> =20
>> -        bus =3D BUS(&pb->sec_bus);
>> -        qbus_set_hotplug_handler(bus, DEVICE(s), errp);
>> +        qbus_set_hotplug_handler(BUS(&pb->sec_bus), DEVICE(s), errp);
>> =20
>>          if (dev->hotplugged) {
>>              pci_default_write_config(pdev, PCI_PRIMARY_BUS,
>>                                       pci_dev_bus_num(pdev), 1);
>>              s->bus_no +=3D 1;
>>              pci_default_write_config(pdev, PCI_SECONDARY_BUS, s->bus_=
no, 1);
>> -            do {
>> -                pdev =3D pci_get_bus(pdev)->parent_dev;
>> -                pci_default_write_config(pdev, PCI_SUBORDINATE_BUS,
>> -                                         s->bus_no, 1);
>> -            } while (pci_get_bus(pdev) && pci_dev_bus_num(pdev));
>> +
>> +            s390_pci_update_subordinate(pdev, s->bus_no);
>=20
>=20
> While your changes look OK at a first glance, and certainly fix the
> crash, I wonder whether this is the right thing to do here at all. Why
> does the hypervisor set up the all the bridge registers here? I'd rathe=
r
> expect that this is the job of the guest after it detects a hot-plugged
> device?

I honestly have no idea who is responsible for that. I can see that
spapr does not seem to handle hotplugging the way s390x does. I was
hoping that Colin maybe know why we have to do that on s390x this way.
At least this patch does not change the behavior but only fixes it.

>=20
> Also I'm not sure whether the numbering is right in every case. Let's
> use the example from the URL that you've mentioned in the cover letter
> (http://www.science.unitn.it/~fiorella/guidelinux/tlk/node76.html step =
4):
>=20
> Assume that you hot-plug another bridge "5" to "Bridge 2". If I get the
> code right, the setup will now look like this:

Yes, this is what I would expect! This implies that any bus in the
hierarchy lies between Sec and Sub. But that there might be multiple
candidates, which feels wrong as you correctly say.

>=20
>                CPU
>                 |
>   --------------+-------------- Bus 0
>                 |
>                 |  Pri=3D0
>                BR1 Sec=3D1
>                 |  Sub=3D5
>                 |
>   ------+-------+----------+--- Bus 1
>         |                  |
>         |  Pri=3D1           |  Pri=3D1
>        BR3 Sec=3D3          BR2 Sec=3D2
>         |  Sub=3D4           |  Sub=3D5
>         |                  |
>   --+---+--- Bus 3       --+-+- Bus 2
>     |                        |
>     |  Pri=3D3                 |  Pri=3D2
>    BR4 Sec=3D4                BR5 Sec=3D5
>     |  Sub=3D4                 |  Sub=3D5
>     |                        |
>   --+---- Bus 4            --+-- Bus 5
>=20
> Requests to bus 3 and 4 are now also routed through to bus 2 and 5. Tha=
t
> sounds wrong to me. Or is this how hot-plugging of PCI bridges is
> supposed to work??
>=20

Learning more about PCI

Quoting from [2]

"PCIe enumeration is generally done twice. First, your BIOS (UEFI or
otherwise) will do it, to figure out who's present and how much memory
they need. This data can then be passed on to the host OS who can take
it as-is, but Linux and Windows often perform their own enumeration
procedure ..."

"The custom software part comes in during this enumeration process and
that is you must reserve ahead of time PCI Bus numbers, and memory
segments for potential future devices -- this is sometimes called 'bus
padding'. This avoids the need to re-enumerate the bus in the future
which can often not be done without disruption to the system ..."


So if I understand correctly, the BIOS/Firmware/QEMU only provides the
initial state. After that, the guest is responsible to manage it,
especially to manage hotplug.

However, I wonder if it would also be up to BIOS/Firmware/QEMU to do
this bus padding or if it is completely on the OS side. And if
hotplugged devices simply have all 0's.

What about special cases where hotplug happends after BIOS enumerated
but before the guest started?

[2]
https://electronics.stackexchange.com/questions/208767/does-pcie-hotplug-=
actually-work-in-practice


--=20

Thanks,

David / dhildenb
