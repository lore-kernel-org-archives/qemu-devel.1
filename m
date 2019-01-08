Received: from eggs.gnu.org ([209.51.188.92]:60488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ggpai-0008G3-46
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ggpaf-0006d1-EA
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:30:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ggpaf-0006Se-2c
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:30:37 -0500
References: <20181225125344.4482-1-arilou@gmail.com>
	<CAJ+F1CJN=Gn5GYqrOeqWFNryw=q+7q8TDUX0VQEzrtS8tbUeQg@mail.gmail.com>
	<7961a154-f139-af73-613d-94b88bf95392@redhat.com>
	<CAP7QCogAWOWgkzL+ebufbpiaap=iSaNh+HWP4N3Sx1OwseQxhA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8d68801f-3252-fd43-cd11-7866c297677d@redhat.com>
Date: Tue, 8 Jan 2019 12:30:26 +0100
MIME-Version: 1.0
In-Reply-To: <CAP7QCogAWOWgkzL+ebufbpiaap=iSaNh+HWP4N3Sx1OwseQxhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] dump: Set correct vaddr for ELF dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jon Doron <arilou@gmail.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Wen Congyang <wency@cn.fujitsu.com>, Luiz Capitulino <lcapitulino@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 01/08/19 07:31, Jon Doron wrote:
> Thank you for looking into this, perhaps I could change the patch (at
> least in the C part not the python script) to something like:
> -    phdr.p_vaddr =3D cpu_to_dumpXX(s, memory_mapping->virt_addr);
> +    phdr.p_vaddr =3D cpu_to_dumpXX(s, memory_mapping->virt_addr) ?
> cpu_to_dumpXX(s, memory_mapping->virt_addr) : phdr.p_paddr;
>=20
> So in the case of paging where virt_addr is available we will use it

I guess that would be an improvement, yes.

Regarding style: although I'm personally opposed to most GNUisms, QEMU
liberally uses, for example, the GNU extension:

  https://gcc.gnu.org/onlinedocs/gcc/Conditionals.html

And, the "?:" operator would apply here.

Thanks,
Laszlo

> On Mon, Jan 7, 2019 at 8:04 PM Laszlo Ersek <lersek@redhat.com> wrote:
>>
>> On 01/07/19 13:14, Marc-Andr=C3=A9 Lureau wrote:
>>> Hi
>>>
>>> On Tue, Dec 25, 2018 at 5:52 PM Jon Doron <arilou@gmail.com> wrote:
>>>>
>>>> vaddr needs to be equal to the paddr since the dump file represents =
the
>>>> physical memory image.
>>>>
>>>> Without setting vaddr correctly, GDB would load all the different me=
mory
>>>> regions on top of each other to vaddr 0, thus making GDB showing the=
 wrong
>>>> memory data for a given address.
>>>>
>>>> Signed-off-by: Jon Doron <arilou@gmail.com>
>>>
>>> This is a non-trivial patch! (qemu-trivial, please ignore).
>>>
>>>> ---
>>>>  dump.c                       | 4 ++--
>>>>  scripts/dump-guest-memory.py | 1 +
>>>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/dump.c b/dump.c
>>>> index 4ec94c5e25..bf77a119ea 100644
>>>> --- a/dump.c
>>>> +++ b/dump.c
>>>> @@ -192,7 +192,7 @@ static void write_elf64_load(DumpState *s, Memor=
yMapping *memory_mapping,
>>>>      phdr.p_paddr =3D cpu_to_dump64(s, memory_mapping->phys_addr);
>>>>      phdr.p_filesz =3D cpu_to_dump64(s, filesz);
>>>>      phdr.p_memsz =3D cpu_to_dump64(s, memory_mapping->length);
>>>> -    phdr.p_vaddr =3D cpu_to_dump64(s, memory_mapping->virt_addr);
>>>> +    phdr.p_vaddr =3D phdr.p_paddr;
>>>
>>> This is likely breaking paging=3Dtrue somehow, which sets
>>> memory_mapping->virt_addr to non-0.
>>>
>>> According to doc "If you want to use gdb to process the core, please
>>> set @paging to true."
>>>
>>> Although I am not able to (gdb) x/10bx 0xa0000 for example on a core
>>> produced with paging. Not sure why, anybody could help?
>>>
>>>>      assert(memory_mapping->length >=3D filesz);
>>>>
>>>> @@ -216,7 +216,7 @@ static void write_elf32_load(DumpState *s, Memor=
yMapping *memory_mapping,
>>>>      phdr.p_paddr =3D cpu_to_dump32(s, memory_mapping->phys_addr);
>>>>      phdr.p_filesz =3D cpu_to_dump32(s, filesz);
>>>>      phdr.p_memsz =3D cpu_to_dump32(s, memory_mapping->length);
>>>> -    phdr.p_vaddr =3D cpu_to_dump32(s, memory_mapping->virt_addr);
>>>> +    phdr.p_vaddr =3D phdr.p_paddr;
>>>>
>>>>      assert(memory_mapping->length >=3D filesz);
>>>>
>>>> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memor=
y.py
>>>> index 198cd0fe40..2c587cbefc 100644
>>>> --- a/scripts/dump-guest-memory.py
>>>> +++ b/scripts/dump-guest-memory.py
>>>> @@ -163,6 +163,7 @@ class ELF(object):
>>>>          phdr =3D get_arch_phdr(self.endianness, self.elfclass)
>>>>          phdr.p_type =3D p_type
>>>>          phdr.p_paddr =3D p_paddr
>>>> +        phdr.p_vaddr =3D p_paddr
>>>
>>> With your proposed change though, I can dump memory with gdb...
>>>
>>>>          phdr.p_filesz =3D p_size
>>>>          phdr.p_memsz =3D p_size
>>>>          self.segments.append(phdr)
>>>> --
>>>> 2.19.2
>>>>
>>>>
>>>
>>>
>>
>> I've never used paging-enabled dumps. First, because doing so requires
>> QEMU to trust guest memory contents (see original commit 783e9b4826b9;
>> or more recently/generally, the @dump-guest-memory docs in
>> "qapi/misc.json"). Second, because whenever I had to deal with guest
>> memory dumps, I always used "crash" (which needs no paging), and the
>> subject guests were all Linux.
>>
>> I can't comment on paging-enabled patches for dump, except that they
>> shouldn't regress the paging-disabled functionality. :) If the patches
>> satisfy that, I'm fine.
>>
>> (I *am* surprised that GDB insists on p_vaddr equaling p_paddr; after
>> all, in the guest, the virtual address is "memory_mapping->virt_addr".
>> But, I would never claim to understand most of the ELF intricacies,
>> and/or what GDB requires on top of those.)
>>
>> Thanks
>> Laszlo
