Received: from eggs.gnu.org ([209.51.188.92]:35987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gkTeV-0000l3-VU
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gkTeS-0006J9-J8
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:53:38 -0500
References: <20190116113523.9213-1-david@redhat.com>
	<20190116113523.9213-10-david@redhat.com>
	<20190118112001.4bb2cf6f@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1f1b6173-ba9f-46b8-4e54-846f48459b4d@redhat.com>
Date: Fri, 18 Jan 2019 13:53:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190118112001.4bb2cf6f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 09/10] pc: Support for PCI based memory
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On 18.01.19 11:20, Igor Mammedov wrote:
> On Wed, 16 Jan 2019 12:35:22 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> Override the PCI device hotplug handler to properly handle the
>> memory device part from the machine hotplug handler and forward to the
>> actual PCI bus hotplug handler.
>>
>> As PCI hotplug has not been properly factored out into hotplug handler=
s,
>> most magic is performed in the (un)realize functions. Also some buses =
don't
>                                                              ^^^^^^^^ p=
ls, be more specific

Last time I checked there were some TYPE_PCI_HOST_BRIDGE devices in QEMU
that would not have a hotplug handler. I *think* they are all unrelated
to x86/pc. But as I was not sure if I am missing something, I introduced
a simple error check.

>=20
>> have a PCI hotplug handler at all yet (not sure if they are actually u=
sed
>> on x86, but just to be sure).
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/i386/pc.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++=
-
>>  1 file changed, 89 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index fd0cb29ba9..62f83859fa 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -75,6 +75,7 @@
>>  #include "hw/usb.h"
>>  #include "hw/i386/intel_iommu.h"
>>  #include "hw/net/ne2000-isa.h"
>> +#include "hw/mem/memory-device.h"
>> =20
>>  /* debug PC/ISA interrupts */
>>  //#define DEBUG_IRQ
>> @@ -2224,6 +2225,84 @@ static void pc_cpu_pre_plug(HotplugHandler *hot=
plug_dev,
>>      numa_cpu_pre_plug(cpu_slot, dev, errp);
>>  }
>> =20
>> +static void pc_pci_pre_plug(HotplugHandler *hotplug_dev, DeviceState =
*dev,
>> +                            Error **errp)
>> +{
>> +    HotplugHandler *hotplug_dev2 =3D qdev_get_bus_hotplug_handler(dev=
);
>> +    Error *local_err =3D NULL;
>> +
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
>> +        if (!hotplug_dev2) {
>> +            /*
>> +             * Without a bus hotplug handler, we cannot control the p=
lug/unplug
>> +             * order. Disallow memory devices on such buses.
>> +             */
>> +            error_setg(errp, "Memory devices not supported on this bu=
s.");
>> +            return;
>> +        }
>> +        memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_de=
v),
>> +                               NULL, errp);
>> +    }
>> +
>> +    if (hotplug_dev2) {
>> +        hotplug_handler_pre_plug(hotplug_dev2, dev, errp);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return;
>> +        }
>> +    }
>> +}
>> +
>> +static void pc_pci_plug(HotplugHandler *hotplug_dev, DeviceState *dev=
,
>> +                        Error **errp)
>> +{
>> +    HotplugHandler *hotplug_dev2 =3D qdev_get_bus_hotplug_handler(dev=
);
>> +    Error *local_err =3D NULL;
>> +
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
>> +        memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
>> +    }
>> +
>> +    if (hotplug_dev2) {
>> +        hotplug_handler_plug(hotplug_dev2, dev, &local_err);
>> +    }
>> +
>> +    if (local_err) {
>> +        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
>> +            memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_=
dev));
>> +        }
>> +    }
>> +    error_propagate(errp, local_err);
>> +}
>> +
>> +static void pc_pci_unplug_request(HotplugHandler *hotplug_dev, Device=
State *dev,
>> +                                  Error **errp)
>> +{
>> +    HotplugHandler *hotplug_dev2 =3D qdev_get_bus_hotplug_handler(dev=
);
>> +
>> +    if (hotplug_dev2) {
>> +        hotplug_handler_unplug_request(hotplug_dev2, dev, errp);
>> +    }
>> +}
>> +
>> +static void pc_pci_device_unplug(HotplugHandler *hotplug_dev, DeviceS=
tate *dev,
>> +                                 Error **errp)
>> +{
>> +    HotplugHandler *hotplug_dev2 =3D qdev_get_bus_hotplug_handler(dev=
);
>> +    Error *local_err =3D NULL;
>> +
>> +    if (hotplug_dev2) {
>> +        hotplug_handler_unplug(hotplug_dev2, dev, &local_err);
>> +    }
>> +
>> +    if (!local_err) {
>> +        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
>> +            memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_=
dev));
>> +        }
>> +    }
>> +    error_propagate(errp, local_err);
>> +}
>> +
>>  static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev=
,
>>                                            DeviceState *dev, Error **e=
rrp)
>>  {
>> @@ -2231,6 +2310,8 @@ static void pc_machine_device_pre_plug_cb(Hotplu=
gHandler *hotplug_dev,
>>          pc_memory_pre_plug(hotplug_dev, dev, errp);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>          pc_cpu_pre_plug(hotplug_dev, dev, errp);
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> +        pc_pci_pre_plug(hotplug_dev, dev, errp);
>>      }
>>  }
>> =20
>> @@ -2241,6 +2322,8 @@ static void pc_machine_device_plug_cb(HotplugHan=
dler *hotplug_dev,
>>          pc_memory_plug(hotplug_dev, dev, errp);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>          pc_cpu_plug(hotplug_dev, dev, errp);
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> +        pc_pci_plug(hotplug_dev, dev, errp);
>>      }
>>  }
>> =20
>> @@ -2251,6 +2334,8 @@ static void pc_machine_device_unplug_request_cb(=
HotplugHandler *hotplug_dev,
>>          pc_memory_unplug_request(hotplug_dev, dev, errp);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>          pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> +        pc_pci_unplug_request(hotplug_dev, dev, errp);
>>      } else {
>>          error_setg(errp, "acpi: device unplug request for not support=
ed device"
>>                     " type: %s", object_get_typename(OBJECT(dev)));
>> @@ -2264,6 +2349,8 @@ static void pc_machine_device_unplug_cb(HotplugH=
andler *hotplug_dev,
>>          pc_memory_unplug(hotplug_dev, dev, errp);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>          pc_cpu_unplug_cb(hotplug_dev, dev, errp);
>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>> +        pc_pci_device_unplug(hotplug_dev, dev, errp);
>>      } else {
>>          error_setg(errp, "acpi: device unplug for not supported devic=
e"
>>                     " type: %s", object_get_typename(OBJECT(dev)));
>> @@ -2274,7 +2361,8 @@ static HotplugHandler *pc_get_hotpug_handler(Mac=
hineState *machine,
>>                                               DeviceState *dev)
>>  {
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
>> -        object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>> +        object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
>> +        object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> why all PCI devices instead of virtio-pmem-pci one?
>=20

Last time I tried to include "hw/virtio/virtio-pci.h" in pc.c it
resulted in an inclusion error madness. But this should be easy to fix I
guess. (the basic idea of this patch is the important bit)

And I just tried to include and it seems to result in no errors right now=
.

>>          return HOTPLUG_HANDLER(machine);
>>      }
>> =20
>=20


--=20

Thanks,

David / dhildenb
