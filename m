Received: from eggs.gnu.org ([209.51.188.92]:39024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ghBFW-0008KX-UI
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ghBFV-0008BH-Rl
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:38:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ghBFU-0008Aa-HK
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:38:13 -0500
References: <20190109082203.27142-1-arilou@gmail.com>
	<CAJ+F1CK1Y4qyzJrebiU8wQdaJ6-JM_WEywsURmF4mB2Tk7UMOA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c1b80e0b-f809-5b33-98d0-081dff2e79cb@redhat.com>
Date: Wed, 9 Jan 2019 11:38:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CK1Y4qyzJrebiU8wQdaJ6-JM_WEywsURmF4mB2Tk7UMOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] dump: Set correct vaddr for ELF dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Jon Doron <arilou@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

On 01/09/19 09:25, Marc-Andr=C3=A9 Lureau wrote:
> On Wed, Jan 9, 2019 at 12:22 PM Jon Doron <arilou@gmail.com> wrote:
>>
>> vaddr needs to be equal to the paddr since the dump file represents th=
e
>> physical memory image.
>>
>> Without setting vaddr correctly, GDB would load all the different memo=
ry
>> regions on top of each other to vaddr 0, thus making GDB showing the w=
rong
>> memory data for a given address.
>>
>> Signed-off-by: Jon Doron <arilou@gmail.com>
>=20
> Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Apparently the only change in v3, relative to v2, is cleaning up the
whitespace problem that was caught by Patchew.

Acked-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

>>  dump.c                       | 5 +++--
>>  scripts/dump-guest-memory.py | 1 +
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/dump.c b/dump.c
>> index 4ec94c5e25..de7f70f099 100644
>> --- a/dump.c
>> +++ b/dump.c
>> @@ -192,7 +192,7 @@ static void write_elf64_load(DumpState *s, MemoryM=
apping *memory_mapping,
>>      phdr.p_paddr =3D cpu_to_dump64(s, memory_mapping->phys_addr);
>>      phdr.p_filesz =3D cpu_to_dump64(s, filesz);
>>      phdr.p_memsz =3D cpu_to_dump64(s, memory_mapping->length);
>> -    phdr.p_vaddr =3D cpu_to_dump64(s, memory_mapping->virt_addr);
>> +    phdr.p_vaddr =3D cpu_to_dump64(s, memory_mapping->virt_addr) ? : =
phdr.p_paddr;
>>
>>      assert(memory_mapping->length >=3D filesz);
>>
>> @@ -216,7 +216,8 @@ static void write_elf32_load(DumpState *s, MemoryM=
apping *memory_mapping,
>>      phdr.p_paddr =3D cpu_to_dump32(s, memory_mapping->phys_addr);
>>      phdr.p_filesz =3D cpu_to_dump32(s, filesz);
>>      phdr.p_memsz =3D cpu_to_dump32(s, memory_mapping->length);
>> -    phdr.p_vaddr =3D cpu_to_dump32(s, memory_mapping->virt_addr);
>> +    phdr.p_vaddr =3D
>> +        cpu_to_dump32(s, memory_mapping->virt_addr) ? : phdr.p_paddr;
>>
>>      assert(memory_mapping->length >=3D filesz);
>>
>> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.=
py
>> index 198cd0fe40..2c587cbefc 100644
>> --- a/scripts/dump-guest-memory.py
>> +++ b/scripts/dump-guest-memory.py
>> @@ -163,6 +163,7 @@ class ELF(object):
>>          phdr =3D get_arch_phdr(self.endianness, self.elfclass)
>>          phdr.p_type =3D p_type
>>          phdr.p_paddr =3D p_paddr
>> +        phdr.p_vaddr =3D p_paddr
>>          phdr.p_filesz =3D p_size
>>          phdr.p_memsz =3D p_size
>>          self.segments.append(phdr)
>> --
>> 2.19.2
>>
>>
>=20
>=20
I pre
