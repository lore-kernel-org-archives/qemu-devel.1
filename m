Received: from eggs.gnu.org ([209.51.188.92]:57214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gqntS-0008OQ-54
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:43:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gqntQ-000170-U2
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 18:43:14 -0500
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-3-david@redhat.com>
	<83c38b9c-4b61-0067-2053-cdfe34b128bf@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c4fb3400-3d6d-5294-1129-415a2367619b@redhat.com>
Date: Tue, 5 Feb 2019 00:43:08 +0100
MIME-Version: 1.0
In-Reply-To: <83c38b9c-4b61-0067-2053-cdfe34b128bf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 2/6] s390x/pci: Fix
 hotplugging of PCI bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 04.02.19 23:48, Collin Walling wrote:
> On 1/30/19 10:57 AM, David Hildenbrand wrote:
>> When hotplugging a PCI bridge right now to the root port, we resolve
>> pci_get_bus(pdev)->parent_dev, which results in a SEGFAULT. Hotpluggin=
g
>> really only works right now when hotplugging to another bridge.
>>
>> Instead, we have to properly check if we are already at the root.
>>
>> Let's cleanup the code while at it a bit and factor out updating the
>> subordiante bus number into a separate function. The check for
>=20
> s/subordiante/subordinate
>=20
>> "old_nr < nr" is right now not strictly necessary, but makes it more
>> obvious what is actually going on.
>>
>> Most probably fixing up the topology is not our responsibility when
>> hotplugging. The guest has to sort this out. But let's keep it for now
>> and only fix current code to not crash.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   hw/s390x/s390-pci-bus.c | 28 +++++++++++++++++++---------
>>   1 file changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index b7c4613fde..9b5c5fff60 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -843,6 +843,21 @@ static void s390_pcihost_pre_plug(HotplugHandler =
*hotplug_dev, DeviceState *dev,
>>       }
>>   }
>>  =20
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
>> +} > +
>>   static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceSta=
te *dev,
>>                                 Error **errp)
>>   {
>> @@ -851,26 +866,21 @@ static void s390_pcihost_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
>>       S390PCIBusDevice *pbdev =3D NULL;
>>  =20
>>       if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>> -        BusState *bus;
>>           PCIBridge *pb =3D PCI_BRIDGE(dev);
>> -        PCIDevice *pdev =3D PCI_DEVICE(dev);
>>  =20
>> +        pdev =3D PCI_DEVICE(dev);
>>           pci_bridge_map_irq(pb, dev->id, s390_pci_map_irq);
>>           pci_setup_iommu(&pb->sec_bus, s390_pci_dma_iommu, s);
>>  =20
>> -        bus =3D BUS(&pb->sec_bus);
>> -        qbus_set_hotplug_handler(bus, DEVICE(s), errp);
>> +        qbus_set_hotplug_handler(BUS(&pb->sec_bus), DEVICE(s), errp);
>>  =20
>>           if (dev->hotplugged) {
>>               pci_default_write_config(pdev, PCI_PRIMARY_BUS,
>>                                        pci_dev_bus_num(pdev), 1);
>>               s->bus_no +=3D 1;
>>               pci_default_write_config(pdev, PCI_SECONDARY_BUS, s->bus=
_no, 1);
>> -            do {
>> -                pdev =3D pci_get_bus(pdev)->parent_dev;
>> -                pci_default_write_config(pdev, PCI_SUBORDINATE_BUS,
>> -                                         s->bus_no, 1);
>> -            } while (pci_get_bus(pdev) && pci_dev_bus_num(pdev));
>> +
>> +            s390_pci_update_subordinate(pdev, s->bus_no);
>>           }
>>       } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>>           pdev =3D PCI_DEVICE(dev);
>>
>=20
> Looks good to me...
>=20

Thanks for the review!!

> Reviewed-by: Collin Walling <walling@linux.ibm.com>
>=20
> Side note: unrelated to the changes here -- and if you can clarify for
> me -- any idea why we do s->bus_no +=3D 1? This throws me off a bit and
> begs me to ask what exactly is the S390pciState object suppose to
> represent? (My guess is that it is representative of the entire PCI
> topology, and we increment the bus_no to denote the subordinate bus
> number?)
On x86, the bios builds the topology. On spapr and s390x, the firmware
builds the topology. The topology is constructed in a way that all buses
can be found ("tree traversed") from the root.

In a clean topology, each bridge has it's dedicated number.

primary: The bus the bridge is attached to
secondary: The bus the bridge spans up
subordinate: The highest bus number that can be found from this bridge

So when we add a new bridge, we have to assign a new "global" bus number
for the topology. This is what we do here. So we denote actually the
"seconardy" bus nr here, which we propagate as "subordinate" up to the ro=
ot.

But this is the interesting point: When hotplugging on x86 and on power,
the _guest_ is responsible for rebuilding the topology. Not the bios,
not the firmware. No numbers are assigned. Code like we have here does
not exist for them.


And most probably this is also broken on s390x: When hotplugging a
bridge, we should not mess with the topology (because as Thomas noted,
we can easily break the topology so the search does no longer work
reliably).

But this is your task to find out :)

Although it sounds like I "speak PCI", I really only have a rough idea
how it all (is supposed to) work(s).

So while I am fixing the current code, we should find out next if we can
drop this "messing with the topology on hotplug" completely. Or e.g.
rework it to have standby numbers we can use when hotplugging ...


>=20
> (let me know if these kind of discussions are too noisy and deemed
> inappropriate for the mailing list, and I'll start pestering you off-
> list instead)

Not at all. This allows other people to learn as well and also to jump
in in case I make up things.

--=20

Thanks,

David / dhildenb
