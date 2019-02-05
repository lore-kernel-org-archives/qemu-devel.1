Received: from eggs.gnu.org ([209.51.188.92]:45551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gr5bL-0003P7-Av
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gr5bJ-0004Df-Gj
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:37:42 -0500
MIME-Version: 1.0
References: <154905879413.25667.2843143192142684785.malonedeb@chaenomeles.canonical.com>
	<a667006b-44e2-f72d-8164-c52a9374cb84@redhat.com>
In-Reply-To: <a667006b-44e2-f72d-8164-c52a9374cb84@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 5 Feb 2019 10:36:46 -0800
Message-ID: <CAKmqyKMBF23CJTNtdqiQ7gO7kA5ZSAu3aXr1uoF+=rE_RKwgFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1814343] [NEW] Initrd not loaded on riscv32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Bug 1814343 <1814343@bugs.launchpad.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>, Alistair Francis <alistair@alistair23.me>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>

On Fri, Feb 1, 2019 at 3:26 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Hi Jonathan,
>
> On 2/1/19 11:06 PM, Jonathan Behrens wrote:
> > Public bug reported:
> >
> > I attempted to run qemu with a ram disk. However, when reading the
> > contents of the disk from within the VM I only get back zeros.
> >
> > I was able to trace the issue to a mismatch of expectations on line 93
> > of hw/riscv/virt.c. Specifically, when running in 32-bit mode the value
> > of kernel_entry is sign extended to 64-bits, but load_image_targphys
> > expects the start address to not be sign extended.
> >
> > Straw man patch (works for 32-bit but would probably break 64-bit VMs?)=
:
> >
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index e7f0716fb6..32216f993c 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -90,7 +90,7 @@ static hwaddr load_initrd(const char *filename, uint6=
4_t mem_size,
> >       * halfway into RAM, and for boards with 256MB of RAM or more we p=
ut
> >       * the initrd at 128MB.
> >       */
> > -    *start =3D kernel_entry + MIN(mem_size / 2, 128 * MiB);
> > +    *start =3D (kernel_entry & 0xffffffff) + MIN(mem_size / 2, 128 * M=
iB);
> >
> >      size =3D load_ramdisk(filename, *start, mem_size - *start);
> >      if (size =3D=3D -1) {
> >
> >
> > Run command:
> >
> > $ qemu/build/riscv32-softmmu/qemu-system-riscv32 -machine virt -kernel
> > mykernel.elf -nographic -initrd payload
> >
> > Commit hash:
> >
> > 3a183e330dbd7dbcac3841737ac874979552cca2
> >
> > ** Affects: qemu
> >      Importance: Undecided
> >          Status: New
>
> I believe this is fixed by the following patch:
> "Ensure the kernel start address is correctly cast"
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06358.html
>
> Can you test it?
> If if works you can reply to it with a
> "Tested-by: Jonathan Behrens <your-email>"
> to increases the odds it get merged ;)

Did you get a chance to test this Jonathan?

Alistair

>
> Thanks,
>
> Phil.
>
