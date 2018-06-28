Received: from eggs.gnu.org ([2001:4830:134:3::10]:43491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYUNL-0003Od-Nd
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYUNH-0007Er-PV
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 06:42:07 -0400
References: <20180618144800.555-1-david@redhat.com>
	<20180618144800.555-3-david@redhat.com>
	<20180619175940.00ae5e70@redhat.com>
	<1c0de15c-0bbd-1714-782a-00928f3064fe@redhat.com>
	<20180626170328.221939e6@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <391b91f3-3641-fbea-8320-375e68c8cad9@redhat.com>
Date: Thu, 28 Jun 2018 12:41:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180626170328.221939e6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/4] machine: factor out
 enforce_aligned_dimm into memory_device_align
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On 26.06.2018 17:03, Igor Mammedov wrote:
> On Tue, 19 Jun 2018 19:06:38 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 19.06.2018 17:59, Igor Mammedov wrote:
>>> On Mon, 18 Jun 2018 16:47:58 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>  =20
>>>> We want to handle memory device address assignment without passing
>>>> compatibility parameters ("*align").
>>>>
>>>> As x86 and Power use different strategies to determine an alignment =
and
>>>> we need clean support for compat handling, let's introduce an enum o=
n
>>>> the machine class level. This is the machine configuration on how to
>>>> align memory devices in guest physical memory.
>>>>
>>>> The three introduced types represent what is being done on x86 and P=
ower
>>>> right now. =20
>>>
>>> commit message doesn't deliver purpose of the path, =20
>>
>> "We want to handle memory device address assignment without passing
>> compatibility parameters ("*align")."
>>
>> So in order to do patch nr 4 without this, I would basically have to
>> move the align parameter to pc_dimm_pre_plug, along with the code for
>> "detecting" the alignment in e.g. pc_memory_plug. And I want to avoid
>> this because ...
>>
>>> So I'm no conviced it's necessary.
>>> we probably discussed it in previous revisions but could you reiterat=
e
>>> it here WHY do you need this and 3/4
>>>  =20
>>
>> .. I want to get rid of the align parameter in the long run. Alignment
>> is some memory device specific property that can be easily detected
>> using a detection configuration (this patch). This approach looks much
>> cleaner to me. This way we can use the same alignment strategy for all
>> memory devices.
>>
>> In follow up series I want to factor out address assignment completely
>> into memory_device_pre_plug(). And I also don't want to have an align
>> parameter at that function. I want to avoid moving the same code aroun=
d
>> two times (pc.c).
>=20
> Lets look at what we have currently:
>=20
>   1.1 PC: RAM backend target page size alignment (bug fixed by 92a37a04=
d
>       as non aligned addr is not valid at all)
>             align =3D TARGET_PAGE_SIZE
>=20
>       but immediately following up commits a2b257d62 / 0c0de1b68
>       overwrites it unconditionally to QEMU_VMALLOC_ALIGN for 2.2 and l=
ater
>=20
>       so
>       ..v2.1
>             address/size =3D not multiple of TARGET_PAGE_SIZE in QEMU-2=
.1 is broken
>                            (a2b257d62) and we don't care
>=20
>             align =3D TARGET_PAGE_SIZE since QEMU-2.2 binary even for o=
lder machine types
>       and later
>             align =3D QEMU_VMALLOC_ALIGN
>=20
>   1.2 SPAPR: RAM backend. memhotplug came after 1.1 so it has
>          v2.5
>             align =3D QEMU_VMALLOC_ALIGN
>=20
>   2.1 PC: file backend
>           v2.1
>             align =3D TARGET_PAGE_SIZE
>           v2.2 .. 2.11
>             align =3D qemu_fd_getpagesize(fd)
>           v2.12 adds one more invariant
>             align =3D MAX(qemu_fd_getpagesize(fd), 'filebackend.align' =
option)
>            =20
>   2.2 SPAPR: file backend
>           v2.5..2.11
>             align =3D qemu_fd_getpagesize(fd)
>           v2.12
>             align =3D MAX(qemu_fd_getpagesize(fd), 'filebackend.align' =
option)
>=20
> also there is s390 kvm invariant for file backend see: file_ram_alloc()
>=20
>            block->mr->align =3D MAX(qemu_fd_getpagesize(fd), 'filebacke=
nd.align' option)
>            if (vkm)
>               block->mr->align =3D MAX(block->mr->align, QEMU_VMALLOC_A=
LIGN);
>=20
>=20
> to sum up they all have memory region based alignment except of v2.1 PC=
 machine
> which is compat trick that I don't expect to be used anywhere else.
> So taking in account above and fact that it's backend property,
> I'm against of pushing it up to generic machine level, I'd try to keep
> compat hack local to PC machine along with enforce_aligned_dimm.

Problematic case is win32 qemu_anon_ram_alloc(), which does not fixup
the alignment. As far as I can see, the alignment will stay 0. So it
could happen that we have a 0 alignment, but I'll send a fix for that (I
don't think we have to worry about compat in windows here (changing
alignment from 0 to getpagesize())).

>=20
> Moreover 3/4 patch where you are making memory-device.c build per targe=
t is no go,
> we are trying to minimize number of such files and not to add any witho=
ut
> a good reason.

I agree, this is to be avoided.

>=20
> Pushing align detection into common helper would be sufficient,=20
> following could do the job with explicit comment inside that *align
> is compat hack for pc machine.
>=20
>    memory_device_pre_plug(.... int *align)
>      use non null for pc-2.1 compat hack and NULL in all other cases
>=20

Okay, in the first shot I'll do

pcdimm_pre_plug(... uint64_t *enforced_align ...)


--=20

Thanks,

David / dhildenb
