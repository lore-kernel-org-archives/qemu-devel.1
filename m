Received: from eggs.gnu.org ([2001:4830:134:3::10]:57797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fO1kp-00079c-T6
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fO1kl-00010a-Tm
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:07:07 -0400
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-2-david@redhat.com>
	<20180529152714.232f952c@redhat.com>
	<cb69838b-e346-503c-f86d-9a0746c6c1e6@redhat.com>
	<20180530145708.42bfd237@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c0e1637b-e4f9-5436-a050-edd69961e7d0@redhat.com>
Date: Wed, 30 May 2018 16:06:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180530145708.42bfd237@redhat.com>
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

On 30.05.2018 14:57, Igor Mammedov wrote:
> On Tue, 29 May 2018 18:02:06 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 29.05.2018 15:27, Igor Mammedov wrote:
>>> On Thu, 17 May 2018 10:15:14 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>  =20
>>>> The start of the address space does not have to be aligned for the
>>>> search. Handle this case explicitly when starting the search for a n=
ew
>>>> address. =20
>>> That's true,
>>> but commit message doesn't explain why address_space_start
>>> should be allowed to be non aligned.
>>>
>>> At least with this assert we would notice early that
>>> board allocating misaligned address space.
>>> I'd keep the assert unless there is a good reason to drop it. =20
>>
>> That reason might be that I can easily crash QEMU
>>
>>  ./x86_64-softmmu/qemu-system-x86_64 -m 256M,maxmem=3D20G,slots=3D2 -o=
bject
>> memory-backend-file,id=3Dmem0,size=3D8192M,mem-path=3D/dev/zero,align=3D=
8192M
>> -device pc-dimm,id=3Ddimm1,memdev=3Dmem0
>>
>> ERROR:hw/mem/memory-device.c:146:memory_device_get_free_addr: assertio=
n
>> failed: (QEMU_ALIGN_UP(address_space_start, align) =3D=3D address_spac=
e_start)
> it looks like a different issue.
> As I remember user visible 'align' property was added as duct tape sinc=
e
> we can't figure out alignment for DAX device no the host,
> so it was left upto upper layers to magically figure that out.
>=20
> However we probably shouldn't allow arbitrary or bigger aligment
> than max page size supported by target machine/cpu
> (i.e. currently hardcoded address_space_start alignment),
> as it creates unnecessary fragmentation and not counted in size
> of hotplug region (for x86 we count in additional 1Gb per memory device=
).
>=20
> How about turning that assert into error check that
> inhibits plugging in devices with alignment values
> larger than address_space_start alignment?


Let me explain a little bit why I don't like such restrictions (for
which I don't see a need yet):

virtio-mem devices will later have a certain block size (e.g. 4MB). I
want to give devices during resource assignment the possibility to
specify their alignment requirements.

For said virtio-mem device, this would e.g. be 4MB. (see patch 10 and 14
of how this call "get_align" comes into play), because the addresses of
the memory blocks are all aligned by e.g. 4MB. This is what is
guaranteed by the device specification.

E.g. for DIMMs we might want to allow to specify the section size (e.g.
128MB on x86), otherwise e.g. Linux is not able to add all memory. (but
we should not hardcode this, as this is a Linux specific requirement -
still it would be nice to specify)

So in general, a memory device might have some alignment that is to be
taken care of.

I don't understand right now why an upper limit on the alignment would
make sense at all. We can easily handle it during our search. And we
have to handle it either way during the search, if we plug some device
with strange sizes (e.g. 1MB DIMM).

Of course, we might end up fragmenting guest physical memory, but that
is purely a setup issue (choosing sizes of devices + main memory
properly). I don't see a reason to error out (and of course also not to
assert out :) ).

--=20

Thanks,

David / dhildenb
