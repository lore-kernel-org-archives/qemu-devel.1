Received: from eggs.gnu.org ([2001:4830:134:3::10]:42383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQveJ-00017m-8a
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQveE-0006yS-82
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:12:23 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-2-david@redhat.com>
	<20180529152714.232f952c@redhat.com>
	<cb69838b-e346-503c-f86d-9a0746c6c1e6@redhat.com>
	<20180530145708.42bfd237@redhat.com>
	<c0e1637b-e4f9-5436-a050-edd69961e7d0@redhat.com>
	<20180531155453.40c1188e@redhat.com>
	<af65fc0d-d010-a8f5-9027-886053034b51@redhat.com>
	<20180607152646.282f2e07@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fb602cbe-33cc-c4d2-a838-cc9eba735d77@redhat.com>
Date: Thu, 7 Jun 2018 16:12:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180607152646.282f2e07@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/14] memory-device: drop assert
 related to align and start of address space
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


>> And another point against introducing a check for the maimum alignment
>> would be: There might be users with a specified alignment > max page
>> size. Changing the behavior will break these setups (strange but true)=
.
> check is already there implicitly as assert, and you're removing it
> with this patch.
> What I'm suggesting is to drop this patch or replace assert with
> graceful error.
> If you have actual usecase that requires this check being dropped,
> then commit message should ddescribe it properly and the patch should
> be a part of series that introduces that requirement.

On x86 hotplug base is aligned to 1GB
On ppc hotplug base is aligned to 1GB

So what you're suggesting is to bail out in case we have an alignment
that does not base (i.e. turning this assert into a check like
"alignment too big")

The we would have to also install such base alignment on s390x, too.
Otherwise, if somebody specifies -m 511, adding something with alignment
of e.g. 4MB will fail.

>=20
>>>> virtio-mem devices will later have a certain block size (e.g. 4MB). =
I
>>>> want to give devices during resource assignment the possibility to
>>>> specify their alignment requirements. =20
>>> size and alignment are 2 diffrent things here, alignment in our desig=
n
>>> is dictated by backing storage page size and for performance reasons
>>> HVA and GPA should be aligned on the same boundary, users are free
>>> to pick another GPA manually as far as it has the same alignment.
>>> But for automatic placement we use backend's alignment to make placem=
ent
>>> as compact as possible but still keeping GPA aligned with HVA.
>>>  =20
>>>> For said virtio-mem device, this would e.g. be 4MB. (see patch 10 an=
d 14
>>>> of how this call "get_align" comes into play), because the addresses=
 of
>>>> the memory blocks are all aligned by e.g. 4MB. This is what is
>>>> guaranteed by the device specification. =20
>>> where does this 4Mb magic comes from and why block must be aligned
>>> on this size? =20
>>
>> (knowing it is hard to get the idea without the current prototype in
>> place, but that will be fixed soon)
>>
>> virtio-mem works in blocks. The block size is the size in which memory
>> can be plugged or unplugged by the guest. It also determines the
>> granularity (and therefore the bitmap) we have to use to keep track of
>> unplugged memory. It is configurable (e.g. for migration purposes), bu=
t
>> might also depend on the backend memory type. E.g. if huge pages are
>> used in the host, the huge page size defines the minimum block size. B=
ut
>> consider the last part a special case. Huge pages will not be supporte=
d
>> for now.
>>
>> The block size also defines the alignment that has to be used by the
>> guest for plugging/unplugging (because that's how blocks gets mapped t=
o
>> the bitmap entries). So a virtio-mem device really needs a block-align=
ed
>> start address,
>>
>> For now I use 4MB because it matches what guests (e.g. Linux) can
>> actually support and keeps the bitmap small. But as I said, it is
>> configurable. (-device virtio-mem,block_size=3D1MB, ...)
>>
>>>   =20
>>>> E.g. for DIMMs we might want to allow to specify the section size (e=
.g.
>>>> 128MB on x86), otherwise e.g. Linux is not able to add all memory. (=
but
>>>> we should not hardcode this, as this is a Linux specific requirement=
 -
>>>> still it would be nice to specify) =20
>>> true, it's guest specific and we do not have restrictions here.
>>> The only restriction we have here is that size must be multiple of
>>> backing storage page size (i.e. alignment) so that guest would
>>> be able to use tail page.
>>>  =20
>>>> So in general, a memory device might have some alignment that is to =
be
>>>> taken care of. =20
>>> Do we really need introducing frontend specific alignment?
>>> I'd try reuse backend's one and go for frontend's only in case we hav=
e to. =20
>>
>> I think so. But I consider this a special case for virtio-mem.
>> (specified indirectly via block_size). For the remaining stuff, we mig=
ht
>> be able to live with the memory backend aligment. And I agree that thi=
s
>> should be the default if possible.
> So if you make block_size to be multiple of backing storage alignment (=
i.e. page size)
> and we should keep GPA mapping (picking address to map region) based on=
 backend's
