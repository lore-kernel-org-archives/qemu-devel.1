Received: from eggs.gnu.org ([2001:4830:134:3::10]:54853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gUAc4-0006BC-PE
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gUAc1-0003n9-LK
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:19:44 -0500
References: <20181128145455.11733-1-david@redhat.com>
	<20181203170127.349625de.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <66e4849d-acbc-c329-de96-e0000ab468b2@redhat.com>
Date: Tue, 4 Dec 2018 14:19:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181203170127.349625de.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] qdev: Let the hotplug_unplug() caller
 delete the device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org

On 03.12.18 17:01, Cornelia Huck wrote:
> On Wed, 28 Nov 2018 15:54:55 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> When unplugging a device, at one point the device will be destroyed
>> via object_unparent(). This will, one the one hand, unrealize the
>> device hierarchy to be removed, and on the other hand, destroy/free th=
e
>> device hierarchy.
>>
>> When chaining interrupt handlers, we want to overwrite a bus hotplug
>=20
> s/interrupt/hotplug/, no?

Yes indeed! (no idea what my brain was coprocessing while writing this
description)

>=20
>> handler by the machine hotplug handler, to be able to perform
>> some part of the plug/unplug and to forward the calls to the bus hotpl=
ug
>> handler.
>>
>> For now, the bus hotplug handler would trigger an object_unparent(), n=
ot
>> allowing us to perform some unplug action on a device after we forward=
ed
>> the call to the bus hotplug handler. The device would be gone at that
>> point.
>>
>> hotplug_handler_unplug(dev) -> calls machine_unplug_handler()
>>     machine_unplug_handler(dev) {
>>         /* eventually do unplug stuff */
>>         bus_unplug_handler(dev) -> calls object_unparent(dev)
>>         /* dev is gone, we can't do more unplug stuff */
>>     }
>>
>> So move the object_unparent() to the original caller of the unplug. Fo=
r
>> now, keep the unrealize() at the original places of the
>> object_unparent().
>>
>> hotplug_handler_unplug(dev) -> calls machine_unplug_handler()
>>     machine_unplug_handler(dev) {
>>         /* eventually do unplug stuff */
>>         bus_unplug_handler(dev) -> calls unrealize(dev)
>>         /* we can do more unplug stuff but device already unrealized *=
/
>>     }
>> object_unparent(dev)
>>
>> In the long run, every unplug action should be factored out of the
>> unrealize() function into the unplug handler (especially for PCI). The=
n
>> we can get rid of the additonal unrealize() calls and object_unparent(=
)
>> will properly unrealize the device hierarchy after the device has been
>> unplugged.
>>
>> hotplug_handler_unplug(dev) -> calls machine_unplug_handler()
>>     machine_unplug_handler(dev) {
>>         /* eventually do unplug stuff */
>>         bus_unplug_handler(dev) -> only unplugs, does not unrealize
>>         /* we can do more unplug stuff */
>>     }
>> object_unparent(dev) -> will unrealize
>>
>>
>> The original approach was suggested by Igor Mammedov for the PCI
>> part, but I extended it to all hotplug handlers. I consider this one
>> step into the right direction.
>=20
> From my limited overview of the hotplug infrastructure, this looks
> reasonable.
>=20
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> I might still be missing some cases, but I want to get some feedback f=
irst
>> if this makes sense.
>>
>> This is based on the series:
>>     [PATCH v3 00/11] pci: hotplug handler reworks=E2=80=8B
>>
>>  hw/acpi/cpu.c            |  1 +
>>  hw/acpi/memory_hotplug.c |  1 +
>>  hw/acpi/pcihp.c          |  3 ++-
>>  hw/core/qdev.c           |  3 +--
>>  hw/i386/pc.c             |  5 ++---
>>  hw/pci/pcie.c            |  3 ++-
>>  hw/pci/shpc.c            |  3 ++-
>>  hw/ppc/spapr.c           |  4 ++--
>>  hw/ppc/spapr_pci.c       |  3 ++-
>>  hw/s390x/css-bridge.c    |  2 +-
>>  hw/s390x/s390-pci-bus.c  | 12 ++++++++++--
>>  qdev-monitor.c           |  9 +++++++--
>>  12 files changed, 33 insertions(+), 16 deletions(-)
>=20
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 9abd49a9dc..a84e80f6dd 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -988,7 +988,11 @@ static void s390_pcihost_unplug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
>>                                   pbdev->fh, pbdev->fid);
>>      bus =3D pci_get_bus(pci_dev);
>>      devfn =3D pci_dev->devfn;
>> -    object_unparent(OBJECT(pci_dev));
>> +    if (OBJECT(pci_dev) =3D=3D OBJECT(dev)) {
>> +        object_property_set_bool(OBJECT(pci_dev), false, "realized", =
NULL);
>> +    } else {
>> +        object_unparent(OBJECT(pci_dev));
>> +    }
>>      s390_pci_msix_free(pbdev);
>>      s390_pci_iommu_free(s, bus, devfn);
>>      pbdev->pdev =3D NULL;
>> @@ -997,7 +1001,11 @@ out:
>>      pbdev->fid =3D 0;
>>      QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
>>      g_hash_table_remove(s->zpci_table, &pbdev->idx);
>> -    object_unparent(OBJECT(pbdev));
>> +    if (OBJECT(pbdev) =3D=3D OBJECT(dev)) {
>> +        object_property_set_bool(OBJECT(pbdev), false, "realized", NU=
LL);
>> +    } else {
>> +        object_unparent(OBJECT(pbdev));
>> +    }
>=20
> That's a bit... ugly. Not really your code, but the inherent ugliness
> of the architecture it uncovers; we basically have two devices paired
> with each other and we need to unplug them both, regardless on which of
> the two unplug is called.
>=20
> Maybe add a comment explaining it a bit?
>=20

Yes, can do. My plan is to refactor this to have two independent
hotunplug calls (and therefore two independent hotplug handler chains) .
One step at a time :)

> It looks correct, though; but I haven't tested it :)
>=20
> Nothing bad jumped out at me from the rest of your patch, either.
>=20

Thanks for having a look!

--=20

Thanks,

David / dhildenb
