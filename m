Received: from eggs.gnu.org ([209.51.188.92]:55723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h1ahB-0004mT-Oe
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 12:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h1ahA-00025v-TX
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 12:51:09 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:36622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1h1ahA-00025H-Jj
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 12:51:08 -0500
Received: by mail-wm1-x336.google.com with SMTP id j125so6799346wmj.1
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 09:51:08 -0800 (PST)
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 06 Mar 2019 17:51:05 +0000
Message-ID: <87va0vgad2.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Booting kernels with PVHVM documentation?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>, Liam Merwick <liam.merwick@oracle.com>, Paolo Bonzini <bonzini@gnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


Hi,

I've been looking at using PVH as an alternative to a long bios boot
sequence to boot some x86_64 test kernels for tests/tcg. I'm finding it
hard to piece together all the bits but I naively thought it would just
be a case of adding a few ELF NOTES to my boot.S with something like:

          ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR 0x100000)
          ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR _start)
          ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,   _ASM_PTR 0)    /* entry =
=3D=3D virtbase */
          ELFNOTE(Xen, XEN_ELFNOTE_PADDR_OFFSET,   _ASM_PTR 0)

          .code64
          .section .text
          /* Kernel Entry Point */
  .global _start
  _start:
          // Setup stack ASAP
          movq $stack_end,%rsp

However I'm running into lots of head scratching as the get_elf_note
code seems to skip over the notes before failing:

  ./qemu-system-x86_64 -monitor none -display none \
    -chardev stdio,id=3Dout -device isa-debugcon,chardev=3Dout \
    -device isa-debug-exit,iobase=3D0xf4,iosize=3D0x4 -kernel ./tests/hello
  load_elf64: processing hdr:0 of type 1
  load_elf64: processing hdr:1 of type 4
  get_elf_note_type64: looking for type 18, first is 3
  get_elf_note_type64: 4/20
  get_elf_note_type64: offset is 36
  get_elf_note_type64: note is 0
  get_elf_note_type64: 0/123713
  get_elf_note_type64: offset is 123728
  load_elf64: processing hdr:2 of type 1685382481
  qemu-system-x86_64: Error loading uncompressed kernel without PVH ELF Note

So I thought I'd go back to the Linux kernel and see if I could get it
to boot up. So I built an x86_64 kernel with:

  CONFIG_XEN_PVHVM=3Dy
  CONFIG_XEN_PVHVM_SMP=3Dy
  CONFIG_XEN_PVH=3Dy
  CONFIG_PVH=3Dy

And tried to boot that, it certainly gets a lot further but in detecting
the note 18 it's looking for but then doesn't provide any output. So I
started digging around the patches and saw talk of a PVH option ROM
which does all the x86 mode escalation before booting the kernel.
However I was unable to find any documentation about if I should be
adding this manually to my command line or if it is auto-magiced into
place. So I have a number of questions:

  * what's the canonical command line for booting a Linux PVHVM kernel?
  * should this work in TCG as well?
  * are they any special linker rules required for the Xen.notes?

And finally:

  * is this idea of mine a weird abuse of the PVHVM boot protocol or
    does it make sense?

Thanks in advance for any elucidation ;-)

--
Alex Benn=C3=A9e
