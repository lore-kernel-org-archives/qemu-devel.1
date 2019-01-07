Received: from eggs.gnu.org ([209.51.188.92]:45260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ggTnu-0000wL-GE
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:14:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ggTnt-0006wX-Oj
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:14:50 -0500
MIME-Version: 1.0
References: <20181225125344.4482-1-arilou@gmail.com>
In-Reply-To: <20181225125344.4482-1-arilou@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 7 Jan 2019 16:14:36 +0400
Message-ID: <CAJ+F1CJN=Gn5GYqrOeqWFNryw=q+7q8TDUX0VQEzrtS8tbUeQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU <qemu-devel@nongnu.org>, qemu trival <qemu-trivial@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Wen Congyang <wency@cn.fujitsu.com>, Luiz Capitulino <lcapitulino@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Tue, Dec 25, 2018 at 5:52 PM Jon Doron <arilou@gmail.com> wrote:
>
> vaddr needs to be equal to the paddr since the dump file represents the
> physical memory image.
>
> Without setting vaddr correctly, GDB would load all the different memory
> regions on top of each other to vaddr 0, thus making GDB showing the wron=
g
> memory data for a given address.
>
> Signed-off-by: Jon Doron <arilou@gmail.com>

This is a non-trivial patch! (qemu-trivial, please ignore).

> ---
>  dump.c                       | 4 ++--
>  scripts/dump-guest-memory.py | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/dump.c b/dump.c
> index 4ec94c5e25..bf77a119ea 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -192,7 +192,7 @@ static void write_elf64_load(DumpState *s, MemoryMapp=
ing *memory_mapping,
>      phdr.p_paddr =3D cpu_to_dump64(s, memory_mapping->phys_addr);
>      phdr.p_filesz =3D cpu_to_dump64(s, filesz);
>      phdr.p_memsz =3D cpu_to_dump64(s, memory_mapping->length);
> -    phdr.p_vaddr =3D cpu_to_dump64(s, memory_mapping->virt_addr);
> +    phdr.p_vaddr =3D phdr.p_paddr;

This is likely breaking paging=3Dtrue somehow, which sets
memory_mapping->virt_addr to non-0.

According to doc "If you want to use gdb to process the core, please
set @paging to true."

Although I am not able to (gdb) x/10bx 0xa0000 for example on a core
produced with paging. Not sure why, anybody could help?

>      assert(memory_mapping->length >=3D filesz);
>
> @@ -216,7 +216,7 @@ static void write_elf32_load(DumpState *s, MemoryMapp=
ing *memory_mapping,
>      phdr.p_paddr =3D cpu_to_dump32(s, memory_mapping->phys_addr);
>      phdr.p_filesz =3D cpu_to_dump32(s, filesz);
>      phdr.p_memsz =3D cpu_to_dump32(s, memory_mapping->length);
> -    phdr.p_vaddr =3D cpu_to_dump32(s, memory_mapping->virt_addr);
> +    phdr.p_vaddr =3D phdr.p_paddr;
>
>      assert(memory_mapping->length >=3D filesz);
>
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
> index 198cd0fe40..2c587cbefc 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -163,6 +163,7 @@ class ELF(object):
>          phdr =3D get_arch_phdr(self.endianness, self.elfclass)
>          phdr.p_type =3D p_type
>          phdr.p_paddr =3D p_paddr
> +        phdr.p_vaddr =3D p_paddr

With your proposed change though, I can dump memory with gdb...

>          phdr.p_filesz =3D p_size
>          phdr.p_memsz =3D p_size
>          self.segments.append(phdr)
> --
> 2.19.2
>
>


--=20
Marc-Andr=C3=A9 Lureau
