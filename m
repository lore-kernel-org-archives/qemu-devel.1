Received: from eggs.gnu.org ([2001:4830:134:3::10]:34264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAaq1-0000h7-GC
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAapw-0007eR-Pj
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:44:57 -0400
References: <20180420123456.22196-1-david@redhat.com>
	<20180420123456.22196-4-david@redhat.com>
	<20180423141928.7e64b380@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <860a6828-e18f-555e-274d-f9be9245eccb@redhat.com>
Date: Mon, 23 Apr 2018 14:44:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180423141928.7e64b380@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] pc-dimm: factor out address space
 logic into MemoryDevice code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>

On 23.04.2018 14:19, Igor Mammedov wrote:
> On Fri, 20 Apr 2018 14:34:56 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> To be able to reuse MemoryDevice logic from other devices besides
>> pc-dimm, factor the relevant stuff out into the MemoryDevice code.
>>
>> As we don't care about slots for memory devices that are not pc-dimm,
>> don't factor that part out.
> that's not really true, you still consume kvm and vhost slots (whatever=
 it is)
> whenever you map it into address space as ram memory region.

Let me rephrase ACPI slots are not of interest. That user visible part
is not needed for other memory devices.

KVM and VHOST slots are different (just memory regions, we don't care
about which specific slot is taken)

>=20
> Also ram_slots currently are (ab)used as flag that user enabled memory
> hotplug via CLI.

Yes, have a patch for this :)

> =20
>> Most of this patch just moves checks and logic around. While at it, ma=
ke
>> the code properly detect certain error conditions better (e.g. fragmen=
ted
>> memory).
> I'd suggest splitting patch in several smaller ones if possible,
> especially parts that do anything more than just moving code around.

I tried to do it in smaller steps but most of it turned out to just
introduce and delete temporary code. Will have a look if this can be
done after we got a common understanding of what the end result should
look like.

>=20
>=20
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/i386/pc.c                   |  12 +--
>>  hw/mem/memory-device.c         | 162 ++++++++++++++++++++++++++++++++=
++++
>>  hw/mem/pc-dimm.c               | 185 +++-----------------------------=
---------
>>  hw/ppc/spapr.c                 |   9 +-
>>  include/hw/mem/memory-device.h |   4 +
>>  include/hw/mem/pc-dimm.h       |  14 +---
>>  6 files changed, 185 insertions(+), 201 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index fa8862af33..1c25546a0c 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1711,7 +1711,7 @@ static void pc_dimm_plug(HotplugHandler *hotplug=
_dev,
>>          goto out;
>>      }
>> =20
>> -    pc_dimm_memory_plug(dev, &pcms->hotplug_memory, mr, align, &local=
_err);
>> +    pc_dimm_memory_plug(dev, align, &local_err);
> Is there a reason why you are dropping pcms->hotplug_memory argument
> and fall back to qdev_get_machine()?

Yes, because we
a) access machine either way internally (a couple of times even).
b) this only works if we have a hotplug handler on the machine (esp: not
for virtio devices). Otherwise we have to get the machine from the
virtio realize function - also ugly.

>=20
> I'd rather see it going other direction,
> i.e. move hotplug_memory from PC
> machine to MachineState and then pass it down as argument whenever it's=
 needed.

As said, ugly for virtio devices. And I don't see a benefit if we access
the machine internally already either way.

