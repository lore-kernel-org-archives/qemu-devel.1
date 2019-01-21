Received: from eggs.gnu.org ([209.51.188.92]:39628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1glX16-00076x-7K
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:41:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1glX14-0000zn-8D
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:41:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1glX13-0000zU-Tm
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:41:18 -0500
References: <20190116113523.9213-1-david@redhat.com>
	<20190116113523.9213-10-david@redhat.com>
	<20190118112001.4bb2cf6f@redhat.com>
	<1f1b6173-ba9f-46b8-4e54-846f48459b4d@redhat.com>
	<20190118153758.2c45a31a@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <918f547f-59e7-a1b3-316d-f3f3c225ad9d@redhat.com>
Date: Mon, 21 Jan 2019 11:31:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190118153758.2c45a31a@redhat.com>
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

On 18.01.19 15:37, Igor Mammedov wrote:
> On Fri, 18 Jan 2019 13:53:14 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 18.01.19 11:20, Igor Mammedov wrote:
>>> On Wed, 16 Jan 2019 12:35:22 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>  =20
>>>> Override the PCI device hotplug handler to properly handle the
>>>> memory device part from the machine hotplug handler and forward to t=
he
>>>> actual PCI bus hotplug handler.
>>>>
>>>> As PCI hotplug has not been properly factored out into hotplug handl=
ers,
>>>> most magic is performed in the (un)realize functions. Also some buse=
s don't =20
>>>                                                              ^^^^^^^^=
 pls, be more specific =20
>>
>> Last time I checked there were some TYPE_PCI_HOST_BRIDGE devices in QE=
MU
>> that would not have a hotplug handler. I *think* they are all unrelate=
d
>> to x86/pc. But as I was not sure if I am missing something, I introduc=
ed
>> a simple error check.
>>
>>>  =20
>>>> have a PCI hotplug handler at all yet (not sure if they are actually=
 used
>>>> on x86, but just to be sure).
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  hw/i386/pc.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++=
++-
>>>>  1 file changed, 89 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>>> index fd0cb29ba9..62f83859fa 100644
>>>> --- a/hw/i386/pc.c
>>>> +++ b/hw/i386/pc.c
>>>> @@ -75,6 +75,7 @@
>>>>  #include "hw/usb.h"
>>>>  #include "hw/i386/intel_iommu.h"
>>>>  #include "hw/net/ne2000-isa.h"
>>>> +#include "hw/mem/memory-device.h"
>>>> =20
>>>>  /* debug PC/ISA interrupts */
>>>>  //#define DEBUG_IRQ
>>>> @@ -2224,6 +2225,84 @@ static void pc_cpu_pre_plug(HotplugHandler *h=
otplug_dev,
>>>>      numa_cpu_pre_plug(cpu_slot, dev, errp);
>>>>  }
>>>> =20
>>>> +static void pc_pci_pre_plug(HotplugHandler *hotplug_dev, DeviceStat=
e *dev,
>>>> +                            Error **errp)
>>>> +{
>>>> +    HotplugHandler *hotplug_dev2 =3D qdev_get_bus_hotplug_handler(d=
ev);
>>>> +    Error *local_err =3D NULL;
>>>> +
>>>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
>>>> +        if (!hotplug_dev2) {
>>>> +            /*
>>>> +             * Without a bus hotplug handler, we cannot control the=
 plug/unplug
>>>> +             * order. Disallow memory devices on such buses.
>>>> +             */
>>>> +            error_setg(errp, "Memory devices not supported on this =
bus.");
>>>> +            return;
>>>> +        }
>>>> +        memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_=
dev),
>>>> +                               NULL, errp);
>>>> +    }
>>>> +
>>>> +    if (hotplug_dev2) {
>>>> +        hotplug_handler_pre_plug(hotplug_dev2, dev, errp);
>>>> +        if (local_err) {
>>>> +            error_propagate(errp, local_err);
>>>> +            return;
>>>> +        }
>>>> +    }
>>>> +}
>>>> +
>>>> +static void pc_pci_plug(HotplugHandler *hotplug_dev, DeviceState *d=
ev,
>>>> +                        Error **errp)
>>>> +{
>>>> +    HotplugHandler *hotplug_dev2 =3D qdev_get_bus_hotplug_handler(d=
ev);
>>>> +    Error *local_err =3D NULL;
>>>> +
>>>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
>>>> +        memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev)=
);
>>>> +    }
>>>> +
>>>> +    if (hotplug_dev2) {
>>>> +        hotplug_handler_plug(hotplug_dev2, dev, &local_err);
>>>> +    }
>>>> +
>>>> +    if (local_err) {
>>>> +        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
>>>> +            memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplu=
g_dev));
>>>> +        }
>>>> +    }
>>>> +    error_propagate(errp, local_err);
>>>> +}
>>>> +
>>>> +static void pc_pci_unplug_request(HotplugHandler *hotplug_dev, Devi=
ceState *dev,
>>>> +                                  Error **errp)
>>>> +{
>>>> +    HotplugHandler *hotplug_dev2 =3D qdev_get_bus_hotplug_handler(d=
ev);
>>>> +
>>>> +    if (hotplug_dev2) {
>>>> +        hotplug_handler_unplug_request(hotplug_dev2, dev, errp);
>>>> +    }
>>>> +}
>>>> +
>>>> +static void pc_pci_device_unplug(HotplugHandler *hotplug_dev, Devic=
eState *dev,
>>>> +                                 Error **errp)
>>>> +{
>>>> +    HotplugHandler *hotplug_dev2 =3D qdev_get_bus_hotplug_handler(d=
ev);
>>>> +    Error *local_err =3D NULL;
>>>> +
>>>> +    if (hotplug_dev2) {
>>>> +        hotplug_handler_unplug(hotplug_dev2, dev, &local_err);
>>>> +    }
>>>> +
>>>> +    if (!local_err) {
>>>> +        if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
>>>> +            memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplu=
g_dev));
>>>> +        }
>>>> +    }
>>>> +    error_propagate(errp, local_err);
>>>> +}
>>>> +
>>>>  static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_d=
ev,
>>>>                                            DeviceState *dev, Error *=
*errp)
>>>>  {
>>>> @@ -2231,6 +2310,8 @@ static void pc_machine_device_pre_plug_cb(Hotp=
lugHandler *hotplug_dev,
>>>>          pc_memory_pre_plug(hotplug_dev, dev, errp);
>>>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>>>          pc_cpu_pre_plug(hotplug_dev, dev, errp);
>>>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>>>> +        pc_pci_pre_plug(hotplug_dev, dev, errp);
>>>>      }
>>>>  }
>>>> =20
>>>> @@ -2241,6 +2322,8 @@ static void pc_machine_device_plug_cb(HotplugH=
andler *hotplug_dev,
>>>>          pc_memory_plug(hotplug_dev, dev, errp);
>>>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>>>          pc_cpu_plug(hotplug_dev, dev, errp);
>>>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>>>> +        pc_pci_plug(hotplug_dev, dev, errp);
>>>>      }
>>>>  }
>>>> =20
>>>> @@ -2251,6 +2334,8 @@ static void pc_machine_device_unplug_request_c=
b(HotplugHandler *hotplug_dev,
>>>>          pc_memory_unplug_request(hotplug_dev, dev, errp);
>>>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>>>          pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
>>>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>>>> +        pc_pci_unplug_request(hotplug_dev, dev, errp);
>>>>      } else {
>>>>          error_setg(errp, "acpi: device unplug request for not suppo=
rted device"
>>>>                     " type: %s", object_get_typename(OBJECT(dev)));
>>>> @@ -2264,6 +2349,8 @@ static void pc_machine_device_unplug_cb(Hotplu=
gHandler *hotplug_dev,
>>>>          pc_memory_unplug(hotplug_dev, dev, errp);
>>>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>>>          pc_cpu_unplug_cb(hotplug_dev, dev, errp);
>>>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>>>> +        pc_pci_device_unplug(hotplug_dev, dev, errp);
>>>>      } else {
>>>>          error_setg(errp, "acpi: device unplug for not supported dev=
ice"
>>>>                     " type: %s", object_get_typename(OBJECT(dev)));
>>>> @@ -2274,7 +2361,8 @@ static HotplugHandler *pc_get_hotpug_handler(M=
achineState *machine,
>>>>                                               DeviceState *dev)
>>>>  {
>>>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
>>>> -        object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>>> +        object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
>>>> +        object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) { =20
>>> why all PCI devices instead of virtio-pmem-pci one?
>>>  =20
>>
>> Last time I tried to include "hw/virtio/virtio-pci.h" in pc.c it
>> resulted in an inclusion error madness. But this should be easy to fix=
 I
>> guess. (the basic idea of this patch is the important bit)
>>
>> And I just tried to include and it seems to result in no errors right =
now
> I'd prefer override for concrete devices only and the rest PCI devices
> handled as they used to. That also should simplify hotplug handlers you
> are adding here.

Yes, will do for the next round as long as gates to inclusion hell don't
open up again :)

Thanks!


--=20

Thanks,

David / dhildenb
