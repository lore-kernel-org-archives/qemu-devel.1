Received: from eggs.gnu.org ([2001:4830:134:3::10]:59326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fO1rG-0000WK-Dt
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fO1rD-0003a1-6s
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:13:46 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-5-david@redhat.com>
	<20180530150806.061c26b9@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5dcb16e5-b9b9-d07d-dfe3-98724e911f83@redhat.com>
Date: Wed, 30 May 2018 16:13:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180530150806.061c26b9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 04/14] pc: prepare for multi stage
 hotplug handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On 30.05.2018 15:08, Igor Mammedov wrote:
> On Thu, 17 May 2018 10:15:17 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> For multi stage hotplug handlers, we'll have to do some error handling
>> in some hotplug functions, so let's use a local error variable (except
>> for unplug requests).
> I'd split out introducing local error into separate patch
> so patch would do a single thing.
>=20
>> Also, add code to pass control to the final stage hotplug handler at t=
he
>> parent bus.
> But I don't agree with generic
>  "} else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {"
> forwarding, it's done by 3/14 for generic case and in case of
> special device that needs bus handler called from machine one,
> I'd suggest to do forwarding explicitly for that device only
> like we do with acpi_dev.

I decided to do it that way because it is generic and results in nicer
recovery handling (e.g. in case pc_dimm plug fails, we can simply
rollback all (for now MemoryDevice) previous plug operations).

IMHO, the resulting code is easier to read.

>From this handling it is clear that
"if we reach the hotplug handler, and it is not some special device
plugged by the machine (CPU, PC_DIMM), pass it on to the actual hotplug
handler if any exists"

>=20
>=20
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/i386/pc.c | 39 +++++++++++++++++++++++++++++++--------
>>  1 file changed, 31 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index d768930d02..510076e156 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2007,19 +2007,32 @@ static void pc_cpu_pre_plug(HotplugHandler *ho=
tplug_dev,
>>  static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev=
,
>>                                            DeviceState *dev, Error **e=
rrp)
>>  {
>> +    Error *local_err =3D NULL;
>> +
>> +    /* final stage hotplug handler */
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>> -        pc_cpu_pre_plug(hotplug_dev, dev, errp);
>> +        pc_cpu_pre_plug(hotplug_dev, dev, &local_err);
>> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
>> +        hotplug_handler_pre_plug(dev->parent_bus->hotplug_handler, de=
v,
>> +                                 &local_err);
>>      }
>> +    error_propagate(errp, local_err);
>>  }
>> =20
>>  static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>>                                        DeviceState *dev, Error **errp)
>>  {
>> +    Error *local_err =3D NULL;
>> +
>> +    /* final stage hotplug handler */
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>> -        pc_dimm_plug(hotplug_dev, dev, errp);
>> +        pc_dimm_plug(hotplug_dev, dev, &local_err);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>> -        pc_cpu_plug(hotplug_dev, dev, errp);
>> +        pc_cpu_plug(hotplug_dev, dev, &local_err);
>> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
>> +        hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &=
local_err);
>>      }
>> +    error_propagate(errp, local_err);
>>  }
>> =20
>>  static void pc_machine_device_unplug_request_cb(HotplugHandler *hotpl=
ug_dev,
>> @@ -2029,7 +2042,10 @@ static void pc_machine_device_unplug_request_cb=
(HotplugHandler *hotplug_dev,
>>          pc_dimm_unplug_request(hotplug_dev, dev, errp);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>          pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
>> -    } else {
>> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
>> +        hotplug_handler_unplug_request(dev->parent_bus->hotplug_handl=
er, dev,
>> +                                       errp);
>> +    } else if (!dev->parent_bus) {
>>          error_setg(errp, "acpi: device unplug request for not support=
ed device"
>>                     " type: %s", object_get_typename(OBJECT(dev)));
>>      }
>> @@ -2038,14 +2054,21 @@ static void pc_machine_device_unplug_request_c=
b(HotplugHandler *hotplug_dev,
>>  static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
>>                                          DeviceState *dev, Error **err=
p)
>>  {
>> +    Error *local_err =3D NULL;
>> +
>> +    /* final stage hotplug handler */
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>> -        pc_dimm_unplug(hotplug_dev, dev, errp);
>> +        pc_dimm_unplug(hotplug_dev, dev, &local_err);
>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>> -        pc_cpu_unplug_cb(hotplug_dev, dev, errp);
>> -    } else {
>> -        error_setg(errp, "acpi: device unplug for not supported devic=
e"
>> +        pc_cpu_unplug_cb(hotplug_dev, dev, &local_err);
>> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
>> +        hotplug_handler_unplug(dev->parent_bus->hotplug_handler, dev,
>> +                               &local_err);
>> +    } else if (!dev->parent_bus) {
>> +        error_setg(&local_err, "acpi: device unplug for not supported=
 device"
>>                     " type: %s", object_get_typename(OBJECT(dev)));
>>      }
>> +    error_propagate(errp, local_err);
>>  }
>> =20
>>  static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
>=20


--=20

Thanks,

David / dhildenb
