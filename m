Received: from eggs.gnu.org ([209.51.188.92]:42530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1glokK-00043N-0B
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:37:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1glokJ-0007vA-9Q
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:37:11 -0500
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:36189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1glokJ-0007uQ-4k
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:37:11 -0500
Received: by mail-vs1-xe43.google.com with SMTP id v205so14008100vsc.3
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 21:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20190109082203.27142-1-arilou@gmail.com>
	<CAJ+F1CK1Y4qyzJrebiU8wQdaJ6-JM_WEywsURmF4mB2Tk7UMOA@mail.gmail.com>
	<c1b80e0b-f809-5b33-98d0-081dff2e79cb@redhat.com>
In-Reply-To: <c1b80e0b-f809-5b33-98d0-081dff2e79cb@redhat.com>
From: Jon Doron <arilou@gmail.com>
Date: Tue, 22 Jan 2019 07:36:57 +0200
Message-ID: <CAP7QCoich3_wvW6xnCfL3+nfRFJ6=JEMY4g28F+jRfkLqOs=Uw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>

ping, so this means that the patch will be merged in?

Thanks,
-- Jon.

On Wed, Jan 9, 2019 at 12:38 PM Laszlo Ersek <lersek@redhat.com> wrote:
>
> On 01/09/19 09:25, Marc-Andr=C3=A9 Lureau wrote:
> > On Wed, Jan 9, 2019 at 12:22 PM Jon Doron <arilou@gmail.com> wrote:
> >>
> >> vaddr needs to be equal to the paddr since the dump file represents th=
e
> >> physical memory image.
> >>
> >> Without setting vaddr correctly, GDB would load all the different memo=
ry
> >> regions on top of each other to vaddr 0, thus making GDB showing the w=
rong
> >> memory data for a given address.
> >>
> >> Signed-off-by: Jon Doron <arilou@gmail.com>
> >
> > Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Apparently the only change in v3, relative to v2, is cleaning up the
> whitespace problem that was caught by Patchew.
>
> Acked-by: Laszlo Ersek <lersek@redhat.com>
>
> Thanks
> Laszlo
>
> >>  dump.c                       | 5 +++--
> >>  scripts/dump-guest-memory.py | 1 +
> >>  2 files changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/dump.c b/dump.c
> >> index 4ec94c5e25..de7f70f099 100644
> >> --- a/dump.c
> >> +++ b/dump.c
> >> @@ -192,7 +192,7 @@ static void write_elf64_load(DumpState *s, MemoryM=
apping *memory_mapping,
> >>      phdr.p_paddr =3D cpu_to_dump64(s, memory_mapping->phys_addr);
> >>      phdr.p_filesz =3D cpu_to_dump64(s, filesz);
> >>      phdr.p_memsz =3D cpu_to_dump64(s, memory_mapping->length);
> >> -    phdr.p_vaddr =3D cpu_to_dump64(s, memory_mapping->virt_addr);
> >> +    phdr.p_vaddr =3D cpu_to_dump64(s, memory_mapping->virt_addr) ? : =
phdr.p_paddr;
> >>
> >>      assert(memory_mapping->length >=3D filesz);
> >>
> >> @@ -216,7 +216,8 @@ static void write_elf32_load(DumpState *s, MemoryM=
apping *memory_mapping,
> >>      phdr.p_paddr =3D cpu_to_dump32(s, memory_mapping->phys_addr);
> >>      phdr.p_filesz =3D cpu_to_dump32(s, filesz);
> >>      phdr.p_memsz =3D cpu_to_dump32(s, memory_mapping->length);
> >> -    phdr.p_vaddr =3D cpu_to_dump32(s, memory_mapping->virt_addr);
> >> +    phdr.p_vaddr =3D
> >> +        cpu_to_dump32(s, memory_mapping->virt_addr) ? : phdr.p_paddr;
> >>
> >>      assert(memory_mapping->length >=3D filesz);
> >>
> >> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.=
py
> >> index 198cd0fe40..2c587cbefc 100644
> >> --- a/scripts/dump-guest-memory.py
> >> +++ b/scripts/dump-guest-memory.py
> >> @@ -163,6 +163,7 @@ class ELF(object):
> >>          phdr =3D get_arch_phdr(self.endianness, self.elfclass)
> >>          phdr.p_type =3D p_type
> >>          phdr.p_paddr =3D p_paddr
> >> +        phdr.p_vaddr =3D p_paddr
> >>          phdr.p_filesz =3D p_size
> >>          phdr.p_memsz =3D p_size
> >>          self.segments.append(phdr)
> >> --
> >> 2.19.2
> >>
> >>
> >
> >
> I pre