>=20
>>      if (local_err) {
>>          goto out;
>>      }
>> @@ -1761,17 +1761,9 @@ static void pc_dimm_unplug(HotplugHandler *hotp=
lug_dev,
>>                             DeviceState *dev, Error **errp)
>>  {
>>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
>> -    PCDIMMDevice *dimm =3D PC_DIMM(dev);
>> -    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>> -    MemoryRegion *mr;
>>      HotplugHandlerClass *hhc;
>>      Error *local_err =3D NULL;
>> =20
>> -    mr =3D ddc->get_memory_region(dimm, &local_err);
>> -    if (local_err) {
>> -        goto out;
>> -    }
>> -
>>      hhc =3D HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
>>      hhc->unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
>> =20
>> @@ -1779,7 +1771,7 @@ static void pc_dimm_unplug(HotplugHandler *hotpl=
ug_dev,
>>          goto out;
>>      }
>> =20
>> -    pc_dimm_memory_unplug(dev, &pcms->hotplug_memory, mr);
>> +    pc_dimm_memory_unplug(dev);
> ditto

(and I still think it looks cleaner, but we can discuss)

>=20
>>      object_unparent(OBJECT(dev));
>> =20
>>   out:
>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
>> index b860c9c582..b96efa3bf4 100644
>> --- a/hw/mem/memory-device.c
>> +++ b/hw/mem/memory-device.c
>> @@ -15,6 +15,8 @@
>>  #include "qapi/error.h"
>>  #include "hw/boards.h"
>>  #include "qemu/range.h"
>> +#include "hw/virtio/vhost.h"
>> +#include "sysemu/kvm.h"
>> =20
>>  static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
>>  {
>> @@ -106,6 +108,166 @@ uint64_t get_plugged_memory_size(void)
>>      return size;
>>  }
>> =20
>> +static int memory_device_used_region_size_internal(Object *obj, void =
*opaque)
>> +{
>> +    uint64_t *size =3D opaque;
>> +
>> +    if (object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
>> +        DeviceState *dev =3D DEVICE(obj);
>> +        MemoryDeviceState *md =3D MEMORY_DEVICE(obj);
>> +        MemoryDeviceClass *mdc =3D MEMORY_DEVICE_GET_CLASS(obj);
>> +
>> +        if (dev->realized) {
>> +            *size +=3D mdc->get_region_size(md, &error_abort);
>> +        }
>> +    }
>> +
>> +    object_child_foreach(obj, memory_device_used_region_size_internal=
, opaque);
>> +    return 0;
>> +}
>> +
>> +static uint64_t memory_device_used_region_size(void)
>> +{
>> +    uint64_t size =3D 0;
>> +
>> +    memory_device_used_region_size_internal(qdev_get_machine(), &size=
);
>> +
>> +    return size;
>> +}
>> +
>> +uint64_t memory_device_get_free_addr(uint64_t *hint, uint64_t align,
>> +                                     uint64_t size, Error **errp)
> I'd suggest to pc_dimm_memory_plug/pc_dimm_get_free_addr first,
> namely most of the stuff it does like checks and assigning default
> values should go to pre_plug (pre realize) handler and then only
> actual mapping is left for plug (after realize) handler to deal with:
>=20

Can you elaborate what you mean by pre-plug? If this is about pre plug
handler of the (machine) hotplug handler, it might be problematic for
virtio devices.

>     memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);     =
         =20
