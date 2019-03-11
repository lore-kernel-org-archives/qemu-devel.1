Received: from eggs.gnu.org ([209.51.188.92]:51687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1h3HFy-0000hi-Qx
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1h3HFx-0001OO-LL
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:30:02 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:55748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1h3HFx-0001Nt-DU
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:30:01 -0400
Received: by mail-wm1-f53.google.com with SMTP id q187so3621358wme.5
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 02:30:00 -0700 (PDT)
Date: Mon, 11 Mar 2019 10:29:56 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190311092956.woo6mfecw3qyxxet@steredhat>
References: <87va0vgad2.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87va0vgad2.fsf@zen.linaroharston>
Subject: Re: [Qemu-devel] Booting kernels with PVHVM documentation?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Liam Merwick <liam.merwick@oracle.com>, Paolo Bonzini <bonzini@gnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Alex,
sorry for the big delay, but I was traveling without my PC.

On Wed, Mar 06, 2019 at 05:51:05PM +0000, Alex Bennée wrote:
> 
> Hi,
> 
> I've been looking at using PVH as an alternative to a long bios boot
> sequence to boot some x86_64 test kernels for tests/tcg. I'm finding it
> hard to piece together all the bits but I naively thought it would just
> be a case of adding a few ELF NOTES to my boot.S with something like:
> 
>           ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR 0x100000)
>           ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR _start)
>           ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,   _ASM_PTR 0)    /* entry == virtbase */
>           ELFNOTE(Xen, XEN_ELFNOTE_PADDR_OFFSET,   _ASM_PTR 0)
> 
>           .code64

Can you try to use .code32?
The pvh.bin optionrom will jump to the image in 32-bit mode.
I don't have a lot of experience, but looking at arch/x86/platform/pvh/head.S
(Linux), I saw that entry point is under .code32, than it will switch to
64-bit mode.

>           .section .text
>           /* Kernel Entry Point */
>   .global _start
>   _start:
>           // Setup stack ASAP
>           movq $stack_end,%rsp
> 
> However I'm running into lots of head scratching as the get_elf_note
> code seems to skip over the notes before failing:
> 
>   ./qemu-system-x86_64 -monitor none -display none \
>     -chardev stdio,id=out -device isa-debugcon,chardev=out \
>     -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel ./tests/hello
>   load_elf64: processing hdr:0 of type 1
>   load_elf64: processing hdr:1 of type 4
>   get_elf_note_type64: looking for type 18, first is 3
>   get_elf_note_type64: 4/20
>   get_elf_note_type64: offset is 36
>   get_elf_note_type64: note is 0
>   get_elf_note_type64: 0/123713
>   get_elf_note_type64: offset is 123728
>   load_elf64: processing hdr:2 of type 1685382481
>   qemu-system-x86_64: Error loading uncompressed kernel without PVH ELF Note
> 
> So I thought I'd go back to the Linux kernel and see if I could get it
> to boot up. So I built an x86_64 kernel with:
> 
>   CONFIG_XEN_PVHVM=y
>   CONFIG_XEN_PVHVM_SMP=y
>   CONFIG_XEN_PVH=y
>   CONFIG_PVH=y

I enabled only CONFIG_PVH to boot a vmlinux image with PVH support.

> 
> And tried to boot that, it certainly gets a lot further but in detecting
> the note 18 it's looking for but then doesn't provide any output. So I
> started digging around the patches and saw talk of a PVH option ROM
> which does all the x86 mode escalation before booting the kernel.
> However I was unable to find any documentation about if I should be
> adding this manually to my command line or if it is auto-magiced into
> place. So I have a number of questions:

Sorry for that, I'll wrote some docs to cover this feature.

> 
>   * what's the canonical command line for booting a Linux PVHVM kernel?

You can use the standard -kernel parameter specifying the path to the
vmlinux image compiled with CONFIG_PVH=y. For example I'm using this
command:
./x86_64-softmmu/qemu-system-x86_64 -machine pc,accel=kvm \
    -kernel /path/to/vmlinux \
    -drive file=/path/to/rootfs.ext2,if=virtio,format=raw \
    -append 'root=/dev/vda console=ttyS0' -vga none -display none \
    -serial mon:stdio

QEMU will detect the PVH image and it will use SeaBIOS with the new pvh.bin
optionrom to boot the image.

>   * should this work in TCG as well?

Yes, I tried the following command and it works:
./x86_64-softmmu/qemu-system-x86_64 -machine pc,accel=tcg \
    -kernel /path/to/vmlinux \
    -drive file=/path/to/rootfs.ext2,if=virtio,format=raw \
    -append 'root=/dev/vda ro console=ttyS0' -vga none -display none \
    -serial mon:stdio

>   * are they any special linker rules required for the Xen.notes?

I don't know, but I'll investigate on it.

> 
> And finally:
> 
>   * is this idea of mine a weird abuse of the PVHVM boot protocol or
>     does it make sense?

IMHO it isn't an abuse and make sense to boot a bare-metal application
directly in 32-bit mode using the PVH loader.

If you want to share with me a part of your code, I'll try to play with
it.

Cheers,
Stefano
