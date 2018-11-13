Received: from eggs.gnu.org ([2001:4830:134:3::10]:46219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gMY0y-0008EG-9N
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gMY0v-0004XX-2l
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:41:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gMY0u-0004Ep-Q0
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 07:41:52 -0500
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-8-david@redhat.com>
	<20181113132614.3abdaa12@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9ba9e9af-d544-bc1b-4def-a876917116ee@redhat.com>
Date: Tue, 13 Nov 2018 13:41:07 +0100
MIME-Version: 1.0
In-Reply-To: <20181113132614.3abdaa12@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 7/7] memory-device: rewrite address
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 13.11.18 13:26, Igor Mammedov wrote:
> On Tue, 23 Oct 2018 17:23:06 +0200
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
>> Now properly reports an error instead of succeeding.
> s/error/error out/

Thanks, fixed.

>=20
>>
>> "can't add memory device [0xffffffffc0000000:0x80000000], range overfl=
ow"
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/mem/memory-device.c | 53 ++++++++++++++++++++++++-----------------=
-
>>  1 file changed, 30 insertions(+), 23 deletions(-)
>>
>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
>> index 8be63c8032..2fb6fc2145 100644
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
>> @@ -145,20 +142,24 @@ static uint64_t memory_device_get_free_addr(Mach=
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
>> +                       "], range overflow", *hint, size);
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
>> +            error_setg(errp, "can't add memory device [0x%" PRIx64 ":=
0x%" PRIx64
>> +                       "], range overflow", *hint, size);
> maybe replace "range overflow" with "too big" or something else more us=
er friendly=20

I guess I'll use the same error message for these two cases

"can't add memory device [...], usable range for memory devices [...]"

That will include the "range overflow" scenario when a hint was given.

>=20
>> +            return 0;
>> +        }
>>      }
>> =20
>>      /* find address range that will fit new memory device */
>> @@ -166,30 +167,36 @@ static uint64_t memory_device_get_free_addr(Mach=
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
>                                          ^^^^^^^^^^^^^^^^^^^
> this theoretically could overflow and already past 'as' check so it wou=
ld
> return an invalid address without erroring out.
>=20
> But in practice we don't have memory device container ending right on 6=
4bit
> limit, so it's not really an issue.

I'll add a simple check for "!next_addr".

>=20
>=20
>> +            if (range_init(&new, next_addr, range_size(&new))) {
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
>>          goto out;
>>      }
>>  out:
>>      g_slist_free(list);
>> -    return new_addr;
>> +    return range_lob(&new);
>>  }
>> =20
>>  MemoryDeviceInfoList *qmp_memory_device_list(void)
>=20
> beside minor notes patch looks good
>=20

Thanks!

--=20

Thanks,

David / dhildenb
