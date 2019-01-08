Received: from eggs.gnu.org ([209.51.188.92]:37740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ggr5B-0004bd-RF
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ggr58-0002gV-RO
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:06:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ggr54-0002E3-TJ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:06:10 -0500
Received: by mail-qt1-f196.google.com with SMTP id p17so4220463qtl.5
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 05:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20190108130219.18550-1-arilou@gmail.com>
In-Reply-To: <20190108130219.18550-1-arilou@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 8 Jan 2019 17:05:46 +0400
Message-ID: <CAMxuvayU-0nLmcMs3zWF61Y5GT9u8AtaZtZApdbYaDDDoCti=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] dump: Set correct vaddr for ELF dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jon Doron <arilou@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>

On Tue, Jan 8, 2019 at 5:02 PM Jon Doron <arilou@gmail.com> wrote:
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

Not sure we are doing everything correctly, but solves the non-paging
GDB case, so:

Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  dump.c                       | 5 +++--
>  scripts/dump-guest-memory.py | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/dump.c b/dump.c
> index 4ec94c5e25..7a56e254d4 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -192,7 +192,7 @@ static void write_elf64_load(DumpState *s, MemoryMapp=
ing *memory_mapping,
>      phdr.p_paddr =3D cpu_to_dump64(s, memory_mapping->phys_addr);
>      phdr.p_filesz =3D cpu_to_dump64(s, filesz);
>      phdr.p_memsz =3D cpu_to_dump64(s, memory_mapping->length);
> -    phdr.p_vaddr =3D cpu_to_dump64(s, memory_mapping->virt_addr);
> +    phdr.p_vaddr =3D cpu_to_dump64(s, memory_mapping->virt_addr) ? : phd=
r.p_paddr;
>
>      assert(memory_mapping->length >=3D filesz);
>
> @@ -216,7 +216,8 @@ static void write_elf32_load(DumpState *s, MemoryMapp=
ing *memory_mapping,
>      phdr.p_paddr =3D cpu_to_dump32(s, memory_mapping->phys_addr);
>      phdr.p_filesz =3D cpu_to_dump32(s, filesz);
>      phdr.p_memsz =3D cpu_to_dump32(s, memory_mapping->length);
> -    phdr.p_vaddr =3D cpu_to_dump32(s, memory_mapping->virt_addr);
> +    phdr.p_vaddr =3D
> +               cpu_to_dump32(s, memory_mapping->virt_addr) ? : phdr.p_pa=
ddr;
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
>          phdr.p_filesz =3D p_size
>          phdr.p_memsz =3D p_size
>          self.segments.append(phdr)
> --
> 2.19.2
>
