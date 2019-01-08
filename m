Received: from eggs.gnu.org ([209.51.188.92]:52625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1ggkvD-0006OD-01
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1ggkvB-0006oQ-20
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:31:30 -0500
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:41321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1ggkvA-0006hl-P6
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:31:28 -0500
Received: by mail-vs1-xe41.google.com with SMTP id t17so1803410vsc.8
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 22:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20181225125344.4482-1-arilou@gmail.com>
	<CAJ+F1CJN=Gn5GYqrOeqWFNryw=q+7q8TDUX0VQEzrtS8tbUeQg@mail.gmail.com>
	<7961a154-f139-af73-613d-94b88bf95392@redhat.com>
In-Reply-To: <7961a154-f139-af73-613d-94b88bf95392@redhat.com>
From: Jon Doron <arilou@gmail.com>
Date: Tue, 8 Jan 2019 08:31:14 +0200
Message-ID: <CAP7QCogAWOWgkzL+ebufbpiaap=iSaNh+HWP4N3Sx1OwseQxhA@mail.gmail.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Wen Congyang <wency@cn.fujitsu.com>, Luiz Capitulino <lcapitulino@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Thank you for looking into this, perhaps I could change the patch (at
least in the C part not the python script) to something like:
-    phdr.p_vaddr =3D cpu_to_dumpXX(s, memory_mapping->virt_addr);
+    phdr.p_vaddr =3D cpu_to_dumpXX(s, memory_mapping->virt_addr) ?
cpu_to_dumpXX(s, memory_mapping->virt_addr) : phdr.p_paddr;

So in the case of paging where virt_addr is available we will use it

Thanks,
-- Jon.

On Mon, Jan 7, 2019 at 8:04 PM Laszlo Ersek <lersek@redhat.com> wrote:
>
> On 01/07/19 13:14, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Dec 25, 2018 at 5:52 PM Jon Doron <arilou@gmail.com> wrote:
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
> > This is a non-trivial patch! (qemu-trivial, please ignore).
> >
> >> ---
> >>  dump.c                       | 4 ++--
> >>  scripts/dump-guest-memory.py | 1 +
> >>  2 files changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/dump.c b/dump.c
> >> index 4ec94c5e25..bf77a119ea 100644
> >> --- a/dump.c
> >> +++ b/dump.c
> >> @@ -192,7 +192,7 @@ static void write_elf64_load(DumpState *s, MemoryM=
apping *memory_mapping,
> >>      phdr.p_paddr =3D cpu_to_dump64(s, memory_mapping->phys_addr);
> >>      phdr.p_filesz =3D cpu_to_dump64(s, filesz);
> >>      phdr.p_memsz =3D cpu_to_dump64(s, memory_mapping->length);
> >> -    phdr.p_vaddr =3D cpu_to_dump64(s, memory_mapping->virt_addr);
> >> +    phdr.p_vaddr =3D phdr.p_paddr;
> >
> > This is likely breaking paging=3Dtrue somehow, which sets
> > memory_mapping->virt_addr to non-0.
> >
> > According to doc "If you want to use gdb to process the core, please
> > set @paging to true."
> >
> > Although I am not able to (gdb) x/10bx 0xa0000 for example on a core
> > produced with paging. Not sure why, anybody could help?
> >
> >>      assert(memory_mapping->length >=3D filesz);
> >>
> >> @@ -216,7 +216,7 @@ static void write_elf32_load(DumpState *s, MemoryM=
apping *memory_mapping,
> >>      phdr.p_paddr =3D cpu_to_dump32(s, memory_mapping->phys_addr);
> >>      phdr.p_filesz =3D cpu_to_dump32(s, filesz);
> >>      phdr.p_memsz =3D cpu_to_dump32(s, memory_mapping->length);
> >> -    phdr.p_vaddr =3D cpu_to_dump32(s, memory_mapping->virt_addr);
> >> +    phdr.p_vaddr =3D phdr.p_paddr;
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
> >
> > With your proposed change though, I can dump memory with gdb...
> >
> >>          phdr.p_filesz =3D p_size
> >>          phdr.p_memsz =3D p_size
> >>          self.segments.append(phdr)
> >> --
> >> 2.19.2
> >>
> >>
> >
> >
>
> I've never used paging-enabled dumps. First, because doing so requires
> QEMU to trust guest memory contents (see original commit 783e9b4826b9;
> or more recently/generally, the @dump-guest-memory docs in
> "qapi/misc.json"). Second, because whenever I had to deal with guest
> memory dumps, I always used "crash" (which needs no paging), and the
> subject guests were all Linux.
>
> I can't comment on paging-enabled patches for dump, except that they
> shouldn't regress the paging-disabled functionality. :) If the patches
> satisfy that, I'm fine.
>
> (I *am* surprised that GDB insists on p_vaddr equaling p_paddr; after
> all, in the guest, the virtual address is "memory_mapping->virt_addr".
> But, I would never claim to understand most of the ELF intricacies,
> and/or what GDB requires on top of those.)
>
> Thanks
> Laszlo