> alignment. virtio-mem probably would even work even with huge pages at =
cost
> of increased granularity.
>

block_size will always be a multiple of backing storage alignment (well,
for now huge pages will not be supported, so the 4MB > page_size always
holds).

However, using an alignment of the backing storage (e.g. page size) is
not enough.

Using block_size of 1GB for virtio-mem is very unrealistic, so i think
we can ignore this for now. (meaning, getting errors if we implement
said alignment check)

>  =20
>>>> I don't understand right now why an upper limit on the alignment wou=
ld
>>>> make sense at all. We can easily handle it during our search. And we
>>>> have to handle it either way during the search, if we plug some devi=
ce
>>>> with strange sizes (e.g. 1MB DIMM).
>>>>
>>>> Of course, we might end up fragmenting guest physical memory, but th=
at
>>>> is purely a setup issue (choosing sizes of devices + main memory
>>>> properly). I don't see a reason to error out (and of course also not=
 to
>>>> assert out :) ). =20
>>> Agreed about assert, but I'd still prefer error out there so that use=
rs
>>> won't crate insane config and then complain (see below and *).
>>>
>>> Upper alignment value is useful for proper sizing of hotplug address =
space,
>>> so that user could plug #slots devices upto #maxmem specified on CLI.
>>> It's still possible to misconfigure using manual placement, but defau=
lt
>>> one just works, user either consumes all memory #maxmem and/or #slots=
. =20
>>
>>
>> Please not that it will still work in most cases. Only if people start
>> to define crazy alignments (like I did), crazy DIMM sizes (e.g. 1MB) o=
r
>> crazy block sizes for virtio-mem, we might have a fragmented guest
>> physical memory. This should  usually not happen, but if so, we alread=
y
>> have error messages for reporting this "fragmented memory".
>>
>> And I consider these "strange configs" similar as "strange manual
>> placement". Same result: fragmented memory, error out.
>>
>> Personally, I don't think we have to guarantee that automatic placemen=
t
>> works in all scenarios that the user is able to come up with. It shoul=
d
>> work in sane configurations, which is still that case.
> It work now on x86 and I'd wish to keep it this way.

And it keeps working when only using DIMMS/PCDIMMs (slots). Which is
totally fine in my point of view.

> =20
>>> There is no misunderstanding in case of error here as it works same a=
s
>>> on baremetal, one doesn't have a free place to put more memory or all
>>> memory one asked for is already there.
>>>
>>> So it might be that #slots decoupling from memory device a premature
>>> action and we can still use it with virtio-mem/pmem.
>>>
>>
>> I treat #slots on x86 as #acpi_slots, that's why I don't think they
>> apply here. I can see how they are used (on x86 only!) to size the
>> address space - but I consider this a "nice to have feature" that shou=
ld
>> not be supposed to work in all possible scenarios.
> slot is more user space concept, as it is on real hw where you stick a =
plank
> with memory, so it's easily understood by users.
> On ACPI side it's just implementation detail, we can go beyond that if =
it's
> needed without any adverse effects.
> Restriction mostly comes from KVM side on # of memory slots and vhost.

KVM memory slots is a completely different concept than the slots
parameter. The problem is: DIMMs use this as if it would be "acpi_slots".

>=20
>> E.g. powerpc already relies on sane user configs. #slots is not used t=
o
>> size the guest address space. Similar things will apply on s390x.
> They both could benefit from it the same way as x86 providing
> properly sized area, so users won't have to scratch their head
> trying to understand why they can't plug more memory.

Fragmented memory is more than enough as an error message IMHO.

--=20

Thanks,

David / dhildenb
