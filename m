Received: from eggs.gnu.org ([2001:4830:134:3::10]:41992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fPnvo-0005tc-61
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fPnvj-00026l-9J
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:45:48 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-13-david@redhat.com>
	<20180601131724.6e17a249@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5f80f3a1-2d40-c197-ebea-636944366d4d@redhat.com>
Date: Mon, 4 Jun 2018 13:45:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180601131724.6e17a249@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 12/14] memory-device: factor out
 pre-plug into hotplug handler
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

On 01.06.2018 13:17, Igor Mammedov wrote:
> On Thu, 17 May 2018 10:15:25 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> Let's move all pre-plug checks we can do without the device being
>> realized into the applicable hotplug handler for pc and spapr.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/i386/pc.c                   | 11 +++++++
>>  hw/mem/memory-device.c         | 72 +++++++++++++++++++--------------=
---------
>>  hw/ppc/spapr.c                 | 11 +++++++
>>  include/hw/mem/memory-device.h |  2 ++
>>  4 files changed, 57 insertions(+), 39 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 8bc41ef24b..61f1537e14 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2010,6 +2010,16 @@ static void pc_machine_device_pre_plug_cb(Hotpl=
ugHandler *hotplug_dev,
>>  {
>>      Error *local_err =3D NULL;
>> =20
>> +    /* first stage hotplug handler */
>> +    if (object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE)) {
>> +        memory_device_pre_plug(MACHINE(hotplug_dev), MEMORY_DEVICE(de=
v),
>> +                               &local_err);
>> +    }
>> +
>> +    if (local_err) {
>> +        goto out;
>> +    }
>> +
>>      /* final stage hotplug handler */
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>>          pc_cpu_pre_plug(hotplug_dev, dev, &local_err);
>> @@ -2017,6 +2027,7 @@ static void pc_machine_device_pre_plug_cb(Hotplu=
gHandler *hotplug_dev,
>>          hotplug_handler_pre_plug(dev->parent_bus->hotplug_handler, de=
v,
>>                                   &local_err);
>>      }
>> +out:
>>      error_propagate(errp, local_err);
>>  }
>> =20
>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
>> index 361d38bfc5..d22c91993f 100644
>> --- a/hw/mem/memory-device.c
>> +++ b/hw/mem/memory-device.c
>> @@ -68,58 +68,26 @@ static int memory_device_used_region_size(Object *=
obj, void *opaque)
>>      return 0;
>>  }
>> =20
>> -static void memory_device_check_addable(MachineState *ms, uint64_t si=
ze,
>> -                                        Error **errp)
>> -{
>> -    uint64_t used_region_size =3D 0;
>> -
>> -    /* we will need a new memory slot for kvm and vhost */
>> -    if (kvm_enabled() && !kvm_has_free_slot(ms)) {
>> -        error_setg(errp, "hypervisor has no free memory slots left");
>> -        return;
>> -    }
>> -    if (!vhost_has_free_slot()) {
>> -        error_setg(errp, "a used vhost backend has no free memory slo=
ts left");
>> -        return;
>> -    }
>> -
>> -    /* will we exceed the total amount of memory specified */
>> -    memory_device_used_region_size(OBJECT(ms), &used_region_size);
>> -    if (used_region_size + size > ms->maxram_size - ms->ram_size) {
>> -        error_setg(errp, "not enough space, currently 0x%" PRIx64
>> -                   " in use of total hot pluggable 0x" RAM_ADDR_FMT,
>> -                   used_region_size, ms->maxram_size - ms->ram_size);
>> -        return;
>> -    }
>> -
>> -}
>> -
>>  uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t=
 *hint,
>>                                       uint64_t align, uint64_t size,
>>                                       Error **errp)
>>  {
>>      uint64_t address_space_start, address_space_end;
>> +    uint64_t used_region_size =3D 0;
>>      GSList *list =3D NULL, *item;
>>      uint64_t new_addr =3D 0;
>> =20
>> -    if (!ms->device_memory) {
>> -        error_setg(errp, "memory devices (e.g. for memory hotplug) ar=
e not "
>> -                         "supported by the machine");
>> -        return 0;
>> -    }
>> -
>> -    if (!memory_region_size(&ms->device_memory->mr)) {
>> -        error_setg(errp, "memory devices (e.g. for memory hotplug) ar=
e not "
>> -                         "enabled, please specify the maxmem option")=
;
>> -        return 0;
>> -    }
>>      address_space_start =3D ms->device_memory->base;
>>      address_space_end =3D address_space_start +
>>                          memory_region_size(&ms->device_memory->mr);
>>      g_assert(address_space_end >=3D address_space_start);
>> =20
>> -    memory_device_check_addable(ms, size, errp);
>> -    if (*errp) {
>> +    /* will we exceed the total amount of memory specified */
>> +    memory_device_used_region_size(OBJECT(ms), &used_region_size);
>> +    if (used_region_size + size > ms->maxram_size - ms->ram_size) {
>> +        error_setg(errp, "not enough space, currently 0x%" PRIx64
>> +                   " in use of total hot pluggable 0x" RAM_ADDR_FMT,
>> +                   used_region_size, ms->maxram_size - ms->ram_size);
>>          return 0;
>>      }
>> =20
>> @@ -242,6 +210,32 @@ uint64_t get_plugged_memory_size(void)
>>      return size;
>>  }
>> =20
>> +void memory_device_pre_plug(MachineState *ms, const MemoryDeviceState=
 *md,
>> +                            Error **errp)
>> +{
>> +    if (!ms->device_memory) {
>> +        error_setg(errp, "memory devices (e.g. for memory hotplug) ar=
e not "
>> +                         "supported by the machine");
>> +        return;
>> +    }
>> +
>> +    if (!memory_region_size(&ms->device_memory->mr)) {
>> +        error_setg(errp, "memory devices (e.g. for memory hotplug) ar=
e not "
>> +                         "enabled, please specify the maxmem option")=
;
>> +        return;
>> +    }
>> +
>> +    /* we will need a new memory slot for kvm and vhost */
>> +    if (kvm_enabled() && !kvm_has_free_slot(ms)) {
>> +        error_setg(errp, "hypervisor has no free memory slots left");
>> +        return;
>> +    }
>> +    if (!vhost_has_free_slot()) {
>> +        error_setg(errp, "a used vhost backend has no free memory slo=
ts left");
>> +        return;
>> +    }
> thanks for extracting preparations steps into the right callback.
>=20
> on top of this _preplug() handler should also set being plugged
> device properties if they weren't set by user.
>  memory_device_get_free_addr() should be here to.
>=20
> general rule for _preplug() would be to check and prepare device
> for being plugged but not touch anything beside the device (it's _plug =
handler job)

I disagree. Or at least I disagree as part of this patch series because
it over-complicates things :)

preplug() can do basic checks but I don't think it should be used to
change actual properties. And I give you the main reason for this:

We have to do quite some amount of unnecessary error handling (please
remember the pc_dimm plug code madness before I refactored it - 80%
consisted of error handling) if we want to work on device properties
before a device is realized. And we even have duplicate checks both in
the realize() and the preplug() code then (again, what we had in the
pc_dimm plug code - do we have a memdev already or not).

Right now, I assume, that all MemoryDevice functions can be safely
called after the device has been realized without error handling. This
is nice. It e.g. guarantees that we have a memdev assigned. Otherwise,
every time we access some MemoryDevice property (e.g. region size), we
have to handle possible uninitialized properties (e.g. memdev) -
something I don't like.

So I want to avoid this by any means. And I don't really see a benefit
for this additional error handling that will be necessary: We don't care
about the performance in case something went wrong.

--=20

Thanks,

David / dhildenb