>     vmstate_register_ram(vmstate_mr, dev);=20
>=20
>> +{
>> +    const uint64_t used_region_size =3D memory_device_used_region_siz=
e();
>> +    uint64_t address_space_start, address_space_end;
>> +    MachineState *machine =3D MACHINE(qdev_get_machine());
>> +    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
>> +    MemoryHotplugState *hpms;
>> +    GSList *list =3D NULL, *item;
>> +    uint64_t new_addr =3D 0;
>> +
>> +    if (!mc->get_memory_hotplug_state) {
>> +        error_setg(errp, "memory devices (e.g. for memory hotplug) ar=
e not "
>> +                         "supported by the machine");
>> +        return 0;
>> +    }
>> +
>> +    hpms =3D mc->get_memory_hotplug_state(machine);
>> +    if (!hpms || !memory_region_size(&hpms->mr)) {
>> +        error_setg(errp, "memory devices (e.g. for memory hotplug) ar=
e not "
>> +                         "enabled, please specify the maxmem option")=
;
>> +        return 0;
>> +    }
> above 2 checks are repeated multiple times separate helper to do it
> would be better.

In the current code there is only one place left (namely) here.

>=20
> PS:
> there is no need to check for it every time device is plugged,
> doing this check once (at machine_init time) is sufficient.

Can you elaborate? There has to be one central place where we check if
we can hotplug a memory device. E.g. virtio devices don't go via the
machine hotplug handler.

>=20
>> +    address_space_start =3D hpms->base;
>> +    address_space_end =3D address_space_start + memory_region_size(&h=
pms->mr);
>> +    g_assert(address_space_end >=3D address_space_start);
>> +
>> +    if (used_region_size + size > machine->maxram_size - machine->ram=
_size) {
>> +        error_setg(errp, "not enough space, currently 0x%" PRIx64
>> +                   " in use of total hot pluggable 0x" RAM_ADDR_FMT,
>> +                   used_region_size, machine->maxram_size - machine->=
ram_size);
>> +        return 0;
>> +    }
>> +
>> +    if (hint && QEMU_ALIGN_UP(*hint, align) !=3D *hint) {
>> +        error_setg(errp, "address must be aligned to 0x%" PRIx64 " by=
tes",
>> +                   align);
>> +        return 0;
>> +    }
>> +
>> +    if (QEMU_ALIGN_UP(size, align) !=3D size) {
>> +        error_setg(errp, "backend memory size must be multiple of 0x%=
"
>> +                   PRIx64, align);
>> +        return 0;
>> +    }
>> +
>> +    if (hint) {
>> +        new_addr =3D *hint;
>> +        if (new_addr < address_space_start) {
>> +            error_setg(errp, "can't add memory [0x%" PRIx64 ":0x%" PR=
Ix64
>> +                       "] at 0x%" PRIx64, new_addr, size, address_spa=
ce_start);
>> +            return 0;
>> +        } else if ((new_addr + size) > address_space_end) {
>> +            error_setg(errp, "can't add memory [0x%" PRIx64 ":0x%" PR=
Ix64
>> +                       "] beyond 0x%" PRIx64, new_addr, size,
>> +                       address_space_end);
>> +            return 0;
>> +        }
>> +    } else {
>> +        new_addr =3D address_space_start;
>> +    }
>> +
>> +    /* find address range that will fit new memory device */
>> +    object_child_foreach(qdev_get_machine(), memory_device_built_list=
, &list);
>> +    for (item =3D list; item; item =3D g_slist_next(item)) {
>> +        MemoryDeviceState *md =3D item->data;
>> +        MemoryDeviceClass *mdc =3D MEMORY_DEVICE_GET_CLASS(OBJECT(md)=
);
>> +        uint64_t md_size, md_addr;
>> +
>> +        md_addr =3D mdc->get_addr(md);
>> +        md_size =3D mdc->get_region_size(md, errp);
>> +        if (*errp) {
>> +            goto out;
>> +        }
>> +
>> +        if (ranges_overlap(md_addr, md_size, new_addr, size)) {
>> +            if (hint) {
>> +                DeviceState *d =3D DEVICE(md);
>> +                error_setg(errp, "address range conflicts with '%s'",=
 d->id);
>> +                goto out;
>> +            }
>> +            new_addr =3D QEMU_ALIGN_UP(md_addr + md_size, align);
>> +        }
>> +    }
>> +
>> +    if (new_addr + size > address_space_end) {
>> +        error_setg(errp, "could not find position in guest address sp=
ace for "
>> +                   "memory device - memory fragmented due to alignmen=
ts");
>> +        goto out;
>> +    }
>> +out:
>> +    g_slist_free(list);
>> +    return new_addr;
>> +}
>> +
>> +void memory_device_plug_region(MemoryRegion *mr, uint64_t addr, Error=
 **errp)
>> +{
> [...]
>=20
>> +    /* we will need a new memory slot for kvm and vhost */
>> +    if (kvm_enabled() && !kvm_has_free_slot(machine)) {
>> +        error_setg(errp, "hypervisor has no free memory slots left");
>> +        return;
>> +    }
>> +    if (!vhost_has_free_slot()) {
>> +        error_setg(errp, "a used vhost backend has no free memory slo=
ts left");
>> +        return;
>> +    }
> move these checks to pre_plug time

That would then be a different flow as we have right now. But it sounds
sane.


--=20

Thanks,

David / dhildenb
