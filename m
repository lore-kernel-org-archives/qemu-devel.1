Received: from eggs.gnu.org ([209.51.188.92]:57488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h2CyF-0002uI-3f
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:43:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h2CyD-00080n-SI
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:43:19 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1h2CyD-0007z1-He
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:43:17 -0500
Received: by mail-wm1-x342.google.com with SMTP id q187so12174076wme.5
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 02:43:17 -0800 (PST)
References: <87va0vgad2.fsf@zen.linaroharston>
	<67ec0d63-69e2-6f2e-aa76-6950bca69e90@oracle.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <67ec0d63-69e2-6f2e-aa76-6950bca69e90@oracle.com>
Date: Fri, 08 Mar 2019 10:43:14 +0000
Message-ID: <87bm2lfxz1.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Booting kernels with PVHVM documentation?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <bonzini@gnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


Liam Merwick <liam.merwick@oracle.com> writes:

> On 06/03/2019 17:51, Alex Benn=C3=A9e wrote:
>>
>> Hi,
>>
>> I've been looking at using PVH as an alternative to a long bios boot
>> sequence to boot some x86_64 test kernels for tests/tcg. I'm finding it
>> hard to piece together all the bits but I naively thought it would just
>> be a case of adding a few ELF NOTES to my boot.S with something like:
>>
>>            ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR 0x100000)
>>            ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR _start)
>>            ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,   _ASM_PTR 0)    /* en=
try =3D=3D virtbase */
>>            ELFNOTE(Xen, XEN_ELFNOTE_PADDR_OFFSET,   _ASM_PTR 0)
>>
>>            .code64
>>            .section .text
>>            /* Kernel Entry Point */
>>    .global _start
>>    _start:
>>            // Setup stack ASAP
>>            movq $stack_end,%rsp
>>
>> However I'm running into lots of head scratching as the get_elf_note
>> code seems to skip over the notes before failing:
>>
>>    ./qemu-system-x86_64 -monitor none -display none \
>>      -chardev stdio,id=3Dout -device isa-debugcon,chardev=3Dout \
>>      -device isa-debug-exit,iobase=3D0xf4,iosize=3D0x4 -kernel ./tests/h=
ello
>>    load_elf64: processing hdr:0 of type 1
>>    load_elf64: processing hdr:1 of type 4
>>    get_elf_note_type64: looking for type 18, first is 3
>>    get_elf_note_type64: 4/20
>>    get_elf_note_type64: offset is 36
>>    get_elf_note_type64: note is 0
>>    get_elf_note_type64: 0/123713
>>    get_elf_note_type64: offset is 123728
>>    load_elf64: processing hdr:2 of type 1685382481
>>    qemu-system-x86_64: Error loading uncompressed kernel without PVH ELF=
 Note
>
>
>
> What does 'readelf -Wn ./tests/hello' or 'readelf -p .notes
> ./tests/hello' show?

$ readelf -Wn tests/hello

Displaying notes found in: .note.gnu.build-id
  Owner                 Data size       Description
  GNU                  0x00000014       NT_GNU_BUILD_ID (unique build ID bi=
tstring)         Build ID: 919289306d162384e3c8a38441088cf6c511f623

Displaying notes found in: .note.Xen
  Owner                 Data size       Description
  Xen                  0x00000008       Unknown note type: (0x00000003)    =
description data: 00 00 10 00 00 00 00 00
  Xen                  0x00000008       NT_VERSION (version)       descript=
ion data: 40 00 10 00 00 00 00 00
  Xen                  0x00000008       Unknown note type: (0x00000012)    =
description data: 00 00 00 00 00 00 00 00
  Xen                  0x00000008       Unknown note type: (0x00000004)    =
description data: 00 00 00 00 00 00 00 00

$ readelf -p .notes tests/hello
readelf: Warning: Section '.notes' was not dumped because it does not exist!

>>
>> So I thought I'd go back to the Linux kernel and see if I could get it
>> to boot up. So I built an x86_64 kernel with:
>>
>>    CONFIG_XEN_PVHVM=3Dy
>>    CONFIG_XEN_PVHVM_SMP=3Dy
>>    CONFIG_XEN_PVH=3Dy
>>    CONFIG_PVH=3Dy
>>
>> And tried to boot that, it certainly gets a lot further but in detecting
>> the note 18 it's looking for but then doesn't provide any output. So I
>> started digging around the patches and saw talk of a PVH option ROM
>> which does all the x86 mode escalation before booting the kernel.
>> However I was unable to find any documentation about if I should be
>> adding this manually to my command line or if it is auto-magiced into
>> place. So I have a number of questions:
>>
>>    * what's the canonical command line for booting a Linux PVHVM kernel?
>
> I had been using '-bios ./qboot.bin' (using
> https://github.com/bonzini/qboot/pull/17/files) but Stefano's changes
> mean that isn't necessary. Here's a command line I used

I think they are all in.

>
> sudo $QEMU \
>       -name testvm01 \
>       -machine
> q35,accel=3Dkvm,kernel_irqchip,nvdimm,nosmm,nosmbus,nosata,nopit \

Hmm if I use the q35 machine type I might have to rethink the approach
for getting output and results as I'm currently using the isa debugcon
and debug exit devices.

I wonder how much framework I would need for a minimal virtio or PV
serial implementation? Currently the ISA stuff is dumb as bricks and
simple:

        /* Output a single character to serial port */
        .global __sys_outc
__sys_outc:
        pushl %ebp
        movl %esp, %ebp
	out %al,$0xE9
        movl %ebp, %esp
        popl %ebp
        ret

and:

        /* output any non-zero result in eax to isa-debug-exit device */
        test %al, %al
        jz 1f
        out %ax, $0xf4

1:      /* QEMU ACPI poweroff */
	mov $0x604,%edx
	mov $0x2000,%eax
	out %ax,%dx
	hlt
	jmp 1b



>       -cpu host \
>       -m 1024,maxmem=3D20G,slots=3D2 \
>       -smp 1 \
>       -no-user-config \
>       -nodefaults \
>       -object
> memory-backend-file,id=3Dmem0,share,mem-path=3D$IMAGE,size=3D235929600 \
>       -device nvdimm,memdev=3Dmem0,id=3Dnv0 \
>       -append 'console=3DttyS0,115200,8n1 root=3D/dev/pmem0p1 panic=3D1 rw
> tsc=3Dreliable no_timer_check noreplace-smp
> init=3D/usr/lib/systemd/systemd rootfstype=3Dext4 rcupdate.rcu_expedited=
=3D1
> reboot=3Df' \
>       -no-reboot \
>       -serial mon:stdio \
>       -kernel $KERNEL
>
>
>>    * should this work in TCG as well?
>>    * are they any special linker rules required for the Xen.notes?
>>
>> And finally:
>>
>>    * is this idea of mine a weird abuse of the PVHVM boot protocol or
>>      does it make sense?
>>


--
Alex Benn=C3=A9e
