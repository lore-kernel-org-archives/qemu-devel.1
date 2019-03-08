Received: from eggs.gnu.org ([209.51.188.92]:46548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1h2CGS-0003ja-RN
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1h2CGR-0000t3-MB
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:58:04 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1h2CGR-0000pP-DX
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:58:03 -0500
References: <87va0vgad2.fsf@zen.linaroharston>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <67ec0d63-69e2-6f2e-aa76-6950bca69e90@oracle.com>
Date: Fri, 8 Mar 2019 09:57:49 +0000
MIME-Version: 1.0
In-Reply-To: <87va0vgad2.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <bonzini@gnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, liam.merwick@oracle.com

On 06/03/2019 17:51, Alex Benn=C3=A9e wrote:
>=20
> Hi,
>=20
> I've been looking at using PVH as an alternative to a long bios boot
> sequence to boot some x86_64 test kernels for tests/tcg. I'm finding it
> hard to piece together all the bits but I naively thought it would just
> be a case of adding a few ELF NOTES to my boot.S with something like:
>=20
>            ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR 0x100000)
>            ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR _start)
>            ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,   _ASM_PTR 0)    /* e=
ntry =3D=3D virtbase */
>            ELFNOTE(Xen, XEN_ELFNOTE_PADDR_OFFSET,   _ASM_PTR 0)
>=20
>            .code64
>            .section .text
>            /* Kernel Entry Point */
>    .global _start
>    _start:
>            // Setup stack ASAP
>            movq $stack_end,%rsp
>=20
> However I'm running into lots of head scratching as the get_elf_note
> code seems to skip over the notes before failing:
>=20
>    ./qemu-system-x86_64 -monitor none -display none \
>      -chardev stdio,id=3Dout -device isa-debugcon,chardev=3Dout \
>      -device isa-debug-exit,iobase=3D0xf4,iosize=3D0x4 -kernel ./tests/=
hello
>    load_elf64: processing hdr:0 of type 1
>    load_elf64: processing hdr:1 of type 4
>    get_elf_note_type64: looking for type 18, first is 3
>    get_elf_note_type64: 4/20
>    get_elf_note_type64: offset is 36
>    get_elf_note_type64: note is 0
>    get_elf_note_type64: 0/123713
>    get_elf_note_type64: offset is 123728
>    load_elf64: processing hdr:2 of type 1685382481
>    qemu-system-x86_64: Error loading uncompressed kernel without PVH EL=
F Note



What does 'readelf -Wn ./tests/hello' or 'readelf -p .notes=20
./tests/hello' show?



>=20
> So I thought I'd go back to the Linux kernel and see if I could get it
> to boot up. So I built an x86_64 kernel with:
>=20
>    CONFIG_XEN_PVHVM=3Dy
>    CONFIG_XEN_PVHVM_SMP=3Dy
>    CONFIG_XEN_PVH=3Dy
>    CONFIG_PVH=3Dy
>=20
> And tried to boot that, it certainly gets a lot further but in detectin=
g
> the note 18 it's looking for but then doesn't provide any output. So I
> started digging around the patches and saw talk of a PVH option ROM
> which does all the x86 mode escalation before booting the kernel.
> However I was unable to find any documentation about if I should be
> adding this manually to my command line or if it is auto-magiced into
> place. So I have a number of questions:
>=20
>    * what's the canonical command line for booting a Linux PVHVM kernel=
?

I had been using '-bios ./qboot.bin' (using=20
https://github.com/bonzini/qboot/pull/17/files) but Stefano's changes=20
mean that isn't necessary. Here's a command line I used

sudo $QEMU \
       -name testvm01 \
       -machine=20
q35,accel=3Dkvm,kernel_irqchip,nvdimm,nosmm,nosmbus,nosata,nopit \
       -cpu host \
       -m 1024,maxmem=3D20G,slots=3D2 \
       -smp 1 \
       -no-user-config \
       -nodefaults \
       -object=20
memory-backend-file,id=3Dmem0,share,mem-path=3D$IMAGE,size=3D235929600 \
       -device nvdimm,memdev=3Dmem0,id=3Dnv0 \
       -append 'console=3DttyS0,115200,8n1 root=3D/dev/pmem0p1 panic=3D1 =
rw=20
tsc=3Dreliable no_timer_check noreplace-smp init=3D/usr/lib/systemd/syste=
md=20
rootfstype=3Dext4 rcupdate.rcu_expedited=3D1 reboot=3Df' \
       -no-reboot \
       -serial mon:stdio \
       -kernel $KERNEL


>    * should this work in TCG as well?
>    * are they any special linker rules required for the Xen.notes?
>=20
> And finally:
>=20
>    * is this idea of mine a weird abuse of the PVHVM boot protocol or
>      does it make sense?
>=20


Regards,
Liam
