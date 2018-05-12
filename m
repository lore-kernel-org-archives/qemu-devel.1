Received: from eggs.gnu.org ([2001:4830:134:3::10]:52247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fHPLv-0000PC-DH
	for qemu-devel@nongnu.org; Sat, 12 May 2018 03:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fHPLs-0005YF-BS
	for qemu-devel@nongnu.org; Sat, 12 May 2018 03:54:03 -0400
References: <20180511131953.12905-1-david@redhat.com>
	<20180511131953.12905-17-david@redhat.com>
	<20180511183405.GA19020@kermit-br-ibm-com>
	<20180511184356.GN13350@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <da24d0d8-2fde-989e-e760-ba853c5f9c80@redhat.com>
Date: Sat, 12 May 2018 09:53:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180511184356.GN13350@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 16/17] s390x: initialize memory region
 for memory devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 11.05.2018 20:43, Eduardo Habkost wrote:
> On Fri, May 11, 2018 at 03:34:05PM -0300, Murilo Opsfelder Araujo wrote=
:
>> On Fri, May 11, 2018 at 03:19:52PM +0200, David Hildenbrand wrote:
>>> While s390x has no real interface for communicating devices mapped in=
to
>>> the physical address space of the guest, paravirtualized devices can
>>> easily expose the applicable address range themselves.
>>>
>>> So let's use the difference between maxram_size and ram_size as the s=
ize
>>> for our hotplug memory area (just as on other architectures).
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  hw/s390x/s390-virtio-ccw.c | 28 ++++++++++++++++++++++++++--
>>>  1 file changed, 26 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index ee0a2b124f..09b755282b 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -157,9 +157,11 @@ static void virtio_ccw_register_hcalls(void)
>>>  #define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)
>>>  #define SEG_MSK (~0xfffffULL)
>>>  #define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE=
) & SEG_MSK)
>>> -static void s390_memory_init(ram_addr_t mem_size)
>>> +static void s390_memory_init(MachineState *machine)
>>>  {
>>> +    S390CcwMachineState *ms =3D S390_CCW_MACHINE(machine);
>>>      MemoryRegion *sysmem =3D get_system_memory();
>>> +    ram_addr_t mem_size =3D machine->ram_size;
>>>      ram_addr_t chunk, offset =3D 0;
>>>      unsigned int number =3D 0;
>>>      gchar *name;
>>> @@ -181,6 +183,28 @@ static void s390_memory_init(ram_addr_t mem_size=
)
>>>      }
>>>      g_free(name);
>>> =20
>>> +    /* always allocate the device memory information */
>>> +    machine->device_memory =3D g_malloc0(sizeof(*machine->device_mem=
ory));
>>
>> Is there any QEMU guideline/preference/recommendation in using g_new0
>> vs. g_malloc0?
>>
>> I recall Paolo suggesting g_new0 instead of g_malloc0 in another patch=
:
>>
>>   http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg02372.htm=
l
>=20

This patch comes unmodified from my same queue, therefore the code looks
identical :)

> I don't see any reason to not use g_new0() instead of
> g_malloc0(sizeof(...)), as it's more readable.

I clearly favor g_malloc over g_new (except for arrays) for two simple
reasons

1. No need to specify the type. Impossible to specify the wrong type.
Easy to rename types.

2. Every C developer should be able to understand what g_malloc() does.
This is not true for g_new. Especially as it might look strange for C++
developers (new vs. new[] - why don't we have g_new() vs. g_new_array())

I am a simple man, I prefer functions with one parameter if only one
parameter is needed :)

>=20
> But I don't think it's a problem that should block the patch from
> being merged.  We have hundreds of g_malloc*(sizeof(...)) calls
> in the tree.

I assume there are a lot of hard feelings about this. I will continue
using g_malloc() for scalars until the last user is removed from the
QEMU source code. Or there is a coding style statement about it (haven't
found one) ... or people start to curse me when I send patches :)

--=20

Thanks,

David / dhildenb
