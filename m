Received: from eggs.gnu.org ([2001:4830:134:3::10]:46020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gXQDT-0007Qd-LE
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:35:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gXQDQ-0008OJ-CM
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:35:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gXQDQ-0008Kf-3h
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:35:44 -0500
References: <20181212092821.18260-1-david@redhat.com>
	<20181212092821.18260-3-david@redhat.com>
	<20181213132850.2b79d12f@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0ba15f35-4827-f6f9-7a62-94a13027c727@redhat.com>
Date: Thu, 13 Dec 2018 13:35:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181213132850.2b79d12f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/2] memory-device: rewrite address
 assignment using ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 13.12.18 13:28, Igor Mammedov wrote:
> On Wed, 12 Dec 2018 10:28:21 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> Let's rewrite it properly using ranges. This fixes certain overflows t=
hat
>> are right now possible. E.g.
>>
>> qemu-system-x86_64 -m 4G,slots=3D20,maxmem=3D40G -M pc \
>>     -object memory-backend-file,id=3Dmem1,share,mem-path=3D/dev/zero,s=
ize=3D2G
>>     -device pc-dimm,memdev=3Dmem1,id=3Ddimm1,addr=3D-0x40000000
>>
>> Now properly errors out instead of succeeding. (Note that qapi
>> parsing of huge uint64_t values is broken and fixes are on the way)
>>
>> "can't add memory device [0xffffffffa0000000:0x80000000], usable range=
 for
>> memory devices [0x140000000:0xe00000000]"
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/mem/memory-device.c | 54 ++++++++++++++++++++++++-----------------=
-
>>  1 file changed, 31 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
>> index 8be63c8032..28e871f562 100644
>> --- a/hw/mem/memory-device.c
>> +++ b/hw/mem/memory-device.c
>> @@ -100,9 +100,8 @@ static uint64_t memory_device_get_free_addr(Machin=
eState *ms,
>>                                              uint64_t align, uint64_t =
size,
>>                                              Error **errp)
>>  {
>> -    uint64_t address_space_start, address_space_end;
>>      GSList *list =3D NULL, *item;
>> -    uint64_t new_addr =3D 0;
>> +    Range as, new =3D range_empty;
>> =20
>>      if (!ms->device_memory) {
>>          error_setg(errp, "memory devices (e.g. for memory hotplug) ar=
e not "
>> @@ -115,13 +114,11 @@ static uint64_t memory_device_get_free_addr(Mach=
ineState *ms,
>>                           "enabled, please specify the maxmem option")=
;
>>          return 0;
>>      }
>> -    address_space_start =3D ms->device_memory->base;
>> -    address_space_end =3D address_space_start +
>> -                        memory_region_size(&ms->device_memory->mr);
>> -    g_assert(address_space_end >=3D address_space_start);
>> +    range_init_nofail(&as, ms->device_memory->base,
>> +                      memory_region_size(&ms->device_memory->mr));
>> =20
>> -    /* address_space_start indicates the maximum alignment we expect =
*/
>> -    if (!QEMU_IS_ALIGNED(address_space_start, align)) {
>> +    /* start of address space indicates the maximum alignment we expe=
ct */
>> +    if (!QEMU_IS_ALIGNED(range_lob(&as), align)) {
>>          error_setg(errp, "the alignment (0x%" PRIx64 ") is not suppor=
ted",
>>                     align);
>>          return 0;
>> @@ -145,20 +142,25 @@ static uint64_t memory_device_get_free_addr(Mach=
ineState *ms,
>>      }
>> =20
>>      if (hint) {
>> -        new_addr =3D *hint;
>> -        if (new_addr < address_space_start) {
>> +        if (range_init(&new, *hint, size)) {
>>              error_setg(errp, "can't add memory device [0x%" PRIx64 ":=
0x%" PRIx64
>> -                       "] before 0x%" PRIx64, new_addr, size,
>> -                       address_space_start);
>> +                       "], usable range for memory devices [0x%" PRIx=
64 ":0x%"
>> +                       PRIx64 "]", *hint, size, range_lob(&as),
>> +                       range_size(&as));
> this changes error message to be the same as the next one and looses 'b=
efore' meaning
> so if you'd like to have the same error message, then prbably merging b=
oth branches would be better.

I can do that, but I'll have to refer to "*hint" and "size" then instead
of range_lob(&new) and range_size(&new), because the range might not be
initialized.

>=20
>>              return 0;
>> -        } else if ((new_addr + size) > address_space_end) {
>> +        }
>> +        if (!range_contains_range(&as, &new)) {
>>              error_setg(errp, "can't add memory device [0x%" PRIx64 ":=
0x%" PRIx64
>> -                       "] beyond 0x%" PRIx64, new_addr, size,
>> -                       address_space_end);
>> +                       "], usable range for memory devices [0x%" PRIx=
64 ":0x%"
>> +                       PRIx64 "]", range_lob(&new), range_size(&new),
>> +                       range_lob(&as), range_size(&as));
>>              return 0;
>>          }
>>      } else {
>> -        new_addr =3D address_space_start;
>> +        if (range_init(&new, range_lob(&as), size)) {
>> +            error_setg(errp, "can't add memory device, device too big=
");
>> +            return 0;
>> +        }
>>      }
>> =20
>>      /* find address range that will fit new memory device */
>> @@ -166,30 +168,36 @@ static uint64_t memory_device_get_free_addr(Mach=
ineState *ms,
>>      for (item =3D list; item; item =3D g_slist_next(item)) {
>>          const MemoryDeviceState *md =3D item->data;
>>          const MemoryDeviceClass *mdc =3D MEMORY_DEVICE_GET_CLASS(OBJE=
CT(md));
>> -        uint64_t md_size, md_addr;
>> +        uint64_t next_addr;
>> +        Range tmp;
>> =20
>> -        md_addr =3D mdc->get_addr(md);
>> -        md_size =3D memory_device_get_region_size(md, &error_abort);
>> +        range_init_nofail(&tmp, mdc->get_addr(md),
>> +                          memory_device_get_region_size(md, &error_ab=
ort));
> is it possible to make QEMU abort here during hotplug here? (range_init=
_nofail)

No, as we've handled (and effectively assigned the addresses of) these
devices when they were effectively added/cold/hotplugged. We only have
to be careful with the new device we're adding.

>=20
>> =20
>> -        if (ranges_overlap(md_addr, md_size, new_addr, size)) {
>> +        if (range_overlaps_range(&tmp, &new)) {
>>              if (hint) {
>>                  const DeviceState *d =3D DEVICE(md);
>>                  error_setg(errp, "address range conflicts with memory=
 device"
>>                             " id=3D'%s'", d->id ? d->id : "(unnamed)")=
;
>>                  goto out;
>>              }
>> -            new_addr =3D QEMU_ALIGN_UP(md_addr + md_size, align);
>> +
>> +            next_addr =3D QEMU_ALIGN_UP(range_upb(&tmp) + 1, align);
>> +            if (!next_addr || range_init(&new, next_addr, range_size(=
&new))) {
>> +                range_make_empty(&new);
>> +                break;
>> +            }
>>          }
>>      }
>> =20
>> -    if (new_addr + size > address_space_end) {
>> +    if (!range_contains_range(&as, &new)) {
>>          error_setg(errp, "could not find position in guest address sp=
ace for "
>>                     "memory device - memory fragmented due to alignmen=
ts");
> it could happen due to fragmentation but also in case remaining free sp=
ace is no enough

That should be handled via memory_device_check_addable(), which is
called at the beginning of the function. It checks for general size
availability.

Thanks!

--=20

Thanks,

David / dhildenb
