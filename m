Received: from eggs.gnu.org ([2001:4830:134:3::10]:52081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVeZF-0006MZ-8k
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVeZC-0002EC-19
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:58:41 -0400
From: David Hildenbrand <david@redhat.com>
References: <20180618144800.555-1-david@redhat.com>
	<20180618144800.555-3-david@redhat.com>
	<20180619175940.00ae5e70@redhat.com>
	<1c0de15c-0bbd-1714-782a-00928f3064fe@redhat.com>
Message-ID: <3cb2aa7a-12a5-a2ca-b8a1-3911c8c2b7fe@redhat.com>
Date: Wed, 20 Jun 2018 16:58:33 +0200
MIME-Version: 1.0
In-Reply-To: <1c0de15c-0bbd-1714-782a-00928f3064fe@redhat.com>
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 19.06.2018 19:06, David Hildenbrand wrote:
> On 19.06.2018 17:59, Igor Mammedov wrote:
>> On Mon, 18 Jun 2018 16:47:58 +0200
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> We want to handle memory device address assignment without passing
>>> compatibility parameters ("*align").
>>>
>>> As x86 and Power use different strategies to determine an alignment a=
nd
>>> we need clean support for compat handling, let's introduce an enum on
>>> the machine class level. This is the machine configuration on how to
>>> align memory devices in guest physical memory.
>>>
>>> The three introduced types represent what is being done on x86 and Po=
wer
>>> right now.
>>
>> commit message doesn't deliver purpose of the path,
>=20
> "We want to handle memory device address assignment without passing
> compatibility parameters ("*align")."
>=20
> So in order to do patch nr 4 without this, I would basically have to
> move the align parameter to pc_dimm_pre_plug, along with the code for
> "detecting" the alignment in e.g. pc_memory_plug. And I want to avoid
> this because ...
>=20
>> So I'm no conviced it's necessary.
>> we probably discussed it in previous revisions but could you reiterate
>> it here WHY do you need this and 3/4
>>
>=20
> .. I want to get rid of the align parameter in the long run. Alignment
> is some memory device specific property that can be easily detected
> using a detection configuration (this patch). This approach looks much
> cleaner to me. This way we can use the same alignment strategy for all
> memory devices.
>=20
> In follow up series I want to factor out address assignment completely
> into memory_device_pre_plug(). And I also don't want to have an align
> parameter at that function. I want to avoid moving the same code around
> two times (pc.c).

It is probably best if you tell my your opinion on how address
assignment/alignment handling of pc-dimm/memory-devices is to be handled
after my rework.

My idea for the end result:

pc_dimm_pre_plug(machine, dev, errp) {
	// detect and verify slot ...
	memory_device_pre_plug(machine, dev, errp);
}

virtio_mem_pre_plug(machine, dev, errp) {
	memory_device_pre_plug(machine, dev, errp);
}

memory_device_pre_plug(machine, md, errp) {
	align =3D memory_device_get_align(machine, md); //handle compat
	addr =3D md->get_addr();
        addr =3D memory_device_get_free_addr(... addr, align ...)
	md->set_addr(addr);
}

If you want *align to remain part of the function call, then
pc_dimm_pre_plug and virtio_mem_pre_plug will have to detect the
alignment themselves (e.g. using the memory region) and either

a) pass it into memory_device_pre_plug()
b) handle what memory_device_pre_plug() would do (get_free_addr ... what
we have in pc_dimm_plug() right now)

--=20

Thanks,

David / dhildenb
